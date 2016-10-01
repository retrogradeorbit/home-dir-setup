#!/usr/bin/env python
from subprocess import check_output
import re

clockwise = {
    'left': 'normal',
    'normal': 'right',
    'right': 'inverted',
    'inverted': 'left'
    }

input_device_set = [
    "ELAN Touchscreen",
    "DELL0740:00 06CB:7E7E Touchpad"
    ]

transform_matrix = {
    'left': [0, -1,  1,
             1,  0,  0,
             0,  0,  1],
    'normal': [1, 0, 0,
               0, 1, 0,
               0, 0, 1],
    'right': [ 0, 1, 0,
              -1, 0, 1,
               0, 0, 1],
    'inverted': [-1, 0, 1,
                 0, -1, 1,
                 0, 0, 1]
    }

def xrandr(args=[]):
    return check_output(['xrandr'] + args)

def connected_line():
    return [
        line for line in xrandr().splitlines()
        if line.split()[1]=='connected'
    ][0]
    
def get_orientation_string(line):
    return re.search(r'\d+x\d+\+\d+\+\d+\s+(.*)\(', line).group(1)

def get_orientation(line):
    flags = get_orientation_string(line)
    if "left" in flags:
        return "left"
    elif "right" in flags:
        return "right"
    elif "inverted" in flags:
        return "inverted"
    else:
        return "normal"

def set_orientation(display, orientation):
    return check_output(['xrandr', '--output', display, '--rotate', orientation])

def get_display(line):
    return line.split()[0]

def set_input_transform(device, transform):
    return check_output(
        ['xinput', 'set-prop',
         device,
         'Coordinate Transformation Matrix']
        +
        [str(N) for N in transform]
    )

def set_input_orientation(device, orientation):
    return set_input_transform(device, transform_matrix[orientation])

def main():
    line = connected_line()
    display = get_display(line)
    orientation = get_orientation(line)
    new_orientation = clockwise[orientation]
    set_orientation(display, new_orientation)
    for device in input_device_set:
        set_input_orientation(device, new_orientation)
    
if __name__ == "__main__":
    main()
