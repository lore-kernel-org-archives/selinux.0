Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJIncIi022764
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 13:49:38 -0500 (EST)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJInelF014556
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 18:49:40 GMT
Subject: Re: using procmail under SE-Linux
From: Colin Walters <walters@verbum.org>
To: Valdis.Kletnieks@vt.edu
Cc: Greg Norris <haphazard@kc.rr.com>, SE-Linux <selinux@tycho.nsa.gov>,
   sds@epoch.ncsc.mil, jwcart2@epoch.ncsc.mil
In-Reply-To: <200411191838.iAJIcB3E006019@turing-police.cc.vt.edu>
References: <20041119013811.GA21001@yggdrasil.localdomain>
	 <1100837214.23707.15.camel@nexus.verbum.private>
	 <200411191838.iAJIcB3E006019@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-grOr+aMm4+lOw6/gdU6P"
Date: Fri, 19 Nov 2004 13:49:36 -0500
Message-Id: <1100890176.5454.1.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-grOr+aMm4+lOw6/gdU6P
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-11-19 at 13:38 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 18 Nov 2004 23:06:54 EST, Colin Walters said:
>=20
> > type_transition postfix_local_t user_home_dir_t:dir user_procmail_t.
> >=20
> > So procmail would compute the domain to use like this, in pseudocode:
> >=20
> > newcon =3D security_compute_relabel (getcon (),
> >                                    getfilecon (getpwent (getuid ())->pw=
_dir))
> > setexeccon(newcon)
>=20
> This would apply only to things that procmail exec'ed, and not to any
> file access/etc done by procmail itself, correct? (i.e. this would fix
> a call to mh's "rcvstore", but not a misuse of 'LOG=3D' in the procmailrc=
)...

I meant for this to go into a procmail wrapper program.  Move the
existing procmail to /usr/bin/procmail.real, and just put the above code
in /usr/bin/procmail, then have it exec /usr/bin/procmail.real after
doing the setexeccon.  Sorry about being unclear.


--=-grOr+aMm4+lOw6/gdU6P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBnkBAOIkJWWp2WGURAq/NAJ9mXK2/mac3+LL6M7NrMnCq1cjnXACffYOe
QH+btSfDS5cLcvzPhBPDvk4=
=99PN
-----END PGP SIGNATURE-----

--=-grOr+aMm4+lOw6/gdU6P--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
