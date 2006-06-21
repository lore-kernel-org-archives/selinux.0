Message-ID: <4499A2F0.8070900@redhat.com>
Date: Wed, 21 Jun 2006 15:50:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Yet another pass at libselinux/matchpathcon fix.
Content-Type: multipart/mixed;
 boundary="------------070801080502000403070803"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070801080502000403070803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

functions renamed to
selinux_file_context_cmp and selinux_file_context_verify

Translation is postponed until last second.  I think for matchpathcon 
the default should be NOTRANS.

Tools that display should have to translate.  I think we had the other 
default because of upgrade from FC4?  Which we will need to handle when 
upgrading RHEL4 if
we decide to change default.

This change will slow down apps that call matchpathcon many times with 
translations turned on.


Dan

--------------070801080502000403070803
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.30.15/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2006-06-16 15:08:24.000000000 -0400
+++ libselinux-1.30.15/include/selinux/selinux.h	2006-06-21 15:26:36.000000000 -0400
@@ -429,8 +429,19 @@
    Caller must free the returned strings via free. */
 extern int getseuserbyname(const char *linuxuser, char **seuser, char **level);
 
+/* This function compares two file context, ignoring the user component */
+int selinux_file_context_cmp(const security_context_t a, const security_context_t b);
+
+/* This function looks at the file context on disk and compares it to the 
+system defaults, it returns 0 on match non 0 on failure */
+int selinux_file_context_verify(const char *path, mode_t mode);
+
+/* This function sets the file context on to the system defaults returns 0 on success */
+int selinux_lsetfilecon_default(const char *path);
+
 #ifdef __cplusplus
 }
 #endif
 
 #endif
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/matchpathcon.8 libselinux-1.30.15/man/man8/matchpathcon.8
--- nsalibselinux/man/man8/matchpathcon.8	2006-05-15 09:43:24.000000000 -0400
+++ libselinux-1.30.15/man/man8/matchpathcon.8	2006-06-21 15:26:36.000000000 -0400
@@ -3,13 +3,25 @@
 matchpathcon \- get the default security context for the specified path from the file contexts configuration.
 
 .SH "SYNOPSIS"
-.B matchpathcon [-n] filepath...
-
+.B matchpathcon [-V] [-N] [-n] [-f file_contexts_file ] [-p prefix ] filepath...
 .SH "DESCRIPTION"
 .B matchpathcon
 Prints the file path and the default security context associated with it.
+.SH OPTIONS
+.B \-n
+Do not display path.
+.br
+.B \-N
+Do not use translations.
+.br
+.B \-f file_context_file
+Use alternate file_context file
+.br
+.B \-p prefix
+Use prefix to speed translations
 .br
-If the -n option is given, do not display path.
+.B \-V
+Verify file context on disk matches defaults
 
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchpathcon.c libselinux-1.30.15/src/matchpathcon.c
--- nsalibselinux/src/matchpathcon.c	2006-05-18 12:11:17.000000000 -0400
+++ libselinux-1.30.15/src/matchpathcon.c	2006-06-21 15:37:18.000000000 -0400
@@ -20,10 +20,12 @@
 #endif
 default_printf(const char *fmt, ...) 
 {
+#ifdef DEBUG
 	va_list ap;
 	va_start(ap, fmt);
 	vfprintf(stderr, fmt, ap);
 	va_end(ap);
+#endif
 }
 
 static void 
@@ -50,7 +52,7 @@
 static int default_canoncon(const char *path, unsigned lineno, char **context)
 {
 	char *tmpcon;
-	if (security_canonicalize_context(*context, &tmpcon) < 0) {
+	if (security_canonicalize_context_raw(*context, &tmpcon) < 0) {
 		if (errno == ENOENT)
 			return 0;
 		if (lineno)
@@ -74,7 +76,7 @@
 		mycanoncon = &default_canoncon;
 }
 
-static unsigned int myflags;
+static __thread unsigned int myflags;
 
 void set_matchpathcon_flags(unsigned int flags)
 {
@@ -552,21 +554,6 @@
 		
 	skip_type:
 		if (strcmp(context, "<<none>>")) {
-			char *tmpcon = NULL;
-
-			if (myflags & MATCHPATHCON_NOTRANS)
-				goto skip_trans;
-
-			if (selinux_raw_to_trans_context(context, &tmpcon)) {
-				myprintf("%s: line %u has invalid "
-					 "context %s\n",
-					 path, lineno, context);
-				return 0;
-			}
-			free(context);
-			context = tmpcon;
-
-skip_trans:
 			if (myflags & MATCHPATHCON_VALIDATE) {
 				if (myinvalidcon) {
 					/* Old-style validation of context. */
@@ -831,7 +818,12 @@
 		spec_arr[i].context_valid = 1;
 	}
 
-	*con = strdup(spec_arr[i].context);
+	if (myflags & MATCHPATHCON_NOTRANS) {
+		*con = strdup(spec_arr[i].context);
+	} else {
+		if (selinux_raw_to_trans_context(spec_arr[i].context, con)) 
+			return -1;
+	}
 	if (!(*con))
 		return -1;
 
@@ -877,3 +869,72 @@
 		}
 	}
 }
+
+/* Compare two contexts to see if their differences are "significant",
+ * or whether the only difference is in the user. */
+int selinux_file_context_cmp(const security_context_t a, const security_context_t b)
+{
+	char *rest_a, *rest_b; /* Rest of the context after the user */
+	if (!a && !b) return 0;
+	if (!a && b) return -1;
+	if (a && !b) return 1;
+	rest_a = strchr((char *)a, ':');
+	rest_b = strchr((char *)b, ':');
+	if (!rest_a && !rest_b) return 0;
+	if (!rest_a && rest_b) return -1;
+	if (rest_a && !rest_b) return 1;
+	return  strcmp(rest_a, rest_b);
+}
+
+int selinux_file_context_verify(const char *path, mode_t mode)
+{
+ 	security_context_t con = NULL;
+ 	security_context_t fcontext = NULL;
+	unsigned int localflags=myflags;
+	int rc=0;
+
+	rc = lgetfilecon_raw(path, &con);
+	if (rc == -1) {
+		if (errno != ENOTSUP)
+			return 1;
+	        else
+			return 0;
+	}
+
+	set_matchpathcon_flags(myflags | MATCHPATHCON_NOTRANS);
+	if (matchpathcon(path,mode,&fcontext) != 0)  {
+		if (errno != ENOENT) 
+			rc = 1;
+		else
+			rc = 0;
+	} 
+	else 
+		rc = (selinux_file_context_cmp(fcontext, con) == 0);
+	set_matchpathcon_flags(localflags);
+	freecon(con);
+	freecon(fcontext); 
+	return rc;
+}
+
+
+int selinux_lsetfilecon_default(const char *path) {
+	struct stat st;
+	int rc = -1;
+	security_context_t scontext=NULL;
+	unsigned int localflags=myflags;
+	if (lstat(path, &st) != 0)
+		return rc;
+
+	set_matchpathcon_flags(myflags | MATCHPATHCON_NOTRANS);
+
+	/* If there's an error determining the context, or it has none, 
+	   return to allow default context */
+	if (matchpathcon(path, st.st_mode, &scontext)) {
+		if (errno == ENOENT) rc = 0;
+	} else 	{
+		rc = lsetfilecon_raw(path, scontext);
+		freecon(scontext);
+	}
+	set_matchpathcon_flags(localflags);
+	return rc;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/matchpathcon.c libselinux-1.30.15/utils/matchpathcon.c
--- nsalibselinux/utils/matchpathcon.c	2006-05-18 12:11:17.000000000 -0400
+++ libselinux-1.30.15/utils/matchpathcon.c	2006-06-21 15:26:36.000000000 -0400
@@ -12,19 +12,44 @@
 	exit(1);
 }
 
+int printmatchpathcon(char *path, int header) {
+	char *buf;
+	int rc = matchpathcon(path, 0, &buf);
+	if (rc < 0) {
+		fprintf(stderr, "matchpathcon(%s) failed: %s\n", path, strerror(errno));
+		return 1;
+	}
+	if (header)
+		printf("%s\t%s\n", path, buf);
+	else
+		printf("%s\n", buf);
+	
+	freecon(buf);
+	return 0;
+}
+
 int main(int argc, char **argv) 
 {
-	char *buf;
-	int rc, i, init = 0;
+	int i, init = 0;
 	int header=1, opt;
+	int verify=0;
+	int notrans=0;
+	int error=0;
 
 	if (argc < 2) usage(argv[0]);
 
-	while ((opt = getopt(argc, argv, "nf:p:")) > 0) {
+	while ((opt = getopt(argc, argv, "Nnf:p:V")) > 0) {
 		switch (opt) {
 		case 'n':
 			header=0;
 			break;
+		case 'V':
+			verify=1;
+			break;
+		case 'N':
+			notrans=1;
+			set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
+			break;
 		case 'f':
 			if (init) {
 				fprintf(stderr, "%s:  -f and -p are exclusive\n", argv[0]);
@@ -54,18 +79,30 @@
 		}
 	}
 	for (i = optind; i < argc; i++) {
-		rc = matchpathcon(argv[i], 0, &buf);
-		if (rc < 0) {
-			fprintf(stderr, "%s:  matchpathcon(%s) failed\n", argv[0], argv[i]);
-			return 2;
-		}
-		if (header)
-			printf("%s\t%s\n", argv[i], buf);
-		else
-			printf("%s\n", buf);
+		if (verify) {
+			if (selinux_file_context_verify(argv[i], 0)) {
+				printf("%s verified.\n", argv[i]);
+			} else {
+				security_context_t con;
+				int rc;
+				if (notrans) 
+					rc = lgetfilecon_raw(argv[i], &con);
+				else
+					rc = lgetfilecon(argv[i], &con);
 
-		freecon(buf);
+				if (rc >= 0) {
+					printf("%s has context %s, should be ", argv[i], con);
+					error += printmatchpathcon(argv[i], 0);
+					freecon(con);
+				} else {
+					printf("actual context unknown: %s, should be ", strerror(errno));
+					error += printmatchpathcon(argv[i], 0);
+				}
+			}
+		} else {
+			error += printmatchpathcon(argv[i], header);
+		}
 	}
 	matchpathcon_fini();
-	return 0;
+	return error;
 }

--------------070801080502000403070803--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
