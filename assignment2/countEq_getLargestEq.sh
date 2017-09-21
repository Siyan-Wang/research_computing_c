#script for question 10
echo country: $1
echo total number of earthquakes:
cut -f 3  Year_Mag_Country.tsv | grep -w $1 | wc -l
echo largest earthquakes information:
grep -w $1 Year_Mag_Country.tsv | sort -k 2| tail -n 1
