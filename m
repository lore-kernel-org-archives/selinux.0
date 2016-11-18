From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] checkpolicy: treat -self as an error
Date: Fri, 18 Nov 2016 11:13:02 -0500
Message-Id: <1479485582-7028-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

checkpolicy wrongly handles "-self". At the least, it should handle it as
an error. At best, it should support it correctly (which would involve
libsepol support as well). At present, it looks like it will end up
negating (-) the next type/attribute in the list after self, or if
there are no entries after self, ignoring it entirely.

This originally was raised by the Android team, which wanted to support
something like the following:
neverallow domain { domain -self }:dir search;
to prohibit cross domain access to some resource but allow access within
the same domain.

This change just makes it a fatal error during compilation.
Implementing real support for -self is left as future work.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 checkpolicy/policy_define.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 128869c..8b56a29 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1978,6 +1978,11 @@ int define_te_avtab_xperms_helper(int which, avrule_t ** rule)
 	while ((id = queue_remove(id_queue))) {
 		if (strcmp(id, "self") == 0) {
 			free(id);
+			if (add == 0) {
+				yyerror("-self is not supported");
+				ret = -1;
+				goto out;
+			}
 			avrule->flags |= RULE_SELF;
 			continue;
 		}
@@ -2437,6 +2442,11 @@ int define_te_avtab_helper(int which, avrule_t ** rule)
 	while ((id = queue_remove(id_queue))) {
 		if (strcmp(id, "self") == 0) {
 			free(id);
+			if (add == 0) {
+				yyerror("-self is not supported");
+				ret = -1;
+				goto out;
+			}
 			avrule->flags |= RULE_SELF;
 			continue;
 		}
-- 
2.7.4
