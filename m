Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91DPirT001090
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 09:25:44 -0400 (EDT)
Received: from ms-smtp-01.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i91DOb4L009265
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 13:24:38 GMT
Received: from sasami.localdomain (CPE-24-163-154-106.kc.rr.com [24.163.154.106])
	by ms-smtp-01.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id i91DPftE012664
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 08:25:41 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by sasami.localdomain (Postfix) with ESMTP id 064904A658
	for <selinux@tycho.nsa.gov>; Fri,  1 Oct 2004 08:25:41 -0500 (CDT)
Received: from sasami.localdomain ([127.0.0.1])
	by localhost (sasami [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11823-06 for <selinux@tycho.nsa.gov>;
	Fri, 1 Oct 2004 08:25:40 -0500 (CDT)
Received: from yggdrasil.localdomain (yggdrasil.localdomain [192.168.0.2])
	by sasami.localdomain (Postfix) with ESMTP id BBC0D4A650
	for <selinux@tycho.nsa.gov>; Fri,  1 Oct 2004 08:25:40 -0500 (CDT)
Date: Fri, 1 Oct 2004 08:25:40 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: where should network context additions go?
Message-ID: <20041001132540.GA8342@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Is there an equivalent to local.fc/local.te for network contexts?  I=20
need to define some additional ports for amavis and postfix to talk to=20
each other.  At the moment I'm putting such things directly into=20
net_contexts, but am concerned about upgrades clobbering my changes.

Thanx!


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBXVrUgrEMyr8Cx2YRAgMhAKCSMB59tcgKUzDRMr6HkwKojTVW0ACgtod6
dacJSrGQnMab2xh970KMI7w=
=P4xE
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
