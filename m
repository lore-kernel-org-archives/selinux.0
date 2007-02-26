Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QGdrjG010220
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 11:39:54 -0500
Received: from web51502.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1QGfEW2010453
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 16:41:14 GMT
Date: Mon, 26 Feb 2007 08:40:43 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: libselinux patch
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1172263502.19041.136.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1258304701-1172508043=:76802"
Message-ID: <796000.76802.qm@web51502.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1258304701-1172508043=:76802
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline


OK, I think the attached patch does _everything _ we discussed. It:
 
 - removes 8 syscalls for the normal path
 - ensures /selinux is trully an selinuxfs
 - drops back to detecting the old way when /selinux is missing
 - changes the old way in is_enabled to use fopen & getline for glibc internal
retries
 - adds retry for EINTR in mls_enabled
 - keeps SELINUX_MAGIC private
 
 Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>


 
____________________________________________________________________________________
Now that's room service!  Choose from over 150,000 hotels
in 45,000 destinations on Yahoo! Travel to find your fit.
http://farechase.yahoo.com/promo-generic-14795097
--0-1258304701-1172508043=:76802
Content-Type: text/x-patch; name="libselinux-2.0.4-enabled.patch"
Content-Description: 3486229055-libselinux-2.0.4-enabled.patch
Content-Disposition: inline; filename="libselinux-2.0.4-enabled.patch"

diff -urp libselinux-2.0.4.orig/src/enabled.c libselinux-2.0.4/src/enabled.c
--- libselinux-2.0.4.orig/src/enabled.c	2007-02-25 14:52:16.000000000 -0500
+++ libselinux-2.0.4/src/enabled.c	2007-02-26 11:18:14.000000000 -0500
@@ -10,46 +10,57 @@
 
 int is_selinux_enabled(void)
 {
-	char *buf;
-	size_t size;
-	int fd;
-	ssize_t ret;
+	char *buf=NULL;
+	FILE *fp;
+	ssize_t num;
+	size_t len;
 	int enabled = 0;
 	security_context_t con;
 
-	fd = open("/proc/filesystems", O_RDONLY);
-	if (fd < 0)
-		return -1;
-
-	size = selinux_page_size;
-	buf = malloc(size);
-	if (!buf) {
-		enabled = -1;
-		goto out;
-	}
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
 
-	memset(buf, 0, size);
+	/* Drop back to detecting it the long way. */
+	fp = fopen("/proc/filesystems", "r");
+	if (!fp)
+		return -1;
 
-	ret = read(fd, buf, size - 1);
-	if (ret < 0) {
-		enabled = -1;
-		goto out2;
+	while ((num = getline(&buf, &len, fp)) != -1) {
+		if (strstr(buf, "selinuxfs")) {
+			enabled = 1;
+			break;
+		}
 	}
 
-	if (!strstr(buf, "selinuxfs"))
-		goto out2;
-
-	enabled = 1;
+	if (num < 0)
+		goto out;
 
+	/* Since an selinux file system is available, we consider
+	 * selinux enabled. If getcon_raw fails, selinux is still
+	 * enabled. We only consider it disabled if no policy is loaded. */
 	if (getcon_raw(&con) == 0) {
 		if (!strcmp(con, "kernel"))
 			enabled = 0;
 		freecon(con);
 	}
-      out2:
-	free(buf);
+
       out:
-	close(fd);
+	free(buf);
+	fclose(fp);
 	return enabled;
 }
 
@@ -75,7 +86,9 @@ int is_selinux_mls_enabled(void)
 
 	memset(buf, 0, sizeof buf);
 
-	ret = read(fd, buf, sizeof buf - 1);
+	do {
+		ret = read(fd, buf, sizeof buf - 1);
+	} while (ret < 0 && errno == EINTR);
 	close(fd);
 	if (ret < 0)
 		return enabled;
diff -urp libselinux-2.0.4.orig/src/init.c libselinux-2.0.4/src/init.c
--- libselinux-2.0.4.orig/src/init.c	2007-02-25 14:52:16.000000000 -0500
+++ libselinux-2.0.4/src/init.c	2007-02-26 11:21:02.000000000 -0500
@@ -6,7 +6,8 @@
 #include <ctype.h>
 #include <stdio.h>
 #include <dlfcn.h>
-#include <unistd.h>
+#include <sys/vfs.h>
+#include <stdint.h>
 
 #include "dso.h"
 #include "policy.h"
@@ -18,51 +19,57 @@ int selinux_page_size = 0;
 
 static void init_selinuxmnt(void)
 {
-	char *buf, *bufp, *p;
-	size_t size;
+	char *buf=NULL, *p;
 	FILE *fp;
+	struct statfs sfbuf;
+	int rc;
+	size_t len;
+	ssize_t num;
 
 	if (selinux_mnt)
 		return;
 
+	/* We check to see if the preferred mount point for selinux file
+	 * system has a selinuxfs. */
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
+	/* At this point, the usual spot doesn't have an selinuxfs so
+	 * we look around for it */
 	fp = fopen("/proc/mounts", "r");
 	if (!fp)
 		return;
 
-	size = selinux_page_size;
-
-	buf = malloc(size);
-	if (!buf)
-		goto out;
-
-	memset(buf, 0, size);
-
-	while ((bufp = fgets_unlocked(buf, size, fp))) {
+	while ((num = getline(&buf, &len, fp)) != -1) {
 		char *tmp;
 		p = strchr(buf, ' ');
 		if (!p)
-			goto out2;
+			goto out;
 		p++;
 		tmp = strchr(p, ' ');
 		if (!tmp)
-			goto out2;
+			goto out;
 		if (!strncmp(tmp + 1, "selinuxfs ", 10)) {
 			*tmp = '\0';
 			break;
 		}
 	}
 
-	if (!bufp)
-		goto out2;
+	/* If we found something, dup it */
+	if (num > 0)
+		selinux_mnt = strdup(p);
 
-	selinux_mnt = strdup(p);
-
-      out2:
-	free(buf);
       out:
+	free(buf);
 	fclose(fp);
 	return;
-
 }
 
 static void fini_selinuxmnt(void)
diff -urp libselinux-2.0.4.orig/src/load_policy.c libselinux-2.0.4/src/load_policy.c
--- libselinux-2.0.4.orig/src/load_policy.c	2007-02-25 14:52:16.000000000 -0500
+++ libselinux-2.0.4/src/load_policy.c	2007-02-26 11:18:14.000000000 -0500
@@ -165,7 +165,6 @@ hidden_def(selinux_mkload_policy)
  * We only need the hardcoded definition for the initial mount 
  * required for the initial policy load.
  */
-#define SELINUXMNT "/selinux/"
 int selinux_init_load_policy(int *enforce)
 {
 	int rc = 0, orig_enforce = 0, seconfig = -2, secmdline = -1;
diff -urp libselinux-2.0.4.orig/src/policy.h libselinux-2.0.4/src/policy.h
--- libselinux-2.0.4.orig/src/policy.h	2007-02-25 14:52:16.000000000 -0500
+++ libselinux-2.0.4/src/policy.h	2007-02-26 11:18:14.000000000 -0500
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
 

--0-1258304701-1172508043=:76802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
