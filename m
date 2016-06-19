Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5JJccbX030473
 for <selinux@tycho.nsa.gov>; Sun, 19 Jun 2016 15:38:38 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH V2 2/3] libselinux: Add setfiles support to
 selinux_restorecon(3)
Date: Sun, 19 Jun 2016 20:38:20 +0100
Message-Id: <1466365100-8091-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add additional error handling, flags, xdev handling, alt_rootpath
and add/remove non-seclabel fs's to support  setfiles(8)
functionality.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 changes as per http://marc.info/?l=selinux&m=146470835908849&w=2
plus selinux_restorecon_set_alt_rootpath() and
selinux_restorecon_set_exclude_list now return errors (were void before).

 libselinux/include/selinux/restorecon.h            |  49 ++-
 libselinux/man/man3/selinux_restorecon.3           |  73 +++-
 .../man/man3/selinux_restorecon_set_alt_rootpath.3 |  35 ++
 .../man/man3/selinux_restorecon_set_exclude_list.3 |  16 +-
 .../man/man3/selinux_restorecon_set_sehandle.3     |   4 +-
 libselinux/src/selinux_restorecon.c                | 453 +++++++++++++++++++--
 libselinux/utils/selinux_restorecon.c              |  42 +-
 7 files changed, 589 insertions(+), 83 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index 6ea328d..43fda98 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -50,7 +50,9 @@ extern int selinux_restorecon(const char *pathname,
  */
 #define SELINUX_RESTORECON_VERBOSE			0x0010
 /*
- * Show progress by printing * to stdout every 1000 files.
+ * Show progress by printing * to stdout every 1000 files, unless
+ * relabeling the entire OS, that will then show the approximate
+ * percentage complete.
  */
 #define SELINUX_RESTORECON_PROGRESS			0x0020
 /*
@@ -68,10 +70,31 @@ extern int selinux_restorecon(const char *pathname,
  * with the specification, then use the last matching specification.
  */
 #define SELINUX_RESTORECON_ADD_ASSOC			0x0100
+/*
+ * Abort on errors during the file tree walk.
+ */
+#define SELINUX_RESTORECON_ABORT_ON_ERROR		0x0200
+/*
+ * Log any label changes to syslog.
+ */
+#define SELINUX_RESTORECON_SYSLOG_CHANGES		0x0400
+/*
+ * Log what spec matched each file.
+ */
+#define SELINUX_RESTORECON_LOG_MATCHES			0x0800
+/*
+ * Ignore files that do not exist.
+ */
+#define SELINUX_RESTORECON_IGNORE_NOENTRY		0x1000
+/*
+ * Do not read /proc/mounts to obtain a list of non-seclabel
+ * mounts to be excluded from relabeling checks.
+ */
+#define SELINUX_RESTORECON_IGNORE_MOUNTS		0x2000
 
 /**
  * selinux_restorecon_set_sehandle - Set the global fc handle.
- * @handle: specifies handle to set as the global fc handle.
+ * @hndl: specifies handle to set as the global fc handle.
  *
  * Called by a process that has already called selabel_open(3) with it's
  * required parameters, or if selinux_restorecon_default_handle(3) has been
@@ -83,17 +106,29 @@ extern void selinux_restorecon_set_sehandle(struct selabel_handle *hndl);
  * selinux_restorecon_default_handle - Sets default selabel_open(3) parameters
  *				       to use the currently loaded policy and
  *				       file_contexts, also requests the digest.
+ *
+ * Return value is the created handle on success or NULL with @errno set on
+ * failure.
  */
 extern struct selabel_handle *selinux_restorecon_default_handle(void);
 
 /**
- * selinux_restorecon_set_exclude_list - Add a list of files or
- *					 directories that are to be excluded
- *					 from relabeling.
+ * selinux_restorecon_set_exclude_list - Add a list of directories that are to
+ *					 to be excluded from relabeling.
  * @exclude_list: containing a NULL terminated list of one or more
- *		  directories or files not to be relabeled.
+ *		  directories not to be relabeled.
+ *
+ * Return %0 on success, -%1 with @errno set on failure.
+ */
+extern int selinux_restorecon_set_exclude_list(const char **exclude_list);
+
+/**
+ * selinux_restorecon_set_alt_rootpath - Use alternate rootpath.
+ * @alt_rootpath: containing the alternate rootpath to be used.
+ *
+ * Return %0 on success, -%1 with @errno set on failure.
  */
-extern void selinux_restorecon_set_exclude_list(const char **exclude_list);
+extern int selinux_restorecon_set_alt_rootpath(const char *alt_rootpath);
 
 #ifdef __cplusplus
 }
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index e5a5a87..2e6f69d 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -82,13 +82,14 @@ Note that if
 .B SELINUX_RESTORECON_VERBOSE
 and
 .B SELINUX_RESTORECON_PROGRESS
-are set, then
+flags are set, then
 .B SELINUX_RESTORECON_PROGRESS
 will take precedence.
 .RE
 .sp
 .B SELINUX_RESTORECON_PROGRESS
-show progress by printing * to stdout every 1000 files.
+show progress by printing * to stdout every 1000 files unless relabeling the
+entire OS, that will then show the approximate percentage complete.
 .sp
 .B SELINUX_RESTORECON_REALPATH
 convert passed-in
@@ -106,6 +107,24 @@ entry from which the descent began.
 attempt to add an association between an inode and a specification. If there
 is already an association for the inode and it conflicts with the
 specification, then use the last matching specification.
+.sp
+.B SELINUX_RESTORECON_ABORT_ON_ERROR
+abort on errors during the file tree walk.
+.sp
+.B SELINUX_RESTORECON_SYSLOG_CHANGES
+log any label changes to
+.BR syslog (3).
+.sp
+.B SELINUX_RESTORECON_LOG_MATCHES
+log what specfile context matched each file.
+.sp
+.B SELINUX_RESTORECON_IGNORE_NOENTRY
+ignore files that do not exist.
+.sp
+.B SELINUX_RESTORECON_IGNORE_MOUNTS
+do not read
+.B /proc/mounts
+to obtain a list of non-seclabel mounts to be excluded from relabeling checks.
 .RE
 .sp
 The behavior regarding the checking and updating of the SHA1 digest described
@@ -120,13 +139,22 @@ to set the handle to be used by
 .sp
 If the
 .I pathname
-is a directory path, then it is possible to set files/directories to be
-excluded from the path by calling
+is a directory path, then it is possible to set directories to be excluded
+from the path by calling
 .BR selinux_restorecon_set_exclude_list (3)
 with a
 .B NULL
 terminated list before calling
 .BR selinux_restorecon (3).
+.sp
+By default
+.BR selinux_restorecon (3)
+reads
+.B /proc/mounts
+to obtain a list of non-seclabel mounts to be excluded from relabeling checks
+unless the
+.B SELINUX_RESTORECON_IGNORE_MOUNTS
+flag has been set.
 .RE
 .
 .SH "RETURN VALUE"
@@ -135,6 +163,7 @@ On success, zero is returned.  On error, \-1 is returned and
 is set appropriately.
 .
 .SH "NOTES"
+.IP "1." 4
 To improve performance when relabeling file systems recursively (e.g. the
 .IR restorecon_flags
 .B SELINUX_RESTORECON_RECURSE
@@ -146,21 +175,23 @@ to an extended attribute named
 .IR security.restorecon_last
 to the directory specified in the
 .IR pathname .
-.sp
+.IP "2." 4
 To check the extended attribute entry use
 .BR getfattr (1) ,
 for example:
 .sp
 .RS
+.RS
 getfattr -e hex -n security.restorecon_last /
 .RE
-.sp
+.RE
+.IP "3." 4
 The SHA1 digest is calculated by
 .BR selabel_open (3)
 concatenating the specfiles it reads during initialisation with the
 resulting digest and list of specfiles being retrieved by
 .BR selabel_digest (3).
-.sp
+.IP "4." 4
 The specfiles consist of the mandatory
 .I file_contexts
 file plus any subs, subs_dist, local and homedir entries (text or binary versions)
@@ -179,24 +210,20 @@ relabeled depending on the settings of the
 flag (provided
 .B SELINUX_RESTORECON_NOCHANGE
 is not set).
-.sp
+.IP "5." 4
 .B /sys
 and in-memory filesystems do not support the
 .IR security.restorecon_last
 extended attribute and are automatically excluded from any relabeling checks.
-.sp
-.BR selinux_restorecon ()
-does not check whether mounted filesystems support the
-.B seclabel
-option (i.e. support extended attributes as described in
-.BR xattr (7)).
-To exclude these filesystems from any relabeling checks
-.BR selinux_restorecon_set_exclude_list (3)
-should be called prior to
-.BR selinux_restorecon ()
-with a NULL terminated
-.IR exclude_list
-of these filesystems.
+.IP "6." 4
+By default
+.B stderr
+is used to log output messages and errors. This may be changed by calling
+.BR selinux_set_callback (3)
+with the
+.B SELINUX_CB_LOG
+.I type
+option.
 .
 .SH "SEE ALSO"
 .BR selinux_restorecon_set_sehandle (3),
@@ -204,3 +231,7 @@ of these filesystems.
 .BR selinux_restorecon_default_handle (3),
 .br
 .BR selinux_restorecon_set_exclude_list (3),
+.br
+.BR selinux_restorecon_set_alt_rootpath (3),
+.br
+.BR selinux_set_callback (3)
diff --git a/libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3 b/libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3
new file mode 100644
index 0000000..6a33421
--- /dev/null
+++ b/libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3
@@ -0,0 +1,35 @@
+.TH "selinux_restorecon_set_alt_rootpath" "3" "29 May 2016" "Security Enhanced Linux" "SELinux API documentation"
+
+.SH "NAME"
+selinux_restorecon_set_alt_rootpath \- set an alternate rootpath.
+.
+.SH "SYNOPSIS"
+.B #include <selinux/restorecon.h>
+.sp
+.BI "int selinux_restorecon_set_alt_rootpath(const char *" alt_rootpath ");"
+.in +\w'void selinux_restorecon_set_alt_rootpath('u
+.
+.SH "DESCRIPTION"
+.BR selinux_restorecon_set_alt_rootpath ()
+passes to
+.BR selinux_restorecon (3)
+a pointer containing an alternate rootpath
+.IR alt_rootpath .
+.sp
+.BR selinux_restorecon_set_alt_rootpath ()
+must be called prior to
+.BR selinux_restorecon (3).
+.
+.SH "RETURN VALUE"
+On success, zero is returned.  On error, \-1 is returned and
+.I errno
+is set appropriately.
+.
+.SH "SEE ALSO"
+.BR selinux_restorecon (3),
+.br
+.BR selinux_restorecon_set_sehandle (3),
+.br
+.BR selinux_restorecon_default_handle (3),
+.br
+.BR selinux_restorecon_set_exclude_list (3)
diff --git a/libselinux/man/man3/selinux_restorecon_set_exclude_list.3 b/libselinux/man/man3/selinux_restorecon_set_exclude_list.3
index ea1fb78..a5a8dc9 100644
--- a/libselinux/man/man3/selinux_restorecon_set_exclude_list.3
+++ b/libselinux/man/man3/selinux_restorecon_set_exclude_list.3
@@ -1,13 +1,13 @@
 .TH "selinux_restorecon_set_exclude_list" "3" "20 Oct 2015" "Security Enhanced Linux" "SELinux API documentation"
 
 .SH "NAME"
-selinux_restorecon_set_exclude_list \- set list of files/directories to be
+selinux_restorecon_set_exclude_list \- set list of directories to be
 excluded from relabeling.
 .
 .SH "SYNOPSIS"
 .B #include <selinux/restorecon.h>
 .sp
-.BI "void selinux_restorecon_set_exclude_list(const char **" exclude_list ");"
+.BI "int selinux_restorecon_set_exclude_list(const char **" exclude_list ");"
 .in +\w'void selinux_restorecon_set_exclude_list('u
 .
 .SH "DESCRIPTION"
@@ -16,17 +16,23 @@ passes to
 .BR selinux_restorecon (3)
 a pointer containing a
 .B NULL
-terminated list of one or more directories or files that are not to be
-relabeled in
+terminated list of one or more directories that are not to be relabeled in
 .IR exclude_list .
 .sp
 .BR selinux_restorecon_set_exclude_list ()
 must be called prior to
 .BR selinux_restorecon (3).
 .
+.SH "RETURN VALUE"
+On success, zero is returned.  On error, \-1 is returned and
+.I errno
+is set appropriately.
+.
 .SH "SEE ALSO"
 .BR selinux_restorecon (3),
 .br
 .BR selinux_restorecon_set_sehandle (3),
 .br
-.BR selinux_restorecon_default_handle (3)
+.BR selinux_restorecon_default_handle (3),
+.br
+.BR selinux_restorecon_set_alt_rootpath (3)
diff --git a/libselinux/man/man3/selinux_restorecon_set_sehandle.3 b/libselinux/man/man3/selinux_restorecon_set_sehandle.3
index 6182f54..30e0ad5 100644
--- a/libselinux/man/man3/selinux_restorecon_set_sehandle.3
+++ b/libselinux/man/man3/selinux_restorecon_set_sehandle.3
@@ -36,4 +36,6 @@ digest and a list of specfiles used to compute the digest.
 .br
 .BR selinux_restorecon_set_exclude_list (3),
 .br
-.BR selinux_restorecon_default_handle (3)
+.BR selinux_restorecon_default_handle (3),
+.br
+.BR selinux_restorecon_set_alt_rootpath (3)
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 7a355e7..6924c89 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1,7 +1,7 @@
 /*
  * The majority of this code is from Android's
  * external/libselinux/src/android.c and upstream
- * selinux/policycoreutils/setfiles/restorecon.c
+ * selinux/policycoreutils/setfiles/restore.c
  *
  * See selinux_restorecon(3) for details.
  */
@@ -16,12 +16,17 @@
 #include <fcntl.h>
 #include <fts.h>
 #include <limits.h>
+#include <stdint.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/xattr.h>
 #include <sys/vfs.h>
+#include <sys/statvfs.h>
+#include <sys/utsname.h>
 #include <linux/magic.h>
 #include <libgen.h>
+#include <syslog.h>
+
 #include <selinux/selinux.h>
 #include <selinux/context.h>
 #include <selinux/label.h>
@@ -35,12 +40,32 @@
 #define SYS_PATH "/sys"
 #define SYS_PREFIX SYS_PATH "/"
 
+#define STAR_COUNT 1000
+
 static struct selabel_handle *fc_sehandle = NULL;
 static unsigned char *fc_digest = NULL;
 static size_t fc_digest_len = 0;
-static const char **fc_exclude_list = NULL;
-static size_t fc_count = 0;
-#define STAR_COUNT 1000
+static char *rootpath = NULL;
+static int rootpathlen;
+
+/* Information on excluded fs and directories. */
+struct edir {
+	char *directory;
+	size_t size;
+};
+static bool ignore_mounts;
+static int exclude_non_seclabel_mounts(int exclude_from_ctr);
+static int exclude_count = 0;
+static struct edir *exclude_lst = NULL;
+static uint64_t fc_count = 0;	/* Number of files processed so far */
+static uint64_t efile_count;	/* Estimated total number of files */
+
+/*
+ * If SELINUX_RESTORECON_PROGRESS is set and mass_relabel = true, then
+ * output approx % complete, else output * for every STAR_COUNT files
+ * processed to stdout.
+ */
+static bool mass_relabel;
 
 /* restorecon_flags for passing to restorecon_sb() */
 struct rest_flags {
@@ -53,6 +78,10 @@ struct rest_flags {
 	bool recurse;
 	bool userealpath;
 	bool set_xdev;
+	bool abort_on_error;
+	bool syslog_changes;
+	bool log_matches;
+	bool ignore_noent;
 };
 
 static void restorecon_init(void)
@@ -63,26 +92,213 @@ static void restorecon_init(void)
 		sehandle = selinux_restorecon_default_handle();
 		selinux_restorecon_set_sehandle(sehandle);
 	}
+
+	efile_count = 0;
+	if (!ignore_mounts)
+		efile_count = exclude_non_seclabel_mounts(exclude_count);
 }
 
 static pthread_once_t fc_once = PTHREAD_ONCE_INIT;
 
-
-static int check_excluded(const char *file)
+/*
+ * Manage excluded directories:
+ *  remove_exclude() - This removes any conflicting entries as there could be
+ *                     a case where a non-seclabel fs is mounted on /foo and
+ *                     then a seclabel fs is mounted on top of it.
+ *
+ *  add_exclude()    - Add a directory/fs to be excluded from labeling.
+ *
+ *  check_excluded() - Check if directory/fs is to be excluded when relabeling.
+ *                     The only case where an excluded directory is ignored, is
+ *                     if the caller specifically requests that a directory
+ *                     is to be relabeled by calling selinux_restorecon(3)
+ *                     with that directory as the pathname parameter.
+ *
+ *  file_system_count() - Calculates the the number of files to be processed.
+ *                        The count is only used if SELINUX_RESTORECON_PROGRESS
+ *                        is set and a mass relabel is requested.
+ *
+ *  exclude_non_seclabel_mounts() - Reads /proc/mounts to determine what
+ *                                  non-seclabel mounts to exclude from
+ *                                  relabeling. restorecon_init() will not
+ *                                  call this function if the
+ *                                  SELINUX_RESTORECON_IGNORE_MOUNTS
+ *                                  flag is set.
+ */
+static void remove_exclude(const char *directory, int exclude_from_ctr)
 {
 	int i;
 
-	for (i = 0; fc_exclude_list[i]; i++) {
-		if (strcmp(file, fc_exclude_list[i]) == 0)
+	for (i = exclude_from_ctr; i < exclude_count; i++) {
+		if (strcmp(directory, exclude_lst[i].directory) == 0) {
+			free(exclude_lst[i].directory);
+			return;
+		}
+	}
+}
+
+static int add_exclude(const char *directory)
+{
+	struct edir *tmp_list, *current;
+	size_t len = 0;
+
+	if (directory == NULL || directory[0] != '/') {
+		selinux_log(SELINUX_ERROR,
+			    "Full path required for exclude: %s.\n",
+			    directory);
+		errno = EINVAL;
+		return -1;
+	}
+
+	tmp_list = realloc(exclude_lst,
+			   sizeof(struct edir) * (exclude_count + 1));
+	if (!tmp_list)
+		goto oom;
+
+	exclude_lst = tmp_list;
+
+	len = strlen(directory);
+	while (len > 1 && directory[len - 1] == '/')
+		len--;
+
+	current = (exclude_lst + exclude_count);
+
+	current->directory = strndup(directory, len);
+	if (!current->directory)
+		goto oom;
+
+	current->size = len;
+	exclude_count++;
+	return 0;
+
+oom:
+	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
+	return -1;
+}
+
+static int check_excluded(const char *file, const char *orig_path)
+{
+	int i = 0;
+
+	for (i = 0; i < exclude_count; i++) {
+		if (strncmp(file, exclude_lst[i].directory,
+		    exclude_lst[i].size) == 0) {
+			/*
+			 * If these match need to ignore the excluded entry
+			 * as the caller intended to relabel this area.
+			 */
+			if (strncmp(file, orig_path, exclude_lst[i].size) == 0)
+				return 0;
+			else if (file[exclude_lst[i].size] == 0 ||
+				 file[exclude_lst[i].size] == '/')
 				return 1;
+		}
 	}
 	return 0;
 }
 
+static int file_system_count(char *name)
+{
+	struct statvfs statvfs_buf;
+	int nfile = 0;
+
+	memset(&statvfs_buf, 0, sizeof(statvfs_buf));
+	if (!statvfs(name, &statvfs_buf))
+		nfile = statvfs_buf.f_files - statvfs_buf.f_ffree;
+
+	return nfile;
+}
+
 /*
- * Support filespec services. selinux_restorecon(3) uses filespec services
- * when the SELINUX_RESTORECON_ADD_ASSOC flag is set for adding associations
- * between an inode and a context.
+ * Search /proc/mounts for all file systems that do not support extended
+ * attributes and add them to the exclude directory table.  File systems
+ * that support security labels have the seclabel option, return
+ * approximate total file count.
+ *
+ * This is called once when selinux_restorecon() is first called, however
+ * selinux_restorecon_set_exclude_list() may have been called to add others
+ * to the list. If these are in the mount list and have seclabels, then
+ * they would be deleted by the call to remove_exclude(), therefore start
+ * check from current exclude_count.
+*/
+static int exclude_non_seclabel_mounts(int exclude_from_ctr)
+{
+	struct utsname uts;
+	FILE *fp;
+	size_t len;
+	ssize_t num;
+	int index = 0, found = 0, nfile = 0;
+	char *mount_info[4];
+	char *buf = NULL, *item;
+
+	/* Check to see if the kernel supports seclabel */
+	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") < 0)
+		return 0;
+
+	fp = fopen("/proc/mounts", "r");
+	if (!fp)
+		return 0;
+
+	while ((num = getline(&buf, &len, fp)) != -1) {
+		found = 0;
+		index = 0;
+		item = strtok(buf, " ");
+		while (item != NULL) {
+			mount_info[index] = item;
+			if (index == 3)
+				break;
+			index++;
+			item = strtok(NULL, " ");
+		}
+		if (index < 3) {
+			selinux_log(SELINUX_ERROR,
+				    "/proc/mounts record \"%s\" has incorrect format.\n",
+				    buf);
+			continue;
+		}
+
+		/*
+		 * Remove pre-existing entry but check from the current
+		 * exclude_count when called from restorecon_init() as entries
+		 * could have been added by calls to
+		 * selinux_restorecon_set_exclude_list() beforehand that are
+		 * in the mount list and have seclabels (e.g. /home).
+		 */
+		remove_exclude(mount_info[1], exclude_from_ctr);
+
+		item = strtok(mount_info[3], ",");
+		while (item != NULL) {
+			if (strcmp(item, "seclabel") == 0) {
+				found = 1;
+				nfile += file_system_count(mount_info[1]);
+				break;
+			}
+			item = strtok(NULL, ",");
+		}
+
+		/*
+		 * Exclude mount points without the seclabel option. If an
+		 * error return 0 files.
+		 */
+		if (!found) {
+			if (add_exclude(mount_info[1]))
+				return 0;
+		}
+	}
+
+	free(buf);
+	fclose(fp);
+	/* return estimated #Files + 5% for directories and hard links */
+	return nfile * 1.05;
+}
+
+/*
+ * Support filespec services filespec_add(), filespec_eval() and
+ * filespec_destroy().
+ *
+ * selinux_restorecon(3) uses filespec services when the
+ * SELINUX_RESTORECON_ADD_ASSOC flag is set for adding associations between
+ * an inode and a specification.
  */
 
 /*
@@ -285,11 +501,51 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	char *newcon = NULL;
 	char *curcon = NULL;
 	char *newtypecon = NULL;
-	int rc = 0;
+	int rc;
 	bool updated = false;
+	const char *lookup_path = pathname;
+	float pc;
+
+	if (rootpath) {
+		if (strncmp(rootpath, lookup_path, rootpathlen) != 0) {
+			selinux_log(SELINUX_ERROR,
+				    "%s is not located in alt_rootpath %s\n",
+				    lookup_path, rootpath);
+			return -1;
+		}
+		lookup_path += rootpathlen;
+	}
+
+	if (rootpath != NULL && lookup_path[0] == '\0')
+		/* this is actually the root dir of the alt root. */
+		rc = selabel_lookup_raw(fc_sehandle, &newcon, "/",
+						    sb->st_mode);
+	else
+		rc = selabel_lookup_raw(fc_sehandle, &newcon, lookup_path,
+						    sb->st_mode);
+
+	if (rc < 0) {
+		if (errno == ENOENT && flags->verbose)
+			selinux_log(SELINUX_INFO,
+				    "Warning no default label for %s\n",
+				    lookup_path);
 
-	if (selabel_lookup_raw(fc_sehandle, &newcon, pathname, sb->st_mode) < 0)
 		return 0; /* no match, but not an error */
+	}
+
+	if (flags->progress) {
+		fc_count++;
+		if (fc_count % STAR_COUNT == 0) {
+			if (mass_relabel && efile_count > 0) {
+				pc = (fc_count < efile_count) ? (100.0 *
+					     fc_count / efile_count) : 100;
+				fprintf(stdout, "\r%-.1f%%", (double)pc);
+			} else {
+				fprintf(stdout, "*");
+			}
+		fflush(stdout);
+		}
+	}
 
 	if (flags->add_assoc) {
 		rc = filespec_add(sb->st_ino, newcon, pathname);
@@ -308,6 +564,10 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		}
 	}
 
+	if (flags->log_matches)
+		selinux_log(SELINUX_INFO, "%s matched by %s\n",
+			    pathname, newcon);
+
 	if (lgetfilecon_raw(pathname, &curcon) < 0) {
 		if (errno != ENODATA)
 			goto err;
@@ -315,14 +575,6 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		curcon = NULL;
 	}
 
-	if (flags->progress) {
-		fc_count++;
-		if (fc_count % STAR_COUNT == 0) {
-			fprintf(stdout, "*");
-			fflush(stdout);
-		}
-	}
-
 	if (strcmp(curcon, newcon) != 0) {
 		if (!flags->set_specctx && curcon &&
 				    (is_context_customizable(curcon) > 0)) {
@@ -359,6 +611,16 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 				    "%s %s from %s to %s\n",
 				    updated ? "Relabeled" : "Would relabel",
 				    pathname, curcon, newcon);
+
+		if (flags->syslog_changes && !flags->nochange) {
+			if (curcon)
+				syslog(LOG_INFO,
+					    "relabeling %s from %s to %s\n",
+					    pathname, curcon, newcon);
+			else
+				syslog(LOG_INFO, "labeling %s to %s\n",
+					    pathname, newcon);
+		}
 	}
 
 out:
@@ -403,6 +665,16 @@ int selinux_restorecon(const char *pathname_orig,
 		   SELINUX_RESTORECON_XDEV) ? true : false;
 	flags.add_assoc = (restorecon_flags &
 		   SELINUX_RESTORECON_ADD_ASSOC) ? true : false;
+	flags.abort_on_error = (restorecon_flags &
+		   SELINUX_RESTORECON_ABORT_ON_ERROR) ? true : false;
+	flags.syslog_changes = (restorecon_flags &
+		   SELINUX_RESTORECON_SYSLOG_CHANGES) ? true : false;
+	flags.log_matches = (restorecon_flags &
+		   SELINUX_RESTORECON_LOG_MATCHES) ? true : false;
+	flags.ignore_noent = (restorecon_flags &
+		   SELINUX_RESTORECON_IGNORE_NOENTRY) ? true : false;
+	ignore_mounts = (restorecon_flags &
+		   SELINUX_RESTORECON_IGNORE_MOUNTS) ? true : false;
 
 	bool issys;
 	bool setrestoreconlast = true; /* TRUE = set xattr RESTORECON_LAST
@@ -412,11 +684,11 @@ int selinux_restorecon(const char *pathname_orig,
 	FTS *fts;
 	FTSENT *ftsent;
 	char *pathname = NULL, *pathdnamer = NULL, *pathdname, *pathbname;
-	char *paths[2] = { NULL , NULL };
-	int fts_flags;
-	int error, sverrno;
+	char *paths[2] = { NULL, NULL };
+	int fts_flags, error, sverrno;
 	char *xattr_value = NULL;
 	ssize_t size;
+	dev_t dev_num = 0;
 
 	if (flags.verbose && flags.progress)
 		flags.verbose = false;
@@ -468,8 +740,17 @@ int selinux_restorecon(const char *pathname_orig,
 			    sizeof(SYS_PREFIX) - 1)) ? true : false;
 
 	if (lstat(pathname, &sb) < 0) {
-		error = -1;
-		goto cleanup;
+		if (flags.ignore_noent && errno == ENOENT) {
+			free(pathdnamer);
+			free(pathname);
+			return 0;
+		} else {
+			selinux_log(SELINUX_ERROR,
+				    "lstat(%s) failed: %s\n",
+				    pathname, strerror(errno));
+			error = -1;
+			goto cleanup;
+		}
 	}
 
 	/* Ignore restoreconlast if not a directory */
@@ -506,19 +787,47 @@ int selinux_restorecon(const char *pathname_orig,
 		}
 	}
 
+	mass_relabel = false;
+	if (!strcmp(pathname, "/")) {
+		mass_relabel = true;
+		if (flags.set_xdev && flags.progress)
+			/*
+			 * Need to recalculate to get accurate % complete
+			 * as only root device id will be processed.
+			 */
+			efile_count = file_system_count(pathname);
+	}
+
 	if (flags.set_xdev)
 		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR | FTS_XDEV;
 	else
 		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
 
 	fts = fts_open(paths, fts_flags, NULL);
-	if (!fts) {
-		error = -1;
-		goto cleanup;
-	}
+	if (!fts)
+		goto fts_err;
+
+	ftsent = fts_read(fts);
+	if (!ftsent)
+		goto fts_err;
+
+	/*
+	 * Keep the inode of the first device. This is because the FTS_XDEV
+	 * flag tells fts not to descend into directories with different
+	 * device numbers, but fts will still give back the actual directory.
+	 * By saving the device number of the directory that was passed to
+	 * selinux_restorecon() and then skipping all actions on any
+	 * directories with a different device number when the FTS_XDEV flag
+	 * is set (from http://marc.info/?l=selinux&m=124688830500777&w=2).
+	 */
+	dev_num = ftsent->fts_statp->st_dev;
 
 	error = 0;
-	while ((ftsent = fts_read(fts)) != NULL) {
+	do {
+		/* If the FTS_XDEV flag is set and the device is different */
+		if (flags.set_xdev && ftsent->fts_statp->st_dev != dev_num)
+			continue;
+
 		switch (ftsent->fts_info) {
 		case FTS_DC:
 			selinux_log(SELINUX_ERROR,
@@ -556,20 +865,24 @@ int selinux_restorecon(const char *pathname_orig,
 				fts_set(fts, ftsent, FTS_SKIP);
 				continue;
 			}
-			/* fall through */
-		default:
-			if (fc_exclude_list) {
-				if (check_excluded(ftsent->fts_path)) {
+
+			if (exclude_count > 0) {
+				if (check_excluded(ftsent->fts_path,
+								pathname)) {
 					fts_set(fts, ftsent, FTS_SKIP);
 					continue;
 				}
 			}
-
+			/* fall through */
+		default:
 			error |= restorecon_sb(ftsent->fts_path,
 					       ftsent->fts_statp, &flags);
+
+			if (error && flags.abort_on_error)
+				goto out;
 			break;
 		}
-	}
+	} while ((ftsent = fts_read(fts)) != NULL);
 
 	/* Labeling successful. Mark the top level directory as completed. */
 	if (setrestoreconlast && !flags.nochange && !error) {
@@ -581,6 +894,13 @@ int selinux_restorecon(const char *pathname_orig,
 	}
 
 out:
+	if (flags.progress) {
+		if (mass_relabel)
+			fprintf(stdout, "\r100.0%%\n");
+		else
+			fprintf(stdout, "\n");
+	}
+
 	sverrno = errno;
 	(void) fts_close(fts);
 	errno = sverrno;
@@ -610,6 +930,13 @@ realpatherr:
 	errno = sverrno;
 	error = -1;
 	goto cleanup;
+
+fts_err:
+	selinux_log(SELINUX_ERROR,
+		    "fts error while labeling %s: %s\n",
+		    paths[0], strerror(errno));
+	error = -1;
+	goto cleanup;
 }
 
 /* selinux_restorecon_set_sehandle(3) is called to set the global fc handle */
@@ -620,8 +947,9 @@ void selinux_restorecon_set_sehandle(struct selabel_handle *hndl)
 
 	fc_sehandle = (struct selabel_handle *) hndl;
 
-	/* Read digest if requested in selabel_open(3).
-	 * If not the set global params. */
+	/*
+	 * Read digest if requested in selabel_open(3), else set global params.
+	 */
 	if (selabel_digest(hndl, &fc_digest, &fc_digest_len,
 				   &specfiles, &num_specfiles) < 0) {
 		fc_digest = NULL;
@@ -678,10 +1006,49 @@ struct selabel_handle *selinux_restorecon_default_handle(void)
 }
 
 /*
- * selinux_restorecon_set_exclude_list(3) is called to set a NULL terminated
- * list of files/directories to exclude.
+ * selinux_restorecon_set_exclude_list(3) is called to add additional entries
+ * to be excluded from labeling checks.
  */
-void selinux_restorecon_set_exclude_list(const char **exclude_list)
+int selinux_restorecon_set_exclude_list(const char **exclude_list)
 {
-	fc_exclude_list = exclude_list;
+	int i;
+	struct stat sb;
+
+	for (i = 0; exclude_list[i]; i++) {
+		remove_exclude(exclude_list[i], 0);
+		if (lstat(exclude_list[i], &sb) < 0 && errno != EACCES) {
+			selinux_log(SELINUX_ERROR,
+				    "lstat error on exclude path \"%s\", %s - ignoring.\n",
+				    exclude_list[i], strerror(errno));
+			break;
+		}
+		if (add_exclude(exclude_list[i]))
+			return -1;
+	}
+
+	return 0;
+}
+
+/* selinux_restorecon_set_alt_rootpath(3) sets an alternate rootpath. */
+int selinux_restorecon_set_alt_rootpath(const char *alt_rootpath)
+{
+	int len;
+
+	/* This should be NULL on first use */
+	if (rootpath)
+		free(rootpath);
+
+	rootpath = strdup(alt_rootpath);
+	if (!rootpath) {
+		selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
+		return -1;
+	}
+
+	/* trim trailing /, if present */
+	len = strlen(rootpath);
+	while (len && (rootpath[len - 1] == '/'))
+		rootpath[--len] = '\0';
+	rootpathlen = len;
+
+	return 0;
 }
diff --git a/libselinux/utils/selinux_restorecon.c b/libselinux/utils/selinux_restorecon.c
index 2552d63..7aea81f 100644
--- a/libselinux/utils/selinux_restorecon.c
+++ b/libselinux/utils/selinux_restorecon.c
@@ -37,9 +37,9 @@ static int validate_context(char **contextp)
 static void usage(const char *progname)
 {
 	fprintf(stderr,
-		"\nusage: %s [-FCnRrdeia] [-v|-P] [-p policy] [-f specfile] "
-		"pathname ...\n"
-		"Where:\n\t"
+		"\nusage: %s [-FCnRrdmiIaAsl] [-e dir] [-v|-P]\n"
+		"[-x alt_rootpath] [-p policy] [-f specfile] pathname ...\n"
+		"\nWhere:\n\t"
 		"-F  Set the label to that in specfile.\n\t"
 		"    If not set then reset the \"type\" component of the "
 		"label to that\n\t    in the specfile.\n\t"
@@ -49,17 +49,25 @@ static void usage(const char *progname)
 		"-R  Recursively change file and directory labels.\n\t"
 		"-v  Show changes in file labels (-v and -P are mutually "
 		" exclusive).\n\t"
-		"-P  Show progress by printing \"*\" to stdout every 1000 files.\n\t"
+		"-P  Show progress by printing \"*\" to stdout every 1000 files"
+		",\n\t    unless relabeling entire OS, then show percentage complete.\n\t"
 		"-r  Use realpath(3) to convert pathnames to canonical form.\n\t"
 		"-d  Prevent descending into directories that have a "
 		"different\n\t    device number than the pathname from  which "
 		"the descent began.\n\t"
-		"-e  Exclude this file/directory (add multiple -e entries).\n\t"
+		"-m  Do not automatically read /proc/mounts to determine what\n\t"
+		"    non-seclabel mounts to exclude from relabeling.\n\t"
+		"-e  Exclude this directory (add multiple -e entries).\n\t"
 		"-i  Do not set SELABEL_OPT_DIGEST option when calling "
 		" selabel_open(3).\n\t"
+		"-I  Ignore files that do not exist.\n\t"
 		"-a  Add an association between an inode and a context.\n\t"
 		"    If there is a different context that matched the inode,\n\t"
 		"    then use the first context that matched.\n\t"
+		"-A  Abort on errors during the file tree walk.\n\t"
+		"-s  Log any label changes to syslog(3).\n\t"
+		"-l  Log what specfile context matched each file.\n\t"
+		"-x  Set alternate rootpath.\n\t"
 		"-p  Optional binary policy file (also sets validate context "
 		"option).\n\t"
 		"-f  Optional file contexts file.\n\t"
@@ -101,6 +109,7 @@ int main(int argc, char **argv)
 	int opt, i;
 	unsigned int restorecon_flags = 0;
 	char *path = NULL, *digest = NULL, *validate = NULL;
+	char *alt_rootpath = NULL;
 	FILE *policystream;
 	bool ignore_digest = false, require_selinux = true;
 	bool verbose = false, progress = false;
@@ -118,7 +127,7 @@ int main(int argc, char **argv)
 	exclude_list = NULL;
 	exclude_count = 0;
 
-	while ((opt = getopt(argc, argv, "iFCnRvPrdae:f:p:")) > 0) {
+	while ((opt = getopt(argc, argv, "iIFCnRvPrdaAslme:f:p:x:")) > 0) {
 		switch (opt) {
 		case 'F':
 			restorecon_flags |=
@@ -158,6 +167,9 @@ int main(int argc, char **argv)
 		case 'd':
 			restorecon_flags |= SELINUX_RESTORECON_XDEV;
 			break;
+		case 'm':
+			restorecon_flags |= SELINUX_RESTORECON_IGNORE_MOUNTS;
+			break;
 		case 'e':
 			add_exclude(optarg);
 			break;
@@ -190,9 +202,24 @@ int main(int argc, char **argv)
 		case 'i':
 			ignore_digest = true;
 			break;
+		case 'I':
+			restorecon_flags |= SELINUX_RESTORECON_IGNORE_NOENTRY;
+			break;
 		case 'a':
 			restorecon_flags |= SELINUX_RESTORECON_ADD_ASSOC;
 			break;
+		case 'A':
+			restorecon_flags |= SELINUX_RESTORECON_ABORT_ON_ERROR;
+			break;
+		case 's':
+			restorecon_flags |= SELINUX_RESTORECON_SYSLOG_CHANGES;
+			break;
+		case 'l':
+			restorecon_flags |= SELINUX_RESTORECON_LOG_MATCHES;
+			break;
+		case 'x':
+			alt_rootpath = optarg;
+			break;
 		default:
 			usage(argv[0]);
 		}
@@ -247,6 +274,9 @@ int main(int argc, char **argv)
 		selinux_restorecon_set_exclude_list
 						 ((const char **)exclude_list);
 
+	if (alt_rootpath)
+		selinux_restorecon_set_alt_rootpath(alt_rootpath);
+
 	/* Call restorecon for each path in list */
 	for (i = optind; i < argc; i++) {
 		if (selinux_restorecon(argv[i], restorecon_flags) < 0) {
-- 
2.5.5
