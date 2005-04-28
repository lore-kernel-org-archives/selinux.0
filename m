Subject: Re: Is there a SELinux tutorial for ISVs ?
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Davide Bolcioni <dbolcioni@3di.it>, fedora-selinux-list@redhat.com,
   SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <42710736.2020001@redhat.com>
References: <426F8B45.8070509@3di.it>
	 <pan.2005.04.27.23.10.29.993659@navi.cx> <42709B74.4000508@3di.it>
	 <42710736.2020001@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Nzjrb4uTrF6d9I1YrvE1"
Date: Thu, 28 Apr 2005 19:32:11 +0200
Message-Id: <1114709532.8548.69.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Nzjrb4uTrF6d9I1YrvE1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El jue, 28-04-2005 a las 11:54 -0400, Daniel J Walsh escribi=F3:
> The problem is the only way to do this is to install policy sources and=20
> muck around.    I think we to have some shared library mechanism
> where a few well known macros could be defined and users could easily=20
> build their own custom policy.
>=20
> Anyways I think we need more discussion on handling third party and user=20
> customization of policy outside of the current make tree stuff.

I've been thinking on it when working on the SELinux deployment within
Ubuntu Linux, and binary policies are something pretty handy for binary
packages-based distributions, among the general benefit they provide.

I might be able to work on something, but I would like to know first how
many people is interested in this and how many of them would be able to
contribute to it in the long term.

The idea I thought about is something like the one shown in the diagram
at
http://pearls.tuxedo-es.org/selinux/diagrams/selinux-binary-policies-1.png

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-Nzjrb4uTrF6d9I1YrvE1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCcR4bDcEopW8rLewRAipAAJ9f33OK5ppBKAINks1+246TnR/AHACfYISX
mHEzTd8yZKP9NStSVEnQD7I=
=Z6Ku
-----END PGP SIGNATURE-----

--=-Nzjrb4uTrF6d9I1YrvE1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
