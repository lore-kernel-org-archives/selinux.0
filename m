Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iARMwoIi005086
	for <selinux@tycho.nsa.gov>; Sat, 27 Nov 2004 17:58:50 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iARMwpIx002340
	for <selinux@tycho.nsa.gov>; Sat, 27 Nov 2004 22:58:52 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 27 Nov 2004 23:58:46 +0100
Date: Sat, 27 Nov 2004 23:58:44 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: Colin Walters <walters@verbum.org>, SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: patch: misc policy additions
Message-Id: <20041127225844.GA2509@jmh.mhn.de>
References: <20041109210447.GC2543@jmh.mhn.de> <1100046550.26388.8.camel@nexus.verbum.private> <20041110102439.GA2541@jmh.mhn.de> <1100893088.31793.14.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
In-Reply-To: <1100893088.31793.14.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[ sorry for the late answer. Have been very busy recently and am just
catching up ]

* James Carter <jwcart2@epoch.ncsc.mil> [2004-11-19 20:35]:
> Merged.  Except for the following chunk:
>=20
> diff -urN orig/domains/program/restorecon.te mod/domains/program/restorec=
on.te
> --- orig/domains/program/restorecon.te  2004-11-09 08:45:50.000000000 +01=
00
> +++ mod/domains/program/restorecon.te   2004-11-09 21:50:48.000000000 +01=
00
> @@ -41,7 +41,7 @@
>  allow restorecon_t unlabeled_t:dir_file_class_set { getattr relabelfrom =
};
>  allow restorecon_t unlabeled_t:dir read;
>  allow restorecon_t device_type:{ chr_file blk_file } { getattr relabelfr=
om relabelto };
> -allow restorecon_t { device_t device_type }:{ chr_file blk_file } { geta=
ttr relabelfrom relabelto };
> +allow restorecon_t { device_t device_type ttyfile }:{ chr_file blk_file =
} { getattr relabelfrom relabelto };
>  ifdef(`distro_redhat', `
>  allow restorecon_t tmpfs_t:{ chr_file blk_file } { rw_file_perms relabel=
=66rom relabelto };
>  ')
>=20
> Why do you want to restorecon_t to relabel a ttyfile? =20
> The only contexts with the ttyfile attribute are user_tty_device_t,
> staff_tty_device_t, and sysadm_tty_device_t.  The tty is relabeled to
> these from an initial tty_device_t context, so the only thing that I see
> this permission doing is to allow a current session to be relabeled from
> one of these three contexts to tty_device_t.  Why would we want to do
> that?

I do not remember the exact circumstances when I needed it. However, I
don't think it's just relabeling between the $1_tty_device_t types. What
if a device file loses its context? restorecon can relabel all other
files so it just seemed logical to allow it.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBqQakxWIrrrL0q+cRAiZEAKCP2izhxE1suS4mBgE699SSoFOYfgCePZgr
g4WWZOT5FKDsyE5KMAKHjyI=
=m7jh
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
