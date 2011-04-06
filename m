Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p36LAvXi008430
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 17:10:57 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p36LAuN6023644
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 21:10:57 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p36LAu5p011522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 17:10:56 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p36LAtrg023756
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 17:10:56 -0400
Message-ID: <4D9CD6DF.2020005@redhat.com>
Date: Wed, 06 Apr 2011 17:10:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: This patch causes the mount points created in load_policy to have
 a proper name
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

"proc" and "selinuxfs"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2c1t8ACgkQrlYvE4MpobMdVwCg1FGxyVFbuoiresvyLPdVD3t5
d/cAnA9hlnt4KDUn03YfaSIVng6Gf4ay
=iL0A
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
