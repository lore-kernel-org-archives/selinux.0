Message-ID: <44981564.9020106@redhat.com>
Date: Tue, 20 Jun 2006 11:33:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: New patch for libselinux
References: <4497FCCF.1030805@redhat.com> <1150812243.17557.79.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1150812243.17557.79.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040102010904060808070004"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040102010904060808070004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch to libselinux to fix handling of MATCHPATHCON_NOTRANS.

Also added two new functions to handle looking at files on disk and 
comparing to the default file_contexts,  These functions are
intended to be used by rpm -V.



--------------040102010904060808070004
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.30.15/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2006-06-16 15:08:24.000000000 -0400
+++ libselinux-1.30.15/include/selinux/selinux.h	2006-06-20 09:25:45.000000000 -0400
@@ -429,8 +429,17 @@
    Caller must free the returned strings via free. */
 extern int getseuserbyname(const char *linuxuser, char **seuser, char **level);
 
+/* This function allows you to compare two security context and ignore the 
+user component */
+int selinux_compare_context_without_user(const security_context_t a, const security_context_t b);
+
+/* This function looks at the file context on disk and compares it to the 
+system defaults, it returns 1 on match non 0 on failure */
+int selinux_verify_file_context(const char *path, mode_t mode);
+
 #ifdef __cplusplus
 }
 #endif
 
 #endif
+
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/matchpathcon.8 libselinux-1.30.15/man/man8/matchpathcon.8
--- nsalibselinux/man/man8/matchpathcon.8	2006-05-15 09:43:24.000000000 -0400
+++ libselinux-1.30.15/man/man8/matchpathcon.8	2006-06-20 10:56:07.000000000 -0400
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
+++ libselinux-1.30.15/src/matchpathcon.c	2006-06-20 11:27:47.000000000 -0400
@@ -26,6 +26,8 @@
 	va_end(ap);
 }
 
+static unsigned int myflags;
+
 static void 
 #ifdef __GNUC__
 __attribute__ ((format (printf, 1, 2)))
@@ -50,7 +52,12 @@
 static int default_canoncon(const char *path, unsigned lineno, char **context)
 {
 	char *tmpcon;
-	if (security_canonicalize_context(*context, &tmpcon) < 0) {
+	int rc;
+	if (myflags & MATCHPATHCON_NOTRANS)
+		rc = security_canonicalize_context_raw(*context, &tmpcon);
+	else
+		rc = security_canonicalize_context(*context, &tmpcon);
+	if ( rc < 0) {
 		if (errno == ENOENT)
 			return 0;
 		if (lineno)
@@ -74,8 +81,6 @@
 		mycanoncon = &default_canoncon;
 }
 
-static unsigned int myflags;
-
 void set_matchpathcon_flags(unsigned int flags)
 {
 	myflags = flags;
@@ -580,7 +585,6 @@
 				spec_arr[nspec].context_valid = 1;
 			}
 		}
-
 		spec_arr[nspec].context = context;
 		
 		/* Determine if specification has 
@@ -797,7 +801,6 @@
 		errno = ENOENT;
 		return -1;
 	}
-
 	spec_arr[i].matches++;
 
 	return i;
@@ -877,3 +880,47 @@
 		}
 	}
 }
+
+/* Compare two contexts to see if their differences are "significant",
+ * or whether the only difference is in the user. */
+int selinux_compare_context_without_user(const security_context_t a, const security_context_t b)
+{
+	char *rest_a, *rest_b; /* Rest of the context after the user */
+	if (!a || !b) return 0;
+	rest_a = strchr((char *)a, ':');
+	rest_b = strchr((char *)b, ':');
+	if (!rest_a || !rest_b) return 0;
+	return  (strcmp(rest_a, rest_b) == 0);
+}
+
+
+int selinux_verify_file_context(const char *path, mode_t mode)
+{
+ 	security_context_t con = NULL;
+ 	security_context_t fcontext = NULL;
+	int rc=0;
+
+	if (myflags & MATCHPATHCON_NOTRANS) 
+		rc = lgetfilecon_raw(path, &con);
+	else 
+		rc = lgetfilecon(path, &con);
+	if (rc == -1) {
+		if (errno != ENOTSUP)
+			return 1;
+	        else
+			return 0;
+	}
+
+	if (matchpathcon(path,mode,&fcontext) != 0)  {
+		if (fcontext == NULL && errno != ENOENT) 
+			rc = 1;
+		else
+			rc = 0;
+	} 
+	else 
+		rc = selinux_compare_context_without_user(fcontext, con);
+n	freecon(con);
+	freecon(fcontext); 
+	return rc;
+}
+
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/matchpathcon.c libselinux-1.30.15/utils/matchpathcon.c
--- nsalibselinux/utils/matchpathcon.c	2006-05-18 12:11:17.000000000 -0400
+++ libselinux-1.30.15/utils/matchpathcon.c	2006-06-20 11:30:26.000000000 -0400
@@ -12,19 +12,43 @@
 	exit(1);
 }
 
+int printmatchpathcon(char *path, int header) {
+	char *buf;
+	int rc = matchpathcon(path, 0, &buf);
+	if (rc < 0) {
+		fprintf(stderr, "matchpathcon(%s) failed\n", path);
+		return 2;
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
@@ -54,17 +78,29 @@
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
+			if (selinux_verify_file_context(argv[i], 0)) {
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
+					printmatchpathcon(argv[i], 0);
+					freecon(con);
+				} else {
+					printf("actual context unknown: %s, should be ", strerror(errno));
+					printmatchpathcon(argv[i], 0);
+				}
+			}
+		} else {
+			printmatchpathcon(argv[i], header);
+		}
 	}
 	matchpathcon_fini();
 	return 0;

--------------040102010904060808070004--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
