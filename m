Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2NDsiRb029607
	for <selinux@tycho.nsa.gov>; Tue, 23 Mar 2004 08:54:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2NDqbdQ024563
	for <selinux@tycho.nsa.gov>; Tue, 23 Mar 2004 13:52:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i2NDqbBL024560
	for <selinux@tycho.nsa.gov>; Tue, 23 Mar 2004 13:52:37 GMT
Subject: Re: patch for libselinux1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200403232125.21252.russell@coker.com.au>
References: <200403232125.21252.russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-BVCkxAffJnIexrtQMhKt"
Message-Id: <1080050046.30176.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 23 Mar 2004 08:54:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BVCkxAffJnIexrtQMhKt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-03-23 at 05:25, Russell Coker wrote:
> If you do "mount selinuxfs /selinux -t selinuxfs" then things don't work, it 
> sees the first "selinuxfs" in /proc/mounts and then takes the last string 
> from the previous line as the mount point.
> 
> I have attached a patch.
> 
> It's not a significant issue for Fedora at the moment as no-one will be 
> mounting /selinux by hand (I hope).  But it's already become an issue for 
> Debian (I've uploaded a fixed package to Debian already).

Your patch has a few bugs in it.  How about this one instead?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-BVCkxAffJnIexrtQMhKt
Content-Disposition: attachment; filename=libselinux.diff
Content-Type: text/x-patch; name=libselinux.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/init.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/init.c,v
retrieving revision 1.3
diff -u -r1.3 init.c
--- libselinux/src/init.c	18 Dec 2003 17:33:47 -0000	1.3
+++ libselinux/src/init.c	23 Mar 2004 13:52:35 -0000
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <ctype.h>
 #include <asm/page.h>
+#include <stdio.h>
 
 char *selinux_mnt = NULL;
 
@@ -13,16 +14,15 @@
 
 static void init_selinuxmnt(void)
 {
-	char *buf, *p;
+	char *buf, *bufp, *p;
 	size_t size;
-	int fd;
-	ssize_t ret;
+	FILE *fp;
 
 	if (selinux_mnt)
 		return;
 
-	fd = open("/proc/mounts", O_RDONLY);
-	if (fd < 0)
+	fp = fopen("/proc/mounts", "r");
+	if (!fp)
 		return;
 
 	size = PAGE_SIZE;
@@ -32,30 +32,31 @@
 		
 	memset(buf, 0, size);
 
-	ret = read(fd, buf, size - 1);
-	if (ret < 0)
-		goto out2;
+	while(( bufp = fgets(buf, size, fp)))
+	{
+		char *tmp;
+		p = strchr(buf, ' ');
+		if (!p)
+			goto out2;
+		p++;
+		tmp = strchr(p, ' ');
+		if (!tmp)
+			goto out2;
+		if(!strncmp(tmp + 1, "selinuxfs ", 10)) {
+			*tmp = '\0';
+			break;
+		}
+	}
 
-	p = strstr(buf, "selinuxfs");
-	if (!p)
+	if (!bufp)
 		goto out2;
 
-	p--;
-	*p = 0;
-	p--;
-
-	while (p > buf && !isspace(*p))
-		p--;
-
-	if (isspace(*p))
-		p++;
-
 	selinux_mnt = strdup(p);
 
 out2:
 	free(buf);
 out:
-	close(fd);
+	fclose(fp);
 	return;
 
 }

--=-BVCkxAffJnIexrtQMhKt--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
