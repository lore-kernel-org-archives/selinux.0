Message-ID: <4329ED38.1030400@trustedcs.com>
Date: Thu, 15 Sep 2005 16:52:56 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: [PATCH] fix checkpolicy segfaults when using role dominance statements
Content-Type: multipart/mixed;
 boundary="------------060708040009090404070402"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060708040009090404070402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes two segfaults in the code path handling a
role dominance statement such as:

dominance { role big_r { role little_r; } }

Look correct?

-- 

Darrel

--------------060708040009090404070402
Content-Type: text/x-patch;
 name="role_dominance.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="role_dominance.patch"

Index: policy_parse.y
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.37
diff -u -p -r1.37 policy_parse.y
--- policy_parse.y	22 Aug 2005 18:06:49 -0000	1.37
+++ policy_parse.y	15 Sep 2005 20:23:51 -0000
@@ -2478,7 +2478,6 @@ static int dominate_role_recheck(hashtab
 {
 	role_datum_t *rdp = (role_datum_t *) arg;
 	role_datum_t *rdatum = (role_datum_t *) datum;
-	ebitmap_t *types = NULL;
 	ebitmap_node_t *node;
 	int i;
 
@@ -2489,17 +2488,22 @@ static int dominate_role_recheck(hashtab
 	/* If a dominating role found */
 	if (ebitmap_get_bit(&(rdatum->dominates), rdp->value - 1))
 	{
-		if (type_set_expand(&rdp->types, types, policydbp, 1)) 
+		ebitmap_t types;
+		ebitmap_init(&types);
+		if (type_set_expand(&rdp->types, &types, policydbp, 1)) {
+			ebitmap_destroy(&types);
 			return -1;
+		}
 		/* raise types and dominates from dominated role */
 		ebitmap_for_each_bit(&rdp->dominates, node, i) {
 			if (ebitmap_node_get_bit(node, i))
 				ebitmap_set_bit(&rdatum->dominates, i, TRUE);
 		}
-		ebitmap_for_each_bit(types, node, i) {
+		ebitmap_for_each_bit(&types, node, i) {
 			if (ebitmap_node_get_bit(node, i))
 				ebitmap_set_bit(&rdatum->types.types, i, TRUE);
 		}		
+		ebitmap_destroy(&types);
 	}
 
 	/* go through all the roles */
@@ -2511,7 +2515,6 @@ static role_datum_t *
 {
 	role_datum_t *role;
 	char *role_id;
-	ebitmap_t *types = NULL;
 	ebitmap_node_t *node;
 	unsigned int i;
 	int ret;
@@ -2563,16 +2566,21 @@ static role_datum_t *
                 }
 	}
 	if (r) {
+		ebitmap_t types;
+		ebitmap_init(&types);
 		ebitmap_for_each_bit(&r->dominates, node, i) {
 			if (ebitmap_node_get_bit(node, i))
 				ebitmap_set_bit(&role->dominates, i, TRUE);
 		}
-		if (type_set_expand(&r->types, types, policydbp, 1)) 
+		if (type_set_expand(&r->types, &types, policydbp, 1)) {
+			ebitmap_destroy(&types);
 			return NULL;
-		ebitmap_for_each_bit(types, node, i) {
+		}
+		ebitmap_for_each_bit(&types, node, i) {
 			if (ebitmap_node_get_bit(node, i))
 				ebitmap_set_bit(&role->types.types, i, TRUE);
 		}
+		ebitmap_destroy(&types);
 		if (!r->value) {
 			/* free intermediate result */
 			type_set_destroy(&r->types);

--------------060708040009090404070402--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
