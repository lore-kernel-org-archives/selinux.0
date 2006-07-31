Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6VEo8wE021149
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 10:50:08 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6VEnxkX024928
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 14:50:00 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.7/8.13.7) with ESMTP id k6VEo4ie003857
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 10:50:05 -0400
Received: (from kmacmill@localhost)
	by localhost.localdomain (8.13.7/8.13.7/Submit) id k6VEo4mV003856
	for selinux@tycho.nsa.gov; Mon, 31 Jul 2006 10:50:04 -0400
Subject: [PATCH 2/2] Introduce symtab_datum_t
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 10:50:04 -0400
Message-Id: <1154357404.26550.79.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch cleans up a cast in module_compiler.c to use the new
symtab_datum_t.

Karl

 module_compiler.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index ec5fc89..3252bb7 100644
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


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
