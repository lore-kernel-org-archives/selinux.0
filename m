Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9L166Wt023875
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 21:06:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9L15s0p018590
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 01:05:54 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h9L15rr7018584
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 01:05:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: old SE Linux patch for procps 3.1.12
Date: Tue, 21 Oct 2003 11:06:01 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>, Colin Walters <walters@verbum.org>
References: <200310191452.43127.russell@coker.com.au> <1066655423.22196.18.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1066655423.22196.18.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310211106.01376.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 20 Oct 2003 23:10, Stephen Smalley wrote:
> On Sun, 2003-10-19 at 00:52, Russell Coker wrote:
> > Procps includes SE Linux support upstream, but it's a bit outdated.
> >
> > I have attached a patch to remove support for displaying SIDs.  It is a
> > bit rough and has a memory leak (allocates textual representations of
> > contexts but never frees them - may be a problem for "top").
> >
> > I wrote this because I couldn't figure out how to get a straight patch
> > for the new SE Linux, so I updated the old SE Linux code to be more like
> > the new SE Linux code as an intermediate step.
>
> My impression was that Albert Cahalan was going to directly implement
> support for displaying the /proc/pid/attr/* values since /proc/pid/attr
> is now part of the mainline kernel API.  At which point you don't really
> need a SELinux-specific patch at all.

Yes.  However I don't think that Albert was planning to write it himself...

procps currently has support upstream for the old SE Linux, and I don't expect 
things to change until/unless we submit appropriate patches.

In my tree I have implemented quite a bit of the new SE Linux API for old SE 
Linux.  For example I have the runcon and chcon programs from the new SE 
Linux running on the old SE Linux.  It won't be much extra work to get it to 
the stage of having a procps patch for the new SE Linux which compiles for 
old SE Linux too.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
