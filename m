Date: Thu, 20 Feb 2014 13:49:39 +0000
From: Colin Walters <walters@verbum.org>
Subject: [RFC] [PATCH] load_policy: Log errors using selinux_log
To: SELinux-NSA <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-aPhOoTbzFWu1RYzuZnX0"
Message-Id: <20140220135440.C93E9680220@frontend2.nyi.mail.srv.osa>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-aPhOoTbzFWu1RYzuZnX0
Content-Type: multipart/alternative; boundary="=-p1v5xTvhhrJpbb7BAFiN"

--=-p1v5xTvhhrJpbb7BAFiN
Content-Type: text/plain; charset=utf-8; format=flowed

This libselinux patch won't actually apply to git master of selinux, as 
it's really on top of the Fedora libselinux package which is carrying a 
patch to use LZMA compression.

This is more of a RFC - I wrote these patches to debug a problem which 
I've now (mostly) solved, but they may help someone else in the 
future...

One question - systemd git has this comment:

 /* Make sure we have no fds open while loading the policy and
 * transitioning */
 log_close();

Introduced by this commit:
http://cgit.freedesktop.org/systemd/systemd/commit/?id=0b3325e7

Is that really necessary?  Something relating to the labels of the fds? 
 If so, is there something we can do to allow logging?  I could 
probably change the systemd log handler to write to a memory buffer or 
something if it's necessary.

For reference I'm attaching my (currently somewhat unclean) systemd 
patch as well.



--=-p1v5xTvhhrJpbb7BAFiN
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div>This libselinux patch won't actually apply to git master of selinux, a=
s it's really on top of the Fedora libselinux package which is carrying a p=
atch to use LZMA compression.</div><div><br></div><div>This is more of a RF=
C - I wrote these patches to debug a problem which I've now (mostly) solved=
, but they may help someone else in the future...</div><div><br></div><div>=
One question - systemd git has this comment:</div><div><br></div><div>&nbsp=
;/* Make sure we have no fds open while loading the policy and</div><div>&n=
bsp;* transitioning */</div><div>&nbsp;log_close();</div><div><br></div><di=
v>Introduced by this commit:</div><div><a href=3D"http://cgit.freedesktop.o=
rg/systemd/systemd/commit/?id=3D0b3325e7">http://cgit.freedesktop.org/syste=
md/systemd/commit/?id=3D0b3325e7</a></div><div><br></div><div>Is that reall=
y necessary? &nbsp;Something relating to the labels of the fds? &nbsp;If so=
, is there something we can do to allow logging? &nbsp;I could probably cha=
nge the systemd log handler to write to a memory buffer or something if it'=
s necessary.</div><div><br></div><div>For reference I'm attaching my (curre=
ntly somewhat unclean) systemd patch as well.</div><div><br></div>=

--=-p1v5xTvhhrJpbb7BAFiN--

--=-aPhOoTbzFWu1RYzuZnX0
Content-Type: multipart/mixed; boundary="=-VT4XelhoimH5iwFsITh1"

--=-VT4XelhoimH5iwFsITh1
Content-Type: text/x-patch
Content-Disposition: attachment;
	filename=0001-load_policy-Log-errors-using-selinux_log.patch

>From 9166f72c56905192cc934063da8d7d6ad430491f Mon Sep 17 00:00:00 2001
From: Colin Walters <walters@verbum.org>
Date: Wed, 19 Feb 2014 13:19:06 -0500
Subject: [PATCH] load_policy: Log errors using selinux_log

I was attempting to debug early userspace policy load failures, and
presently systemd redirects stderr to /dev/null shortly before loading
policy.

With this patch, we will continue to log to stderr.  Now, I have a
patch for systemd which installs a log handler before loading policy,
which allows it to get these error messages and log them.
---
 src/load_policy.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/src/load_policy.c b/src/load_policy.c
index 275672d..c30a314 100644
--- a/src/load_policy.c
+++ b/src/load_policy.c
@@ -15,6 +15,7 @@
 #include <sepol/policydb.h>
 #include <dlfcn.h>
 #include "policy.h"
+#include "callbacks.h"
 #include <limits.h>
 #include <lzma.h>
 
@@ -251,9 +252,9 @@ checkbool:
 		fd = open(path, O_RDONLY);
 	}
 	if (fd < 0) {
-		fprintf(stderr,
-			"SELinux:  Could not open policy file <= %s.%d:  %s\n",
-			selinux_binary_policy_path(), maxvers, strerror(errno));
+		selinux_log(SELINUX_ERROR,
+			    "Could not open policy file <= %s.%d:  %s",
+			    selinux_binary_policy_path(), maxvers, strerror(errno));
 		goto dlclose;
 	}
 
@@ -261,9 +262,9 @@ checkbool:
 
 	if (!data) {
 		if (fstat(fd, &sb) < 0) {
-			fprintf(stderr,
-				"SELinux:  Could not stat policy file %s:  %s\n",
-			path, strerror(errno));
+			selinux_log(SELINUX_ERROR,
+				    "Could not stat policy file %s:  %s",
+				    path, strerror(errno));
 			goto close;
 		}
 		
@@ -274,9 +275,9 @@ checkbool:
 		size = sb.st_size;
 		data = map = mmap(NULL, size, prot, MAP_PRIVATE, fd, 0);
 		if (map == MAP_FAILED) {
-			fprintf(stderr,
-				"SELinux:  Could not map policy file %s:  %s\n",
-				path, strerror(errno));
+			selinux_log(SELINUX_ERROR,
+				    "Could not map policy file %s:  %s",
+				    path, strerror(errno));
 			goto close;
 		}
 	}
@@ -300,9 +301,9 @@ checkbool:
 		if (policydb_set_vers(policydb, kernvers) ||
 		    policydb_to_image(NULL, policydb, &data, &size)) {
 			/* Downgrade failed, keep searching. */
-			fprintf(stderr,
-				"SELinux:  Could not downgrade policy file %s, searching for an older version.\n",
-				path);
+			selinux_log(SELINUX_ERROR,
+				    "Could not downgrade policy file %s, searching for an older version.",
+				    path);
 			policy_file_free(pf);
 			policydb_free(policydb);
 			if (map)
@@ -362,9 +363,9 @@ checkbool:
 	rc = security_load_policy(data, size);
 	
 	if (rc)
-		fprintf(stderr,
-			"SELinux:  Could not load policy file %s:  %s\n",
-			path, strerror(errno));
+		selinux_log(SELINUX_ERROR,
+			    "Could not load policy file %s:  %s",
+			    path, strerror(errno));
 
       unmap:
 	if (data != map)
-- 
1.8.3.1


--=-VT4XelhoimH5iwFsITh1
Content-Type: text/x-patch
Content-Disposition: attachment;
	filename=0001-selinux-setup-Initialize-SELinux-logging-earlier.patch

>From 8cdd6cfc2e92c13bc93290887e9a07bc45aa94e8 Mon Sep 17 00:00:00 2001
From: Fedora systemd team <systemd-maint@redhat.com>
Date: Wed, 19 Feb 2014 17:19:54 -0500
Subject: [PATCH] selinux-setup: Initialize SELinux logging earlier

Presently systemd's early setup redirects stderr to /dev/null,
and also installs a log callback for SELinux that is a noop.

This makes it rather annoying to debug policy failures.  Now later on,
we do set up a log handler with libselinux - so this commit just moves
that earlier.

I can't think of good a reason to just /dev/null early errors from
SELinux, so this commit should just be better all around.
---
 src/core/main.c           |  7 +++++++
 src/core/selinux-access.c | 34 -------------------------------
 src/core/selinux-setup.c  | 51 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/src/core/main.c b/src/core/main.c
index 58c3a9e..34233ad 100644
--- a/src/core/main.c
+++ b/src/core/main.c
@@ -1291,11 +1291,18 @@ int main(int argc, char *argv[]) {
                 log_set_target(LOG_TARGET_KMSG);
                 log_open();
 
+                log_info("systemd starting: in_initrd:%d skip_setup: %d",
+                         in_initrd(),
+                         skip_setup);
+
                 if (in_initrd())
                         initrd_timestamp = userspace_timestamp;
 
                 if (!skip_setup) {
                         mount_setup_early();
+                }
+
+                if (!skip_setup && !in_initrd()) {
                         if (selinux_setup(&loaded_policy) < 0)
                                 goto finish;
                         if (ima_setup() < 0)
diff --git a/src/core/selinux-access.c b/src/core/selinux-access.c
index 0a3ee18..0f6fb0c 100644
--- a/src/core/selinux-access.c
+++ b/src/core/selinux-access.c
@@ -169,39 +169,6 @@ static int audit_callback(
 }
 
 /*
-   Any time an access gets denied this callback will be called
-   code copied from dbus. If audit is turned on the messages will go as
-   user_avc's into the /var/log/audit/audit.log, otherwise they will be
-   sent to syslog.
-*/
-_printf_attr_(2, 3) static int log_callback(int type, const char *fmt, ...) {
-        va_list ap;
-
-        va_start(ap, fmt);
-
-#ifdef HAVE_AUDIT
-        if (get_audit_fd() >= 0) {
-                _cleanup_free_ char *buf = NULL;
-                int r;
-
-                r = vasprintf(&buf, fmt, ap);
-                va_end(ap);
-
-                if (r >= 0) {
-                        audit_log_user_avc_message(get_audit_fd(), AUDIT_USER_AVC, buf, NULL, NULL, NULL, 0);
-                        return 0;
-                }
-
-                va_start(ap, fmt);
-        }
-#endif
-        log_metav(LOG_USER | LOG_INFO, __FILE__, __LINE__, __FUNCTION__, fmt, ap);
-        va_end(ap);
-
-        return 0;
-}
-
-/*
    Function must be called once to initialize the SELinux AVC environment.
    Sets up callbacks.
    If you want to cleanup memory you should need to call selinux_access_finish.
@@ -215,7 +182,6 @@ static int access_init(void) {
         }
 
         selinux_set_callback(SELINUX_CB_AUDIT, (union selinux_callback) audit_callback);
-        selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback) log_callback);
 
         if (security_getenforce() >= 0)
                 return 0;
diff --git a/src/core/selinux-setup.c b/src/core/selinux-setup.c
index 7a32ed5..628caa7 100644
--- a/src/core/selinux-setup.c
+++ b/src/core/selinux-setup.c
@@ -28,6 +28,9 @@
 #ifdef HAVE_SELINUX
 #include <selinux/selinux.h>
 #endif
+#ifdef HAVE_AUDIT
+#include <libaudit.h>
+#endif
 
 #include "selinux-setup.h"
 #include "selinux-util.h"
@@ -35,10 +38,47 @@
 #include "mount-setup.h"
 #include "macro.h"
 #include "util.h"
+#include "audit-fd.h"
 #include "log.h"
 
+#ifdef HAVE_AUDIT
+/* Avoid logging to audit until after we're done loading policy.
+ */
+static bool enable_audit_logging;
+#endif
+
 #ifdef HAVE_SELINUX
-static int null_log(int type, const char *fmt, ...) {
+/*
+   Any time an access gets denied this callback will be called
+   code copied from dbus. If audit is turned on the messages will go as
+   user_avc's into the /var/log/audit/audit.log, otherwise they will be
+   sent to syslog.
+*/
+_printf_attr_(2, 3) static int systemd_selinux_log_callback(int type, const char *fmt, ...) {
+        va_list ap;
+
+        log_info("In SELinux log callback type=%d fmt=%s", type, fmt);
+
+#ifdef HAVE_AUDIT
+        if (enable_audit_logging && get_audit_fd() >= 0) {
+                _cleanup_free_ char *buf = NULL;
+                int r;
+
+                va_start(ap, fmt);
+                r = vasprintf(&buf, fmt, ap);
+                va_end(ap);
+
+                if (r >= 0) {
+                        audit_log_user_avc_message(get_audit_fd(), AUDIT_USER_AVC, buf, NULL, NULL, NULL, 0);
+                        return 0;
+                }
+        }
+#endif
+
+        va_start(ap, fmt);
+        log_metav(LOG_USER | LOG_INFO, __FILE__, __LINE__, __FUNCTION__, fmt, ap);
+        va_end(ap);
+
         return 0;
 }
 #endif
@@ -54,8 +94,7 @@ int selinux_setup(bool *loaded_policy) {
 
        assert(loaded_policy);
 
-       /* Turn off all of SELinux' own logging, we want to do that */
-       cb.func_log = null_log;
+       cb.func_log = systemd_selinux_log_callback;
        selinux_set_callback(SELINUX_CB_LOG, cb);
 
        /* Already initialized by somebody else? */
@@ -73,6 +112,10 @@ int selinux_setup(bool *loaded_policy) {
        /* Make sure we have no fds open while loading the policy and
         * transitioning */
        log_close();
+       log_set_target(LOG_TARGET_CONSOLE);
+       log_open();
+
+       log_info("Preparing to load SELinux policy");
 
        /* Now load the policy */
        before_load = now(CLOCK_MONOTONIC);
@@ -104,7 +147,7 @@ int selinux_setup(bool *loaded_policy) {
                         format_timespan(timespan, sizeof(timespan), after_load - before_load, 0));
 
                *loaded_policy = true;
-
+               enable_audit_logging = true;
        } else {
                log_open();
 
-- 
1.8.3.1


--=-VT4XelhoimH5iwFsITh1--

--=-aPhOoTbzFWu1RYzuZnX0--
