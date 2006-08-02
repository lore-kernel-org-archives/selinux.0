Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72IA2g1004712
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 14:10:02 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k72I9seA006394
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 18:09:56 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.7/8.13.7) with ESMTP id k72I9waW021419
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 14:09:59 -0400
Received: (from kmacmill@localhost)
	by localhost.localdomain (8.13.7/8.13.7/Submit) id k72I9vYm021418
	for selinux@tycho.nsa.gov; Wed, 2 Aug 2006 14:09:57 -0400
Subject: [PATCH 2/2] Ver 2 Introduce symtab_datum_t
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 14:09:57 -0400
Message-Id: <1154542197.27457.88.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
