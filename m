Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA2NE3jj005835
	for <selinux@tycho.nsa.gov>; Sat, 2 Nov 2013 19:14:05 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 146BC1A00F
	for <selinux@tycho.nsa.gov>; Sun,  3 Nov 2013 00:13:56 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
	by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id brLgJ6Oz16PZ for <selinux@tycho.nsa.gov>;
	Sun,  3 Nov 2013 00:13:51 +0100 (CET)
Received: from fornost.bigon.be (unknown [IPv6:2a02:578:85fc:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 414171A1A4
	for <selinux@tycho.nsa.gov>; Sun,  3 Nov 2013 00:13:51 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 2/2] src/libselinux.pc.in: Move -lpthread to Libs.private
Date: Sun,  3 Nov 2013 00:13:50 +0100
Message-Id: <1383434030-5853-2-git-send-email-bigon@debian.org>
In-Reply-To: <1383434030-5853-1-git-send-email-bigon@debian.org>
References: <1383434030-5853-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

Move -lpthread to Libs.private as libselinux is not exposing any of its
API
---
 libselinux/src/libselinux.pc.in | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.pc.in
index 2bd3c0e..f453c8f 100644
--- a/libselinux/src/libselinux.pc.in
+++ b/libselinux/src/libselinux.pc.in
@@ -8,5 +8,6 @@ Description: SELinux utility library
 Version: @VERSION@
 URL: http://userspace.selinuxproject.org/
 Requires.private: libsepol libpcre
-Libs: -L${libdir} -lselinux -lpthread
+Libs: -L${libdir} -lselinux
+Libs.private: -lpthread
 Cflags: -I${includedir}
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
