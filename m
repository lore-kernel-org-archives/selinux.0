Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FJiLe7020347
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:44:21 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FJiKHA016948
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 19:44:20 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8FJiDxU026210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:44:13 -0400
Message-ID: <4E72558D.4080908@redhat.com>
Date: Thu, 15 Sep 2011 15:44:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 34/67] policycoreutils: sandbox: FIXME do not bind mount so
Content-Type: multipart/mixed;
 boundary="------------010309060004060008070102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010309060004060008070102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

pam_namespace and sandbox both do the bind mounts internally now.  No
reason to force this on everyone.  Hopefully the sandbox init script
will be disappearing with systemd doing this by default.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5yVYwACgkQrlYvE4MpobMk0wCfX1XvN0N5XF8FKniNiH+h4763
VNoAoIheFq+CdghKZwWTlfGFW0qPkR+s
=9n8c
-----END PGP SIGNATURE-----

--------------010309060004060008070102
Content-Type: text/plain;
 name="0034-policycoreutils-sandbox-FIXME-do-not-bind-mount-so-m.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0034-policycoreutils-sandbox-FIXME-do-not-bind-mount-so-m.pa";
 filename*1="tch"


--------------010309060004060008070102--
