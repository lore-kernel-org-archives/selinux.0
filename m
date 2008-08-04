Received: from [144.51.25.121] (moss-spartans [144.51.25.121])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74Gx5R6000782
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:59:05 -0400
Subject: [patch] libselinux:  make setrans socket descriptor close-on-exec
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 04 Aug 2008 12:59:05 -0400
Message-Id: <1217869145.20067.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ensure that the setrans socket descriptor is marked close-on-exec.
If supported, use the new SOCK_CLOEXEC flag when the socket is created,
as per:
http://udrepper.livejournal.com/20407.html
Otherwise fall back to using fcntl after the socket has been created.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

Index: trunk/libselinux/src/setrans_client.c
===================================================================
--- trunk/libselinux/src/setrans_client.c	(revision 2936)
+++ trunk/libselinux/src/setrans_client.c	(working copy)
@@ -13,7 +13,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <netdb.h>
-
+#include <fcntl.h>
 #include <stdio.h>
 #include <string.h>
 #include <ctype.h>
@@ -42,11 +42,17 @@
 {
 	struct sockaddr_un addr;
 	int fd;
-
-	fd = socket(PF_UNIX, SOCK_STREAM, 0);
-	if (fd < 0) {
+#ifdef SOCK_CLOEXEC
+	fd = socket(PF_UNIX, SOCK_STREAM|SOCK_CLOEXEC, 0);
+	if (fd < 0 && errno == EINVAL)
+#endif
+	{
+		fd = socket(PF_UNIX, SOCK_STREAM, 0);
+		if (fd >= 0)
+			fcntl(fd, F_SETFD, FD_CLOEXEC);
+	}
+	if (fd < 0)
 		return -1;
-	}
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_UNIX;


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
