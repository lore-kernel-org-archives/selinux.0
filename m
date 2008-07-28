Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6SFJC6g020349
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2008 11:19:12 -0400
Received: from QMTA05.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6SFJCZu010299
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2008 15:19:12 GMT
Subject: Re: [refpolicy-patch 06/23] logrotate policy update
From: Chris PeBenito <pebenito@gentoo.org>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <20080719210252.074422602@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
	 <20080719210252.074422602@hardeman.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LA5uEeJfHh6X7CHSYQn2"
Date: Mon, 28 Jul 2008 11:18:55 -0400
Message-Id: <1217258335.4959.13.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-LA5uEeJfHh6X7CHSYQn2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-07-19 at 22:50 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_admin_logrotate.patch)
> No controversial changes

I merged the uncontroversial changes.  The second one, however, is
controversial in my opinion.

> diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/admi=
n/logrotate.te serefpolicy-3.5.0/policy/modules/admin/logrotate.te
> --- nsaserefpolicy/policy/modules/admin/logrotate.te	2008-07-10 11:38:46.=
000000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/admin/logrotate.te	2008-07-15 14:05:=
12.000000000 -0400
> @@ -71,6 +71,7 @@
> =20
>  fs_search_auto_mountpoints(logrotate_t)
>  fs_getattr_xattr_fs(logrotate_t)
> +fs_list_inotifyfs(logrotate_t)
> =20
>  mls_file_read_all_levels(logrotate_t)
>  mls_file_write_all_levels(logrotate_t)
> @@ -96,9 +97,11 @@
>  files_read_etc_files(logrotate_t)
>  files_read_etc_runtime_files(logrotate_t)
>  files_read_all_pids(logrotate_t)
> +files_search_all(logrotate_t)
>  # Write to /var/spool/slrnpull - should be moved into its own type.
>  files_manage_generic_spool(logrotate_t)
>  files_manage_generic_spool_dirs(logrotate_t)
> +files_getattr_generic_locks(logrotate_t)
> =20
>  # cjp: why is this needed?
>  init_domtrans_script(logrotate_t)

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-LA5uEeJfHh6X7CHSYQn2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiN418ACgkQvI7kLeavkkNq7gCgleT2qmIm6+oBs5/+6aunvkLG
Wl0An2GLvv7x8YOgxnE5nKHDX9lXhmTv
=hKKB
-----END PGP SIGNATURE-----

--=-LA5uEeJfHh6X7CHSYQn2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
