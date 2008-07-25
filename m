Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6PCFS6n006309
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 08:15:28 -0400
Received: from QMTA04.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6PCFS78019350
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 12:15:28 GMT
Subject: Re: [refpolicy-patch 19/23] netlabel policy update
From: Chris PeBenito <pebenito@gentoo.org>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <20080719210254.067780906@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
	 <20080719210254.067780906@hardeman.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UG2Z8ngLXgTBwD0M6umY"
Date: Fri, 25 Jul 2008 08:14:47 -0400
Message-Id: <1216988087.5022.52.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-UG2Z8ngLXgTBwD0M6umY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-07-19 at 22:50 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_system_netlabel.patch)
> Trivial patch

Merged.

> diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/syst=
em/netlabel.te serefpolicy-3.5.0/policy/modules/system/netlabel.te
> --- nsaserefpolicy/policy/modules/system/netlabel.te	2008-06-12 23:25:07.=
000000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/system/netlabel.te	2008-07-15 14:05:=
13.000000000 -0400
> @@ -9,6 +9,7 @@
>  type netlabel_mgmt_t;
>  type netlabel_mgmt_exec_t;
>  application_domain(netlabel_mgmt_t,netlabel_mgmt_exec_t)
> +role system_r types netlabel_mgmt_t;
> =20
>  ########################################
>  #

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-UG2Z8ngLXgTBwD0M6umY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiJw7cACgkQvI7kLeavkkPFUwCfcLVbbMCctOfzLJEx18z8FuFp
g/oAn3XEY+9yLqoPPpb8QN1eQLbD/jRY
=4vvD
-----END PGP SIGNATURE-----

--=-UG2Z8ngLXgTBwD0M6umY--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
