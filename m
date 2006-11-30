Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAULIxlB013023
	for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2006 16:18:59 -0500
Received: from facesaver.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAULIHxL015737
	for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2006 21:18:17 GMT
Received: from moss-huskies.epoch.ncsc.mil (tychonac [144.51.25.7])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAULDr3D018217
	for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2006 16:13:53 -0500
Subject: [PATCH] labeling API examples: setfiles patch and simple program
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
In-Reply-To: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
References: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-tJuINDZHc89YinoIKzn7"
Date: Thu, 30 Nov 2006 16:18:58 -0500
Message-Id: <1164921538.2794.230.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-tJuINDZHc89YinoIKzn7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

A patch to setfiles allowing it to use the new labeling API.  Should be
compatible with existing behavior.

Also attached is a simple usage example program, displaying how a
userspace object manager might use it.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

---
 policycoreutils/setfiles/setfiles.c |  127 ++++++--------------
 1 file changed, 40 insertions(+), 87 deletions(-)


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-tJuINDZHc89YinoIKzn7
Content-Description: 
Content-Disposition: inline; filename=setfiles.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/setfiles/setfiles.c
===================================================================
--- policycoreutils/setfiles/setfiles.c	(revision 2116)
+++ policycoreutils/setfiles/setfiles.c	(working copy)
@@ -66,14 +66,13 @@
 #include <stdio_ext.h>
 #include <string.h>
 #include <errno.h>
-#include <ctype.h>
-#include <regex.h>
-#include <sys/vfs.h>
 #define __USE_XOPEN_EXTENDED 1	/* nftw */
 #include <ftw.h>
-#include <limits.h>
 #include <sepol/sepol.h>
+#include <selinux/flask.h>
 #include <selinux/selinux.h>
+#include <selinux/label.h>
+#include <selinux/label_backend.h>
 #include <syslog.h>
 #include <libgen.h>
 #ifdef USE_AUDIT
@@ -84,7 +83,6 @@
 #endif
 #endif
 
-static int add_assoc = 1;
 static FILE *outfile = NULL;
 static int force = 0;
 #define STAT_BLOCK_SIZE 1
@@ -112,7 +110,7 @@
 static int log = 0;
 static int warn_no_match = 0;
 static char *rootpath = NULL;
-static int rootpathlen = 0;
+static label_handle_t labelh;
 
 static char *progname;
 
@@ -181,41 +179,6 @@
 	return 0;
 }
 
-int match(const char *name, struct stat *sb, char **con)
-{
-	int ret;
-	const char *fullname = name;
-
-	/* fullname will be the real file that gets labeled
-	 * name will be what is matched in the policy */
-	if (NULL != rootpath) {
-		if (0 != strncmp(rootpath, name, rootpathlen)) {
-			fprintf(stderr, "%s:  %s is not located in %s\n",
-				progname, name, rootpath);
-			return -1;
-		}
-		name += rootpathlen;
-	}
-
-	if (excludeCtr > 0) {
-		if (exclude(fullname)) {
-			return -1;
-		}
-	}
-	ret = lstat(fullname, sb);
-	if (ret) {
-		fprintf(stderr, "%s:  unable to stat file %s\n", progname,
-			fullname);
-		return -1;
-	}
-
-	if (rootpath != NULL && name[0] == '\0')
-		/* this is actually the root dir of the alt root */
-		return matchpathcon_index("/", sb->st_mode, con);
-	else
-		return matchpathcon_index(name, sb->st_mode, con);
-}
-
 void usage(const char *const name)
 {
 	fprintf(stderr,
@@ -263,10 +226,8 @@
 		      int flag, struct FTW *s_unused __attribute__ ((unused)))
 {
 	const char *my_file;
-	struct stat my_sb;
-	int i, j, ret;
 	char *context, *newcon;
-	int user_only_changed = 0;
+	int ret, user_only_changed = 0;
 	char buf[STAT_BLOCK_SIZE];
 	if (pipe_fds[0] != -1
 	    && read(pipe_fds[0], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE) {
@@ -286,10 +247,15 @@
 		return 0;
 	}
 
-	i = match(my_file, &my_sb, &newcon);
-	if (i < 0)
-		/* No matching specification. */
+	if (excludeCtr > 0 && exclude(my_file))
 		return 0;
+	ret = label_lookup(labelh, my_file, SECCLASS_FILE, &newcon);
+	if (ret < 0)
+		/* No matching specification on ENOENT, otherwise error */
+		return (errno == ENOENT) ? 0 : -1;
+	if (ret == LABEL_FILE_CONFLICT)
+		/* There was already an association and it took precedence. */
+		return 0;
 
 	if (progress) {
 		count++;
@@ -303,23 +269,6 @@
 		}
 	}
 
-	/*
-	 * Try to add an association between this inode and
-	 * this specification.  If there is already an association
-	 * for this inode and it conflicts with this specification,
-	 * then use the last matching specification.
-	 */
-	if (add_assoc) {
-		j = matchpathcon_filespec_add(my_sb.st_ino, i, my_file);
-		if (j < 0)
-			goto err;
-
-		if (j != i) {
-			/* There was already an association and it took precedence. */
-			goto out;
-		}
-	}
-
 	if (debug) {
 		printf("%s:  %s matched by %s\n", progname, my_file, newcon);
 	}
@@ -428,10 +377,9 @@
 	len = strlen(rootpath);
 	while (len && ('/' == rootpath[len - 1]))
 		rootpath[--len] = 0;
-	rootpathlen = len;
 }
 
-int canoncon(const char *path, unsigned lineno, char **contextp)
+int canoncon(security_class_t cls __attribute__ ((unused)), char **contextp)
 {
 	char *context = *contextp, *tmpcon;
 	int valid = 1;
@@ -448,14 +396,9 @@
 		*contextp = tmpcon;
 	}
 
-	if (!valid) {
-		fprintf(stderr, "%s:  line %u has invalid context %s\n",
-			path, lineno, context);
-
+	if (!valid && policyfile)
 		/* Exit immediately if we're in checking mode. */
-		if (policyfile)
-			exit(1);
-	}
+		exit(1);
 
 	return !valid;
 }
@@ -507,13 +450,15 @@
 int main(int argc, char **argv)
 {
 	struct stat sb;
-	int opt, rc, i;
+	int opt, rc, i, flags, add_assoc = 1;
 	int done_root = 0;	/* have we processed the / directory as an arg */
+	struct label_file_opts opts;
+	struct label_action_callback actions;
 
 	memset(excludeArray, 0, sizeof(excludeArray));
 
-	/* Validate all file contexts during matchpathcon_init. */
-	set_matchpathcon_flags(MATCHPATHCON_VALIDATE | MATCHPATHCON_NOTRANS);
+	/* Validate all file contexts. */
+	flags = LABEL_VALIDATE;
 
 	/* Process any options. */
 	while ((opt = getopt(argc, argv, "Fc:dlnpqrsvWe:o:")) > 0) {
@@ -546,9 +491,7 @@
 				/* Only process the specified file_contexts file, not
 				   any .homedirs or .local files, and do not perform
 				   context translations. */
-				set_matchpathcon_flags(MATCHPATHCON_BASEONLY |
-						       MATCHPATHCON_NOTRANS |
-						       MATCHPATHCON_VALIDATE);
+				flags |= LABEL_BASEONLY;
 
 				break;
 			}
@@ -640,7 +583,12 @@
 	/* Use our own invalid context checking function so that
 	   we can support either checking against the active policy or
 	   checking against a binary policy file. */
-	set_matchpathcon_canoncon(&canoncon);
+	actions.func_validate = &canoncon;
+	rc = label_init(NULL, NULL, &actions, NULL);
+	if (rc < 0) {
+		perror("label_init");
+		exit(1);
+	}
 
 	if (stat(argv[optind], &sb) < 0) {
 		perror(argv[optind]);
@@ -653,8 +601,14 @@
 	}
 
 	/* Load the file contexts configuration and check it. */
-	rc = matchpathcon_init(argv[optind]);
-	if (rc < 0) {
+	if (add_assoc)
+		flags |= LABEL_FILE_INODE;
+
+	opts.path = argv[optind];
+	opts.prefix = NULL;
+	opts.rootpath = rootpath;
+	labelh = label_open(FILE_CONTEXTS, SECCLASS_FILE, flags, &opts);
+	if (!labelh) {
 		perror(argv[optind]);
 		exit(1);
 	}
@@ -737,18 +691,17 @@
 			 * Evaluate the association hash table distribution for the
 			 * directory tree just traversed.
 			 */
-			set_matchpathcon_printf(&qprintf);
-			matchpathcon_filespec_eval();
-			set_matchpathcon_printf(NULL);
+			if (!quiet)
+				label_cache_stats(labelh);
 
 			/* Reset the association hash table for the next directory tree. */
-			matchpathcon_filespec_destroy();
+			label_file_reset_inodes(labelh);
 		}
 
 	maybe_audit_mass_relabel(done_root, 0);
 
 	if (warn_no_match)
-		matchpathcon_checkmatches(argv[0]);
+		label_op_stats(labelh);
 
 	if (outfile)
 		fclose(outfile);

--=-tJuINDZHc89YinoIKzn7
Content-Description: 
Content-Disposition: inline; filename=test.c
Content-Type: text/x-csrc; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <stdlib.h>
#include <stdio.h>
#include <selinux/flask.h>
#include <selinux/selinux.h>
#include <selinux/label.h>

static label_handle_t h;

int main(void) {
    int rc;
    security_context_t con;

    /* at startup time */
    label_init(NULL, NULL, NULL, NULL);

    h = label_open("xorg-x11-server", SECCLASS_XEXTENSION, 0, NULL);


    /* at labeling time */
    rc = label_lookup(h, "my_name_I_know_about", SECCLASS_XEXTENSION, &con);
    if (rc < 0)
	exit(1);
    else
	myobj.label = security_context_to_sid(con); /* whatever */


    /* at shutdown time */
    label_destroy();

    return 0;
}

--=-tJuINDZHc89YinoIKzn7--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
