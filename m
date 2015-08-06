Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t76EUWJK018630
 for <selinux@tycho.nsa.gov>; Thu, 6 Aug 2015 10:30:33 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH v2 2/3] libsemanage: Fix null pointer dereference in
 semanage_module_key_destroy
Date: Thu, 6 Aug 2015 10:30:13 -0400
Message-ID: <1438871414-62292-3-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1438871414-62292-1-git-send-email-ykhodorkovskiy@tresys.com>
References: <1438871414-62292-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If modkey is NULL, semanage_module_key_destroy() would still try to
initialize a modkey after freeing it.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 libsemanage/src/modules.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index 131f502..90c5e49 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -690,10 +690,12 @@ int semanage_module_key_destroy(semanage_handle_t *sh,
 {
 	assert(sh);
 
-	if (modkey) {
-		free(modkey->name);
+	if (!modkey) {
+		return 0;
 	}
 
+	free(modkey->name);
+
 	return semanage_module_key_init(sh, modkey);
 }
 
-- 
1.9.3
