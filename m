Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6PCFCR9006269
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 08:15:12 -0400
Received: from QMTA08.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6PCFC78019302
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 12:15:12 GMT
Subject: Re: [refpolicy-patch 18/23] miscfiles policy update
From: Chris PeBenito <pebenito@gentoo.org>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <20080719210253.958616054@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
	 <20080719210253.958616054@hardeman.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Itd9T8GXYAlfwrDCs/je"
Date: Fri, 25 Jul 2008 08:14:44 -0400
Message-Id: <1216988084.5022.51.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Itd9T8GXYAlfwrDCs/je
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-07-19 at 22:50 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_system_miscfiles.patch)
> Trivial change (perhaps RH specific path?)...

Merged; in distro_redhat block.

> diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/syst=
em/miscfiles.fc serefpolicy-3.5.0/policy/modules/system/miscfiles.fc
> --- nsaserefpolicy/policy/modules/system/miscfiles.fc	2008-06-12 23:25:07=
.000000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/system/miscfiles.fc	2008-07-15 14:05=
:13.000000000 -0400
> @@ -11,6 +11,7 @@
>  /etc/avahi/etc/localtime --	gen_context(system_u:object_r:locale_t,s0)
>  /etc/localtime		--	gen_context(system_u:object_r:locale_t,s0)
>  /etc/pki(/.*)?			gen_context(system_u:object_r:cert_t,s0)
> +/etc/sysconfig/clock	--	gen_context(system_u:object_r:locale_t,s0)
> =20
>  #
>  # /opt

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-Itd9T8GXYAlfwrDCs/je
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiJw7QACgkQvI7kLeavkkPUoACePlaKuJJ0W9Ev4wihrSDjPnCs
4MQAoJekpWt0b/2srK0NfPmDvX09omwI
=Z6uF
-----END PGP SIGNATURE-----

--=-Itd9T8GXYAlfwrDCs/je--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
