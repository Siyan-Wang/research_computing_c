#number 9 question answer script
cut -f 3  Year_Mag_Country.tsv | grep -w $1 | wc -l
