Message-ID: <41F148B8.5090504@redhat.com>
Date: Fri, 21 Jan 2005 13:23:52 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Change of restorecon and setfiles to not modify context if only_user_section
 changed
Content-Type: multipart/mixed;
 boundary="------------050503080506060408030006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050503080506060408030006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Specifying force (-F) will override.

Dan

--------------050503080506060408030006
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

Binary files nsapolicycoreutils/load_policy/load_policy and policycoreutils-1.21.1/load_policy/load_policy differ
Binary files nsapolicycoreutils/newrole/newrole and policycoreutils-1.21.1/newrole/newrole differ
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.21.1/restorecon/restorecon.c
--- nsapolicycoreutils/restorecon/restorecon.c	2005-01-20 15:59:21.000000000 -0500
+++ policycoreutils-1.21.1/restorecon/restorecon.c	2005-01-21 13:21:44.916873000 -0500
@@ -50,15 +50,12 @@
 static int only_changed_user(const char *a, const char *b)
 {
 	char *rest_a, *rest_b; /* Rest of the context after the user */
-	if (!a || !b)
-		return 0;
+	if (force) return 0;
+	if (!a || !b) return 0;
 	rest_a = strchr(a, ':');
 	rest_b = strchr(b, ':');
-	if (!rest_a || !rest_b)
-		return 0;
-	if (strcmp(rest_a, rest_b) == 0)
-		return 1;
-	return 0;
+	if (!rest_a || !rest_b) return 0;
+	return  (strcmp(rest_a, rest_b) == 0);
 }
 
 void usage(const char * const name)
@@ -75,6 +72,7 @@
   int len=strlen(filename);
   struct stat st;
   char path[PATH_MAX+1];
+  int user_only_changed=0;
   /* 
      Eliminate trailing /
   */
@@ -139,7 +137,8 @@
       if (outfile) {
 	fprintf(outfile, "%s\n", filename);
       }
-      if (change) {
+      user_only_changed = only_changed_user(scontext, prev_context);
+      if (change && !user_only_changed) {
 	retval=lsetfilecon(filename,scontext);
       }
       if (retval<0) {
@@ -151,7 +150,7 @@
 	  return 1;
       } else 	
 	      if (verbose && 
-		  (verbose > 1 || !only_changed_user(scontext, prev_context)))
+		  (verbose > 1 || !user_only_changed))
 		      fprintf(stderr,"%s reset context %s:%s->%s\n",
 			      progname, filename, (retcontext >= 0 ? prev_context : ""), scontext);
     }
Binary files nsapolicycoreutils/run_init/run_init and policycoreutils-1.21.1/run_init/run_init differ
Binary files nsapolicycoreutils/setfiles/setfiles and policycoreutils-1.21.1/setfiles/setfiles differ
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/setfiles/setfiles.c policycoreutils-1.21.1/setfiles/setfiles.c
--- nsapolicycoreutils/setfiles/setfiles.c	2005-01-20 15:59:22.000000000 -0500
+++ policycoreutils-1.21.1/setfiles/setfiles.c	2005-01-21 13:21:14.438382000 -0500
@@ -583,13 +583,12 @@
 static int only_changed_user(const char *a, const char *b)
 {
 	char *rest_a, *rest_b; /* Rest of the context after the user */
+	if (force) return 0;
+	if (!a || !b) return 0;
 	rest_a = strchr(a, ':');
 	rest_b = strchr(b, ':');
-	if (!rest_a || !rest_b)
-		return 0;
-	if (strcmp(rest_a, rest_b) == 0)
-		return 1;
-	return 0;
+	if (!rest_a || !rest_b) return 0;
+	return  (strcmp(rest_a, rest_b) == 0);
 }
 
 /*
@@ -605,6 +604,7 @@
 	struct stat my_sb;
 	int i, ret;
 	char *context; 
+	int user_only_changed=0;
 
 	/* Skip the extra slash at the beginning, if present. */
 	if (file[0] == '/' && file[1] == '/')
@@ -666,6 +666,8 @@
 		}
 	}
 
+	user_only_changed=only_changed_user(context, spec_arr[i].context);
+
 	/*
 	 * Do not relabel the file if the matching specification is 
 	 * <<none>> or the file is already labeled according to the 
@@ -690,21 +692,18 @@
 		/* If we're just doing "-v", trim out any relabels where
 		 * the user has changed but the role and type are the
 		 * same.  For "-vv", emit everything. */
-		if (verbose > 1 || 
-		    !only_changed_user(context, spec_arr[i].context)) {
+		if (verbose > 1 || !user_only_changed) {
 			printf("%s:  relabeling %s from %s to %s\n", progname,
 			       my_file, context, spec_arr[i].context);
 		}
 	}
 
-	if (log &&
-	    !only_changed_user(context, spec_arr[i].context)) {
+	if ( log && !user_only_changed ) {
 		syslog(LOG_INFO, "relabeling %s from %s to %s\n", 
 		       my_file, context, spec_arr[i].context);
 	}
 
-	if (outfile &&
-	    !only_changed_user(context, spec_arr[i].context)) 
+	if (outfile && !user_only_changed)
 		fprintf(outfile, "%s\n", my_file);
 
 	freecon(context);
@@ -712,7 +711,7 @@
 	/*
 	 * Do not relabel the file if -n was used.
 	 */
-	if (!change)
+	if (!change || user_only_changed) 
 		return 0;
 
 	/*
Binary files nsapolicycoreutils/setfiles/setfiles.o and policycoreutils-1.21.1/setfiles/setfiles.o differ

--------------050503080506060408030006--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
