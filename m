Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v83CKZBw026038
 for <selinux@tycho.nsa.gov>; Sun, 3 Sep 2017 08:20:35 -0400
Received: from localhost.localdomain (abo-140-56-69.avi.modulonet.fr
 [85.69.56.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 910AD5646CA
 for <selinux@tycho.nsa.gov>; Sun,  3 Sep 2017 14:20:00 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  3 Sep 2017 14:19:24 +0200
Message-Id: <20170903121928.24024-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170903121928.24024-1-nicolas.iooss@m4x.org>
References: <20170903121928.24024-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 2/6] libsepol/cil:
 __cil_post_db_neverallow_attr_helper() does not use extra_args
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since commit 67b410e80f09 ("libsepol/cil: Keep attributes used by
generated attributes in neverallow rules") gcc reports the following
warning when building libsepol:

    ../cil/src/cil_post.c: In function
    ‘__cil_post_db_neverallow_attr_helper’:
    ../cil/src/cil_post.c:1322:17: error: unused variable ‘db’
    [-Werror=unused-variable]
      struct cil_db *db = extra_args;
                     ^~

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_post.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index ee693d47ca5f..3e013c97e219 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1317,10 +1317,8 @@ static void __mark_neverallow_attrs(struct cil_list *expr_list)
 	}
 }
 
-static int __cil_post_db_neverallow_attr_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args)
+static int __cil_post_db_neverallow_attr_helper(struct cil_tree_node *node, uint32_t *finished, __attribute__((unused)) void *extra_args)
 {
-	struct cil_db *db = extra_args;
-
 	switch (node->flavor) {
 	case CIL_BLOCK: {
 		struct cil_block *blk = node->data;
-- 
2.14.1
