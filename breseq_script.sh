#!/bin/bash 

echo "Load modules!"
module add biotools/bowtie2-2.2.5 biotools/breseq-0.31.0 devel/R-3.2.2  # on abacus
# module add biotools/bowtie2-2.4.1 biotools/breseq-0.35.1 devel/R-4.0.2  # on calculon

# echo "Start decompressing!"
# tar -xvf $(find ./ -type f -name '*.tar')     # this can unpack the .tar archive
# mv $(find ./ -type f -name '*.fq.gz') ./      # can move all .fq.gz files up to the current directory
# echo "Decompressing is done!"                 # you will see this prompt when done

# DEFINE YOUR LIST OF SAMPLES
declare -A ARRAY
ARRAY["Strain_1"]="D1_"
ARRAY["Strain_2"]="D2_"
ARRAY["Strain_3"]="D3_"
#...

echo "Starting Breseq Assembly! (see log files)"
# Modify the references (-r options) when necessary
for key in ${!ARRAY[@]}; do
	mkdir ${key}
	breseq -j 24 -o ${key} -n ${key} -r GENOME.gbk -r PLASMID.gbk $(find ./ -type f -name ${ARRAY[$key]}*1.fq.gz) $(find ./ -type f -name ${ARRAY[$key]}*2.fq.gz) &> ${key}/log.txt &
done

wait
echo "Finished assembly"

echo "Starting the comparison!"
mkdir comparison
for key in ${!ARRAY[@]}; do 
   cp ./${key}/output/output.gd ./comparison/${key}.gd
done 

cd comparison
gdtools COMPARE -o COMPARE.html -r GENOME.gbk -r PLASMID.gbk Strain_1.gd Strain_2.gd Strain_3.gd
echo "Comarison is done!"