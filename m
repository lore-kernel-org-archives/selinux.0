Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8RKsfrT004478
	for <selinux@tycho.nsa.gov>; Mon, 27 Sep 2004 16:54:41 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8RKsdii013623
	for <selinux@tycho.nsa.gov>; Mon, 27 Sep 2004 20:54:40 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Mon, 27 Sep 2004 22:54:38 +0200
Date: Mon, 27 Sep 2004 22:55:12 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patch for strict policy
Message-Id: <20040927205512.GA2574@jmh.mhn.de>
References: <41542FF5.2090502@redhat.com> <1096303384.3234.7.camel@moss-lions.epoch.ncsc.mil> <41584D2F.5020902@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
In-Reply-To: <41584D2F.5020902@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Daniel J Walsh <dwalsh@redhat.com> [2004-09-27 21:12]:
> diff --exclude-from=3Dexclude -N -u -r nsapolicy/domains/misc/screensaver=
=2Ete policy-1.17.22/domains/misc/screensaver.te
> --- nsapolicy/domains/misc/screensaver.te	1969-12-31 19:00:00.000000000 -=
0500
> +++ policy-1.17.22/domains/misc/screensaver.te	2004-09-27 10:19:13.000000=
000 -0400
> @@ -0,0 +1,18 @@
> +#
> +# Alias file to stop blow up during policy upgrade, since=20
> +# screensaver policy is being removed.

How will screensavers be able to authenticate users (think screen lock)
if this policy is removed? screensavers had the auth_chkpwd attribute to
do this; I do not think that we should grant this capability to user_t.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBWH4wxWIrrrL0q+cRAg3MAJ9EUQ5L75AhhxeVIAx85vxkZunlRgCfemD4
9as2TyGUtgf5Mj+tnEvAIEs=
=e+jF
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
