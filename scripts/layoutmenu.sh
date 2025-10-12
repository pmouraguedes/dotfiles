#!/bin/sh

cat <<EOF | xmenu
[M] Monocle Layout	0
HHH Grid Layout	1
[]= Tiled Layout	2
><> Floating Layout	3
|M| Centeredmaster Layout	4
>M> Centeredfloatingmaster Layout	5
[D] Deck Layout	6
TTT bstack Layout	7
=== bstackhoriz Layout	8
EOF
