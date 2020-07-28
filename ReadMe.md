## The script is for NGS analysis using breseq on **abacus** and **calculon**, the Linux servers at MPI-MP.  

The script exemplifies the use of **breseq** for NGS raw data from resequencing micrbial genomes (haploid, <10 Mb). The program is installed on both MPI-MP linux servers, **abacus** and **calculon**.  When using it, you need:  

1. Comment either line 4 or line 5 according to the server you are using;  
2. Define your list of samples in line 14 to 16, add more if needed;  
    Fill in separately for each sample; in the brackets, choose a useful name for the sample (will be used in your output); behind the equality-sign, provide the file name (first letters until underscore are enough if unique).
3. Give the reference genome (and plasmid) file location in line 23;
4. Modify line 36 your references and sample names;
5. [Optional] If you edited the script on Windows, it might be necessary to do:
    ```bash
    dos2unix breseq_script.sh
    ```
6. Run the script: 
    ```bash
    bash breseq_script.sh
    ```

Please refer to the [breseq Manual](https://barricklab.org/twiki/pub/Lab/ToolsBacterialGenomeResequencing/documentation/index.html) for the details of program installation, usage and result interpretation. This [tutorial](https://wikis.utexas.edu/display/bioiteam/Lonestar5+Breseq+Tutorial) could be also helpful.    

You could use [IGV](http://www.broadinstitute.org/igv/) or [Tablet](http://bioinf.scri.ac.uk/tablet/) to check the assembly results within the genome.