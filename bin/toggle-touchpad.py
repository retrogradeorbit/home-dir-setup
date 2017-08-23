#!/usr/bin/env python
from subprocess import check_output
import re

touchpad_device = "DELL0740:00 06CB:7E7E Touchpad"

command = {
    False: "disable",
    True: "enable"
    }

def xinput(command):
    return check_output(["xinput", command, touchpad_device])

def get_touchpad_state():
    return [
        line for line in xinput("list-props").splitlines()
        if "Device Enabled (137)" in line
        ][0].split()[-1]=="1"
    
def set_touchpad_state(state):
    xinput(command[state])

def toggle_touchpad_state():
    set_touchpad_state(not get_touchpad_state())

def main():
    toggle_touchpad_state()

if __name__ == "__main__":
    main()
