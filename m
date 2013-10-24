Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OEwf2V031376
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:58:41 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OEwbmM014506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:58:37 -0400
Message-ID: <5269359C.8040104@redhat.com>
Date: Thu, 24 Oct 2013 10:58:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 49/74] Add customized calls for modules to list disabled
Content-Type: multipart/mixed;
 boundary="------------020706050706030003020703"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020706050706030003020703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch allows semanage module to list modules you disabled.  We use this
info when extracting customizations via semanage extract command, which can
then be used on a different platform.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpNZwACgkQrlYvE4MpobNwcwCfVrvkdrtafhUEVqdz+U7foXYS
LmsAoNFQd+qjDCK4oWBRCfujn0fq1XPf
=gdI+
-----END PGP SIGNATURE-----

--------------020706050706030003020703
Content-Type: text/x-patch;
 name="0049-Add-customized-calls-for-modules-to-list-disabled-mo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0049-Add-customized-calls-for-modules-to-list-disabled-mo.pa";
 filename*1="tch"


--------------020706050706030003020703--
