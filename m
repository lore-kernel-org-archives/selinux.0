Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8AJ1aSD029375
 for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2015 15:01:36 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol/cil: Fix uninitialized false positive in cil_binary
Date: Thu, 10 Sep 2015 15:01:15 -0400
Message-ID: <1441911675-50003-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On older versions of gcc, an error is incorrectly given about
uninitialized variables. This will initialize the culprits.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 libsepol/cil/src/cil_binary.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 52ce067..b359232 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1497,7 +1497,7 @@ int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void
 	ebitmap_t *xperms;
 	ebitmap_node_t *node;
 	unsigned int i;
-	uint16_t low, high;
+	uint16_t low = 0, high = 0;
 	struct avtab_extended_perms *partial = NULL;
 	struct avtab_extended_perms *complete = NULL;
 	int start_new_range;
-- 
1.9.3
