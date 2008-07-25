Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6PCEvgt006239
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 08:14:57 -0400
Received: from QMTA07.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6PCEun9026012
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 12:14:56 GMT
Subject: Re: [refpolicy-patch 21/23] raid policy update
From: Chris PeBenito <pebenito@gentoo.org>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <20080719210254.370409871@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
	 <20080719210254.370409871@hardeman.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WkR44hrydYK1BjpozHAi"
Date: Fri, 25 Jul 2008 08:14:40 -0400
Message-Id: <1216988080.5022.50.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WkR44hrydYK1BjpozHAi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-07-19 at 22:50 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_system_raid.patch)
> The original patch also added dev_read_realtime_clock(mdadm_t)
> which I removed since I couldn't find a version of mdadm in
> Debian or RedHat which actually read /dev/rtc (and likewise
> for /sbin/mdmpd on RH).

Partial merge (see below)

> diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/syst=
em/raid.te serefpolicy-3.5.0/policy/modules/system/raid.te
> --- nsaserefpolicy/policy/modules/system/raid.te	2008-07-10 11:38:46.0000=
00000 -0400
> +++ serefpolicy-3.5.0/policy/modules/system/raid.te	2008-07-15 14:05:13.0=
00000000 -0400
> @@ -19,7 +19,7 @@
>  # Local policy
>  #
> =20
> -allow mdadm_t self:capability { dac_override sys_admin ipc_lock };
> +allow mdadm_t self:capability { dac_override mknod sys_admin ipc_lock };
>  dontaudit mdadm_t self:capability sys_tty_config;
>  allow mdadm_t self:process { sigchld sigkill sigstop signull signal };
>  allow mdadm_t self:fifo_file rw_fifo_file_perms;

An explicit mknod isn't needed because storage_manage_fixed_disk()
provides the capability.

> @@ -86,3 +86,7 @@
>  optional_policy(`
>  	udev_read_db(mdadm_t)
>  ')
> +
> +optional_policy(`
> +	unconfined_domain(mdadm_t)
> +')

This part is merged.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-WkR44hrydYK1BjpozHAi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiJw7AACgkQvI7kLeavkkOkgwCcDTtDnewWSa92U7u5JU9ql87B
AkYAoIBBmH/f//pL9evMBgwfvz2ErxIe
=E2ED
-----END PGP SIGNATURE-----

--=-WkR44hrydYK1BjpozHAi--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
