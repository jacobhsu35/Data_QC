#!/bin/bash
#PBS -q nhri192G
#PBS -P MST108173
#PBS -W group_list=MST108173
#PBS -l select=1:ncpus=40
#PBS -l walltime=18:00:00
#PBS -M jacobhsu@ntu.edu.tw
#PBS -m be
#PBS -j oe

cd /project/GP1/u3710062/AI_SHARE/GATK/Outputs/20200528_GIAB

fastq1=/work2/u00srx00/DRAGEN/Pipeline_compare/INPUT/NA24695_HG007.R1.fastq  #input 1
fastq2=/work2/u00srx00/DRAGEN/Pipeline_compare/INPUT/NA24695_HG007.R2.fastq  #input 2
readlength1=$(awk 'NR % 4 == 2 { s += length($1); t++} END {print s/t}' $fastq1) #calculate read length for fastq file 1
readlength2=$(awk 'NR % 4 == 2 { s += length($1); t++} END {print s/t}' $fastq2) #calculate read length for fastq file 2
totalreadlength=$(echo "$readlength1+$readlength2"|bc) #calculate total read length
averagereadlength=$(echo "$totalreadlength/2"|bc) #calculate average read length by parsing into bc command - which truncates the decimal numbers by default in multiplication/division

readcount1=$(cat $fastq1| echo $((`wc -l`/4))) #read count in file 1
readcount2=$(cat $fastq2| echo $((`wc -l`/4))) #read count in file 2
totalreadcount=$(echo "$readcount1+$readcount2"|bc) #total read count of file 1 and file 2
averagereadcount=$(echo "$totalreadcount/2"|bc) #average read count - parsed into bc command to be rounded

echo -n -e "$fastq1\tread_length:${averagereadlength}\treads:${averagereadcount}" >> NA24695_HG007.txt
#echo -e "reads" >> NA24695_HG007.txt
#echo -e -n "$fastq1\t" >> NA24695_HG007.txt
#echo -e -n "$averagereadlength\t" >> NA24695_HG007.txt
#echo "$averagereadcount" >> NA24695_HG007.txt

exit 0;
