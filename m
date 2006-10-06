Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96M9tKg011409
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 18:09:55 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96M9IcV019380
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 22:09:18 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k96M9t6i005043
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 18:09:55 -0400
Subject: [PATCH 1/1] Reworked patch for restorecon
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 18:09:53 -0400
Message-Id: <1160172593.29401.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch makes the following changes to restorecon:

-i flag to tell restorecon to ignore missing files

-o now takes "-" to allow it to output file list to stdout

Check to make sure restorecon has at least one input file

This patch is based on Dan's patch from Sep. 26 but only includes the
restorecon changes (see
http://marc.theaimsgroup.com/?l=selinux&m=115928447719072&w=2). Please
apply.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

---

 restorecon.8 |    3 ++
 restorecon.c |   55 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/policycoreutils/restorecon/restorecon.8 b/policycoreutils/restorecon/restorecon.8
index f228407..172f6ef 100644
--- a/policycoreutils/restorecon/restorecon.8
+++ b/policycoreutils/restorecon/restorecon.8
@@ -23,6 +23,9 @@ contexts are all as you expect.
 
 .SH "OPTIONS"
 .TP 
+.B \-i
+ignore files that do not exist
+.TP 
 .B \-f infilename
 infilename contains a list of files to be processed by application. Use \- for stdin.
 .TP 
diff --git a/policycoreutils/restorecon/restorecon.c b/policycoreutils/restorecon/restorecon.c
index 022a453..c1352aa 100644
--- a/policycoreutils/restorecon/restorecon.c
+++ b/policycoreutils/restorecon/restorecon.c
@@ -11,9 +11,10 @@
  * restorecon [-Rnv] pathname...
  * 
  * -e   Specify directory to exclude
+ * -i   Ignore error if file does not exist
  * -n	Do not change any file labels.
  * -v	Show changes in file labels.  
- * -o filename save list of files with incorrect context
+ * -o	filename save list of files with incorrect context
  * -F	Force reset of context to match file_context for customizable files
  *
  * pathname...	The file(s) to label 
@@ -41,12 +42,14 @@ #define __USE_XOPEN_EXTENDED 1	/* nftw *
 #include <ftw.h>
 
 static int change = 1;
+static int change_ctr = 0;
 static int verbose = 0;
 static int progress = 0;
 static FILE *outfile = NULL;
 static char *progname;
 static int errors = 0;
 static int recurse = 0;
+static int file_exist = 1;
 static int force = 0;
 #define STAT_BLOCK_SIZE 1
 static int pipe_fds[2] = { -1, -1 };
@@ -62,6 +65,7 @@ static struct edir excludeArray[MAX_EXCL
 static int add_exclude(const char *directory)
 {
 	struct stat sb;
+	size_t len = 0;
 	if (directory == NULL || directory[0] != '/') {
 		fprintf(stderr, "Full path required for exclude: %s.\n",
 			directory);
@@ -85,12 +89,17 @@ static int add_exclude(const char *direc
 		return 1;
 	}
 
-	excludeArray[excludeCtr].directory = strdup(directory);
-	if (!excludeArray[excludeCtr].directory) {
+	len = strlen(directory);
+	while (len > 1 && directory[len - 1] == '/') {
+		len--;
+	}
+	excludeArray[excludeCtr].directory = strndup(directory, len);
+
+	if (excludeArray[excludeCtr].directory == NULL) {
 		fprintf(stderr, "Out of memory.\n");
 		return 1;
 	}
-	excludeArray[excludeCtr++].size = strlen(directory);
+	excludeArray[excludeCtr++].size = len;
 
 	return 0;
 }
@@ -129,7 +138,7 @@ static int only_changed_user(const char 
 void usage(const char *const name)
 {
 	fprintf(stderr,
-		"usage:  %s [-FnrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
+		"usage:  %s [-iFnrRv] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
 		name);
 	exit(1);
 }
@@ -160,6 +169,8 @@ int restore(const char *filename)
 	}
 
 	if (lstat(filename, &st) != 0) {
+		if (!file_exist && errno == ENOENT)
+			return 0;
 		fprintf(stderr, "lstat(%s) failed: %s\n", filename,
 			strerror(errno));
 		return 1;
@@ -249,7 +260,9 @@ int restore(const char *filename)
 						freecon(scontext);
 						return 1;
 					}
-				}
+				} else
+					change_ctr++;
+
 				if (verbose)
 					printf("%s reset %s context %s->%s\n",
 					       progname, filename,
@@ -322,6 +335,8 @@ void process(char *buf)
 			close(pipe_fds[1]);
 		if (rc == -1 || rc > 0) {
 			if (nftw(buf, apply_spec, 1024, FTW_PHYS)) {
+				if (!file_exist && errno == ENOENT)
+					return;
 				fprintf(stderr,
 					"%s:  error while labeling files under %s\n",
 					progname, buf);
@@ -351,13 +366,17 @@ int main(int argc, char **argv)
 	progname = argv[0];
 	if (is_selinux_enabled() <= 0)
 		exit(0);
+
 	set_matchpathcon_flags(MATCHPATHCON_NOTRANS);
 
-	while ((opt = getopt(argc, argv, "pFrRnvf:o:e:")) > 0) {
+	while ((opt = getopt(argc, argv, "ipFrRnvf:o:e:")) > 0) {
 		switch (opt) {
 		case 'n':
 			change = 0;
 			break;
+		case 'i':
+			file_exist = 0;
+			break;
 		case 'r':
 		case 'R':
 			recurse = 1;
@@ -370,13 +389,18 @@ int main(int argc, char **argv)
 				exit(1);
 			break;
 		case 'o':
-			outfile = fopen(optarg, "w");
-			if (!outfile) {
-				fprintf(stderr, "Error opening %s: %s\n",
-					optarg, strerror(errno));
-				usage(argv[0]);
+			if (strcmp(optarg, "-") == 0)
+				outfile = stdout;
+			else {
+				outfile = fopen(optarg, "w");
+				if (!outfile) {
+					fprintf(stderr,
+						"Error opening %s: %s\n",
+						optarg, strerror(errno));
+					usage(argv[0]);
+				}
+				__fsetlocking(outfile, FSETLOCKING_BYCALLER);
 			}
-			__fsetlocking(outfile, FSETLOCKING_BYCALLER);
 			break;
 		case 'v':
 			if (progress) {
@@ -421,6 +445,8 @@ int main(int argc, char **argv)
 		if (strcmp(file_name, "-") != 0)
 			fclose(f);
 	} else {
+		if (optind >= argc)
+			usage(argv[0]);
 		for (i = optind; i < argc; i++) {
 			process(argv[i]);
 		}
@@ -428,5 +454,8 @@ int main(int argc, char **argv)
 	if (outfile)
 		fclose(outfile);
 
+	if (!change)
+		return change_ctr;
+
 	return errors;
 }




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
