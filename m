Message-ID: <467324C0.3050705@tycho.nsa.gov>
Date: Fri, 15 Jun 2007 19:46:08 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: [PATCH 7/7] libselinux: labeling support (try 4)
References: <467320D6.5040703@tycho.nsa.gov>
In-Reply-To: <467320D6.5040703@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch changes setfiles to use the new interface.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 setfiles.c |  275 ++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 210 insertions(+), 65 deletions(-)


Index: policycoreutils/setfiles/setfiles.c
===================================================================
--- policycoreutils/setfiles/setfiles.c	(revision 2474)
+++ policycoreutils/setfiles/setfiles.c	(working copy)
@@ -16,6 +16,7 @@
 #include <limits.h>
 #include <sepol/sepol.h>
 #include <selinux/selinux.h>
+#include <selinux/label.h>
 #include <syslog.h>
 #include <libgen.h>
 #ifdef USE_AUDIT
@@ -70,21 +71,165 @@
 static int abort_on_error; /* Abort the file tree walk upon an error. */
 static int add_assoc; /* Track inode associations for conflict detection. */
 static int nftw_flags; /* Flags to nftw, e.g. follow links, follow mounts */
-static int matchpathcon_flags; /* Flags to matchpathcon */
+static int base_only; /* Don't use local file_contexts customizations */
+static int ctx_validate; /* Validate contexts */
+static const char *altpath; /* Alternate path to file_contexts */
 
-static void
-#ifdef __GNUC__
-    __attribute__ ((format(printf, 1, 2)))
-#endif
-    qprintf(const char *fmt, ...)
+/* Label interface handle */
+static struct selabel_handle *hnd;
+
+/*
+ * An association between an inode and a context.
+ */
+typedef struct file_spec {
+	ino_t ino;		/* inode number */
+	char *con;		/* matched context */
+	char *file;		/* full pathname */
+	struct file_spec *next;	/* next association in hash bucket chain */
+} file_spec_t;
+
+/*
+ * The hash table of associations, hashed by inode number.
+ * Chaining is used for collisions, with elements ordered
+ * by inode number in each bucket.  Each hash bucket has a dummy 
+ * header.
+ */
+#define HASH_BITS 16
+#define HASH_BUCKETS (1 << HASH_BITS)
+#define HASH_MASK (HASH_BUCKETS-1)
+static file_spec_t *fl_head;
+
+/*
+ * Try to add an association between an inode and a context.
+ * If there is a different context that matched the inode,
+ * then use the first context that matched.
+ */
+int filespec_add(ino_t ino, const security_context_t con, const char *file)
 {
-	va_list ap;
-	va_start(ap, fmt);
-	if (!quiet)
-		vfprintf(stdout, fmt, ap);
-	va_end(ap);
+	file_spec_t *prevfl, *fl;
+	int h, ret;
+	struct stat sb;
+
+	if (!fl_head) {
+		fl_head = malloc(sizeof(file_spec_t) * HASH_BUCKETS);
+		if (!fl_head)
+			goto oom;
+		memset(fl_head, 0, sizeof(file_spec_t) * HASH_BUCKETS);
+	}
+
+	h = (ino + (ino >> HASH_BITS)) & HASH_MASK;
+	for (prevfl = &fl_head[h], fl = fl_head[h].next; fl;
+	     prevfl = fl, fl = fl->next) {
+		if (ino == fl->ino) {
+			ret = lstat(fl->file, &sb);
+			if (ret < 0 || sb.st_ino != ino) {
+				freecon(fl->con);
+				free(fl->file);
+				fl->file = strdup(file);
+				if (!fl->file)
+					goto oom;
+				fl->con = strdup(con);
+				if (!fl->con)
+					goto oom;
+				return 1;
+			}
+
+			if (strcmp(fl->con, con) == 0)
+				return 1;
+
+			fprintf(stderr,
+				"%s:  conflicting specifications for %s and %s, using %s.\n",
+				__FUNCTION__, file, fl->file, fl->con);
+			free(fl->file);
+			fl->file = strdup(file);
+			if (!fl->file)
+				goto oom;
+			return 1;
+		}
+
+		if (ino > fl->ino)
+			break;
+	}
+
+	fl = malloc(sizeof(file_spec_t));
+	if (!fl)
+		goto oom;
+	fl->ino = ino;
+	fl->con = strdup(con);
+	if (!fl->con)
+		goto oom_freefl;
+	fl->file = strdup(file);
+	if (!fl->file)
+		goto oom_freefl;
+	fl->next = prevfl->next;
+	prevfl->next = fl;
+	return 0;
+      oom_freefl:
+	free(fl);
+      oom:
+	fprintf(stderr,
+		"%s:  insufficient memory for file label entry for %s\n",
+		__FUNCTION__, file);
+	return -1;
 }
 
+/*
+ * Evaluate the association hash table distribution.
+ */
+void filespec_eval(void)
+{
+	file_spec_t *fl;
+	int h, used, nel, len, longest;
+
+	if (!fl_head)
+		return;
+
+	used = 0;
+	longest = 0;
+	nel = 0;
+	for (h = 0; h < HASH_BUCKETS; h++) {
+		len = 0;
+		for (fl = fl_head[h].next; fl; fl = fl->next) {
+			len++;
+		}
+		if (len)
+			used++;
+		if (len > longest)
+			longest = len;
+		nel += len;
+	}
+
+	printf
+	    ("%s:  hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
+	     __FUNCTION__, nel, used, HASH_BUCKETS, longest);
+}
+
+/*
+ * Destroy the association hash table.
+ */
+void filespec_destroy(void)
+{
+	file_spec_t *fl, *tmp;
+	int h;
+
+	if (!fl_head)
+		return;
+
+	for (h = 0; h < HASH_BUCKETS; h++) {
+		fl = fl_head[h].next;
+		while (fl) {
+			tmp = fl;
+			fl = fl->next;
+			freecon(tmp->con);
+			free(tmp->file);
+			free(tmp);
+		}
+		fl_head[h].next = NULL;
+	}
+	free(fl_head);
+	fl_head = NULL;
+}
+
 static int add_exclude(const char *directory)
 {
 	struct stat sb;
@@ -230,9 +375,9 @@
 
 	if (rootpath != NULL && name[0] == '\0')
 		/* this is actually the root dir of the alt root */
-		return matchpathcon_index("/", sb->st_mode, con);
+		return selabel_lookup_raw(hnd, con, "/", sb->st_mode);
 	else
-		return matchpathcon_index(name, sb->st_mode, con);
+		return selabel_lookup_raw(hnd, con, name, sb->st_mode);
 }
 
 void usage(const char *const name)
@@ -282,7 +427,7 @@
 {
 	char *my_file = strdupa(file);
 	struct stat my_sb;
-	int i, j, ret;
+	int ret;
 	char *context, *newcon;
 	int user_only_changed = 0;
 	size_t len = strlen(my_file);
@@ -293,10 +438,9 @@
 	if (len > 1 && my_file[len - 1] == '/')
 		my_file[len - 1] = 0;
 
-	i = match(my_file, &my_sb, &newcon);
-	if (i < 0)
-		/* No matching specification. */
-		return 0;
+	if (match(my_file, &my_sb, &newcon) < 0)
+		/* Check for no matching specification. */
+		return (errno == ENOENT) ? 0 : -1;
 
 	if (progress) {
 		count++;
@@ -317,14 +461,13 @@
 	 * then use the last matching specification.
 	 */
 	if (add_assoc) {
-		j = matchpathcon_filespec_add(my_sb.st_ino, i, my_file);
-		if (j < 0)
+		ret = filespec_add(my_sb.st_ino, newcon, my_file);
+		if (ret < 0)
 			goto err;
 
-		if (j != i) {
+		if (ret > 0)
 			/* There was already an association and it took precedence. */
 			goto out;
-		}
 	}
 
 	if (debug) {
@@ -460,33 +603,25 @@
 	rootpathlen = len;
 }
 
-int canoncon(const char *path, unsigned lineno, char **contextp)
+int canoncon(char **contextp)
 {
 	char *context = *contextp, *tmpcon;
-	int valid = 1;
+	int rc = 0;
 
 	if (policyfile) {
-		valid = (sepol_check_context(context) >= 0);
-	} else if (security_canonicalize_context_raw(context, &tmpcon) < 0) {
-		if (errno != ENOENT) {
-			valid = 0;
-			inc_err();
+		if (sepol_check_context(context) < 0) {
+			fprintf(stderr, "invalid context %s\n", context);
+			exit(1);
 		}
-	} else {
+	} else if (security_canonicalize_context_raw(context, &tmpcon) == 0) {
 		free(context);
 		*contextp = tmpcon;
+	} else if (errno != ENOENT) {
+		rc = -1;
+		inc_err();
 	}
 
-	if (!valid) {
-		fprintf(stderr, "%s:  line %u has invalid context %s\n",
-			path, lineno, context);
-
-		/* Exit immediately if we're in checking mode. */
-		if (policyfile)
-			exit(1);
-	}
-
-	return !valid;
+	return rc;
 }
 
 static int pre_stat(const char *file_unused __attribute__ ((unused)),
@@ -557,10 +692,9 @@
 
 out:
 	if (add_assoc) {
-		set_matchpathcon_printf(&qprintf);
-		matchpathcon_filespec_eval();
-		set_matchpathcon_printf(NULL);
-		matchpathcon_filespec_destroy();
+		if (!quiet)
+			filespec_eval();
+		filespec_destroy();
 	}
 
 	return rc;
@@ -605,14 +739,20 @@
 int main(int argc, char **argv)
 {
 	struct stat sb;
-	int opt, rc, i = 0;
+	int opt, i = 0;
 	char *input_filename = NULL;
 	int use_input_file = 0;
 	char *buf = NULL;
 	size_t buf_len;
 	char *base;
+	struct selabel_opt opts[] = {
+		{ SELABEL_OPT_VALIDATE, NULL },
+		{ SELABEL_OPT_BASEONLY, NULL },
+		{ SELABEL_OPT_PATH, NULL }
+	};
 
 	memset(excludeArray, 0, sizeof(excludeArray));
+	altpath = NULL;
 
 	progname = strdup(argv[0]);
 	if (!progname) {
@@ -637,7 +777,7 @@
 		abort_on_error = 1;
 		add_assoc = 1;
 		nftw_flags = FTW_PHYS | FTW_MOUNT;
-		matchpathcon_flags = MATCHPATHCON_VALIDATE | MATCHPATHCON_NOTRANS;
+		ctx_validate = 1;
 	} else {
 		/*
 		 * restorecon:  
@@ -648,15 +788,15 @@
 		 * Follows mounts,
 		 * Does lazy validation of contexts upon use. 
 		 */
-		if (strcmp(base, RESTORECON)) 
-			qprintf("Executed with an unrecognized name (%s), defaulting to %s behavior.\n", base, RESTORECON);
+		if (strcmp(base, RESTORECON) && !quiet) 
+			printf("Executed with an unrecognized name (%s), defaulting to %s behavior.\n", base, RESTORECON);
 		iamrestorecon = 1;
 		recurse = 0;
 		expand_realpath = 1;
 		abort_on_error = 0;
 		add_assoc = 0;
 		nftw_flags = FTW_PHYS;
-		matchpathcon_flags = MATCHPATHCON_NOTRANS;
+		ctx_validate = 0;
 
 		/* restorecon only:  silent exit if no SELinux.
 		   Allows unconditional execution by scripts. */
@@ -664,8 +804,6 @@
 			exit(0);
 	}
 
-	set_matchpathcon_flags(matchpathcon_flags);
-
 	/* Process any options. */
 	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW")) > 0) {
 		switch (opt) {
@@ -700,9 +838,8 @@
 				/* Only process the specified file_contexts file, not
 				   any .homedirs or .local files, and do not perform
 				   context translations. */
-				set_matchpathcon_flags(MATCHPATHCON_BASEONLY |
-						       MATCHPATHCON_NOTRANS |
-						       MATCHPATHCON_VALIDATE);
+				base_only = 1;
+				ctx_validate = 1;
 
 				break;
 			}
@@ -812,7 +949,8 @@
 		/* Use our own invalid context checking function so that
 		   we can support either checking against the active policy or
 		   checking against a binary policy file. */
-		set_matchpathcon_canoncon(&canoncon);
+		selinux_set_callback(SELINUX_CB_VALIDATE,
+				     (union selinux_callback)&canoncon);
 
 		if (stat(argv[optind], &sb) < 0) {
 			perror(argv[optind]);
@@ -824,19 +962,24 @@
 			exit(1);
 		}
 
-		/* Load the file contexts configuration and check it. */
-		rc = matchpathcon_init(argv[optind]);
-		if (rc < 0) {
-			perror(argv[optind]);
-			exit(1);
-		}
-
+		altpath = argv[optind];
 		optind++;
+	}
 
-		if (nerr)
-			exit(1);
+	/* Load the file contexts configuration and check it. */
+	opts[0].value = (char *)ctx_validate;
+	opts[1].value = (char *)base_only;
+	opts[2].value = altpath;
+
+	hnd = selabel_open(SELABEL_CTX_FILE, opts, 3);
+	if (!hnd) {
+		perror(altpath);
+		exit(1);
 	}
 
+	if (nerr)
+		exit(1);
+
 	if (use_input_file) {
 		FILE *f = stdin;
 		ssize_t len;
@@ -863,8 +1006,10 @@
 	maybe_audit_mass_relabel();
 
 	if (warn_no_match)
-		matchpathcon_checkmatches(argv[0]);
+		selabel_stats(hnd);
 
+	selabel_close(hnd);
+
 	if (outfile)
 		fclose(outfile);
 


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
