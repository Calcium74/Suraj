########### Mutation #########

## File VCF Input 
open(FH,"mutect_immediate.vcf") or die $!;
open(FF,">accepted.xls");

## Get Chromosome Position
while(<FH>)
{
	if ($_=~/^chr.*\s+(\d+)\s+/)
	{
	push(@chr,$_);
	push(@pos,"$1\n");
	}
		if ($_=~/^#(CH.*)/){print FF "$1\n";}
}
close(FH);

## bed File Input

open(FW,"truseq.bed") or die $!;
#print "Start\tEnd\n";
# Get Start & End points
while(<FW>)
{
	if($_=~/^chr.*\s+(\d+)\s+(\d+)/)
	{
	#print "$1\t$2\n";
	push(@start,"$1\n");
	push(@end,"$2\n");
	}
}
close(FW);

#print FF"Start\tPosition\tEnd\n";

# Loop For Finding Mutation: if that position occurs in between start and end points 

for($i=0;$i<=scalar(@pos);$i++)
{
	for($j=0;$j<=scalar(@start);$j++)
	{
		if($start[$i] <= $pos[$j] && $end[$i] >= $pos[$j] )
		{
		push(@p,$pos[$j]);
		}
	}
}

## Loop for Printing Output In accepted.xls file 
for($a=0;$a<=@pos;$a++)
{
	for($b=0;$b<=@start;$b++)
	{	
		if($chr[$a]=~/^(chr.*\s+)(\d+)(\s+.*)/)
		{
			if($2==$p[$b])
			{
			print FF"$1$2$3\n";
			}
		}
	break;
	}
}