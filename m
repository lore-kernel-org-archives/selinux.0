Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA06524
	for <selinux@tycho.nsa.gov>; Fri, 27 Dec 2002 23:21:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBS4LXI01044
	for <selinux@tycho.nsa.gov>; Sat, 28 Dec 2002 04:21:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gBS4LVf01040 for <selinux@tycho.nsa.gov>; Sat, 28 Dec 2002 04:21:32 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Ben Ritter <benritter@earthlink.net>, selinux@tycho.nsa.gov
Subject: Re: Mandrake and Slackware Distros
Date: Sat, 28 Dec 2002 05:21:11 +0100
References: <CF725BE6-1A0C-11D7-9B43-003065AE1370@earthlink.net>
In-Reply-To: <CF725BE6-1A0C-11D7-9B43-003065AE1370@earthlink.net>
MIME-Version: 1.0
Message-Id: <200212280521.11138.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 28 Dec 2002 03:33, Ben Ritter wrote:
> I'm kinda new here, how secure are the current distributions of
> Mandrake and Slackware linux?

The SE Linux project is not about testing distributions for security so the 
people involved in it aren't about to start discussing the relative merits of 
various distributions regarding general security (at least not officially and 
not on this list).

SE Linux support in a distribution is (IMHO) best for Debian.  The Debian 
packages for SE Linux patched utilities are well maintained for two different 
releases of Debian (the current release "woody" and the beta's of the next 
release).  Debian has the best support for an easy install of SE on an 
existing system (IMHO), and Brian is working on installation disks that have 
a Debian machine running SE Linux right from the start.  Debian has the best 
support for upgrading an SE Linux computer to new versions of the server 
programs it runs.

The NSA people do their testing work on Red Hat and release their official 
patches against the versions of software it includes.  Also Mark Westerman is 
producing RPMs of SE Linux software for RH.

There are quite a few German people working on SUSE support, some of which 
happens on a German-language list AFAIK.

Regarding Slackware support for SE Linux, I only recall seeing reports of 
people having problems getting things to work on Slackware with no great 
success stories (if someone has it working well on Slackware then please 
inform us).

I don't recall anyone actively working on Mandrake SE Linux support.

This doesn't make Slackware or Mandrake inherantly any less secure than 
Debian.  However they are less supported for SE Linux (which is what this 
list is about).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
