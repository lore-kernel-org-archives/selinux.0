Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h835nCLa022744
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 01:49:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h835nBet017552
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 05:49:12 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h835n9lq017546 for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 05:49:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   Nick Davis <nicholas-davis@utulsa.edu>
Subject: Re: glibc rpm install error
Date: Wed, 3 Sep 2003 15:49:17 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <3F54CF05.8050608@utulsa.edu> <1062523542.18568.130.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1062523542.18568.130.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309031549.17859.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Sep 2003 03:25, Stephen Smalley wrote:
> On Tue, 2003-09-02 at 13:10, Nick Davis wrote:
> > Error: %postun(glibc-2.3.2-27.9.selinux.0) scriptlet failed, exit status
> > 121
> >
> >  From that point on, any command I run gives a Segmentation Fault.  I
> > tried installing the glibc RPMs last, after all of the other utils, but
> > the same thing happens.
> >
> > Has anyone run into this problem before, or have an idea on what the
> > problem might be?
>
> Yes.  The problem isn't specific to SELinux; it also occurs when
> installing the original RHL errata RPMs if you install the i386 glibc on

There are also other potential problems.

When I tried compiling that for Debian I got the same result (of everything 
SEGV'ing) even though Debian does not have CPU optimised versions of glibc.

There must have been some subtle difference between my compiler and that which 
was used to originally build libc6, because I could not build one that worked 
in any reasonable amount of time.

If programs such as newrole etc are statically linked then you can get by 
without the patched libc6, and I'm planning to wait for it to get into the 
standard package (I've already spent excessive time fiddling with it).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
