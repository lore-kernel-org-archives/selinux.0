Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KEpHrT004438
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 10:51:17 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KEoZ4v012955
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 14:50:35 GMT
Subject: Re: conflict between libselinux and libsepol
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
	 <1092972342.29540.35.camel@nexus.verbum.private>
	 <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-FPs5v0giw8lgydiolozv"
Date: Fri, 20 Aug 2004 10:52:07 -0400
Message-Id: <1093013527.9495.0.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-FPs5v0giw8lgydiolozv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-08-20 at 07:48 -0400, Stephen Smalley wrote:

> I'd rather keep them independent, as they serve different purposes
> (types for the binary policy vs. types for the SELinux API) and may
> diverge over time.  

Ok.

> Simplest fix would be to add a distinguishing prefix
> to the sepol types to avoid namespace conflicts.  

That makes sense.  I'll wait for you to fix this, since it is mostly
search-and-replace, and a patch for it would be rather huge :)

> But I'm a bit curious
> about why setfiles would need libsepol at all, as it normally does not
> have anything to do with binary policies.

Well, one problem we ran into yesterday is that the content of
file_contexts is not easily verified to ensure there are no undefined
types.  During an installation, setfiles would abort after 10 errors by
default.  What we want to do is verify the content during a policy
package build, to ensure this doesn't happen again.

I'm attaching my (obviously untested) patch to setfiles, I think it will
work once sepol is fixed.



--=-FPs5v0giw8lgydiolozv
Content-Disposition: attachment; filename=policycoreutils-setfiles-validate.patch
Content-Type: text/x-patch; name=policycoreutils-setfiles-validate.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- policycoreutils-1.15.7/setfiles/setfiles.c.setfiles-validate	2004-08-16 07:57:40.000000000 -0400
+++ policycoreutils-1.15.7/setfiles/setfiles.c	2004-08-19 22:56:30.011752264 -0400
@@ -12,8 +12,9 @@
  * the user.  The program does not cross file system boundaries.
  *
  * USAGE:
- * setfiles [-dnpqsvW] [-o filename ] spec_file pathname...
+ * setfiles [-dnpqsvW] [-c policy] [-o filename ] spec_file pathname...
  * 
+ * -c   Verify the specification file using a binary policy
  * -d   Show what specification matched each file.
  * -n	Do not change any file labels.
  * -q   Be quiet (suppress non-error output).
@@ -66,6 +67,7 @@
 #define __USE_XOPEN_EXTENDED 1	/* nftw */
 #include <ftw.h>
 #include <limits.h>
+#include <sepol/services.h>
 #include <selinux/selinux.h>
 
 static int add_assoc = 1;
@@ -74,6 +76,7 @@
 /*
  * Command-line options.
  */
+static char *policyfile = NULL;
 static int debug = 0;
 static int change = 1;
 static int quiet = 0;
@@ -483,7 +486,8 @@
 {
 	fprintf(stderr,
 		"usage:  %s [-dnqvW] [-o filename] spec_file pathname...\n"
-		"usage:  %s -s [-dnqvW] [-o filename ] spec_file\n", name, name);
+		"usage:  %s [-c policyfile] spec_file\n"
+		"usage:  %s -s [-dnqvW] [-o filename ] spec_file\n", name, name, name);
 	exit(1);
 }
 
@@ -696,8 +700,33 @@
 	rootpathlen = len;
 }
 
+void validate_context(const char *context, const char *progname,
+		      int lineno)
+{
+	security_id_t sid;
+	int valid = 1;
+
+	if (policyfile && sepol_context_to_sid ((char *) context, strlen(context),
+						&sid) < 0) {
+		valid = 0;
+	} else if (security_check_context((char *) context) < 0 && errno != ENOENT) {
+		valid = 0;
+		inc_err();
+	}
+
+	if (!valid) {
+		fprintf(stderr, "%s:  invalid context %s on line number %d\n",
+			progname, context, lineno);
+
+		/* Exit immediately if we're in checking mode. */
+		if (policyfile)
+			exit(1);
+	}
+}
+
 int main(int argc, char **argv)
 {
+	policydb_t *policy;
 	FILE *fp;
 	/* 
 	   For now switching up to BUFSIZ, but this should be allocated
@@ -711,8 +740,43 @@
 	spec_t *spec_copy;
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "dnqrsvWo:")) > 0) {
+	while ((opt = getopt(argc, argv, "c:dnqrsvWo:")) > 0) {
 		switch (opt) {
+		case 'c':
+		{
+			struct policy_file fp;
+			policyfile = optarg;
+
+			if ((policy = malloc(sizeof(policydb_t))) == NULL) {
+				fprintf(stderr, "%s:  insufficient memory for policy load\n", argv[0]);
+				exit(1);
+			}
+
+			if (policydb_init(policy) < 0) {
+				fprintf(stderr, "Error initializing policy\n");
+				exit(1);
+			}
+
+			fp.fp = fopen(policyfile,"r");
+			if (!fp.fp) {
+				fprintf(stderr, "Error opening %s: %s\n", 
+					policyfile, strerror(errno));
+				exit(1);
+			}
+
+			fp.type = PF_USE_STDIO;
+			if (policydb_read (policy, &fp, 0) < 0) {
+				fprintf(stderr, "Error reading policy %s\n", policyfile);
+				exit(1);
+			}
+
+			if (sepol_set_policydb (policy) < 0) {
+				fprintf(stderr, "Error setting policy %s\n", policyfile);
+				exit(1);
+			}
+			
+			break;
+		}
 		case 'd':
 			debug = 1;
 			break;
@@ -760,7 +824,10 @@
 		}
 	}
 
-	if (use_stdin) {
+	if (policyfile) {
+		if (optind != (argc - 1))
+			usage(argv[0]);
+	} else if (use_stdin) {
 		if (optind != (argc - 1)) {
 			/* Cannot mix with pathname arguments. */
 			usage(argv[0]);
@@ -904,13 +971,7 @@
 				spec_arr[nspec].context = context;
 
 				if (strcmp(context, "<<none>>")) {
-					if (security_check_context(context) < 0 && errno != ENOENT) {
-						fprintf(stderr,
-							"%s:  invalid context %s on line number %d\n",
-							argv[0], context,
-							lineno);
-						inc_err();
-					}
+					validate_context(context, argv[0], lineno);
 				}
 
 				/* Determine if specification has 

--=-FPs5v0giw8lgydiolozv--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
