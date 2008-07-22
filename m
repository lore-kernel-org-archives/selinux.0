Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MKWkpi030012
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 16:32:46 -0400
Received: from QMTA05.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MKWkT1011895
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 20:32:46 GMT
Subject: Re: [refpolicy-patch 20/23] pcmcia policy update
From: Chris PeBenito <pebenito@gentoo.org>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <20080719210254.226174360@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
	 <20080719210254.226174360@hardeman.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ych45/GhmZ1utWQOBw8P"
Date: Tue, 22 Jul 2008 16:32:02 -0400
Message-Id: <1216758722.4954.36.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ych45/GhmZ1utWQOBw8P
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-07-19 at 22:50 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_system_pcmcia.patch)
> Documentation changes only...
>=20
> diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/syst=
em/pcmcia.if serefpolicy-3.5.0/policy/modules/system/pcmcia.if
> --- nsaserefpolicy/policy/modules/system/pcmcia.if	2008-07-10 11:38:46.00=
0000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/system/pcmcia.if	2008-07-15 14:05:13=
.000000000 -0400
> @@ -4,9 +4,9 @@
>  ## <summary>
>  ##	PCMCIA stub interface.  No access allowed.
>  ## </summary>
> -## <param name=3D"domain" unused=3D"true">
> +## <param name=3D"domain" optional=3D"true">
>  ##	<summary>
> -##	Domain allowed access.
> +##	N/A
>  ##	</summary>
>  ## </param>
>  #
>=20
Reverses an upstream change.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-ych45/GhmZ1utWQOBw8P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiGQ8IACgkQvI7kLeavkkOeSQCfbk+xdexsM2D8j4GE1Bqp/RXD
xuUAn11DyKnrv176Nu2KC0Gn9mCcJWcs
=GM0I
-----END PGP SIGNATURE-----

--=-ych45/GhmZ1utWQOBw8P--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
