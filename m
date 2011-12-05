Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB5JUKIW000321
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2011 14:30:21 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pB5JUK9F011015
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2011 19:30:20 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pB5JUJT0030248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2011 14:30:19 -0500
Message-ID: <4EDD1BCA.1060502@redhat.com>
Date: Mon, 05 Dec 2011 14:30:18 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 21/48] checkpolicy: dis* fixed signed vs unsigned errors
Content-Type: multipart/mixed;
 boundary="------------090009030809090500070700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090009030809090500070700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7dG8oACgkQrlYvE4MpobMMQgCgmAarqPUYaCsnuKbz7q/Gv1j/
OwUAoOsSdeMCa0vhqBbT/gfzz17aQUai
=Bqzc
-----END PGP SIGNATURE-----

--------------090009030809090500070700
Content-Type: text/plain;
 name="0021-checkpolicy-dis-fixed-signed-vs-unsigned-errors.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0021-checkpolicy-dis-fixed-signed-vs-unsigned-errors.patch"


--------------090009030809090500070700--
