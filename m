Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i88DWfrT003384
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 09:32:41 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i88DVkR0028509
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 13:31:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: debian-devel@lists.debian.org
Subject: Re: dpkg and selinux
Date: Wed, 8 Sep 2004 23:32:36 +1000
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Scott James Remnant <scott@netsplit.com>, SE-Linux <selinux@tycho.nsa.gov>,
   Dpkg Development <debian-dpkg@lists.debian.org>
References: <20040831234115.GZ4375@lkcl.net> <200409072220.53751.russell@coker.com.au> <20040907123930.GD17760@lkcl.net>
In-Reply-To: <20040907123930.GD17760@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409082332.36104.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 7 Sep 2004 22:39, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > This is already catered for.  The only move which could lose the SE Linux
> > context is one that crosses file systems.  This doesn't work for package
> > installation anyway (imagine if /bin/bash or /usr/bin/perl was being
> > replaced and half way through copying over the new file there was a power
> > failure).
>
>  so... if i have /usr, /var, / and /boot on separate partitions, and move
>  files around, is the selinux context lost or kept?

It's kept by default with the modified coreutils.  Other programs that perform 
similar functions to mv will operate differently.

> > >  2) the linux kernel could be "prepped" by the functions in libselinux
> > >      such that the correct file contexts be applied at move time (i
> > > think!)
> >
> > No kernel changes.
>
>  [i mean by using libselinux1 in standard way]

Yes, we can make dpkg call functions in libselinux1.

> > >  well, under most circumstances, i believe that can be catered for
> > >  (with /etc/init.d/xfs creating /tmp/.font-unix being a notable
> > >   exception).
> >
> > test -s /sbin/restorecon && /sbin/restorecon /tmp/.font-unix
>
>  (in /etc/init.d/xfs i've used if [ -x /sbin/restorecon ]; then /sbin....
>   but hey it's all the same)

Yes.  Now we just need to get that into the init script.  Please file an 
appropriate bug report requesting that either method be used.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
