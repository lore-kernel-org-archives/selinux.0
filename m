Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h32LnGx6026123
	for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2003 16:49:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h32Ln5xH023525
	for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2003 21:49:05 GMT
Received: from windowpane.com (ip57.gte1.rb1.bel.nwlink.com [209.20.131.57])
        by jazzband.ncsc.mil  with ESMTP id h32Ln4Dl023426 for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2003 21:49:05 GMT
Message-ID: <003501c2f962$231ba240$398314d1@windowpane.com>
From: "ccallen" <ccallen@windowpane.com>
To: "Russell Coker" <russell@coker.com.au>
Cc: <selinux@tycho.nsa.gov>
References: <000d01c2f7fa$f3c67730$398314d1@windowpane.com> <200304022237.31539.russell@coker.com.au>
Subject: Re: Motif for selinux?
Date: Wed, 2 Apr 2003 13:52:20 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks Russel,

I'll try out your KDE. I have RH 7.1 and selinux 2.5, will this work ok with
your code?

Conan

----- Original Message -----
From: "Russell Coker" <russell@coker.com.au>
To: "ccallen" <ccallen@windowpane.com>; <selinux@tycho.nsa.gov>
Sent: Wednesday, April 02, 2003 4:37 AM
Subject: Re: Motif for selinux?


> On Tue, 1 Apr 2003 13:01, ccallen wrote:
> > In build / install doc states that there are a modified versions of gdm
&
> > kdm that will work with selinux, where can these projects be found? Is
> > there a modified version of open motif that will work with selinux?
>
> KDM for KDE 2.2 is on my web site.  I have not yet got KDM 3.1.1 to build
with
> SE Linux patches (hopefully soon).
>
> I don't know the current status of GDM, check the SourceForge site.
>
> There are no other X based login programs which have been modified for SE
> Linux.  You could modify the program you desire (it's not difficult
coding),
> of you could use KDM (using KDM to start a different desktop system works
> fine).
>
> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
