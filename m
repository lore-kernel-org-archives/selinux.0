Message-ID: <46648BAC.8090702@redhat.com>
Date: Mon, 04 Jun 2007 18:01:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: setfiles -c is failing do to bad checking on options.
Content-Type: multipart/mixed;
 boundary="------------020603030704090905000000"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020603030704090905000000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------020603030704090905000000
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/setfiles/setfiles.c policycoreutils-2.0.19/setfiles/setfiles.c
--- nsapolicycoreutils/setfiles/setfiles.c	2007-05-18 09:58:33.000000000 -0400
+++ policycoreutils-2.0.19/setfiles/setfiles.c	2007-06-04 17:42:44.000000000 -0400
@@ -858,8 +858,6 @@
 		if (strcmp(input_filename, "-") != 0)
 			fclose(f);
 	} else {
-		if (optind >= argc)
-			usage(argv[0]);
 		for (i = optind; i < argc; i++) {
 			errors |= process_one(argv[i]);
 		}

--------------020603030704090905000000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
