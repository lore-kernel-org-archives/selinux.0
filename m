Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6P07iqg023212
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 20:07:44 -0400
Received: from QMTA03.emeryville.ca.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6P07bm4017722
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 00:07:42 GMT
Subject: Re: libsepol.context_from_record: MLS is disabled, but MLS context
	"s0" found
From: Chris PeBenito <pebenito@gentoo.org>
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
Cc: selinux@tycho.nsa.gov, "MacMillan, Karl" <kmacmillan@tresys.com>
In-Reply-To: <4888E754.9030504@windriver.com>
References: <4888E754.9030504@windriver.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FbZ8k3dQuD6Xh2OsFW7O"
Date: Thu, 24 Jul 2008 20:07:15 -0400
Message-Id: <1216944435.4931.20.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-FbZ8k3dQuD6Xh2OsFW7O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-07-24 at 16:34 -0400, Vikram Ambrose wrote:
> I keep getting this error with audit2why.
>=20
> root@localhost:/root> cat msg
> type=3D1400 audit(1216736766.147:35): avc:  denied  { read write } for =20
> pid=3D1829 comm=3D"modprobe" name=3D"console" dev=3Dsda ino=3D344069=20
> scontext=3Dsystem_u:system_r:insmod_t=20
> tcontext=3Dunconfined_u:object_r:default_t tclass=3Dchr_file
>=20
> root@localhost:/root> audit2allow < msg
> #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D insmod_t =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> allow insmod_t default_t:chr_file { read write };
>=20
> root@localhost:/root> audit2why < msg
> libsepol.context_from_record: MLS is disabled, but MLS context "s0" found
> libsepol.context_from_record: could not create context structure
> libsepol.context_from_string: could not create context structure
> libsepol.sepol_context_to_sid: could not convert=20
> system_u:system_r:insmod_t:s0 to sid
> Invalid Source Context system_u:system_r:insmod_t:s0

I ran into this last week.  Sepolgen incorrectly adds the MLS portion of
the context regardless if MLS is enabled or not.  Then when the tool
uses the context, libsepol throws the above errors when MLS is disabled.
I haven't had a chance to really look at what would be the right way to
fix it, since I'm no python expert.  Karl?

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-FbZ8k3dQuD6Xh2OsFW7O
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiJGTIACgkQvI7kLeavkkMAYQCgitTQDRubig0FcA3a2v+7G8Q/
BtsAnRVC5Q16A9j6EjP5rSjJU8+FzkDR
=cUWT
-----END PGP SIGNATURE-----

--=-FbZ8k3dQuD6Xh2OsFW7O--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
