Subject: [RFC][PATCH 3/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 13:23:25 -0400
Message-Id: <1122657805.6573.213.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch, relative to the checkpolicy patch to reduce avtab node size,
updates checkpolicy for the changes to libsepol.

---

 checkpolicy.c  |    7 ++-----
 policy_parse.y |    6 +++---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff -X /home/sds/dontdiff -rup checkpolicy-avtab1/checkpolicy.c checkpolicy/checkpolicy.c
--- checkpolicy-avtab1/checkpolicy.c	2005-07-28 14:47:49.000000000 -0400
+++ checkpolicy/checkpolicy.c	2005-07-28 14:49:06.000000000 -0400
@@ -584,14 +584,11 @@ int main(int argc, char **argv)
 		}
 
 		if (check_assertions(policydbp,
-                                     policydbp->global->branch_list->avrules,
-                                     &policydbp->te_avtab) ||
-		    check_assertions(policydbp,
-                                     policydbp->global->branch_list->avrules,
-                                     &policydbp->te_cond_avtab)) {
+                                     policydbp->global->branch_list->avrules)) {
                         fprintf(stderr, "Check assertions failed.\n");
 			return -1;
                 }
+
 		fclose(yyin);
 	}
 
diff -X /home/sds/dontdiff -rup checkpolicy-avtab1/policy_parse.y checkpolicy/policy_parse.y
--- checkpolicy-avtab1/policy_parse.y	2005-07-06 13:28:08.000000000 -0400
+++ checkpolicy/policy_parse.y	2005-07-28 14:49:06.000000000 -0400
@@ -2483,7 +2483,7 @@ static int dominate_role_recheck(hashtab
 	/* If a dominating role found */
 	if (ebitmap_get_bit(&(rdatum->dominates), rdp->value - 1))
 	{
-		if (type_set_expand(&rdp->types, types, policydbp)) 
+		if (type_set_expand(&rdp->types, types, policydbp, 1)) 
 			return -1;
 		/* raise types and dominates from dominated role */
 		for (i = ebitmap_startbit(&rdp->dominates); 
@@ -2564,7 +2564,7 @@ static role_datum_t *
 			if (ebitmap_get_bit(&r->dominates, i))
 				ebitmap_set_bit(&role->dominates, i, TRUE);
 		}
-		if (type_set_expand(&r->types, types, policydbp)) 
+		if (type_set_expand(&r->types, types, policydbp, 1)) 
 			return NULL;
 		for (i = ebitmap_startbit(types); i < ebitmap_length(types); i++)	{
 			if (ebitmap_get_bit(types, i))
@@ -2683,7 +2683,7 @@ static int define_role_trans(void)
 	if (role_set_expand(&roles, &e_roles, policydbp))
 		goto bad;
 		
-	if (type_set_expand(&types, &e_types, policydbp))
+	if (type_set_expand(&types, &e_types, policydbp, 1))
 		goto bad;
 
 	for (i = ebitmap_startbit(&e_roles); i < ebitmap_length(&e_roles); i++) {

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
