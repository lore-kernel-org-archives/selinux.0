Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9IhTIi014797
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 13:43:30 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9IhWEj004228
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 18:43:33 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 9 Dec 2004 19:43:31 +0100
Date: Thu, 9 Dec 2004 19:43:32 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: patch: policy for powernowd
Message-Id: <20041209184332.GE8179@jmh.mhn.de>
References: <20041209173555.GE5074@jmh.mhn.de> <1102617077.2582.3.camel@defiant.pebenito.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
In-Reply-To: <1102617077.2582.3.camel@defiant.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* "Christopher J. PeBenito" <cpebenito@tresys.com> [2004-12-09 19:31]:
> On Thu, 2004-12-09 at 18:35 +0100, Thomas Bleher wrote:
> > Attached is policy for powernowd.
>=20
> This is just a slight variation of cpuspeed.te.  Does powernowd really
> need its own policy?

Not necessarily. I can merge it if wanted. It's just that there _are_
differences (albeit not that big) and the code bases are completely
separate (AFAIK). As the policy is very simple, I decided to just write
it from scratch.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBuJzUxWIrrrL0q+cRAmzcAKC0VeWfwc4x0zNwMaeHhTllKlq9HACgpGFq
iSSZJCOf6acZd66DoeRyo6I=
=ixas
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
