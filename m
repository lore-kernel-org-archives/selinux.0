Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71ANJrT006239
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 06:23:19 -0400 (EDT)
Received: from smtp811.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i71ANH0x019122
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 10:23:17 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp811.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 10:23:17 -0000
Date: Sun, 1 Aug 2004 11:34:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: hacked Makefile to use 17 instead of 18
Message-ID: <20040801103422.GD7384@lkcl.net>
References: <20040731122835.GO3378@lkcl.net> <200408011934.54470.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408011934.54470.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 01, 2004 at 07:34:54PM +1000, Russell Coker wrote:
> On Sat, 31 Jul 2004 22:28, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > well, i'm about to find out if it's okay, but i hacked the 1.14-1
> > Makefile to forcibly put policy file of type 18 into a file named
> > policy.17.
> 
> Bad idea.  Why would you want to do that?

 ignorance and lack of fear.  *lol*

> > oh, darn, i'm using xfs, hope that's okay.
> 
> XFS works on the latest kernels.  But make sure you have 512 byte Inodes (see 
> previous discussion on the list).
 
 eek!  okay!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
