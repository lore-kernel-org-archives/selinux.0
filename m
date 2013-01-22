Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MEd42V011206
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:39:04 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0MEd2rm028624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 09:39:02 -0500
Message-ID: <50FEA485.40009@redhat.com>
Date: Tue, 22 Jan 2013 09:39:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 18/84] libsemanage: FIME binary_policy_path error checking
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

man asprintf says

       When  successful,  these  functions return the number of bytes printed,
       just like sprintf(3).  If memory allocation wasn't  possible,  or  some
       other error occurs, these functions will return -1, and the contents of
       strp is undefined.



So checking for != 0 is wrong, I guess we should be check > -1;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+pIUACgkQrlYvE4MpobPuxgCdHZdPKVhN8aQFm4w+7KMpQKDl
EhIAmQGoiTZiaZ41zehFBisd5THvEmkN
=nqot
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
