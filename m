Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0EDDgCl013728
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 08:13:42 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 417625646E3
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 14:13:30 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] checkpolicy: do not leak memory when declaring a type
 which has been required
Date: Sat, 14 Jan 2017 14:12:55 +0100
Message-Id: <20170114131255.17598-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This kind of strange construction is currently accepted by checkmodule
but it makes memory to be leaked in declare_type():

    optional {
        require { type TYPE1; }
    }
    optional {
        require { attribute ATTR; }
        type TYPE1, ATTR;
    }

Moreover reversing the order of these two optional blocks leads to an
(expected) error:

    ERROR 'duplicate declaration of type/attribute' at token 'TYPE1'
    on line 14:
            require { type TYPE1; }

Make checkmodule fails with an error when encourntering the first
construction.

Moreover the construction below also makes memory to be leaked:

    optional {
        require { type TYPE2; attribute ATTR; }
        typeattribute TYPE2 ATTR;
    }
    type TYPE2;

This example is valid and is used by several refpolicy modules. In
declare_type(), declare_symbol() returns 1, stack_top->parent is NULL
and the scope of TYPE2 has been updated when declare_symbol() called
symtab_insert(). When these conditions are met, declare_type() should
return the currently existing type in the policy database.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---

I have tested this patch both with "make test" and by compiling the
current master branch of refpolicy. I have not tested it to build any
Android policy.

 checkpolicy/module_compiler.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 6e5483c17540..04d09d1445a3 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -308,7 +308,7 @@ role_datum_t *declare_role(unsigned char isattr)
 type_datum_t *declare_type(unsigned char primary, unsigned char isattr)
 {
 	char *id;
-	type_datum_t *typdatum;
+	type_datum_t *typdatum, *old_datum;
 	int retval;
 	uint32_t value = 0;
 
@@ -335,10 +335,37 @@ type_datum_t *declare_type(unsigned char primary, unsigned char isattr)
 	typdatum->flavor = isattr ? TYPE_ATTRIB : TYPE_TYPE;
 
 	retval = declare_symbol(SYM_TYPES, id, typdatum, &value, &value);
-	if (retval == 0 || retval == 1) {
+	if (retval == 0) {
 		if (typdatum->primary) {
 			typdatum->s.value = value;
 		}
+	} else if (retval == 1) {
+		/* the type has been previously marked as required */
+		assert(stack_top->type == 1);
+		if (stack_top->parent == NULL) {
+			/* in global scope, the type has previously been required and is now declared.
+			 * policydbp->scope[SYM_TYPES] has been updated by declare_symbol() */
+			old_datum = (type_datum_t *) hashtab_search(policydbp->p_types.table, id);
+
+			/* check that previous symbol has the same type/attribute-ness */
+			if (typdatum->flavor == old_datum->flavor) {
+				type_datum_destroy(typdatum);
+				free(typdatum);
+				typdatum = old_datum;
+			} else {
+				yyerror("declaration of type/attribute with an unexpected flavor");
+				type_datum_destroy(typdatum);
+				free(typdatum);
+				typdatum = NULL;
+			}
+			free(id);
+		} else {
+			yyerror("declaration of type/attribute after it has been required");
+			free(id);
+			type_datum_destroy(typdatum);
+			free(typdatum);
+			return NULL;
+		}
 	} else {
 		/* error occurred (can't have duplicate type declarations) */
 		free(id);
-- 
2.11.0
