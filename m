Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3BLkUKj001912
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 17:46:31 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5DA1A5647D8
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 23:46:29 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/6] libselinux: avoid calling strcmp() on a NULL pointer
Date: Tue, 11 Apr 2017 23:46:00 +0200
Message-Id: <20170411214603.28040-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170411214603.28040-1-nicolas.iooss@m4x.org>
References: <20170411214603.28040-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When curcon is NULL, calling strcmp(curcon, newcon) produces an undefined
behavior. Avoid this by checking whether curcon is NULL beforehand.

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/selinux_restorecon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index eefd2cf83e32..a41fc48a82d8 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -664,7 +664,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		curcon = NULL;
 	}
 
-	if (strcmp(curcon, newcon) != 0) {
+	if (curcon == NULL || strcmp(curcon, newcon) != 0) {
 		if (!flags->set_specctx && curcon &&
 				    (is_context_customizable(curcon) > 0)) {
 			if (flags->verbose) {
-- 
2.12.0
