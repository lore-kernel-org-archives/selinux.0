Subject: Re: Question about assurance?
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <20050605163932.63622.qmail@web51508.mail.yahoo.com>
References: <20050605163932.63622.qmail@web51508.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vEWd9GnGr6t9VkvuNJcO"
Date: Sun, 05 Jun 2005 21:12:14 +0200
Message-Id: <1117998734.25172.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vEWd9GnGr6t9VkvuNJcO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El dom, 05-06-2005 a las 09:39 -0700, Park Lee escribi=F3:
> Hi,
>=20
> In "5.1 Architecture Overview" of=A1=B6The Flask Security
> Architecture: System Support for Diverse Security
> Policies=A1=B7, It says:
>=20
> "Secondary goals for the architecture include
> application
> transparency, defense-in-depth, ease of assurance,
> and minimal performance impact".
>=20
> Here, Is the meaning of word "assurance" the same as
> the meaning of "assurance" of "Security assurance" in
> ISO/IEC15408 (i.e. Information technology - Security
> techniques --Evaluation criteria for IT security)?=20
> or Does it just mean another thing?

At least for me, that part means that you can easily implement
information assurance models on top of the Flask architecture, with the
"defense in depth" philosophy, which is basically putting layered
defenses all-together for ensuring that breakage, corruption, overriding
or any other type of mis-use either desired or undesired against one or
more layers, can't lead to a complete compromise of the environment.

All the rest of CC and the like it's much of the same, but talking in
technical terms, it's what I've told you AFAIK.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-vEWd9GnGr6t9VkvuNJcO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCo06NDcEopW8rLewRAjg8AJ9l+WarUdZktGgb4/K8rEHeL0bPGwCfXt7q
rGgnpYbRm/aZ523TEbWvzAY=
=7jWk
-----END PGP SIGNATURE-----

--=-vEWd9GnGr6t9VkvuNJcO--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
