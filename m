Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hASGkLRb027804
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 11:46:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hASGjip5020805
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 16:45:44 GMT
Received: from node11.ravantivirus.com (node11.ravantivirus.com [213.233.121.11])
	by jazzswing.ncsc.mil  with ESMTP id hASGjht0020802
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 16:45:43 GMT
Date: Fri, 28 Nov 2003 18:46:12 +0200
From: Petre Rodan <petre.rodan@ravantivirus.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: policies for DJ Bernstein tools
Message-ID: <20031128164612.GA32668@peter.rav.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Hi,

I have searched for selinux policies for daemontools, ucspi-tcp, publicfile=
 and clockspeed.=20
Failing to find them ment that I shoud try to create them. I'm not an exper=
t in these matters, but I'm more than willing to try to become one ;)

I would really like to see these policies in the '{domains/file_contexts}/p=
rogram/unused' sf.net cvs repo, and if I can help make this true, I would b=
e honored.

An early test version can be found here:

http://team.rav.ro/peter/policy.tar.gz

I'll update this package from time to time.

Feedback is more than welcome.

bye,
peter


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/x3vUixMPpwVd7zERAgKNAKCIT/EJVGfUpiA2lhcFv8XIQDBtdACeM0PF
DCYcc77HiVaFxsNS642fMzU=
=KanU
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
