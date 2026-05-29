#!/usr/bin/env python3

import subprocess

def get_current():
    proc = subprocess.run(["brightnessctl", "-c", "backlight", "get"], capture_output=True, check=True)
    return int(proc.stdout)


def get_max():
    proc = subprocess.run(["brightnessctl", "-c", "backlight", "max"], capture_output=True, check=True)
    return int(proc.stdout)

current_level = get_current()
max_level = get_max()


if current_level <= max_level * 0.35:
    subprocess.run(["brightnessctl", "-c", "backlight", "set", "60%"])
elif current_level <= max_level * 0.65:
    subprocess.run(["brightnessctl", "-c", "backlight", "set", "100%"])
else:
    subprocess.run(["brightnessctl", "-c", "backlight", "set", "30%"])
