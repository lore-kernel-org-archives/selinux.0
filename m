Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODuE7t024560
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:56:14 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODuBAt011902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:56:11 -0400
Message-ID: <526926FA.1080100@redhat.com>
Date: Thu, 24 Oct 2013 09:56:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 15/74] Add selinux_current_policy_path
Content-Type: multipart/mixed;
 boundary="------------010603090201010008060905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010603090201010008060905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The idea of this patch is to allow tools like setroubleshoot, sepolicy and
audit2allow to examine the current running policy on a system then to search
for a potentially different policy in /etc/selinux/POLICYTYPE/policy/policy.*
file.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJvoACgkQrlYvE4MpobMknwCcCogVBxy8MenTHX6cvNDAUsHB
VggAoMrHb1sLNTBi5GEOp4DoLRxksNpk
=icuA
-----END PGP SIGNATURE-----

--------------010603090201010008060905
Content-Type: text/x-patch;
 name="0015-Add-selinux_current_policy_path-which-returns-the-a-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0015-Add-selinux_current_policy_path-which-returns-the-a-.pa";
 filename*1="tch"


--------------010603090201010008060905--
