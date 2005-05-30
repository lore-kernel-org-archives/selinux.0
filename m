Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4UNpugA028444
	for <selinux@tycho.nsa.gov>; Mon, 30 May 2005 19:51:56 -0400 (EDT)
Received: from rwcrmhc14.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4UNk8NW025021
	for <selinux@tycho.nsa.gov>; Mon, 30 May 2005 23:46:08 GMT
Subject: Re: gentoo/hardened
From: Chris PeBenito <pebenito@gentoo.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050530013136.GA28006@lkcl.net>
References: <20050530013136.GA28006@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BX6byGgw3HHcPQD9KB/U"
Date: Mon, 30 May 2005 19:46:06 -0400
Message-Id: <1117496766.1742.39.camel@chris.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BX6byGgw3HHcPQD9KB/U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-05-30 at 02:31 +0100, Luke Kenneth Casson Leighton wrote:
> i've just installed gentoo/hardened on a laptop, and i wanted to run
> Xorg on it.
>=20
> bearing in mind the warnings about gentoo/hardened not having
> "workstation" capability, i noted these and carried on, happy in the
> knowledge that i would be able to sort it out.
>=20
> ... then i found out what chris had done.

You make it sound like I did something nefarious!

> chris - i hope you don't mind me saying this...
>=20
> ... but you have made a _lot_ of work for yourself, and for
> people like myself who would be happy to contribute / get
> things working.
>=20
> what chris has done is, rather than create (for example, as one
> possible way forward) a gentoo_hardened define and comment out
> blocks of code is... he's started from the sf.net cvs policy
> and REMOVED entire sections from the gentoo released selinux
> policy (including a large number of booleans).

This has been discussed on the list before.  We simply have different
goals then other distros.  The NSA example policy is being pushed by Red
Hat for widespread use, and the policy is developed in that direction,
which is fine.  The tunable policy was converted over to use booleans
and conditional policy support, which is to Red Hat's advantage, since
they don't want to install policy sources on people's system by default.
I don't have a problem with any of this, since widespread adoption helps
SELinux, which is good. =20

Gentoo users are willing to give up more functionality, especially
legacy support, for more security.  We also don't want a bunch of dead
policy, since its wasteful, and leaves more possibility of unwanted
information flows.  So the 'base policy' is only the policy needed for
the core system packages.  As a user merges more packages, policy is
pulled in as a dependency as required.  Configurability is a big thing
for Gentoo users, and thus they are willing to get down into the
details, so we definitely install the policy sources.  Most of the
tunable policy does not need to be toggled at runtime; therefore, I
reverted the conditional policy back to m4 ifdefs so there isn't extra
unneeded policy in memory.

The main divergence is the conditional policy being switched back to m4
ifdefs.  This wouldn't be sanely handled with distro tunables.  Most
everything else is just the fact that I don't keep up with sourceforge
CVS religiously.  If it ain't broke, don't fix it.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--=-BX6byGgw3HHcPQD9KB/U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCm6W+vI7kLeavkkMRAjjQAJ9+srmrkVBlhK5FRkabJkKnThwutgCglH36
Ch5gUuOjqPMQioA0KWc2hlU=
=ybVl
-----END PGP SIGNATURE-----

--=-BX6byGgw3HHcPQD9KB/U--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
