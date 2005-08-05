Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j75JStOb003371
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 15:28:55 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j75JKorI029749
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 19:20:51 GMT
Subject: Re: Red Hat's passwd
From: Colin Walters <walters@verbum.org>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <42F3B900.1090700@tresys.com>
References: <42F3904F.5080401@tresys.com>
	 <1123261941.20237.9.camel@nexus.verbum.private>
	 <42F3ACF2.9050905@tresys.com> <42F3B235.3080701@redhat.com>
	 <42F3B900.1090700@tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zra1SgheKk4eDMjT7Sgo"
Date: Fri, 05 Aug 2005 15:21:46 -0400
Message-Id: <1123269706.20237.25.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-zra1SgheKk4eDMjT7Sgo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-08-05 at 15:07 -0400, Joshua Brindle wrote:

> Sounds good to me, trivial patch to do this.. Also, I assume you will=20
> change the previous patch for passwd.c to the new function.

Shouldn't we also remove checkPasswdAccess from the header?  Otherwise
what's the point?

I should note this approach addresses the consistency and namespacing
from the developer point of view, but doesn't address possible symbol
collisions.  Possibly that could wait until a soname bump, just thought
I'd point it out.




--=-zra1SgheKk4eDMjT7Sgo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC87xKOIkJWWp2WGURAolZAJ9YeqhaZk1krQYrG0+Hr4ErYQNshQCfZZt1
VKLUyir/pcR/BYKGB+h6t58=
=J+d0
-----END PGP SIGNATURE-----

--=-zra1SgheKk4eDMjT7Sgo--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
