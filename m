Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0TF3nV7010501
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 10:03:49 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0TF3mtk022119
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 15:03:48 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m0TF3mOl018621
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 10:03:48 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0TF3ktH017888
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 10:03:47 -0500
Received: from localhost.localdomain (vpn-248-50.boston.redhat.com [10.13.248.50])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m0TF3kdo005243
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 10:03:46 -0500
Message-ID: <479F4051.7030101@redhat.com>
Date: Tue, 29 Jan 2008 10:03:45 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: genhomedircon is broken in libsemanage
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adding

mythtv:x:1004:1004::/var/lib/mythtv:/bin/bash

To /etc/passwd causes the labeling to get all screwed up.  This would
report an error when we used the python version of genhomedircon and not
foul up the labeling by checking if there was a label for /var/lib
already in the file_context file. (Boy do I love python.  :^))

https://bugzilla.redhat.com/show_bug.cgi?id=430195

Dan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkefQFEACgkQrlYvE4MpobOQ+ACgochR6fDi53bJva3/g7+QaM9p
DJwAoN4LZp7Z3+frZj+kekxbCEJblzbw
=0p5A
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
