Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j75HJVOb001946
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 13:19:31 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j75HCN26008805
	for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2005 17:12:23 GMT
Subject: Re: Red Hat's passwd
From: Colin Walters <walters@verbum.org>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42F3904F.5080401@tresys.com>
References: <42F3904F.5080401@tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rPiYghLSwSz3jtk95Jp4"
Date: Fri, 05 Aug 2005 13:12:21 -0400
Message-Id: <1123261941.20237.9.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-rPiYghLSwSz3jtk95Jp4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-08-05 at 12:14 -0400, Joshua Brindle wrote:
> The attached patch removes the selinux code from Red Hat's passwd.c and=20
> uses the libselinux function checkPasswdAccess.=20

This reminds me...there was some griping from people maintaining modules
which use libselinux about the name "checkPasswdAccess" in a shared
library targeted for wide use; could we get some namespacing here?  This
is a good thing for preventing symbol collisions and also for aesthetic
and consistency reasons.  Perhaps avc_check_passwd_permission or
security_check_passwd_permission or something?

Renaming the function would be an API/ABI break, but it doesn't seem
like a function that could be applicable for more than a few programs at
most.


--=-rPiYghLSwSz3jtk95Jp4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC8531OIkJWWp2WGURAnSbAJ9EgqzEJRuHqYp6scOqGFbAnHeBiwCfXVUg
loeEfz3c2v6fTrC7lAny3u0=
=NQaD
-----END PGP SIGNATURE-----

--=-rPiYghLSwSz3jtk95Jp4--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
