Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8QFUAgj000683
 for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2016 11:30:10 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux: Add function to find security.restorecon_last
 entries
Date: Mon, 26 Sep 2016 16:29:56 +0100
Message-Id: <1474903796-4991-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch adds a new selinux_restorecon_xattr(3) function to find
and/or remove security.restorecon_last entries added by setfiles(8)
or restorecon(8).

Also review and update the man pages.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/include/selinux/restorecon.h            |  48 +++++
 libselinux/man/man3/selinux_restorecon.3           |   2 +
 .../man/man3/selinux_restorecon_default_handle.3   |   6 +-
 .../man/man3/selinux_restorecon_set_alt_rootpath.3 |   4 +-
 .../man/man3/selinux_restorecon_set_exclude_list.3 |   4 +-
 .../man/man3/selinux_restorecon_set_sehandle.3     |   9 +-
 libselinux/man/man3/selinux_restorecon_xattr.3     | 170 +++++++++++++++++
 libselinux/src/selinux_restorecon.c                | 207 +++++++++++++++++++++
 8 files changed, 441 insertions(+), 9 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_restorecon_xattr.3

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index e6db8f9..7cfdee1 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -128,6 +128,54 @@ extern void selinux_restorecon_set_exclude_list(const char **exclude_list);
  */
 extern int selinux_restorecon_set_alt_rootpath(const char *alt_rootpath);
 
+/**
+ * selinux_restorecon_xattr - Read/remove RESTORECON_LAST xattr entries.
+ * @pathname: specifies directory path to check.
+ * @xattr_flags: specifies the actions to be performed.
+ * @xattr_list: a linked list of struct dir_xattr structures containing
+ *              the directory, digest and result of the action on the
+ *              RESTORECON_LAST entry.
+ *
+ * selinux_restorecon_xattr(3) will automatically call
+ * selinux_restorecon_default_handle(3) and selinux_restorecon_set_sehandle(3)
+ * first time through to set the selabel_open(3) parameters to use the
+ * currently loaded policy file_contexts and request their computed digest.
+ *
+ * Should other selabel_open(3) parameters be required see
+ * selinux_restorecon_set_sehandle(3), however note that a file_contexts
+ * computed digest is required for selinux_restorecon_xattr().
+ */
+enum digest_result {
+	MATCH = 0,
+	NOMATCH,
+	DELETED_MATCH,
+	DELETED_NOMATCH,
+	ERROR
+};
+
+struct dir_xattr {
+	char *directory;
+	char *digest; /* A hex encoded string that can be printed. */
+	enum digest_result result;
+	struct dir_xattr *next;
+};
+
+extern int selinux_restorecon_xattr(const char *pathname,
+				    unsigned int xattr_flags,
+				    struct dir_xattr ***xattr_list);
+
+/*
+ * xattr_flags options
+ */
+/* Recursively descend directories. */
+#define SELINUX_RESTORECON_XATTR_RECURSE			0x0001
+/* Delete non-matching digests from each directory in pathname. */
+#define SELINUX_RESTORECON_XATTR_DELETE_NONMATCH_DIGESTS	0x0002
+/* Delete all digests found in pathname. */
+#define SELINUX_RESTORECON_XATTR_DELETE_ALL_DIGESTS		0x0004
+/* Do not read /proc/mounts. */
+#define SELINUX_RESTORECON_XATTR_IGNORE_MOUNTS			0x0008
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index ad8acdc..2d8274b 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -239,4 +239,6 @@ option.
 .br
 .BR selinux_restorecon_set_alt_rootpath (3),
 .br
+.BR selinux_restorecon_xattr (3),
+.br
 .BR selinux_set_callback (3)
diff --git a/libselinux/man/man3/selinux_restorecon_default_handle.3 b/libselinux/man/man3/selinux_restorecon_default_handle.3
index 0f1e737..52f5ad3 100644
--- a/libselinux/man/man3/selinux_restorecon_default_handle.3
+++ b/libselinux/man/man3/selinux_restorecon_default_handle.3
@@ -56,4 +56,8 @@ is set appropriately.
 .br
 .BR selinux_restorecon_set_sehandle (3),
 .br
-.BR selinux_restorecon_set_exclude_list (3)
+.BR selinux_restorecon_set_exclude_list (3),
+.br
+.BR selinux_restorecon_set_alt_rootpath (3),
+.br
+.BR selinux_restorecon_xattr (3)
diff --git a/libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3 b/libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3
index 6a33421..13a804a 100644
--- a/libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3
+++ b/libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3
@@ -32,4 +32,6 @@ is set appropriately.
 .br
 .BR selinux_restorecon_default_handle (3),
 .br
-.BR selinux_restorecon_set_exclude_list (3)
+.BR selinux_restorecon_set_exclude_list (3),
+.br
+.BR selinux_restorecon_xattr (3)
diff --git a/libselinux/man/man3/selinux_restorecon_set_exclude_list.3 b/libselinux/man/man3/selinux_restorecon_set_exclude_list.3
index 20c9d8d..373deec 100644
--- a/libselinux/man/man3/selinux_restorecon_set_exclude_list.3
+++ b/libselinux/man/man3/selinux_restorecon_set_exclude_list.3
@@ -30,4 +30,6 @@ must be called prior to
 .br
 .BR selinux_restorecon_default_handle (3),
 .br
-.BR selinux_restorecon_set_alt_rootpath (3)
+.BR selinux_restorecon_set_alt_rootpath (3),
+.br
+.BR selinux_restorecon_xattr (3)
diff --git a/libselinux/man/man3/selinux_restorecon_set_sehandle.3 b/libselinux/man/man3/selinux_restorecon_set_sehandle.3
index 30e0ad5..978945e 100644
--- a/libselinux/man/man3/selinux_restorecon_set_sehandle.3
+++ b/libselinux/man/man3/selinux_restorecon_set_sehandle.3
@@ -25,11 +25,6 @@ is generally used when customised
 .BR selabel_open (3)
 parameters are required to perform relabeling operations with
 .BR selinux_restorecon (3).
-.sp
-.BR selinux_restorecon_set_sehandle ()
-will output to the default SELinux log information regarding whether a digest
-is available or not. If it were available, the message will contain the SHA1
-digest and a list of specfiles used to compute the digest.
 .
 .SH "SEE ALSO"
 .BR selinux_restorecon (3),
@@ -38,4 +33,6 @@ digest and a list of specfiles used to compute the digest.
 .br
 .BR selinux_restorecon_default_handle (3),
 .br
-.BR selinux_restorecon_set_alt_rootpath (3)
+.BR selinux_restorecon_set_alt_rootpath (3),
+.br
+.BR selinux_restorecon_xattr (3)
diff --git a/libselinux/man/man3/selinux_restorecon_xattr.3 b/libselinux/man/man3/selinux_restorecon_xattr.3
new file mode 100644
index 0000000..2f03f8f
--- /dev/null
+++ b/libselinux/man/man3/selinux_restorecon_xattr.3
@@ -0,0 +1,170 @@
+.TH "selinux_restorecon_xattr" "3" "30 July 2016" "" "SELinux API documentation"
+
+.SH "NAME"
+selinux_restorecon_xattr \- manage default
+.I security.restorecon_last
+extended attribute entries added by
+.BR selinux_restorecon (3),
+.BR setfiles (8)
+or
+.BR restorecon (8).
+
+.SH "SYNOPSIS"
+.B #include <selinux/restorecon.h>
+.sp
+.BI "int selinux_restorecon_xattr(const char *" pathname ,
+.in +\w'int selinux_restorecon('u
+.br
+.BI "unsigned int " xattr_flags ,
+.br
+.BI "struct dir_xattr ***" xattr_list ");"
+.in
+.
+.SH "DESCRIPTION"
+.BR selinux_restorecon_xattr ()
+returns a linked list of
+.B dir_xattr
+structures containing information described below based on:
+.sp
+.RS
+.IR pathname
+containing a directory tree to be searched for
+.I security.restorecon_last
+extended attribute entries.
+.sp
+.IR xattr_flags
+contains options as follows:
+.sp
+.RS
+.sp
+.B SELINUX_RESTORECON_XATTR_RECURSE
+recursively descend directories.
+.sp
+.B SELINUX_RESTORECON_XATTR_DELETE_NONMATCH_DIGESTS
+delete non-matching digests from each directory in
+.IR pathname .
+.sp
+.B SELINUX_RESTORECON_XATTR_DELETE_ALL_DIGESTS
+delete all digests from each directory in
+.IR pathname .
+.sp
+.B SELINUX_RESTORECON_XATTR_IGNORE_MOUNTS
+do not read
+.B /proc/mounts
+to obtain a list of non-seclabel mounts to be excluded from the search.
+.br
+Setting
+.B SELINUX_RESTORECON_XATTR_IGNORE_MOUNTS
+is useful where there is a non-seclabel fs mounted with a seclabel fs mounted
+on a directory below this.
+.RE
+.sp
+.I xattr_list
+is the returned pointer to a linked list of
+.B dir_xattr
+structures, each containing the following information:
+.sp
+.RS
+.ta 4n 16n 24n
+.nf
+struct dir_xattr {
+	char *directory;
+	char *digest;    /* Printable hex encoded string */
+	enum digest_result result;
+	struct dir_xattr *next;
+};
+.fi
+.ta
+.RE
+.sp
+The
+.B result
+entry is enumerated as follows:
+.RS
+.ta 4n 16n 24n
+.nf
+enum digest_result {
+	MATCH = 0,
+	NOMATCH,
+	DELETED_MATCH,
+	DELETED_NOMATCH,
+	ERROR
+};
+.fi
+.ta
+.RE
+.sp
+.I xattr_list
+must be set to
+.B NULL
+before calling
+.BR selinux_restorecon_xattr (3).
+The caller is responsible for freeing the returned
+.I xattr_list
+entries in the linked list.
+.RE
+.sp
+See the
+.B NOTES
+section for more information.
+
+.SH "RETURN VALUE"
+On success, zero is returned.  On error, \-1 is returned and
+.I errno
+is set appropriately.
+
+.SH "NOTES"
+.IP "1." 4
+By default
+.BR selinux_restorecon_xattr (3)
+will use the default set of specfiles described in
+.BR files_contexts (5)
+to calculate the initial SHA1 digest to be used for comparision.
+To change this default behavior
+.BR selabel_open (3)
+must be called specifying the required
+.B SELABEL_OPT_PATH
+and setting the
+.B SELABEL_OPT_DIGEST
+option to a non-NULL value.
+.BR selinux_restorecon_set_sehandle (3)
+is then called to set the handle to be used by
+.BR selinux_restorecon_xattr (3).
+.IP "2." 4
+By default
+.BR selinux_restorecon_xattr (3)
+reads
+.B /proc/mounts
+to obtain a list of non-seclabel mounts to be excluded from searches unless the
+.B SELINUX_RESTORECON_XATTR_IGNORE_MOUNTS
+flag has been set.
+.IP "3." 4
+.B RAMFS
+and
+.B TMPFS
+filesystems do not support the
+.IR security.restorecon_last
+extended attribute and are automatically excluded from searches.
+.IP "4." 4
+By default
+.B stderr
+is used to log output messages and errors. This may be changed by calling
+.BR selinux_set_callback (3)
+with the
+.B SELINUX_CB_LOG
+.I type
+option.
+
+.SH "SEE ALSO"
+.BR selinux_restorecon (3)
+.br
+.BR selinux_restorecon_set_sehandle (3),
+.br
+.BR selinux_restorecon_default_handle (3),
+.br
+.BR selinux_restorecon_set_exclude_list (3),
+.br
+.BR selinux_restorecon_set_alt_rootpath (3),
+.br
+.BR selinux_set_callback (3)
+
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 0d3e4d5..0945138 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -64,6 +64,10 @@ static struct edir *exclude_lst = NULL;
 static uint64_t fc_count = 0;	/* Number of files processed so far */
 static uint64_t efile_count;	/* Estimated total number of files */
 
+/* Store information on directories with xattr's. */
+struct dir_xattr *dir_xattr_list;
+static struct dir_xattr *dir_xattr_last;
+
 /*
  * If SELINUX_RESTORECON_PROGRESS is set and mass_relabel = true, then
  * output approx % complete, else output * for every STAR_COUNT files
@@ -292,6 +296,90 @@ static int exclude_non_seclabel_mounts(void)
 	return nfile * 1.05;
 }
 
+/* Called by selinux_restorecon_xattr(3) to build a linked list of entries. */
+static int add_xattr_entry(const char *directory, bool delete_nonmatch,
+			   bool delete_all)
+{
+	char *sha1_buf = NULL;
+	unsigned char *xattr_value = NULL;
+	ssize_t xattr_size;
+	size_t i;
+	int rc, digest_result;
+	struct dir_xattr *new_entry;
+
+	if (!directory) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	xattr_value = malloc(fc_digest_len);
+	if (!xattr_value)
+		goto oom;
+
+	xattr_size = getxattr(directory, RESTORECON_LAST, xattr_value,
+			      fc_digest_len);
+	if (xattr_size < 0) {
+		free(xattr_value);
+		return 1;
+	}
+
+	/* Convert entry to a hex encoded string. */
+	sha1_buf = malloc(xattr_size * 2 + 1);
+	if (!sha1_buf) {
+		free(xattr_value);
+		goto oom;
+	}
+
+	for (i = 0; i < (size_t)xattr_size; i++)
+		sprintf((&sha1_buf[i * 2]), "%02x", xattr_value[i]);
+
+	rc = memcmp(fc_digest, xattr_value, fc_digest_len);
+	digest_result = rc ? NOMATCH : MATCH;
+
+	if ((delete_nonmatch && rc != 0) || delete_all) {
+		digest_result = rc ? DELETED_NOMATCH : DELETED_MATCH;
+		rc = removexattr(directory, RESTORECON_LAST);
+		if (rc) {
+			selinux_log(SELINUX_ERROR,
+				  "Error: %s removing xattr \"%s\" from: %s\n",
+				  strerror(errno), RESTORECON_LAST, directory);
+			digest_result = ERROR;
+		}
+	}
+	free(xattr_value);
+
+	/* Now add entries to link list. */
+	new_entry = malloc(sizeof(struct dir_xattr));
+	if (!new_entry)
+		goto oom;
+	new_entry->next = NULL;
+
+	new_entry->directory = strdup(directory);
+	if (!new_entry->directory)
+		goto oom;
+
+	new_entry->digest = strdup(sha1_buf);
+	if (!new_entry->digest)
+		goto oom;
+
+	new_entry->result = digest_result;
+
+	if (!dir_xattr_list) {
+		dir_xattr_list = new_entry;
+		dir_xattr_last = new_entry;
+	} else {
+		dir_xattr_last->next = new_entry;
+		dir_xattr_last = new_entry;
+	}
+
+	free(sha1_buf);
+	return 0;
+
+oom:
+	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
+	return -1;
+}
+
 /*
  * Support filespec services filespec_add(), filespec_eval() and
  * filespec_destroy().
@@ -1028,3 +1116,122 @@ int selinux_restorecon_set_alt_rootpath(const char *alt_rootpath)
 
 	return 0;
 }
+
+/* selinux_restorecon_xattr(3) - Find RESTORECON_LAST entries. */
+int selinux_restorecon_xattr(const char *pathname, unsigned int xattr_flags,
+					    struct dir_xattr ***xattr_list)
+{
+	bool recurse = (xattr_flags &
+	    SELINUX_RESTORECON_XATTR_RECURSE) ? true : false;
+	bool delete_nonmatch = (xattr_flags &
+	    SELINUX_RESTORECON_XATTR_DELETE_NONMATCH_DIGESTS) ? true : false;
+	bool delete_all = (xattr_flags &
+	    SELINUX_RESTORECON_XATTR_DELETE_ALL_DIGESTS) ? true : false;
+	ignore_mounts = (xattr_flags &
+	   SELINUX_RESTORECON_XATTR_IGNORE_MOUNTS) ? true : false;
+
+	int rc, fts_flags;
+	struct stat sb;
+	struct statfs sfsb;
+	struct dir_xattr *current, *next;
+	FTS *fts;
+	FTSENT *ftsent;
+	char *paths[2] = { NULL, NULL };
+
+	__selinux_once(fc_once, restorecon_init);
+
+	if (!fc_sehandle || !fc_digest_len)
+		return -1;
+
+	if (lstat(pathname, &sb) < 0) {
+		if (errno == ENOENT)
+			return 0;
+
+		selinux_log(SELINUX_ERROR,
+			    "lstat(%s) failed: %s\n",
+			    pathname, strerror(errno));
+		return -1;
+	}
+
+	if (!recurse) {
+		if (statfs(pathname, &sfsb) == 0) {
+			if (sfsb.f_type == RAMFS_MAGIC ||
+			    sfsb.f_type == TMPFS_MAGIC)
+				return 0;
+		}
+
+		if (check_excluded(pathname))
+			return 0;
+
+		rc = add_xattr_entry(pathname, delete_nonmatch, delete_all);
+
+		if (!rc && dir_xattr_list)
+			*xattr_list = &dir_xattr_list;
+		else if (rc == -1)
+			return rc;
+
+		return 0;
+	}
+
+	paths[0] = (char *)pathname;
+	fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
+
+	fts = fts_open(paths, fts_flags, NULL);
+	if (!fts) {
+		selinux_log(SELINUX_ERROR,
+			    "fts error on %s: %s\n",
+			    paths[0], strerror(errno));
+		return -1;
+	}
+
+	while ((ftsent = fts_read(fts)) != NULL) {
+		switch (ftsent->fts_info) {
+		case FTS_DP:
+			continue;
+		case FTS_D:
+			if (statfs(ftsent->fts_path, &sfsb) == 0) {
+				if (sfsb.f_type == RAMFS_MAGIC ||
+				    sfsb.f_type == TMPFS_MAGIC)
+					continue;
+			}
+			if (check_excluded(ftsent->fts_path)) {
+				fts_set(fts, ftsent, FTS_SKIP);
+				continue;
+			}
+
+			rc = add_xattr_entry(ftsent->fts_path,
+					     delete_nonmatch, delete_all);
+			if (rc == 1)
+				continue;
+			else if (rc == -1)
+				goto cleanup;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (dir_xattr_list)
+		*xattr_list = &dir_xattr_list;
+
+	(void) fts_close(fts);
+	return 0;
+
+cleanup:
+	rc = errno;
+	(void) fts_close(fts);
+	errno = rc;
+
+	if (dir_xattr_list) {
+		/* Free any used memory */
+		current = dir_xattr_list;
+		while (current) {
+			next = current->next;
+			free(current->directory);
+			free(current->digest);
+			free(current);
+			current = next;
+		}
+	}
+	return -1;
+}
-- 
2.7.4
