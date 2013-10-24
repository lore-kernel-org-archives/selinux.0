Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OE231l025635
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:02:03 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OE2076014941
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:02:01 -0400
Message-ID: <52692857.7080801@redhat.com>
Date: Thu, 24 Oct 2013 10:01:59 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 21/74] Remove the policy.kern after policy is build and
Content-Type: multipart/mixed;
 boundary="------------030408040200030304020106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030408040200030304020106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We are trying to shrink the size of SELinux on small platforms like cloud
images,  THis patch removes the policy.kern file after compile replacing it
with a link.  Some parts of libsemanage still want to read the policy.kern
file because this is the only way to guarantee the last built policy.
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpKFcACgkQrlYvE4MpobPM/ACgk1tOADZClDfT1jt1t0omAElJ
WVQAni6gX/105cQbGti9DlEP6Tabx2bc
=JnPX
-----END PGP SIGNATURE-----

--------------030408040200030304020106
Content-Type: text/x-patch;
 name="0021-Remove-the-policy.kern-after-policy-is-build-and-rep.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0021-Remove-the-policy.kern-after-policy-is-build-and-rep.pa";
 filename*1="tch"


--------------030408040200030304020106--
