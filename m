Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0NDROgH031993
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2013 08:27:24 -0500
From: Jan Stancek <jstancek@redhat.com>
To: selinux@tycho.nsa.gov
Cc: serge@hallyn.com, jburke@redhat.com
Subject: [selinux-testsuite][PATCH] use extfs ioctls only when running on ext[234]
Date: Wed, 23 Jan 2013 14:27:12 +0100
Message-Id: <6012e6d654ddc5defd9e283745ff7d10a2fa20b5.1358947507.git.jstancek@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

EXT2_* ioctls are likely to fail on other filesystems,
for example: xfs.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tests/ioctl/Makefile       |    6 ++++++
 tests/ioctl/test_ioctl.c   |    2 ++
 tests/ioctl/test_noioctl.c |    2 ++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/tests/ioctl/Makefile b/tests/ioctl/Makefile
index 8dce555..def5267 100644
--- a/tests/ioctl/Makefile
+++ b/tests/ioctl/Makefile
@@ -1,4 +1,10 @@
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+
+DIR_FS=$(shell df -TP . | awk '{print $2}' | grep 'ext[234]')
+ifneq (x$(DIR_FS),x)
+    CFLAGS += -DUSE_EXTFS_IOCTLS
+endif
+
 all: $(TARGETS)
 clean:
 	rm -f $(TARGETS)
diff --git a/tests/ioctl/test_ioctl.c b/tests/ioctl/test_ioctl.c
index 0852f41..fa5d021 100644
--- a/tests/ioctl/test_ioctl.c
+++ b/tests/ioctl/test_ioctl.c
@@ -49,6 +49,7 @@ int main(int argc, char **argv) {
     exit(1);
   }
 
+#ifdef USE_EXTFS_IOCTLS
   /* This one should hit the FILE__GETATTR or FILE__READ test */
   rc = ioctl(fd, EXT2_IOC_GETVERSION, &val);
   if( rc != 0 ) {
@@ -63,6 +64,7 @@ int main(int argc, char **argv) {
     perror("test_ioctl:EXT2_IOC_SETVERSION");
     exit(1);
   }
+#endif
 
   close(fd);
   exit(0);
diff --git a/tests/ioctl/test_noioctl.c b/tests/ioctl/test_noioctl.c
index ef3fac5..b0ca660 100644
--- a/tests/ioctl/test_noioctl.c
+++ b/tests/ioctl/test_noioctl.c
@@ -68,6 +68,7 @@ int main(int argc, char **argv) {
     exit(1);
   }
 
+#ifdef USE_EXTFS_IOCTLS
   /*
    * This one depends on kernel version:
    * New:  Should hit the FILE__READ test and succeed.
@@ -86,6 +87,7 @@ int main(int argc, char **argv) {
     perror("test_noioctl:EXT2_IOC_SETVERSION");
     exit(1);
   }
+#endif
 
   close(fd);
   exit(0);
-- 
1.7.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
