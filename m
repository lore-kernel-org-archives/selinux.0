Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TDokrT018716
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 09:50:46 -0400 (EDT)
Received: from smtp810.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TDoiCb005399
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 13:50:45 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp810.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 13:50:45 -0000
Date: Thu, 29 Jul 2004 15:01:50 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <method@gentoo.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: udev and .dev...
Message-ID: <20040729140150.GD8858@lkcl.net>
References: <20040729091423.GC6443@lkcl.net> <4108EE75.6040109@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4108EE75.6040109@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 08:32:53AM -0400, Joshua Brindle wrote:
> Luke Kenneth Casson Leighton wrote:
> 
> >dear selinux people,
> >
> >ah ha!  okay, the reason why my hard drive was inaccessible
> >is because /.dev/* had all been set to default_t :)
> >
> >soooo... to fix that [rather than a patch, a sed command]:
> >
> >	:%s/u?dev/.?u?dev/g
> >
> >this will allow setfiles to set up the security contexts on
> >the /.dev which is the _real_ filesystem /dev stuff which will
> >allow things like, oh, init (!!) to access the hard drive.
> >
> >argh :)
> >
> >l.
> >
> > 
> >
> Why not have a minimal /dev for init and friends and mount the ramfs for 
> udev on top of it? it's much easier to deal with 1 /dev and this is 
> pretty standard anyway.
 
 i'm getting from here to there in the minimal amount of time: if i
 find something that works, i leave it as it is.

 remember that i'm trying to hack up a standard debian/unstable system
 to do se/linux, where the focus is on making it as easy for users
 as possible.
 
 (hence usb-mount, hence udev, hence patching the kernel)

 i can always fix it later: it works for now, next thing on the list...
 
 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
