#!/bin/bash

cpdf -split in.pdf -o page%%%.pdf
cp blank.pdf blank_tmp.pdf

PAGE_COUNT=$(ls page*.pdf | wc -l)

pages=""

for i in `seq 1 $(( $PAGE_COUNT + (4 - $PAGE_COUNT%4) ))`; do
    page_num=$((i-1))
    if [ $(( i%4 )) -eq 1 ]; then
        page_num=$((i+3))
    fi
    if [ $page_num -le $PAGE_COUNT ]; then
        page_num=$(printf "%03d\n" $page_num)
        pages+="page${page_num}.pdf "
    else
        pages+="blank_tmp.pdf "
    fi
done

cpdf -merge $pages -o out.pdf
rm -rf $pages
cpdf -squeeze out.pdf -o out.pdf
