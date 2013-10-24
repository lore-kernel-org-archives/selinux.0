Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODmQbQ023759
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:48:26 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODmOYN020897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:48:24 -0400
Message-ID: <52692527.3000007@redhat.com>
Date: Thu, 24 Oct 2013 09:48:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 09/74] define SELINUX_TRANS_DIR in selinux.h
Content-Type: multipart/mixed;
 boundary="------------080403060708060503010806"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080403060708060503010806
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Future pass to mcstransd to allow libvirt to specify the names of selected MCS
Labels, which mcstransd can translate.  This patch adds an interface to allow
libvirt and mcstransd to communicate in the mcstransd /var/run directory.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJScACgkQrlYvE4MpobOC8gCcCBacFSzF4+Bll4PqAOQeEnRo
YWwAnisWknWIHjayevKuZjno6zes6FGE
=LtlM
-----END PGP SIGNATURE-----

--------------080403060708060503010806
Content-Type: text/x-patch;
 name="0009-define-SELINUX_TRANS_DIR-in-selinux.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0009-define-SELINUX_TRANS_DIR-in-selinux.h.patch"


--------------080403060708060503010806--
