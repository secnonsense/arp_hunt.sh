#!/bin/bash
sudo arp -a -d
echo -en '\n'
nmap -sn 192.168.0.1-254
echo -en '\n'
arp -a | grep -v incomplete | cut -d " " -f 4 > macs.txt
echo -en '\n'
if ! test -f "hold.txt"
then
echo "hold.txt doesn't exist. Generating file..."
cp macs.txt hold.txt
exit
fi
for LINE in $(cat hold.txt)
do
y="$(grep -i $LINE macs.txt)"
if [[ -n "$y" ]]
then
echo "Match!! "$LINE" -- "$y
else
echo "No match for "$LINE
fi
done
cp macs.txt hold.txt
echo -en '\n'
