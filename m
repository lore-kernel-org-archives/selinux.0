Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9IZbIi014730
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 13:35:37 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9IXxPS013229
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 18:33:59 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 9 Dec 2004 19:35:38 +0100
Date: Thu, 9 Dec 2004 19:35:39 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jwcart2@epoch.ncsc.mil, SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: Some more fixes
Message-Id: <20041209183539.GD8179@jmh.mhn.de>
References: <20041207000805.GH3678@jmh.mhn.de> <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil> <41B87DDD.3060204@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
In-Reply-To: <41B87DDD.3060204@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A few comments:

* Daniel J Walsh <dwalsh@redhat.com> [2004-12-09 19:01]:
> diff --exclude-from=3Dexclude -N -u -r nsapolicy/domains/program/ldconfig=
=2Ete policy-1.19.12/domains/program/ldconfig.te
> --- nsapolicy/domains/program/ldconfig.te	2004-12-09 10:26:08.603496932 -=
0500
> +++ policy-1.19.12/domains/program/ldconfig.te	2004-12-09 11:05:48.845841=
826 -0500
> @@ -44,3 +44,4 @@
>  ')
> =20
>  allow ldconfig_t proc_t:file read;
> +dontaudit ldconfig_t unconfined_t:tcp_socket { read write };

This needs an ifdef(`unconfined.te' around it.

> diff --exclude-from=3Dexclude -N -u -r nsapolicy/domains/program/unused/k=
udzu.te policy-1.19.12/domains/program/unused/kudzu.te
> --- nsapolicy/domains/program/unused/kudzu.te	2004-12-09 10:26:09.1504354=
29 -0500
> +++ policy-1.19.12/domains/program/unused/kudzu.te	2004-12-09 11:03:11.36=
2550614 -0500
> @@ -16,6 +16,7 @@
> =20
>  allow kudzu_t ramfs_t:dir search;
>  allow kudzu_t ramfs_t:sock_file write;
> +allow kudzu_t etc_t:file { getattr read };

I just sent in a patch to remove this, because on line 54, there's
already rw_dir_create_file(kudzu_t, etc_t)

> diff --exclude-from=3Dexclude -N -u -r nsapolicy/macros/user_macros.te po=
licy-1.19.12/macros/user_macros.te
> --- nsapolicy/macros/user_macros.te	2004-12-09 10:26:10.334302305 -0500
> +++ policy-1.19.12/macros/user_macros.te	2004-12-09 11:03:11.384548140 -0=
500
> @@ -215,27 +222,11 @@
>  dontaudit $1_t init_t:fd use;
>  dontaudit $1_t initrc_t:fd use;
>  allow $1_t initrc_t:fifo_file write;
> -ifdef(`user_can_mount', `
> -#
> -#  Allow users to mount file systems like floppies and cdrom
> -#
> -mount_domain($1, $1_mount, `, fs_domain')
> -r_dir_file($1_t, mnt_t)
> -allow $1_mount_t device_t:lnk_file read;
> -allow $1_mount_t removable_device_t:blk_file read;
> -allow $1_mount_t iso9660_t:filesystem relabelfrom;
> -allow $1_mount_t removable_t:filesystem { mount relabelto };
> -allow $1_mount_t removable_t:dir mounton;
> -ifdef(`xdm.te', `
> -allow $1_mount_t xdm_t:fd use;
> -allow $1_mount_t xdm_t:fifo_file { read write };
> -')
> -')

I don't think this should be removed. No idea how Fedora handles this
but at least on my system I still need it because I neither use udev nor
hal. As it's already in a tunable, I think you can just disable this
tunable on Fedora.

> =20
>  #
>  # Rules used to associate a homedir as a mountpoint
>  #
> -allow $1_home_t self:filesystem associate;
> +allow $1_home_t $1_home_t:filesystem associate;
>  allow $1_file_type $1_home_t:filesystem associate;
>  ')

Ahh, this was just fixed in a patch from me. Should be left as it is.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBuJr7xWIrrrL0q+cRAk+fAKC2m7Dz4Qsfwq5eA5/3usYgrkOFpACgpZlX
QDiSCgmXtzTgJUWWOKn2EIM=
=WSEZ
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
