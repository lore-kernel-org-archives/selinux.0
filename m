Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MKU4Oo029445
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 16:30:04 -0400
Received: from QMTA04.emeryville.ca.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MKU3fo006901
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 20:30:03 GMT
Subject: Re: [refpolicy-patch 14/23] rhgb policy update
From: Chris PeBenito <pebenito@gentoo.org>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <20080719210253.302868396@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
	 <20080719210253.302868396@hardeman.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AkstMySNGpnZN8TdvhvW"
Date: Tue, 22 Jul 2008 16:29:23 -0400
Message-Id: <1216758563.4954.35.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-AkstMySNGpnZN8TdvhvW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-07-19 at 22:50 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_services_rhgb.patch)
> rhgb (RedHat Graphical Boot) is RH specific so this should be uncontrover=
sial...
>=20
> diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/serv=
ices/rhgb.if serefpolicy-3.5.0/policy/modules/services/rhgb.if
> --- nsaserefpolicy/policy/modules/services/rhgb.if	2008-07-10 11:38:46.00=
0000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/services/rhgb.if	2008-07-15 14:05:13=
.000000000 -0400
> @@ -4,7 +4,7 @@
>  ## <summary>
>  ##	RHGB stub interface.  No access allowed.
>  ## </summary>
> -## <param name=3D"domain" unused=3D"true">
> +## <param name=3D"domain">
>  ##	<summary>
>  ##	N/A
>  ##	</summary>

This reverses an upstream change.

> diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/serv=
ices/rhgb.te serefpolicy-3.5.0/policy/modules/services/rhgb.te
> --- nsaserefpolicy/policy/modules/services/rhgb.te	2008-07-10 11:38:46.00=
0000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/services/rhgb.te	2008-07-15 14:05:13=
.000000000 -0400
> @@ -92,6 +92,7 @@
>  term_getattr_pty_fs(rhgb_t)
> =20
>  init_write_initctl(rhgb_t)
> +init_chat(rhgb_t)
> =20
>  libs_use_ld_so(rhgb_t)
>  libs_use_shared_libs(rhgb_t)

This interface doesn't exist.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-AkstMySNGpnZN8TdvhvW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiGQyMACgkQvI7kLeavkkMBoQCgh1FZm21TSqT+auCc24bHsZxq
g+oAn0EmxOgK1I4YEjaOEKD8Fv46tXSV
=J9tS
-----END PGP SIGNATURE-----

--=-AkstMySNGpnZN8TdvhvW--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
