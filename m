Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0VJfgGA019171
 for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2017 14:41:42 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/5] checkpolicy: Create common function for type declares and
 requires
Date: Tue, 31 Jan 2017 14:41:54 -0500
Message-Id: <1485891718-18829-2-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1485891718-18829-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Move common code out of declare_type() and require_type_or_attribute()
into the new function create_type().

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 checkpolicy/module_compiler.c | 142 ++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 80 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 6e5483c..0c76bfb 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -305,67 +305,83 @@ role_datum_t *declare_role(unsigned char isattr)
 	}
 }
 
-type_datum_t *declare_type(unsigned char primary, unsigned char isattr)
+int create_type(uint32_t scope, unsigned char isattr, type_datum_t **type)
 {
 	char *id;
-	type_datum_t *typdatum;
-	int retval;
+	type_datum_t *datum;
+	int ret;
 	uint32_t value = 0;
 
+	*type = NULL;
+
 	id = (char *)queue_remove(id_queue);
 	if (!id) {
 		yyerror("no type/attribute name?");
-		return NULL;
+		return -1;
 	}
 	if (strcmp(id, "self") == 0) {
-		yyerror
-		    ("'self' is a reserved type name and may not be declared.");
+		yyerror("\"self\" is a reserved type name.");
 		free(id);
-		return NULL;
+		return -1;
 	}
 
-	typdatum = (type_datum_t *) malloc(sizeof(type_datum_t));
-	if (!typdatum) {
+	datum = malloc(sizeof(*datum));
+	if (!datum) {
 		yyerror("Out of memory!");
 		free(id);
-		return NULL;
+		return -1;
 	}
-	type_datum_init(typdatum);
-	typdatum->primary = primary;
-	typdatum->flavor = isattr ? TYPE_ATTRIB : TYPE_TYPE;
+	type_datum_init(datum);
+	datum->primary = 1;
+	datum->flavor = isattr ? TYPE_ATTRIB : TYPE_TYPE;
 
-	retval = declare_symbol(SYM_TYPES, id, typdatum, &value, &value);
-	if (retval == 0 || retval == 1) {
-		if (typdatum->primary) {
-			typdatum->s.value = value;
-		}
+	if (scope == SCOPE_DECL) {
+		ret = declare_symbol(SYM_TYPES, id, datum, &value, &value);
 	} else {
-		/* error occurred (can't have duplicate type declarations) */
-		free(id);
-		type_datum_destroy(typdatum);
-		free(typdatum);
+		ret = require_symbol(SYM_TYPES, id, datum, &value, &value);
 	}
-	switch (retval) {
-	case -3:{
+
+	if (ret == 0) {
+		datum->s.value = value;
+		*type = datum;
+	} else if (ret == 1) {
+		type_datum_destroy(datum);
+		free(datum);
+		*type = hashtab_search(policydbp->symtab[SYM_TYPES].table, id);
+		free(id);
+	} else {
+		free(id);
+		type_datum_destroy(datum);
+		free(datum);
+
+		switch (ret) {
+		case -3:
 			yyerror("Out of memory!");
-			return NULL;
-		}
-	case -2:{
+			break;
+		case -2:
 			yyerror2("duplicate declaration of type/attribute");
-			return NULL;
-		}
-	case -1:{
+			break;
+		case -1:
 			yyerror("could not declare type/attribute here");
-			return NULL;
-		}
-	case 0:
-	case 1:{
-			return typdatum;
-		}
-	default:{
+			break;
+		default:
 			abort();	/* should never get here */
 		}
 	}
+
+	return ret;
+}
+
+type_datum_t *declare_type(unsigned char primary, unsigned char isattr)
+{
+	type_datum_t *type = NULL;
+	int ret = create_type(SCOPE_DECL, isattr, &type);
+
+	if (ret == 0) {
+		type->primary = primary;
+	}
+
+	return type;
 }
 
 static int user_implicit_bounds(hashtab_t users_tab,
@@ -934,55 +950,21 @@ int require_attribute_role(int pass)
 
 static int require_type_or_attribute(int pass, unsigned char isattr)
 {
-	char *id = queue_remove(id_queue);
 	type_datum_t *type = NULL;
-	int retval;
+	int ret;
+
 	if (pass == 2) {
-		free(id);
+		free(queue_remove(id_queue));
 		return 0;
 	}
-	if (id == NULL) {
-		yyerror("no type name");
-		return -1;
-	}
-	if ((type = malloc(sizeof(*type))) == NULL) {
-		free(id);
-		yyerror("Out of memory!");
+
+	ret = create_type(SCOPE_REQ, isattr, &type);
+
+	if (ret < 0) {
 		return -1;
 	}
-	type_datum_init(type);
-	type->primary = 1;
-	type->flavor = isattr ? TYPE_ATTRIB : TYPE_TYPE;
-	retval =
-	    require_symbol(SYM_TYPES, id, (hashtab_datum_t *) type,
-			   &type->s.value, &type->s.value);
-	if (retval != 0) {
-		free(id);
-		free(type);
-	}
-	switch (retval) {
-	case -3:{
-			yyerror("Out of memory!");
-			return -1;
-		}
-	case -2:{
-			yyerror("duplicate declaration of type/attribute");
-			return -1;
-		}
-	case -1:{
-			yyerror("could not require type/attribute here");
-			return -1;
-		}
-	case 0:{
-			return 0;
-		}
-	case 1:{
-			return 0;	/* type already required */
-		}
-	default:{
-			abort();	/* should never get here */
-		}
-	}
+
+	return 0;
 }
 
 int require_type(int pass)
-- 
2.7.4
