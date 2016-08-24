Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7OCtRnH022130
 for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2016 08:55:27 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] policycoreutils: setfiles - Add option to ignore
 restorecon_last
Date: Wed, 24 Aug 2016 13:55:16 +0100
Message-Id: <1472043316-28973-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add -x option to restorecon(8) and setfiles(8) to ignore the
"security.restorecon_last" extended attribute.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policycoreutils/setfiles/restore.c    |  5 +++--
 policycoreutils/setfiles/restore.h    |  2 ++
 policycoreutils/setfiles/restorecon.8 | 14 ++++++++++++--
 policycoreutils/setfiles/setfiles.8   | 12 +++++++++++-
 policycoreutils/setfiles/setfiles.c   | 19 ++++++++++++-------
 5 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index cf04e96..8ecb087 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -7,7 +7,7 @@
 #include <glob.h>
 
 char **exclude_list;
-int exclude_count;
+static int exclude_count;
 
 struct restore_opts *r_opts;
 
@@ -35,7 +35,8 @@ void restore_init(struct restore_opts *opts)
 			   r_opts->recurse | r_opts->userealpath |
 			   r_opts->xdev | r_opts->abort_on_error |
 			   r_opts->syslog_changes | r_opts->log_matches |
-			   r_opts->ignore_noent | r_opts->ignore_mounts;
+			   r_opts->ignore_noent | r_opts->ignore_mounts |
+			   r_opts->ignore_xattr;
 
 	/* Use setfiles, restorecon and restorecond own handles */
 	selinux_restorecon_set_sehandle(r_opts->hnd);
diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
index bafb662..ad652bb 100644
--- a/policycoreutils/setfiles/restore.h
+++ b/policycoreutils/setfiles/restore.h
@@ -40,6 +40,7 @@ struct restore_opts {
 	unsigned int log_matches;
 	unsigned int ignore_noent;
 	unsigned int ignore_mounts;
+	unsigned int ignore_xattr;
 	/* restorecon_flags holds | of above for restore_init() */
 	unsigned int restorecon_flags;
 	char *rootpath;
@@ -56,5 +57,6 @@ void restore_init(struct restore_opts *opts);
 void restore_finish(void);
 void add_exclude(const char *directory);
 int process_glob(char *name, struct restore_opts *opts);
+extern char **exclude_list;
 
 #endif
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 4851f0f..e913e53 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -4,10 +4,10 @@ restorecon \- restore file(s) default SELinux security contexts.
 
 .SH "SYNOPSIS"
 .B restorecon
-.I [\-R] [\-m] [\-n] [\-p] [\-v] [\-I] [\-e directory] pathname...
+.I [\-R] [\-m] [\-n] [\-p] [\-v] [\-I] [\-x] [\-e directory] pathname...
 .P
 .B restorecon
-.I \-f infilename [\-e directory] [\-R] [\-m] [\-n] [\-p] [\-v] [\-F] [\-I]
+.I \-f infilename [\-e directory] [\-R] [\-m] [\-n] [\-p] [\-v] [\-F] [\-I] [\-x]
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -56,6 +56,14 @@ there are no errors. See the
 .B NOTES
 section for further details.
 .TP
+.B \-x
+do not check or update any directory SHA1 digests. Use this option to
+effectively disable usage of the
+.IR security.restorecon_last
+extended attribute. Note that using this option will override the
+.B \-I
+option.
+.TP
 .B \-m
 do not read
 .B /proc/mounts
@@ -151,6 +159,8 @@ option will ignore the SHA1 digest from each directory specified in
 .B pathname...
 and provided the
 .B \-n
+option is NOT set and the
+.B \-x
 option is NOT set and recursive mode is set, files will be relabeled as
 required with the digest then being updated provided there are no errors.
 
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 35e38b2..b90f381 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -4,7 +4,7 @@ setfiles \- set SELinux file security contexts.
 
 .SH "SYNOPSIS"
 .B setfiles
-.I [\-c policy] [\-d] [\-l] [\-m] [\-n] [\-e directory] [\-o filename] [\-p] [\-q] [\-s] [\-v] [\-W] [\-F] [\-I] spec_file pathname...
+.I [\-c policy] [\-d] [\-l] [\-m] [\-n] [\-e directory] [\-o filename] [\-p] [\-q] [\-s] [\-v] [\-W] [\-F] [\-I] [\-x] spec_file pathname...
 .SH "DESCRIPTION"
 This manual page describes the
 .BR setfiles
@@ -57,6 +57,14 @@ there are no errors. See the
 .B NOTES
 section for further details.
 .TP
+.B \-x
+do not check or update any directory SHA1 digests. Use this option to
+effectively disable usage of the
+.IR security.restorecon_last
+extended attribute. Note that using this option will override the
+.B \-I
+option.
+.TP
 .B \-l
 log changes in file labels to syslog.
 .TP
@@ -190,6 +198,8 @@ option will ignore the SHA1 digest from each directory specified in
 .B pathname...
 and provided the
 .B \-n
+option is NOT set and the
+.B \-x
 option is NOT set, files will be relabeled as required with the digest then
 being updated provided there are no errors.
 
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index b700228..cf71d21 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -42,14 +42,14 @@ void usage(const char *const name)
 {
 	if (iamrestorecon) {
 		fprintf(stderr,
-			"usage:  %s [-iIFmnprRv0] [-e excludedir] pathname...\n"
-			"usage:  %s [-iIFmnprRv0] [-e excludedir] -f filename\n",
+			"usage:  %s [-iIFmnprRvx0] [-e excludedir] pathname...\n"
+			"usage:  %s [-iIFmnprRvx0] [-e excludedir] -f filename\n",
 			name, name);
 	} else {
 		fprintf(stderr,
-			"usage:  %s [-diIlmnpqvFW] [-e excludedir] [-r alt_root_path] spec_file pathname...\n"
-			"usage:  %s [-diIlmnpqvFW] [-e excludedir] [-r alt_root_path] spec_file -f filename\n"
-			"usage:  %s -s [-diIlmnpqvFW] spec_file\n"
+			"usage:  %s [-diIlmnpqvxFW] [-e excludedir] [-r alt_root_path] spec_file pathname...\n"
+			"usage:  %s [-diIlmnpqvxFW] [-e excludedir] [-r alt_root_path] spec_file -f filename\n"
+			"usage:  %s -s [-diIlmnpqvxFW] spec_file\n"
 			"usage:  %s -c policyfile spec_file\n",
 			name, name, name, name);
 	}
@@ -147,8 +147,8 @@ int main(int argc, char **argv)
 	size_t buf_len;
 	const char *base;
 	int mass_relabel = 0, errors = 0;
-	const char *ropts = "e:f:hiIlmno:pqrsvFRW0";
-	const char *sopts = "c:de:f:hiIlmno:pqr:svFR:W0";
+	const char *ropts = "e:f:hiIlmno:pqrsvxFRW0";
+	const char *sopts = "c:de:f:hiIlmno:pqr:svxFR:W0";
 	const char *opts;
 
 	/* Initialize variables */
@@ -184,6 +184,7 @@ int main(int argc, char **argv)
 		/* FTS_PHYSICAL and FTS_NOCHDIR are always set by selinux_restorecon(3) */
 		r_opts.xdev = SELINUX_RESTORECON_XDEV;
 		r_opts.ignore_mounts = 0; /* SELINUX_RESTORECON_IGNORE_MOUNTS */
+		r_opts.ignore_xattr = 0; /* SELINUX_RESTORECON_IGNORE_XATTR */
 		ctx_validate = 1;
 		opts = sopts;
 	} else {
@@ -207,6 +208,7 @@ int main(int argc, char **argv)
 		r_opts.add_assoc = 0;
 		r_opts.xdev = 0;
 		r_opts.ignore_mounts = 0;
+		r_opts.ignore_xattr = 0;
 		ctx_validate = 0;
 		opts = ropts;
 
@@ -356,6 +358,9 @@ int main(int argc, char **argv)
 			}
 			r_opts.progress = SELINUX_RESTORECON_PROGRESS;
 			break;
+		case 'x':
+			r_opts.ignore_xattr = SELINUX_RESTORECON_IGNORE_XATTR;
+			break;
 		case 'W':
 			warn_no_match = 1; /* Print selabel_stats() */
 			break;
-- 
2.7.4
