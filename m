Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA05837
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2001 20:26:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA28234
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2001 01:25:32 GMT
Received: from jsmith.org (pool-141-158-40-48.phil.east.verizon.net [141.158.40.48])
	by jazzband.ncsc.mil  with ESMTP id BAA28230
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2001 01:25:22 GMT
Subject: Didn't notice this question
From: Justin Smith <jsmith@mcs.drexel.edu>
To: Stephen Smalley <sds@tislabs.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.33.0112041403260.28408-100000@raven>
References: <Pine.GSO.4.33.0112041403260.28408-100000@raven>
Content-Type: text/plain
Date: 11 Dec 2001 20:23:09 -0500
Message-Id: <1008120189.1675.0.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2001-12-04 at 14:43, Stephen Smalley wrote:
> newrules.te'.  Could you clarify under what terms you are releasing
> this script (e.g. GPL)?

> 
Of  course, I am GPL'ing this script. Here's a slightly revised form (it
runs dmesg itself):


#----------------------------cut-------------------
#!/usr/bin/perl
#
#    newrules.pl.
#
#    
#    Copyright (C) 2001  Justin R. Smith (jsmith@mcs.drexel.edu)
#
#    This program is free software; you can redistribute it and/or 
#    modify
#    it under the terms of the GNU General Public License as published
#    by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA     
#                                        02111-1307  USA
#

# Get the 'access denied' messages
@allmessages=split /\n/,`dmesg`;


my %rules = ();

# format: $rules{ "$scontext|$tcontext|$tclass"}
#          = { '$accesstype' => 1}; 

foreach $inline (@allmessages)
  {
    next unless ($inline =~ m/avc:\s*denied\s*\{((\w|\s)*)\}/);
    my $accesstype = $1;
    my $nextline = $';
    $nextline =~ m/scontext=\w+:\w+:(\w+)\s*/;
    my $scontext = $1;
    $nextline = $';
    $nextline =~ m/tcontext=\w+:\w+:(\w+)\s*/;
    my $tcontext = $1;
    $nextline = $';
    $nextline =~ m/tclass=(\w+)\s*\Z/;
    my $tclass = $1;
    my @atypes = split /\s+/,$accesstype;
    foreach $atype (@atypes)
      {
	next unless $atype =~ m/\S/;
	my $trim=undef;
	$atype =~ m/\s*(\w+)\s*/;
	$trim = $1;
	$rules{"$scontext|$tcontext|$tclass"}{$trim}=1;
      }
  }

# done  with the input file
# now generate the rules

foreach $k (sort keys %rules)
  {
    my ($scontext,$tcontext,$tclass) = split /\|/, $k;
    print  "allow $scontext $tcontext:$tclass { ";
    my $access_types = $rules{$k};
    foreach $t (sort keys %$access_types)
      {
	print  "$t ";
      }
    print  "};\n";
  }
#

------------------cut---------------------------


If I find the time (?), I'll try to expand this to a gui tool for
configuring security policies (using Perl/Tk).

-- 



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
