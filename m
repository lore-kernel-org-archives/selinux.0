Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJ1cCIi018032
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 20:38:12 -0500 (EST)
Received: from ms-smtp-01.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJ1ahiM012121
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 01:36:44 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-01.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id iAJ1cCXP027882
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 19:38:12 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 273954A658
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 19:38:12 -0600 (CST)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06290-07 for <selinux@tycho.nsa.gov>;
	Thu, 18 Nov 2004 19:38:11 -0600 (CST)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id E8AF64A650
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 19:38:11 -0600 (CST)
Date: Thu, 18 Nov 2004 19:38:11 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: using procmail under SE-Linux
Message-ID: <20041119013811.GA21001@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Can anyone point me to the source for se_procmail[1]?  Unfortunately, it
no longer seems to be accessible via the list archive. :(  I want to
allow per-user bayesian filtering with Spamassassin, and need to somehow
coerce procmail into running under the correct domain.=20

Thanx!


[1] http://www.nsa.gov/selinux/list-archive/0307/4748.cfm

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBnU6DgrEMyr8Cx2YRAujHAKDJ5SJe6rlSdXVnGXpAcjmk4cl+kACgy2jc
2rdL5yHUr+zswVrmVrW9aVY=
=w7Rt
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
