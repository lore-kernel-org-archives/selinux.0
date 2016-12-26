Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBQLIkwt018050
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 16:18:46 -0500
Received: from localhost.localdomain (private.iosenag.net [31.7.184.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E8DAA56469F
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 22:18:43 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/5] checkpolicy: fix memory usage in define_bool_tunable()
Date: Mon, 26 Dec 2016 22:18:28 +0100
Message-Id: <20161226211832.7165-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In an error path of define_bool_tunable(), variable id is freed after
being used by a successful call to declare_symbol(). This may cause
trouble as this pointer may have been used as-is in the policy symtab
hash table.

Moreover bool_value is never freed after being used. Fix this memory
leak too. This leak has been detected with gcc Address Sanitizer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/policy_define.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 864788992e5c..2ad98c3c851e 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1704,11 +1704,11 @@ int define_bool_tunable(int is_tunable)
 	bool_value = (char *)queue_remove(id_queue);
 	if (!bool_value) {
 		yyerror("no default value for bool definition?");
-		free(id);
 		return -1;
 	}
 
 	datum->state = (int)(bool_value[0] == 'T') ? 1 : 0;
+	free(bool_value);
 	return 0;
       cleanup:
 	cond_destroy_bool(id, datum, NULL);
-- 
2.11.0
