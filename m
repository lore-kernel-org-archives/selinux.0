Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KCDWRb017930
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 08:13:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KCANB2018880
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:10:24 GMT
Received: from mailrelay2.lrz-muenchen.de (mailrelay2.lrz-muenchen.de [129.187.254.102])
	by jazzswing.ncsc.mil  with ESMTP id i4KC9owi018741
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:09:50 GMT
Received: from cobalt.jmh.mhn.de ([192.168.99.1] [192.168.99.1]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 20 May 2004 14:12:12 +0200
Date: Thu, 20 May 2004 14:11:57 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
Message-Id: <20040520121157.GA2146@jmh.mhn.de>
References: <20040519074242.GK7348@lkcl.net> <20040519100822.GA31914@colombo.cip.ifi.lmu.de> <20040519115039.GB4221@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
In-Reply-To: <20040519115039.GB4221@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-05-19 15:13]:
> On Wed, May 19, 2004 at 12:08:22PM +0200, Thomas Bleher wrote:
> > * Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-05-19 11:06]:
> > > is this pretty much all that's required???  compared to the 2.4 stuff
> > > it's like tiny.
> > >=20
> > > this is all that the patch to wdm does.  i'm just a little surprised
> > > (pleasantly so).
> > >=20
> > > --- client.c.old	2004-05-19 07:40:58.000000000 +0000
> > > +++ kdm/backend/client.c	2004-05-19 07:18:01.000000000 +0000
> > <snip patch>
> >=20
> > I don't think that even this is required. It should work without
> > patching, just using pam_selinux.so.

I just rechecked, and it is indeed working fine on a SuSE box
(kdebase3-kdm-3.2.2-8) without any patches, just using the selinux pam
module.

>  oh?
>=20
>  do you have some example usage that i can try out, and does
>  anyone have any advice on how to ensure that installation
>  of debian packages (pam and selinux and kde) would result
>  in pam being automatically updated?

echo "session  required       pam_selinux.so" >> /etc/pam.d/kdm
should do it.
/etc/pam.d/kdm is a conffile AFAIK, so there should be no problems when
updating packages.

HTH,
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFArKCNxWIrrrL0q+cRAjCgAJ4g0VNq7FcQMAh9yCFCM0mmLeK6RwCfU5cJ
5025+WR/l7py+C2kjX60Dus=
=6/pn
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
