Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7AETXrT003159
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 10:29:33 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7AESuET027008
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 14:28:56 GMT
Message-Id: <200408101429.i7AET6Sf010692@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <russell@coker.com.au>, "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   <selinux-dev@tresys.com>
Subject: RE: Now that SELinux supports booleans should we replace tunableswith booleans?
Date: Tue, 10 Aug 2004 10:29:06 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <200408101646.32992.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: Russell Coker [mailto:russell@coker.com.au]
> Sent: Tuesday, August 10, 2004 2:47 AM
> To: Stephen Smalley
> Cc: Karl MacMillan; selinux@tycho.nsa.gov; Daniel J Walsh; selinux-
> dev@tresys.com
> Subject: Re: Now that SELinux supports booleans should we replace
> tunableswith booleans?
> 
> On Tue, 10 Aug 2004 06:11, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > > Under the proposed scheme, reboots and policy reloads would set the
> > > booleans to the values saved in /etc/selinux/$SELINUXTYPE/booleans
> > > (defaulting to the compile-time defaults if there was no value saved
> in
> > > that file for a given boolean).  Admins would edit that file (directly
> > > or using a tool) if they wanted the boolean setting to persist; if
> they
> > > only want a temporary change that will be reverted by a reboot or
> policy
> > > reload, then they would use setsebool to make that temporary change.
> >
> > Karl has suggested that while /sbin/init should use this technique for
> > preserving booleans across reboots, /usr/sbin/load_policy should just
> > get the current boolean settings from selinuxfs and use them for policy
> > reloads, so that booleans do not change upon a policy reload by
> > default.  This is to ensure that booleans that represent system state
> > are not perturbed by policy reloads.  What do others think?
> 
> Sounds good.
> 

Another question is what happens if you change the default value in the
policy source? Under this suggestion, the new default would not take effect
until a reboot and then only if the config file doesn't specify the boolean
value. Not certain if this is a problem, but it is kind of strange and
potentially surprising to policy authors.

Karl

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134

> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
