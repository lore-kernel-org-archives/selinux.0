Message-ID: <420BD7E6.4000208@redhat.com>
Date: Thu, 10 Feb 2005 16:53:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: libselinux patch to add file_context.homedirs and remove potential
 memory and fd leaks.
Content-Type: multipart/mixed;
 boundary="------------010107030209040807070208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010107030209040807070208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------010107030209040807070208
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchpathcon.c libselinux-1.21.9/src/matchpathcon.c
--- nsalibselinux/src/matchpathcon.c	2005-01-31 13:50:18.000000000 -0500
+++ libselinux-1.21.9/src/matchpathcon.c	2005-02-10 16:51:59.000000000 -0500
@@ -519,10 +519,13 @@
 {
 	FILE *fp;
 	FILE *localfp;
+	FILE *homedirfp;
 	char local_path[PATH_MAX + 1];
+	char homedir_path[PATH_MAX + 1];
 	char line_buf[BUFSIZ + 1];
 	unsigned int lineno, pass, i, j, maxnspec;
 	spec_t *spec_copy;
+	int status=-1;
 
 	/* Open the specification file. */
 	if (!path)
@@ -530,6 +533,9 @@
 	if ((fp = fopen(path, "r")) == NULL)
 		return -1;
 
+	snprintf(homedir_path, sizeof(homedir_path), "%s.homedirs", path);
+	homedirfp = fopen(homedir_path, "r");
+
 	snprintf(local_path, sizeof(local_path), "%s.local", path);
 	localfp = fopen(local_path, "r");
 
@@ -547,33 +553,41 @@
 		nspec = 0;
 		while (fgets_unlocked(line_buf, sizeof line_buf, fp) && nspec < maxnspec) {
 			if (process_line(path, line_buf, pass, ++lineno) != 0)
-				return -1;
+				goto finish;
 		}
+		if (homedirfp) 
+			while (fgets_unlocked(line_buf, sizeof line_buf, homedirfp) && nspec < maxnspec) {
+				if (process_line(homedir_path, line_buf, pass, ++lineno) != 0)
+					goto finish;
+			}
+
+
 		if (localfp) 
 			while (fgets_unlocked(line_buf, sizeof line_buf, localfp) && nspec < maxnspec) {
 				if (process_line(local_path, line_buf, pass, ++lineno) != 0)
-					return -1;
+					goto finish;
 			}
 
 		if (pass == 0) {
-			if (nspec == 0)
-				return 0;
+			if (nspec == 0) {
+				status = 0;
+				goto finish;
+			}
 			if ((spec_arr = malloc(sizeof(spec_t) * nspec)) ==
 			    NULL)
-				return -1;
+				goto finish;
 			memset(spec_arr, '\0', sizeof(spec_t) * nspec);
 			maxnspec = nspec;
 			rewind(fp);
+			if (homedirfp) rewind(homedirfp);
 			if (localfp) rewind(localfp);
 		}
 	}
-	fclose(fp);
-	if (localfp) fclose(localfp);
 
 	/* Move exact pathname specifications to the end. */
 	spec_copy = malloc(sizeof(spec_t) * nspec);
 	if (!spec_copy)
-		return -1;
+		goto finish;
 	j = 0;
 	for (i = 0; i < nspec; i++) {
 		if (spec_arr[i].hasMetaChars)
@@ -588,7 +602,13 @@
 
 	nodups_specs(path);
 
-	return 0;
+	status = 0;
+ finish:
+	fclose(fp);
+	if (spec_arr != spec_copy) free(spec_arr);
+	if (homedirfp) fclose(homedirfp);
+	if (localfp) fclose(localfp);
+	return status;
 }
 hidden_def(matchpathcon_init)
 

--------------010107030209040807070208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
