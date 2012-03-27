Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFcBLO027943
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:38:11 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFc9Cp005732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:38:09 -0400
Message-ID: <4F71DEE1.8060001@redhat.com>
Date: Tue, 27 Mar 2012 11:38:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 62/73] libsemanage -- Do not link against libpython
Content-Type: multipart/mixed;
 boundary="------------060401010708080206010606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060401010708080206010606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x3uEACgkQrlYvE4MpobPrUACgxgTLhub8pwXXW60BuzF16DoI
nloAoNYSHRED5MNq46wU4crieK8HPyHc
=vTXA
-----END PGP SIGNATURE-----

--------------060401010708080206010606
Content-Type: text/x-patch;
 name="0062-libsemanage-Do-not-link-against-libpython-this-is-co.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0062-libsemanage-Do-not-link-against-libpython-this-is-co.pa";
 filename*1="tch"


--------------060401010708080206010606--
