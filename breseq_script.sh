#!/bin/bash 

echo "Load modules!"
module add biotools/bowtie2-2.2.5 biotools/breseq-0.31.0 devel/R-3.2.2  # on abacus
# module add biotools/bowtie2-2.4.1 biotools/breseq-0.35.1 devel/R-4.0.2  # on calculon

# echo "Start decompressing!"
# tar -xvf $(find ./ -type f -name '*.tar')     # this can unpack the .tar archive
# mv $(find ./ -type f -name '*.fq.gz') ./      # can move all .fq.gz files up to the current directory
# echo "Decompressing is done!"                 # you will see this prompt when done

# DEFINE YOUR LIST OF SAMPLES
declare -a Samples; declare -a Labels
Samples+=("Strain_1"); Labels+=("D1_")
Samples+=("Strain_2"); Labels+=("D2_")
Samples+=("Strain_3"); Labels+=("D3_")
#...

echo "Starting Breseq Assembly! (see log files)"
# Modify the references (-r options) when necessary
for i in ${!Samples[@]}; do
	mkdir -p ${Samples[$i]}
	breseq -j 4 -o ${Samples[$i]} -n ${Samples[$i]} -r GENOME.gbk -r PLASMID.gbk $(find ./ -type f -name ${Labels[$i]}*1.fq.gz) $(find ./ -type f -name ${Labels[$i]}*2.fq.gz) &> ${Samples[$i]}/log.txt &
done

wait
echo "Finished assembly"

echo "Starting the comparison!"
mkdir -p comparison
declare -a output=()
for key in ${!Samples[@]}; do 
   cp cp ./${Samples[$i]}/output/output.gd ./comparison/${Samples[$i]}.gd
   output+=("${Samples[$i]}.gd")
done 

cd comparison
gdtools COMPARE -o COMPARE.html -r GENOME.gbk -r PLASMID.gbk ${output[@]}   # all samples
# gdtools COMPARE -o COMPARE.html -r GENOME.gbk -r PLASMID.gbk ${output[@]:0:3}    # samples 0, 1, 2
echo "Comarison is done!"

exit 0