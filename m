Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2PIVhDo011112
	for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2005 13:31:43 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2PIVLeh012985
	for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2005 18:31:22 GMT
Subject: Re: [RFC] selinux-support (1.0.1) available
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Colin Walters <walters@verbum.org>, Stephen Smalley <sds@tycho.nsa.gov>,
   ubuntu-hardened@lists.ubuntu.com, selinux@tycho.nsa.gov
In-Reply-To: <20050325175904.GP8553@lkcl.net>
References: <1111704432.27644.62.camel@localhost.localdomain>
	 <1111759697.15280.53.camel@moss-spartans.epoch.ncsc.mil>
	 <1111761662.27644.121.camel@localhost.localdomain>
	 <1111764692.3932.45.camel@nexus.verbum.private>
	 <20050325175904.GP8553@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LHGyQzyZPF7b7hUA8V+X"
Date: Fri, 25 Mar 2005 19:30:42 +0100
Message-Id: <1111775442.27644.144.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-LHGyQzyZPF7b7hUA8V+X
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El vie, 25-03-2005 a las 17:59 +0000, Luke Kenneth Casson Leighton
escribi=F3:
> On Fri, Mar 25, 2005 at 10:31:32AM -0500, Colin Walters wrote:
>=20
> > I haven't really done any Debian development in a year, but I think I
> > still remember much of how things work, so I'd be happy to help with an=
y
> > integration issues you might have.  I'm sure the same is true of
> > Russell.  Posting to selinux@tycho.nsa.gov is probably your best bet.
> =20
>  about six/eight months ago, i worked for about four months on
>  getting debian to work with selinux (strict).
>=20
>  including getting udev to work (with tmpfs).
>=20
>  so, likewise, i'd be happy to help.

Great, there's a page on the wiki that might be a start point:
http://www.ubuntulinux.org/wiki/SELinux
just write your name there if you want to (formerly) contribute.

By now, the "TODO" is there.

>  many of the patches are delayed until sarge is released, at which point
>  libselinux1 can be made "Required" rather than "Optional".

Right, Ubuntu Breezy (Hoary+1) is our target, and sure that we can have
many work done for it.

Then such work could get back into Debian, as in many other fields of
the project.

>  at _that_ point, the patch floodgates open, and patches to coreutils
>  etc. can be put forward.

I hope so ;)

Thanks, cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-LHGyQzyZPF7b7hUA8V+X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCRFjSDcEopW8rLewRAju5AKCaqAbj5qESeKcFZIEDeaVy+RlJWgCeNKu8
5NgUii6cSMVo8VPLc70IMt8=
=8AWs
-----END PGP SIGNATURE-----

--=-LHGyQzyZPF7b7hUA8V+X--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
