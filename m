Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2NAR6Rb028555
	for <selinux@tycho.nsa.gov>; Tue, 23 Mar 2004 05:27:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2NAPGdQ014137
	for <selinux@tycho.nsa.gov>; Tue, 23 Mar 2004 10:25:16 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i2NAOwBL014080
	for <selinux@tycho.nsa.gov>; Tue, 23 Mar 2004 10:25:15 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id A5B3861BC5
	for <selinux@tycho.nsa.gov>; Tue, 23 Mar 2004 21:25:24 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 29920-03 for <selinux@tycho.nsa.gov>;
	Tue, 23 Mar 2004 21:25:24 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 460B761BBE
	for <selinux@tycho.nsa.gov>; Tue, 23 Mar 2004 21:25:24 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 3B7912F5CA
	for <selinux@tycho.nsa.gov>; Tue, 23 Mar 2004 21:25:22 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: patch for libselinux1
Date: Tue, 23 Mar 2004 21:25:21 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RCBYAvd0Tucp/ai"
Message-Id: <200403232125.21252.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_RCBYAvd0Tucp/ai
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

If you do "mount selinuxfs /selinux -t selinuxfs" then things don't work, it 
sees the first "selinuxfs" in /proc/mounts and then takes the last string 
from the previous line as the mount point.

I have attached a patch.

It's not a significant issue for Fedora at the moment as no-one will be 
mounting /selinux by hand (I hope).  But it's already become an issue for 
Debian (I've uploaded a fixed package to Debian already).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_RCBYAvd0Tucp/ai
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- libselinux-1.8.orig/src/init.c
+++ libselinux-1.8/src/init.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <ctype.h>
 #include <asm/page.h>
+#include <stdio.h>
 
 char *selinux_mnt = NULL;
 
@@ -15,14 +16,14 @@
 {
 	char *buf, *p;
 	size_t size;
-	int fd;
+	FILE *fp;
 	ssize_t ret;
 
 	if (selinux_mnt)
 		return;
 
-	fd = open("/proc/mounts", O_RDONLY);
-	if (fd < 0)
+	fp = fopen("/proc/mounts", "r");
+	if (!fp)
 		return;
 
 	size = PAGE_SIZE;
@@ -32,30 +33,27 @@
 		
 	memset(buf, 0, size);
 
-	ret = read(fd, buf, size - 1);
-	if (ret < 0)
-		goto out2;
-
-	p = strstr(buf, "selinuxfs");
-	if (!p)
-		goto out2;
-
-	p--;
-	*p = 0;
-	p--;
-
-	while (p > buf && !isspace(*p))
-		p--;
-
-	if (isspace(*p))
-		p++;
+	while(fgets(buf, size - 1, fp))
+	{
+		char *tmp;
+		p = strchr(buf, ' ');
+		if(p)
+		{
+			p++;
+			tmp = strchr(p, ' ');
+		}
+		if(tmp && !strncmp(tmp + 1, "selinuxfs ", 10))
+		{
+			*tmp = '\0';
+		}
+	}
 
 	selinux_mnt = strdup(p);
 
 out2:
 	free(buf);
 out:
-	close(fd);
+	fclose(fp);
 	return;
 
 }

--Boundary-00=_RCBYAvd0Tucp/ai--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
