Message-ID: <4267B69F.30301@redhat.com>
Date: Thu, 21 Apr 2005 10:20:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: I added back in matchpathcon to libselinux rpm.
Content-Type: multipart/mixed;
 boundary="------------070402090407030000080802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070402090407030000080802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Some people were coming up with some interesting ways of using chcon

chcon `matchpathcon -n /etc/passwd` /usr/local/mypasswd

So I added -n qualifier to not display path.  Also added man page.

Dan

-- 



--------------070402090407030000080802
Content-Type: text/plain;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

--- /dev/null	2005-04-20 05:34:52.522685192 -0400
+++ libselinux-1.23.7/man/man3/selinux_policy_root.3	2005-04-21 09:54:24.000000000 -0400
@@ -0,0 +1,17 @@
+.TH "selinux_policy_root" "3" "25 May 2004" "dwalsh@redhat.com" "SE Linux API documentation"
+.SH "NAME"
+selinux_policy_root \- return the path of the SELinux policy files for this machine.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.B char *selinux_policy_root();
+.br
+
+.SH "DESCRIPTION"
+.B selinux_policy_root
+Reads the contents of the /etc/selinux/config file to determine which policy files should be used for this machine.
+.SH "RETURN VALUE"
+On success, returns a directory path containing the SELinux policy files.
+On failure, NULL is returned.
+
+
--- libselinux-1.23.7/man/man8/matchpathcon.8.rhat	2005-04-21 10:05:45.000000000 -0400
+++ libselinux-1.23.7/man/man8/matchpathcon.8	2005-04-21 10:12:24.000000000 -0400
@@ -0,0 +1,20 @@
+.TH "matchpathcon" "8" "21 April 2005" "dwalsh@redhat.com" "SE Linux Command Line documentation"
+.SH "NAME"
+matchpathcon \- get the default security context for the specified path from the file contexts configuration.
+
+.SH "SYNOPSIS"
+.B matchpathcon [-n] filepath...
+
+.SH "DESCRIPTION"
+.B matchpathcon
+Prints the file path and the default security context associated with it.
+.br
+If the -n option is given, do not display path.
+
+.SH AUTHOR	
+This manual page was written by Dan Walsh <dwalsh@redhat.com>.
+.br
+The program was written by NSA
+
+.SH "SEE ALSO"
+.BR mathpathcon "(3), " 
--- libselinux-1.23.7/utils/matchpathcon.c.rhat	2005-04-13 11:34:19.000000000 -0400
+++ libselinux-1.23.7/utils/matchpathcon.c	2005-04-21 10:02:04.000000000 -0400
@@ -1,25 +1,43 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <getopt.h>
 #include <selinux/selinux.h>
 
+void usage(const char *progname) 
+{
+	fprintf(stderr, "usage:  %s [-n] path...\n", progname);
+	exit(1);
+}
+
 int main(int argc, char **argv) 
 {
 	char *buf;
 	int rc, i;
+	int header=1, opt;
 
-	if (argc < 2) {
-		fprintf(stderr, "usage:  %s path...\n", argv[0]);
-		return 1;
-	}
+	if (argc < 2) usage(argv[0]);
 
-	for (i = 1; i < argc; i++) {
+	while ((opt = getopt(argc, argv, "n")) > 0) {
+		switch (opt) {
+		case 'n':
+			header=0;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+	for (i = optind; i < argc; i++) {
 		rc = matchpathcon(argv[i], 0, &buf);
 		if (rc < 0) {
 			fprintf(stderr, "%s:  matchpathcon(%s) failed\n", argv[0], argv[i]);
 			return 2;
 		}
-		printf("%s\t%s\n", argv[i], buf);
+		if (header)
+			printf("%s\t%s\n", argv[i], buf);
+		else
+			printf("%s\n", buf);
+
 		freecon(buf);
 	}
 	return 0;

--------------070402090407030000080802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
