From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: matchpathcon/selabel_file: Fix man pages.
Date: Mon, 11 May 2015 10:09:38 -0400
Message-Id: <1431353378-6438-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As discussed in https://bugzilla.redhat.com/show_bug.cgi?id=1219718,
there are several inconsistencies between the matchpathcon man page
and the implementation.  The same is true of the SELABEL_OPT_SUBSET
option for the selabel_file backend.  Fix the man pages for both.
Also note in the man pages that the entire matchpathcon family
of functions is deprecated and recommend use of the corresponding
selabel interfaces for new code.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/man/man3/matchpathcon.3 | 45 +++++++++++++++++++++++++++++++++-----
 libselinux/man/man5/selabel_file.5 |  6 +++--
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/libselinux/man/man3/matchpathcon.3 b/libselinux/man/man3/matchpathcon.3
index 1bc7ba1..177f15d 100644
--- a/libselinux/man/man3/matchpathcon.3
+++ b/libselinux/man/man3/matchpathcon.3
@@ -7,7 +7,7 @@ matchpathcon, matchpathcon_index \- get the default SELinux security context for
 .sp
 .BI "int matchpathcon_init(const char *" path ");"
 .sp
-.BI "int matchpathcon_init_prefix(const char *" path ", const char *" subset ");"
+.BI "int matchpathcon_init_prefix(const char *" path ", const char *" prefix ");"
 .sp
 .BI "int matchpathcon_fini(void);"
 .sp
@@ -16,6 +16,24 @@ matchpathcon, matchpathcon_index \- get the default SELinux security context for
 .BI "int matchpathcon_index(const char *" name ", mode_t " mode ", char **" con ");"
 .
 .SH "DESCRIPTION"
+
+This family of functions is deprecated.  For new code, please use
+.BR selabel_open (3)
+with the
+.B SELABEL_CTX_FILE
+backend in place of
+.BR matchpathcon_init (),
+use
+.BR selabel_close (3)
+in place of
+.BR matchpathcon_fini (),
+and use
+.BR selabel_lookup (3)
+in place of
+.BR matchpathcon ().
+
+The remaining description below is for the legacy interface.
+
 .BR matchpathcon_init ()
 loads the file contexts configuration specified by
 .I path
@@ -41,9 +59,16 @@ customizations.
 .BR matchpathcon_init_prefix ()
 is the same as
 .BR matchpathcon_init ()
-but only loads entries with regular expressions that have stems prefixed
-by
-.I \%prefix.
+but only loads entries with regular expressions whose first pathname
+component is a prefix of
+.I \%prefix
+, e.g. pass "/dev" if you only intend to call
+.BR matchpathcon ()
+with pathnames beginning with /dev.
+However, this optimization is no longer necessary due to the use of
+.I file_contexts.bin
+files with precompiled regular expressions, so use of this interface
+is deprecated.
 
 .BR matchpathcon_fini ()
 frees the memory allocated by a prior call to
@@ -54,7 +79,17 @@ calls, or to free memory when finished using
 .BR matchpathcon ().
 
 .BR matchpathcon ()
-matches the specified pathname and mode against the file contexts
+matches the specified
+.I pathname,
+after transformation via
+.BR realpath (3)
+excepting any final symbolic link component if S_IFLNK was
+specified as the
+.I mode,
+and
+.I mode
+against the
+.I file contexts
 configuration and sets the security context 
 .I con 
 to refer to the
diff --git a/libselinux/man/man5/selabel_file.5 b/libselinux/man/man5/selabel_file.5
index 79eca95..e738824 100644
--- a/libselinux/man/man5/selabel_file.5
+++ b/libselinux/man/man5/selabel_file.5
@@ -55,7 +55,9 @@ A non-null value for this option specifies a path to a file that will be opened
 A non-null value for this option indicates that any local customizations to the file contexts mapping should be ignored.
 .TP
 .B SELABEL_OPT_SUBSET
-A non-null value for this option is interpreted as a path prefix, for example "/etc".  Only file context specifications starting with the given prefix are loaded.  This may increase lookup performance, however any attempt to look up a path not starting with the given prefix will fail.
+A non-null value for this option is interpreted as a path prefix, for example "/etc".  Only file context specifications with starting with a first component that prefix matches the given prefix are loaded.  This may increase lookup performance, however any attempt to look up a path not starting with the given prefix may fail.  This optimization is no longer required due to the use of
+.I file_contexts.bin
+files and is deprecated.
 .RE
 .
 .SH "FILES"
@@ -206,7 +208,7 @@ component with \fI/var/www\fR, therefore the path used is:
 If contexts are to be validated, then the global option \fBSELABEL_OPT_VALIDATE\fR must be set before calling \fBselabel_open\fR(3). If this is not set, then it is possible for an invalid context to be returned.
 .IP "2." 4
 If the size of file contexts series of files contain many entries, then \fBselabel_open\fR(3) may have a delay as it reads in the files, and if
-requested validates the entries. If possible use the \fBSELABEL_OPT_SUBSET\fR option to reduce the number of entries processed.
+requested validates the entries.
 .IP "3." 4
 Depending on the version of SELinux it is possible that a \fIfile_contexts.template\fR file may also be present, however this is now deprecated.
 .br
-- 
2.1.0
