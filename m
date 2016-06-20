Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5KBon1r031840
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 07:50:49 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6E5C96332F
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 11:50:46 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] checkpolicy: Fix typos in test/dispol
Date: Mon, 20 Jun 2016 13:50:41 +0200
Message-Id: <1466423441-32172-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Reported-By: Milos Malik <mmalik@redhat.com>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 checkpolicy/test/dispol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 86f5688..a78ce81 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -252,11 +252,11 @@ int display_cond_expressions(policydb_t * p, FILE * fp)
 int display_handle_unknown(policydb_t * p, FILE * out_fp)
 {
 	if (p->handle_unknown == ALLOW_UNKNOWN)
-		fprintf(out_fp, "Allow unknown classes and permisions\n");
+		fprintf(out_fp, "Allow unknown classes and permissions\n");
 	else if (p->handle_unknown == DENY_UNKNOWN)
-		fprintf(out_fp, "Deny unknown classes and permisions\n");
+		fprintf(out_fp, "Deny unknown classes and permissions\n");
 	else if (p->handle_unknown == REJECT_UNKNOWN)
-		fprintf(out_fp, "Reject unknown classes and permisions\n");
+		fprintf(out_fp, "Reject unknown classes and permissions\n");
 	return 0;
 }
 
@@ -349,7 +349,7 @@ int menu(void)
 	printf("\nSelect a command:\n");
 	printf("1)  display unconditional AVTAB\n");
 	printf("2)  display conditional AVTAB (entirely)\n");
-	printf("3)  display conditional AVTAG (only ENABLED rules)\n");
+	printf("3)  display conditional AVTAB (only ENABLED rules)\n");
 	printf("4)  display conditional AVTAB (only DISABLED rules)\n");
 	printf("5)  display conditional bools\n");
 	printf("6)  display conditional expressions\n");
-- 
2.7.4
