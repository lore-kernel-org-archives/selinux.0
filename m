Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA3G0RCe004092
	for <selinux@tycho.nsa.gov>; Sun, 3 Nov 2013 11:00:27 -0500
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Cc: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] libsepol: Fix valgrind errors in constraint_expr_eval_reason
Date: Sun,  3 Nov 2013 16:00:10 +0000
Message-Id: <1383494410-8220-1-git-send-email-richard_c_haines@btinternet.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Running valgrind flagged up three "definitely lost" malloc/realloc errors
when checking constraints.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libsepol/src/services.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 73faa05..6869173 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -723,6 +723,7 @@ mls_ops:
 			push(answer_list[answer_counter++]);
 			free(a);
 			free(b);
+			free(expr_list[x]);
 		} else if (strncmp(expr_list[x], "not", 3) == 0) {
 			b = pop();
 			b_len = strlen(b);
@@ -743,6 +744,7 @@ mls_ops:
 						expr_list[x], b);
 			push(answer_list[answer_counter++]);
 			free(b);
+			free(expr_list[x]);
 		} else {
 			push(expr_list[x]);
 		}
@@ -807,6 +809,8 @@ out:
 		for (x = 0; expr_list[x] != NULL; x++)
 			free(expr_list[x]);
 	}
+	free(answer_list);
+	free(expr_list);
 	return rc;
 }
 
-- 
1.8.3.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
