Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJ46wIi018481
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 23:06:58 -0500 (EST)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJ45U3F015083
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 04:05:30 GMT
Subject: Re: using procmail under SE-Linux
From: Colin Walters <walters@verbum.org>
To: Greg Norris <haphazard@kc.rr.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, sds@epoch.ncsc.mil,
   jwcart2@epoch.ncsc.mil
In-Reply-To: <20041119013811.GA21001@yggdrasil.localdomain>
References: <20041119013811.GA21001@yggdrasil.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qoobtsIazph4LvuJaNok"
Date: Thu, 18 Nov 2004 23:06:54 -0500
Message-Id: <1100837214.23707.15.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-qoobtsIazph4LvuJaNok
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-11-18 at 19:38 -0600, Greg Norris wrote:
> Can anyone point me to the source for se_procmail[1]?=20

I don't have the source handy anymore, but it was a really simple, quick
hack. Basically, it just read a file in /etc (something
like /etc/selinux/contexts/mail), and searched for a mapping from the
home directory context to a target context, for example:

system_u:object_r:user_home_t system_u:object_r:user_procmail_t

It then set its exec security context via setexeccon, and exec'd the
regular procmail.

However, I've learned a lot about SELinux since then, and I think a
better approach would be to use security_compute_relabel.  Then the
policy itself can specify the type to use, via type_transition.  For
example:

type_transition postfix_local_t user_home_dir_t:dir user_procmail_t.

So procmail would compute the domain to use like this, in pseudocode:

newcon =3D security_compute_relabel (getcon (),=20
                                   getfilecon (getpwent (getuid ())->pw_dir=
))
setexeccon(newcon)

To do this right, you create a postfix_user_domain($1) macro, call it
from base_user_macros.te (and probably ifdef(`procmail.te')).

I think this is arguably cleaner than having another config file
in /etc.


--=-qoobtsIazph4LvuJaNok
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBnXFeOIkJWWp2WGURAkMcAKCHCvyUbswiAaUemGEr0zGnJqnb/gCfSPSE
vh8aSb+BejucHjCqWGpcxhU=
=1QVz
-----END PGP SIGNATURE-----

--=-qoobtsIazph4LvuJaNok--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
