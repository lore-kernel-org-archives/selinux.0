Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1MFCalT024288
 for <selinux@tycho.nsa.gov>; Sun, 22 Feb 2015 10:12:36 -0500
Received: by mail-qg0-f52.google.com with SMTP id h3so20947667qgf.11
 for <selinux@tycho.nsa.gov>; Sun, 22 Feb 2015 07:12:15 -0800 (PST)
Sender: "Christopher J. PeBenito" <pebenito@ieee.org>
From: Chris PeBenito <cpebenito@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] Fix error path in mls_semantic_level_expand().
Date: Sun, 22 Feb 2015 10:12:23 -0500
Message-Id: <1424617943-12541-1-git-send-email-cpebenito@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If the level contains a category that is not associated with a sensitivity,
the code correctly detects the condition, but does not return an error.

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
---
 libsepol/src/expand.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 467f7a7..3193ef5 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -914,10 +914,11 @@ int mls_semantic_level_expand(mls_semantic_level_t * sl, mls_level_t * l,
 		}
 		for (i = cat->low - 1; i < cat->high; i++) {
 			if (!ebitmap_get_bit(&levdatum->level->cat, i)) {
-				ERR(h, "Category %s can not be associate with "
+				ERR(h, "Category %s can not be associated with "
 				    "level %s",
 				    p->p_cat_val_to_name[i],
 				    p->p_sens_val_to_name[l->sens - 1]);
+				return -1;
 			}
 			if (ebitmap_set_bit(&l->cat, i, 1)) {
 				ERR(h, "Out of memory!");
-- 
2.3.0
