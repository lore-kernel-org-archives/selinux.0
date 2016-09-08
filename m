Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u88KVIGw001789
 for <selinux@tycho.nsa.gov>; Thu, 8 Sep 2016 16:31:19 -0400
Received: by mail-pa0-f50.google.com with SMTP id id6so20579666pad.3
 for <selinux@tycho.nsa.gov>; Thu, 08 Sep 2016 13:31:17 -0700 (PDT)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jwcart2@tycho.nsa.gov, jeffv@google.com,
 dcashman <dcashman@android.com>
Subject: [PATCH 1/5] libsepol: cil: Add userrole mapping to cil_gen_policy().
Date: Thu,  8 Sep 2016 13:30:48 -0700
Message-Id: <1473366652-23929-2-git-send-email-dcashman@android.com>
In-Reply-To: <1473366652-23929-1-git-send-email-dcashman@android.com>
References: <1473366652-23929-1-git-send-email-dcashman@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: dcashman <dcashman@android.com>

Avoid a "No roles associated with user" error produced by
cil_userrole_to_policy() when a userrole mapping is present in CIL policy.

Signed-off-by: Daniel Cashman <dcashman@android.com>
---
 libsepol/cil/src/cil_policy.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 382129b..324becc 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1155,7 +1155,12 @@ int __cil_gen_policy_node_helper(struct cil_tree_node *node, uint32_t *finished,
 	} else {
 		switch (node->flavor) {
 		case CIL_USER:
-			cil_multimap_insert(users, node->data, NULL, CIL_USERROLE, CIL_NONE);
+			cil_multimap_insert(users, node->data, NULL, CIL_USER, CIL_NONE);
+			break;
+		case CIL_USERROLE: {
+			struct cil_userrole *userrole = node->data;
+			cil_multimap_insert(users, userrole->user, userrole->role, CIL_USER, CIL_ROLE);
+		}
 			break;
 		case CIL_CATALIAS: {
 			struct cil_alias *alias = node->data;
-- 
2.8.0.rc3.226.g39d4020
