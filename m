Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UEqZrT023561
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 10:52:35 -0400 (EDT)
Received: from obadja2.jmh.mhn.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UEpRng013600
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 14:51:27 GMT
Date: Thu, 30 Sep 2004 16:52:56 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Colin Walters <walters@verbum.org>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: Access to xdm_t
Message-ID: <20040930145256.GE2773@cip.ifi.lmu.de>
References: <20040929163222.GA4125@rom.cip.ifi.lmu.de> <1096512456.5008.3.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
In-Reply-To: <1096512456.5008.3.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Colin Walters <walters@verbum.org> [2004-09-30 09:53]:
> On Wed, 2004-09-29 at 18:32 +0200, Thomas Bleher wrote:
> > I have a question about access to xdm_t:
> > With KDM 3.3 I am seeing a lot of accesses to xdm_t:fd and
> > xdm_t:fifo_file from user processes (say user_lpr_t and user_gpg_t)
>=20
> For Fedora we modified GDM to log the X session errors to=20
> /tmp/xses-$USER.$RANDOM, you could probably do something similar with
> KDM.

This seems like the right thing to do; however, this is not possible
with current kdm, at least not without patching.
Just bugzillad: http://bugs.kde.org/show_bug.cgi?id=3D90552

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBXB3IxWIrrrL0q+cRAiw5AKCszYLyxJjLVScksyexdq7EDbHCJwCcDRUr
fcZqwsZt7aWaVeFFTiz8inc=
=RVdx
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
