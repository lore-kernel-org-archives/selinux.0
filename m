Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0LEQOoi012692
 for <selinux@tycho.nsa.gov>; Sat, 21 Jan 2017 09:26:26 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 2B4845647DE
 for <selinux@tycho.nsa.gov>; Sat, 21 Jan 2017 15:26:21 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/4] checkpolicy: always free id in define_type()
Date: Sat, 21 Jan 2017 15:26:10 +0100
Message-Id: <20170121142613.12375-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In function define_type(), some error conditions between "id =
queue_remove(id_queue)" and "get_local_type(id, attr->s.value, 1)"
returned without freeing id. Fix theses memory leaks.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/policy_define.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 6bfadbe59c91..03a0c18a9686 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1426,11 +1426,13 @@ int define_type(int alias)
 		if (!attr) {
 			/* treat it as a fatal error */
 			yyerror2("attribute %s is not declared", id);
+			free(id);
 			return -1;
 		}
 
 		if (attr->flavor != TYPE_ATTRIB) {
 			yyerror2("%s is a type, not an attribute", id);
+			free(id);
 			return -1;
 		}
 
-- 
2.11.0
