Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0FEWCRb002859
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 09:32:12 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0FEV2xr003292
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 14:31:02 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0FEV2Yc003289
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 14:31:02 GMT
Subject: Re: specifying groups of types
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: david caplan <dac@tresys.com>, Chris PeBenito <pebenito@gentoo.org>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <3F8C46E4.1030403@tresys.com>
References: <200310111435.46684.russell@coker.com.au>
	 <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>
	 <3F8C46E4.1030403@tresys.com>
Content-Type: multipart/mixed; boundary="=-Zy7WhPIgAAOb7dexXU3L"
Message-Id: <1074177115.17320.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 15 Jan 2004 09:31:55 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Zy7WhPIgAAOb7dexXU3L
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-10-14 at 14:56, David Caplan wrote:
> Here's a quick hack that appears to work.  It turns off the type (or 
> list of types if used on an attribute) when building the bitmap of types 
> for a rule.  The syntax is to use a '-' in front of a type or attribute 
> name.
> 
> allow some_domain { file_type -shadow_t -null_device_t -exec_type}:...
> 
> The proper way to do this is in the yacc parsing section.  All I did was 
> allow '-' as the first character of an identifier (policy_scan.l) and 
> handle the subtraction of the type/attribute in 
> policy_parse.y:set_types().  The danger is that types (and anything 
> using the identifier definition) can be declared with '-' as the first 
> character and cause problems.  The advantage, in theory, is that 
> wherever a list of types/attributes is processed, the '-' notation can 
> be used to turn off types.  So, you should also be able to do something 
> like:
> 
> allow { auth -crond_t } file_type:...
> 
> Types/attributes are processed in order, and subsequent allow rules can 
> also override the subtraction.
> 
> I'd recommend trying this out and if you find it useful change the parse 
> rules.  I tested it on some real basic policy, so it may cause other 
> unintended problems.  I'm throwing it out more as a starting point 
> rather than something intended to be integrated into checkpolicy.

The attached patch for checkpolicy-1.4 provides the same feature (and
syntax), but is implemented as a modification to the policy grammar
rather than a change to the identifier token definition.  It doesn't
address the use of types in constraint expressions, but should work for
the TE rules, including assertions.
   
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-Zy7WhPIgAAOb7dexXU3L
Content-Disposition: attachment; filename=checkpolicy-excludetypes.patch
Content-Type: text/x-patch; name=checkpolicy-excludetypes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: checkpolicy/policy_parse.y
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.10
diff -u -r1.10 policy_parse.y
--- checkpolicy/policy_parse.y	9 Jan 2004 14:05:01 -0000	1.10
+++ checkpolicy/policy_parse.y	14 Jan 2004 21:08:32 -0000
@@ -520,6 +520,8 @@
 			| tilde nested_id_set
 	 		{ if (insert_id("~", 0)) return -1; 
 			  if (insert_separator(0)) return -1; }
+                        | identifier '-' { if (insert_id("-", 0)) return -1; } identifier 
+			{ if (insert_separator(0)) return -1; }
 			;
 tilde_push              : tilde
                         { if (insert_id("~", 1)) return -1; }
@@ -546,7 +548,7 @@
                         ;
 nested_id_list          : nested_id_element | nested_id_list nested_id_element
                         ;
-nested_id_element       : identifier | nested_id_set
+nested_id_element       : identifier | '-' { if (insert_id("-", 0)) return -1; } identifier | nested_id_set
                         ;
 identifier		: IDENTIFIER
 			{ if (insert_id(yytext,0)) return -1; }
@@ -1661,7 +1663,8 @@
 
 
 static int set_types(ebitmap_t *set,
-		     char *id)
+		     char *id,
+		     int *add)
 {
 	type_datum_t *t;
 	unsigned int i;
@@ -1686,6 +1689,12 @@
 		return 0;
 	}
 
+	if (strcmp(id, "-") == 0) {
+		*add = 0;
+		free(id);
+		return 0;
+	}	
+
 	t = hashtab_search(policydbp->p_types.table, id);
 	if (!t) {
 		sprintf(errormsg, "unknown type %s", id);
@@ -1695,18 +1704,19 @@
 	}
 
 	if (t->isattr) {
-		/* set all types with this attribute */
+		/* set or clear all types with this attribute */
 		for (i = ebitmap_startbit(&t->types); i < ebitmap_length(&t->types); i++) {
 			if (!ebitmap_get_bit(&t->types, i)) 
 				continue;		
-			ebitmap_set_bit(set, i, TRUE);
+			ebitmap_set_bit(set, i, *add);
 		}
 	} else {
-		/* set one type */
-		ebitmap_set_bit(set, t->value - 1, TRUE);
+		/* set or clear one type */
+		ebitmap_set_bit(set, t->value - 1, *add);
 	}
 
 	free(id);
+	*add = 1;
 	return 0;
 }
 
@@ -1720,7 +1730,7 @@
 	class_datum_t *cladatum;
 	ebitmap_t stypes, ttypes, tclasses;
 	__u32 newtype = 0;
-	int ret;
+	int ret, add = 1;
 	unsigned int i, j, k;
 
 	if (pass == 1) {
@@ -1740,12 +1750,12 @@
 	ebitmap_init(&tclasses);
 
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, id))
+		if (set_types(&stypes, id, &add))
 			return -1;
 	}
 
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&ttypes, id))
+		if (set_types(&ttypes, id, &add))
 			return -1;
 	}
 
@@ -1967,7 +1977,7 @@
 	ebitmap_t stypes, ttypes, tclasses;
 	access_vector_t *avp;
 	unsigned int i, j, hiclass;
-	int self = 0;
+	int self = 0, add = 1;
 	te_assert_t *newassert;
 
 	if (pass == 1) {
@@ -1987,7 +1997,7 @@
 	ebitmap_init(&tclasses);
 
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, id))
+		if (set_types(&stypes, id, &add))
 			return -1;
 	}
 
@@ -1996,7 +2006,7 @@
 			self = 1;
 			continue;
 		}
-		if (set_types(&ttypes, id))
+		if (set_types(&ttypes, id, &add))
 			return -1;
 	}
 
@@ -2139,7 +2149,7 @@
 {
 	role_datum_t *role;
 	char *role_id, *id;
-	int ret;
+	int ret, add = 1;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -2174,7 +2184,7 @@
 		free(role_id);
 
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&role->types, id))
+		if (set_types(&role->types, id, &add))
 			return -1;
 	}
 
@@ -2328,6 +2338,7 @@
 	ebitmap_t roles, types;
 	struct role_trans *tr = 0;
 	unsigned int i, j;
+	int add = 1;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -2348,7 +2359,7 @@
 	}
 
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&types, id))
+		if (set_types(&types, id, &add))
 			return -1;
 	}
 
@@ -2589,6 +2600,7 @@
 	role_datum_t *role;
 	char *id;
 	__u32 val;
+	int add = 1;
 
 	if (pass == 1) {
 		if (expr_type == CEXPR_NAMES) {
@@ -2678,7 +2690,7 @@
 				}
 				val = role->value;
 			} else if (expr->attr & CEXPR_TYPE) {
-				if (set_types(&expr->names, id)) {
+				if (set_types(&expr->names, id, &add)) {
 					free(expr);
 					return 0;
 				}

--=-Zy7WhPIgAAOb7dexXU3L--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
