Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5OEuMrT024034
	for <selinux@tycho.nsa.gov>; Thu, 24 Jun 2004 10:56:23 -0400 (EDT)
Received: from gw-eur4.philips.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5OEu9MS008353
	for <selinux@tycho.nsa.gov>; Thu, 24 Jun 2004 14:56:09 GMT
Received: from smtpscan-eur4.philips.com (smtpscan-eur4.mail.philips.com [130.144.57.167])
	by gw-eur4.philips.com (Postfix) with ESMTP id 85DF049963
	for <selinux@tycho.nsa.gov>; Thu, 24 Jun 2004 14:56:13 +0000 (UTC)
Received: from smtpscan-eur4.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP id 3E4A019F
	for <selinux@tycho.nsa.gov>; Thu, 24 Jun 2004 14:56:13 +0000 (GMT)
Received: from smtprelay-eur1.philips.com (smtprelay-eur1.philips.com [130.144.57.170])
	by smtpscan-eur4.philips.com (Postfix) with ESMTP id C16351A1
	for <selinux@tycho.nsa.gov>; Thu, 24 Jun 2004 14:56:11 +0000 (GMT)
Received: from prle4.natlab.research.philips.com (prle4.natlab.research.philips.com [130.145.137.96])
	by smtprelay-eur1.philips.com (8.9.3p3/8.9.3-1.2.2m-20040401) with ESMTP id OAA14546
	for <selinux@tycho.nsa.gov>; Thu, 24 Jun 2004 14:56:07 GMT
Received: from smtpmon (smtpmon [130.145.137.150])
	by prle4.natlab.research.philips.com (8.11.6/8.11.6) with ESMTP id i5OEu6M30285
	for <selinux@tycho.nsa.gov>; Thu, 24 Jun 2004 16:56:06 +0200
Received: from therning by pc67148596.ddns.htc.nl.philips.com with local (Exim 4.34)
	id 1BdXFc-0007mU-Ae
	for selinux@tycho.nsa.gov; Thu, 24 Jun 2004 18:39:00 +0200
Date: Thu, 24 Jun 2004 18:39:00 +0200
From: Magnus Therning <magnus-work@therning.org>
To: selinux@tycho.nsa.gov
Subject: SELinux on Debian (Sid), second try
Message-ID: <20040624163900.GB3290@philips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all!

I made an earlier attempt at installing SELinux on a Debian box, but got
stuck on the policy package. After that I got side tracked at work, then
the computer I was doing it on started exhibiting strange behaviour...
well, now I have some time do try again. Despite the computer being
fixed I've decided to start all over (it doesn't take that long any way
(the rumour about Debian's unfriendly installer is grossly
exaggerated!)).

Anyway, I've come as far as installing Woody, then bringing it all up to
Sid. Now the questions start coming :-)

When following the instructions from the SF site[1] I notice that there
are basically two kinds of programs:

 1. SELinux related packages, libselinux1, etc.
 2. Additional packages, coreutils, etc.

Should they be installed in some specific order (i.e. SELinux packages
before the others, or the other way around)?

Does it matter when I install the kernel with SELinux support?

Can I install the SELinux packages (especially selinux-policy-default)
on a non-SELinux kernel? (I remember the install scripts running some
tools that are SELinux related, and that's where I got stuck the last
time.)

/M

P.S. The note about having to install the procps package seems to
unnecessary. AFAICS I already have a procps package that supports
SELinux.

1. http://sourceforge.net/docman/display_doc.php?docid=3D20372&group_id=3D2=
1266
--=20
-----------------------------------------------------------------------
Magnus Therning                 Philips Research Laboratories Eindhoven
Phone: +31 40 2745179           (OpenPGP: 0x4FBB2C40)

Maturity is when you quite blaming other people for your problems
     -- Craig Burton

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2wOkYcKlB0+7LEARAgrUAJ9B7bBOV1IyctdrCrnie6zXsM46fACePyx6
XRm4HCdldAwkNJO6Gyce4ak=
=NAUz
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
