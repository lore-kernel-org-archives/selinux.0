Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h83FHCLa027038
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 11:17:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h83FHBet028771
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 15:17:11 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id h83FHAlq028768 for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2003 15:17:10 GMT
Subject: Re: Enable SELinux via boot parameter
From: Chris PeBenito <pebenito@gentoo.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Tom <tom@lemuria.org>, SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1062592181.18568.321.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <Pine.LNX.4.44.0309021942550.11746-100000@thoron.boston.redhat.com>
	 <1062558452.1838.52.camel@chris.pebenito.net>
	 <20030903091258.L30963@lemuria.org>
	 <1062592181.18568.321.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-O1xIffhRHT6xbr7SjbeZ"
Message-Id: <1062602228.1849.99.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Wed, 03 Sep 2003 10:17:09 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-O1xIffhRHT6xbr7SjbeZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-09-03 at 07:29, Stephen Smalley wrote:
> On Wed, 2003-09-03 at 03:12, Tom wrote:
> > The broad public will not be using SELinux for now, so I'm afraid it's
> > not really a special case.

Yes, but that doesn't invalidate the idea that this in effect penalizes
people that do use it.  Most of these people compile their own kernels,
meaning they choose SELinux, and expect it to be on by default.  Making
the default off caters to the needs of distributions rather than the
needs of SELinux users.  Just because SELinux users are in the minority
doesn't mean they should loose out to distribution's needs.

> > There should, however, be a kernel config option to turn it on by
> > default and FORCE it on. (i.e. no way to boot that kernel without SE
> > enabled). Otherwise we have a trivial boot security problem.

I like this.  Except the option should be to make it disable-able.=20
Kinda like how turning on development mode requires to specify
enforcing=3D1 to boot up in enforcing.

> It is already the case that you need to specify 'enforcing=3D1' to boot a=
n
> enforcing kernel if you enabled development support.  How many people
> disable development support?  And if you do disable development support,
> do you also keep around a second kernel that you can boot for emergency
> recovery?  In that case, what is the difference?  You are still are
> relying on your lilo/grub password to limit the ability to boot the
> non-SELinux kernel.

This is true; however, from my point of view, it supports having a
kernel config option.  If development is not turned on, then it always
enforces.  If no one ever turns off development mode, as you're arguing,
then why bother making it an option, and just make it default to
development mode?  By not making this SELinux-disabling option
controlled by a kernel config option, you are eliminating the usefulness
of regular (non-development) mode.  If you do turn off development,
SELinux could still be disabled by this patch, so it makes
non-development meaningless.  Lilo/grub passwords not being real
security does not negate this fact.  Anyone that has physical access to
a machine can generally do whatever they want anyway.

My suggestion is the default should be to not be able to disable
selinux, and have a kernel config option to make it disable-able (and
with that turned on SELinux would be disabled by default).  I think this
is a good compromise between people that compile their on kernels and
just want SELinux to work by default, and also gives distributions the
option of having a kernel that SELinux is disabled by default.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-O1xIffhRHT6xbr7SjbeZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/VgX0vI7kLeavkkMRArJZAJ0VKvDmZ64JeUrE3rclCel3mYiSgACfZTxx
rWQE1D37WnsqMUsT9XeRs1k=
=YAJ0
-----END PGP SIGNATURE-----

--=-O1xIffhRHT6xbr7SjbeZ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
