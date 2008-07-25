Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6P02ELU022637
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 20:02:14 -0400
Received: from QMTA10.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6P02Dm4016878
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 00:02:13 GMT
Subject: Re: [refpolicy-patch 13/23] portslave policy update
From: Chris PeBenito <pebenito@gentoo.org>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <20080719210253.146694148@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
	 <20080719210253.146694148@hardeman.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fAeqWfVf4KgyLlFuuJYK"
Date: Thu, 24 Jul 2008 20:00:53 -0400
Message-Id: <1216944053.4931.2.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-fAeqWfVf4KgyLlFuuJYK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-07-19 at 22:50 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_services_portslave.patch)
> Trivial patch

Merged.

> diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/serv=
ices/portslave.te serefpolicy-3.5.0/policy/modules/services/portslave.te
> --- nsaserefpolicy/policy/modules/services/portslave.te	2008-06-12 23:25:=
05.000000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/services/portslave.te	2008-07-15 14:=
05:13.000000000 -0400
> @@ -12,7 +12,7 @@
>  init_daemon_domain(portslave_t,portslave_exec_t)
> =20
>  type portslave_etc_t;
> -files_type(portslave_etc_t)
> +files_config_file(portslave_etc_t)
> =20
>  type portslave_lock_t;
>  files_lock_file(portslave_lock_t)

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-fAeqWfVf4KgyLlFuuJYK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiJF7UACgkQvI7kLeavkkNiKgCfagPwymbnaksI6b/QVTjQrTTM
psYAoItKmZ83wI3azs2otiquXM3/fWF1
=/anb
-----END PGP SIGNATURE-----

--=-fAeqWfVf4KgyLlFuuJYK--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
