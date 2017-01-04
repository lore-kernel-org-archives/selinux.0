Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v04Ll0wk016816
 for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2017 16:47:01 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 3F7C35647D0
 for <selinux@tycho.nsa.gov>; Wed,  4 Jan 2017 22:46:59 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] libsemanage: increment the right index variable in for
 loop
Date: Wed,  4 Jan 2017 22:46:23 +0100
Message-Id: <20170104214623.24674-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170104214623.24674-1-nicolas.iooss@m4x.org>
References: <20170104214623.24674-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/semanage_store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 58a58ef9452e..f468faba4b64 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1158,7 +1158,7 @@ cleanup:
 	free(all_modinfos);
 
 	if (status != 0) {
-		for (i = 0; i < j; j++) {
+		for (i = 0; i < j; i++) {
 			semanage_module_info_destroy(sh, &(*modinfo)[i]);
 		}
 		free(*modinfo);
-- 
2.11.0
