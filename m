Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA01286
	for <selinux@tycho.nsa.gov>; Fri, 27 Dec 2002 10:07:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA18421
	for <selinux@tycho.nsa.gov>; Fri, 27 Dec 2002 15:05:09 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA18417
	for <selinux@tycho.nsa.gov>; Fri, 27 Dec 2002 15:05:07 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Oliver Tennert <tennert@science-computing.de>
Subject: Re: SELinux SuSE 8.1 RPMs
Date: Fri, 27 Dec 2002 16:07:12 +0100
Cc: selinux@tycho.nsa.gov
References: <Pine.GHP.4.02.10212271530570.15737-100000@alderaan.science-computing.de>
In-Reply-To: <Pine.GHP.4.02.10212271530570.15737-100000@alderaan.science-computing.de>
MIME-Version: 1.0
Message-Id: <200212271607.12705.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 27 Dec 2002 15:46, Oliver Tennert wrote:
> I have also produced an SELinux-RPM selinux-2002121210-1.i386.rpm, which
> includes the SELinux core utilites, libraries, headers and so forth.
> The only thing is: the source RPM does not really contain the sources, as
> I found it quite painsome to have the core part of SELinux separated and
> compiled in a way non-invasive to the running system (without using a
> VMWare box). So it just cotains a tarball, re-packed to an RPM.

I have also had problems that may be similar to what you are describing.  When 
compiling my selinux-small packages it always wanted to use installed headers 
instead of the headers from the source package.  So I made it Build-Conflict 
on my libselinux-dev package so that the headers would not be installed at 
the time it's being compiled.

It's still a PITA for me as the maintainer but for users it's not an issue.

> I would like to make these packages available to all, so
> if you like to have a look at these packages and give me some ftp URL
> or the like, I would upload them. Then you can decide to make them
> publicly accessible via a dedicated URL or whatever.

I can give you some space on my server in Melbourne if you like.  It won't be 
as fast as some of the servers in Europe (256Kb frame isn't much by European 
standards) but it should do.  Of course having a connection in Germany would 
probably be best as I expect that most of the interested people will be based 
in Germany.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
