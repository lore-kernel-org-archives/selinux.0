Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1MFlIJO032554
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 10:47:18 -0500
Received: from web51503.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1MFmaTj022255
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 15:48:36 GMT
Date: Thu, 22 Feb 2007 07:48:35 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: libselinux patch
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1172153417.14363.360.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1439561621-1172159315=:5368"
Message-ID: <451748.5368.qm@web51503.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1439561621-1172159315=:5368
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

OK, I think the attached patch does _everything _ we discussed. It:

- removes 8 syscalls for the normal path
- ensures /selinux is trully an selinuxfs
- drops back to detecting the old way when /selinux is missing
- changes the old way in is_enabled to use fopen for glibc internal retries
- adds retry for EINTR in mls_enabled
- keeps SELINUX_MAGIC private

Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>



 
____________________________________________________________________________________
Cheap talk?
Check out Yahoo! Messenger's low PC-to-Phone call rates.
http://voice.yahoo.com
--0-1439561621-1172159315=:5368
Content-Type: text/x-patch; name="libselinux-2.0.0-enabled.patch"
Content-Description: 3974351640-libselinux-2.0.0-enabled.patch
Content-Disposition: inline; filename="libselinux-2.0.0-enabled.patch"

diff -urp libselinux-2.0.0.orig/src/enabled.c libselinux-2.0.0/src/enabled.c
--- libselinux-2.0.0.orig/src/enabled.c	2007-02-19 20:57:53.000000000 -0500
+++ libselinux-2.0.0/src/enabled.c	2007-02-22 10:26:02.000000000 -0500
@@ -10,15 +10,33 @@
 
 int is_selinux_enabled(void)
 {
-	char *buf;
+	char *buf, *bufp;
 	size_t size;
-	int fd;
+	FILE *fp;
 	ssize_t ret;
-	int enabled = 0;
+	int rc, enabled = 0;
 	security_context_t con;
 
-	fd = open("/proc/filesystems", O_RDONLY);
-	if (fd < 0)
+	/* init_selinuxmnt() gets called before this function. We
+ 	 * will assume that if a selinux file system is mounted, then
+ 	 * selinux is enabled. */
+	if (selinux_mnt) {
+
+		/* Since a file system is mounted, we consider selinux
+		 * enabled. If getcon_raw fails, selinux is still enabled.
+		 * We only consider it disabled if no policy is loaded. */
+		enabled = 1;
+		if (getcon_raw(&con) == 0) {
+			if (!strcmp(con, "kernel"))
+				enabled = 0;
+			freecon(con);
+		}
+		return enabled;
+        }
+
+	/* Drop back to detecting it the long way. */
+	fp = fopen("/proc/filesystems", "r");
+	if (!fp)
 		return -1;
 
 	size = selinux_page_size;
@@ -30,17 +48,19 @@ int is_selinux_enabled(void)
 
 	memset(buf, 0, size);
 
-	ret = read(fd, buf, size - 1);
-	if (ret < 0) {
-		enabled = -1;
-		goto out2;
+	while ((bufp = fgets_unlocked(buf, size, fp))) {
+		if (strstr(buf, "selinuxfs")) {
+			enabled = 1;
+			break;
+		}
 	}
 
-	if (!strstr(buf, "selinuxfs"))
+	if (!bufp)
 		goto out2;
 
-	enabled = 1;
-
+	/* Since an selinux file system is available, we consider
+	 * selinux enabled. If getcon_raw fails, selinux is still
+	 * enabled. We only consider it disabled if no policy is loaded. */
 	if (getcon_raw(&con) == 0) {
 		if (!strcmp(con, "kernel"))
 			enabled = 0;
@@ -49,7 +69,7 @@ int is_selinux_enabled(void)
       out2:
 	free(buf);
       out:
-	close(fd);
+	fclose(fp);
 	return enabled;
 }
 
@@ -75,7 +95,9 @@ int is_selinux_mls_enabled(void)
 
 	memset(buf, 0, sizeof buf);
 
-	ret = read(fd, buf, sizeof buf - 1);
+	do {
+		ret = read(fd, buf, sizeof buf - 1);
+	} while (ret < 0 && errno == EINTR);
 	close(fd);
 	if (ret < 0)
 		return enabled;
diff -urp libselinux-2.0.0.orig/src/init.c libselinux-2.0.0/src/init.c
--- libselinux-2.0.0.orig/src/init.c	2007-02-19 20:57:53.000000000 -0500
+++ libselinux-2.0.0/src/init.c	2007-02-22 10:25:04.000000000 -0500
@@ -6,7 +6,8 @@
 #include <ctype.h>
 #include <stdio.h>
 #include <dlfcn.h>
-#include <unistd.h>
+#include <sys/vfs.h>
+#include <stdint.h>
 
 #include "dso.h"
 #include "policy.h"
@@ -21,10 +22,22 @@ static void init_selinuxmnt(void)
 	char *buf, *bufp, *p;
 	size_t size;
 	FILE *fp;
+	struct statfs sfbuf;
+	int rc;
 
 	if (selinux_mnt)
 		return;
 
+	do {
+		rc = statfs(SELINUXMNT, &sfbuf);
+	} while (rc < 0 && errno == EINTR);
+	if (rc == 0) {
+		if ((uint32_t)sfbuf.f_type == (uint32_t)SELINUX_MAGIC) {
+			selinux_mnt = strdup(SELINUXMNT);
+			return;
+		}
+	}
+
 	fp = fopen("/proc/mounts", "r");
 	if (!fp)
 		return;
@@ -62,7 +75,6 @@ static void init_selinuxmnt(void)
       out:
 	fclose(fp);
 	return;
-
 }
 
 static void fini_selinuxmnt(void)
diff -urp libselinux-2.0.0.orig/src/load_policy.c libselinux-2.0.0/src/load_policy.c
--- libselinux-2.0.0.orig/src/load_policy.c	2007-02-19 20:57:53.000000000 -0500
+++ libselinux-2.0.0/src/load_policy.c	2007-02-22 10:23:42.000000000 -0500
@@ -165,7 +165,6 @@ hidden_def(selinux_mkload_policy)
  * We only need the hardcoded definition for the initial mount 
  * required for the initial policy load.
  */
-#define SELINUXMNT "/selinux/"
 int selinux_init_load_policy(int *enforce)
 {
 	int rc = 0, orig_enforce = 0, seconfig = -2, secmdline = -1;
diff -urp libselinux-2.0.0.orig/src/policy.h libselinux-2.0.0/src/policy.h
--- libselinux-2.0.0.orig/src/policy.h	2007-02-19 20:57:53.000000000 -0500
+++ libselinux-2.0.0/src/policy.h	2007-02-22 10:23:42.000000000 -0500
@@ -9,6 +9,12 @@
 /* Initial length guess for getting contexts. */
 #define INITCONTEXTLEN 255
 
+/* selinuxfs magic number */
+#define SELINUX_MAGIC 0xf97cff8c
+
+/* Preferred selinux mount location */
+#define SELINUXMNT "/selinux"
+
 /* selinuxfs mount point */
 extern char *selinux_mnt;
 

--0-1439561621-1172159315=:5368--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
