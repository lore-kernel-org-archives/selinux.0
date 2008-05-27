Subject: Re: Is there a command line tool that returns 1 if a file is in
	the wrong context?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <552999F5-C6B1-4ACE-B6CF-A4020CD13B5F@nall.com>
References: <552999F5-C6B1-4ACE-B6CF-A4020CD13B5F@nall.com>
Content-Type: text/plain
Date: Tue, 27 May 2008 11:28:37 -0400
Message-Id: <1211902117.19360.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 2008-05-24 at 18:58 -0500, Joe Nall wrote:
> Is there a command line tool that returns 1 if a file is in the wrong  
> context?. I want to add a %verifyscript to our rpms to validate the  
> installed file context when rpm -V is invoked.

I was going to suggest matchpathcon -V, except when trying it, I found
that there is a bug in the current libselinux that makes it seg fault
and it also doesn't return the status but rather displays it.  So how
about the patch below to fix the bug and make the exit status usable?

After this patch, you can run '/usr/sbin/matchpathcon -Vq path1
[path2...]' and check the exit status; 0 will mean that all verified;
non-zero will be the count of failures.

Index: libselinux/utils/matchpathcon.c
===================================================================
--- libselinux/utils/matchpathcon.c	(revision 2883)
+++ libselinux/utils/matchpathcon.c	(working copy)
@@ -12,7 +12,7 @@
 void usage(const char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-N] [-n] [-f file_contexts] [-p prefix] [-V] path...\n",
+		"usage:  %s [-N] [-n] [-f file_contexts] [-p prefix] [-Vq] path...\n",
 		progname);
 	exit(1);
 }
@@ -42,11 +42,12 @@
 	int verify = 0;
 	int notrans = 0;
 	int error = 0;
+	int quiet = 0;
 
 	if (argc < 2)
 		usage(argv[0]);
 
-	while ((opt = getopt(argc, argv, "Nnf:p:V")) > 0) {
+	while ((opt = getopt(argc, argv, "Nnf:p:Vq")) > 0) {
 		switch (opt) {
 		case 'n':
 			header = 0;
@@ -90,6 +91,9 @@
 				exit(1);
 			}
 			break;
+		case 'q':
+			quiet = 1;
+			break;
 		default:
 			usage(argv[0]);
 		}
@@ -101,11 +105,18 @@
 			mode = buf.st_mode;
 
 		if (verify) {
+			if (quiet) {
+				if (selinux_file_context_verify(argv[i], 0))
+					continue;
+				else
+					exit(1);
+			}
 			if (selinux_file_context_verify(argv[i], 0)) {
 				printf("%s verified.\n", argv[i]);
 			} else {
 				security_context_t con;
 				int rc;
+				error++;
 				if (notrans)
 					rc = lgetfilecon_raw(argv[i], &con);
 				else
@@ -114,15 +125,13 @@
 				if (rc >= 0) {
 					printf("%s has context %s, should be ",
 					       argv[i], con);
-					error +=
-					    printmatchpathcon(argv[i], 0, mode);
+					printmatchpathcon(argv[i], 0, mode);
 					freecon(con);
 				} else {
 					printf
 					    ("actual context unknown: %s, should be ",
 					     strerror(errno));
-					error +=
-					    printmatchpathcon(argv[i], 0, mode);
+					printmatchpathcon(argv[i], 0, mode);
 				}
 			}
 		} else {
Index: libselinux/src/matchpathcon.c
===================================================================
--- libselinux/src/matchpathcon.c	(revision 2883)
+++ libselinux/src/matchpathcon.c	(working copy)
@@ -372,6 +372,9 @@
 		else
 			return 0;
 	}
+	
+	if (!hnd && (matchpathcon_init_prefix(NULL, NULL) < 0))
+			return -1;
 
 	if (selabel_lookup_raw(hnd, &fcontext, path, mode) != 0) {
 		if (errno != ENOENT)
@@ -394,6 +397,9 @@
 	if (lstat(path, &st) != 0)
 		return rc;
 
+	if (!hnd && (matchpathcon_init_prefix(NULL, NULL) < 0))
+			return -1;
+
 	/* If there's an error determining the context, or it has none, 
 	   return to allow default context */
 	if (selabel_lookup_raw(hnd, &scontext, path, st.st_mode)) {
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
