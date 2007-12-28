Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBSKlpfB017398
	for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 15:47:51 -0500
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBSKlnMX010518
	for <selinux@tycho.nsa.gov>; Fri, 28 Dec 2007 20:47:49 GMT
Subject: Re: What happened to source for targeted?
From: James Antill <jantill@redhat.com>
To: Lance Spitzner <lance@spitzner.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <705BD06B-DED9-4B3C-968C-4B8A09B97204@spitzner.net>
References: <705BD06B-DED9-4B3C-968C-4B8A09B97204@spitzner.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-S2DRLTOdZaDxQrlBuDWT"
Date: Fri, 28 Dec 2007 14:41:40 -0500
Message-Id: <1198870900.27673.15.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-S2DRLTOdZaDxQrlBuDWT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Thu, 2007-12-27 at 23:28 -0600, Lance Spitzner wrote:
> Apologies if this is off topic or can be found elsewhere, I'm not =20
> having luck with archives or Google.  What happened to the source for =20
> the targeted policy?  The latest versions of Red Hat (Fedora8 / =20
> CensOS5) have the targeted policy, but no source for it.  I cannot =20
> find the RPMs either for the source.  Is there a source for the =20
> targeted policy, am I missing something?

 The way to find this information out is:

% yumdownloader --source selinux-policy-targeted --urls

...or remove the --urls option to just download the .src.rpm. The
yumdownloader application is part of the yum-utils package.

--=20
James Antill <jantill@redhat.com>

--=-S2DRLTOdZaDxQrlBuDWT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHdVF011eXTEMrxtQRAkHYAKCdvP3ockg77vTgASIojglE2vUu3QCfdf+B
hiErNOCcOQsOerjGuuxnk1A=
=I2tY
-----END PGP SIGNATURE-----

--=-S2DRLTOdZaDxQrlBuDWT--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
