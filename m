Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA17978
	for <selinux@tycho.nsa.gov>; Sat, 7 Dec 2002 08:23:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gB7DNdI09417
	for <selinux@tycho.nsa.gov>; Sat, 7 Dec 2002 13:23:39 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gB7DNbf09413 for <selinux@tycho.nsa.gov>; Sat, 7 Dec 2002 13:23:38 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 56A9E92668
	for <selinux@tycho.nsa.gov>; Sun,  8 Dec 2002 00:23:33 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6710470EB
	for <selinux@tycho.nsa.gov>; Sat,  7 Dec 2002 14:23:25 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: patch for warnings in test programs
Date: Sat, 7 Dec 2002 14:23:24 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_0V3REE449FM3FODCIJ5E"
Message-Id: <200212071423.24977.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_0V3REE449FM3FODCIJ5E
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

The attached patch fixes warnings with getsockname_secure() type functions.  
It's the old sockaddr_in vs sockaddr issue.

These aren't important warnings, however we should fix all warnings so that 
when something really goes wrong it'll be noticed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_0V3REE449FM3FODCIJ5E
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

--- selinux-small-2002102211.orig/libsecure/test/tcp_server.c
+++ selinux-small-2002102211/libsecure/test/tcp_server.c
@@ -84,7 +84,7 @@
 	/* Obtain the security context of the listening socket */
 	sin.sin_family = AF_INET;
 	sinlen = sizeof(struct sockaddr_in);
-	ret = getsockname_secure(s, &sin, &sinlen, &tmp_sid);
+	ret = getsockname_secure(s, (struct sockaddr *)&sin, &sinlen, &tmp_sid);
 	if (ret) {
 		perror("getsockname_secure");
 		exit(1);
@@ -139,7 +139,7 @@
 		       inet_ntoa(sin.sin_addr), ntohs(sin.sin_port), context);
 
 		/* Obtain the new connection socket security context */
-		ret = getsockname_secure(ctrl, &sin, &sinlen, &tmp_sid);
+		ret = getsockname_secure(ctrl, (struct sockaddr *)&sin, &sinlen, &tmp_sid);
 		if (ret) {
 			perror("getsockname_secure");
 			exit(1);
--- selinux-small-2002102211.orig/libsecure/test/udp_client.c
+++ selinux-small-2002102211/libsecure/test/udp_client.c
@@ -82,7 +82,7 @@
 	/* Obtain the security context of the server socket */
 	sin.sin_family = AF_INET;
 	sinlen = sizeof(struct sockaddr_in);
-	ret = getsockname_secure(s, &sin, &sinlen, &tmp_sid);
+	ret = getsockname_secure(s, (struct sockaddr *)&sin, &sinlen, &tmp_sid);
 	if (ret) {
 		perror("getsockname_secure");
 		exit(1);
--- selinux-small-2002102211.orig/libsecure/test/tcp_client.c
+++ selinux-small-2002102211/libsecure/test/tcp_client.c
@@ -80,7 +80,7 @@
 	/* Obtain the security context of the client socket */
 	sin.sin_family = AF_INET;
 	sinlen = sizeof(struct sockaddr_in);
-	ret = getsockname_secure(s, &sin, &sinlen, &tmp_sid);
+	ret = getsockname_secure(s, (struct sockaddr *)&sin, &sinlen, &tmp_sid);
 	if (ret) {
 		perror("getsockname_secure");
 		exit(1);
--- selinux-small-2002102211.orig/libsecure/test/unix_stream_server.c
+++ selinux-small-2002102211/libsecure/test/unix_stream_server.c
@@ -104,7 +104,7 @@
 	/* Obtain the security context of the listening socket */
 	sun.sun_family = AF_UNIX;
 	sunlen = sizeof(struct sockaddr_un);
-	ret = getsockname_secure(s, &sun, &sunlen, &tmp_sid);
+	ret = getsockname_secure(s, (struct sockaddr *)&sun, &sunlen, &tmp_sid);
 	if (ret) {
 		perror("getsockname_secure");
 		exit(1);
@@ -172,7 +172,7 @@
 
 		/* Obtain the new connection socket security context */
 		sunlen = sizeof(struct sockaddr_un);
-		ret = getsockname_secure(ctrl, &sun, &sunlen, &tmp_sid);
+		ret = getsockname_secure(ctrl, (struct sockaddr *)&sun, &sunlen, &tmp_sid);
 		if (ret) {
 			perror("getsockname_secure");
 			CLEANUP_AND_EXIT;
--- selinux-small-2002102211.orig/libsecure/test/unix_dgram_server.c
+++ selinux-small-2002102211/libsecure/test/unix_dgram_server.c
@@ -104,7 +104,7 @@
 	/* Obtain the security context of the server socket */
 	sun.sun_family = AF_UNIX;
 	sunlen = sizeof(struct sockaddr_un);
-	ret = getsockname_secure(s, &sun, &sunlen, &tmp_sid);
+	ret = getsockname_secure(s, (struct sockaddr *)&sun, &sunlen, &tmp_sid);
 	if (ret) {
 		perror("getsockname_secure");
 		exit(1);
@@ -170,7 +170,7 @@
 					     &peer_sid, &msg_sid);
 			sunlen = msg.msg_namelen;
 		} else {
-			ret = recvfrom_secure(s, buf, sizeof(buf), 0, 
+			ret = recvfrom_secure(s, (void *)buf, sizeof(buf), 0, 
 					      (struct sockaddr*)&sun, &sunlen,
 					      &peer_sid, &msg_sid);
 		}
--- selinux-small-2002102211.orig/libsecure/test/unix_stream_client.c
+++ selinux-small-2002102211/libsecure/test/unix_stream_client.c
@@ -96,7 +96,7 @@
 	/* Obtain the security context of the client socket */
 	sun.sun_family = AF_UNIX;
 	sunlen = sizeof(struct sockaddr_un);
-	ret = getsockname_secure(s, &sun, &sunlen, &tmp_sid);
+	ret = getsockname_secure(s, (struct sockaddr *)&sun, &sunlen, &tmp_sid);
 	if (ret) {
 		perror("getsockname_secure");
 		exit(1);
--- selinux-small-2002102211.orig/libsecure/test/udp_server.c
+++ selinux-small-2002102211/libsecure/test/udp_server.c
@@ -78,7 +78,7 @@
 	/* Obtain the security context of the server socket */
 	sin.sin_family = AF_INET;
 	sinlen = sizeof(struct sockaddr_in);
-	ret = getsockname_secure(s, &sin, &sinlen, &tmp_sid);
+	ret = getsockname_secure(s, (struct sockaddr *)&sin, &sinlen, &tmp_sid);
 	if (ret) {
 		perror("getsockname_secure");
 		exit(1);

--------------Boundary-00=_0V3REE449FM3FODCIJ5E--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
