Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6ELXqHa014899
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 17:33:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6ELXoH5000321
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 21:33:51 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6ELXhRX000292 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 21:33:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Colin Walters <walters@verbum.org>
Subject: Re: enforcement and initrds
Date: Tue, 15 Jul 2003 07:33:30 +1000
Cc: selinux@tycho.nsa.gov
References: <1058151822.9620.25.camel@columbia> <1058185993.13738.597.camel@moss-huskers.epoch.ncsc.mil> <1058214662.19392.31.camel@columbia>
In-Reply-To: <1058214662.19392.31.camel@columbia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307150733.30170.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 15 Jul 2003 06:31, Colin Walters wrote:
> On Mon, 2003-07-14 at 08:33, Stephen Smalley wrote:
> > If CONFIG_SECURITY_SELINUX_DEVELOP=n, then the kernel is always in
> > enforcing mode, so you won't be able to defer setting enforcing mode to
> > the initrd.
>
> That's a good point, but then again we could just make DEVELOP=n instead
> mean that once enforcing mode was switched on, it couldn't be switched
> off.

You could compile with DEVELOP=y and use policy that prevents turning it off 
which is almost as good (anyone who can load a policy that allows turning it 
off can load a policy that permits everything).

> >  You can assign a single type to all of the ramfs entries
> > via genfs_contexts (but nothing more granular without further support
> > either in the ramfs code or in the SELinux module) and then grant
> > permissions to it.
>
> I tried this, but there appears to be a bootstrapping problem; the
> policy says that romfs uses genfs; but the policy has to be loaded from
> the initrd, which isn't labeled until we know what the policy is.

Last time I did this it worked OK, SE Linux loaded the policy as part of the 
mount process.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
