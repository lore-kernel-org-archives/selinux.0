Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8BFNYrT024803
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 11:23:34 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8BFMc9R022766
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 15:22:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: policy patch against latest CVS
Date: Sun, 12 Sep 2004 01:23:28 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200409111954.15823.russell@coker.com.au> <20040911115308.GB24787@lkcl.net>
In-Reply-To: <20040911115308.GB24787@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409120123.28663.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 11 Sep 2004 21:53, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Sat, Sep 11, 2004 at 07:54:15PM +1000, Russell Coker wrote:
> > +file_type_auto_trans(init_t, device_t, initctl_t, fifo_file)
> > +ifdef(`distro_redhat', `
> > +file_type_auto_trans(init_t, tmpfs_t, initctl_t, fifo_file)
> > +')
>
>  debian will need this too, yes?

[...]

>  and this?
>
>  if this is as you say to support tmpfs_t in udev, and i am to keep
>  current with the present selinux policy, i'll need these in debian
>  not just redhat!

That is for tmpfs in initrd.  If tmpfs is just mounted AFTER the root fs is 
mounted (which implies that a basic /dev already exists) then udev can (and 
should) arrange it such that there is never a /dev labelled as tmpfs_t.

As far as I am aware there are no plans to ever use udev in an initrd in 
Debian.  This is partially driven by the fact that a large portion of Debian 
users choose not to use initrd at all.

If there are ever plans for udev in initrd on Debian then please let me know 
and I'll change policy appropriately.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
