#!/usr/bin/perl -w
###############################################################################################
#This script converts multifasta to one line header and one line sequence multifasta
#Author: Alejandro Sanchez-Flores
###############################################################################################

use strict;
@ARGV == 1 or die "Usage: perl $0 fasta_file > fasta_file.one.fasta\n";
my($fasta)=@ARGV;
open(FASTA,$fasta);

my $flag = 0;


while (<FASTA>) {
	#print; <STDIN>;
	chomp;
	if (/^>/) {
		
		if ($flag) {
			print "\n";
			$flag = 0;
		}
		my $id = $_; 
		print "$id\n";
		$flag = 1;
		next;
	}
	tr/a-z/A-Z/;
	print;
}
