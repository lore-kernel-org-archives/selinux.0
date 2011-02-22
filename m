Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1MKwEso018615
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 15:58:17 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1MKwFcZ017276
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 20:58:16 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p1MKwCBx025349
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 15:58:12 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p1MKwCN6006610
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2011 15:58:12 -0500
Message-ID: <4D642363.6050403@redhat.com>
Date: Tue, 22 Feb 2011 15:58:11 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: I want to add the following to mcs constraints in SELinux policy
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

mlsconstrain { tcp_socket udp_socket rawip_socket } node_bind
	(( h1 dom h2 ) or ( t1 == mcsnetwrite ));


For some reason we do not do this in MLS policy.  Does anyone know why
we don't do this for MLS?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk1kI2MACgkQrlYvE4MpobOsEgCgu8Mf/oR+ZRrk9b8Fo13IbmDk
HFMAoIs5qMgEAmF1wpXEeND1VfT6WfIZ
=K41/
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
