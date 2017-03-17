Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2HMAUic005280
 for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2017 18:10:30 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 0B3E65607A0
 for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2017 23:10:27 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] checkpolicy: dereference rangehead after checking it was
 not NULL
Date: Fri, 17 Mar 2017 23:10:03 +0100
Message-Id: <20170317221003.18666-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/policy_define.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index dbafadb01e21..949ca7117233 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1924,11 +1924,11 @@ int avrule_ioctl_ranges(struct av_ioctl_range_list **rangelist)
 	/* read in ranges to include and omit */
 	if (avrule_read_ioctls(&rangehead))
 		return -1;
-	omit = rangehead->omit;
 	if (rangehead == NULL) {
 		yyerror("error processing ioctl commands");
 		return -1;
 	}
+	omit = rangehead->omit;
 	/* sort and merge the input ioctls */
 	if (avrule_sort_ioctls(&rangehead))
 		return -1;
-- 
2.12.0
