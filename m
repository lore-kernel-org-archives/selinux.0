Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72I3KBi004390
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 14:03:20 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k72I3Aa2000916
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 18:03:10 GMT
From: kmacmillan@mentalrootkit.com
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmill@mentalrootkit.com>
Subject: [PATCH 2/2] Introduce symtab_datum_t
Reply-To: kmacmillan@mentalrootkit.com
Date: Wed, 02 Aug 2006 14:03:07 -0400
Message-Id: <11545417961009-git-send-email-kmacmillan@mentalrootkit.com>
In-Reply-To: <11545417914109-git-send-email-kmacmillan@mentalrootkit.com>
References: <11545417871050-git-send-email-kmacmillan@mentalrootkit.com> <11545417914109-git-send-email-kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Karl MacMillan <kmacmill@mentalrootkit.com>

This patch cleans up two casts in module_compiler.c to use the new
symtab_datum_t.

Karl
---
 checkpolicy/module_compiler.c |   26 +++++++++-----------------
 1 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index ec5fc89..977daca 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -137,15 +137,11 @@ int declare_symbol(uint32_t symbol_type,
 	retval = symtab_insert(policydbp, symbol_type, key, datum,
 			       SCOPE_DECL, decl->decl_id, dest_value);
 	if (retval == 1) {
-		/* because C has no polymorphism, make the
-		 * [outrageous] assumption that the first field of all
-		 * symbol table data is a uint32_t representing its
-		 * value */
-		uint32_t *v =
-		    (uint32_t *) hashtab_search(policydbp->symtab[symbol_type].
+		symtab_datum_t *s =
+		    (symtab_datum_t *)hashtab_search(policydbp->symtab[symbol_type].
 						table, key);
-		assert(v != NULL);
-		*dest_value = *v;
+		assert(s != NULL);
+		*dest_value = s->value;
 	} else if (retval == -2) {
 		return -2;
 	} else if (retval < 0) {
@@ -494,15 +490,11 @@ int require_symbol(uint32_t symbol_type,
 	retval = symtab_insert(policydbp, symbol_type, key, datum,
 			       SCOPE_REQ, decl->decl_id, dest_value);
 	if (retval == 1) {
-		/* because C has no polymorphism, make the
-		 * [outrageous] assumption that the first field of all
-		 * symbol table data is a uint32_t representing its
-		 * value */
-		uint32_t *v =
-		    (uint32_t *) hashtab_search(policydbp->symtab[symbol_type].
-						table, key);
-		assert(v != NULL);
-		*dest_value = *v;
+		symtab_datum_t *s =
+		    (symtab_datum_t *) hashtab_search(policydbp->symtab[symbol_type].
+						      table, key);
+		assert(s != NULL);
+		*dest_value = s->value;
 	} else if (retval == -2) {
 		/* ignore require statements if that symbol was
 		 * previously declared and is in current scope */
-- 
1.4.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
