Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4NF7uQG015175
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 11:07:56 -0400
Received: from kakou.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4NF7s9T025856
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 15:07:55 GMT
Message-ID: <447326FC.7040103@kakou.org>
Date: Tue, 23 May 2006 17:15:08 +0200
From: kakou <kakou@kakou.org>
Reply-To: kakou@kakou.org
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Problem with libselinux
Content-Type: text/plain; charset=ISO-8859-15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

It looks that libselinux is not synchronized with the kernel.
Indeed, the av_perm_to_string.h, av_permissions.h and av_inherit.h are
from libselinux smaller than the version in current kernel (2.6.16).
For example my version of libselinux do not recognize "name_connect"
permission

It's a problem with my distrib (gentoo) ?

I use libselinux-1.30 and I have tried with libselinux from cvs.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEcyb53RS+hG/PB/URAtctAKCRA+1nuN3kbYNdvAPPfNRw4ACiZwCeOhrF
HbX6lyyZuCOH1wPusx4GbzY=
=UCGi
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
