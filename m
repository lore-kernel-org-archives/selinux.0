Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFJJ5B025877
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:19:19 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFJHuP004514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:19:17 -0400
Message-ID: <4F71DA74.1070402@redhat.com>
Date: Tue, 27 Mar 2012 11:19:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 32/73] policycoreutils: semanage: Change semanage to produce
Content-Type: multipart/mixed;
 boundary="------------040102040901070700070802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040102040901070700070802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

semanage command was not reporting proper audit messages for the LSPP
certification.  Needed to report additional information such as prior
roles before and after update. Many other changes, were reviewed by
Steve Grubb to make sure were were doing proper auditing.


Should be reporting AUDIT_ROLE_ASSIGN instead of AUDIT_USER_ROLE_CHANGE.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x2nQACgkQrlYvE4MpobOzbgCg1POO+mdPJOCl7Puq29nbdyjR
FakAn1VahZWD/ej9soH55bxiuQsWkqX4
=OyPJ
-----END PGP SIGNATURE-----

--------------040102040901070700070802
Content-Type: text/x-patch;
 name="0032-policycoreutils-semanage-Change-semanage-to-produce-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0032-policycoreutils-semanage-Change-semanage-to-produce-.pa";
 filename*1="tch"


--------------040102040901070700070802--
