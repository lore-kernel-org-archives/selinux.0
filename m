Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA29949
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 09:00:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA20938
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 13:59:48 GMT
Received: from jsmith.org (pool-141-158-43-243.phil.east.verizon.net [141.158.43.243])
	by jazzband.ncsc.mil  with ESMTP id NAA20934
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 13:59:47 GMT
Subject: simple Perl script to converse messages to access rules
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 04 Dec 2001 08:57:47 -0500
Message-Id: <1007474267.2028.0.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This will convert a sequence of access denied messages into
allow-commands.


One problem: even in permissive move, SELinux doesn't generate all
possible denied messages. After one enables access and reruns an
offending program, one gets more denied messages. It's as if the program
didn't completely run the previous time (although it should, in
permissive mode). 

Here's the perl script:
#------------------------------------cut here---------------------
#!/usr/bin/perl
open ERRFILE, "< messages";
open NEWRULES, "> newrules";

my %rules = ();

#
# format: $rules{ "$scontext|$tcontext|$tclass"}
#          = { '$accesstype1' => 1,'$accesstype2' => 1}, etc.,; 
#

while ($inline = <ERRFILE>)
  {
    next unless ($inline =~ /avc:\s*denied\s*\{\s*(\w+)\s*\}/);
    my $accesstype = $1;
    my $nextline = <ERRFILE>;
    $nextline =~ /:(\w+)\s*\Z/;
    my $scontext = $1;
    $nextline = <ERRFILE>;
    $nextline =~ /:(\w+)\s*\Z/;
    my $tcontext = $1;
    $nextline = <ERRFILE>;
    $nextline =~ /=(\w+)\s*\Z/;
    my $tclass = $1;
    $rules{"$scontext|$tcontext|$tclass" }{$accesstype}=1;
  }

# done  with the input file
# now generate the rules

foreach $k (sort keys %rules)
  {
    my ($scontext,$tcontext,$tclass) = split /\|/, $k;
    print NEWRULES "allow $scontext $tcontext:$tclass { ";
    my $access_types = $rules{$k};
    foreach $t (sort keys %$access_types)
      {
	print NEWRULES "$t ";
      }
    print NEWRULES "};\n";
  }


#-----------------end------------------------------------
-- 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
