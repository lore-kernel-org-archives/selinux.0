Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oB1E5dfM006917
	for <selinux@tycho.nsa.gov>; Wed, 1 Dec 2010 09:05:39 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oB1E5Vax026182
	for <selinux@tycho.nsa.gov>; Wed, 1 Dec 2010 14:05:32 GMT
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id oB1E5Vnj012118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 1 Dec 2010 09:05:31 -0500
Received: from localhost.localdomain (vpn-8-6.rdu.redhat.com [10.11.8.6])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id oB1E5Uto016185
	for <selinux@tycho.nsa.gov>; Wed, 1 Dec 2010 09:05:30 -0500
Message-ID: <4CF6562A.9090601@redhat.com>
Date: Wed, 01 Dec 2010 09:05:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: We have a problem with libselinux leaking memory using __thread
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

https://bugzilla.redhat.com/show_bug.cgi?id=658571
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkz2VioACgkQrlYvE4MpobO0twCfQcEujZ16btqXpSZ47PHtlWEj
SPgAn1FL7pEloh3dvrRJxegJ4srJ1uIx
=euLO
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
