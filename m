Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6QLWliq016517
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2013 17:32:47 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r6QLWgA4003086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2013 17:32:42 -0400
Message-ID: <51F2EAF8.2040201@redhat.com>
Date: Fri, 26 Jul 2013 17:32:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
CC: Steve Grubb <sgrubb@redhat.com>
Subject: Currently we handle adding audit records with semanage command in
 pocliycoreutils.
Content-Type: multipart/mixed;
 boundary="------------010802040207060807090901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010802040207060807090901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The problem is useradd is not calling libsemanage functions directly, this
patch moves the audit record calls into libsemanage.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHy6vgACgkQrlYvE4MpobNx1wCgyyRY7vs3HlQYpHVZAZUSIijq
p8cAniXvcKVQU3ahCiS9mAf+fM8oB+Zv
=9OtP
-----END PGP SIGNATURE-----

--------------010802040207060807090901
Content-Type: text/x-patch;
 name="0044-Move-handling-of-role-audit-messages-into-libsemanag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0044-Move-handling-of-role-audit-messages-into-libsemanag.pa";
 filename*1="tch"


--------------010802040207060807090901--
