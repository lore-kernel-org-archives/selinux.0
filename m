Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB26sTRb012703
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 01:54:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB26rmp5008202
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 06:53:48 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id hB26rmt0008199
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 06:53:48 GMT
Received: from nexus.verbum.private (dhcp024-208-187-170.columbus.rr.com [24.208.187.170])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "nexus.verbum.org", Issuer "monk.verbum.org" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 5862C32A6C0
	for <selinux@tycho.nsa.gov>; Tue,  2 Dec 2003 01:54:40 -0500 (EST)
Subject: "new" SELinux 2.4.22 UML kernel patch + sample Debian filesystem
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FpXaN8S93XVg/b0Jmjv3"
Message-Id: <1070347847.12634.512.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Tue, 02 Dec 2003 01:50:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-FpXaN8S93XVg/b0Jmjv3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I've merged the 2.4.22 LSM patch in Russell's Debian kernel patches with
the latest 2.4.22 UML bits, and placed the result here:

http://web.verbum.org/selinux/uml/

Additionally, I've created a roomy 350MB Debian sid image (which gzipped
into just 370kb), set up with the latest Debian sid SELinux packages.=20
It seems to work fine even in enforcing mode.  I had to disable bootlogd
though.

It's a great way to play around with SELinux, especially if you use
UML's copy-on-write filesystem bits.  That way if you mess something up,
you can just delete your COW file and restart from the base image.

One tip: you will likely want to give your UML at least 64MB of ram;
setfiles seems to be summarily executed by the OOM killer with less.=20
Here's how I'm booting the UML:

walters@nexus> ./linux enforcing=3D1 mem=3D64M ubd0=3D/build/uml/debian-se-=
work.img,/build/uml/debian-se.img eth0=3Dtuntap,tap0

Enjoy!


--=-FpXaN8S93XVg/b0Jmjv3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/zDZHOIkJWWp2WGURAiKHAJ0QgqjMDsKZDITaNVV5KQQbVcwRSQCfVrnf
glSgAh2vIIMgCjJVf96B2aA=
=b/qb
-----END PGP SIGNATURE-----

--=-FpXaN8S93XVg/b0Jmjv3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
