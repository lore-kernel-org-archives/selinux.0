Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p85EdHJJ010946
	for <selinux@tycho.nsa.gov>; Mon, 5 Sep 2011 10:39:17 -0400
Received: from nm1-vm0.bt.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p85EdGcV014318
	for <selinux@tycho.nsa.gov>; Mon, 5 Sep 2011 14:39:16 GMT
Message-ID: <1315233555.55198.YahooMailClassic@web87015.mail.ird.yahoo.com>
Date: Mon, 5 Sep 2011 15:39:15 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] CIL compiler - Generate initial SIDs correctly in binary policy.
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When running the CIL compiler, only the first initial SID was added to each entry of the binary file. This patch adds a counter to increment the SID count when writing out the file. This patch may not be the best way to achieve this, so I recommend that the CIL team review.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/cil_binary.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/cil_binary.c b/src/cil_binary.c
index ffe4f56..061a706 100644
--- a/src/cil_binary.c
+++ b/src/cil_binary.c
@@ -42,6 +42,8 @@
 #include "cil_mem.h"
 #include "cil_tree.h"
 
+static int sid_counter = 1;
+
 struct cil_args_binary {
 	const struct cil_db *db;
 	policydb_t *pdb;
@@ -1930,7 +1932,7 @@ int cil_sid_to_policydb(policydb_t *pdb, struct cil_tree_node *node)
 	new_sepol_sidcon->next = pdb->ocontexts[OCON_ISID];
 	pdb->ocontexts[OCON_ISID] = new_sepol_sidcon;
 
-	new_sepol_sidcon->sid[0] = pdb->ocontexts[OCON_ISID]->sid[0] + 1;
+	new_sepol_sidcon->sid[0] = pdb->ocontexts[OCON_ISID]->sid[0] + sid_counter++;
 	new_sepol_sidcon->u.name = cil_strdup(cil_sid->datum.name);
 
 	sepol_context = &new_sepol_sidcon->context[0];
-- 
1.7.6.1



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
