Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJLZvIi024238
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 16:35:57 -0500 (EST)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJLZwlF020238
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 21:35:59 GMT
Subject: Re: using procmail under SE-Linux
From: Colin Walters <walters@verbum.org>
To: Valdis.Kletnieks@vt.edu
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Greg Norris <haphazard@kc.rr.com>,
   SE-Linux <selinux@tycho.nsa.gov>, Jim Carter <jwcart2@epoch.ncsc.mil>
In-Reply-To: <200411192123.iAJLN2VL007405@turing-police.cc.vt.edu>
References: <20041119013811.GA21001@yggdrasil.localdomain>
	 <1100837214.23707.15.camel@nexus.verbum.private>
	 <1100889824.15944.195.camel@moss-spartans.epoch.ncsc.mil>
	 <200411192123.iAJLN2VL007405@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uH/tkELVneKqsQdAFZ0s"
Date: Fri, 19 Nov 2004 16:35:54 -0500
Message-Id: <1100900154.5454.38.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-uH/tkELVneKqsQdAFZ0s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-11-19 at 16:23 -0500, Valdis.Kletnieks@vt.edu wrote:

> (Mind you, the wrapper *will* work for the generic "invoke procmail as a
> delivery aject from sendmail, and only run the user's .procmailrc as the
> user, and don't use any of the advanced features" configuration - but the=
re
> *are* things that are going to require some major work/rewriting to do we=
ll
> under selinux.)

Ah.  I've only ever used the simple configuration then, I guess.  I'm
not sure the procmail code is going to be very amenable to more
extensive work though...

--=-uH/tkELVneKqsQdAFZ0s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBnmc6OIkJWWp2WGURAhfxAJ98Qbl4gYK+JnIWQC/x7nMqM/GSNwCeP6lg
KMp+8Uh/moVXa0t7rtbQJ6M=
=PLlV
-----END PGP SIGNATURE-----

--=-uH/tkELVneKqsQdAFZ0s--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
