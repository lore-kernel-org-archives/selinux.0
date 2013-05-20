Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4KGGJRU007680
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2013 12:16:23 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Requires libpcre and libpthread for static linking
Date: Mon, 20 May 2013 18:16:11 +0200
Message-Id: <1369066571-12452-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 libselinux/src/libselinux.pc.in | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/libselinux.pc.in
index 5691559..f453c8f 100644
--- a/libselinux/src/libselinux.pc.in
+++ b/libselinux/src/libselinux.pc.in
@@ -7,6 +7,7 @@ Name: libselinux
 Description: SELinux utility library
 Version: @VERSION@
 URL: http://userspace.selinuxproject.org/
-Requires.private: libsepol
+Requires.private: libsepol libpcre
 Libs: -L${libdir} -lselinux
+Libs.private: -lpthread
 Cflags: -I${includedir}
-- 
1.8.3.rc2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
