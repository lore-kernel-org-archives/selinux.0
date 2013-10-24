Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODxgs8024935
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:59:42 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODxXIx023405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:59:33 -0400
Message-ID: <526927C4.2060300@redhat.com>
Date: Thu, 24 Oct 2013 09:59:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 20/74] Add Laurent Bigonville fix to look at MAX_UID as well
Content-Type: multipart/mixed;
 boundary="------------060305050206080708070204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060305050206080708070204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJ8QACgkQrlYvE4MpobOurgCguoVDteb2Iked2CBpfYtAm638
SIgAnRyiZ9NfbGjwWObZr19XHokByiGD
=hdK8
-----END PGP SIGNATURE-----

--------------060305050206080708070204
Content-Type: text/x-patch;
 name="0020-Add-Laurent-Bigonville-fix-to-look-at-MAX_UID-as-wel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0020-Add-Laurent-Bigonville-fix-to-look-at-MAX_UID-as-wel.pa";
 filename*1="tch"


--------------060305050206080708070204--
