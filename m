Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA7IfnMA026526
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2005 13:41:49 -0500 (EST)
Subject: Re: [Fwd: [patch 1/1] selinux:  Extend selinuxfs context interface]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1131387140.20591.136.camel@moss-spartans.epoch.ncsc.mil>
References: <1131387140.20591.136.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-u534PQVq9ozIrSoq3AhK"
Date: Mon, 07 Nov 2005 13:31:59 -0500
Message-Id: <1131388319.20591.142.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-u534PQVq9ozIrSoq3AhK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-11-07 at 13:12 -0500, Stephen Smalley wrote:
> FYI, this patch has been submitted upstream in response to the
> previously raised issue with needing to canonicalize contexts for
> matchpathcon et al.

Patches for libselinux and policycoreutils (setfiles) to use this
support are attached.  Note that if the kernel doesn't support the
extended selinuxfs context interface, then the logic falls back to using
the original context, so there is no change in behavior in that case.

-- 
Stephen Smalley
National Security Agency

--=-u534PQVq9ozIrSoq3AhK
Content-Disposition: attachment; filename=libselinux-canon.diff
Content-Type: text/x-patch; name=libselinux-canon.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -X /home/sds/dontdiff -Nrup libselinux.old/include/selinux/selinux.h libselinux/include/selinux/selinux.h
--- libselinux.old/include/selinux/selinux.h	2005-10-27 08:16:36.000000000 -0400
+++ libselinux/include/selinux/selinux.h	2005-11-07 13:46:01.000000000 -0500
@@ -224,6 +224,12 @@ extern int security_load_booleans(char *
 extern int security_check_context(security_context_t con);
 extern int security_check_context_raw(security_context_t con);
 
+/* Canonicalize a security context. */
+extern int security_canonicalize_context(security_context_t con,
+					 security_context_t *canoncon);
+extern int security_canonicalize_context_raw(security_context_t con,
+					     security_context_t *canoncon);
+
 /* Get the enforce flag value. */
 extern int security_getenforce(void);
 
@@ -276,6 +282,14 @@ extern void set_matchpathcon_invalidcon(
 						 unsigned lineno, 
 						 char *context));
 
+/* Same as above, but also allows canonicalization of the context,
+   by changing *context to refer to the canonical form.  If not set,
+   and invalidcon is also not set, then this defaults to calling
+   security_canonicalize_context(). */
+extern void set_matchpathcon_canoncon(int (*f)(const char *path, 
+					       unsigned lineno, 
+					       char **context));
+
 /* Set flags controlling operation of matchpathcon_init or matchpathcon. */
 #define MATCHPATHCON_BASEONLY 1 /* Only process the base file_contexts file. */
 extern void set_matchpathcon_flags(unsigned int flags);
diff -X /home/sds/dontdiff -Nrup libselinux.old/src/canonicalize_context.c libselinux/src/canonicalize_context.c
--- libselinux.old/src/canonicalize_context.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux/src/canonicalize_context.c	2005-11-07 13:26:07.000000000 -0500
@@ -0,0 +1,87 @@
+#include <unistd.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <asm/page.h>
+#include "selinux_internal.h"
+#include "policy.h"
+#include <limits.h>
+
+int security_canonicalize_context_raw(security_context_t con,
+				      security_context_t *canoncon)
+{
+	char path[PATH_MAX];
+	char *buf;
+	size_t size;
+	int fd, ret;
+
+	snprintf(path, sizeof path, "%s/context", selinux_mnt);
+	fd = open(path, O_RDWR);
+	if (fd < 0)
+		return -1;
+
+	size = PAGE_SIZE;
+	buf = malloc(size);
+	if (!buf) {
+		ret = -1;
+		goto out;
+	}
+	strncpy(buf, con, size);
+
+	ret = write(fd, buf, strlen(buf)+1);
+	if (ret < 0)
+		goto out2;
+
+	memset(buf, 0, size);
+	ret = read(fd, buf, size-1);
+	if (ret < 0 && errno == EINVAL) {
+		/* Fall back to the original context for kernels
+		   that do not support the extended interface. */
+		strncpy(buf, con, size);
+	}
+
+	*canoncon = strdup(buf);
+	if (!(*canoncon)) {
+		ret = -1;
+		goto out2;
+	}
+	ret = 0;
+out2:
+	free(buf);
+out:	
+	close(fd);
+	return ret;
+}
+hidden_def(security_canonicalize_context_raw)
+
+int security_canonicalize_context(security_context_t con,
+				  security_context_t *canoncon)
+{
+	int ret;
+	security_context_t rcon = con;
+	security_context_t rcanoncon;
+
+	if (context_translations && trans_to_raw_context(con, &rcon))
+		return -1;
+
+ 	ret = security_canonicalize_context_raw(rcon, &rcanoncon);
+
+	if (context_translations) {
+		freecon(rcon);
+		if (!ret) {
+			if (raw_to_trans_context(rcanoncon, canoncon)) {
+				*canoncon = NULL;
+				ret = -1;
+			}
+			freecon(rcanoncon);
+		}
+	} else if (!ret) {
+		*canoncon = rcanoncon;
+	}
+
+	return ret;
+}
+hidden_def(security_canonicalize_context)
diff -X /home/sds/dontdiff -Nrup libselinux.old/src/matchpathcon.c libselinux/src/matchpathcon.c
--- libselinux.old/src/matchpathcon.c	2005-10-05 11:48:05.000000000 -0400
+++ libselinux/src/matchpathcon.c	2005-11-07 13:42:48.000000000 -0500
@@ -71,23 +71,35 @@ void set_matchpathcon_printf(void (*f)(c
 		myprintf = &default_printf;
 }
 
-static int default_invalidcon(const char *path, unsigned lineno, char *context)
+static int (*myinvalidcon)(const char *p, unsigned l, char *c) = NULL;
+
+void set_matchpathcon_invalidcon(int (*f)(const char *p, unsigned l, char *c))
+{
+	myinvalidcon = f;
+}
+
+static int default_canoncon(const char *path, unsigned lineno, char **context)
 {
-	if (security_check_context(context) < 0 && errno != ENOENT) {
-		myprintf("%s:  line %u has invalid context %s\n", path, lineno, context);
+	char *tmpcon;
+	if (security_canonicalize_context(*context, &tmpcon) < 0) {
+		if (errno == ENOENT)
+			return 0;
+		myprintf("%s:  line %u has invalid context %s\n", path, lineno, *context);
 		return 1;
 	}
+	free(*context);
+	*context = tmpcon;
 	return 0;
 }
 
-static int (*myinvalidcon)(const char *p, unsigned l, char *c) = &default_invalidcon;
+static int (*mycanoncon)(const char *p, unsigned l, char **c) = &default_canoncon;
 
-void set_matchpathcon_invalidcon(int (*f)(const char *p, unsigned l, char *c))
+void set_matchpathcon_canoncon(int (*f)(const char *p, unsigned l, char **c))
 {
 	if (f)
-		myinvalidcon = f;
+		mycanoncon = f;
 	else
-		myinvalidcon = &default_invalidcon;
+		mycanoncon = &default_canoncon;
 }
 
 static unsigned int myflags;
@@ -557,23 +569,30 @@ static int process_line( const char *pat
 		
 	skip_type:
 		if (strcmp(context, "<<none>>")) {
+			char *tmpcon = NULL;
 			if (context_translations) {
-				if (raw_to_trans_context(context,
-				                    &spec_arr[nspec].context)) {
+				if (raw_to_trans_context(context, &tmpcon)) {
 					myprintf("%s: line %u has invalid "
 					         "context %s\n",
 					         path, lineno, context);
 					return 0;
 				}
 				free(context);
-				context = spec_arr[nspec].context;
+				context = tmpcon;
 			} else {
 				if (STRIP_LEVEL(&context, mls_enabled))
 					return -1;
 			}
 
-			if (myinvalidcon(path, lineno, context))
-				return 0;
+			if (myinvalidcon) {
+				/* Old-style validation of context. */
+				if (myinvalidcon(path, lineno, context)) 
+					return 0;
+			} else {
+				/* New canonicalization of context. */
+				if (mycanoncon(path, lineno, &context))
+					return 0;
+			}
 		}
 
 		spec_arr[nspec].context = context;
diff -X /home/sds/dontdiff -Nrup libselinux.old/src/selinux_internal.h libselinux/src/selinux_internal.h
--- libselinux.old/src/selinux_internal.h	2005-10-27 08:16:37.000000000 -0400
+++ libselinux/src/selinux_internal.h	2005-11-07 13:25:16.000000000 -0500
@@ -12,6 +12,8 @@ hidden_proto(security_set_boolean)
 hidden_proto(security_commit_booleans)
 hidden_proto(security_check_context)
 hidden_proto(security_check_context_raw)
+hidden_proto(security_canonicalize_context)
+hidden_proto(security_canonicalize_context_raw)
 hidden_proto(security_compute_av)
 hidden_proto(security_compute_av_raw)
 hidden_proto(security_compute_user)

--=-u534PQVq9ozIrSoq3AhK
Content-Disposition: attachment; filename=policycoreutils-canon.patch
Content-Type: text/x-patch; name=policycoreutils-canon.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/setfiles/setfiles.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/setfiles/setfiles.c,v
retrieving revision 1.37
diff -u -p -r1.37 setfiles.c
--- policycoreutils/setfiles/setfiles.c	20 Sep 2005 17:58:59 -0000	1.37
+++ policycoreutils/setfiles/setfiles.c	7 Nov 2005 18:44:20 -0000
@@ -382,8 +382,9 @@ void set_rootpath(const char *arg)
 	rootpathlen = len;
 }
 
-int invalidcon(const char *path, unsigned lineno, char *context)
+int canoncon(const char *path, unsigned lineno, char **contextp)
 {
+	char *context = *contextp, *tmpcon;
 	int valid = 1;
 
 	if (policyfile) {
@@ -394,9 +395,14 @@ int invalidcon(const char *path, unsigne
 			valid = (sepol_check_context (raw) >= 0);
 			freecon(raw);
 		}
-	} else if (security_check_context((char *) context) < 0 && errno != ENOENT) {
-		valid = 0;
-		inc_err();
+	} else if (security_canonicalize_context(context, &tmpcon) < 0) {
+		if (errno != ENOENT) {
+			valid = 0;
+			inc_err();
+		}
+	} else {
+		free(context);
+		*contextp = tmpcon;
 	}
 
 	if (!valid) {
@@ -519,7 +525,7 @@ int main(int argc, char **argv)
 	/* Use our own invalid context checking function so that
 	   we can support either checking against the active policy or
 	   checking against a binary policy file. */
-	set_matchpathcon_invalidcon(&invalidcon);
+	set_matchpathcon_canoncon(&canoncon);
 
 	/* Load the file contexts configuration and check it. */
 	rc = matchpathcon_init(argv[optind]);

--=-u534PQVq9ozIrSoq3AhK--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
