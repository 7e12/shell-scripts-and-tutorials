#!/bin/sh

# Get input arguments
bank_number=$1
pad_name=$2
pad_number=$3

# Only accept pad name A-B-C-D (or a-b-c-d)
pad_name_value=`printf '%d' "'$pad_name"`

if [ "$pad_name_value" -ge "97" ]
then pad_name_value=`expr $pad_name_value - 97`
else pad_name_value=`expr $pad_name_value - 65`
fi

if [ "$pad_name_value" -ge "4" ]
then
    echo "Pad name not found!"
    exit
fi

# Calculate pin number
pin_number=`expr $bank_number \* 32 + $pad_name_value \* 8 + $pad_number`
echo "GPIO$bank_number-$pad_name$pad_number pin number = $pin_number"
exit
