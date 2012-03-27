Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFhf58028707
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:43:41 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFhecB012554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:43:40 -0400
Message-ID: <4F71E02B.5060408@redhat.com>
Date: Tue, 27 Mar 2012 11:43:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 71/73] libselinux -- Do not link against python library
Content-Type: multipart/mixed;
 boundary="------------080806060607060306020906"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080806060607060306020906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x4CsACgkQrlYvE4MpobMbEACff/stSNJNrmCgTh5Ts8JhnTjc
9z8AoOD4rq72pV8TJQoKEEVRAbpWqzoQ
=61Qt
-----END PGP SIGNATURE-----

--------------080806060607060306020906
Content-Type: text/x-patch;
 name="0071-libselinux-Do-not-link-against-python-library-this-i.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0071-libselinux-Do-not-link-against-python-library-this-i.pa";
 filename*1="tch"


--------------080806060607060306020906--
