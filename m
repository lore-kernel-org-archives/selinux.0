Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0FI44Rb004346
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 13:04:05 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0FI2dxr022784
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 18:02:40 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0FI2dYc022780
	for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2004 18:02:39 GMT
Subject: Re: aliases
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200401092218.47912.russell@coker.com.au>
References: <200401092218.47912.russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-PF9RxWyZv9mjirjr7Hhi"
Message-Id: <1074189815.17320.128.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 15 Jan 2004 13:03:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-PF9RxWyZv9mjirjr7Hhi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-01-09 at 06:18, Russell Coker wrote:
> I believe that we need a minor change in the policy language to deal with 
> aliases.
> 
> The current setup requires that all aliases be specified on the type 
> declaration line.  One significant problem with this is that if a type is 
> declared by a macro there is no way to add aliases to it.  Because of this we 
> have at various times had aliases specified in macros when they weren't 
> needed for 95% of the cases.
> 
> I believe that a declaration of the form is necessary:
> typealias foo_t aliases { bar_t baz_t };
> 
> That would mean that I could do:
> 
> var_run_domain(foo)
> typealias foo_var_run_t alias var_run_foo_t;
> 
> Instead of having the current alias in the var_run_domain() macro.  Of course 
> it's no big deal for the var_run_domain() macro (and I'll remove the alias 
> from my tree because it's been there too long anyway).  But there are other 
> situations which are more difficult to manage (such as renaming netscape to 
> mozilla).

A simple patch for checkpolicy that adds such typealias declarations
is attached.  However, note that this patch only supports typealias
declarations _after_ the base type declaration has been processed;
removing this ordering dependency would require reworking checkpolicy
further, as it currently collects all of the type declarations
(including alias and attribute information) in a single pass.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-PF9RxWyZv9mjirjr7Hhi
Content-Disposition: attachment; filename=checkpolicy-typealias.patch
Content-Type: text/x-patch; name=checkpolicy-typealias.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: checkpolicy/policy_parse.y
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.11
diff -u -r1.11 policy_parse.y
--- checkpolicy/policy_parse.y	15 Jan 2004 14:23:02 -0000	1.11
+++ checkpolicy/policy_parse.y	15 Jan 2004 17:48:45 -0000
@@ -42,6 +42,7 @@
 static int define_common_base(void);
 static int define_av_base(void);
 static int define_attrib(void);
+static int define_typealias(void);
 static int define_type(int alias);
 static int define_compute_type(int which);
 static int define_te_avtab(int which);
@@ -82,6 +83,7 @@
 %token SID
 %token ROLE
 %token ROLES
+%token TYPEALIAS
 %token TYPE
 %token TYPES
 %token ALIAS
@@ -240,6 +242,7 @@
 			;
 te_decl			: attribute_def
                         | type_def
+                        | typealias_def
                         | transition_def
                         | te_avtab_def
 			;
@@ -251,6 +254,9 @@
 	                | TYPE identifier opt_attr_list ';'
                         {if (define_type(0)) return -1;}
     			;
+typealias_def           : TYPEALIAS identifier alias_def
+			{if (define_typealias()) return -1;}
+			;
 opt_attr_list           : ',' id_comma_list
 			| 
 			;
@@ -1479,6 +1485,61 @@
 	return 0;
 }
 
+static int define_typealias(void)
+{
+	char *id;
+	type_datum_t *t, *aliasdatum;;
+	int ret;
+
+
+	if (pass == 2) {
+		while ((id = queue_remove(id_queue))) 
+			free(id);
+		return 0;
+	}
+
+	id = (char *) queue_remove(id_queue);
+	if (!id) {
+		yyerror("no type name for typealias definition?");
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
+		aliasdatum = (type_datum_t *) malloc(sizeof(type_datum_t));
+		if (!aliasdatum) {
+			yyerror("out of memory");
+			return -1;
+		}
+		memset(aliasdatum, 0, sizeof(type_datum_t));
+		aliasdatum->value = t->value;
+
+		ret = hashtab_insert(policydbp->p_types.table,
+				     (hashtab_key_t) id, (hashtab_datum_t) aliasdatum);
+
+		if (ret == HASHTAB_PRESENT) {
+			sprintf(errormsg, "name conflict for type alias %s", id);
+			yyerror(errormsg);
+			free(aliasdatum);
+			free(id);
+			return -1;
+		}
+		if (ret == HASHTAB_OVERFLOW) {
+			yyerror("hash table overflow");
+			free(aliasdatum);
+			free(id);
+			return -1;
+		}
+	}
+	return 0;
+}
 
 static int define_type(int alias)
 {
Index: checkpolicy/policy_scan.l
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/policy_scan.l,v
retrieving revision 1.3
diff -u -r1.3 policy_scan.l
--- checkpolicy/policy_scan.l	17 Dec 2003 16:52:20 -0000	1.3
+++ checkpolicy/policy_scan.l	15 Jan 2004 17:33:23 -0000
@@ -46,6 +46,8 @@
 roles				{ return(ROLES); }
 TYPES |
 types				{ return(TYPES); }
+TYPEALIAS |
+typealias			{ return(TYPEALIAS); }
 TYPE |
 type				{ return(TYPE); }
 ALIAS |

--=-PF9RxWyZv9mjirjr7Hhi--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
