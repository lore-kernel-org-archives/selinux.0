Message-ID: <72222DC86846D411ABD300A0C9EB08A10152436F@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: SELinux@tycho.nsa.gov
Subject: Policy Distribution Program.
Date: Fri, 26 Apr 2002 10:58:49 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C1ED3B.40E66960"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C1ED3B.40E66960
Content-Type: text/plain;
	charset="iso-8859-1"

This is my first cut of a program to help in the distribution
of policy files. The program is a perl script and 
take what I call a perl policy file. <file>.pp


Synopsis:

The purpose of this perlscript to take an input file 
and write to the specified policy files as specified 
by the perlpolicy file. The format of the Perl Policy 
file is as follows. Until a section command is found 
all output is sent the stdout. The section entries
must start at the beginning of a line.

Format of the section entries perl policy file:

%file: <filename>
	All lines following this section are sent to the 
	filename specified. If the file does not exist the 
	file will be created. If the file exists the file 
	will be overwritten.
%append: <filename>
	All lines following this section are appended the 
	filename specified. If the file does not exist the 
	file is created.
%insert: <filename> <pattern>
	All lines following are inserted into to file specified. 
	The file will be searched for the perl regular expression 
	specified by pattern. If the pattern is not found the 
	file will be appended with the information. When the first
	occurrence of the pattern is found then all line following 
	are inserted at that point. If the file does not exist then 
	file is created and the information is stored into the file.  


I think something like this needs to be done. 
Comment and suggestions are welcome. BTW I am not 
a perl programmer. 

Mark  


------_=_NextPart_000_01C1ED3B.40E66960
Content-Type: application/octet-stream;
	name="perlpolicy.pl"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="perlpolicy.pl"

#!/usr/bin/perl=0A=
#=0A=
# Author: Mark Westerman mark.westerman@westcam.com=0A=
#=0A=
#=0A=
# The purpose of this perlscript to take an input file =0A=
# and write to the specified policy files as specified =0A=
# by the perlpolicy file. The format of the Perl Policy =0A=
# file is as follows. Until a section command is found =0A=
# all output is sent the stdout.=0A=
#=0A=
# Format of the section entries perl policy file:=0A=
#=0A=
# %file: <filename>=0A=
#	All lines following this section are sent to the =0A=
#	filename specified. If the file does not exist the =0A=
#	file will be created. If the file exists the file =0A=
#	will be overwritten.=0A=
# %append: <filename>=0A=
#	All lines following this section are appended the =0A=
#	filename specified. If the file does not exist the =0A=
#	file is created.=0A=
# %insert: <filename> <pattern>=0A=
#	All lines following are inserted into to file specified. =0A=
#	The file will be searched for the perl regular expression =0A=
#	specified by pattern. If the pattern is not found the =0A=
#	file will be appended with the information. When the first=0A=
#	occurrence of the pattern is found then all line following =0A=
#	are inserted at that point. If the file does not exist then =0A=
#	file is created and the information is stored into the file.    =0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
open (OUTPUT,">&STDOUT");=0A=
=0A=
=0A=
$count =3D @ARGV;=0A=
if(@ARGV < 1)=0A=
{=0A=
	print_ussage();=0A=
	exit(0);=0A=
}=0A=
=0A=
open(INPUT,'<',$ARGV[0]) or die "Can't open ARGV[$1]";=0A=
=0A=
$section_fileopen=3D0;=0A=
$section_inserting=3D0;=0A=
=0A=
while(<INPUT>)=0A=
{=0A=
	$line =3D $_;=0A=
	@command =3D split;=0A=
	SWITCH: =0A=
	{=0A=
		if (/\%file:/){start_file($command[1]);last SWITCH;}=0A=
		if (/\%append:/){start_append($command[1]);last SWITCH;}=0A=
		if (/\%insert:/){start_insert($command[1],$_);=0A=
			last SWITCH;}=0A=
		print OUTPUT $line;=0A=
		$section_fileopen=3D1;=0A=
	}=0A=
=0A=
}=0A=
=0A=
if($section_inserting)=0A=
{=0A=
	print OUTPUT $tailinsert;=0A=
}=0A=
=0A=
close(output);=0A=
 =0A=
sub sstart_section()=0A=
{=0A=
	local @command;=0A=
=0A=
	@command =3D split;	=0A=
	$_ =3D $command[0];=0A=
	SWITCH: =0A=
	{=0A=
		if (/\%file:/){start_file($command[1]);last SWITCH;}=0A=
		if (/\%append:/){start_append($command[1]);last SWITCH;}=0A=
		if (/\%insert:/){start_insert($command[1],$command[2]);=0A=
			last SWITCH;}=0A=
	}=0A=
}=0A=
=0A=
sub start_file()=0A=
{=0A=
	my ($file) =3D @_;=0A=
	if($section_inserting)=0A=
	{=0A=
		print OUTPUT $tailinsert;=0A=
	}=0A=
=0A=
	if($section_fileopen)=0A=
	{=0A=
		close(OUTPUT);=0A=
	}=0A=
	open(OUTPUT,'>',$file) or die "Could not open $file for writing";=0A=
}=0A=
=0A=
sub start_append()=0A=
{=0A=
	my ($file) =3D @_;=0A=
	=0A=
	if($section_inserting)=0A=
	{=0A=
		print OUTPUT $tailinsert;=0A=
	}=0A=
=0A=
	if($section_fileopen)=0A=
	{=0A=
		close(OUTPUT);=0A=
	}=0A=
=0A=
	open(OUTPUT,'>>',$file) or die "Could not open $file for writing";=0A=
}=0A=
=0A=
=0A=
sub start_insert()=0A=
{=0A=
	my ($file, $inline)  =3D @_;=0A=
	local $head;=0A=
=0A=
	if($section_inserting)=0A=
	{=0A=
		print OUTPUT $inserttail;=0A=
	}=0A=
	if($section_fileopen)=0A=
	{=0A=
		close(OUTPUT);=0A=
	}=0A=
	$_ =3D $inline;=0A=
	s/\%insert:\s*\S*\s*//;=0A=
	$pattern =3D $_;=0A=
	chomp $pattern;=0A=
	open(OUTPUT, '+<', $file);=0A=
	$tailinsert =3D "";=0A=
	$section_inserting=3D0;=0A=
	while(<OUTPUT>)=0A=
	{=0A=
		if(/$pattern/)=0A=
		{=0A=
			$head =3D $head . $_;=0A=
			while(<OUTPUT>)=0A=
			{=0A=
				$tailinsert =3D $tailinsert . $_;=0A=
				$section_inserting =3D 1;=0A=
			}=0A=
		}=0A=
		$head =3D $head . $_;=0A=
	}=0A=
	close(OUTPUT);=0A=
	open(OUTPUT, '>', $file) or die "Could not open $file for insert";=0A=
	print OUTPUT $head;		=0A=
}=0A=
=0A=
sub print_ussage()=0A=
{=0A=
	print "perlpolicy policy.pp\n";=0A=
	print "Where policy.pp it the perlpolicy file to include\n";=0A=
}=0A=

------_=_NextPart_000_01C1ED3B.40E66960--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
