Subject: [patch] libselinux:  access per-thread proc pid attr nodes, unify
	code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 15:20:42 -0400
Message-Id: <1155324042.30078.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Rework the libselinux functions that access /proc/pid/attr to access the
per-thread nodes, and unify the code to simplify maintenance.

---

 src/getcon.c           |   17 ---
 src/getexeccon.c       |   15 ---
 src/getfscreatecon.c   |   15 ---
 src/getkeycreatecon.c  |   15 ---
 src/getpidcon.c        |   20 ----
 src/getprevcon.c       |   17 ---
 src/getprocattrcon.c   |   69 ---------------
 src/getsockcreatecon.c |   15 ---
 src/procattr.c         |  215 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/selinux_internal.h |    8 -
 src/setcon.c           |   19 ----
 src/setexeccon.c       |   17 ---
 src/setfscreatecon.c   |   15 ---
 src/setkeycreatecon.c  |   15 ---
 src/setprocattrcon.c   |   46 ----------
 src/setsockcreatecon.c |   15 ---
 16 files changed, 215 insertions(+), 318 deletions(-)

diff -X /home/sds/dontdiff -Nrup libselinux/src/getcon.c libselinux.procattr/src/getcon.c
--- libselinux/src/getcon.c	2006-08-11 11:00:00.000000000 -0400
+++ libselinux.procattr/src/getcon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,17 +0,0 @@
-#include "selinux_internal.h"
-
-int getcon_raw(security_context_t * context)
-{
-	char *current_pid_proc_entry = "/proc/self/attr/current";
-	return getprocattrcon_raw(context, current_pid_proc_entry);
-}
-
-hidden_def(getcon_raw)
-
-int getcon(security_context_t * context)
-{
-	char *current_pid_proc_entry = "/proc/self/attr/current";
-	return getprocattrcon(context, current_pid_proc_entry);
-}
-
-hidden_def(getcon)
diff -X /home/sds/dontdiff -Nrup libselinux/src/getexeccon.c libselinux.procattr/src/getexeccon.c
--- libselinux/src/getexeccon.c	2006-08-11 11:00:00.000000000 -0400
+++ libselinux.procattr/src/getexeccon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,15 +0,0 @@
-#include "selinux_internal.h"
-
-#define EXEC_PROC_ENTRY "/proc/self/attr/exec"
-
-int getexeccon_raw(security_context_t * context)
-{
-	return getprocattrcon_raw(context, EXEC_PROC_ENTRY);
-}
-
-hidden_def(getexeccon_raw)
-
-int getexeccon(security_context_t * context)
-{
-	return getprocattrcon(context, EXEC_PROC_ENTRY);
-}
diff -X /home/sds/dontdiff -Nrup libselinux/src/getfscreatecon.c libselinux.procattr/src/getfscreatecon.c
--- libselinux/src/getfscreatecon.c	2006-08-11 11:00:00.000000000 -0400
+++ libselinux.procattr/src/getfscreatecon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,15 +0,0 @@
-#include "selinux_internal.h"
-
-#define FSCREATE_PROC_ENTRY "/proc/self/attr/fscreate"
-
-int getfscreatecon_raw(security_context_t * context)
-{
-	return getprocattrcon_raw(context, FSCREATE_PROC_ENTRY);
-}
-
-hidden_def(getfscreatecon_raw)
-
-int getfscreatecon(security_context_t * context)
-{
-	return getprocattrcon(context, FSCREATE_PROC_ENTRY);
-}
diff -X /home/sds/dontdiff -Nrup libselinux/src/getkeycreatecon.c libselinux.procattr/src/getkeycreatecon.c
--- libselinux/src/getkeycreatecon.c	2006-08-11 11:00:00.000000000 -0400
+++ libselinux.procattr/src/getkeycreatecon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,15 +0,0 @@
-#include "selinux_internal.h"
-
-#define KEYCREATE_PROC_ENTRY "/proc/self/attr/keycreate"
-
-int getkeycreatecon_raw(security_context_t * context)
-{
-	return getprocattrcon_raw(context, KEYCREATE_PROC_ENTRY);
-}
-
-hidden_def(getkeycreatecon_raw)
-
-int getkeycreatecon(security_context_t * context)
-{
-	return getprocattrcon(context, KEYCREATE_PROC_ENTRY);
-}
diff -X /home/sds/dontdiff -Nrup libselinux/src/getpidcon.c libselinux.procattr/src/getpidcon.c
--- libselinux/src/getpidcon.c	2006-08-11 11:00:00.000000000 -0400
+++ libselinux.procattr/src/getpidcon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,20 +0,0 @@
-#include <stdio.h>
-#include "selinux_internal.h"
-
-#define PID_CON_PROC_ENTRY "/proc/%d/attr/current"
-
-int getpidcon_raw(pid_t pid, security_context_t * context)
-{
-	char path[40];
-	snprintf(path, sizeof path, PID_CON_PROC_ENTRY, pid);
-	return getprocattrcon_raw(context, path);
-}
-
-hidden_def(getpidcon_raw)
-
-int getpidcon(pid_t pid, security_context_t * context)
-{
-	char path[40];
-	snprintf(path, sizeof path, PID_CON_PROC_ENTRY, pid);
-	return getprocattrcon(context, path);
-}
diff -X /home/sds/dontdiff -Nrup libselinux/src/getprevcon.c libselinux.procattr/src/getprevcon.c
--- libselinux/src/getprevcon.c	2006-08-11 11:00:00.000000000 -0400
+++ libselinux.procattr/src/getprevcon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,17 +0,0 @@
-#include "selinux_internal.h"
-
-#define PREV_PROC_ENTRY "/proc/self/attr/prev"
-
-int getprevcon_raw(security_context_t * context)
-{
-	return getprocattrcon_raw(context, PREV_PROC_ENTRY);
-}
-
-hidden_def(getprevcon_raw)
-
-int getprevcon(security_context_t * context)
-{
-	return getprocattrcon(context, PREV_PROC_ENTRY);
-}
-
-hidden_def(getprevcon)
diff -X /home/sds/dontdiff -Nrup libselinux/src/getprocattrcon.c libselinux.procattr/src/getprocattrcon.c
--- libselinux/src/getprocattrcon.c	2006-08-11 11:00:00.000000000 -0400
+++ libselinux.procattr/src/getprocattrcon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,69 +0,0 @@
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <stdlib.h>
-#include <errno.h>
-#include "selinux_internal.h"
-#include "policy.h"
-
-int hidden getprocattrcon_raw(security_context_t * context,
-			      const char *proc_entry)
-{
-	char *buf;
-	size_t size;
-	int fd;
-	ssize_t ret;
-	int errno_hold;
-
-	fd = open(proc_entry, O_RDONLY);
-	if (fd < 0)
-		return -1;
-
-	size = selinux_page_size;
-	buf = malloc(size);
-	if (!buf) {
-		ret = -1;
-		goto out;
-	}
-	memset(buf, 0, size);
-
-	do {
-		ret = read(fd, buf, size - 1);
-	} while (ret < 0 && errno == EINTR);
-	if (ret < 0)
-		goto out2;
-
-	if (ret == 0) {
-		*context = NULL;
-		goto out2;
-	}
-
-	*context = strdup(buf);
-	if (!(*context)) {
-		ret = -1;
-		goto out2;
-	}
-	ret = 0;
-      out2:
-	free(buf);
-      out:
-	errno_hold = errno;
-	close(fd);
-	errno = errno_hold;
-	return ret;
-}
-
-int hidden getprocattrcon(security_context_t * context, const char *proc_entry)
-{
-	int ret;
-	security_context_t rcontext;
-
-	ret = getprocattrcon_raw(&rcontext, proc_entry);
-
-	if (!ret) {
-		ret = selinux_raw_to_trans_context(rcontext, context);
-		freecon(rcontext);
-	}
-
-	return ret;
-}
diff -X /home/sds/dontdiff -Nrup libselinux/src/getsockcreatecon.c libselinux.procattr/src/getsockcreatecon.c
--- libselinux/src/getsockcreatecon.c	2006-08-11 11:00:00.000000000 -0400
+++ libselinux.procattr/src/getsockcreatecon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,15 +0,0 @@
-#include "selinux_internal.h"
-
-#define SOCKCREATE_PROC_ENTRY "/proc/self/attr/sockcreate"
-
-int getsockcreatecon_raw(security_context_t * context)
-{
-	return getprocattrcon_raw(context, SOCKCREATE_PROC_ENTRY);
-}
-
-hidden_def(getsockcreatecon_raw)
-
-int getsockcreatecon(security_context_t * context)
-{
-	return getprocattrcon(context, SOCKCREATE_PROC_ENTRY);
-}
diff -X /home/sds/dontdiff -Nrup libselinux/src/procattr.c libselinux.procattr/src/procattr.c
--- libselinux/src/procattr.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux.procattr/src/procattr.c	2006-08-11 14:37:53.000000000 -0400
@@ -0,0 +1,215 @@
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include "selinux_internal.h"
+#include "policy.h"
+
+#include <sys/types.h>
+#include <linux/unistd.h>
+#include <sys/syscall.h>
+#ifdef _syscall0
+static _syscall0(pid_t, gettid)
+#else
+static pid_t gettid(void) 
+{
+	return syscall(__NR_gettid);
+}
+#endif
+
+static int getprocattrcon_raw(security_context_t * context,
+			      pid_t pid,
+			      const char *attr)
+{
+	char *path, *buf;
+	size_t size;
+	int fd, rc;
+	ssize_t ret;
+	pid_t tid;
+	int errno_hold;
+
+	if (pid > 0)
+		rc = asprintf(&path, "/proc/%d/attr/%s", pid, attr);
+	else {
+		tid = gettid();
+		rc = asprintf(&path, "/proc/self/task/%d/attr/%s", tid, attr);
+	}
+	if (rc < 0)
+		return -1;
+
+	fd = open(path, O_RDONLY);
+	free(path);
+	if (fd < 0)
+		return -1;
+
+	size = selinux_page_size;
+	buf = malloc(size);
+	if (!buf) {
+		ret = -1;
+		goto out;
+	}
+	memset(buf, 0, size);
+
+	do {
+		ret = read(fd, buf, size - 1);
+	} while (ret < 0 && errno == EINTR);
+	if (ret < 0)
+		goto out2;
+
+	if (ret == 0) {
+		*context = NULL;
+		goto out2;
+	}
+
+	*context = strdup(buf);
+	if (!(*context)) {
+		ret = -1;
+		goto out2;
+	}
+	ret = 0;
+      out2:
+	free(buf);
+      out:
+	errno_hold = errno;
+	close(fd);
+	errno = errno_hold;
+	return ret;
+}
+
+static int getprocattrcon(security_context_t * context, 
+			  pid_t pid,
+			  const char *attr)
+{
+	int ret;
+	security_context_t rcontext;
+
+	ret = getprocattrcon_raw(&rcontext, pid, attr);
+
+	if (!ret) {
+		ret = selinux_raw_to_trans_context(rcontext, context);
+		freecon(rcontext);
+	}
+
+	return ret;
+}
+
+static int setprocattrcon_raw(security_context_t context, 
+			      pid_t pid,
+			      const char *attr)
+{
+	char *path;
+	int fd, rc;
+	pid_t tid;
+	ssize_t ret;
+	int errno_hold;
+
+	if (pid > 0)
+		rc = asprintf(&path, "/proc/%d/attr/%s", pid, attr);
+	else {
+		tid = gettid();
+		rc = asprintf(&path, "/proc/self/task/%d/attr/%s", tid, attr);
+	}
+	if (rc < 0)
+		return -1;
+
+	fd = open(path, O_RDWR);
+	free(path);
+	if (fd < 0)
+		return -1;
+	if (context)
+		do {
+			ret = write(fd, context, strlen(context) + 1);
+		} while (ret < 0 && errno == EINTR);
+	else
+		do {
+			ret = write(fd, NULL, 0);	/* clear */
+		} while (ret < 0 && errno == EINTR);
+	errno_hold = errno;
+	close(fd);
+	errno = errno_hold;
+	if (ret < 0)
+		return -1;
+	else
+		return 0;
+}
+
+static int setprocattrcon(security_context_t context, 
+			  pid_t pid,
+			  const char *attr)
+{
+	int ret;
+	security_context_t rcontext = context;
+
+	if (selinux_trans_to_raw_context(context, &rcontext))
+		return -1;
+
+	ret = setprocattrcon_raw(rcontext, pid, attr);
+
+	freecon(rcontext);
+
+	return ret;
+}
+
+#define getselfattr_def(fn, attr) \
+	int get##fn##_raw(security_context_t *c) \
+	{ \
+		return getprocattrcon_raw(c, 0, #attr); \
+	} \
+	int get##fn(security_context_t *c) \
+	{ \
+		return getprocattrcon(c, 0, #attr); \
+	}
+
+#define setselfattr_def(fn, attr) \
+	int set##fn##_raw(security_context_t c) \
+	{ \
+		return setprocattrcon_raw(c, 0, #attr); \
+	} \
+	int set##fn(security_context_t c) \
+	{ \
+		return setprocattrcon(c, 0, #attr); \
+	}
+
+#define all_selfattr_def(fn, attr) \
+	getselfattr_def(fn, attr)	 \
+	setselfattr_def(fn, attr)
+
+#define getpidattr_def(fn, attr) \
+	int get##fn##_raw(pid_t pid, security_context_t *c)	\
+	{ \
+		return getprocattrcon_raw(c, pid, #attr); \
+	} \
+	int get##fn(pid_t pid, security_context_t *c)	\
+	{ \
+		return getprocattrcon(c, pid, #attr); \
+	}
+		
+all_selfattr_def(con, current)
+getpidattr_def(pidcon, current)
+getselfattr_def(prevcon, prev)
+all_selfattr_def(execcon, exec)
+all_selfattr_def(fscreatecon, fscreate)
+all_selfattr_def(sockcreatecon, sockcreate)
+all_selfattr_def(keycreatecon, keycreate)
+
+hidden_def(getcon_raw)
+hidden_def(getcon)
+hidden_def(getexeccon_raw)
+hidden_def(getfilecon_raw)
+hidden_def(getfilecon)
+hidden_def(getfscreatecon_raw)
+hidden_def(getkeycreatecon_raw)
+hidden_def(getpeercon_raw)
+hidden_def(getpidcon_raw)
+hidden_def(getprevcon_raw)
+hidden_def(getprevcon)
+hidden_def(getsockcreatecon_raw)
+hidden_def(setcon_raw)
+hidden_def(setexeccon_raw)
+hidden_def(setexeccon)
+hidden_def(setfilecon_raw)
+hidden_def(setfscreatecon_raw)
+hidden_def(setkeycreatecon_raw)
+hidden_def(setsockcreatecon_raw)
diff -X /home/sds/dontdiff -Nrup libselinux/src/selinux_internal.h libselinux.procattr/src/selinux_internal.h
--- libselinux/src/selinux_internal.h	2006-08-11 10:52:58.000000000 -0400
+++ libselinux.procattr/src/selinux_internal.h	2006-08-11 14:12:26.000000000 -0400
@@ -77,11 +77,3 @@ extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
 extern int selinux_page_size hidden;
 extern int cache_trans hidden;
-
-/* Generic /proc pid attr handlers.  These will either get or set the context
-   from or into the proc location passed to them. */
-extern int hidden getprocattrcon(security_context_t * con, const char *path);
-extern int hidden getprocattrcon_raw(security_context_t * con,
-				     const char *path);
-extern int hidden setprocattrcon(security_context_t con, const char *path);
-extern int hidden setprocattrcon_raw(security_context_t con, const char *path);
diff -X /home/sds/dontdiff -Nrup libselinux/src/setcon.c libselinux.procattr/src/setcon.c
--- libselinux/src/setcon.c	2006-08-11 10:52:58.000000000 -0400
+++ libselinux.procattr/src/setcon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,19 +0,0 @@
-/*
- * Author: Trusted Computer Solutions, Inc. <chanson@trustedcs.com>
- */
-
-#include "selinux_internal.h"
-
-#define CURRENT_PROC_ENTRY "/proc/self/attr/current"
-
-int setcon_raw(security_context_t context)
-{
-	return setprocattrcon_raw(context, CURRENT_PROC_ENTRY);
-}
-
-hidden_def(setcon_raw)
-
-int setcon(char *context)
-{
-	return setprocattrcon(context, CURRENT_PROC_ENTRY);
-}
diff -X /home/sds/dontdiff -Nrup libselinux/src/setexeccon.c libselinux.procattr/src/setexeccon.c
--- libselinux/src/setexeccon.c	2006-08-11 10:52:58.000000000 -0400
+++ libselinux.procattr/src/setexeccon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,17 +0,0 @@
-#include "selinux_internal.h"
-
-#define EXEC_PROC_ENTRY "/proc/self/attr/exec"
-
-int setexeccon_raw(security_context_t context)
-{
-	return setprocattrcon_raw(context, EXEC_PROC_ENTRY);
-}
-
-hidden_def(setexeccon_raw)
-
-int setexeccon(char *context)
-{
-	return setprocattrcon(context, EXEC_PROC_ENTRY);
-}
-
-hidden_def(setexeccon)
diff -X /home/sds/dontdiff -Nrup libselinux/src/setfscreatecon.c libselinux.procattr/src/setfscreatecon.c
--- libselinux/src/setfscreatecon.c	2006-08-11 10:52:58.000000000 -0400
+++ libselinux.procattr/src/setfscreatecon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,15 +0,0 @@
-#include "selinux_internal.h"
-
-#define FSCREATE_PROC_ENTRY "/proc/self/attr/fscreate"
-
-int setfscreatecon_raw(security_context_t context)
-{
-	return setprocattrcon_raw(context, FSCREATE_PROC_ENTRY);
-}
-
-hidden_def(setfscreatecon_raw)
-
-int setfscreatecon(char *context)
-{
-	return setprocattrcon(context, FSCREATE_PROC_ENTRY);
-}
diff -X /home/sds/dontdiff -Nrup libselinux/src/setkeycreatecon.c libselinux.procattr/src/setkeycreatecon.c
--- libselinux/src/setkeycreatecon.c	2006-08-11 10:52:58.000000000 -0400
+++ libselinux.procattr/src/setkeycreatecon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,15 +0,0 @@
-#include "selinux_internal.h"
-
-#define KEYCREATE_PROC_ENTRY "/proc/self/attr/keycreate"
-
-int setkeycreatecon_raw(security_context_t context)
-{
-	return setprocattrcon_raw(context, KEYCREATE_PROC_ENTRY);
-}
-
-hidden_def(setkeycreatecon_raw)
-
-int setkeycreatecon(char *context)
-{
-	return setprocattrcon(context, KEYCREATE_PROC_ENTRY);
-}
diff -X /home/sds/dontdiff -Nrup libselinux/src/setprocattrcon.c libselinux.procattr/src/setprocattrcon.c
--- libselinux/src/setprocattrcon.c	2006-08-11 10:52:58.000000000 -0400
+++ libselinux.procattr/src/setprocattrcon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,46 +0,0 @@
-#include <unistd.h>
-#include <string.h>
-#include <fcntl.h>
-#include <errno.h>
-#include "selinux_internal.h"
-
-int hidden setprocattrcon_raw(char *context, const char *proc_entry)
-{
-	int fd;
-	ssize_t ret;
-	int errno_hold;
-
-	fd = open(proc_entry, O_RDWR);
-	if (fd < 0)
-		return -1;
-	if (context)
-		do {
-			ret = write(fd, context, strlen(context) + 1);
-		} while (ret < 0 && errno == EINTR);
-	else
-		do {
-			ret = write(fd, NULL, 0);	/* clear */
-		} while (ret < 0 && errno == EINTR);
-	errno_hold = errno;
-	close(fd);
-	errno = errno_hold;
-	if (ret < 0)
-		return -1;
-	else
-		return 0;
-}
-
-int hidden setprocattrcon(char *context, const char *proc_entry)
-{
-	int ret;
-	security_context_t rcontext = context;
-
-	if (selinux_trans_to_raw_context(context, &rcontext))
-		return -1;
-
-	ret = setprocattrcon_raw(rcontext, proc_entry);
-
-	freecon(rcontext);
-
-	return ret;
-}
diff -X /home/sds/dontdiff -Nrup libselinux/src/setsockcreatecon.c libselinux.procattr/src/setsockcreatecon.c
--- libselinux/src/setsockcreatecon.c	2006-08-11 10:52:58.000000000 -0400
+++ libselinux.procattr/src/setsockcreatecon.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,15 +0,0 @@
-#include "selinux_internal.h"
-
-#define SOCKCREATE_PROC_ENTRY "/proc/self/attr/sockcreate"
-
-int setsockcreatecon_raw(security_context_t context)
-{
-	return setprocattrcon_raw(context, SOCKCREATE_PROC_ENTRY);
-}
-
-hidden_def(setsockcreatecon_raw)
-
-int setsockcreatecon(char *context)
-{
-	return setprocattrcon(context, SOCKCREATE_PROC_ENTRY);
-}


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
