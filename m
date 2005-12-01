Subject: [patch] checkpolicy cleanups
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: SELinux-dev@tresys.com
Content-Type: multipart/mixed; boundary="=-kgJvtQ85Ci6oTTMT7IqR"
Date: Thu, 01 Dec 2005 12:08:21 -0500
Message-Id: <1133456901.28437.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-kgJvtQ85Ci6oTTMT7IqR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Just FYI, a couple of cleanups have been committed to checkpolicy,
attached below.  

First patch was based on patches submitted by George Coker and drops out
the compatibility handling of netlink classes from checkpolicy as well
as making fs_use optional.  The motivation was to allow checkpolicy to
work for non-Linux platforms where the netlink classes are meaningless.
I think that the compatibility code there is no longer necessary since
the change occurred back in Linux 2.6.8, and it would only matter if you
were trying to compile a newer policy source with the fine-grained
netlink classes to a form useable by a 2.6.7 or older kernel.  Also,
even if we wanted to retain this remapping support, we would need to
move it into libsepol to handle policy modules and automatic downgrading
of policy upon policy load.

Second patch adds error checking for a number of cases in checkpolicy
where it was failing to check for failure on ebitmap_set_bit calls
(which can occur due to an out of memory condition); I happened to
notice that lack of such checking when merging the first patch.

-- 
Stephen Smalley
National Security Agency

--=-kgJvtQ85Ci6oTTMT7IqR
Content-Disposition: attachment; filename=checkpolicy-nlclass.patch
Content-Type: text/x-patch; name=checkpolicy-nlclass.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: checkpolicy/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/ChangeLog,v
retrieving revision 1.90
retrieving revision 1.91
diff -u -p -r1.90 -r1.91
--- checkpolicy/ChangeLog	25 Oct 2005 12:09:08 -0000	1.90
+++ checkpolicy/ChangeLog	1 Dec 2005 15:49:36 -0000	1.91
@@ -1,3 +1,10 @@
+1.27.18 2005-12-01
+	* Merged removal of compatibility handling of netlink classes
+	  (requirement that policies with newer versions include the
+	   netlink class definitions, remapping of fine-grained netlink
+	   classes in newer source policies to single netlink class when
+	   generating older policies) from George Coker.
+
 1.27.17 2005-10-25
 	* Merged dismod fix from Joshua Brindle.
 
Index: checkpolicy/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/VERSION,v
retrieving revision 1.62
retrieving revision 1.63
diff -u -p -r1.62 -r1.63
--- checkpolicy/VERSION	25 Oct 2005 12:09:09 -0000	1.62
+++ checkpolicy/VERSION	1 Dec 2005 15:49:36 -0000	1.63
@@ -1 +1 @@
-1.27.17
+1.27.18
Index: checkpolicy/checkmodule.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/checkmodule.c,v
retrieving revision 1.7
retrieving revision 1.8
diff -u -p -r1.7 -r1.8
--- checkpolicy/checkmodule.c	19 Oct 2005 19:59:30 -0000	1.7
+++ checkpolicy/checkmodule.c	1 Dec 2005 15:49:36 -0000	1.8
@@ -53,9 +53,6 @@ static char *binfile = "policy";
 unsigned int policy_type = POLICY_BASE;
 unsigned int policyvers = MOD_POLICYDB_VERSION_MAX;
 
-/* always set to 0 for checkpolicy, set to 1 for checkmodule */
-unsigned int is_building_modules = 1;
-
 static int read_binary_policy(policydb_t *p, char *file, char *progname)
 {
         int fd;
Index: checkpolicy/checkpolicy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/checkpolicy.c,v
retrieving revision 1.42
retrieving revision 1.44
diff -u -p -r1.42 -r1.44
--- checkpolicy/checkpolicy.c	20 Oct 2005 16:34:06 -0000	1.42
+++ checkpolicy/checkpolicy.c	1 Dec 2005 15:49:36 -0000	1.44
@@ -103,9 +103,6 @@ static char *binfile = "policy";
 
 unsigned int policyvers = POLICYDB_VERSION_MAX;
 
-/* always set to 0 for checkpolicy, set to 1 for checkmodule */
-unsigned int is_building_modules = 0;
-
 void usage(char *progname)
 {
 	printf("usage:  %s [-b] [-d] [-M] [-c policyvers (%d-%d)] [-o output_file] [input_file]\n",
@@ -528,12 +525,6 @@ int main(int argc, char **argv)
 		if (policydb_errors) 
 			exit(1);
 
-		if (policyvers >= POLICYDB_VERSION_NLCLASS &&
-		    parse_policy.p_classes.nprim < SECCLASS_NETLINK_DNRT_SOCKET) {
-			fprintf(stderr, "%s:  policy lacks new netlink classes, unable to generate policy version %d\n", argv[0], policyvers);
-			exit(1);
-		}
-
 		if (policydb_init(&policydb)) {
 			fprintf(stderr, "%s:  policydb_init failed\n", argv[0]);
 			exit(1);
Index: checkpolicy/policy_parse.y
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.53
retrieving revision 1.55
diff -u -p -r1.53 -r1.55
--- checkpolicy/policy_parse.y	19 Oct 2005 18:37:53 -0000	1.53
+++ checkpolicy/policy_parse.y	1 Dec 2005 15:49:36 -0000	1.55
@@ -71,7 +71,6 @@ extern unsigned long policydb_lineno;
 extern unsigned long source_lineno;
 extern unsigned int policydb_errors;
 extern unsigned int policyvers;
-extern int is_building_modules;
 
 extern char yytext[];
 extern int yylex(void);
@@ -214,7 +213,7 @@ base_policy             : { if (define_p
 			  opt_mls te_rbac users opt_constraints 
                          { if (pass == 1) { if (policydb_index_bools(policydbp)) return -1;}
 			   else if (pass == 2) { if (policydb_index_others(NULL, policydbp, 0)) return -1;}}
-			  initial_sid_contexts opt_fs_contexts fs_uses opt_genfs_contexts net_contexts 
+			  initial_sid_contexts opt_fs_contexts opt_fs_uses opt_genfs_contexts net_contexts 
 			;
 classes			: class_def 
 			| classes class_def
@@ -658,6 +657,9 @@ node_context_def	: NODECON ipv4_addr_def
 			| NODECON ipv6_addr ipv6_addr security_context_def
 			{if (define_ipv6_node_context()) return -1;}
 			;
+opt_fs_uses             : fs_uses
+                        |
+                        ;
 fs_uses                 : fs_use_def
                         | fs_uses fs_use_def
                         ;
@@ -1979,7 +1981,6 @@ static int define_compute_type_helper(in
 
         ebitmap_init(&tclasses);
 	while ((id = queue_remove(id_queue))) {
-                uint32_t classvalue;
                 if (!is_id_in_scope(SYM_CLASSES, id)) {
                         yyerror2("class %s is not within scope", id);
                         free(id);
@@ -1991,19 +1992,7 @@ static int define_compute_type_helper(in
 			yyerror(errormsg);
 			goto bad;
 		}
-                if (!is_building_modules &&
-                    policyvers < POLICYDB_VERSION_NLCLASS &&
-		    (cladatum->value >= SECCLASS_NETLINK_ROUTE_SOCKET &&
-		     cladatum->value <= SECCLASS_NETLINK_DNRT_SOCKET)) {
-			sprintf(errormsg, "remapping class %s to netlink_socket "
-			        "for policy version %d", id, policyvers);
-			yywarn(errormsg);
-			classvalue = SECCLASS_NETLINK_SOCKET;
-                }
-                else {
-                        classvalue = cladatum->value;
-                }
-                ebitmap_set_bit(&tclasses, classvalue - 1, TRUE);
+		ebitmap_set_bit(&tclasses, cladatum->value - 1, TRUE);
 		free(id);
 	}
 
@@ -2212,7 +2201,7 @@ static int define_te_avtab_helper(int wh
 	ebitmap_t tclasses;
 	ebitmap_node_t *node;
 	avrule_t *avrule;
-	unsigned int i, hiclass;
+	unsigned int i;
 	int add = 1, ret = 0;
 	int suppress = 0;
 
@@ -2245,11 +2234,8 @@ static int define_te_avtab_helper(int wh
 		}
 	}
 
-	hiclass = 0;
 	ebitmap_init(&tclasses);
 	while ((id = queue_remove(id_queue))) {
-		uint32_t classvalue;
-
                 if (!is_id_in_scope(SYM_CLASSES, id)) {
                         yyerror2("class %s is not within scope", id);
                         ret = -1;
@@ -2262,21 +2248,7 @@ static int define_te_avtab_helper(int wh
 			ret = -1;
 			goto out;
 		}
-                if (!is_building_modules &&
-                    policyvers < POLICYDB_VERSION_NLCLASS &&
-		    (cladatum->value >= SECCLASS_NETLINK_ROUTE_SOCKET &&
-		     cladatum->value <= SECCLASS_NETLINK_DNRT_SOCKET)) {
-			sprintf(errormsg, "remapping class %s to netlink_socket "
-			        "for policy version %d", id, policyvers);
-			yywarn(errormsg);
-			classvalue = SECCLASS_NETLINK_SOCKET;
-			suppress = 1;
-		} else 
-			classvalue = cladatum->value;
-		
-		ebitmap_set_bit(&tclasses, classvalue - 1, TRUE);	
-		if (classvalue > hiclass)
-			hiclass = classvalue;
+		ebitmap_set_bit(&tclasses, cladatum->value - 1, TRUE);	
 		free(id);
 	}
 

--=-kgJvtQ85Ci6oTTMT7IqR
Content-Disposition: attachment; filename=checkpolicy-setbit.patch
Content-Type: text/x-patch; name=checkpolicy-setbit.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: checkpolicy/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/ChangeLog,v
retrieving revision 1.91
retrieving revision 1.92
diff -u -p -r1.91 -r1.92
--- checkpolicy/ChangeLog	1 Dec 2005 15:49:36 -0000	1.91
+++ checkpolicy/ChangeLog	1 Dec 2005 16:27:58 -0000	1.92
@@ -1,3 +1,7 @@
+1.27.19 2005-12-01
+	* Added error checking of all ebitmap_set_bit calls for out of
+	  memory conditions.
+
 1.27.18 2005-12-01
 	* Merged removal of compatibility handling of netlink classes
 	  (requirement that policies with newer versions include the
Index: checkpolicy/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/VERSION,v
retrieving revision 1.63
retrieving revision 1.64
diff -u -p -r1.63 -r1.64
--- checkpolicy/VERSION	1 Dec 2005 15:49:36 -0000	1.63
+++ checkpolicy/VERSION	1 Dec 2005 16:27:58 -0000	1.64
@@ -1 +1 @@
-1.27.18
+1.27.19
Index: checkpolicy/module_compiler.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/module_compiler.c,v
retrieving revision 1.11
retrieving revision 1.12
diff -u -p -r1.11 -r1.12
--- checkpolicy/module_compiler.c	19 Oct 2005 18:37:53 -0000	1.11
+++ checkpolicy/module_compiler.c	1 Dec 2005 16:27:58 -0000	1.12
@@ -240,7 +240,10 @@ role_datum_t *declare_role(void)
                 return NULL;
         }
         case 0: {
-                ebitmap_set_bit(&role->dominates, role->value - 1, 1);
+		if (ebitmap_set_bit(&role->dominates, role->value - 1, 1)) {
+			yyerror("out of memory");
+			return NULL;
+		}
                 return dest_role;
         }
         case 1: {
@@ -736,7 +739,10 @@ int require_role(int pass)
         }
         case 0: {
                 /* all roles dominate themselves */
-                ebitmap_set_bit(&role->dominates, role->value - 1, 1);
+                if (ebitmap_set_bit(&role->dominates, role->value - 1, 1)) {
+			yyerror("Out of memory");
+			return -1;
+		}
                 return 0;
         }
         case 1: {
Index: checkpolicy/policy_parse.y
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.55
retrieving revision 1.56
diff -u -p -r1.55 -r1.56
--- checkpolicy/policy_parse.y	1 Dec 2005 15:49:36 -0000	1.55
+++ checkpolicy/policy_parse.y	1 Dec 2005 16:27:58 -0000	1.56
@@ -1874,7 +1874,10 @@ static int define_type(int alias)
                         return -1;
                 }
 
-		ebitmap_set_bit(&attr->types, datum->value - 1, TRUE);
+		if (ebitmap_set_bit(&attr->types, datum->value - 1, TRUE)) {
+			yyerror("Out of memory");
+			return -1;
+		}
 	}
 
 	return 0;
@@ -1939,14 +1942,20 @@ static int set_types(type_set_t *set,
 	}
 
         if (*add == 0) {
-                ebitmap_set_bit(&set->negset, t->value - 1, TRUE);
+                if (ebitmap_set_bit(&set->negset, t->value - 1, TRUE)) 
+			goto oom;
         }
         else {
-                ebitmap_set_bit(&set->types, t->value - 1, TRUE);
+                if (ebitmap_set_bit(&set->types, t->value - 1, TRUE))
+			goto oom;
         }
 	free(id);
 	*add = 1;
 	return 0;
+oom:
+	yyerror("Out of memory");
+	free(id);
+	return -1;
 }
 
 static int define_compute_type_helper(int which, avrule_t **rule)
@@ -1992,7 +2001,10 @@ static int define_compute_type_helper(in
 			yyerror(errormsg);
 			goto bad;
 		}
-		ebitmap_set_bit(&tclasses, cladatum->value - 1, TRUE);
+		if (ebitmap_set_bit(&tclasses, cladatum->value - 1, TRUE)) {
+			yyerror("Out of memory");
+			goto bad;
+		}
 		free(id);
 	}
 
@@ -2248,7 +2260,11 @@ static int define_te_avtab_helper(int wh
 			ret = -1;
 			goto out;
 		}
-		ebitmap_set_bit(&tclasses, cladatum->value - 1, TRUE);	
+		if (ebitmap_set_bit(&tclasses, cladatum->value - 1, TRUE)) {
+			yyerror("Out of memory");
+			ret = -1;
+			goto out;
+		}
 		free(id);
 	}
 
@@ -2462,17 +2478,22 @@ static int dominate_role_recheck(hashtab
 		/* raise types and dominates from dominated role */
 		ebitmap_for_each_bit(&rdp->dominates, node, i) {
 			if (ebitmap_node_get_bit(node, i))
-				ebitmap_set_bit(&rdatum->dominates, i, TRUE);
+				if (ebitmap_set_bit(&rdatum->dominates, i, TRUE)) 
+					goto oom;
 		}
 		ebitmap_for_each_bit(&types, node, i) {
 			if (ebitmap_node_get_bit(node, i))
-				ebitmap_set_bit(&rdatum->types.types, i, TRUE);
+				if (ebitmap_set_bit(&rdatum->types.types, i, TRUE))
+					goto oom;
 		}		
 		ebitmap_destroy(&types);
 	}
 
 	/* go through all the roles */
 	return 0;
+oom:
+	yyerror("Out of memory");
+	return -1;
 }
 
 static role_datum_t *
@@ -2506,7 +2527,10 @@ static role_datum_t *
 			return NULL;
 		}
 		memset(role, 0, sizeof(role_datum_t));
-		ebitmap_set_bit(&role->dominates, role->value-1, TRUE);
+		if (ebitmap_set_bit(&role->dominates, role->value-1, TRUE)) {
+                        yyerror("Out of memory!");
+                        goto cleanup;
+		}
 		ret = declare_symbol(SYM_ROLES, (hashtab_key_t) role_id, (hashtab_datum_t) role, &role->value, &role->value);
                 switch(ret) {
                 case -3: {
@@ -2535,7 +2559,8 @@ static role_datum_t *
 		ebitmap_init(&types);
 		ebitmap_for_each_bit(&r->dominates, node, i) {
 			if (ebitmap_node_get_bit(node, i))
-				ebitmap_set_bit(&role->dominates, i, TRUE);
+				if (ebitmap_set_bit(&role->dominates, i, TRUE))
+					goto oom;
 		}
 		if (type_set_expand(&r->types, &types, policydbp, 1)) {
 			ebitmap_destroy(&types);
@@ -2543,7 +2568,8 @@ static role_datum_t *
 		}
 		ebitmap_for_each_bit(&types, node, i) {
 			if (ebitmap_node_get_bit(node, i))
-				ebitmap_set_bit(&role->types.types, i, TRUE);
+				if (ebitmap_set_bit(&role->types.types, i, TRUE))
+					goto oom;
 		}
 		ebitmap_destroy(&types);
 		if (!r->value) {
@@ -2565,6 +2591,9 @@ static role_datum_t *
         role_datum_destroy(role);
         free(role);
         return NULL;
+oom:
+	yyerror("Out of memory");
+	goto cleanup;
 }
 
 static int role_val_to_name_helper(hashtab_key_t key, hashtab_datum_t datum, void *p)
@@ -2624,7 +2653,11 @@ static int set_roles(role_set_t *set,
 		return -1;
 	}
 
-        ebitmap_set_bit(&set->roles, r->value - 1, TRUE);
+        if (ebitmap_set_bit(&set->roles, r->value - 1, TRUE)) {
+		yyerror("out of memory");
+		free(id);
+		return -1;
+	}
 	free(id);
 	return 0;
 }
@@ -3517,10 +3550,14 @@ static int set_user_roles(role_set_t *se
 	/* set the role and every role it dominates */
 	ebitmap_for_each_bit(&r->dominates, node, i) {
 		if (ebitmap_node_get_bit(node, i))
-			ebitmap_set_bit(&set->roles, i, TRUE);
+			if (ebitmap_set_bit(&set->roles, i, TRUE))
+				goto oom;
 	}
 	free(id);
 	return 0;
+oom:
+	yyerror("out of memory");
+	return -1;
 }
 
 

--=-kgJvtQ85Ci6oTTMT7IqR--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
