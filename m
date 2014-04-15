Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3FGRsRU016508
 for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2014 12:27:54 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: Skip duplicate filename_trans rules in state->out
 policy.
Date: Tue, 15 Apr 2014 17:27:32 +0100
Message-Id: <1397579252-1378-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The current detection of duplicate rules does not cover the state->out
policy and therefore will duplicate filename transition rules if already
present.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libsepol/src/expand.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index acb6906..e908fdb 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1534,6 +1534,20 @@ static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *r
 				if (cur_trans)
 					continue;
 
+				/* Now check if duplicate rule in state->out policy */
+				cur_trans = state->out->filename_trans;
+
+				while (cur_trans) {
+					if (cur_trans->stype == (i + 1) &&
+					    cur_trans->ttype == (j + 1) &&
+					    cur_trans->tclass == cur_rule->tclass &&
+					    !strcmp(cur_trans->name, cur_rule->name))
+						break;
+					cur_trans = cur_trans->next;
+				}
+				if (cur_trans)
+					continue;
+
 				new_trans = malloc(sizeof(*new_trans));
 				if (!new_trans) {
 					ERR(state->handle, "Out of memory!");
-- 
1.9.0
