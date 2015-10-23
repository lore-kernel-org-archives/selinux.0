Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9NDV9oI024642
 for <selinux@tycho.nsa.gov>; Fri, 23 Oct 2015 09:31:09 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH V3] libselinux: Add selinux_restorecon function
Date: Fri, 23 Oct 2015 14:30:27 +0100
Message-Id: <1445607027-8926-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The selinux_restorecon(3) man page details this function.

It has been built using the work from Android where an SHA1 hash
of the specfiles is held in an extended attribute to enhance
performance. Also contains components from policycoreutils/setfiles.

The utils/selinux_restorecon.c utility demonstrates the functionality.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Changes:
Added exclude_list to function, updated util to test and man page
Fixed xdev to use fts correctly.
V3 Changes:
Added changes as per:
http://marc.info/?l=selinux&m=144355845129121&w=2
http://marc.info/?l=selinux&m=144442104813915&w=2
Support a SELINUX_RESTORECON_PROGRESS option.

 libselinux/include/selinux/restorecon.h            |  79 ++++
 libselinux/man/man3/selinux_restorecon.3           | 195 +++++++++
 .../man/man3/selinux_restorecon_default_handle.3   |  59 +++
 .../man/man3/selinux_restorecon_set_exclude_list.3 |  32 ++
 .../man/man3/selinux_restorecon_set_sehandle.3     |  39 ++
 libselinux/src/Makefile                            |   2 +-
 libselinux/src/selinux_restorecon.c                | 486 +++++++++++++++++++++
 libselinux/utils/Makefile                          |   2 +
 libselinux/utils/selinux_restorecon.c              | 263 +++++++++++
 9 files changed, 1156 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/include/selinux/restorecon.h
 create mode 100644 libselinux/man/man3/selinux_restorecon.3
 create mode 100644 libselinux/man/man3/selinux_restorecon_default_handle.3
 create mode 100644 libselinux/man/man3/selinux_restorecon_set_exclude_list.3
 create mode 100644 libselinux/man/man3/selinux_restorecon_set_sehandle.3
 create mode 100644 libselinux/src/selinux_restorecon.c
 create mode 100644 libselinux/utils/selinux_restorecon.c

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
new file mode 100644
index 0000000..ba1232e
--- /dev/null
+++ b/libselinux/include/selinux/restorecon.h
@@ -0,0 +1,79 @@
+#ifndef _RESTORECON_H_
+#define _RESTORECON_H_
+
+#include <sys/types.h>
+#include <stdarg.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * selinux_restorecon - Relabel files.
+ * @pathname: specifies file/directory to relabel.
+ * @restorecon_flags: specifies the actions to be performed when relabeling.
+ *
+ * selinux_restorecon(3) will automatically call
+ * selinux_restorecon_default_handle(3) and selinux_restorecon_set_sehandle(3)
+ * first time through to set the selabel_open(3) parameters to use the
+ * currently loaded policy file_contexts and request their computed digest.
+ *
+ * Should other selabel_open(3) parameters be required see
+ * selinux_restorecon_set_sehandle(3).
+ */
+extern int selinux_restorecon(const char *pathname,
+				    unsigned int restorecon_flags);
+/*
+ * restorecon_flags options
+ */
+/* Force the checking of labels even if the stored SHA1
+ * digest matches the specfiles SHA1 digest. */
+#define SELINUX_RESTORECON_IGNORE_DIGEST		1
+/* Do not change file labels */
+#define SELINUX_RESTORECON_NOCHANGE			2
+/* If set set change file label to that in spec file.
+ * If not only change type component to that in spec file. */
+#define SELINUX_RESTORECON_SET_SPECFILE_CTX		4
+/* Recursively descend directories */
+#define SELINUX_RESTORECON_RECURSE			8
+/* Log changes to selinux log. Note that if VERBOSE and
+ * PROGRESS are set, then PROGRESS will take precedence. */
+#define SELINUX_RESTORECON_VERBOSE			16
+/* Show progress by printing * to stdout every 1000 files */
+#define SELINUX_RESTORECON_PROGRESS			32
+/* Convert passed-in pathname to canonical pathname */
+#define SELINUX_RESTORECON_REALPATH			64
+/* Prevent descending into directories that have a different
+ * device number than the pathname from which the descent began */
+#define SELINUX_RESTORECON_XDEV				128
+
+/**
+ * selinux_restorecon_set_sehandle - Set the global fc handle.
+ * @handle: specifies handle to set as the global fc handle.
+ *
+ * Called by a process that has already called selabel_open(3) with it's
+ * required parameters, or if selinux_restorecon_default_handle(3) has been
+ * called to set the default selabel_open(3) parameters.
+ */
+extern void selinux_restorecon_set_sehandle(struct selabel_handle *hndl);
+
+/**
+ * selinux_restorecon_default_handle - Sets default selabel_open(3) parameters
+ *				       to use the currently loaded policy and
+ *				       file_contexts, also requests the digest.
+ */
+extern struct selabel_handle *selinux_restorecon_default_handle(void);
+
+/**
+ * selinux_restorecon_set_exclude_list - Add a list of files or
+ *					 directories that are to be excluded
+ *					 from relabeling.
+ * @exclude_list: containing a NULL terminated list of one or more
+ *		  directories or files not to be relabeled.
+ */
+extern void selinux_restorecon_set_exclude_list(const char **exclude_list);
+
+#ifdef __cplusplus
+}
+#endif
+#endif
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
new file mode 100644
index 0000000..152b29c
--- /dev/null
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -0,0 +1,195 @@
+.TH "selinux_restorecon" "3" "20 Oct 2015" "Security Enhanced Linux" "SELinux API documentation"
+
+.SH "NAME"
+selinux_restorecon \- restore file(s) default SELinux security contexts
+.
+.SH "SYNOPSIS"
+.B #include <selinux/restorecon.h>
+.sp
+.BI "int selinux_restorecon(const char **" pathname ,
+.in +\w'int selinux_restorecon('u
+.br
+.BI "unsigned int " restorecon_flags ");"
+.in
+.
+.SH "DESCRIPTION"
+.BR selinux_restorecon ()
+restores file default security contexts based on:
+.sp
+.RS
+.IR pathname
+containing a directory or file to be relabeled.
+.br
+If this is a directory and the
+.IR restorecon_flags
+.B SELINUX_RESTORECON_RECURSE
+has been set (for decending through directories), then
+.BR selinux_restorecon ()
+will write an SHA1 digest of the combined specfiles (see the
+.B NOTES
+section for details) to an extended attribute of
+.IR security.restorecon_last
+once the relabeling has been completed successfully. This digest will be
+checked should
+.BR selinux_restorecon ()
+be rerun
+with the
+.IR restorecon_flags
+.B SELINUX_RESTORECON_RECURSE
+flag set. If any of the specfiles had been updated, the digest
+will also be updated. However if the digest is the same, no relabeling checks
+will take place (unless the
+.B SELINUX_RESTORECON_IGNORE_DIGEST
+is set).
+.sp
+.IR restorecon_flags
+contains the labeling option/rules as follows:
+.sp
+.RS
+.sp
+.B SELINUX_RESTORECON_IGNORE_DIGEST
+force the checking of labels even if the stored SHA1 digest matches the
+specfiles SHA1 digest. The specfiles digest will be written to the
+.IR security.restorecon_last
+extended attribute once relabeling has been completed successfully provided the
+.B SELINUX_RESTORECON_NOCHANGE
+has not been set.
+.sp
+.B SELINUX_RESTORECON_NOCHANGE
+don't change any file labels (passive check) or update the digest in the
+.IR security.restorecon_last
+extended attribute.
+.sp
+.B SELINUX_RESTORECON_SET_SPECFILE_CTX
+If set, reset the files label to match the default specfile context.
+if not set only reset the files "type" component of the context to match the
+default specfile context.
+.br
+
+.sp
+.B SELINUX_RESTORECON_RECURSE
+change file and directory labels recursively (descend directories)
+and if successful write an SHA1 digest of the combined specfiles to an
+extended attribute as described in the
+.B NOTES
+section.
+.sp
+.B SELINUX_RESTORECON_VERBOSE
+log file label changes.
+.RS
+Note that if
+.B SELINUX_RESTORECON_VERBOSE
+and
+.B SELINUX_RESTORECON_PROGRESS
+are set, then
+.B SELINUX_RESTORECON_PROGRESS
+will take precedence.
+.RE
+.sp
+.B SELINUX_RESTORECON_PROGRESS
+show progress by printing * to stdout every 1000 files.
+.sp
+.B SELINUX_RESTORECON_REALPATH
+convert passed-in
+.I pathname
+to the canonical pathname using
+.BR realpath (3).
+.sp
+.B SELINUX_RESTORECON_XDEV
+prevent descending into directories that have a different device number than
+the
+.I pathname
+entry from which the descent began.
+.RE
+.sp
+The behavior regarding the checking and updating of the SHA1 digest described
+above is the default behavior. It is possible to change this by first calling
+.BR selabel_open (3)
+and not enabling the
+.B SELABEL_OPT_DIGEST
+option, then calling
+.BR selinux_restorecon_set_sehandle (3)
+to set the handle to be used by
+.BR selinux_restorecon (3).
+.sp
+If the
+.I pathname
+is a directory path, then it is possible to set files/directories to be exluded
+from the path by calling
+.BR selinux_restorecon_set_exclude_list (3)
+with a
+.B NULL
+terminated list before calling
+.BR selinux_restorecon (3).
+.RE
+.
+.SH "RETURN VALUE"
+On success, zero is returned.  On error, \-1 is returned and
+.I errno
+is set appropriately.
+.
+.SH "NOTES"
+To improve performance when relabeling file systems recursively (e.g. the
+.IR restorecon_flags
+.B SELINUX_RESTORECON_RECURSE
+flag is set)
+.BR selinux_restorecon ()
+will write an SHA1 digest of the specfiles that are processed by
+.BR selabel_open (3)
+to an extended attribute named
+.IR security.restorecon_last
+to the directory specified in the
+.IR pathname .
+.sp
+To check the extended attribute entry use
+.BR getfattr (1) ,
+for example:
+.sp
+.RS
+getfattr -e hex -n security.restorecon_last /
+.RE
+.sp
+The SHA1 digest is calculated by
+.BR selabel_open (3)
+concatenating the specfiles it reads during initialisation with the
+resulting digest and list of specfiles being retrieved by
+.BR selabel_digest (3).
+.sp
+The specfiles consist of the mandatory
+.I file_contexts
+file plus any subs, subs_dist, local and homedir entries (text or binary versions)
+as determined by any
+.BR selabel_open (3)
+options e.g.
+.BR SELABEL_OPT_BASEONLY .
+.sp
+Should any of the specfiles have changed, then when
+.BR selinux_restorecon ()
+is run again with the
+.B SELINUX_RESTORECON_RECURSE
+flag set, a new SHA1 digest will be calculated and all files will be automatically
+relabeled depending on the settings of the
+.B SELINUX_RESTORECON_SET_SPECFILE_CTX
+flag (provided
+.B SELINUX_RESTORECON_NOCHANGE
+is not set).
+.sp
+.B /sys
+and in-memory filesystems do not support the
+.IR security.restorecon_last
+extended attribute.
+.sp
+.BR selinux_restorecon ()
+does not check whether the mounted filesystems support the
+.B seclabel
+option. These should be set by the caller by
+.BR selinux_restorecon_set_exclude_list (3)
+in the
+.IR exclude_list .
+.
+.SH "SEE ALSO"
+.BR selinux_restorecon_set_sehandle (3),
+.br
+.BR selinux_restorecon_default_handle (3),
+.br
+.BR selinux_restorecon_set_exclude_list (3),
diff --git a/libselinux/man/man3/selinux_restorecon_default_handle.3 b/libselinux/man/man3/selinux_restorecon_default_handle.3
new file mode 100644
index 0000000..0f1e737
--- /dev/null
+++ b/libselinux/man/man3/selinux_restorecon_default_handle.3
@@ -0,0 +1,59 @@
+.TH "selinux_restorecon_default_handle" "3" "20 Oct 2015" "Security Enhanced Linux" "SELinux API documentation"
+
+.SH "NAME"
+selinux_restorecon_default_handle \- sets default parameters for
+.BR selinux_restorecon (3)
+.
+.SH "SYNOPSIS"
+.B #include <selinux/restorecon.h>
+.br
+.B #include <selinux/label.h>
+.sp
+.B "struct selabel_handle *selinux_restorecon_default_handle(void);"
+.
+.SH "DESCRIPTION"
+.BR selinux_restorecon_default_handle ()
+sets default parameters for
+.BR selinux_restorecon (3)
+by calling
+.BR selabel_open (3)
+with the
+.B SELABEL_OPT_DIGEST
+option only. This will enable a digest to be calculated on the currently
+loaded policy
+.BR file_contexts (5)
+set of files as described in the
+.B NOTES
+section of
+.BR selinux_restorecon (3).
+.sp
+Calling
+.BR selinux_restorecon_default_handle ()
+is optional, however if used then
+.BR selinux_restorecon_set_sehandle (3)
+should be called with the returned handle to set this for use by
+.BR selinux_restorecon (3).
+.sp
+.BR selinux_restorecon_default_handle ()
+is optional as
+.BR selinux_restorecon (3)
+will automatically call this and
+.BR selinux_restorecon_set_sehandle (3)
+provided a handle has not already been set, for
+example by
+.BR selinux_restorecon_set_sehandle (3)
+to set customised
+.BR selabel_open (3)
+parameters.
+.
+.SH "RETURN VALUE"
+A non\-NULL handle value is returned on success. On error, NULL is returned and
+.I errno
+is set appropriately.
+.
+.SH "SEE ALSO"
+.BR selinux_restorecon (3),
+.br
+.BR selinux_restorecon_set_sehandle (3),
+.br
+.BR selinux_restorecon_set_exclude_list (3)
diff --git a/libselinux/man/man3/selinux_restorecon_set_exclude_list.3 b/libselinux/man/man3/selinux_restorecon_set_exclude_list.3
new file mode 100644
index 0000000..ea1fb78
--- /dev/null
+++ b/libselinux/man/man3/selinux_restorecon_set_exclude_list.3
@@ -0,0 +1,32 @@
+.TH "selinux_restorecon_set_exclude_list" "3" "20 Oct 2015" "Security Enhanced Linux" "SELinux API documentation"
+
+.SH "NAME"
+selinux_restorecon_set_exclude_list \- set list of files/directories to be
+excluded from relabeling.
+.
+.SH "SYNOPSIS"
+.B #include <selinux/restorecon.h>
+.sp
+.BI "void selinux_restorecon_set_exclude_list(const char **" exclude_list ");"
+.in +\w'void selinux_restorecon_set_exclude_list('u
+.
+.SH "DESCRIPTION"
+.BR selinux_restorecon_set_exclude_list ()
+passes to
+.BR selinux_restorecon (3)
+a pointer containing a
+.B NULL
+terminated list of one or more directories or files that are not to be
+relabeled in
+.IR exclude_list .
+.sp
+.BR selinux_restorecon_set_exclude_list ()
+must be called prior to
+.BR selinux_restorecon (3).
+.
+.SH "SEE ALSO"
+.BR selinux_restorecon (3),
+.br
+.BR selinux_restorecon_set_sehandle (3),
+.br
+.BR selinux_restorecon_default_handle (3)
diff --git a/libselinux/man/man3/selinux_restorecon_set_sehandle.3 b/libselinux/man/man3/selinux_restorecon_set_sehandle.3
new file mode 100644
index 0000000..6182f54
--- /dev/null
+++ b/libselinux/man/man3/selinux_restorecon_set_sehandle.3
@@ -0,0 +1,39 @@
+.TH "selinux_restorecon_set_sehandle" "3" "20 Oct 2015" "Security Enhanced Linux" "SELinux API documentation"
+
+.SH "NAME"
+selinux_restorecon_set_sehandle \- set a labeling handle for use by
+.BR selinux_restorecon (3)
+.
+.SH "SYNOPSIS"
+.B #include <selinux/restorecon.h>
+.br
+.B #include <selinux/label.h>
+.sp
+.BI "void selinux_restorecon_set_sehandle(struct selabel_handle *" handle ");"
+.in +\w'void selinux_restorecon_set_sehandle('u
+.
+.SH "DESCRIPTION"
+.BR selinux_restorecon_set_sehandle ()
+sets the
+.I handle
+to be use by
+.BR selinux_restorecon (3)
+when relabeling files.
+.sp
+.BR selinux_restorecon_set_sehandle ()
+is generally used when customised
+.BR selabel_open (3)
+parameters are required to perform relabeling operations with
+.BR selinux_restorecon (3).
+.sp
+.BR selinux_restorecon_set_sehandle ()
+will output to the default SELinux log information regarding whether a digest
+is available or not. If it were available, the message will contain the SHA1
+digest and a list of specfiles used to compute the digest.
+.
+.SH "SEE ALSO"
+.BR selinux_restorecon (3),
+.br
+.BR selinux_restorecon_set_exclude_list (3),
+.br
+.BR selinux_restorecon_default_handle (3)
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index feab561..21ca185 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -73,7 +73,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -fipa-pure-const -Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
           -Werror -Wno-aggregate-return -Wno-redundant-decls
 
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
+override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(EMFLAGS)
 
 SWIG_CFLAGS += -Wno-error -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter \
 		-Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
new file mode 100644
index 0000000..17ed6fe
--- /dev/null
+++ b/libselinux/src/selinux_restorecon.c
@@ -0,0 +1,486 @@
+/*
+ * The majority of this code is from Android's
+ * external/libselinux/src/android.c and upstream
+ * selinux/policycoreutils/setfiles/restorecon.c
+ *
+ * See selinux_restorecon(3) for details.
+ */
+
+#include <unistd.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <fts.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/xattr.h>
+#include <sys/vfs.h>
+#include <linux/magic.h>
+#include <libgen.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+#include <selinux/label.h>
+#include <selinux/restorecon.h>
+
+#include "callbacks.h"
+#include "selinux_internal.h"
+
+#define RESTORECON_LAST "security.restorecon_last"
+
+#define SYS_PATH "/sys"
+#define SYS_PREFIX SYS_PATH "/"
+
+static struct selabel_handle *fc_sehandle = NULL;
+static unsigned char *fc_digest = NULL;
+static size_t fc_digest_len = 0;
+static const char **fc_exclude_list = NULL;
+static size_t fc_count = 0;
+#define STAR_COUNT 1000
+
+static void restorecon_init(void)
+{
+	struct selabel_handle *sehandle = NULL;
+
+	if (!fc_sehandle) {
+		sehandle = selinux_restorecon_default_handle();
+		selinux_restorecon_set_sehandle(sehandle);
+	}
+}
+
+static pthread_once_t fc_once = PTHREAD_ONCE_INIT;
+
+
+static int check_excluded(const char *file)
+{
+	int i;
+
+	for (i = 0; fc_exclude_list[i]; i++) {
+		if (strcmp(file, fc_exclude_list[i]) == 0)
+				return 1;
+	}
+	return 0;
+}
+
+/* Called if SELINUX_RESTORECON_SET_SPECFILE_CTX is not set to check if
+ * the type components differ, updating newtypecon if so. */
+static int compare_types(char *curcon, char *newcon, char **newtypecon)
+{
+	int types_differ = 0;
+	context_t cona;
+	context_t conb;
+	int rc = 0;
+
+	cona = context_new(curcon);
+	if (!cona) {
+		rc = -1;
+		goto out;
+	}
+	conb = context_new(newcon);
+	if (!conb) {
+		context_free(cona);
+		rc = -1;
+		goto out;
+	}
+
+	types_differ = strcmp(context_type_get(cona), context_type_get(conb));
+	if (types_differ) {
+		rc |= context_user_set(conb, context_user_get(cona));
+		rc |= context_role_set(conb, context_role_get(cona));
+		rc |= context_range_set(conb, context_range_get(cona));
+		if (!rc) {
+			*newtypecon = strdup(context_str(conb));
+			if (!*newtypecon) {
+				rc = -1;
+				goto err;
+			}
+		}
+	}
+
+err:
+	context_free(cona);
+	context_free(conb);
+out:
+	return rc;
+}
+
+static int restorecon_sb(const char *pathname, const struct stat *sb,
+					    bool nochange, bool verbose,
+					    bool progress, bool specctx)
+{
+	char *newcon = NULL;
+	char *curcon = NULL;
+	char *newtypecon = NULL;
+	int rc = 0;
+	bool updated = false;
+
+	if (selabel_lookup_raw(fc_sehandle, &newcon, pathname, sb->st_mode) < 0)
+		return 0; /* no match, but not an error */
+
+	if (lgetfilecon_raw(pathname, &curcon) < 0) {
+		if (errno != ENODATA)
+			goto err;
+
+		curcon = NULL;
+	}
+
+	if (progress) {
+		fc_count++;
+		if (fc_count % STAR_COUNT == 0) {
+			fprintf(stdout, "*");
+			fflush(stdout);
+		}
+	}
+
+	if (strcmp(curcon, newcon) != 0) {
+		if (!specctx && curcon &&
+				    (is_context_customizable(curcon) > 0)) {
+			if (verbose) {
+				selinux_log(SELINUX_INFO,
+				 "%s not reset as customized by admin to %s\n",
+							    pathname, curcon);
+				goto out;
+			}
+		}
+
+		if (!specctx && curcon) {
+			/* If types different then update newcon. */
+			rc = compare_types(curcon, newcon, &newtypecon);
+			if (rc)
+				goto err;
+
+			if (newtypecon) {
+				freecon(newcon);
+				newcon = newtypecon;
+			} else {
+				goto out;
+			}
+		}
+
+		if (!nochange) {
+			if (lsetfilecon(pathname, newcon) < 0)
+				goto err;
+			updated = true;
+		}
+
+		if (verbose)
+			selinux_log(SELINUX_INFO,
+				    "%s %s from %s to %s\n",
+				    updated ? "Relabeled" : "Would relabel",
+				    pathname, curcon, newcon);
+	}
+
+out:
+	rc = 0;
+out1:
+	freecon(curcon);
+	freecon(newcon);
+	return rc;
+err:
+	selinux_log(SELINUX_ERROR,
+		    "Could not set context for %s:  %s\n",
+		    pathname, strerror(errno));
+	rc = -1;
+	goto out1;
+}
+
+/*
+ * Public API
+ */
+
+/* selinux_restorecon(3) - Main function that is responsible for labeling */
+int selinux_restorecon(const char *pathname_orig,
+				    unsigned int restorecon_flags)
+{
+	bool ignore = (restorecon_flags &
+		    SELINUX_RESTORECON_IGNORE_DIGEST) ? true : false;
+	bool nochange = (restorecon_flags &
+		    SELINUX_RESTORECON_NOCHANGE) ? true : false;
+	bool verbose = (restorecon_flags &
+		    SELINUX_RESTORECON_VERBOSE) ? true : false;
+	bool progress = (restorecon_flags &
+		    SELINUX_RESTORECON_PROGRESS) ? true : false;
+	bool recurse = (restorecon_flags &
+		    SELINUX_RESTORECON_RECURSE) ? true : false;
+	bool specctx = (restorecon_flags &
+		    SELINUX_RESTORECON_SET_SPECFILE_CTX) ? true : false;
+	bool userealpath = (restorecon_flags &
+		   SELINUX_RESTORECON_REALPATH) ? true : false;
+	bool xdev = (restorecon_flags &
+		   SELINUX_RESTORECON_XDEV) ? true : false;
+	bool issys;
+	bool setrestoreconlast = true; /* TRUE = set xattr RESTORECON_LAST
+					* FALSE = don't use xattr */
+	struct stat sb;
+	struct statfs sfsb;
+	FTS *fts;
+	FTSENT *ftsent;
+	char *pathname = NULL, *pathdnamer = NULL, *pathdname, *pathbname;
+	char *paths[2] = { NULL , NULL };
+	int fts_flags;
+	int error, sverrno;
+	char *xattr_value = NULL;
+	ssize_t size;
+
+	if (verbose && progress)
+		verbose = false;
+
+	__selinux_once(fc_once, restorecon_init);
+
+	if (!fc_sehandle)
+		return -1;
+
+	if (fc_digest_len) {
+		xattr_value = malloc(fc_digest_len);
+		if (!xattr_value)
+			return -1;
+	}
+
+	/*
+	 * Convert passed-in pathname to canonical pathname by resolving
+	 * realpath of containing dir, then appending last component name.
+	 */
+	if (userealpath) {
+		pathbname = basename((char *)pathname_orig);
+		if (!strcmp(pathbname, "/") || !strcmp(pathbname, ".") ||
+					    !strcmp(pathbname, "..")) {
+			pathname = realpath(pathname_orig, NULL);
+			if (!pathname)
+				goto realpatherr;
+		} else {
+			pathdname = dirname((char *)pathname_orig);
+			pathdnamer = realpath(pathdname, NULL);
+			if (!pathdnamer)
+				goto realpatherr;
+			if (!strcmp(pathdnamer, "/"))
+				error = asprintf(&pathname, "/%s", pathbname);
+			else
+				error = asprintf(&pathname, "%s/%s",
+						    pathdnamer, pathbname);
+			if (error < 0)
+				goto oom;
+		}
+	} else {
+		pathname = strdup(pathname_orig);
+		if (!pathname)
+			goto oom;
+	}
+
+	paths[0] = pathname;
+	issys = (!strcmp(pathname, SYS_PATH) ||
+			    !strncmp(pathname, SYS_PREFIX,
+			    sizeof(SYS_PREFIX) - 1)) ? true : false;
+
+	if (lstat(pathname, &sb) < 0) {
+		error = -1;
+		goto cleanup;
+	}
+
+	/* Ignore restoreconlast if not a directory */
+	if ((sb.st_mode & S_IFDIR) != S_IFDIR)
+		setrestoreconlast = false;
+
+	if (!recurse) {
+		error = restorecon_sb(pathname, &sb, nochange, verbose,
+						    progress, specctx);
+		goto cleanup;
+	}
+
+	/* Ignore restoreconlast on /sys */
+	if (issys)
+		setrestoreconlast = false;
+
+	/* Ignore restoreconlast on in-memory filesystems */
+	if (statfs(pathname, &sfsb) == 0) {
+		if (sfsb.f_type == RAMFS_MAGIC || sfsb.f_type == TMPFS_MAGIC)
+			setrestoreconlast = false;
+	}
+
+	if (setrestoreconlast) {
+		size = getxattr(pathname, RESTORECON_LAST, xattr_value,
+							    fc_digest_len);
+
+		if (!ignore && size == fc_digest_len &&
+			    memcmp(fc_digest, xattr_value, fc_digest_len)
+								    == 0) {
+			selinux_log(SELINUX_INFO,
+			    "Skipping restorecon as matching digest on: %s\n",
+				    pathname);
+			error = 0;
+			goto cleanup;
+		}
+	}
+
+	if (xdev)
+		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR | FTS_XDEV;
+	else
+		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
+
+	fts = fts_open(paths, fts_flags, NULL);
+	if (!fts) {
+		error = -1;
+		goto cleanup;
+	}
+
+	error = 0;
+	while ((ftsent = fts_read(fts)) != NULL) {
+		switch (ftsent->fts_info) {
+		case FTS_DC:
+			selinux_log(SELINUX_ERROR,
+				    "Directory cycle on %s.\n",
+				    ftsent->fts_path);
+			errno = ELOOP;
+			error = -1;
+			goto out;
+		case FTS_DP:
+			continue;
+		case FTS_DNR:
+			selinux_log(SELINUX_ERROR,
+				    "Could not read %s: %s.\n",
+				    ftsent->fts_path,
+						  strerror(ftsent->fts_errno));
+			fts_set(fts, ftsent, FTS_SKIP);
+			continue;
+		case FTS_NS:
+			selinux_log(SELINUX_ERROR,
+				    "Could not stat %s: %s.\n",
+				    ftsent->fts_path,
+						  strerror(ftsent->fts_errno));
+			fts_set(fts, ftsent, FTS_SKIP);
+			continue;
+		case FTS_ERR:
+			selinux_log(SELINUX_ERROR,
+				    "Error on %s: %s.\n",
+				    ftsent->fts_path,
+						  strerror(ftsent->fts_errno));
+			fts_set(fts, ftsent, FTS_SKIP);
+			continue;
+		case FTS_D:
+			if (issys && !selabel_partial_match(fc_sehandle,
+					    ftsent->fts_path)) {
+				fts_set(fts, ftsent, FTS_SKIP);
+				continue;
+			}
+			/* fall through */
+		default:
+			if (fc_exclude_list) {
+				if (check_excluded(ftsent->fts_path)) {
+					fts_set(fts, ftsent, FTS_SKIP);
+					continue;
+				}
+			}
+
+			error |= restorecon_sb(ftsent->fts_path,
+				    ftsent->fts_statp, nochange,
+				    verbose, progress, specctx);
+			break;
+		}
+	}
+
+	/* Labeling successful. Mark the top level directory as completed. */
+	if (setrestoreconlast && !nochange && !error) {
+		error = setxattr(pathname, RESTORECON_LAST, fc_digest,
+						    fc_digest_len, 0);
+		if (!error && verbose)
+			selinux_log(SELINUX_INFO,
+				   "Updated digest for: %s\n", pathname);
+	}
+
+out:
+	sverrno = errno;
+	(void) fts_close(fts);
+	errno = sverrno;
+cleanup:
+	free(pathdnamer);
+	free(pathname);
+	free(xattr_value);
+	return error;
+oom:
+	sverrno = errno;
+	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
+	errno = sverrno;
+	error = -1;
+	goto cleanup;
+realpatherr:
+	sverrno = errno;
+	selinux_log(SELINUX_ERROR,
+		    "SELinux: Could not get canonical path for %s restorecon: %s.\n",
+		    pathname_orig, strerror(errno));
+	errno = sverrno;
+	error = -1;
+	goto cleanup;
+}
+
+/* selinux_restorecon_set_sehandle(3) is called to set the global fc handle */
+void selinux_restorecon_set_sehandle(struct selabel_handle *hndl)
+{
+	char **specfiles, *sha1_buf = NULL;
+	size_t num_specfiles, i;
+
+	fc_sehandle = (struct selabel_handle *) hndl;
+
+	/* Read digest if requested in selabel_open(3).
+	 * If not the set global params. */
+	if (selabel_digest(hndl, &fc_digest, &fc_digest_len,
+				   &specfiles, &num_specfiles) < 0) {
+		fc_digest = NULL;
+		fc_digest_len = 0;
+		selinux_log(SELINUX_INFO, "Digest not requested.\n");
+		return;
+	}
+
+	sha1_buf = malloc(fc_digest_len * 2 + 1);
+	if (!sha1_buf) {
+		selinux_log(SELINUX_ERROR,
+			    "Error allocating digest buffer: %s\n",
+						    strerror(errno));
+		return;
+	}
+
+	for (i = 0; i < fc_digest_len; i++)
+		sprintf((&sha1_buf[i * 2]), "%02x", fc_digest[i]);
+
+	selinux_log(SELINUX_INFO,
+		    "specfiles SHA1 digest: %s\n", sha1_buf);
+	selinux_log(SELINUX_INFO,
+		    "calculated using the following specfile(s):\n");
+	if (specfiles) {
+		for (i = 0; i < num_specfiles; i++)
+			selinux_log(SELINUX_INFO,
+				    "%s\n", specfiles[i]);
+	}
+	free(sha1_buf);
+}
+
+/* selinux_restorecon_default_handle(3) is called to set the global restorecon
+ * handle by a process if the default params are required. */
+struct selabel_handle *selinux_restorecon_default_handle(void)
+{
+	struct selabel_handle *sehandle;
+
+	struct selinux_opt fc_opts[] = {
+		{ SELABEL_OPT_DIGEST, (char *)1 }
+	};
+
+	sehandle = selabel_open(SELABEL_CTX_FILE, fc_opts, 1);
+
+	if (!sehandle) {
+		selinux_log(SELINUX_ERROR,
+			    "Error obtaining file context handle: %s\n",
+						    strerror(errno));
+		return NULL;
+	}
+
+	return sehandle;
+}
+
+/* selinux_restorecon_set_exclude_list(3) is called to set a NULL terminated
+ * list of files/directories to exclude. */
+void selinux_restorecon_set_exclude_list(const char **exclude_list)
+{
+	fc_exclude_list = exclude_list;
+}
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index cac85c7..cf7af52 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -30,6 +30,8 @@ TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 sefcontext_compile: LDLIBS += -lpcre ../src/libselinux.a -lsepol
 
+selinux_restorecon: LDLIBS += -lsepol
+
 ifeq ($(DISABLE_AVC),y)
 	UNUSED_TARGETS+=compute_av compute_create compute_member compute_relabel
 endif
diff --git a/libselinux/utils/selinux_restorecon.c b/libselinux/utils/selinux_restorecon.c
new file mode 100644
index 0000000..52352c5
--- /dev/null
+++ b/libselinux/utils/selinux_restorecon.c
@@ -0,0 +1,263 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <sepol/sepol.h>
+#include <selinux/label.h>
+#include <selinux/restorecon.h>
+
+static char *policyfile;
+
+static char **exclude_list;
+static int exclude_count;
+
+static int validate_context(char **contextp)
+{
+	char *context = *contextp, *tmpcon;
+
+	if (policyfile) {
+		if (sepol_check_context(context) < 0) {
+			fprintf(stderr, "Invalid context %s\n", context);
+			exit(-1);
+		}
+	} else if (security_canonicalize_context_raw(context, &tmpcon) == 0) {
+		free(context);
+		*contextp = tmpcon;
+	} else if (errno != ENOENT) {
+		fprintf(stderr, "Validate context error: %s\n",
+						    strerror(errno));
+		exit(-1);
+	}
+
+	return 0;
+}
+
+static void usage(const char *progname)
+{
+	fprintf(stderr,
+		"\nusage: %s [-FCnRrdei] [-v|-P] [-p policy] [-f specfile] "
+		"pathname ...\n"
+		"Where:\n\t"
+		"-F  Set the label to that in specfile.\n\t"
+		"    If not set then reset the \"type\" component of the "
+		"label to that\n\t    in the specfile.\n\t"
+		"-C  Check labels even if the stored SHA1 digest matches\n\t"
+		"    the specfiles SHA1 digest.\n\t"
+		"-n  Don't change any file labels (passive check).\n\t"
+		"-R  Recursively change file and directory labels.\n\t"
+		"-v  Show changes in file labels (-v and -P are mutually "
+		" exclusive).\n\t"
+		"-P  Show progress by printing \"*\" to stdout every 1000 files.\n\t"
+		"-r  Use realpath(3) to convert pathnames to canonical form.\n\t"
+		"-d  Prevent descending into directories that have a "
+		"different\n\t    device number than the pathname from  which "
+		"the descent began.\n\t"
+		"-e  Exclude this file/directory (add multiple -e entries).\n\t"
+		"-i  Do not set SELABEL_OPT_VALIDATE option in selabel_open(3)"
+		" then call\n\t    selinux_restorecon_set_sehandle(3).\n\t"
+		"-p  Optional binary policy file (also sets validate context "
+		"option).\n\t"
+		"-f  Optional file contexts file.\n\t"
+		"pathname  One or more paths to relabel.\n\n",
+		progname);
+	exit(-1);
+}
+
+static void add_exclude(const char *directory)
+{
+	char **tmp_list;
+
+	if (directory == NULL || directory[0] != '/') {
+		fprintf(stderr, "Full path required for exclude: %s.\n",
+			directory);
+		exit(-1);
+	}
+
+	/* Add another two entries, one for directory, and the other to
+	 * terminate the list */
+	tmp_list = realloc(exclude_list, sizeof(char *) * (exclude_count + 2));
+	if (!tmp_list) {
+		fprintf(stderr, "ERROR: realloc failed.\n");
+		exit(-1);
+	}
+	exclude_list = tmp_list;
+
+	exclude_list[exclude_count] = strdup(directory);
+	if (!exclude_list[exclude_count]) {
+		fprintf(stderr, "ERROR: strdup failed.\n");
+		exit(-1);
+	}
+	exclude_count++;
+	exclude_list[exclude_count] = NULL;
+}
+
+int main(int argc, char **argv)
+{
+	int opt, i;
+	unsigned int restorecon_flags = 0;
+	char *path = NULL, *digest = NULL, *validate = NULL;
+	FILE *policystream;
+	bool ignore_digest = false, require_selinux = true;
+	bool verbose = false, progress = false;
+
+	struct selabel_handle *hnd = NULL;
+	struct selinux_opt selabel_option[] = {
+		{ SELABEL_OPT_PATH, path },
+		{ SELABEL_OPT_DIGEST, digest },
+		{ SELABEL_OPT_VALIDATE, validate }
+	};
+
+	if (argc < 2)
+		usage(argv[0]);
+
+	exclude_list = NULL;
+	exclude_count = 0;
+
+	while ((opt = getopt(argc, argv, "iFCnRvPrde:f:p:")) > 0) {
+		switch (opt) {
+		case 'F':
+			restorecon_flags |=
+					SELINUX_RESTORECON_SET_SPECFILE_CTX;
+			break;
+		case 'C':
+			restorecon_flags |=
+					SELINUX_RESTORECON_IGNORE_DIGEST;
+			break;
+		case 'n':
+			restorecon_flags |= SELINUX_RESTORECON_NOCHANGE;
+			break;
+		case 'R':
+			restorecon_flags |= SELINUX_RESTORECON_RECURSE;
+			break;
+		case 'v':
+			if (progress) {
+				fprintf(stderr,
+					"Progress and Verbose are mutually exclusive\n");
+				exit(-1);
+			}
+			verbose = true;
+			restorecon_flags |=  SELINUX_RESTORECON_VERBOSE;
+			break;
+		case 'P':
+			if (verbose) {
+				fprintf(stderr,
+					"Progress and Verbose are mutually exclusive\n");
+				exit(-1);
+			}
+			progress = true;
+			restorecon_flags |=  SELINUX_RESTORECON_PROGRESS;
+			break;
+		case 'r':
+			restorecon_flags |= SELINUX_RESTORECON_REALPATH;
+			break;
+		case 'd':
+			restorecon_flags |= SELINUX_RESTORECON_XDEV;
+			break;
+		case 'e':
+			add_exclude(optarg);
+			break;
+		case 'p':
+			policyfile = optarg;
+
+			policystream = fopen(policyfile, "r");
+			if (!policystream) {
+				fprintf(stderr,
+					"ERROR: opening %s: %s\n",
+					policyfile, strerror(errno));
+				exit(-1);
+			}
+
+			if (sepol_set_policydb_from_file(policystream) < 0) {
+				fprintf(stderr,
+					"ERROR: reading policy %s: %s\n",
+					policyfile, strerror(errno));
+				exit(-1);
+			}
+			fclose(policystream);
+
+			selinux_set_callback(SELINUX_CB_VALIDATE,
+				    (union selinux_callback)&validate_context);
+			require_selinux = false;
+			break;
+		case 'f':
+			path = optarg;
+			break;
+		case 'i':
+			ignore_digest = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (require_selinux && (is_selinux_enabled() <= 0)) {
+		fprintf(stderr,
+		    "SELinux must be enabled to perform this operation.\n");
+		exit(-1);
+	}
+
+	if (optind >= argc) {
+		fprintf(stderr, "No pathname specified\n");
+		exit(-1);
+	}
+
+	/* If any of these set then do our own selabel_open and pass
+	 * handle to selinux_restorecon */
+	if (ignore_digest || path || policyfile) {
+		if (path)
+			selabel_option[0].value = path;
+		else
+			selabel_option[0].value = NULL;
+
+		if (ignore_digest)
+			selabel_option[1].value = NULL;
+		else
+			selabel_option[1].value = (char *)1;
+
+		if (policyfile) /* Validate */
+			selabel_option[2].value = (char *)1;
+		else
+			selabel_option[2].value = NULL;
+
+		hnd = selabel_open(SELABEL_CTX_FILE, selabel_option, 3);
+		if (!hnd) {
+			switch (errno) {
+			case EOVERFLOW:
+				fprintf(stderr, "ERROR: Number of specfiles or"
+				    " specfile buffer caused an overflow.\n");
+				break;
+			default:
+				fprintf(stderr, "ERROR: selabel_open: %s\n",
+							    strerror(errno));
+			}
+			exit(-1);
+		}
+		selinux_restorecon_set_sehandle(hnd);
+	}
+
+	if (exclude_list)
+		selinux_restorecon_set_exclude_list
+						 ((const char **)exclude_list);
+
+	/* Call restorecon for each path in list */
+	for (i = optind; i < argc; i++) {
+		if (selinux_restorecon(argv[i], restorecon_flags) < 0) {
+			fprintf(stderr, "ERROR: selinux_restorecon: %s\n",
+					    strerror(errno));
+			exit(-1);
+		}
+	}
+
+	if (exclude_list) {
+		for (i = 0; exclude_list[i]; i++)
+			free(exclude_list[i]);
+		free(exclude_list);
+	}
+
+	if (hnd)
+		selabel_close(hnd);
+
+	return 0;
+}
-- 
2.4.3
