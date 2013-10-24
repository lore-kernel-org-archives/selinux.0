Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9ODskH7024432
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:54:46 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9ODsjDx002696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:54:45 -0400
Message-ID: <526926A4.3040205@redhat.com>
Date: Thu, 24 Oct 2013 09:54:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 14/74] Change get_context_list to return an error rather then
Content-Type: multipart/mixed;
 boundary="------------000200070809040106070403"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000200070809040106070403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

In the past pam_selinux would return a bogus login context if the login program
was running with the wrong context.  If you ran sshd as unconfined_t
you might get the login user loggin in as pam_oddjob_mkhomedir_t or some other
bogus
type.  This change fixes the code to return an error if it can not return a good
match.

   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpJqQACgkQrlYvE4MpobOkmQCdGD2YBvJx1vg0VkNgsyni6Y4F
WwgAoKAicAI1nPrReds9DLJkSkamj10X
=YR4U
-----END PGP SIGNATURE-----

--------------000200070809040106070403
Content-Type: text/x-patch;
 name="0014-Change-get_context_list-to-return-an-error-rather-th.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0014-Change-get_context_list-to-return-an-error-rather-th.pa";
 filename*1="tch"


--------------000200070809040106070403--
