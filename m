From: "Frank Mayer" <mayerf@tresys.com>
To: <SELinux@tycho.nsa.gov>
Subject: setools patch
Date: Tue, 19 Aug 2003 13:29:58 -0400
Message-ID: <002a01c36677$8630eac0$8100a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002B_01C36655.FF1F4AC0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_002B_01C36655.FF1F4AC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Attached is a patch to our selinux tools (setools) package.  It fixes =
two
issues:

1. Fixes problem handling type aliases noted by Carsten Grohmann.

2. Updates the core library to handle policy version 15 files (as used =
with the
new 2.6 kernel).  As always, this library should remain backward =
compatible with
older policy versions too.

This patch is for release 20030609 of setools (the source of which can =
be found
at wwww.tresys.com/selinux among other places).

Just as a heads up we're planning to release a new version in September =
that
will add more analysis capabilities for apol (such as information flow =
analysis,
and more domain transition analysis), plus various minor stuff. =20

Regards, Frank

------=_NextPart_000_002B_01C36655.FF1F4AC0
Content-Type: application/octet-stream;
	name="setools-20030609a.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setools-20030609a.patch"

diff -ruN --exclude CVS setools/ChangeLog-setools =
setools-cur/ChangeLog-setools=0A=
--- setools/ChangeLog-setools	2003-06-09 09:01:54.000000000 -0400=0A=
+++ setools-cur/ChangeLog-setools	2003-08-18 14:47:45.798856608 -0400=0A=
@@ -1,6 +1,13 @@=0A=
 CHANGE LOG, SE Linux TOOLS (setools)=0A=
 =0A=
 =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A=
+August 18, 2003 SE Linux Tools, Release 20030609a=0A=
+=0A=
+Libapol:=0A=
+	Fixed alias bug.=0A=
+	Added support for v15 policy files.=0A=
+=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=0A=
 June 9, 2003 SE Linux Tools, Release 20030609=0A=
 =0A=
 Apol:=0A=
diff -ruN --exclude CVS setools/libapol/apolicy_parse.y =
setools-cur/libapol/apolicy_parse.y=0A=
--- setools/libapol/apolicy_parse.y	2003-04-01 16:37:08.000000000 -0500=0A=
+++ setools-cur/libapol/apolicy_parse.y	2003-08-18 13:40:59.000000000 =
-0400=0A=
@@ -126,7 +126,7 @@=0A=
 static int define_port_context(int ver);=0A=
 static int define_netif_context(int ver);=0A=
 static int define_node_context(int ver);=0A=
-static int define_fs_use(int behavior);=0A=
+static int define_fs_use(int behavior, int ver);=0A=
 static int define_genfs_context(int has_type);=0A=
 static int define_nfs_context(void);=0A=
 %}=0A=
@@ -164,7 +164,7 @@=0A=
 %token TARGET=0A=
 %token SAMEUSER=0A=
 %token FSCON PORTCON NETIFCON NODECON =0A=
-%token FSUSEPSID FSUSETASK FSUSETRANS=0A=
+%token FSUSEPSID FSUSETASK FSUSETRANS FSUSEXATTR=0A=
 %token GENFSCON=0A=
 %token U1 U2 R1 R2 T1 T2=0A=
 %token NOT AND OR =0A=
@@ -524,12 +524,15 @@=0A=
                         | fs_uses fs_use_def=0A=
                         ;=0A=
 /* added Jul 2002 */=0A=
+/* changed Jul 2003; added FSUSEXATTR */=0A=
 fs_use_def              : FSUSEPSID identifier ';' =0A=
-                        {if (define_fs_use(0)) return -1;}=0A=
+                        {if (define_fs_use(0, POL_VER_JUL2002)) return =
-1;}=0A=
+                        | FSUSEXATTR identifier security_context_def ';'=0A=
+                        {if (define_fs_use(1, POL_VER_15)) return -1;}=0A=
                         | FSUSETASK identifier security_context_def ';'=0A=
-                        {if (define_fs_use(1)) return -1;}=0A=
+                        {if (define_fs_use(1, POL_VER_JUL2002)) return =
-1;}=0A=
                         | FSUSETRANS identifier security_context_def ';'=0A=
-                        {if (define_fs_use(1)) return -1;}=0A=
+                        {if (define_fs_use(1, POL_VER_JUL2002)) return =
-1;}=0A=
                         ; =0A=
 /* added Jul 2002 */                       =0A=
 opt_genfs_contexts      : genfs_contexts=0A=
@@ -2271,11 +2274,12 @@=0A=
 }=0A=
 =0A=
 /* added Jul 2002 */=0A=
-static int define_fs_use(int behavior)=0A=
+/* changed Jul 2003; added FSUSEXATTR */=0A=
+static int define_fs_use(int behavior, int ver)=0A=
 {=0A=
 	int rt;=0A=
 	=0A=
-	rt =3D set_policy_version(POL_VER_JUL2002, policy);=0A=
+	rt =3D set_policy_version(ver, policy);=0A=
 	if(rt !=3D 0) {=0A=
 		if(rt =3D=3D -2) {=0A=
 			yyerror("fs_use keyword (FSUSE*) in what appears to be a pre-July =
2002 policy)");=0A=
diff -ruN --exclude CVS setools/libapol/apolicy_scan.l =
setools-cur/libapol/apolicy_scan.l=0A=
--- setools/libapol/apolicy_scan.l	2002-09-26 16:35:28.000000000 -0400=0A=
+++ setools-cur/libapol/apolicy_scan.l	2003-08-18 13:40:59.000000000 =
-0400=0A=
@@ -100,6 +100,8 @@=0A=
 FS_USE_TASK                     {return(FSUSETASK);}=0A=
 fs_use_trans |=0A=
 FS_USE_TRANS                    {return(FSUSETRANS);}=0A=
+fs_use_xattr |=0A=
+FS_USE_XATTR                     {return(FSUSEXATTR);}=0A=
 genfscon |=0A=
 GENFSCON                        { return(GENFSCON);}=0A=
 r1 |=0A=
diff -ruN --exclude CVS setools/libapol/apol_tcl.c =
setools-cur/libapol/apol_tcl.c=0A=
--- setools/libapol/apol_tcl.c	2003-05-29 08:50:26.000000000 -0400=0A=
+++ setools-cur/libapol/apol_tcl.c	2003-08-18 13:40:59.000000000 -0400=0A=
@@ -894,6 +894,9 @@=0A=
 	/* case POL_VER_12: */ /* (currently synonmous with v.11 */=0A=
 		Tcl_AppendResult(interp, POL_VER_STRING_11, (char *) NULL);=0A=
 		break;=0A=
+	case POL_VER_15:=0A=
+		Tcl_AppendResult(interp, POL_VER_STRING_15, (char *) NULL);=0A=
+		break;=0A=
 	default:=0A=
 		Tcl_AppendResult(interp, "Unkown version", (char *) NULL);=0A=
 		break;=0A=
diff -ruN --exclude CVS setools/libapol/policy-avl.c =
setools-cur/libapol/policy-avl.c=0A=
--- setools/libapol/policy-avl.c	2003-03-12 16:27:44.000000000 -0500=0A=
+++ setools-cur/libapol/policy-avl.c	2003-08-18 13:35:44.000000000 -0400=0A=
@@ -57,21 +57,8 @@=0A=
 /* Compare support function for TYPES to use with avl-utils */=0A=
 int type_compare(const char *key, int idx, policy_t *policy)=0A=
 {=0A=
-	int cmpval;=0A=
-	name_item_t *ptr;=0A=
-	=0A=
 	assert(!(key =3D=3D NULL || policy =3D=3D NULL || =
!is_valid_type_idx(idx, policy)));=0A=
-	cmpval =3D strcasecmp(key, policy->types[idx].name);=0A=
-	if(cmpval !=3D 0) {=0A=
-		/* FIX: for now aliases are just unsorted attached linked list;=0A=
-		 * low priority since they are rare */		=0A=
-		/* check aliases */=0A=
-		for(ptr =3D policy->types[idx].aliases; ptr !=3D NULL; ptr =3D =
ptr->next) {=0A=
-			if(strcasecmp(ptr->name, key) =3D=3D 0)=0A=
-				return 0; /* found via alias */=0A=
-		}=0A=
-	}=0A=
-	return cmpval;=0A=
+	return strcasecmp(key, policy->types[idx].name);=0A=
 }=0A=
 /* ATTRIB comp function*/=0A=
 int attrib_compare(const char *key, int idx, policy_t *policy)=0A=
diff -ruN --exclude CVS setools/libapol/policy.c =
setools-cur/libapol/policy.c=0A=
--- setools/libapol/policy.c	2003-04-10 09:23:22.000000000 -0400=0A=
+++ setools-cur/libapol/policy.c	2003-08-18 13:40:59.000000000 -0400=0A=
@@ -70,7 +70,16 @@=0A=
 	}=0A=
 	policy->list_sz[POL_LIST_TYPE] =3D LIST_SZ;=0A=
 	policy->num_types =3D 0;=0A=
-=0A=
+	=0A=
+	/* type aliases */=0A=
+	policy->aliases =3D (alias_item_t *)malloc(sizeof(type_item_t) * =
LIST_SZ);=0A=
+	if(policy->aliases =3D=3D NULL) {=0A=
+		fprintf(stderr, "out of memory\n");=0A=
+		return -1;=0A=
+	}=0A=
+	policy->list_sz[POL_LIST_ALIAS] =3D LIST_SZ;=0A=
+	policy->num_aliases =3D 0;=0A=
+	=0A=
 	/* type attributes list */=0A=
 	policy->attribs =3D (attrib_item_t *)malloc(sizeof(attrib_item_t) * =
LIST_SZ);=0A=
 	if(policy->attribs =3D=3D NULL) {=0A=
@@ -177,6 +186,10 @@=0A=
 		/* fprintf(stdout, "Policy version appears to be Pre July 2002\n");*/=0A=
 		break;=0A=
 	case POL_VER_JUL2002:=0A=
+		if(policy->version > POL_VER_JUL2002)=0A=
+		/* if we have a greater version, just go on */=0A=
+			return 0;=0A=
+=0A=
 		if(policy->version !=3D POL_VER_UNKNOWN ) {=0A=
 			return -3;=0A=
 		}=0A=
@@ -299,8 +312,18 @@=0A=
 		free(policy->types);=0A=
 	}=0A=
 =0A=
+	/* type aliases list */=0A=
+	/* NOTE: while we still have the name list for attributes associated =
with =0A=
+	 * the types, the alias names in the alias list will be freed above in =
the=0A=
+	 * types area and we do not need to free them again */=0A=
+	if(policy->aliases !=3D NULL) {=0A=
+		free(policy->aliases);=0A=
+	} =0A=
+	=0A=
+=0A=
 	/* type attributes list */=0A=
 	free_attrib_list(policy->attribs, policy->num_attribs);=0A=
+	=0A=
 =0A=
 	/* av_access rules */=0A=
 	if(policy->av_access !=3D NULL) {=0A=
@@ -401,6 +424,24 @@=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/* check if TYPE ALIAS array has room for new entry, grow if necessary =
*/=0A=
+int check_alias_array(policy_t *policy)=0A=
+{=0A=
+	assert(policy !=3D NULL);=0A=
+	if (policy->num_aliases >=3D policy->list_sz[POL_LIST_ALIAS]) {=0A=
+		/* grow the dynamic array */=0A=
+		alias_item_t * ptr;=0A=
+		ptr =3D (alias_item_t *)realloc(policy->aliases, =
(LIST_SZ+policy->list_sz[POL_LIST_ALIAS]) * sizeof(alias_item_t));=0A=
+		if(ptr =3D=3D NULL) {=0A=
+			fprintf(stderr, "out of memory\n");=0A=
+			return -1;=0A=
+		}=0A=
+		policy->aliases =3D ptr;=0A=
+		policy->list_sz[POL_LIST_ALIAS] +=3D LIST_SZ;=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /* check if ATTRIB array has room for new entry, grow if necessary */=0A=
 int check_attrib_array(policy_t *policy)=0A=
 {=0A=
@@ -474,6 +515,19 @@=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/* check the alias array to see if name matches and if so return the =
associated=0A=
+ * type idx */=0A=
+int get_type_idx_by_alias_name(const char *alias, policy_t *policy)=0A=
+{=0A=
+	int i;=0A=
+	if(alias =3D=3D NULL || policy =3D=3D NULL)=0A=
+		return -1;=0A=
+	for(i =3D 0; i < policy->num_aliases; i++) {=0A=
+		if(strcasecmp(alias, policy->aliases[i].name) =3D=3D 0) =0A=
+			return policy->aliases[i].type;=0A=
+	} =0A=
+	return -1;=0A=
+}=0A=
 =0A=
 =0A=
 int get_type_idx(char *name, policy_t *policy)=0A=
@@ -481,13 +535,22 @@=0A=
 #ifndef USE_SORTING=0A=
 	int i;=0A=
 	name_item_t *ptr;=0A=
+#else	=0A=
+	int rt, rt2;=0A=
 #endif=0A=
 	if(name =3D=3D NULL || policy =3D=3D NULL)=0A=
 		return -1;=0A=
 =0A=
 #ifdef USE_SORTING=0A=
 	/* traverse the avl tree */=0A=
-	return avl_get_idx(name, policy->tree[AVL_TYPES].head, type_compare, =
get_type_subtree, policy);=0A=
+	rt =3D avl_get_idx(name, policy->tree[AVL_TYPES].head, type_compare, =
get_type_subtree, policy);=0A=
+	if(rt <0) {=0A=
+		/* check aliases for a match */=0A=
+		rt2 =3D get_type_idx_by_alias_name(name, policy);=0A=
+		if(rt2 >=3D0 )=0A=
+			return rt2;=0A=
+	}=0A=
+	return rt;		=0A=
 #else=0A=
 	for(i =3D 0; i < policy->num_types; i++)	{=0A=
 		if(strcasecmp(policy->types[i].name, name) =3D=3D 0)=0A=
@@ -503,6 +566,9 @@=0A=
 =0A=
 }=0A=
 =0A=
+=0A=
+=0A=
+=0A=
 /* this is an INTERNAL function only; allows direct access to type name =
string=0A=
  * stored within the policy db.  This function shouldn't be exported as =
a caller=0A=
  * could corrupt the db.  It is used internally within the policy.c =
file for=0A=
@@ -775,12 +841,37 @@=0A=
 =0A=
 int add_alias(int type_idx, char *alias, policy_t *policy)=0A=
 {=0A=
+	int idx;=0A=
 	if(!is_valid_type_idx(type_idx, policy) || alias =3D=3D NULL || policy =
=3D=3D NULL)=0A=
 		return -1;=0A=
 =0A=
+	/* TODO: we have a problem with the way we handle aliases once AVL =
trees were added.=0A=
+	 *	since the AVL trees are sorted by type name, the alias search =
doesn't work=0A=
+	 *	(since an aliases is checked only if the type name doesn't match, =
but since we have=0A=
+	 * 	an efficient type name tree, not all types (and therefore aliases) =
are searched.=0A=
+	 *	What we've done for now is maintain a separate alias array while =
still maintaining=0A=
+	 *	the old alias name list attached to each type.  The alias array =
will allow us to search=0A=
+	 *	for a type using its alias name if it wasn't found via the AVL =
search using prime=0A=
+	 *	type names.  Eventually we need to remove the name list and use =
references to the=0A=
+	 *	alias array.=0A=
+	 *=0A=
+	 *	This is currently fragile as we don't check for syntax problems =
arising from the using=0A=
+	 * 	the same alias twice (checkpolicy would not allow this).=0A=
+	 */=0A=
+	/* first the simple name list */=0A=
 	if(add_name(alias, &(policy->types[type_idx].aliases)) !=3D 0) {=0A=
 		return -1;			=0A=
 	}=0A=
+	/* and now the alias array; add_name also uses the memory for the =
name, so we need to be=0A=
+	 * careful on free */=0A=
+	if(check_alias_array(policy) !=3D 0) =0A=
+		return -1;=0A=
+	=0A=
+	idx =3D policy->num_aliases;=0A=
+	policy->aliases[idx].name =3D alias;=0A=
+	policy->aliases[idx].type =3D type_idx;=0A=
+	(policy->num_aliases)++;=0A=
+=0A=
 	return 0;=0A=
 }=0A=
 =0A=
diff -ruN --exclude CVS setools/libapol/policy.h =
setools-cur/libapol/policy.h=0A=
--- setools/libapol/policy.h	2003-03-13 11:43:52.000000000 -0500=0A=
+++ setools-cur/libapol/policy.h	2003-08-18 13:42:41.000000000 -0400=0A=
@@ -249,6 +249,12 @@=0A=
 } user_list_t;=0A=
 =0A=
 =0A=
+/* type alias array=0A=
+ * TODO: see comments in add_alias() in policy.c */=0A=
+typedef struct alias_item {=0A=
+	char			*name;=0A=
+	int			type;	/* assoicated type */=0A=
+} alias_item_t;=0A=
 =0A=
 /* IDs for DYNAMIC array only  (e.g., clones is not a dynamic array, =
but rather a linked list*/=0A=
 #define POL_LIST_TYPE		0=0A=
@@ -262,7 +268,8 @@=0A=
 #define POL_LIST_PERMS		8=0A=
 #define POL_LIST_COMMON_PERMS	9=0A=
 #define POL_LIST_OBJ_CLASSES	10=0A=
-#define POL_NUM_LISTS		11=0A=
+#define POL_LIST_ALIAS		11=0A=
+#define POL_NUM_LISTS		12=0A=
 =0A=
 =0A=
 =0A=
@@ -282,10 +289,12 @@=0A=
 #define POL_VER_JUL2002		2	/* all version after Jul 2002 until next =
date */=0A=
 #define POL_VER_11		2	/* same as POL_VER_JUL2002 */=0A=
 #define POL_VER_12		2	/* same as POL_VER_JUL2002; no apparent syntax =
changes b/w 11 and 12 */=0A=
-#define POL_VER_MAX		2=0A=
+#define POL_VER_15		3	/* somewhere between v 12 and 15! */=0A=
+#define POL_VER_MAX		3=0A=
 =0A=
 #define POL_VER_STRING_PRE_11 	"prior to v. 11"=0A=
 #define POL_VER_STRING_11	"v.11 -- v.12"=0A=
+#define POL_VER_STRING_15	"v.13 -- v.15"=0A=
 =0A=
 =0A=
 =0A=
@@ -303,6 +312,7 @@=0A=
 	int 	num_perms;		/* " " */=0A=
 	int	num_common_perms;=0A=
 	int	num_obj_classes;=0A=
+	int	num_aliases;=0A=
 	int 	rule_cnt[RULE_MAX];	/* statics on # of various rules */=0A=
 	int	list_sz[POL_NUM_LISTS]; /* keep track of dynamic array sizes */=0A=
 #ifdef USE_SORTING=0A=
@@ -316,6 +326,7 @@=0A=
 	obj_class_t	*obj_classes;	/* define objects and their perms (ARRAY) */=0A=
 /* Type Enforcement Rules */=0A=
 	type_item_t 	*types;    	/* defined types and their attribs (ARRAY)*/=0A=
+	alias_item_t	*aliases;	/* separate index into type aliases (ARRAY) */=0A=
 	attrib_item_t 	*attribs;	/* defined attribs and their types (ARRAY)*/=0A=
 	av_item_t	*av_access;	/* allow and neverallow rules; we expect lots of =
these (ARRAY)*/=0A=
 	av_item_t	*av_audit;	/* audit and notify rules (ARRAY)*/=0A=
@@ -375,6 +386,7 @@=0A=
 int init_policy( policy_t **policy_ptr);=0A=
 int free_policy(policy_t **policy_ptr);=0A=
 int get_type_idx(char *name, policy_t *policy);=0A=
+int get_type_idx_by_alias_name(const char *alias, policy_t *policy);=0A=
 int get_attrib_idx(char *name, policy_t *policy);=0A=
 int get_type_or_attrib_idx(char *name, int *idx_type, policy_t *policy);=0A=
 int get_role_name(int idx, char **name, policy_t *policy);=0A=
diff -ruN --exclude CVS setools/libapol/util.h setools-cur/libapol/util.h=0A=
--- setools/libapol/util.h	2003-05-29 12:32:02.000000000 -0400=0A=
+++ setools-cur/libapol/util.h	2003-08-18 14:49:11.416840696 -0400=0A=
@@ -15,7 +15,7 @@=0A=
 #include <stdlib.h>=0A=
 #include "policy.h"=0A=
 =0A=
-#define VERSION_STRING "0.7.1"=0A=
+#define VERSION_STRING "0.7.1a"=0A=
 =0A=
 /* generic link list structures */=0A=
 typedef struct llist_node {=0A=

------=_NextPart_000_002B_01C36655.FF1F4AC0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
