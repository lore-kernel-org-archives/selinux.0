Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87CSOrT025710
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 08:28:24 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87CSNll007667
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 12:28:23 GMT
Date: Tue, 7 Sep 2004 13:39:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: debian-devel@lists.debian.org, Scott James Remnant <scott@netsplit.com>,
   SE-Linux <selinux@tycho.nsa.gov>,
   Dpkg Development <debian-dpkg@lists.debian.org>
Subject: Re: dpkg and selinux
Message-ID: <20040907123930.GD17760@lkcl.net>
References: <20040831234115.GZ4375@lkcl.net> <1094045403.6901.112.camel@descent.netsplit.com> <20040901172551.GC4400@lkcl.net> <200409072220.53751.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409072220.53751.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 07, 2004 at 10:20:53PM +1000, Russell Coker wrote:

> > > Vaguely, files are unpacked in a temporary place then moved into the
> > > right place (inside process_archive).
> >
> >  okay, then that means that:
> >
> >  1b) the move needs to be handled carefully to ensure that the
> >     selinux permissions are preserved
> 
> This is already catered for.  The only move which could lose the SE Linux 
> context is one that crosses file systems.  This doesn't work for package 
> installation anyway (imagine if /bin/bash or /usr/bin/perl was being replaced 
> and half way through copying over the new file there was a power failure).
 
 so... if i have /usr, /var, / and /boot on separate partitions, and move
 files around, is the selinux context lost or kept?





> >  2) the linux kernel could be "prepped" by the functions in libselinux
> >      such that the correct file contexts be applied at move time (i think!)
> 
> No kernel changes.
 
 [i mean by using libselinux1 in standard way]

> >  well, under most circumstances, i believe that can be catered for
> >  (with /etc/init.d/xfs creating /tmp/.font-unix being a notable
> >   exception).
> 
> test -s /sbin/restorecon && /sbin/restorecon /tmp/.font-unix

 (in /etc/init.d/xfs i've used if [ -x /sbin/restorecon ]; then /sbin....
  but hey it's all the same)

  l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
