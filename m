Message-ID: <48529591.90806@manicmethod.com>
Date: Fri, 13 Jun 2008 11:43:13 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [patch] libsepol write.c has shadowed var
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch addresses a shadowed var that prevents libsepol from being built with DEBUG=1

Signed-off-by: Joshua Brindle <method@manicmethod.com>

---

Index: libsepol/src/write.c
===================================================================
--- libsepol/src/write.c	(revision 2908)
+++ libsepol/src/write.c	(working copy)
@@ -1625,10 +1625,10 @@
 	if (p->policyvers < POLICYDB_VERSION_PERMISSIVE &&
 	    p->policy_type == POLICY_KERN) {
 		ebitmap_node_t *tnode;
-		unsigned int i;
+		unsigned int j;
 
-		ebitmap_for_each_bit(&p->permissive_map, tnode, i) {
-			if (ebitmap_node_get_bit(tnode, i)) {
+		ebitmap_for_each_bit(&p->permissive_map, tnode, j) {
+			if (ebitmap_node_get_bit(tnode, j)) {
 				WARN(fp->handle, "Warning! Policy version %d cannot "
 				     "support permissive types, but some were defined",
 				     p->policyvers);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
