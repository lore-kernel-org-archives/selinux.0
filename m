Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7RB4ZLa009355
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 07:04:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7RB374F020752
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 11:03:07 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h7RB35FC020749
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 11:03:06 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 8A248C1B5
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 21:04:31 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13395-04 for <selinux@tycho.nsa.gov>;
 Wed, 27 Aug 2003 21:04:30 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 0CC04C1B4
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 21:04:30 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id C3902926F8
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 21:04:29 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 893D37F0E6
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2003 21:04:27 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: setfiles patch
Date: Wed, 27 Aug 2003 21:04:27 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7AJT/rc2STjAEKI"
Message-Id: <200308272104.27041.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_7AJT/rc2STjAEKI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch for the latest setfiles makes the usage information 
consistent and more accurate, it removes the unused "-p" and "-x" options, 
and it limits the number of messages about bad contexts to 10 when not in 
debug mode.

I added the limit to error messages because when I tried running setfiles on a 
machine without the policy loaded (something I anticipate to be a common 
error, and an error that may even be performed repeatedly by scripts) it took 
30 seconds to display the error messages on my test machine (and also logged 
lots of messages via syslog).

10 error messages is enough to indicate that there is a serious problem and to 
allow the administrator to get busy solving the problem.  More messages just 
wastes time and disk space without adding value IMHO.  The "-d" option causes 
all the messages to be displayed (but maybe "-v" is more appropriate for 
that).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_7AJT/rc2STjAEKI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="setfiles.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="setfiles.diff"

diff -ru setfiles.orig/setfiles.c setfiles/setfiles.c
--- setfiles.orig/setfiles.c	2003-07-15 06:00:06.000000000 +1000
+++ setfiles/setfiles.c	2003-08-27 20:26:38.000000000 +1000
@@ -511,6 +511,25 @@
 	return 0;
 }
 
+void usage(const char * const name)
+{
+	fprintf(stderr,
+		"usage:  %s [-dnqvW] spec_file pathname...\n"
+		"usage:  %s -s [-dnqvW] spec_file\n", name, name);
+	exit(1);
+}
+
+static int nerr = 0;
+
+void inc_err()
+{
+	nerr++;
+	if(nerr > 9 && !debug)
+	{
+		fprintf(stderr, "Exiting after 10 errors.\n");
+		exit(1);
+	}
+}
 
 int main(int argc, char **argv)
 {
@@ -518,10 +537,10 @@
 	char buf[255 + 1], *buf_p;
 	char *regex, *type, *context;
 	char *anchored_regex;
-	int opt, items, len, lineno, pass, nerr, regerr, i;
+	int opt, items, len, lineno, pass, regerr, i;
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "dnpqsvxW")) > 0) {
+	while ((opt = getopt(argc, argv, "dnqsvW")) > 0) {
 		switch (opt) {
 		case 'd':
 			debug = 1;
@@ -539,33 +558,22 @@
 		case 'v':
 			verbose = 1;
 			break;
-		case 'x':
-			/* now the default */
-			break;
 		case 'W':
 			warn_no_match = 1;
 			break;
 		case '?':
-			fprintf(stderr,
-				"usage:  %s [-dnpqsvW] spec_file pathname...\n", argv[0]);
-			exit(1);
+			usage(argv[0]);
 		}
 	}
 
 	if (use_stdin) {
 		if (optind != (argc - 1)) {
 			/* Cannot mix with pathname arguments. */
-			fprintf(stderr,
-				"usage:  %s -s [-dnqvW] spec_file\n", argv[0]);
-			exit(1);
+			usage(argv[0]);
 		}
 	} else {
-		if (optind > (argc - 2)) {
-			fprintf(stderr,
-				"usage:  %s [-dnpqvW] spec_file pathname...\n",
-				argv[0]);
-			exit(1);
-		}
+		if (optind > (argc - 2))
+			usage(argv[0]);
 	}
 
 	/* Open the specification file. */
@@ -586,7 +594,6 @@
 	for (pass = 0; pass < 2; pass++) {
 		lineno = 0;
 		nspec = 0;
-		nerr = 0;
 		while (fgets(buf, sizeof buf, fp)) {
 			lineno++;
 			len = strlen(buf);
@@ -594,7 +601,7 @@
 				fprintf(stderr,
 					"%s:  no newline on line number %d (only read %s)\n",
 					argv[0], lineno, buf);
-				nerr++;
+				inc_err();
 				continue;
 			}
 			buf[len - 1] = 0;
@@ -611,7 +618,7 @@
 				fprintf(stderr,
 					"%s:  line number %d is missing fields (only read %s)\n",
 					argv[0], lineno, buf);
-				nerr++;
+				inc_err();
 				if (items == 1)
 					free(regex);
 				continue;
@@ -650,7 +657,7 @@
 						"%s:  unable to compile regular expression %s on line number %d:  %s\n",
 						argv[0], regex, lineno,
 						errbuf);
-					nerr++;
+					inc_err();
 				}
 				free(anchored_regex);
 
@@ -664,7 +671,7 @@
 					fprintf(stderr,
 						"%s:  invalid type specifier %s on line number %d\n",
 						argv[0], type, lineno);
-					nerr++;
+					inc_err();
 					goto skip_type;
 				}
 				switch (type[1]) {
@@ -693,7 +700,7 @@
 					fprintf(stderr,
 						"%s:  invalid type specifier %s on line number %d\n",
 						argv[0], type, lineno);
-					nerr++;
+					inc_err();
 				}
 
 			      skip_type:
@@ -706,7 +713,7 @@
 							"%s:  invalid context %s on line number %d\n",
 							argv[0], context,
 							lineno);
-						nerr++;
+						inc_err();
 					}
 				}
 

--Boundary-00=_7AJT/rc2STjAEKI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
