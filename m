Message-ID: <41741B2A.3060505@redhat.com>
Date: Mon, 18 Oct 2004 15:36:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Adding alternate root patch to restorecon (setfiles?)
Content-Type: multipart/mixed;
 boundary="------------080808030104060906050803"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080808030104060906050803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Forgot patch.

Dan

--------------080808030104060906050803
Content-Type: text/plain;
 name="policycoreutils-altroot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-altroot.patch"

--- policycoreutils-1.17.6/restorecon/restorecon.c.altroot	2004-10-06 09:47:47.000000000 -0400
+++ policycoreutils-1.17.6/restorecon/restorecon.c	2004-10-18 15:35:41.124661316 -0400
@@ -8,11 +8,13 @@
  * to match the specification returned by matchpathcon.
  *
  * USAGE:
- * restorecon [-Rnv] pathname...
+ * restorecon [-Rnv] [ -o outputfile ] [ -p alt_root ] pathname...
  * 
+ * -R	recurse
  * -n	Do not change any file labels.
  * -v	Show changes in file labels.  
- * -o filename save list of files with incorrect context
+ * -o	filename save list of files with incorrect context
+ * -p	alternate root: strip off alt_root from pathname when doing matchfilecon
  *
  * pathname...	The file(s) to label 
  *
@@ -40,6 +42,8 @@
 static int verbose=0;
 static FILE *outfile=NULL;
 static char *progname;
+static char *alt_root=NULL;
+static int alt_len=0;
 static int errors=0;
 static int recurse;
 
@@ -52,6 +56,7 @@
 int restore(char *filename) {
   int retcontext=0;
   int retval=0;
+  char *target=NULL;
   security_context_t scontext;
   security_context_t prev_context;
   int len=strlen(filename);
@@ -99,9 +104,14 @@
     }
     filename = p;
   }
-  retval = matchpathcon(filename, st.st_mode, &scontext);
+
+  target=filename;
+  if (alt_len != 0 && strncmp(alt_root, filename, alt_len) == 0)
+	  target=&filename[alt_len];
+
+  retval = matchpathcon(target, st.st_mode, &scontext);
   if (retval < 0) {
-    fprintf(stderr,"matchpathcon(%s) failed %s\n", filename,strerror(errno));
+    fprintf(stderr,"matchpathcon(%s) failed %s\n", target,strerror(errno));
     return 1;
   } 
   if (strcmp(scontext,"<<none>>")==0) {
@@ -179,7 +189,7 @@
 
   memset(buf,0, sizeof(buf));
 
-  while ((opt = getopt(argc, argv, "Rnvf:o:")) > 0) {
+  while ((opt = getopt(argc, argv, "Rnvf:o:p:")) > 0) {
     switch (opt) {
     case 'n':
       change = 0;
@@ -187,6 +197,12 @@
     case 'R':
       recurse = 1;
       break;
+    case 'p':
+      alt_root=strdup(optarg);
+      alt_len=strlen(optarg);
+      if (alt_root[alt_len-1]=='/') 
+	      alt_len--;
+      break;
     case 'o':
       outfile = fopen(optarg,"w");
       if (!outfile) {

--------------080808030104060906050803--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
