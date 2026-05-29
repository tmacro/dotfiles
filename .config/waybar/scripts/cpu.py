#!/usr/bin/env python3

import json
import random
import time
import pathlib

random.seed(time.time())

GREEN = '#69ff94'
BLUE = '#2aa9ff'
YELLOW = '#ffffa5'
ORANGE = '#ff9977'
RED = '#dd532e'

# DATA_PATH = pathlib.Path('~/.config/waybar/scripts/.cpu.state').resolve().as_posix()
DATA_PATH = pathlib.Path('/tmp/cpu.state').resolve().as_posix()
MAX_DATA_DELAY = 10

levels = (
    (('⣀'), GREEN),
    (('⣄','⣠'), GREEN),
    (('⣤'), BLUE),
    (('⣦','⣴'), BLUE),
    (('⣶'), YELLOW),
    (('⣷','⣾'), ORANGE),
    (('⣿'), RED)
)

level_cutoffs = [100 * (1 / len(levels)) * i for i in range(len(levels))]

def get_level(i):
    chars, color = levels[i]
    char = chars[0]
    if len(chars) > 1:
        char = random.choice(chars)
    return f"<span color='{color}'>{char}</span>"

def get_level_char(i):
    level_char = None
    for level, cutoff in enumerate(level_cutoffs):
        if i < cutoff:
            level_char = get_level(max(0, level - 1))
            break

    if level_char == None:
        level_char = get_level(len(levels) - 1)
    return level_char

# user: normal processes executing in user mode
# nice: niced processes executing in user mode
# system: processes executing in kernel mode
# idle: twiddling thumbs
# iowait: waiting for I/O to complete
# irq: servicing interrupts
# softirq: servicing softirqs

# cpu0 18349 14 8554 1521660 1157 2560 4340 0 0 0
def get_cpu_usage():
    usage = {}
    with open('/proc/stat') as f:
        current_cpu = -1
        for line in f:
            if line.startswith('cpu'):
                # print(line)
                times = [int(p) for p in line.split(' ')[1:] if p]
                wait = times[3] + times[4]
                total = sum(times)
                if current_cpu == -1:
                    usage['total'] = (wait, total)
                elif current_cpu >= 0:
                    usage[f'core{current_cpu}'] = (wait, total)
                current_cpu += 1
    return usage

def load_state(path):
    if not pathlib.Path(path).exists():
        return None

    with open(path) as f:
        data = json.load(f)

    if 'ts' not in data:
        return None

    if time.time() - data['ts'] > MAX_DATA_DELAY:
        return None

    return data['usage']

def save_state(path, usage):
    with open(path, 'w') as f:
        json.dump({
            'ts': time.time(),
            'usage': usage,
        }, f)


# "<span color='#69ff94'>⣀</span>", // green
# "<span color='#69ff94'>⣄</span>", // green ⣠
# "<span color='#2aa9ff'>⣤</span>", // blue
# "<span color='#2aa9ff'>⣴</span>", // blue ⣦
# "<span color='#ffffa5'>⣶</span>", // yellow
# "<span color='#ff9977'>⣷</span>", // yellow ⣾
# "<span color='#dd532e'>⣿</span>" // red

def endless_range():
    i = 0
    while True:
        yield i
        i += 1

def main():
    prev_usage = load_state(DATA_PATH)
    if prev_usage is None:
        prev_usage = get_cpu_usage()
        time.sleep(0.1)

    cur_usage = get_cpu_usage()

    text = ''
    tooltip = ''

    if 'total' in prev_usage and 'total' in cur_usage:
        prev_idle, prev_total = prev_usage['total']
        cur_idle, cur_total = cur_usage['total']
        delta_idle = cur_idle - prev_idle
        delta_total = cur_total - prev_total
        usage_per = 0
        if delta_total > 0:
            usage_per = 100 * (1 - delta_idle / delta_total)
        tooltip += f'Total:\t{round(usage_per)}%'

    for cpu_num in endless_range():
        if f'core{cpu_num}' not in prev_usage:
            break
        if f'core{cpu_num}' not in cur_usage:
            break
        prev_idle, prev_total = prev_usage[f'core{cpu_num}']
        cur_idle, cur_total = cur_usage[f'core{cpu_num}']
        delta_idle = cur_idle - prev_idle
        delta_total = cur_total - prev_total
        usage_per = 0
        if delta_total > 0:
            usage_per = 100 * (1 - delta_idle / delta_total)
        tooltip += f'\nCore{cpu_num}:\t{round(usage_per)}%'
        # print(cpu_num, delta_idle, delta_total, usage_per)
        # print(cpu_num, usage_per)
        level_char = get_level_char(usage_per)
        # for level, cutoff in enumerate(level_cutoffs):
        #     # print(cpu_num, level, usage_per, cutoff)
        #     if usage_per < cutoff:
        #         # print(cpu_num, level, get_level(max(0, level - 1)))
        #         level_char = get_level(max(0, level - 1))
        #         break

        # if level_char == None:
        #     level_char = get_level(len(levels) - 1)
        # print(level_char, end='')
        text += level_char
    # print()

    save_state(DATA_PATH, cur_usage)

    print(json.dumps({
        'text': text,
        'tooltip': tooltip,
    }))
    # for cpu_num, (idle, total) in enumerate(cpu_usage):
    #     # busy = 1 - (idle / total)
    #     idle_perc = idle/total
    #     busy_perc = 1 - idle_perc
    #     cpu_level = 0
    #     for i in range(len(levels)):
    #         limit = 1 / len(levels) * i
    #         print(idle_perc, busy_perc, limit)
    #         if busy_perc < limit:
    #             break
    #         cpu_level += 1
    #     lvlCh = get_level(cpu_level - 1)
    #     print(cpu_num, lvlCh)

if __name__ == '__main__':
    main()
