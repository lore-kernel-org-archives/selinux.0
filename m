Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l08LhOUo008467
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 16:43:24 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l08LiCc5016419
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 21:44:13 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l08LiCcG006946
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 16:44:12 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l08LiChk023392
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 16:44:12 -0500
Received: from [10.11.14.28] (vpn-14-28.rdu.redhat.com [10.11.14.28])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l08LiBP5002717
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 16:44:12 -0500
Subject: [PATCH] allow semodule -i to accept list of modules
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 16:43:47 -0500
Message-Id: <1168292627.14203.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch allows semodule to handle a list of modules for
installation (i.e., semodule -i *.pp now works).

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

diff -r e37f9d8d6611 policycoreutils/semodule/semodule.c
--- a/policycoreutils/semodule/semodule.c	Mon Jan 08 15:00:14 2007 -0500
+++ b/policycoreutils/semodule/semodule.c	Mon Jan 08 16:37:23 2007 -0500
@@ -225,15 +225,6 @@ static void parse_command_line(int argc,
 			}
 		}
 	}
-	if (optind < argc) {
-		fprintf(stderr, "Extraneous arguments:  ");
-		while (optind < argc)
-			fprintf(stderr, "%s", argv[optind++]);
-		fprintf(stderr, "\n");
-		usage(argv[0]);
-		cleanup();
-		exit(1);
-	}
 	if ((build || reload) && num_commands) {
 		fprintf(stderr,
 			"build or reload should not be used with other commands\n");
@@ -244,6 +235,24 @@ static void parse_command_line(int argc,
 		fprintf(stderr, "At least one mode must be specified.\n");
 		usage(argv[0]);
 		exit(1);
+	}
+
+	if (optind < argc) {
+		/* if -i was the last command treat any remaining
+		 * arguments as modules to allow 'semodule -i *.pp' to
+		 * work as expected.
+		 */
+		if (commands[num_commands - 1].mode == INSTALL_M) {
+			while (optind < argc)
+				set_mode(INSTALL_M, argv[optind++]);
+		} else {
+			fprintf(stderr, "unknown additional arguments:\n");
+			while (optind < argc)
+				fprintf(stderr, " %s", argv[optind++]);
+			fprintf(stderr, "\n\n");
+			usage(argv[0]);
+			exit(1);
+		}
 	}
 }
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
