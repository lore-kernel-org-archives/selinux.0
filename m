Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7AH63rT004471
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 13:06:03 -0400 (EDT)
Received: from mcfeely.r00td0wn.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7AH61lU007836
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 17:06:01 GMT
Message-ID: <41190079.9020206@diyab.net>
Date: Tue, 10 Aug 2004 13:06:01 -0400
From: Timothy Wood <timothy@diyab.net>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: russell@coker.com.au, "'Stephen Smalley'" <sds@epoch.ncsc.mil>,
   selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   selinux-dev@tresys.com
Subject: Re: Now that SELinux supports booleans should we replace tunableswith
 booleans?
References: <200408101429.i7AET6Sf010692@gotham.columbia.tresys.com>
In-Reply-To: <200408101429.i7AET6Sf010692@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Why not add an option to load_policy that would force loading of boolean
values from the policy.  If you specify that option load_policy modifies
the current boolean values to the policy defaults.  If you do not
specify the option load_policy does not touch current boolean values.

You could do the same thing with a tunable and have load_policy check
for the tunable value.

Timothy,

Karl MacMillan wrote:
|>-----Original Message-----
|>From: Russell Coker [mailto:russell@coker.com.au]
|>Sent: Tuesday, August 10, 2004 2:47 AM
|>To: Stephen Smalley
|>Cc: Karl MacMillan; selinux@tycho.nsa.gov; Daniel J Walsh; selinux-
|>dev@tresys.com
|>Subject: Re: Now that SELinux supports booleans should we replace
|>tunableswith booleans?
|>
|>On Tue, 10 Aug 2004 06:11, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
|>
|>>>Under the proposed scheme, reboots and policy reloads would set the
|>>>booleans to the values saved in /etc/selinux/$SELINUXTYPE/booleans
|>>>(defaulting to the compile-time defaults if there was no value saved
|>
|>in
|>
|>>>that file for a given boolean).  Admins would edit that file (directly
|>>>or using a tool) if they wanted the boolean setting to persist; if
|>
|>they
|>
|>>>only want a temporary change that will be reverted by a reboot or
|>
|>policy
|>
|>>>reload, then they would use setsebool to make that temporary change.
|>>
|>>Karl has suggested that while /sbin/init should use this technique for
|>>preserving booleans across reboots, /usr/sbin/load_policy should just
|>>get the current boolean settings from selinuxfs and use them for policy
|>>reloads, so that booleans do not change upon a policy reload by
|>>default.  This is to ensure that booleans that represent system state
|>>are not perturbed by policy reloads.  What do others think?
|>
|>Sounds good.
|>
|
|
| Another question is what happens if you change the default value in the
| policy source? Under this suggestion, the new default would not take
effect
| until a reboot and then only if the config file doesn't specify the
boolean
| value. Not certain if this is a problem, but it is kind of strange and
| potentially surprising to policy authors.
|
| Karl
|
| Karl MacMillan
| Tresys Technology
| http://www.tresys.com
| (410)290-1411 ext 134
|
|
|>--
|>http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
|>http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
|>http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
|>http://www.coker.com.au/~russell/  My home page
|
|
|
| --
| This message was distributed to subscribers of the selinux mailing list.
| If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
| the words "unsubscribe selinux" without quotes as the message.
|
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBGQB5PT0XLCkCs2ARAiGrAJ4pvPGpZEPrWO8Z8yOB0iXueXK4pgCgiHoj
/IU4/SscNhayiOvwMUEtItc=
=bZ0L
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
