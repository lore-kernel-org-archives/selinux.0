Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFPx10026599
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:25:59 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFPwSG019592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:25:58 -0400
Message-ID: <4F71DC06.7010500@redhat.com>
Date: Tue, 27 Mar 2012 11:25:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 38/73] policycoreutils: setfiles: If you are not changing
 any
Content-Type: multipart/mixed;
 boundary="------------040402000705040207010304"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040402000705040207010304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

Basically this change stops sysloging if the change did not actually
happen.

By default we do not modify a label if only the user component of the
SELinux context had changed, but were were sending a syslog messages
as if something had changed.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x3AYACgkQrlYvE4MpobOJgQCg6j4oYbZwE7yG94ViPj3Ul6wY
hUcAoOTnwAiOCOhTLE55fZhHjGTGoBvI
=tpWp
-----END PGP SIGNATURE-----

--------------040402000705040207010304
Content-Type: text/x-patch;
 name="0038-policycoreutils-setfiles-If-you-are-not-changing-any.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0038-policycoreutils-setfiles-If-you-are-not-changing-any.pa";
 filename*1="tch"


--------------040402000705040207010304--
