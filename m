Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2ECYVdS003975
 for <selinux@tycho.nsa.gov>; Wed, 14 Mar 2018 08:34:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2028401DE92
 for <selinux@tycho.nsa.gov>; Wed, 14 Mar 2018 12:34:26 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64FD0AFD46
 for <selinux@tycho.nsa.gov>; Wed, 14 Mar 2018 12:34:26 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 14 Mar 2018 13:34:22 +0100
Message-Id: <20180314123422.15298-1-vmojzis@redhat.com>
Subject: [PATCH] policycoreutils/semodule: Allow enabling/disabling
 multiple modules at once
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Vit Mojzis <vmojzis@localhost.localdomain>

Unify behaviour for all module actions.
The same behavoiour is already present for -i/-u/-r/-e switches.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1545218

Signed-off-by: Vit Mojzis <vmojzis@localhost.localdomain>
---
 policycoreutils/semodule/semodule.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 504247d3..c6953cb1 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -311,28 +311,29 @@ static void parse_command_line(int argc, char **argv)
 	}
 
 	if (optind < argc) {
-		int mode;
+		int mode = commands ? commands[num_commands - 1].mode : -1;
 		/* if -i/u/r/E was the last command treat any remaining
 		 * arguments as args. Will allow 'semodule -i *.pp' to
 		 * work as expected.
 		 */
 
-		if (commands && commands[num_commands - 1].mode == INSTALL_M) {
-			mode = INSTALL_M;
-		} else if (commands && commands[num_commands - 1].mode == REMOVE_M) {
-			mode = REMOVE_M;
-		} else if (commands && commands[num_commands - 1].mode == EXTRACT_M) {
-			mode = EXTRACT_M;
-		} else {
-			fprintf(stderr, "unknown additional arguments:\n");
-			while (optind < argc)
-				fprintf(stderr, " %s", argv[optind++]);
-			fprintf(stderr, "\n\n");
-			usage(argv[0]);
-			exit(1);
+		switch (mode) {
+			case INSTALL_M:
+			case REMOVE_M:
+			case EXTRACT_M:
+			case ENABLE_M:
+			case DISABLE_M:
+				while (optind < argc)
+					set_mode(mode, argv[optind++]);
+				break;
+			default:
+				fprintf(stderr, "unknown additional arguments:\n");
+				while (optind < argc)
+					fprintf(stderr, " %s", argv[optind++]);
+				fprintf(stderr, "\n\n");
+				usage(argv[0]);
+				exit(1);
 		}
-		while (optind < argc)
-			set_mode(mode, argv[optind++]);
 	}
 }
 
-- 
2.14.3
