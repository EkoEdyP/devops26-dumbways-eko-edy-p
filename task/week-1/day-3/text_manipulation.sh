#!/bin/bash

FILE="sample.txt"

echo "=== TEXT MANIPULATION ==="

# echo
echo "Hello DevOps Day 3" > $FILE
echo "Belajar Bash Script" >> $FILE
echo "Belajar UFW Firewall" >> $FILE

# cat
echo "- Isi file:"
cat $FILE

# grep
echo "- Cari kata 'Belajar':"
grep "Belajar" $FILE

# sed
echo "- Ganti 'Belajar' menjadi 'Practice':"
sed -i 's/Belajar/Practice/g' $FILE

echo "- Hasil akhir:"
cat $FILE
