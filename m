Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBCFhwRb009365
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 10:43:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBCFhBlU023127
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 15:43:11 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hBCFhASX023124
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 15:43:11 GMT
Subject: [patch] Change libselinux to discover selinuxfs mount point via
	/proc/mounts (Was:  Re: Information about selinuxfs)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>
Cc: selinux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1071236618.14716.21.camel@moss-spartans.epoch.ncsc.mil>
References: <3FD9B8F2.7030100@ipen.br>
	 <1071236618.14716.21.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-+w3wR8h7xcXhnH9XIt/n"
Message-Id: <1071243803.14716.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 12 Dec 2003 10:43:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+w3wR8h7xcXhnH9XIt/n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2003-12-12 at 08:43, Stephen Smalley wrote:
> libselinux expects selinuxfs to be mounted on /selinux for the various
> security_* calls.  However, someone recently suggested that we change
> libselinux to discover the selinuxfs mount point at runtime from
> /proc/mounts, which would allow you to change the mount point without
> requiring a patch and rebuild for libselinux.

The attached patch makes the change described above to libselinux.  A
constructor function determines the selinuxfs mount point from
/proc/mounts during initialization, and this mount point directory is
then used by the libselinux functions.  This eliminates the need to
rebuild libselinux in the future if the mount point changes.

 libselinux/src/check_context.c   |    6 +++
 libselinux/src/compute_av.c      |    5 ++-
 libselinux/src/compute_create.c  |    5 ++-
 libselinux/src/compute_relabel.c |    5 ++-
 libselinux/src/compute_user.c    |    5 ++-
 libselinux/src/getenforce.c      |    5 ++-
 libselinux/src/init.c            |   62 +++++++++++++++++++++++++++++++++++++++
 libselinux/src/load_policy.c     |    6 +++
 libselinux/src/policy.h          |    3 +
 libselinux/src/policyvers.c      |    5 ++-
 libselinux/src/setenforce.c      |    5 ++-
 11 files changed, 103 insertions(+), 9 deletions(-)

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-+w3wR8h7xcXhnH9XIt/n
Content-Disposition: attachment; filename=libselinux.patch
Content-Type: text/x-patch; name=libselinux.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: selinux-usr/libselinux/src/check_context.c
diff -u selinux-usr/libselinux/src/check_context.c:1.2 selinux-usr/libselinux/src/check_context.c:1.3
--- selinux-usr/libselinux/src/check_context.c:1.2	Tue Apr 29 17:09:21 2003
+++ selinux-usr/libselinux/src/check_context.c	Fri Dec 12 10:29:05 2003
@@ -4,14 +4,18 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
+#include <stdio.h>
 #include <selinux/selinux.h>
 #include "policy.h"
+#include <limits.h>
 
 int security_check_context(security_context_t con)
 {
+	char path[PATH_MAX];
 	int fd, ret;
 
-	fd = open(SELINUXMNT "context", O_RDWR);
+	snprintf(path, sizeof path, "%s/context", selinux_mnt);
+	fd = open(path, O_RDWR);
 	if (fd < 0)
 		return -1;
 
Index: selinux-usr/libselinux/src/compute_av.c
diff -u selinux-usr/libselinux/src/compute_av.c:1.5 selinux-usr/libselinux/src/compute_av.c:1.6
--- selinux-usr/libselinux/src/compute_av.c:1.5	Mon Dec  1 14:28:32 2003
+++ selinux-usr/libselinux/src/compute_av.c	Fri Dec 12 10:29:05 2003
@@ -8,6 +8,7 @@
 #include <asm/page.h>
 #include <selinux/selinux.h>
 #include "policy.h"
+#include <limits.h>
 
 int security_compute_av(security_context_t scon,
 			security_context_t tcon,
@@ -15,11 +16,13 @@
 			access_vector_t requested,
 			struct av_decision *avd)
 {
+	char path[PATH_MAX];
 	char *buf;
 	size_t len;
 	int fd, ret;
 
-	fd = open(SELINUXMNT "access", O_RDWR);
+	snprintf(path, sizeof path, "%s/access", selinux_mnt);
+	fd = open(path, O_RDWR);
 	if (fd < 0) 
 		return -1;
 
Index: selinux-usr/libselinux/src/compute_create.c
diff -u selinux-usr/libselinux/src/compute_create.c:1.7 selinux-usr/libselinux/src/compute_create.c:1.8
--- selinux-usr/libselinux/src/compute_create.c:1.7	Thu Jul 17 10:38:06 2003
+++ selinux-usr/libselinux/src/compute_create.c	Fri Dec 12 10:29:05 2003
@@ -8,17 +8,20 @@
 #include <asm/page.h>
 #include <selinux/selinux.h>
 #include "policy.h"
+#include <limits.h>
 
 int security_compute_create(security_context_t scon,
 			    security_context_t tcon,
 			    security_class_t tclass,
 			    security_context_t *newcon)
 {
+	char path[PATH_MAX];
 	char *buf;
 	size_t size;
 	int fd, ret;
 
-	fd = open(SELINUXMNT "create", O_RDWR);
+	snprintf(path, sizeof path, "%s/create", selinux_mnt);
+	fd = open(path, O_RDWR);
 	if (fd < 0)
 		return -1;
 
Index: selinux-usr/libselinux/src/compute_relabel.c
diff -u selinux-usr/libselinux/src/compute_relabel.c:1.7 selinux-usr/libselinux/src/compute_relabel.c:1.8
--- selinux-usr/libselinux/src/compute_relabel.c:1.7	Thu Jul 17 10:38:06 2003
+++ selinux-usr/libselinux/src/compute_relabel.c	Fri Dec 12 10:29:05 2003
@@ -8,17 +8,20 @@
 #include <asm/page.h>
 #include <selinux/selinux.h>
 #include "policy.h"
+#include <limits.h>
 
 int security_compute_relabel(security_context_t scon,
 			    security_context_t tcon,
 			    security_class_t tclass,
 			    security_context_t *newcon)
 {
+	char path[PATH_MAX];
 	char *buf;
 	size_t size;
 	int fd, ret;
 
-	fd = open(SELINUXMNT "relabel", O_RDWR);
+	snprintf(path, sizeof path, "%s/relabel", selinux_mnt);
+	fd = open(path, O_RDWR);
 	if (fd < 0)
 		return -1;
 
Index: selinux-usr/libselinux/src/compute_user.c
diff -u selinux-usr/libselinux/src/compute_user.c:1.5 selinux-usr/libselinux/src/compute_user.c:1.6
--- selinux-usr/libselinux/src/compute_user.c:1.5	Mon Dec  1 14:28:32 2003
+++ selinux-usr/libselinux/src/compute_user.c	Fri Dec 12 10:29:05 2003
@@ -8,18 +8,21 @@
 #include <asm/page.h>
 #include <selinux/selinux.h>
 #include "policy.h"
+#include <limits.h>
 
 int security_compute_user(security_context_t scon,
 			  const char *user,
 			  security_context_t **con)
 {
+	char path[PATH_MAX];
 	char **ary;
 	char *buf, *ptr;
 	size_t size;
 	int fd, ret;
 	unsigned int i, nel;
 
-	fd = open(SELINUXMNT "user", O_RDWR);
+	snprintf(path, sizeof path, "%s/user", selinux_mnt);
+	fd = open(path, O_RDWR);
 	if (fd < 0)
 		return -1;
 
Index: selinux-usr/libselinux/src/getenforce.c
diff -u selinux-usr/libselinux/src/getenforce.c:1.1 selinux-usr/libselinux/src/getenforce.c:1.2
--- selinux-usr/libselinux/src/getenforce.c:1.1	Tue Oct 21 15:40:40 2003
+++ selinux-usr/libselinux/src/getenforce.c	Fri Dec 12 10:29:05 2003
@@ -7,13 +7,16 @@
 #include <selinux/selinux.h>
 #include "policy.h"
 #include <stdio.h>
+#include <limits.h>
 
 int security_getenforce(void)
 {
 	int fd, ret, enforce = 0;
+	char path[PATH_MAX];
 	char buf[20];
 
-	fd = open(SELINUXMNT "enforce", O_RDONLY);
+	snprintf(path, sizeof path, "%s/enforce", selinux_mnt);
+	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return -1;
 
Index: selinux-usr/libselinux/src/init.c
diff -u /dev/null selinux-usr/libselinux/src/init.c:1.1
--- /dev/null	Fri Dec 12 10:30:01 2003
+++ selinux-usr/libselinux/src/init.c	Fri Dec 12 10:29:05 2003
@@ -0,0 +1,62 @@
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <selinux/selinux.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <ctype.h>
+#include <asm/page.h>
+
+char *selinux_mnt = NULL;
+
+static void init_selinuxmnt(void) __attribute__ ((constructor));
+
+static void init_selinuxmnt(void)
+{
+	char *buf, *p;
+	size_t size;
+	int fd;
+	ssize_t ret;
+
+	if (selinux_mnt)
+		return;
+
+	fd = open("/proc/mounts", O_RDONLY);
+	if (fd < 0)
+		return;
+
+	size = PAGE_SIZE;
+	buf = malloc(size);
+	if (!buf)
+		goto out;
+		
+	memset(buf, 0, size);
+
+	ret = read(fd, buf, size - 1);
+	if (ret < 0)
+		goto out2;
+
+	p = strstr(buf, "selinuxfs");
+	if (!p)
+		goto out2;
+
+	p--;
+	*p = 0;
+	p--;
+
+	while (p > buf && !isspace(*p))
+		p--;
+
+	if (isspace(*p))
+		p++;
+
+	selinux_mnt = strdup(p);
+
+out2:
+	free(buf);
+out:
+	close(fd);
+	return;
+
+}
+ 
Index: selinux-usr/libselinux/src/load_policy.c
diff -u selinux-usr/libselinux/src/load_policy.c:1.2 selinux-usr/libselinux/src/load_policy.c:1.3
--- selinux-usr/libselinux/src/load_policy.c:1.2	Tue Apr 29 17:09:21 2003
+++ selinux-usr/libselinux/src/load_policy.c	Fri Dec 12 10:29:05 2003
@@ -2,15 +2,19 @@
 #include <sys/types.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#include <stdio.h>
 #include <errno.h>
 #include <selinux/selinux.h>
 #include "policy.h"
+#include <limits.h>
 
 int security_load_policy(void *data, size_t len)
 {
+	char path[PATH_MAX];
 	int fd, ret;
 	
-	fd = open(SELINUXMNT "load", O_RDWR);
+	snprintf(path, sizeof path, "%s/load", selinux_mnt);
+	fd = open(path, O_RDWR);
 	if (fd < 0) 
 		return -1;
 
Index: selinux-usr/libselinux/src/policy.h
diff -u selinux-usr/libselinux/src/policy.h:1.4 selinux-usr/libselinux/src/policy.h:1.5
--- selinux-usr/libselinux/src/policy.h:1.4	Tue Oct 21 15:40:40 2003
+++ selinux-usr/libselinux/src/policy.h	Fri Dec 12 10:29:06 2003
@@ -9,6 +9,9 @@
 /* Initial length guess for getting contexts. */
 #define INITCONTEXTLEN 255
 
+/* selinuxfs mount point */
+extern char *selinux_mnt;
+
 #endif
 
 
Index: selinux-usr/libselinux/src/policyvers.c
diff -u selinux-usr/libselinux/src/policyvers.c:1.1 selinux-usr/libselinux/src/policyvers.c:1.2
--- selinux-usr/libselinux/src/policyvers.c:1.1	Tue Oct 21 15:40:40 2003
+++ selinux-usr/libselinux/src/policyvers.c	Fri Dec 12 10:29:06 2003
@@ -7,16 +7,19 @@
 #include <selinux/selinux.h>
 #include <stdio.h>
 #include "policy.h"
+#include <limits.h>
 
 #define DEFAULT_POLICY_VERSION 15
 
 int security_policyvers(void)
 {
 	int fd, ret;
+	char path[PATH_MAX];
 	char buf[20];
 	unsigned vers = DEFAULT_POLICY_VERSION;
 
-	fd = open(SELINUXMNT "policyvers", O_RDONLY);
+	snprintf(path, sizeof path, "%s/policyvers", selinux_mnt);
+	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return vers;
 	memset(buf, 0, sizeof buf);
Index: selinux-usr/libselinux/src/setenforce.c
diff -u selinux-usr/libselinux/src/setenforce.c:1.1 selinux-usr/libselinux/src/setenforce.c:1.2
--- selinux-usr/libselinux/src/setenforce.c:1.1	Tue Oct 21 15:40:40 2003
+++ selinux-usr/libselinux/src/setenforce.c	Fri Dec 12 10:29:06 2003
@@ -7,13 +7,16 @@
 #include <selinux/selinux.h>
 #include "policy.h"
 #include <stdio.h>
+#include <limits.h>
 
 int security_setenforce(int value)
 {
 	int fd, ret;
+	char path[PATH_MAX];
 	char buf[20];
 
-	fd = open(SELINUXMNT "enforce", O_RDWR);
+	snprintf(path, sizeof path, "%s/enforce", selinux_mnt);
+	fd = open(path, O_RDWR);
 	if (fd < 0)
 		return -1;
 

--=-+w3wR8h7xcXhnH9XIt/n--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
