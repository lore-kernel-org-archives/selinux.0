Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9ENNcrT002389
	for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 19:23:38 -0400 (EDT)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9ENMQmT012369
	for <selinux@tycho.nsa.gov>; Thu, 14 Oct 2004 23:22:26 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 15 Oct 2004 01:23:36 +0200
Date: Fri, 15 Oct 2004 01:24:13 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: policy compile fixes
Message-Id: <20041014232413.GJ2540@jmh.mhn.de>
References: <20041014113536.GC2540@jmh.mhn.de> <1097785396.32077.92.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
In-Reply-To: <1097785396.32077.92.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* James Carter <jwcart2@epoch.ncsc.mil> [2004-10-14 23:35]:
> Merged with the exception of the cups.fc stuff.
>=20
> Currently, the policy Makefile is not set up so that the fc files can
> use an ifdef(`somefile.te',
>=20
> If there is interest in adding that support though, it can be done.

It just seemed easiest this way.=20
Other possibility would be to unconditionally define
cupsd_config_exec_t and be done with it.
I do not care either way, it just has to be handled.

> On Thu, 2004-10-14 at 07:35, Thomas Bleher wrote:
> > This patch fixes a few compile problems with latest policy:
> >         consoletype.te: firstboot.te may not be there
> >         cups.fc: cupsd_config only exists if hald.te is available
> >         apache_macros.te: allow_ypbind is only declared if ypbind.te is
> >                           available

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBbwqdxWIrrrL0q+cRAvwRAKCwwd03B9rJLIrOQgZ1lsE9AikjUwCgpxlO
lJMbiJvq5h6daCEgc2yYKOs=
=N+xs
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
