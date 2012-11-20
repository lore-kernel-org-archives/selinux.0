Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAKFT4qc030888
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2012 10:29:04 -0500
From: Guillem Jover <guillem@debian.org>
To: selinux@tycho.nsa.gov
Cc: rpm-maint@lists.rpm.org, debian-dpkg@lists.debian.org
Subject: [PATCH] libselinux: Refactor rpm_execcon() into a new setexecfilecon()
Date: Tue, 20 Nov 2012 16:27:55 +0100
Message-Id: <1353425275-10277-2-git-send-email-guillem@debian.org>
In-Reply-To: <1353425275-10277-1-git-send-email-guillem@debian.org>
References: <1353425275-10277-1-git-send-email-guillem@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This new function allows a process to invoke helper programs with
a new execution context based on the filename, this is initially
intended for package managers so that they can easily execute
package scriptlets or maintainer scripts.

Base rpm_execcon() off this new function.

Signed-off-by: Guillem Jover <guillem@debian.org>
---
 libselinux/Makefile                        |  3 +++
 libselinux/include/selinux/selinux.h       |  4 ++++
 libselinux/man/man3/getexeccon.3           | 23 ++++++++++++++++++++---
 libselinux/src/Makefile                    |  3 ---
 libselinux/src/{rpm.c => setexecfilecon.c} | 27 ++++++++++++++++++++-------
 5 files changed, 47 insertions(+), 13 deletions(-)
 rename libselinux/src/{rpm.c => setexecfilecon.c} (71%)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index fd4f0b1..6142b60 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -16,6 +16,9 @@ endif
 ifeq ($(DISABLE_BOOL),y)
 	EMFLAGS+= -DDISABLE_BOOL
 endif
+ifeq ($(DISABLE_RPM),y)
+	EMFLAGS+= -DDISABLE_RPM
+endif
 ifeq ($(DISABLE_SETRANS),y)
 	EMFLAGS+= -DDISABLE_SETRANS
 endif
diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 6b9089d..e1e965d 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -565,6 +565,10 @@ int selinuxfs_exists(void);
 /* clear selinuxmnt variable and free allocated memory */
 void fini_selinuxmnt(void);
 
+/* Set an appropriate security context based on the filename of a helper
+ * program, falling back to a new context with the specified type. */
+extern int setexecfilecon(const char *filename, const char *fallback_type);
+
 /* Execute a helper for rpm in an appropriate security context. */
 extern int rpm_execcon(unsigned int verified,
 		       const char *filename,
diff --git a/libselinux/man/man3/getexeccon.3 b/libselinux/man/man3/getexeccon.3
index c188a3a..1b66ab6 100644
--- a/libselinux/man/man3/getexeccon.3
+++ b/libselinux/man/man3/getexeccon.3
@@ -15,6 +15,8 @@ rpm_execcon \- run a helper for rpm in an appropriate security context
 .sp
 .BI "int setexeccon_raw(security_context_t "context );
 .sp
+.BI "int setexecfilecon(const char *" filename ", const char *" fallback_type );
+.sp
 .BI "int rpm_execcon(unsigned int " verified ", const char *" filename ", char *const " argv "[] , char *const " envp "[]);
 .
 .SH "DESCRIPTION"
@@ -62,7 +64,21 @@ Signal handlers that perform an
 must take care to
 save, reset, and restore the exec context to avoid unexpected behavior.
 
+.BR setexecfilecon ()
+sets the context used for the next
+.BR execve (2)
+call, based on the policy for the
+.IR filename ,
+and falling back to a new context with a
+.I fallback_type
+in case there is no transition.
+
 .BR rpm_execcon ()
+is deprecated; please use
+.BR setexecfilecon ()
+in conjunction with
+.BR execve (2)
+in all new code. This function
 runs a helper for rpm in an appropriate security context.  The
 verified parameter should contain the return code from the signature
 verification (0 == ok, 1 == notfound, 2 == verifyfail, 3 ==
@@ -76,10 +92,11 @@ environment arrays.
 On error \-1 is returned.
 
 On success
-.BR getexeccon ()
-and
+.BR getexeccon (),
 .BR setexeccon ()
-returns 0.
+and
+.BR setexecfilecon ()
+return 0.
 .BR rpm_execcon ()
 only returns upon errors, as it calls
 .BR execve (2).
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index ac019df..a7e5311 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -47,9 +47,6 @@ endif
 ifeq ($(DISABLE_BOOL),y)
 	UNUSED_SRCS+=booleans.c
 endif
-ifeq ($(DISABLE_RPM),y)
-	UNUSED_SRCS+=rpm.c
-endif
 
 GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
 SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(wildcard *.c))
diff --git a/libselinux/src/rpm.c b/libselinux/src/setexecfilecon.c
similarity index 71%
rename from libselinux/src/rpm.c
rename to libselinux/src/setexecfilecon.c
index b89f1bb..b3afa13 100644
--- a/libselinux/src/rpm.c
+++ b/libselinux/src/setexecfilecon.c
@@ -5,15 +5,14 @@
 #include "selinux_internal.h"
 #include "context_internal.h"
 
-int rpm_execcon(unsigned int verified __attribute__ ((unused)),
-		const char *filename, char *const argv[], char *const envp[])
+int setexecfilecon(const char *filename, const char *fallback_type)
 {
 	security_context_t mycon = NULL, fcon = NULL, newcon = NULL;
 	context_t con = NULL;
 	int rc = 0;
 
 	if (is_selinux_enabled() < 1)
-		return execve(filename, argv, envp);
+		return 0;
 
 	rc = getcon(&mycon);
 	if (rc < 0)
@@ -28,12 +27,12 @@ int rpm_execcon(unsigned int verified __attribute__ ((unused)),
 		goto out;
 
 	if (!strcmp(mycon, newcon)) {
-		/* No default transition, use rpm_script_t for now. */
+		/* No default transition, use fallback_type for now. */
 		rc = -1;
 		con = context_new(mycon);
 		if (!con)
 			goto out;
-		if (context_type_set(con, "rpm_script_t"))
+		if (context_type_set(con, fallback_type))
 			goto out;
 		freecon(newcon);
 		newcon = strdup(context_str(con));
@@ -47,8 +46,8 @@ int rpm_execcon(unsigned int verified __attribute__ ((unused)),
 		goto out;
       out:
 
-	if (rc >= 0 || security_getenforce() < 1)
-		rc = execve(filename, argv, envp);
+	if (rc < 0 && security_getenforce() == 0)
+		rc = 0;
 
 	context_free(con);
 	freecon(newcon);
@@ -56,3 +55,17 @@ int rpm_execcon(unsigned int verified __attribute__ ((unused)),
 	freecon(mycon);
 	return rc < 0 ? rc : 0;
 }
+
+#ifndef DISABLE_RPM
+int rpm_execcon(unsigned int verified __attribute__ ((unused)),
+		const char *filename, char *const argv[], char *const envp[])
+{
+	int rc;
+
+	rc = setexecfilecon(filename, "rpm_script_t");
+	if (rc < 0)
+		return rc;
+
+	return execve(filename, argv, envp);
+}
+#endif
-- 
1.8.0


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
