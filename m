Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB6FoPRb010725
	for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 10:50:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB6FoORV001879
	for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 15:50:24 GMT
Received: from wavehammer.waldi.eu.org (hornet.berlios.de [195.37.77.140])
        by jazzband.ncsc.mil  with ESMTP id hB6FoIta001870 for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 15:50:24 GMT
Date: Sat, 6 Dec 2003 16:50:12 +0100
From: Bastian Blank <bastian@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: setfiles - should not fail on ro fs
Message-ID: <20031206155012.GA19852@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi folks

setfiles should not fail on r/o filesystems:

| /usr/sbin/setfiles:  labeling files under /boot301
| /boot301: Read-only file system
| /usr/sbin/setfiles:  unable to relabel /boot301 to system_u:object_r:file=
_t
| /usr/sbin/setfiles:  error while labeling files under /boot301
| make: *** [relabel] Error 1

bastian

--=20
Genius doesn't work on an assembly line basis.  You can't simply say,
"Today I will be brilliant."
		-- Kirk, "The Ultimate Computer", stardate 4731.3

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iEYEARECAAYFAj/R+rQACgkQLkAIIn9ODhFshACgyeC+M9a3XTf8UoCSTNs0B+ug
BBAAoMuXaZsC2TaIFZg7iIi/1WX3tPkM
=3Wq1
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
