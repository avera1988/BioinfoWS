#!/usr/bin/perl -w 
use strict;
use warnings;

###################################################################
#This program caculates the coverage from idba_ud assemblies
#Needs, contigs in one lane and it prints the coverage of each contig and the sequence
#Also it prints a coverage.txt file with the coverage for each contig
#Author: Arturo Vera
#v.1
#06/13/17
#v.2
#May_2019
##########################################################################################


@ARGV == 1 or die "Usage: perl $0 fasta_file\n";
my(@header, @id,$lon, $count, $rounded, $cover, $seq,@coverage);
(my $contigs)=@ARGV;
open (ARCH, $contigs);
open(FASTA,">$contigs.mod.fasta");
open (COVERAGE, ">$contigs.coverage.txt");
while(<ARCH>){
	chomp; 
	if($_ =~ /^>/){
	 @header=split(/\s+/);
		foreach($header[0]){
			@id=split(/\>/);
		} 
		foreach($header[1]){
		(undef,$lon)=split(/\_/);
		#print "$lon\n";
	}
		foreach($header[2]){
		(undef,undef,$count)=split(/\_/);
	#print "$count\n";
	} 
	$cover=(100*$count/$lon); 
	$rounded = sprintf("%.3f", $cover);
	#print "$header[0]_$cover\n";
	push(@coverage,$rounded);
	#print COVER "@coverage\n";
  	  }else{
		$seq=$_;
		print COVERAGE "$id[1]\t$lon\t$rounded\n";
   		print FASTA "$header[0]_$rounded\n$seq\n";
      }
}

my $coverage;
my $acc = 0;
foreach (@coverage){
  $acc += $_;
}
my $len=@coverage;
my $cover_mean =$acc/$len;
my $cover_mean_round =sprintf("%.3f", $cover_mean);
print "$contigs coverage=\t$cover_mean_round\n";

