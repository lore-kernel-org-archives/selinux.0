Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9SJj2WY012985
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:45:02 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9SJi0fk029566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2013 15:44:00 -0400
Message-ID: <526EBE7E.5080706@redhat.com>
Date: Mon, 28 Oct 2013 15:43:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 02/17] Catch IOError errors within audit2allow
Content-Type: multipart/mixed;
 boundary="------------000205010603000802010003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000205010603000802010003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Simple patch to catch IOError within audit2allow.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJuvn4ACgkQrlYvE4MpobM2ogCgt32aY0fs3tx2UFZn6NLOBNQp
CQIAoJ1GA1lzf2wg+e5WnTLJzONbfLp1
=qW+4
-----END PGP SIGNATURE-----

--------------000205010603000802010003
Content-Type: text/x-patch;
 name="0002-Catch-IOError-errors-within-audit2allow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-Catch-IOError-errors-within-audit2allow.patch"


--------------000205010603000802010003--
