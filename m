Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u88KVIH0001789
 for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2016 16:31:19 -0400
Received: by mail-pa0-f50.google.com with SMTP id cm16so20661382pac.0
 for <selinux@tycho.nsa.gov>; Thu, 08 Sep 2016 13:31:18 -0700 (PDT)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jwcart2@tycho.nsa.gov, jeffv@google.com,
 dcashman <dcashman@android.com>
Subject: [PATCH 2/5] libsepol: cil: Remove duplicate sid policy declaration.
Date: Thu,  8 Sep 2016 13:30:49 -0700
Message-Id: <1473366652-23929-3-git-send-email-dcashman@android.com>
In-Reply-To: <1473366652-23929-2-git-send-email-dcashman@android.com>
References: <1473366652-23929-1-git-send-email-dcashman@android.com>
 <1473366652-23929-2-git-send-email-dcashman@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: dcashman <dcashman@android.com>

cil_gen_policy() creates two sets of sid declarations from CIL policy
due to the combination of sidorder iteration and the CIL_SID case in the
AST walk.  Remove the sidorder iteration.

Signed-off-by: Daniel Cashman <dcashman@android.com>
---
 libsepol/cil/src/cil_policy.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 324becc..d8ef151 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1272,10 +1272,6 @@ int cil_gen_policy(struct cil_db *db)
 
 	policy_file = fopen("policy.conf", "w+");
 
-	cil_list_for_each(item, db->sidorder) {
-		fprintf(file_arr[ISIDS], "sid %s ", ((struct cil_sid*)item->data)->datum.name);
-	}
-
 	cil_list_for_each(item, db->classorder) {
 		struct cil_class *class = item->data;
 		struct cil_tree_node *node = class->datum.nodes->head->data;
-- 
2.8.0.rc3.226.g39d4020
