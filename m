Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIJhJIi015598
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 14:43:19 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAIJfpiM024977
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 19:41:51 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 18 Nov 2004 20:43:20 +0100
Date: Thu, 18 Nov 2004 20:43:13 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jwcart2@epoch.ncsc.mil, Russell Coker <russell@coker.com.au>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patches without the can_network patch.
Message-Id: <20041118194313.GA2538@jmh.mhn.de>
References: <41741A2C.8040408@redhat.com> <200410260138.19426.russell@coker.com.au> <20041025213122.GA2535@jmh.mhn.de> <200410270036.14935.russell@coker.com.au> <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil> <4192A029.5050909@redhat.com> <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil> <419CB27E.6080800@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <419CB27E.6080800@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Daniel J Walsh <dwalsh@redhat.com> [2004-11-18 15:32]:
> diff --exclude-from=3Dexclude -N -u -r nsapolicy/domains/program/ldconfig=
=2Ete policy-1.19.2/domains/program/ldconfig.te
> --- nsapolicy/domains/program/ldconfig.te	2004-11-09 13:35:12.000000000 -=
0500
> +++ policy-1.19.2/domains/program/ldconfig.te	2004-11-18 08:48:23.9181398=
78 -0500
> @@ -26,7 +26,7 @@
>  allow ldconfig_t lib_t:lnk_file create_lnk_perms;
> =20
>  allow ldconfig_t userdomain:fd use;
> -allow ldconfig_t etc_t:file { getattr read };
> +allow ldconfig_t etc_t:file { getattr read unlink };

Which files does it want to unlink? Is it possible that the file was
just mislabeled? (there's this line in the policy:
file_type_auto_trans(ldconfig_t, etc_t, ld_so_cache_t, file)
so it should probably be ld_so_cache_t)

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD4DBQFBnPtRxWIrrrL0q+cRAtO/AJjxE/g4ihq4tzJLPSkdRyHXGOo2AKCx2WZL
IPsTW6qxny8K/TIBDboIJg==
=qEXj
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
