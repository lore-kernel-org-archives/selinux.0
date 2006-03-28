Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2SNPrZB022334
	for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2006 18:25:53 -0500
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2SNPp5d007981
	for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2006 23:25:51 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 29 Mar 2006 01:25:41 +0200
Date: Wed, 29 Mar 2006 01:25:38 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: Misc policy fixes
Message-Id: <20060328232538.GE8309@thorium.jmh.mhn.de>
References: <20060324122554.GB7306@thorium.jmh.mhn.de> <1143218978.3962.59.camel@sgc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
In-Reply-To: <1143218978.3962.59.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* "Christopher J. PeBenito" <cpebenito@tresys.com> [2006-03-24 17:49]:
> On Fri, 2006-03-24 at 13:25 +0100, Thomas Bleher wrote:
> Merged except for:
>=20
> > * Remove .SECONDARY because it causes build failures with current CVS
> >   make (I already sent a mail about this; I think this is a bug in make,
> >   but removing this line makes it work and doesn't cause negative side
> >   effects AFAIK).
>=20
> Actually, .SECONDARY provides an important feature, it prevents make
> from deleting intermediate files from implicit targets (e.g., the final
> source file used with checkmodule), which is very useful for debugging.

Hmm, OK. Let's hope the make maintainers will fix this bug soon.
Debian and Ubuntu only have the development version of make, but of
course I can just delete this line manually.

Thomas

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEKcXyD9qpeVMU938RAqFUAJ0Vx/4PR4F2hdNd2Hr19hGJ916m+wCdG5BH
+v7UxB4VE6GwfiP4h0nhCkc=
=Fmwn
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
