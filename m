Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBDFqYIi004453
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 10:52:35 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBDFqbX4002258
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 15:52:37 GMT
Received: (from smmsp@localhost)
	by tcsfw2.tcs-sec.com (8.12.2/8.12.2) id iBDFqWvL004116
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 10:52:32 -0500 (EST)
Message-ID: <41BDBAF1.2060502@trustedcs.com>
Date: Mon, 13 Dec 2004 09:53:21 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: [patch] typeattribute statements
Content-Type: multipart/mixed;
 boundary="------------090502030805060401010206"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090502030805060401010206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
     I have attached a simple patch which introduces a "typeattribute" statement 
to the policy grammar.  This will allow attributes to be added to a type after 
its initial definition - much like the "typealias" statement allows for aliasing 
after the initial type definition.  The usage is as follows:

typeattribute TYPE ATTRIBUTES;

where TYPE is the type you are adding attributes to and ATTRIBUTES is a comma 
separated list of the attributes you would like to add.

Such statements are useful for policy tweaking without extensive modification to 
the existing .te files (which makes tracking changes much easier).

The patch is against the current sourceforge CVS chekpolicy directory.

-- 

Darrel

--------------090502030805060401010206
Content-Type: text/plain;
 name="typeattr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="typeattr.patch"

Index: policy_parse.y
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.25
diff -u -r1.25 policy_parse.y
--- policy_parse.y	5 Nov 2004 19:14:42 -0000	1.25
+++ policy_parse.y	13 Dec 2004 15:37:38 -0000
@@ -68,6 +68,7 @@
 static int define_av_base(void);
 static int define_attrib(void);
 static int define_typealias(void);
+static int define_typeattribute(void);
 static int define_type(int alias);
 static int define_compute_type(int which);
 static int define_te_avtab(int which);
@@ -121,6 +122,7 @@
 %token ROLE
 %token ROLES
 %token TYPEALIAS
+%token TYPEATTRIBUTE
 %token TYPE
 %token TYPES
 %token ALIAS
@@ -287,6 +289,7 @@
 te_decl			: attribute_def
                         | type_def
                         | typealias_def
+                        | typeattribute_def
                         | bool_def
                         | transition_def
                         | te_avtab_def
@@ -303,6 +306,9 @@
 typealias_def           : TYPEALIAS identifier alias_def ';'
 			{if (define_typealias()) return -1;}
 			;
+typeattribute_def	: TYPEATTRIBUTE identifier id_comma_list ';'
+			{if (define_typeattribute()) return -1;}
+			;
 opt_attr_list           : ',' id_comma_list
 			| 
 			;
@@ -1633,10 +1639,9 @@
 static int define_typealias(void)
 {
 	char *id;
-	type_datum_t *t, *aliasdatum;;
+	type_datum_t *t, *aliasdatum;
 	int ret;
 
-
 	if (pass == 2) {
 		while ((id = queue_remove(id_queue))) 
 			free(id);
@@ -1686,6 +1691,84 @@
 	return 0;
 }
 
+static int define_typeattribute(void)
+{
+	char *id;
+	type_datum_t *t, *attr;
+
+	if (pass == 2) {
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		return 0;
+	}
+
+	id = (char *)queue_remove(id_queue);
+	if (!id) {
+		yyerror("no type name for typeattribute definition?");
+		return -1;
+	}
+
+	t = hashtab_search(policydbp->p_types.table, id);
+	if (!t || t->isattr) {
+		sprintf(errormsg, "unknown type %s", id);
+		yyerror(errormsg);
+		free(id);
+		return -1;
+	}
+
+	while ((id = queue_remove(id_queue))) {
+#ifdef CONFIG_SECURITY_SELINUX_MLS
+		if (!strcmp(id, "mlstrustedreader")) {
+			if (ebitmap_set_bit(&policydbp->trustedreaders,
+			                    (t->value - 1), TRUE)) {
+				yyerror("out of memory");
+				free(id);
+				return -1;
+			}
+		} else if (!strcmp(id, "mlstrustedwriter")) {
+			if (ebitmap_set_bit(&policydbp->trustedwriters,
+			                    (t->value - 1), TRUE)) {
+				yyerror("out of memory");
+				free(id);
+				return -1;
+			}
+		} else if (!strcmp(id, "mlstrustedobject")) {
+			if (ebitmap_set_bit(&policydbp->trustedobjects,
+			                    (t->value - 1), TRUE)) {
+				yyerror("out of memory");
+				free(id);
+				return -1;
+			}
+		}
+#endif
+		attr = hashtab_search(policydbp->p_types.table, id);
+		if (!attr) {
+			sprintf(errormsg, "attribute %s is not declared", id);
+			/* treat it as a fatal error */
+			yyerror(errormsg);
+			free(id);
+			return -1;
+		}
+
+		if (!attr->isattr) {
+			sprintf(errormsg, "%s is a type, not an attribute", id);
+			yyerror(errormsg);
+			free(id);
+			return -1;
+		}
+
+		free(id);
+
+		if (ebitmap_set_bit(&attr->types, (t->value - 1), TRUE)) {
+			yyerror("out of memory");
+			free(id);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 static int define_type(int alias)
 {
 	char *id;
Index: policy_scan.l
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/checkpolicy/policy_scan.l,v
retrieving revision 1.6
diff -u -r1.6 policy_scan.l
--- policy_scan.l	9 Aug 2004 18:12:29 -0000	1.6
+++ policy_scan.l	13 Dec 2004 15:37:38 -0000
@@ -64,6 +64,8 @@
 types				{ return(TYPES); }
 TYPEALIAS |
 typealias			{ return(TYPEALIAS); }
+TYPEATTRIBUTE |
+typeattribute			{ return(TYPEATTRIBUTE); }
 TYPE |
 type				{ return(TYPE); }
 BOOL |

--------------090502030805060401010206--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
