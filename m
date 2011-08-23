Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7NA8eJs018446
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 06:08:47 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7NA8kAm022980
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 10:08:46 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v0 PATCH 4/6] Permanently enable the if or else branch of a tunable during link.
Date: Tue, 23 Aug 2011 18:08:30 +0800
Message-ID: <1314094112-6477-5-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For a cond_node_t in one decl->cond_list queue, append its
avtrue_list or avfalse_list to the avrules list of its home decl
depending on its state value, so that these effective rules would
be permanently added to te_avtab.

If tunables and booleans co-exist in one expression, then the tunables
would be "transformed" as boolean.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/link.c |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 421c47b..de78916 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -2451,6 +2451,92 @@ static int populate_roleattributes(link_state_t *state, policydb_t *pol)
 	return 0;
 }
 
+static void separate_tunables(link_state_t *state, policydb_t *pol)
+{
+	avrule_block_t *block;
+	avrule_decl_t *decl;
+	cond_node_t *cur_node;
+	cond_expr_t *cur_expr;
+	int cur_state;
+	avrule_t *tail, *to_be_appended;
+
+	if (state->verbose)
+		INFO(state->handle, "Separating tunables from booleans.");
+
+	/* Iterate through all cond_node of all enabled decls, if a cond_node
+	 * is about tunable, caculate its state value and concatenate one of
+	 * its avrule list to the current decl->avrules list.
+	 *
+	 * Note, such tunable cond_node would be skipped over in expansion,
+	 * so we won't have to worry about removing it from decl->cond_list
+	 * here :-)
+	 *
+	 * If tunables and booleans co-exist in the expression of a cond_node,
+	 * then tunables would be "transformed" as booleans.
+	 */
+	for (block = pol->global; block != NULL; block = block->next) {
+		decl = block->enabled;
+		if (decl == NULL || decl->enabled == 0)
+			continue;
+
+		tail = decl->avrules;
+		while (tail && tail->next)
+			tail = tail->next;
+
+		for (cur_node = decl->cond_list; cur_node != NULL;
+		     cur_node = cur_node->next) {
+			int booleans, tunables, i;
+			cond_bool_datum_t *booldatum;
+			cond_bool_datum_t *tmp[COND_EXPR_MAXDEPTH];
+
+			booleans = tunables = 0;
+			memset(tmp, 0, sizeof(cond_bool_datum_t *) * COND_EXPR_MAXDEPTH);
+
+			for (cur_expr = cur_node->expr; cur_expr != NULL;
+			     cur_expr = cur_expr->next) {
+				if (cur_expr->expr_type != COND_BOOL)
+					continue;
+				booldatum = pol->bool_val_to_struct[cur_expr->bool - 1];
+				if (booldatum->flags & COND_BOOL_FLAGS_TUNABLE)
+					tmp[tunables++] = booldatum;
+				else
+					booleans++;
+			}
+			
+			if (tunables && booleans) {
+				/* Tunable mixed with boolean */
+				for (i = 0; i < tunables; i++)
+					tmp[i]->flags &= ~COND_BOOL_FLAGS_TUNABLE;
+			} else if (tunables && !booleans) {
+				/* Pure tunable conditional */
+				cur_node->flags |= COND_NODE_FLAGS_TUNABLE;
+				cur_state = cond_evaluate_expr(pol, cur_node->expr);
+				if (cur_state == -1) {
+					printf("Expression result was "
+						"undefined, skipping all"
+						"rules\n");
+					continue;
+				}
+
+				to_be_appended = (cur_state == 1) ?
+					cur_node->avtrue_list : cur_node->avfalse_list;
+
+				if (tail)
+					tail->next = to_be_appended;
+				else
+					tail = decl->avrules = to_be_appended;
+
+				/* Update the tail of decl->avrules for
+				 * further concatenation */
+				while (tail && tail->next)
+					tail = tail->next;
+
+				cur_node->avtrue_list = cur_node->avfalse_list = NULL;
+			}
+		}
+	}
+}
+
 /* Link a set of modules into a base module. This process is somewhat
  * similar to an actual compiler: it requires a set of order dependent
  * steps.  The base and every module must have been indexed prior to
@@ -2587,6 +2673,11 @@ int link_modules(sepol_handle_t * handle,
 			&state))
 		goto cleanup;
 
+	/* Append tunable's avtrue_list or avfalse_list to the avrules list
+	 * of its home decl depending on its state value, so that the effect
+	 * rules of a tunable would be added to te_avtab permanently. */
+	separate_tunables(&state, state.base);
+
 	retval = 0;
       cleanup:
 	for (i = 0; modules != NULL && i < len; i++) {
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
