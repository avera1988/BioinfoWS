# Instructions to create FastQC reports using multiple fastq files

1. Download the Data folder [Data](https://osu.box.com/s/fwt94wix99q9fv3t78ni6ch0ph5hiy9r)

-This is a small data set from [paper](https://aem.asm.org/content/86/8/e00091-20)

2. Open a terminal
3. Create a folder named FastQC
4. Move the Data folder into FastQC directory
5. Decompress the tar ball file with tar command

```console
[avera]$ mkdir FastQC
[avera]$ ls -lrth
total 4.0K
drwxr-xr-x 2 avera avera 4.0K May 16 11:51 FastQC
[avera@]$ cd FastQC/
[avera@]$ mv ../Raw_reads.tar.gz  .
[avera@]$ tar -xzvf Raw_reads.tar.gz 
Raw_reads/
Raw_reads/Illumina/
Raw_reads/Illumina/214_R1.fastq
Raw_reads/Illumina/214_R2.fastq
Raw_reads/Illumina/224_R1.fastq
Raw_reads/Illumina/224_R2.fastq
Raw_reads/Illumina/519_R1.fastq
Raw_reads/Illumina/519_R2.fastq
Raw_reads/Illumina/51_R1.fastq
Raw_reads/Illumina/51_R2.fastq

```
### Now we can use FastQC by calling it with:
```console
[avera]$ fastqc
```
![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/fastqcconsole.png)

**Graphic version is fine for one file, but what happens when we have to deal with multiple files, well you can use the command line**
```console
[avera]$ fastqc -h

            FastQC - A high throughput sequence QC analysis tool

SYNOPSIS

	fastqc seqfile1 seqfile2 .. seqfileN

    fastqc [-o output dir] [--(no)extract] [-f fastq|bam|sam] 
           [-c contaminant file] seqfile1 .. seqfileN
```

**Enter to ~FastQC/Raw_reads/Illumina/**

```console
$ ls
214_R1.fastq  214_R2.fastq  224_R1.fastq  224_R2.fastq  519_R1.fastq  519_R2.fastq  51_R1.fastq  51_R2.fastq
```

Let's run fastQC for these two files
 ```console
[avera]$ fastqc -t 4 -f fastq 51_R1.fastq 51_R2.fastq
 ```
 Check the results 	
 ```Console
 [avera]$ ls

 ```
 You can open the fastQC report using a web browser, in my case firefox
 ```console
[avera]$ firefox 51*html
 ```
 
 ## What happen if I am using UNITY??? ##
 
 **For using UNITY you first need to conect, if you are off campus (and also in campus using the Wi-Fi) you can conect via 
 [VPN](https://osuasc.teamdynamix.com/TDClient/1929/Portal/KB/ArticleDet?ID=14542)
 or you can use the [JUMPserver](https://osuasc.teamdynamix.com/TDClient/1929/Portal/KB/ArticleDet?ID=29849)**
 
 ```console
 (base) avera@mark3:~$ ssh veraponcedeleon.1@jump.asc.ohio-state.edu

################################################################################
#                                                                              #
#  This information system, including all related equipment, networks and      #
#  network devices, are provided solely for authorized Ohio State University   #
#  use. Use of this system constitutes consent to abide by The Ohio State      #
#  University Policy on "Responsible Use of University Computing and Network   #
#  Resources", https://go.osu.edu/responsible-use. The Ohio State University   #
#  may monitor use of this information system without notice. Unauthorized     #
#  disclosure of information, or evidence of unauthorized use may be subject   #
#  to administrative action, civil action, and/or criminal prosecution.        #
#                                                                              #
################################################################################


Password: 
Duo two-factor login for veraponcedeleon.1

Enter a passcode or select one of the following options:

 1. Duo Push to XXX-XXX-7968
 2. Phone call to XXX-XXX-7968
 3. SMS passcodes to XXX-XXX-7968

Passcode or option (1-3): 1 
 
  ```
  
  Then you need to "jump" to UNITY from this:
  
 ```
 [veraponcedeleon.1@jump ~]$ ssh unity.asc.ohio-state.edu
Last login: Wed Apr  8 19:15:51 2020 from jump.asc.ohio-state.edu

-----------------------------------------
Welcome to Unity.

Unity is a college-wide resource managed by ASCTech

Information on how to use the Unity Cluster:
http://go.osu.edu/unitycompute

For assistance please email asctech@osu.edu
or submit request to: http://go.osu.edu/unitysupportticket
-----------------------------------------


(base) [veraponcedeleon.1@unity-1 ~]$
 
 ```
 
 you do not need to download the data only cp from:
 
 ```console
 
 $ /fs/project/obcp/veraponcedelon.1/BioinfoWS
 
 ```
 
 **First lets check the important documentation**
 [UNITY](https://osuasc.teamdynamix.com/TDClient/1929/Portal/KB/?CategoryID=12831)
 
**As UNITY is a cluster you can not work in the main node so for this class lets create a quick interactive job**

```console
[veraponcedeleon.1@unity-1 Illumina]$ qsub -I -l nodes=1:ppn=4 -l mem=8GB -l walltime=2:00:00
qsub: waiting for job 1940648.unity-1.asc.ohio-state.edu to start
qsub: job 1940648.unity-1.asc.ohio-state.edu ready
 ```
 Then even thought UNITY has a [InfiniBand]() for sharing information, jobs are more eficient if are running in the same node (computer)
 we are working on. We need to create a directory in this computer and then transfer the files into this.
 
 ```console
 [veraponcedeleon.1@u084 ~]$ cp -r /fs/project/obcp/veraponcedelon.1/BioinfoWS/*.tar.gz $TMPDIR
 ```
 
 Then enter to the Directory, decompress the file and create a FastQC dir
 
 ```console
(base) [veraponcedeleon.1@u084 1940648.unity-1.asc.ohio-state.edu]$ mkdir Fastqc
(base) [veraponcedeleon.1@u084 1940648.unity-1.asc.ohio-state.edu]$ cd Fastqc/
(base) [veraponcedeleon.1@u084 Fastqc]$ mv ../Raw_reads.tar.gz .
(base) [veraponcedeleon.1@u084 Fastqc]$ tar -xzvf Raw_reads.tar.gz
 ```
 
 Then I need to call a FASTQC module
 
 ```console
 base) [veraponcedeleon.1@unity-1 BioinfoWS]$ module available

------------------------------------------------------------------------------ /usr/local/share/lmodfiles/Core -------------------------------------------------------------------------------
   CAFE/4.2                          blast/2.4.0+            (D)    gemma/0.96                  lfmm/1.5                   pandaseq/2.11                 singularity/3.2.1 (D)
   DupliPHY/1.0                      blast/2.8.1+                   genemark/4.38               ls-dyna/971_d_9.0.1        paraview/4.4.0                snpeff/4.2
   FLASH/1.2.11                      bowtie1/1.1.2                  genomethreader/1.7.1        ls-dyna/971_s_9.0.1 (D)    paup/4a165                    spark/2.0.0
   FLASH-modified/1.2.4              bowtie2/2.2.9                  geos/3.7.1                  mafft/7.407                paup/4a166             (D)    sratoolkit/2.6.3  (D)
   FreeFem++/3.59                    bpp/3.4                        git/2.12.2                  maker/2.31.10              pcadmix/1.0                   sratoolkit/2.10.4
   GPSTk/2.12-ISO-8859-1      (D)    busco/3.1.0                    git/2.20.0           (D)    maple/default              pcp/pcp                       stacks/1.44


(base) [veraponcedeleon.1@unity-1 BioinfoWS]$ module load fastqc/0.11.7

(base) [veraponcedeleon.1@unity-1 BioinfoWS]$ fastqc -h

FastQC - A high throughput sequence QC analysis tool

SYNOPSIS

	fastqc seqfile1 seqfile2 .. seqfileN

    fastqc [-o output dir] [--(no)extract] [-f fastq|bam|sam] 
           [-c contaminant file] seqfile1 .. seqfileN

DESCRIPTION

    FastQC reads a set of sequence files and produces from each one a quality
    control report consisting of a number of different modules, each one of 
    which will help to identify a different potential type of problem in your
    data. 

 ```
 
 Now I can Run FastQC
