Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OFAXMd000911
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:10:37 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OFAICk010215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:10:21 -0400
Message-ID: <52693858.3090906@redhat.com>
Date: Thu, 24 Oct 2013 11:10:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 66/74] Make setsebool be less verbose.
Content-Type: multipart/mixed;
 boundary="------------080904060402030504040003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080904060402030504040003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

These two patches cleanup setsebool error reporting.

This is what we currently get if user mispells boolean name.

# setsebool -P spacewalk_nfs_mountpointttt on
Actual results:
libsemanage.dbase_llist_set: record not found in the database (No such file or
directory).
libsemanage.dbase_llist_set: could not set record value (No such file or
directory).
Could not change boolean spacewalk_nfs_mountpointttt
Could not change policy booleans

Now we get

# setsebool -P spacewalk_nfs_mountpointttt on
Boolean spacewalk_nfs_mountpointttt is not defined


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpOFgACgkQrlYvE4MpobP5uACgrFgNyhHvGYPFlJ/ZFQZKG4B5
TngAnAzC6zN3zsJPmVDcGqlXhHwdpHZF
=3lSr
-----END PGP SIGNATURE-----

--------------080904060402030504040003
Content-Type: text/x-patch;
 name="0066-Make-setsebool-be-less-verbose.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0066-Make-setsebool-be-less-verbose.patch"


--------------080904060402030504040003--
