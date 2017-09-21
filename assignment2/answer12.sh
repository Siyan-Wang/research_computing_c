for YEAR in $(cut -f 1  Year_Mag_Country.tsv | sort | uniq -c | sort -n | tail -n 10 | cut -c 6-)
do 
    grep -w $YEAR Year_Mag_Country.tsv > $YEAR-earthquakes.txt
done 
