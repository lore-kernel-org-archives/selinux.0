Message-ID: <41E544B6.1060606@redhat.com>
Date: Wed, 12 Jan 2005 10:39:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Colin Walters <walters@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Added is_context_configurable function
References: <41E2FEF4.5070604@redhat.com>	 <1105456934.20566.52.camel@moss-spartans.epoch.ncsc.mil>	 <41E3FAF4.2060109@redhat.com>	 <1105473610.20566.123.camel@moss-spartans.epoch.ncsc.mil>	 <1105481440.24748.22.camel@nexus.verbum.private> <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1105539555.22495.28.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------080804040408000801080602"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080804040408000801080602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch to policycoreutils so restorecon/setfiles can handle 
customizable_types.

Also fix a segfault in restorecon.

Dan

--------------080804040408000801080602
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.8 policycoreutils-1.20.1/restorecon/restorecon.8
--- nsapolicycoreutils/restorecon/restorecon.8	2004-10-06 09:47:27.000000000 -0400
+++ policycoreutils-1.20.1/restorecon/restorecon.8	2005-01-12 09:34:55.756460549 -0500
@@ -7,7 +7,7 @@
 .I [\-o outfilename ] [\-R] [\-n] [\-v] pathname...
 .P
 .B restorecon
-.I \-f infilename [\-o outfilename ] [\-R] [\-n] [\-v] 
+.I \-f infilename [\-o outfilename ] [\-R] [\-n] [\-v] [\-F]
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -38,6 +38,12 @@
 .B \-v
 show changes in file labels.
 .TP 
+.B \-vv
+show changes in file labels, if type, role, or user are changing.
+.TP 
+.B \-F
+Force reset of context to match file_context for customizable files
+.TP 
 .SH "ARGUMENTS"
 .B pathname...
 The pathname for the file(s) to be relabeled. 
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.20.1/restorecon/restorecon.c
--- nsapolicycoreutils/restorecon/restorecon.c	2005-01-07 09:42:39.000000000 -0500
+++ policycoreutils-1.20.1/restorecon/restorecon.c	2005-01-12 09:34:55.758460325 -0500
@@ -13,6 +13,7 @@
  * -n	Do not change any file labels.
  * -v	Show changes in file labels.  
  * -o filename save list of files with incorrect context
+ * -F	Force reset of context to match file_context for customizable files
  *
  * pathname...	The file(s) to label 
  *
@@ -41,13 +42,16 @@
 static FILE *outfile=NULL;
 static char *progname;
 static int errors=0;
-static int recurse;
+static int recurse=0;
+static int force=0;
 
 /* Compare two contexts to see if their differences are "significant",
  * or whether the only difference is in the user. */
 static int only_changed_user(const char *a, const char *b)
 {
 	char *rest_a, *rest_b; /* Rest of the context after the user */
+	if (!a || !b)
+		return 0;
 	rest_a = strchr(a, ':');
 	rest_b = strchr(b, ':');
 	if (!rest_a || !rest_b)
@@ -128,7 +132,10 @@
   retcontext=lgetfilecon(filename,&prev_context);
   
   if (retcontext >= 0 || errno == ENODATA) {
-    if (retcontext < 0 || strcmp(prev_context,scontext) != 0) {
+    int customizable=0;
+    if (retcontext < 0 || 
+	(strcmp(prev_context,scontext) != 0 && 	
+	 (customizable=(force ? 0: is_context_customizable(prev_context))==0))) {
       if (outfile) {
 	fprintf(outfile, "%s\n", filename);
       }
@@ -143,11 +150,16 @@
 	  freecon(scontext);
 	  return 1;
       } else 	
-	  if (verbose > 1 || 
-	      !only_changed_user(scontext, prev_context)) 
-	      fprintf(stderr,"%s reset context %s:%s->%s\n",
-		      progname, filename, prev_context, scontext);
-    } 
+	      if (verbose && 
+		  (verbose > 1 || !only_changed_user(scontext, prev_context)))
+		      fprintf(stderr,"%s reset context %s:%s->%s\n",
+			      progname, filename, (retcontext >= 0 ? prev_context : ""), scontext);
+    }
+    if (verbose > 1 && customizable>0) {
+	    fprintf(stderr,"%s: %s not reset customized by admin to %s\n",
+		      progname, filename, prev_context);
+    }
+
     if (retcontext >= 0)
       freecon(prev_context);
   } 
@@ -197,7 +209,7 @@
 
   memset(buf,0, sizeof(buf));
 
-  while ((opt = getopt(argc, argv, "Rnvf:o:")) > 0) {
+  while ((opt = getopt(argc, argv, "FRnvf:o:")) > 0) {
     switch (opt) {
     case 'n':
       change = 0;
@@ -205,6 +217,9 @@
     case 'R':
       recurse = 1;
       break;
+    case 'F':
+      force = 1;
+      break;
     case 'o':
       outfile = fopen(optarg,"w");
       if (!outfile) {
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/setfiles/setfiles.8 policycoreutils-1.20.1/setfiles/setfiles.8
--- nsapolicycoreutils/setfiles/setfiles.8	2004-10-06 09:47:28.000000000 -0400
+++ policycoreutils-1.20.1/setfiles/setfiles.8	2005-01-12 09:34:55.759460213 -0500
@@ -4,7 +4,7 @@
 
 .SH "SYNOPSIS"
 .B setfiles
-.I [\-d] [\-l] [\-n] [\-e directory ] [\-o filename ] [\-q] [\-s] [\-v] [\-vv] [\-W] spec_file pathname...
+.I [\-d] [\-l] [\-n] [\-e directory ] [\-o filename ] [\-q] [\-s] [\-v] [\-vv] [\-W] [\F] spec_file pathname...
 .SH "DESCRIPTION"
 This manual page describes the
 .BR setfiles
@@ -35,6 +35,9 @@
 .B \-e directory
 directory to exclude (repeat option for more than one directory.)
 .TP 
+.B \-F
+Force reset of context to match file_context for customizable files
+.TP 
 .B \-o filename
 save list of files with incorrect context in filename.
 .TP 
@@ -44,6 +47,7 @@
 .TP
 .B \-v
 show changes in file labels, if type or role are changing.
+.TP 
 .B \-vv
 show changes in file labels, if type, role, or user are changing.
 .TP 
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/setfiles/setfiles.c policycoreutils-1.20.1/setfiles/setfiles.c
--- nsapolicycoreutils/setfiles/setfiles.c	2004-10-06 09:47:28.000000000 -0400
+++ policycoreutils-1.20.1/setfiles/setfiles.c	2005-01-12 09:34:55.761459989 -0500
@@ -15,6 +15,7 @@
  * setfiles [-dnpqsvW] [-e directory ] [-c policy] [-o filename ] spec_file pathname...
  * 
  * -e   Specify directory to exclude
+ * -F	Force reset of context to match file_context for customizable files
  * -c   Verify the specification file using a binary policy
  * -d   Show what specification matched each file.
  * -l   Log changes in files labels to syslog.
@@ -76,6 +77,7 @@
 
 static int add_assoc = 1;
 static FILE *outfile=NULL;
+static int force=0;
 
 #define MAX_EXCLUDES 100
 static int excludeCtr=0;
@@ -675,6 +677,15 @@
 		return 0;
 	}
 
+	if (! force && 
+	    ( is_context_customizable(context)>0 )) {
+		if (verbose > 1) {
+			fprintf(stderr,"%s: %s not reset customized by admin to %s\n",
+				progname, my_file, context);
+		}
+		return 0;
+	}
+
 	if (verbose) {
 		/* If we're just doing "-v", trim out any relabels where
 		 * the user has changed but the role and type are the
@@ -775,7 +786,7 @@
 	memset(excludeArray,0, sizeof(excludeArray));
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:dlnqrsvWe:o:")) > 0) {
+	while ((opt = getopt(argc, argv, "Fc:dlnqrsvWe:o:")) > 0) {
 		switch (opt) {
 		case 'c':
 		{
@@ -837,6 +848,9 @@
 		case 'l':
 			log = 1;
 			break;
+		case 'F':
+			force = 1;
+			break;
 		case 'n':
 			change = 0;
 			break;

--------------080804040408000801080602--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
