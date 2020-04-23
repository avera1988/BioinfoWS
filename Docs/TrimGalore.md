## Quality filter with trim galore

### Create a TrimGalore directory, copy there the illumina files

```console
avera@mark3$ mkdir TrimGalore
ln -s ../51_*fastq .
```

**Let's take a look into the fastq files**
```console
head -4 51_R1.fastq
avera@mark3:TrimGalore$ @SN1052:253:C5NPEACXX:8:1101:5987:1956 1:N:0:79
NAGTAATAACAGTGCGGGATGACATAATGAACTACCTTATTGACCAGGGACTTGAAAAAGGAACAGCATTTAAAATAATGGAGTTTGTAAGAAAAGGTAA
+
#1=BDDDFHGGHFHIJJJJJJJJJIJJIIJJIIJIJIJIJJIIIJIIIIIJJJIJJIJIJHHHHFFFEFEDEEDC>CCDDACDACCD?ADCCCCCDD>>C
vera@mark3:TrimGalore$ head -4 51_R2.fastq
@SN1052:253:C5NPEACXX:8:1101:5987:1956 2:N:0:79
CTCTGGCATACATTTCCACTATAATTTCACATATTGCCATTTCAGCTTTTTTCTTTACATCAAGTTTTGGTTCTTTGCTCAATACTGCCAGATGTTCTTT
+
CCCFFFFFHHHGHJJJJIIJJIJIJFJJJJJJJJJJJJJJIDFIIJJJJJGHIIJJGGIHIIJJGIEIEIDHIJIJHHHHGHFFFFFFEECEEEDDEDCD
```

**Now we can run TrimGalore command**

avera@mark3:TrimGalore$ trim_galore --paired -j 4 -q 30 --fastqc 51_R1.fastq 51_R2.fastq

**And compare the sequences from the original files with these trimmed ones**

## If Run in Unity 

**Create an interactive Job

```console
qsub -I -l nodes=1:ppn=10 -l mem=20GB -l walltime=36:00:00
```
***Notice how the prompt name change indicating the node we are working on***
**Create a $TMPDIR and cp the files to work in the same node

```console
(base) [veraponcedeleon.1@u078 ~]$ mkdir $TMPDIR
(base) [veraponcedeleon.1@u078 ~]$ cd $TMPDIR
(base) [veraponcedeleon.1@u078 1974644.unity-1.asc.ohio-state.edu]$ cp /fs/project/obcp/veraponcedelon.1/BioinfoWS/042320/Raw_reads/Illumina/51_*fastq .
base) [veraponcedeleon.1@u078 1974644.unity-1.asc.ohio-state.edu]$ ls -l
total 1339980
-rw-r--r-- 1 veraponcedeleon.1 research-eeob-sabree 686064328 Apr 23 09:43 51_R1.fastq
-rw-r--r-- 1 veraponcedeleon.1 research-eeob-sabree 686064328 Apr 23 09:43 51_R2.fastq
```
Now you need to load the trimgalore module in Unity

```console
(base) [veraponcedeleon.1@u078 1974644.unity-1.asc.ohio-state.edu]$ module load TrimGalore/0.6.0 
(base) [veraponcedeleon.1@u078 1974644.unity-1.asc.ohio-state.edu]$ trim_galore --help

 USAGE:

trim_galore [options] <filename(s)>


-h/--help               Print this help message and exits.

```

As TrimGalore uses FastQC load FastQC module

```console
(base) [veraponcedeleon.1@u078 1974644.unity-1.asc.ohio-state.edu]$ module load fastqc/0.11.7
```

Then Run TrimGalore with multiple CPUs

```console
(base) [veraponcedeleon.1@u078 1974644.unity-1.asc.ohio-state.edu]$ nohup trim_galore --paired -j 10 -q 30 --fastqc 51_R1.fastq 51_R2.fastq &
```

When Finish you need to remove the original fastq files, compress everithing and move into your home or storage directory

```console
(base) [veraponcedeleon.1@u078 1974644.unity-1.asc.ohio-state.edu]$ rm 51_R1.fastq
(base) [veraponcedeleon.1@u078 1974644.unity-1.asc.ohio-state.edu]$ rm 51_R2.fastq
(base) [veraponcedeleon.1@u078 1974644.unity-1.asc.ohio-state.edu]$ mkdir TrimGalore51.di
(base) [veraponcedeleon.1@u078 1974644.unity-1.asc.ohio-state.edu]$ mv *.* TrimGalore51.di/
(base) [veraponcedeleon.1@u078 1974644.unity-1.asc.ohio-state.edu]$ mv TrimGalore51.di/ /fs/project/obcp/veraponcedelon.1/BioinfoWS/042320/Raw_reads/Illumina
```

**When finish exit your status***

```console
(base) [veraponcedeleon.1@u078 1974644.unity-1.asc.ohio-state.edu]$ exit
logout
qsub: job 1974644.unity-1.asc.ohio-state.edu completed
(base) [veraponcedeleon.1@unity-1 042320]$

qsub: job 1974644.unity-1.asc.ohio-state.edu completed
(base) [veraponcedeleon.1@unity-1 042320]$
```
***Again our promt return to the base Unity-1 name***
