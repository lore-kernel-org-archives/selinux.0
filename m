Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v04Ll0wj016816
 for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2017 16:47:01 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 9F60C5647D0
 for <selinux@tycho.nsa.gov>; Wed,  4 Jan 2017 22:46:57 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libsemanage: genhomedircon: remove duplicated test
 condition
Date: Wed,  4 Jan 2017 22:46:22 +0100
Message-Id: <20170104214623.24674-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/genhomedircon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 7ceeafb7b5d9..fd6d391984b6 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -246,7 +246,7 @@ static int fcontext_matches(const semanage_fcontext_t *fcontext, void *varg)
 
 	/* Only match ALL or DIR */
 	type = semanage_fcontext_get_type(fcontext);
-	if (type != SEMANAGE_FCONTEXT_ALL && type != SEMANAGE_FCONTEXT_ALL)
+	if (type != SEMANAGE_FCONTEXT_ALL)
 		return 0;
 
 	len = strlen(oexpr);
-- 
2.11.0
