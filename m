Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFa3FT027620
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:36:03 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFa2Wq010494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:36:02 -0400
Message-ID: <4F71DE62.8040007@redhat.com>
Date: Tue, 27 Mar 2012 11:36:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 56/73] sepolgen: Make use of setools optional within sepolgen
Content-Type: multipart/mixed;
 boundary="------------010304090205050309060001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010304090205050309060001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

This will work because the try block will fire if setools is not
installed.  And the tool will work.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x3mIACgkQrlYvE4MpobNvJQCeLn+/HhND+fZLS2Z9GzAGgzFE
42cAoLQbtQtp41fm2mdVvCEXd23jTsdk
=jkIQ
-----END PGP SIGNATURE-----

--------------010304090205050309060001
Content-Type: text/x-patch;
 name="0056-sepolgen-Make-use-of-setools-optional-within-sepolge.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0056-sepolgen-Make-use-of-setools-optional-within-sepolge.pa";
 filename*1="tch"


--------------010304090205050309060001--
