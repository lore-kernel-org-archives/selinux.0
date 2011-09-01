Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p813U5Z6032062
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 23:30:15 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p813U406012582
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 03:30:04 GMT
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p813U4nR007338
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 20:30:04 -0700 (PDT)
From: Harry Ciao <qingtao.cao@windriver.com>
To: <selinux@tycho.nsa.gov>
Subject: [v2 PATCH 8/8] Preserve tunables when required by semodule program.
Date: Thu, 1 Sep 2011 11:29:47 +0800
Message-ID: <1314847787-4055-9-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
References: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If the "-P/--preserve_tunables" option is set for the semodule program,
the preserve_tunables flag in sepol_handle_t would be set, then all tunables
would be treated as booleans by having their TUNABLE flag bit cleared,
resulting in all tunables if-else conditionals preserved for raw policy.

Note, such option would invalidate the logic to double-check if tunables
ever mix with booleans in one expression, so skip the call to assert()
when this option is passed.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/expand.c |   36 ++++++++++++++++++++++++------------
 1 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index d5f10a6..d67b84c 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2678,25 +2678,29 @@ int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
 	return copy_and_expand_avrule_block(&state);
 }
 
-static void discard_tunables(policydb_t *pol)
+static void discard_tunables(sepol_handle_t *sh, policydb_t *pol)
 {
 	avrule_block_t *block;
 	avrule_decl_t *decl;
 	cond_node_t *cur_node;
 	cond_expr_t *cur_expr;
-	int cur_state;
+	int cur_state, preserve_tunables = 0;
 	avrule_t *tail, *to_be_appended;
 
+	if (sh && sh->preserve_tunables)
+		preserve_tunables = 1;
+
 	/* Iterate through all cond_node of all enabled decls, if a cond_node
-	 * is about tunable, caculate its state value and concatenate one of
-	 * its avrule list to the current decl->avrules list.
+	 * is about tunable, calculate its state value and concatenate one of
+	 * its avrule list to the current decl->avrules list. On the other
+	 * hand, the disabled unused branch of a tunable would be discarded.
 	 *
 	 * Note, such tunable cond_node would be skipped over in expansion,
 	 * so we won't have to worry about removing it from decl->cond_list
 	 * here :-)
 	 *
-	 * If tunables and booleans co-exist in the expression of a cond_node,
-	 * then tunables would be "transformed" as booleans.
+	 * If tunables are requested to be preserved then they would be
+	 * "transformed" as booleans by having their TUNABLE flag cleared.
 	 */
 	for (block = pol->global; block != NULL; block = block->next) {
 		decl = block->enabled;
@@ -2709,10 +2713,12 @@ static void discard_tunables(policydb_t *pol)
 
 		for (cur_node = decl->cond_list; cur_node != NULL;
 		     cur_node = cur_node->next) {
-			int booleans, tunables;
+			int booleans, tunables, i;
 			cond_bool_datum_t *booldatum;
+			cond_bool_datum_t *tmp[COND_EXPR_MAXDEPTH];
 
 			booleans = tunables = 0;
+			memset(tmp, 0, sizeof(cond_bool_datum_t *) * COND_EXPR_MAXDEPTH);
 
 			for (cur_expr = cur_node->expr; cur_expr != NULL;
 			     cur_expr = cur_expr->next) {
@@ -2720,18 +2726,24 @@ static void discard_tunables(policydb_t *pol)
 					continue;
 				booldatum = pol->bool_val_to_struct[cur_expr->bool - 1];
 				if (booldatum->flags & COND_BOOL_FLAGS_TUNABLE)
-					tunables++;
+					tmp[tunables++] = booldatum;
 				else
 					booleans++;
 			}
 
 			/* bool_copy_callback() at link phase has ensured
 			 * that no mixture of tunables and booleans in one
-			 * expression. */
-			assert(!(booleans && tunables));
+			 * expression. However, this would be broken by the
+			 * request to preserve tunables */
+			if (!preserve_tunables)
+				assert(!(booleans && tunables));
 
-			if (booleans) {
+			if (booleans || preserve_tunables) {
 				cur_node->flags &= ~COND_NODE_FLAGS_TUNABLE;
+				if (tunables) {
+					for (i = 0; i < tunables; i++)
+						tmp[i]->flags &= ~COND_BOOL_FLAGS_TUNABLE;
+				}
 			} else {
 				cur_node->flags |= COND_NODE_FLAGS_TUNABLE;
 				cur_state = cond_evaluate_expr(pol, cur_node->expr);
@@ -2787,7 +2799,7 @@ int expand_module(sepol_handle_t * handle,
 	 * Originally this function is called at the very end of link phase,
 	 * however, we need to keep the linked policy intact for analysis
 	 * purpose. */
-	discard_tunables(base);
+	discard_tunables(handle, base);
 
 	expand_state_init(&state);
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
