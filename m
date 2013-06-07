Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r570Dqgl020048
	for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2013 20:13:53 -0400
Received: from [IPv6:2001:470:e1cc:2:2677:3ff:fe25:a674] (unknown [IPv6:2001:470:e1cc:2:2677:3ff:fe25:a674])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mthode.org (Postfix) with ESMTPSA id EBC7DB238
	for <selinux@tycho.nsa.gov>; Thu,  6 Jun 2013 20:15:10 -0400 (EDT)
Message-ID: <51B125CE.5020801@mthode.org>
Date: Thu, 06 Jun 2013 19:14:06 -0500
From: Matthew Thode <mthode@mthode.org>
Reply-To: mthode@mthode.org
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: selinux on zfs(onlinux)
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2PTULJONKHEASIHANFVCU"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2PTULJONKHEASIHANFVCU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

zfs is very close to usable as a root file-system with selinux, but is
just missing one thing, it doesn't know what to set the root context to
on mount.

I am going to petition for this to be added as a property, but should it
be called rootcontext (want to make sure it's valid).

system_u:object_r:fs_t is what I used just to get my system working
(including stuff like /usr, but meh).


here is the upstream bug if curious
https://github.com/zfsonlinux/zfs/issues/1504


--=20
-- Matthew Thode


------enig2PTULJONKHEASIHANFVCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRsSXaAAoJECRx6z5ArFrD5aMQAJcY53OEP31pT8u33iJPk9qD
Z2jEH9AIyKvPVUUbtvL7nvhY6lef88mu8s+7YvXGYJWkz7xq4/odtf8TrZBi9bJ3
41xojI4Lx91MX43kUQT4oQF7MNdnwe0Q8JpSGwo6Z7ETFcv9oa6cCo2iqUOxgzKI
Va5CjxqsPviUMJJTOmP1nnDIVNXkuMaQhzJhujkydmt0ZjQMPkbQTIXvQMQ1gE60
ajFOWa0t0t846+b3cOcOb87MQsMDPiRaBhVdR9dKXAVJ0JUw1JJDGBH9mZU3dz/a
4LHO8O+/mLVPsFDaPPWaIa4XVS6xzylX+hHioPKx4g+rG7tiO4d5vhQjGqPuRzkJ
ENaI3QRc/fYnwCvaq+re8aIV57qcXAqU9iFz8ttmKZH9pvFBhFJnxB1vG8IUE5u5
vF5lqXMg06SULzsoIQpVl04xOQjxbv1vJISAntR0CBqok8p7kamzUe8Y3dCcwry3
Zh9wMOYHcrVBJE1AXPGG+Tshi31RypIm8c+UOxE7ZfhdKvM0SCjADE4eYtQrzsGp
vkrvtDBY3NRu0HcadXfKAJlhJM3jiEZatZRmgpiFveSk4APoiL3apr9EjkXAw4hK
edWBgX7dW+tttKrkMCVoc3/XllIp2scvJpeFJsDDZcaGvLolZPgiq60vR681hmJ3
eAqZkLsz8HXzyvgtwByy
=luiX
-----END PGP SIGNATURE-----

------enig2PTULJONKHEASIHANFVCU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
