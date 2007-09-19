Subject: [patch] libsemanage, semodule:  Improve error reporting
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 14:29:40 -0400
Message-Id: <1190226580.25863.82.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change libsemanage to save errno values appropriately so they aren't lost
on cleanup paths and to include the strerror output in error messages.
Also change semodule to include strerror output as appropriate on some common error cases.

In particular, this yields useful error messages when invoking semodule
on a full filesystem or a read-only filesystem.  Erich Schubert reported this
as a bug a year ago.

Also fixes a couple of bugs in write() error checking in libsemanage.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 libsemanage/src/debug.c             |    7 +++++++
 libsemanage/src/semanage_store.c    |   34 +++++++++++++++++++++++++++-------
 policycoreutils/semodule/semodule.c |    8 ++++----
 3 files changed, 38 insertions(+), 11 deletions(-)

Index: trunk/libsemanage/src/debug.c
===================================================================
--- trunk/libsemanage/src/debug.c	(revision 2569)
+++ trunk/libsemanage/src/debug.c	(working copy)
@@ -23,6 +23,8 @@
 #include <stdarg.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <errno.h>
+#include <string.h>
 #include "handle.h"
 #include "debug.h"
 
@@ -55,10 +57,12 @@
 {
 
 	FILE *stream = NULL;
+	int errsv = 0;
 
 	switch (semanage_msg_get_level(handle)) {
 
 	case SEMANAGE_MSG_ERR:
+		errsv = errno;
 	case SEMANAGE_MSG_WARN:
 		stream = stderr;
 		break;
@@ -77,6 +81,9 @@
 	vfprintf(stream, fmt, ap);
 	va_end(ap);
 
+	if (errsv)
+		fprintf(stream, " %s.", strerror(errsv));
+
 	fprintf(stream, "\n");
 
 	varg = NULL;
Index: trunk/libsemanage/src/semanage_store.c
===================================================================
--- trunk/libsemanage/src/semanage_store.c	(revision 2569)
+++ trunk/libsemanage/src/semanage_store.c	(working copy)
@@ -437,7 +437,7 @@
  * overwrite it.  Returns 0 on success, -1 on error. */
 static int semanage_copy_file(const char *src, const char *dst, mode_t mode)
 {
-	int in, out, retval = 0, amount_read, n;
+	int in, out, retval = 0, amount_read, n, errsv = errno;
 	char tmp[PATH_MAX];
 	char buf[4192];
 
@@ -453,23 +453,32 @@
 		mode = S_IRUSR | S_IWUSR;
 
 	if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, mode)) == -1) {
+		errsv = errno;
 		close(in);
-		return -1;
+		retval = -1;
+		goto out;
 	}
 	while (retval == 0 && (amount_read = read(in, buf, sizeof(buf))) > 0) {
-		if (write(out, buf, amount_read) != amount_read) {
+		if (write(out, buf, amount_read) < 0) {
+			errsv = errno;
 			retval = -1;
 		}
 	}
-	if (amount_read < 0)
+	if (amount_read < 0) {
+		errsv = errno;
 		retval = -1;
+	}
 	close(in);
-	if (close(out) < 0)
+	if (close(out) < 0) {
+		errsv = errno;
 		retval = -1;
+	}
 
 	if (!retval && rename(tmp, dst) == -1)
 		return -1;
 
+out:
+	errno = errsv;
 	return retval;
 }
 
@@ -558,6 +567,7 @@
 {
 	const char *sandbox = semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);
 	struct stat buf;
+	int errsv;
 
 	if (stat(sandbox, &buf) == -1) {
 		if (errno != ENOENT) {
@@ -582,7 +592,9 @@
 	return 0;
 
       cleanup:
+	errsv = errno;
 	semanage_remove_directory(sandbox);
+	errno = errsv;
 	return -1;
 }
 
@@ -973,14 +985,14 @@
 		if (!strncmp(buf, "HOME_DIR", 8) ||
 		    !strncmp(buf, "HOME_ROOT", 9) || strstr(buf, "ROLE")) {
 			/* This contains one of the template variables, write it to homedir.template */
-			if (write(hd, buf, strlen(buf)) == 0) {
+			if (write(hd, buf, strlen(buf)) < 0) {
 				ERR(sh, "Write to %s failed.",
 				    semanage_path(SEMANAGE_TMP,
 						  SEMANAGE_HOMEDIR_TMPL));
 				goto cleanup;
 			}
 		} else {
-			if (write(fc, buf, strlen(buf)) == 0) {
+			if (write(fc, buf, strlen(buf)) < 0) {
 				ERR(sh, "Write to %s failed.",
 				    semanage_path(SEMANAGE_TMP, SEMANAGE_FC));
 				goto cleanup;
@@ -1226,6 +1238,7 @@
 		/* note that if an error occurs during the next three
 		 * function then the store will be left in an
 		 * inconsistent state */
+		int errsv = errno;
 		if (rename(active, sandbox) < 0)
 			ERR(sh, "Error while renaming %s back to %s.", active,
 			    sandbox);
@@ -1234,16 +1247,19 @@
 			    active);
 		else
 			semanage_install_active(sh);
+		errno = errsv;
 		retval = -1;
 		goto cleanup;
 	}
 
 	if (!sh->conf->save_previous) {
+		int errsv = errno;
 		retval = semanage_remove_directory(backup);
 		if (retval < 0) {
 			ERR(sh, "Could not delete previous directory %s.", backup);
 			goto cleanup;
 		}
+		errno = errsv;
 	}
 
       cleanup:
@@ -1409,22 +1425,26 @@
  * there. */
 void semanage_release_trans_lock(semanage_handle_t * sh)
 {
+	int errsv = errno;
 	if (sh->u.direct.translock_file_fd >= 0) {
 		flock(sh->u.direct.translock_file_fd, LOCK_UN);
 		close(sh->u.direct.translock_file_fd);
 		sh->u.direct.translock_file_fd = -1;
 	}
+	errno = errsv;
 }
 
 /* Releases the read lock.  Does nothing if there was not one already
  * there. */
 void semanage_release_active_lock(semanage_handle_t * sh)
 {
+	int errsv = errno;
 	if (sh->u.direct.activelock_file_fd >= 0) {
 		flock(sh->u.direct.activelock_file_fd, LOCK_UN);
 		close(sh->u.direct.activelock_file_fd);
 		sh->u.direct.activelock_file_fd = -1;
 	}
+	errno = errsv;
 }
 
 /* Read the current commit number from the commit number file which
Index: trunk/policycoreutils/semodule/semodule.c
===================================================================
--- trunk/policycoreutils/semodule/semodule.c	(revision 2569)
+++ trunk/policycoreutils/semodule/semodule.c	(working copy)
@@ -329,8 +329,8 @@
 
 	if (build) {
 		if ((result = semanage_begin_transaction(sh)) < 0) {
-			fprintf(stderr, "%s:  Could not begin transaction\n",
-				argv[0]);
+			fprintf(stderr, "%s:  Could not begin transaction:  %s\n",
+				argv[0], errno ? strerror(errno) : "");
 			goto cleanup;
 		}
 	}
@@ -343,8 +343,8 @@
 		if (mode == INSTALL_M || mode == UPGRADE_M || mode == BASE_M) {
 			if ((data_len = map_file(mode_arg, &data)) == 0) {
 				fprintf(stderr,
-					"%s:  Could not read file '%s':\n",
-					argv[0], mode_arg);
+					"%s:  Could not read file '%s': %s\n",
+					argv[0], mode_arg, errno ? strerror(errno) : "");
 				goto cleanup;
 			}
 		}



-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
