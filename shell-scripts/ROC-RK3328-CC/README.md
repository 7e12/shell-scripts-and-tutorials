# ROC-RK3328-CC

Shell script to calculate ROC-RK3328-CC GPIO pin number for interacting via the Linux `sysfs` file system at `/sys/class/gpio/gpio[pin_number]`

## Execute

```$bash
$ sh PinNumCalc.sh [bank_number] [pad_name] [pad_number]
e.g.
    input:      sh PinNumCalc.sh 2 A 6
    output:     GPIO2-A6 pin number = 70
```
