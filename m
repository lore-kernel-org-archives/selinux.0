Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7AEltrT003347
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 10:47:55 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7AElrlU002519
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 14:47:53 GMT
Message-Id: <200408101447.i7AElXSf010858@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Daniel J Walsh'" <dwalsh@redhat.com>
Cc: <russell@coker.com.au>, "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: Now that SELinux supports booleans should we replace tunableswith booleans?
Date: Tue, 10 Aug 2004 10:47:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <4118DCBA.7080104@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
> Sent: Tuesday, August 10, 2004 10:34 AM
> >>>Karl has suggested that while /sbin/init should use this technique for
> >>>preserving booleans across reboots, /usr/sbin/load_policy should just
> >>>get the current boolean settings from selinuxfs and use them for policy
> >>>reloads, so that booleans do not change upon a policy reload by
> >>>default.  This is to ensure that booleans that represent system state
> >>>are not perturbed by policy reloads.  What do others think?
> >>>
> >>>
> >>Sounds good.
> >>
> >>
> >>
> >
> >Another question is what happens if you change the default value in the
> >policy source? Under this suggestion, the new default would not take
> effect
> >until a reboot and then only if the config file doesn't specify the
> boolean
> >value. Not certain if this is a problem, but it is kind of strange and
> >potentially surprising to policy authors.
> >
> >
> Maybe load_policy should log to the syslog which boolean settings it is
> using,  Does the kernel
> have any memory of booleans that were manually changed from the default?
> 

No - unfortunately, the booleans only store their current state and not the
default. The default could be determined from the policy, but we could only
determine if the current value matches the default not whether the value had
been manually changed. This may not be a useful distinction, but there might
be a notion that if the admin had changed the value they wanted it to
'stick' even if it was set to the same as the default.

Karl

> Dan
> 
> >Karl
> >
> >Karl MacMillan
> >Tresys Technology
> >http://www.tresys.com
> >(410)290-1411 ext 134
> >
> >
> >
> >>--
> >>http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux
> packages
> >>http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> >>http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> >>http://www.coker.com.au/~russell/  My home page
> >>
> >>
> >
> >
> >


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
