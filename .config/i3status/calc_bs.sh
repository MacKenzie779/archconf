#!/bin/bash

#read actual bl value
actual_bs="$(cat /sys/class/backlight/amdgpu_bl1/brightness)"

#read max bl value
max_bs="$(cat /sys/class/backlight/amdgpu_bl1/max_brightness)"

#compute division with floating numbers
result=$(echo "scale=2; $actual_bs / $max_bs" | bc)

#multiply by 100
result=$(echo "scale=0; $result * 100" | bc)

#cast back to int
result=$(echo "${result%%.*}")

#write res in file
echo $result > ./brightness

