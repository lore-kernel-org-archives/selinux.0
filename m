Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA13811
	for <selinux@tycho.nsa.gov>; Sat, 21 Dec 2002 13:21:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBLILFI22176
	for <selinux@tycho.nsa.gov>; Sat, 21 Dec 2002 18:21:15 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gBLILDf22168 for <selinux@tycho.nsa.gov>; Sat, 21 Dec 2002 18:21:14 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: [ISN] Music file flaws could threaten traders
Date: Sat, 21 Dec 2002 19:20:49 +0100
Cc: selinux@tycho.nsa.gov
References: <Pine.LNX.4.44.0212190257480.19905-100000@idle.curiosity.org> <200212200823.55982.russell@coker.com.au> <20021220234612.GE24957@snoopy.apana.org.au>
In-Reply-To: <20021220234612.GE24957@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200212211920.49070.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 21 Dec 2002 00:46, Brian May wrote:
> > If that is the approach that you want then why not just audit the source
> > code to all the programs that use such files?
>
> That would be the best long term solution.

In which case OpenBSD may be more suitable to your needs than SE Linux.  
Considered working on the Debian OpenBSD project?

Don't take this as some sort of sarcastic comment.  I think that the OpenBSD 
project is doing some good things and that Debian OpenBSD is a worthy 
project.  I encourage people to work on such things if that interests them.

> Which means were going around in circles, and I am arguing
> your case for running AV programs in a seperate domain, until
> they can be audited at least. Oh well...

;)

> > Surely auditing source code to applications is easier than writing
> > virus-scanners for every type of file that MIGHT break some buggy
> > program somewhere and cause a security hole.
>
> Not so much a virus-scanner, more a "fsck"/validator that works on data
> files rather then harddisk images. I would be surprised if such a
> program doesn't already exist, there must be some program to ensure
> output MP3 files are consistant with the MP3 standard (whether it is
> free software or not though is another matter).

I'm sure that there are "lint" type programs for many different types of file.  
However they are generally aimed at ensuring that the files are usable not 
that they are not going to cause an exploit.  Also it is quite possible for a 
file to comply with all standards and still break an application!  Many 
buffer overflow exploits are of such a nature.

But this would be an interesting topic for research.  Are you planning on 
getting a second Ph.D?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
