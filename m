Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1LIP1FB021714
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:25:01 -0500
Received: from web51508.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1LIQGMh028724
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 18:26:17 GMT
Date: Wed, 21 Feb 2007 10:26:10 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: libselinux patch
To: Steve G <linux_4ever@yahoo.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <948733.27387.qm@web51508.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1569986583-1172082370=:80842"
Message-ID: <658470.80842.qm@web51508.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1569986583-1172082370=:80842
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

>Actually, you could guess "/selinux" and drop back to dynamically determining if
>that failed.

This approach works and saves about 7 syscalls. This is the diff of running
selinuxenabled with and without the attached patch.

 close(3)                                = 0
 munmap(0x2aaaaaaac000, 4096)            = 0
-open("/proc/mounts", O_RDONLY)          = 3
-fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
-mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x2aaaaaaac000
-read(3, "rootfs / rootfs rw 0 0\n/dev/root"..., 4096) = 673
-close(3)                                = 0
-munmap(0x2aaaaaaac000, 4096)            = 0
+statfs("/selinux", {f_type=0xf97cff8c, f_bsize=4096, f_blocks=0, f_bfree=0,
f_bavail=0, f_files=0, f_ffree=0, f_fsid={0, 0}, f_namelen=255, f_frsize=4096}) =
0
 open("/selinux/mls", O_RDONLY)          = 3
 read(3, "1", 19)                        = 1
@@ -71,12 +66,10 @@
 readv(3, [{"\0", 1}], 1)                = 1
 close(3)                                = 0
-open("/proc/filesystems", O_RDONLY)     = 3
-read(3, "nodev\tsysfs\nnodev\trootfs\nnodev\tb"..., 4095) = 311
-close(3)                                = 0
+statfs("/selinux", {f_type=0xf97cff8c, f_bsize=4096, f_blocks=0, f_bfree=0,
f_bavail=0, f_files=0, f_ffree=0, f_fsid={0, 0}, f_namelen=255, f_frsize=4096}) =
0
 gettid()                                = 14365
 open("/proc/self/task/14365/attr/current", O_RDONLY) = 3

This improves performance, falls back to the old method when the guess is wrong,
and checks that /selinux really is an selinuxfs.

While reading through the is_enabled code, I realized something. Right before the
call to getcon_raw(), we decide that its enabled. If the getcon_raw() fails, we
still consider it enabled. Only if the call return success do we do a test and
consider it disabled. I don't know if that's good or bad, but I copied the
behavior. Seems suspicious to me.

Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>


 
____________________________________________________________________________________
Bored stiff? Loosen up... 
Download and play hundreds of games for free on Yahoo! Games.
http://games.yahoo.com/games/front
--0-1569986583-1172082370=:80842
Content-Type: text/x-patch; name="libselinux-2.0.0-enabled.patch"
Content-Description: 3974351640-libselinux-2.0.0-enabled.patch
Content-Disposition: inline; filename="libselinux-2.0.0-enabled.patch"

diff -urp libselinux-2.0.0.orig/include/selinux/selinux.h libselinux-2.0.0/include/selinux/selinux.h
--- libselinux-2.0.0.orig/include/selinux/selinux.h	2007-02-19 20:57:53.000000000 -0500
+++ libselinux-2.0.0/include/selinux/selinux.h	2007-02-21 13:06:13.000000000 -0500
@@ -8,6 +8,8 @@
 extern "C" {
 #endif
 
+#define SELINUX_MAGIC 0xf97cff8c
+
 /* Return 1 if we are running on a SELinux kernel, or 0 if not or -1 if we get an error. */
 	extern int is_selinux_enabled(void);
 /* Return 1 if we are running on a SELinux MLS kernel, or 0 otherwise. */
diff -urp libselinux-2.0.0.orig/src/enabled.c libselinux-2.0.0/src/enabled.c
--- libselinux-2.0.0.orig/src/enabled.c	2007-02-19 20:57:53.000000000 -0500
+++ libselinux-2.0.0/src/enabled.c	2007-02-21 13:08:24.000000000 -0500
@@ -6,16 +6,34 @@
 #include <errno.h>
 #include <limits.h>
 #include <stdio.h>
+#include <sys/vfs.h>
+
 #include "policy.h"
 
 int is_selinux_enabled(void)
 {
 	char *buf;
 	size_t size;
-	int fd;
+	int fd, rc;
 	ssize_t ret;
 	int enabled = 0;
 	security_context_t con;
+	struct statfs sfbuf;
+
+	do { 
+		rc = statfs("/selinux", &sfbuf);
+	} while(rc < 0 && errno == EINTR);
+	if (rc == 0) {
+		if ((u_int32_t)sfbuf.f_type == (u_int32_t)SELINUX_MAGIC) {
+			enabled = 1;
+			if (getcon_raw(&con) == 0) {
+				if (!strcmp(con, "kernel"))
+					enabled = 0;
+				freecon(con);
+			}
+                        return enabled;
+                }
+        }
 
 	fd = open("/proc/filesystems", O_RDONLY);
 	if (fd < 0)
diff -urp libselinux-2.0.0.orig/src/init.c libselinux-2.0.0/src/init.c
--- libselinux-2.0.0.orig/src/init.c	2007-02-19 20:57:53.000000000 -0500
+++ libselinux-2.0.0/src/init.c	2007-02-21 13:09:39.000000000 -0500
@@ -6,7 +6,7 @@
 #include <ctype.h>
 #include <stdio.h>
 #include <dlfcn.h>
-#include <unistd.h>
+#include <sys/vfs.h>
 
 #include "dso.h"
 #include "policy.h"
@@ -21,10 +21,22 @@ static void init_selinuxmnt(void)
 	char *buf, *bufp, *p;
 	size_t size;
 	FILE *fp;
+	struct statfs sfbuf;
+	int rc;
 
 	if (selinux_mnt)
 		return;
 
+	do {
+		rc = statfs("/selinux", &sfbuf);
+	} while (rc < 0 && errno == EINTR);
+	if (rc == 0) {
+		if ((u_int32_t)sfbuf.f_type == (u_int32_t)SELINUX_MAGIC) {
+			selinux_mnt = strdup("/selinux");
+			return;
+		}
+	}
+
 	fp = fopen("/proc/mounts", "r");
 	if (!fp)
 		return;

--0-1569986583-1172082370=:80842--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
