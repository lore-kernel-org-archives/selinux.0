Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D48DC433F5
	for <selinux@archiver.kernel.org>; Sun, 29 May 2022 18:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiE2SLQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 29 May 2022 14:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiE2SLP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 29 May 2022 14:11:15 -0400
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 May 2022 11:11:12 PDT
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B153366FA7
        for <selinux@vger.kernel.org>; Sun, 29 May 2022 11:11:12 -0700 (PDT)
Received: from localhost.localdomain (41.169.89.92.rev.sfr.net [92.89.169.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A788C564EE6;
        Sun, 29 May 2022 20:02:00 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Cc:     jsegitz@suse.de
Subject: [PATCH 1/1] libselinux: do not return the cached prev_current value when using getpidcon()
Date:   Sun, 29 May 2022 20:01:11 +0200
Message-Id: <20220529180111.408899-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun May 29 20:02:00 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

libselinux implements a cache mechanism for get*con() functions, such
that when a thread calls setcon(...) then getcon(...), the context is
directly returned. Unfortunately, getpidcon(pid, &context) uses the same
cached variable, so when a program uses setcon("something"), all later
calls to getpidcon(pid, ...) returns "something". This is a bug.

Here is a program which illustrates this bug:

    #include <stdio.h>
    #include <selinux/selinux.h>

    int main() {
        char *context = "";
        if (getpidcon(1, &context) < 0) {
            perror("getpidcon(1)");
        }
        printf("getpidcon(1) = %s\n", context);

        if (getcon(&context) < 0) {
            perror("getcon()");
        }
        printf("getcon() = %s\n", context);
        if (setcon(context) < 0) {
            perror("setcon()");
        }
        if (getpidcon(1, &context) < 0) {
            perror("getpidcon(1)");
        }
        printf("getpidcon(1) = %s\n", context);

        return 0;
    }

On an Arch Linux system using unconfined user, this program displays:

    getpidcon(1) = system_u:system_r:init_t
    getcon() = unconfined_u:unconfined_r:unconfined_t
    getpidcon(1) = unconfined_u:unconfined_r:unconfined_t

With this commit, this program displays:

    getpidcon(1) = system_u:system_r:init_t
    getcon() = unconfined_u:unconfined_r:unconfined_t
    getpidcon(1) = system_u:system_r:init_t

This bug was present in the first commit of
https://github.com/SELinuxProject/selinux git history. It was reported
in https://lore.kernel.org/selinux/20220121084012.GS7643@suse.com/ and a
patch to fix it was sent in
https://patchwork.kernel.org/project/selinux/patch/20220127130741.31940-1-jsegitz@suse.de/
without a clear explanation. This patch added pid checks, which made
sense but were difficult to read. Instead, it is possible to change the
way the functions are called so that they directly know which cache
variable to use.

Moreover, as the code is not clear at all (I spent too much time trying
to understand what the switch did and what the thread-local variable
contained), this commit also reworks libselinux/src/procattr.c to:
- not use hard-to-understand switch/case constructions on strings (they
  are replaced by a new argument filled by macros)
- remove getpidattr_def macro (it was only used once, for pidcon, and
  the code is clearer with one less macro)
- remove the pid parameter of setprocattrcon() and setprocattrcon_raw()
  (it is always zero)

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: Johannes Segitz <jsegitz@suse.de>
---
 libselinux/src/procattr.c | 147 +++++++++++++-------------------------
 1 file changed, 50 insertions(+), 97 deletions(-)

diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
index 142fbf3a80e0..6f4cfb82479d 100644
--- a/libselinux/src/procattr.c
+++ b/libselinux/src/procattr.c
@@ -11,11 +11,14 @@
 
 #define UNSET (char *) -1
 
+/* Cached values so that when a thread calls set*con() then gen*con(), the value
+ * which was set is directly returned.
+ */
 static __thread char *prev_current = UNSET;
-static __thread char * prev_exec = UNSET;
-static __thread char * prev_fscreate = UNSET;
-static __thread char * prev_keycreate = UNSET;
-static __thread char * prev_sockcreate = UNSET;
+static __thread char *prev_exec = UNSET;
+static __thread char *prev_fscreate = UNSET;
+static __thread char *prev_keycreate = UNSET;
+static __thread char *prev_sockcreate = UNSET;
 
 static pthread_once_t once = PTHREAD_ONCE_INIT;
 static pthread_key_t destructor_key;
@@ -111,43 +114,18 @@ out:
 	return fd;
 }
 
-static int getprocattrcon_raw(char ** context,
-			      pid_t pid, const char *attr)
+static int getprocattrcon_raw(char **context, pid_t pid, const char *attr,
+			      const char *prev_context)
 {
 	char *buf;
 	size_t size;
 	int fd;
 	ssize_t ret;
 	int errno_hold;
-	char * prev_context;
 
 	__selinux_once(once, init_procattr);
 	init_thread_destructor();
 
-	switch (attr[0]) {
-		case 'c':
-			prev_context = prev_current;
-			break;
-		case 'e':
-			prev_context = prev_exec;
-			break;
-		case 'f':
-			prev_context = prev_fscreate;
-			break;
-		case 'k':
-			prev_context = prev_keycreate;
-			break;
-		case 's':
-			prev_context = prev_sockcreate;
-			break;
-		case 'p':
-			prev_context = NULL;
-			break;
-		default:
-			errno = ENOENT;
-			return -1;
-	}
-
 	if (prev_context && prev_context != UNSET) {
 		*context = strdup(prev_context);
 		if (!(*context)) {
@@ -194,13 +172,13 @@ static int getprocattrcon_raw(char ** context,
 	return ret;
 }
 
-static int getprocattrcon(char ** context,
-			  pid_t pid, const char *attr)
+static int getprocattrcon(char **context, pid_t pid, const char *attr,
+			  const char *prev_context)
 {
 	int ret;
 	char * rcontext;
 
-	ret = getprocattrcon_raw(&rcontext, pid, attr);
+	ret = getprocattrcon_raw(&rcontext, pid, attr, prev_context);
 
 	if (!ret) {
 		ret = selinux_raw_to_trans_context(rcontext, context);
@@ -210,45 +188,24 @@ static int getprocattrcon(char ** context,
 	return ret;
 }
 
-static int setprocattrcon_raw(const char * context,
-			      pid_t pid, const char *attr)
+static int setprocattrcon_raw(const char *context, const char *attr,
+			      char **prev_context)
 {
 	int fd;
 	ssize_t ret;
 	int errno_hold;
-	char **prev_context, *context2 = NULL;
+	char *context2 = NULL;
 
 	__selinux_once(once, init_procattr);
 	init_thread_destructor();
 
-	switch (attr[0]) {
-		case 'c':
-			prev_context = &prev_current;
-			break;
-		case 'e':
-			prev_context = &prev_exec;
-			break;
-		case 'f':
-			prev_context = &prev_fscreate;
-			break;
-		case 'k':
-			prev_context = &prev_keycreate;
-			break;
-		case 's':
-			prev_context = &prev_sockcreate;
-			break;
-		default:
-			errno = ENOENT;
-			return -1;
-	}
-
 	if (!context && !*prev_context)
 		return 0;
 	if (context && *prev_context && *prev_context != UNSET
 	    && !strcmp(context, *prev_context))
 		return 0;
 
-	fd = openattr(pid, attr, O_RDWR | O_CLOEXEC);
+	fd = openattr(0, attr, O_RDWR | O_CLOEXEC);
 	if (fd < 0)
 		return -1;
 	if (context) {
@@ -279,8 +236,8 @@ out:
 	}
 }
 
-static int setprocattrcon(const char * context,
-			  pid_t pid, const char *attr)
+static int setprocattrcon(const char *context, const char *attr,
+			  char **prev_context)
 {
 	int ret;
 	char * rcontext;
@@ -288,62 +245,58 @@ static int setprocattrcon(const char * context,
 	if (selinux_trans_to_raw_context(context, &rcontext))
 		return -1;
 
-	ret = setprocattrcon_raw(rcontext, pid, attr);
+	ret = setprocattrcon_raw(rcontext, attr, prev_context);
 
 	freecon(rcontext);
 
 	return ret;
 }
 
-#define getselfattr_def(fn, attr) \
+#define getselfattr_def(fn, attr, prev_context) \
 	int get##fn##_raw(char **c) \
 	{ \
-		return getprocattrcon_raw(c, 0, #attr); \
+		return getprocattrcon_raw(c, 0, attr, prev_context); \
 	} \
 	int get##fn(char **c) \
 	{ \
-		return getprocattrcon(c, 0, #attr); \
+		return getprocattrcon(c, 0, attr, prev_context); \
 	}
 
-#define setselfattr_def(fn, attr) \
+#define setselfattr_def(fn, attr, prev_context) \
 	int set##fn##_raw(const char * c) \
 	{ \
-		return setprocattrcon_raw(c, 0, #attr); \
+		return setprocattrcon_raw(c, attr, &prev_context); \
 	} \
 	int set##fn(const char * c) \
 	{ \
-		return setprocattrcon(c, 0, #attr); \
+		return setprocattrcon(c, attr, &prev_context); \
 	}
 
-#define all_selfattr_def(fn, attr) \
-	getselfattr_def(fn, attr)	 \
-	setselfattr_def(fn, attr)
+#define all_selfattr_def(fn, attr, prev_context) \
+	getselfattr_def(fn, attr, prev_context)	 \
+	setselfattr_def(fn, attr, prev_context)
 
-#define getpidattr_def(fn, attr) \
-	int get##fn##_raw(pid_t pid, char **c)	\
-	{ \
-		if (pid <= 0) { \
-			errno = EINVAL; \
-			return -1; \
-		} else { \
-			return getprocattrcon_raw(c, pid, #attr); \
-		} \
-	} \
-	int get##fn(pid_t pid, char **c)	\
-	{ \
-		if (pid <= 0) { \
-			errno = EINVAL; \
-			return -1; \
-		} else { \
-			return getprocattrcon(c, pid, #attr); \
-		} \
-	}
+all_selfattr_def(con, "current", prev_current)
+    getselfattr_def(prevcon, "prev", NULL)
+    all_selfattr_def(execcon, "exec", prev_exec)
+    all_selfattr_def(fscreatecon, "fscreate", prev_fscreate)
+    all_selfattr_def(sockcreatecon, "sockcreate", prev_sockcreate)
+    all_selfattr_def(keycreatecon, "keycreate", prev_keycreate)
 
-all_selfattr_def(con, current)
-    getpidattr_def(pidcon, current)
-    getselfattr_def(prevcon, prev)
-    all_selfattr_def(execcon, exec)
-    all_selfattr_def(fscreatecon, fscreate)
-    all_selfattr_def(sockcreatecon, sockcreate)
-    all_selfattr_def(keycreatecon, keycreate)
+int getpidcon_raw(pid_t pid, char **c)
+{
+	if (pid <= 0) {
+		errno = EINVAL;
+		return -1;
+	}
+	return getprocattrcon_raw(c, pid, "current", NULL);
+}
 
+int getpidcon(pid_t pid, char **c)
+{
+	if (pid <= 0) {
+		errno = EINVAL;
+		return -1;
+	}
+	return getprocattrcon(c, pid, "current", NULL);
+}
-- 
2.36.1

