Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1K8v56g001735
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2011 03:57:05 -0500
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1K8udZ2026836
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2011 08:56:49 GMT
Received: from [192.168.2.2] (151.64.23.4) by cp-out9.libero.it (8.5.133) (authenticated as g.trentalancia@libero.it)
        id 4D35A95304BF79AC for selinux@tycho.nsa.gov; Sun, 20 Feb 2011 09:56:49 +0100
Subject: [PATCH 1/2]: clean-up setfiles source code and document two options
From: Guido Trentalancia <guido@trentalancia.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 20 Feb 2011 09:56:48 +0100
Message-ID: <1298192208.2989.31.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Minor improvements and clean-ups to the setfiles source code
(policycoreutils):

- removed unused code for undocumented and no-op "-i" option;
- document syntax of "-f" option;
- document syntax of "-p" option in secondary usage case (i.e. with
"-s");
- substitute variable name with parameter name in usage printout for
"-r" option;
- remove a few misplaced spaces from the usage printout for better
formatting.

--- policycoreutils/setfiles/setfiles.c	2011-02-20 06:59:40.716066179 +0100
+++ policycoreutils-new/setfiles/setfiles.c	2011-02-20 09:17:49.504994923 +0100
@@ -25,7 +25,6 @@ static char *policyfile = NULL;
 static int warn_no_match = 0;
 static int null_terminated = 0;
 static int errors;
-static int ignore_enoent;
 static struct restore_opts r_opts;
 
 #define STAT_BLOCK_SIZE 1
@@ -44,14 +43,15 @@ void usage(const char *const name)
 {
 	if (iamrestorecon) {
 		fprintf(stderr,
-			"usage:  %s [-iFnrRv0] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
+			"usage:  %s [-iFnrRv0] [-e excludedir] [-o filename] [-f filename | pathname...]\n",
 			name);
 	} else {
 		fprintf(stderr,
-			"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path ] spec_file pathname...\n"
+			"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path] spec_file pathname...\n"
 			"usage:  %s -c policyfile spec_file\n"
-			"usage:  %s -s [-dnqvW] [-o filename ] spec_file\n", name, name,
-			name);
+			"usage:  %s -f filename [-dnpqvW] [-o filename] spec_file\n"
+			"usage:  %s -s [-dnpqvW] [-o filename] spec_file\n", name, name,
+			name, name);
 	}
 	exit(1);
 }
@@ -283,7 +283,7 @@ int main(int argc, char **argv)
 	exclude_non_seclabel_mounts();
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW0")) > 0) {
+	while ((opt = getopt(argc, argv, "c:de:f:lnpqrsvo:FRW0")) > 0) {
 		switch (opt) {
 		case 'c':
 			{
@@ -334,9 +334,6 @@ int main(int argc, char **argv)
 		case 'd':
 			r_opts.debug = 1;
 			break;
-		case 'i':
-			ignore_enoent = 1;
-			break;
 		case 'l':
 			r_opts.logging = 1;
 			break;
@@ -371,7 +368,7 @@ int main(int argc, char **argv)
 				break;
 			}
 			if (optind + 1 >= argc) {
-				fprintf(stderr, "usage:  %s -r r_opts.rootpath\n",
+				fprintf(stderr, "usage:  %s -r rootpath\n",
 					argv[0]);
 				exit(1);
 			}



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
