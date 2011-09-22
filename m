Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8MJrQFk030387
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 15:53:26 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8MJrO1J026568
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 19:53:25 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8MJrOaZ005281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 15:53:24 -0400
Received: from [10.11.9.201] (vpn-9-201.rdu.redhat.com [10.11.9.201])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p8MJrN3M011138
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 15:53:24 -0400
Message-ID: <4E7B9233.6080609@redhat.com>
Date: Thu, 22 Sep 2011 15:53:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: I would like to change the behavior of MCS label creations in directory.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Currently if I create a directory labeled

etc_t:s0:c1

And with a process running as unconfined_t:s0-s0:c0.c1023 create a
file within the directory, the file gets created with the label
etc_t:s0.   I would like to change the behavior to creating the file
as etc_t:s0:c1.

That way an administrator could modify files within a sandbox and have
the files be labeled correctly.

I believe this behavior differs from MLS but believe this would be
what the admin expects.

Is changing this a kernel or policy issue?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk57kjMACgkQrlYvE4MpobO6GACgrZnzZl4OySYUkZATfl7RJPWb
z1YAn0m4wkHLWYWlR6urpuQ0tuGb+cdN
=uDm1
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
