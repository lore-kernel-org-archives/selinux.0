Subject: [RFC][PATCH 3/3] Reduce avtab node size
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@redhat.com>
In-Reply-To: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil>
References: <1122320487.3029.21.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 15:56:09 -0400
Message-Id: <1122321369.3029.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch updates checkpolicy for the change in the avtab_search
interface that resulted from moving the specified field into the key.

Index: checkpolicy/checkpolicy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/checkpolicy.c,v
retrieving revision 1.32
diff -u -p -r1.32 checkpolicy.c
--- checkpolicy/checkpolicy.c	18 Jul 2005 13:52:26 -0000	1.32
+++ checkpolicy/checkpolicy.c	23 Jul 2005 02:25:47 -0000
@@ -285,8 +285,8 @@ static void cond_check_type_rules_list(c
 	cond_av_list_t *cur = list;
 
 	while (cur) {
-		if (cur->node->datum.specified & AVTAB_TYPE) {
-			if (avtab_search(&policydbp->te_avtab, &cur->node->key, AVTAB_TYPE)) {
+		if (cur->node->key.specified & AVTAB_TYPE) {
+			if (avtab_search(&policydbp->te_avtab, &cur->node->key)) {
 				fprintf(stderr, "conditional type rule for (%s, %s : %s) conflicts with entry in base policy; "
 					"conditional rule discarded.\n", policydbp->p_type_val_to_name[cur->node->key.source_type-1],
 					policydbp->p_type_val_to_name[cur->node->key.target_type-1],

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
