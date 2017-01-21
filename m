Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0LEQOoj012692
 for <selinux@tycho.nsa.gov>; Sat, 21 Jan 2017 09:26:29 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 501775647DE
 for <selinux@tycho.nsa.gov>; Sat, 21 Jan 2017 15:26:23 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/4] checkpolicy: add a missing free(id) in
 define_roleattribute()
Date: Sat, 21 Jan 2017 15:26:12 +0100
Message-Id: <20170121142613.12375-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170121142613.12375-1-nicolas.iooss@m4x.org>
References: <20170121142613.12375-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/policy_define.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index eab940878ad1..e2e384d4599b 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2733,6 +2733,7 @@ int define_roleattribute(void)
 		free(id);
 		return -1;
 	}
+	free(id);
 
 	while ((id = queue_remove(id_queue))) {
 		if (!is_id_in_scope(SYM_ROLES, id)) {
-- 
2.11.0
