Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8BCXs5j014366
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 08:33:54 -0400
Date: Tue, 11 Sep 2012 14:33:21 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Laurent Bigonville <bigon@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Assertion `new_role != ((void *)0) && new_role->flavor == 1'
 when installing modules
Message-ID: <20120911123321.GD4390@telmora.telvanni>
References: <20120909191000.74e83c73@fornost.bigon.be>
 <1347280786.2480.3.camel@moss-pluto.epoch.ncsc.mil>
 <20120911011349.0ecc2f99@eldamar.bigon.be>
 <20120911063822.GA4390@telmora.telvanni>
 <20120911121903.6ba2825d@eldamar.bigon.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
In-Reply-To: <20120911121903.6ba2825d@eldamar.bigon.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2012 at 12:19:03PM +0200, Laurent Bigonville wrote:
> Le Tue, 11 Sep 2012 08:38:22 +0200,
> Ole Kliemann <ole@plastictree.net> a =E9crit :
>=20
> >=20
> > You are building the policy without MLS/MCS, right?
>=20
> Yes, TYPE =3D standard in the build.conf
>=20
> >=20
> > Educated guess: It's the same here:
> >=20
> >     http://marc.info/?l=3Dselinux&m=3D133003003018371
> >=20
> > Patch would be (helped on Ubuntu):
> >=20
> >     http://marc.info/?l=3Dselinux&m=3D132433039902439&w=3D2
>=20
> Actually this patch is already included in the version of libsemanage
> I'm using.
>=20
> The patch here: http://marc.info/?l=3Dselinux&m=3D132636024218187&w=3D2 f=
ixed
> the segfault when loading the policy with Stephen patch.

Okay, guess I used that one too then, can't remember. Didn't=20
persue this any further when I moved away from refpol (and don't=20
use any genhomedircon stuff).

>=20
> BUT, it seems that the initial assertion is not completely fixed.
>=20
> I'm still getting:
>=20
> checkmodule: expand.c:700: role_fix_callback: Assertion `new_role !=3D ((=
void *)0) && new_role->flavor =3D=3D 1' failed.
>=20
> When compiling the policy the following way:
>=20
> 1) Take the refpolicy git HEAD
> 2) make conf
> 3) edit policy/modules.conf and set the following module as part of the
>    base: init libraries logging selinuxutil modutils storage userdomain
>    miscfiles sysadm authlogin sysnetwork application locallogin
> 4) make policy
> 5) -> assetion
>=20
> Cheers
>=20
> Laurent Bigonville

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlBPL5EACgkQS1FjE303ERzBhQCgjYBab3bCiGnYo3QEbIG5wFri
R28An3y12PsBSeFBClLPSfqQcKC/LRZN
=ddWq
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
