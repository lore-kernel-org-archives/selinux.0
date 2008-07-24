Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6ONie4J020547
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 19:44:41 -0400
Received: from QMTA02.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6ONieZH024679
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 23:44:40 GMT
Subject: Re: [refpolicy-patch 14/23] rhgb policy update
From: Chris PeBenito <pebenito@gentoo.org>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1216758563.4954.35.camel@defiant.pebenito.net>
References: <20080719205002.462190042@hardeman.nu>
	 <20080719210253.302868396@hardeman.nu>
	 <1216758563.4954.35.camel@defiant.pebenito.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+FxPy6/Fb8aLJJ9qL85D"
Date: Thu, 24 Jul 2008 19:44:03 -0400
Message-Id: <1216943043.4931.0.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+FxPy6/Fb8aLJJ9qL85D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-22 at 16:29 -0400, Chris PeBenito wrote:
> On Sat, 2008-07-19 at 22:50 +0200, david@hardeman.nu wrote:
> > plain text document attachment (policy_modules_services_rhgb.patch)
> > rhgb (RedHat Graphical Boot) is RH specific so this should be uncontrov=
ersial...
> >=20
> > diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/se=
rvices/rhgb.if serefpolicy-3.5.0/policy/modules/services/rhgb.if
> > --- nsaserefpolicy/policy/modules/services/rhgb.if	2008-07-10 11:38:46.=
000000000 -0400
> > +++ serefpolicy-3.5.0/policy/modules/services/rhgb.if	2008-07-15 14:05:=
13.000000000 -0400
> > @@ -4,7 +4,7 @@
> >  ## <summary>
> >  ##	RHGB stub interface.  No access allowed.
> >  ## </summary>
> > -## <param name=3D"domain" unused=3D"true">
> > +## <param name=3D"domain">
> >  ##	<summary>
> >  ##	N/A
> >  ##	</summary>
>=20
> This reverses an upstream change.
>=20
> > diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/se=
rvices/rhgb.te serefpolicy-3.5.0/policy/modules/services/rhgb.te
> > --- nsaserefpolicy/policy/modules/services/rhgb.te	2008-07-10 11:38:46.=
000000000 -0400
> > +++ serefpolicy-3.5.0/policy/modules/services/rhgb.te	2008-07-15 14:05:=
13.000000000 -0400
> > @@ -92,6 +92,7 @@
> >  term_getattr_pty_fs(rhgb_t)
> > =20
> >  init_write_initctl(rhgb_t)
> > +init_chat(rhgb_t)
> > =20
> >  libs_use_ld_so(rhgb_t)
> >  libs_use_shared_libs(rhgb_t)
>=20
> This interface doesn't exist.

This is more towards Dan, but how much do we care about this policy, now
that rhgb has been removed from Fedora?

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-+FxPy6/Fb8aLJJ9qL85D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiJE8MACgkQvI7kLeavkkPNdQCfU8aOMEYWYdkKf/ZJPiMYDma9
bJYAnA9oMUGDHOaG7pfCFm7XnVMHHz9c
=ftwS
-----END PGP SIGNATURE-----

--=-+FxPy6/Fb8aLJJ9qL85D--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
