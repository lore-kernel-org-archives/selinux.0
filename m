Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA11184
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 18:42:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBKNg2I20051
	for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 23:42:02 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id gBKNfxf20047 for <selinux@tycho.nsa.gov>; Fri, 20 Dec 2002 23:41:59 GMT
Date: Sat, 21 Dec 2002 10:46:12 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: [ISN] Music file flaws could threaten traders
Message-ID: <20021220234612.GE24957@snoopy.apana.org.au>
References: <Pine.LNX.4.44.0212190257480.19905-100000@idle.curiosity.org> <200212192307.20386.russell@coker.com.au> <20021220001646.GD15409@snoopy.apana.org.au> <200212200823.55982.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212200823.55982.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Dec 20, 2002 at 08:23:55AM +0100, Russell Coker wrote:
> On Fri, 20 Dec 2002 01:16, Brian May wrote:
> > I think it should be possible to write a program that checks to source
> > file, makes sure it is valid and doesn't contain any errors or other
> > potentially dangerous stuff (eg. a multimedia tag with too much data, as
> > per article), and then relabels it with a file label that allows the
> > user to freely use that file.
> 
> If that is the approach that you want then why not just audit the source code 
> to all the programs that use such files?

That would be the best long term solution.

After it, it isn't really the files that are at fault, it is the
application that is at fault.

If this invalid file was created accidently (eg. due to buggy
software or data curruption), you wouldn't want it crashing you
applications either.

Which means were going around in circles, and I am arguing
your case for running AV programs in a seperate domain, until
they can be audited at least. Oh well...

> Surely auditing source code to applications is easier than writing
> virus-scanners for every type of file that MIGHT break some buggy
> program somewhere and cause a security hole.

Not so much a virus-scanner, more a "fsck"/validator that works on data
files rather then harddisk images. I would be surprised if such a
program doesn't already exist, there must be some program to ensure
output MP3 files are consistant with the MP3 standard (whether it is
free software or not though is another matter).
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
