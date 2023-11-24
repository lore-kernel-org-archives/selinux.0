Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jurajmarcin.com header.i=juraj@jurajmarcin.com header.b="USRa7bdr"
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73967D44
	for <selinux@vger.kernel.org>; Fri, 24 Nov 2023 04:14:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700828080; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=cfeouj0S/hVdJUsmdeqZ+QuQ2bh9EHJG8YoD1+OF0dNIkhNJWVQrahnuU6eNz9J7VjJSfjSqW/no5XNESr7lLmU1vymfQ7AumszMzUanKAizc0ryjsxdEqHiEXiy66CyPSsqSnTIwVoIzmx4+JB93ZPY5bkD7v0mLefx3Zra5NQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1700828080; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=14TTpb6ZzKSLWQPU9356vyWBHgHKfuUFUBfdnhivpG0=; 
	b=AZ/ChjH4J74DFM6IdQn67sS/pHu4hwB3s58qrna6NjiJZf0vfLO3e/qKw7b9sSUE+IwbONBbw+406C1cqH75nYoKZ9aOSIyx9DU+DcaZAhJpeVarJWt9cyMgWpt5XCmbYahLl/eM+ern3aHkLHentV4VYybPiGkd936BXlqeJDg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=jurajmarcin.com;
	spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
	dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700828080;
	s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=14TTpb6ZzKSLWQPU9356vyWBHgHKfuUFUBfdnhivpG0=;
	b=USRa7bdrrHg8fhiTkSoMrvyB1EHi49f7KMy8s5W0fv+sw1AfEgh3JvGtr67proM8
	G3tHm7AHKROwBMgA3KzxDk2iQhlN+Wb375W1XVoNOjfU3/XVxoCkb5wmhvoLLWtMq0N
	uYt92XY0ca2pcrdl5zhlNXEXoEis9jphmuYiIt4o=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
	with SMTPS id 1700828078194865.9924520373728; Fri, 24 Nov 2023 13:14:38 +0100 (CET)
Received: from jmarcin-t14s-01.redhat.com (unknown [86.49.236.63])
	by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 56ECA20890FD;
	Fri, 24 Nov 2023 12:14:36 +0000 (UTC)
From: Juraj Marcin <juraj@jurajmarcin.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v5] checkpolicy,libsepol: add prefix/suffix matching to filename type transitions
Date: Fri, 24 Nov 2023 13:14:03 +0100
Message-ID: <20231124121405.3268465-1-juraj@jurajmarcin.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, filename transitions are stored separately from other type
enforcement rules and only support exact name matching. However, in
practice, the names contain variable parts. This leads to many
duplicated rules in the policy that differ only in the part of the name,
or it is even impossible to cover all possible combinations.

This patch implements the equivalent changes made by this kernel
patch [1].

This patch updates the policydb structure to contain prefix and suffix
filename transition tables along normal filename transitions table and
updates the code that accesses those tables. Furthermore, it adds
match_type attribute to module and CIL structures that store filename
transitions and updates functions that parse conf and CIL policy files.

This patch does not significantly change the binary policy size when
prefix/suffix rules are not used. In addition, with prefix/suffix rules,
the number of filename transitions can be reduced, and therefore also
binary policy size can be reduced.

Syntax of the new prefix/suffix filename transition rule:

    type_transition source_type target_type : class default_type object_n=
ame match_type;

    (typetransition source_type_id target_type_id class_id object_name ma=
tch_type default_type_id)

where match_type is either keyword "prefix" or "suffix"

Examples:

    type_transition ta tb:CLASS01 tc "file01" prefix;
    type_transition td te:CLASS01 tf "file02" suffix;

    (typetransition ta tb CLASS01 "file01" prefix td)
    (typetransition td te CLASS01 "file02" suffix tf)

In the kernel, the rules have the following order of priority, if no
matching rule is found, the code moves on to the next category:
- exact filename transitions,
- prefix filename transitions in the order of the longest prefix match,
- suffix filename transitions in the order of the longest suffix match.
This ensures the compatibility with older policies.

[1]: https://lore.kernel.org/selinux/20231121122719.2332137-1-juraj@juraj=
marcin.com/

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
v5:
- rebased to the latest main, fixed conflicts in libsepol/cil

v4:
- rebased to the latest main, fixed conflicts in policydb_validate.c
- added syntax tests to checkpolicy and secilc as proposed by Christian
- retested with more test cases

v3:
- reworked the solution from scratch, this time only adding the
  prefix/suffix matching feature without moving filename transition
  rules to the avtab
---
 checkpolicy/policy_define.c                   |   7 +-
 checkpolicy/policy_define.h                   |   2 +-
 checkpolicy/policy_parse.y                    |  13 ++-
 checkpolicy/policy_scan.l                     |   4 +
 checkpolicy/test/dismod.c                     |  14 ++-
 checkpolicy/test/dispol.c                     |  26 ++++-
 checkpolicy/tests/policy_allonce.conf         |   2 +
 .../tests/policy_allonce.expected.conf        |   8 ++
 .../tests/policy_allonce.expected_opt.conf    |   8 ++
 checkpolicy/tests/policy_allonce_mls.conf     |   2 +
 .../tests/policy_allonce_mls.expected.conf    |   8 ++
 .../policy_allonce_mls.expected_opt.conf      |   8 ++
 libsepol/cil/src/cil.c                        |   6 ++
 libsepol/cil/src/cil_binary.c                 |   8 +-
 libsepol/cil/src/cil_build_ast.c              |  29 ++++-
 libsepol/cil/src/cil_copy_ast.c               |   1 +
 libsepol/cil/src/cil_internal.h               |   4 +
 libsepol/cil/src/cil_policy.c                 |  17 ++-
 libsepol/cil/src/cil_resolve_ast.c            |  12 +++
 libsepol/cil/src/cil_write_ast.c              |   2 +
 libsepol/include/sepol/policydb/policydb.h    |  23 +++-
 libsepol/src/expand.c                         |  17 ++-
 libsepol/src/kernel_to_cil.c                  |  36 ++++++-
 libsepol/src/kernel_to_conf.c                 |  36 ++++++-
 libsepol/src/link.c                           |   1 +
 libsepol/src/module_to_cil.c                  |  21 +++-
 libsepol/src/policydb.c                       | 100 ++++++++++++++----
 libsepol/src/policydb_validate.c              |  26 ++++-
 libsepol/src/write.c                          |  67 +++++++++---
 secilc/test/policy.cil                        |   4 +
 30 files changed, 442 insertions(+), 70 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 260e609d..fb8325ee 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -3159,7 +3159,7 @@ avrule_t *define_cond_filename_trans(void)
 	return COND_ERR;
 }
=20
-int define_filename_trans(void)
+int define_filename_trans(uint32_t match_type)
 {
 	char *id, *name =3D NULL;
 	type_set_t stypes, ttypes;
@@ -3261,7 +3261,7 @@ int define_filename_trans(void)
 			ebitmap_for_each_positive_bit(&e_ttypes, tnode, t) {
 				rc =3D policydb_filetrans_insert(
 					policydbp, s+1, t+1, c+1, name,
-					NULL, otype, NULL
+					NULL, otype, match_type, NULL
 				);
 				if (rc !=3D SEPOL_OK) {
 					if (rc =3D=3D SEPOL_EEXIST) {
@@ -3279,7 +3279,7 @@ int define_filename_trans(void)
 			if (self) {
 				rc =3D policydb_filetrans_insert(
 					policydbp, s+1, s+1, c+1, name,
-					NULL, otype, NULL
+					NULL, otype, match_type, NULL
 				);
 				if (rc !=3D SEPOL_OK) {
 					if (rc =3D=3D SEPOL_EEXIST) {
@@ -3317,6 +3317,7 @@ int define_filename_trans(void)
 		ftr->tclass =3D c + 1;
 		ftr->otype =3D otype;
 		ftr->flags =3D self ? RULE_SELF : 0;
+		ftr->match_type =3D match_type;
 	}
=20
 	free(name);
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 075b048d..05869346 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -57,7 +57,7 @@ int define_role_trans(int class_specified);
 int define_role_types(void);
 int define_role_attr(void);
 int define_roleattribute(void);
-int define_filename_trans(void);
+int define_filename_trans(uint32_t match_type);
 int define_sens(void);
 int define_te_avtab(int which);
 int define_te_avtab_extended_perms(int which);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 356626e2..ee4be4ea 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -153,6 +153,7 @@ typedef int (* require_func_t)(int pass);
 %token FILESYSTEM
 %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
 %token LOW_HIGH LOW HIGH GLBLUB
+%token PREFIX SUFFIX
=20
 %left OR
 %left XOR
@@ -410,6 +411,12 @@ cond_rule_def           : cond_transition_def
 			{ $$ =3D NULL; }
                         ;
 cond_transition_def	: TYPE_TRANSITION names names ':' names identifier f=
ilename ';'
+                        { $$ =3D define_cond_filename_trans() ;
+                          if ($$ =3D=3D COND_ERR) return -1;}
+			| TYPE_TRANSITION names names ':' names identifier filename PREFIX ';=
'
+                        { $$ =3D define_cond_filename_trans() ;
+                          if ($$ =3D=3D COND_ERR) return -1;}
+			| TYPE_TRANSITION names names ':' names identifier filename SUFFIX ';=
'
                         { $$ =3D define_cond_filename_trans() ;
                           if ($$ =3D=3D COND_ERR) return -1;}
 			| TYPE_TRANSITION names names ':' names identifier ';'
@@ -449,7 +456,11 @@ cond_dontaudit_def	: DONTAUDIT names names ':' names=
 names ';'
 		        ;
 			;
 transition_def		: TYPE_TRANSITION  names names ':' names identifier file=
name ';'
-			{if (define_filename_trans()) return -1; }
+			{if (define_filename_trans(FILENAME_TRANS_MATCH_EXACT)) return -1; }
+			| TYPE_TRANSITION  names names ':' names identifier filename PREFIX '=
;'
+			{if (define_filename_trans(FILENAME_TRANS_MATCH_PREFIX)) return -1; }
+			| TYPE_TRANSITION  names names ':' names identifier filename SUFFIX '=
;'
+			{if (define_filename_trans(FILENAME_TRANS_MATCH_SUFFIX)) return -1; }
 			| TYPE_TRANSITION names names ':' names identifier ';'
                         {if (define_compute_type(AVRULE_TRANSITION)) ret=
urn -1;}
                         | TYPE_MEMBER names names ':' names identifier '=
;'
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index c998ff8b..0780ef15 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -270,6 +270,10 @@ low |
 LOW				{ return(LOW); }
 glblub |
 GLBLUB				{ return(GLBLUB); }
+PREFIX |
+prefix				{ return(PREFIX); }
+SUFFIX |
+suffix				{ return(SUFFIX); }
 "/"[^ \n\r\t\f]*	        { return(PATH); }
 \""/"[^\"\n]*\" 		{ return(QPATH); }
 \"[^"/"\"\n]+\"	{ return(FILENAME); }
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 9f4a669b..931af9da 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -571,13 +571,25 @@ static void display_role_allow(role_allow_rule_t * =
ra, policydb_t * p, FILE * fp
=20
 static void display_filename_trans(filename_trans_rule_t * tr, policydb_=
t * p, FILE * fp)
 {
+	const char *match_str =3D "";
 	fprintf(fp, "filename transition");
 	for (; tr; tr =3D tr->next) {
 		display_type_set(&tr->stypes, 0, p, fp);
 		display_type_set(&tr->ttypes, 0, p, fp);
 		display_id(p, fp, SYM_CLASSES, tr->tclass - 1, ":");
 		display_id(p, fp, SYM_TYPES, tr->otype - 1, "");
-		fprintf(fp, " %s\n", tr->name);
+		switch (tr->match_type) {
+		case FILENAME_TRANS_MATCH_EXACT:
+			match_str =3D "";
+			break;
+		case FILENAME_TRANS_MATCH_PREFIX:
+			match_str =3D " prefix";
+			break;
+		case FILENAME_TRANS_MATCH_SUFFIX:
+			match_str =3D " suffix";
+			break;
+		}
+		fprintf(fp, " %s%s\n", tr->name, match_str);
 	}
 }
=20
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 944ef7ec..d53462c5 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -458,6 +458,7 @@ static void display_role_trans(policydb_t *p, FILE *f=
p)
=20
 struct filenametr_display_args {
 	policydb_t *p;
+	uint32_t match_type;
 	FILE *fp;
 };
=20
@@ -472,6 +473,19 @@ static int filenametr_display(hashtab_key_t key,
 	FILE *fp =3D args->fp;
 	ebitmap_node_t *node;
 	uint32_t bit;
+	const char *match_str =3D "";
+
+	switch (args->match_type) {
+	case FILENAME_TRANS_MATCH_EXACT:
+		match_str =3D "";
+		break;
+	case FILENAME_TRANS_MATCH_PREFIX:
+		match_str =3D " prefix";
+		break;
+	case FILENAME_TRANS_MATCH_SUFFIX:
+		match_str =3D " suffix";
+		break;
+	}
=20
 	do {
 		ebitmap_for_each_positive_bit(&ftdatum->stypes, node, bit) {
@@ -479,7 +493,7 @@ static int filenametr_display(hashtab_key_t key,
 			display_id(p, fp, SYM_TYPES, ft->ttype - 1, "");
 			display_id(p, fp, SYM_CLASSES, ft->tclass - 1, ":");
 			display_id(p, fp, SYM_TYPES, ftdatum->otype - 1, "");
-			fprintf(fp, " %s\n", ft->name);
+			fprintf(fp, " %s%s\n", ft->name, match_str);
 		}
 		ftdatum =3D ftdatum->next;
 	} while (ftdatum);
@@ -495,7 +509,15 @@ static void display_filename_trans(policydb_t *p, FI=
LE *fp)
 	fprintf(fp, "filename_trans rules:\n");
 	args.p =3D p;
 	args.fp =3D fp;
-	hashtab_map(p->filename_trans, filenametr_display, &args);
+	args.match_type =3D FILENAME_TRANS_MATCH_EXACT;
+	hashtab_map(p->filename_trans[FILENAME_TRANS_MATCH_EXACT],
+		    filenametr_display, &args);
+	args.match_type =3D FILENAME_TRANS_MATCH_PREFIX;
+	hashtab_map(p->filename_trans[FILENAME_TRANS_MATCH_PREFIX],
+		    filenametr_display, &args);
+	args.match_type =3D FILENAME_TRANS_MATCH_SUFFIX;
+	hashtab_map(p->filename_trans[FILENAME_TRANS_MATCH_SUFFIX],
+		    filenametr_display, &args);
 }
=20
 static int menu(void)
diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/po=
licy_allonce.conf
index 34e6402d..fb0a0172 100644
--- a/checkpolicy/tests/policy_allonce.conf
+++ b/checkpolicy/tests/policy_allonce.conf
@@ -30,6 +30,8 @@ tunable TUNABLE1 false;
 tunable TUNABLE2 true;
 type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
 type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
";
+type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
" prefix;
+type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
" suffix;
 type_member TYPE1 TYPE2 : CLASS1 TYPE2;
 type_change TYPE1 TYPE2 : CLASS1 TYPE3;
 allow TYPE1 self : CLASS1 { PERM1 };
diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy=
/tests/policy_allonce.expected.conf
index 63739e1f..e3db7593 100644
--- a/checkpolicy/tests/policy_allonce.expected.conf
+++ b/checkpolicy/tests/policy_allonce.expected.conf
@@ -40,9 +40,17 @@ dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
 type_transition TYPE1 TYPE2:CLASS1 TYPE3;
 type_member TYPE1 TYPE2:CLASS1 TYPE2;
 type_change TYPE1 TYPE2:CLASS1 TYPE3;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
 if (BOOL1) {
 } else {
diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpo=
licy/tests/policy_allonce.expected_opt.conf
index 1c969961..94eaf37a 100644
--- a/checkpolicy/tests/policy_allonce.expected_opt.conf
+++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
@@ -40,9 +40,17 @@ dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
 type_transition TYPE1 TYPE2:CLASS1 TYPE3;
 type_member TYPE1 TYPE2:CLASS1 TYPE2;
 type_change TYPE1 TYPE2:CLASS1 TYPE3;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
 if (BOOL1) {
 } else {
diff --git a/checkpolicy/tests/policy_allonce_mls.conf b/checkpolicy/test=
s/policy_allonce_mls.conf
index c88616b3..2ba88a00 100644
--- a/checkpolicy/tests/policy_allonce_mls.conf
+++ b/checkpolicy/tests/policy_allonce_mls.conf
@@ -41,6 +41,8 @@ tunable TUNABLE1 false;
 tunable TUNABLE2 true;
 type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
 type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
";
+type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
" prefix;
+type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
" suffix;
 type_member TYPE1 TYPE2 : CLASS1 TYPE2;
 type_change TYPE1 TYPE2 : CLASS1 TYPE3;
 range_transition TYPE1 TYPE2 : CLASS1 s1:c0.c1;
diff --git a/checkpolicy/tests/policy_allonce_mls.expected.conf b/checkpo=
licy/tests/policy_allonce_mls.expected.conf
index 87c36f92..d390aac0 100644
--- a/checkpolicy/tests/policy_allonce_mls.expected.conf
+++ b/checkpolicy/tests/policy_allonce_mls.expected.conf
@@ -51,9 +51,17 @@ dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
 type_transition TYPE1 TYPE2:CLASS1 TYPE3;
 type_member TYPE1 TYPE2:CLASS1 TYPE2;
 type_change TYPE1 TYPE2:CLASS1 TYPE3;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
 range_transition TYPE1 TYPE2:CLASS1 s1:c0,c1 - s1:c0,c1;
 if (BOOL1) {
diff --git a/checkpolicy/tests/policy_allonce_mls.expected_opt.conf b/che=
ckpolicy/tests/policy_allonce_mls.expected_opt.conf
index 38176166..ef683070 100644
--- a/checkpolicy/tests/policy_allonce_mls.expected_opt.conf
+++ b/checkpolicy/tests/policy_allonce_mls.expected_opt.conf
@@ -51,9 +51,17 @@ dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
 type_transition TYPE1 TYPE2:CLASS1 TYPE3;
 type_member TYPE1 TYPE2:CLASS1 TYPE2;
 type_change TYPE1 TYPE2:CLASS1 TYPE3;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
 type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
 range_transition TYPE1 TYPE2:CLASS1 s1:c0,c1 - s1:c0,c1;
 if (BOOL1) {
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 067e28a6..bbfe6e62 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -97,6 +97,8 @@ char *CIL_KEY_TUNABLEIF;
 char *CIL_KEY_ALLOW;
 char *CIL_KEY_DONTAUDIT;
 char *CIL_KEY_TYPETRANSITION;
+char *CIL_KEY_PREFIX;
+char *CIL_KEY_SUFFIX;
 char *CIL_KEY_TYPECHANGE;
 char *CIL_KEY_CALL;
 char *CIL_KEY_TUNABLE;
@@ -269,6 +271,8 @@ static void cil_init_keys(void)
 	CIL_KEY_ALLOW =3D cil_strpool_add("allow");
 	CIL_KEY_DONTAUDIT =3D cil_strpool_add("dontaudit");
 	CIL_KEY_TYPETRANSITION =3D cil_strpool_add("typetransition");
+	CIL_KEY_PREFIX =3D cil_strpool_add("prefix");
+	CIL_KEY_SUFFIX =3D cil_strpool_add("suffix");
 	CIL_KEY_TYPECHANGE =3D cil_strpool_add("typechange");
 	CIL_KEY_CALL =3D cil_strpool_add("call");
 	CIL_KEY_TUNABLE =3D cil_strpool_add("tunable");
@@ -2461,6 +2465,8 @@ void cil_nametypetransition_init(struct cil_nametyp=
etransition **nametypetrans)
 	(*nametypetrans)->obj =3D NULL;
 	(*nametypetrans)->name_str =3D NULL;
 	(*nametypetrans)->name =3D NULL;
+	(*nametypetrans)->match_type_str =3D NULL;
+	(*nametypetrans)->match_type =3D FILENAME_TRANS_MATCH_EXACT;
 	(*nametypetrans)->result_str =3D NULL;
 	(*nametypetrans)->result =3D NULL;
 }
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
index a8e3616a..75a9e064 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1168,7 +1168,7 @@ static int __cil_typetransition_to_avtab_helper(pol=
icydb_t *pdb,
 						type_datum_t *sepol_src,
 						type_datum_t *sepol_tgt,
 						struct cil_list *class_list,
-						char *name,
+						char *name, uint32_t match_type,
 						type_datum_t *sepol_result)
 {
 	int rc;
@@ -1183,7 +1183,7 @@ static int __cil_typetransition_to_avtab_helper(pol=
icydb_t *pdb,
 		rc =3D policydb_filetrans_insert(
 			pdb, sepol_src->s.value, sepol_tgt->s.value,
 			sepol_obj->s.value, name, NULL,
-			sepol_result->s.value, &otype
+			sepol_result->s.value, match_type, &otype
 		);
 		if (rc !=3D SEPOL_OK) {
 			if (rc =3D=3D SEPOL_EEXIST) {
@@ -1252,7 +1252,7 @@ static int __cil_typetransition_to_avtab(policydb_t=
 *pdb, const struct cil_db *d
=20
 			rc =3D __cil_typetransition_to_avtab_helper(
 				pdb, sepol_src, sepol_src, class_list,
-				name, sepol_result
+				name, typetrans->match_type, sepol_result
 			);
 			if (rc !=3D SEPOL_OK) goto exit;
 		}
@@ -1270,7 +1270,7 @@ static int __cil_typetransition_to_avtab(policydb_t=
 *pdb, const struct cil_db *d
=20
 				rc =3D __cil_typetransition_to_avtab_helper(
 					pdb, sepol_src, sepol_tgt, class_list,
-					name, sepol_result
+					name, typetrans->match_type, sepol_result
 				);
 				if (rc !=3D SEPOL_OK) goto exit;
 			}
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
index be260a31..1224d623 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -3386,10 +3386,11 @@ int cil_gen_typetransition(struct cil_db *db, str=
uct cil_tree_node *parse_curren
 		CIL_SYN_STRING,
 		CIL_SYN_STRING,
 		CIL_SYN_STRING | CIL_SYN_END,
-		CIL_SYN_END
+		CIL_SYN_STRING | CIL_SYN_END,
+		CIL_SYN_END,
 	};
 	size_t syntax_len =3D sizeof(syntax)/sizeof(*syntax);
-	char *s1, *s2, *s3, *s4, *s5;
+	char *s1, *s2, *s3, *s4, *s5, *s6;
=20
 	if (db =3D=3D NULL || parse_current =3D=3D NULL || ast_node =3D=3D NULL=
 ) {
 		goto exit;
@@ -3405,12 +3406,22 @@ int cil_gen_typetransition(struct cil_db *db, str=
uct cil_tree_node *parse_curren
 	s3 =3D parse_current->next->next->next->data;
 	s4 =3D parse_current->next->next->next->next->data;
 	s5 =3D NULL;
+	s6 =3D NULL;
=20
 	if (parse_current->next->next->next->next->next) {
 		if (s4 =3D=3D CIL_KEY_STAR) {
-			s4 =3D parse_current->next->next->next->next->next->data;
+			if (parse_current->next->next->next->next->next->next) {
+				s4 =3D parse_current->next->next->next->next->next->next->data;
+			} else {
+				s4 =3D parse_current->next->next->next->next->next->data;
+			}
 		} else {
-			s5 =3D parse_current->next->next->next->next->next->data;
+			if (parse_current->next->next->next->next->next->next) {
+				s5 =3D parse_current->next->next->next->next->next->data;
+				s6 =3D parse_current->next->next->next->next->next->next->data;
+			} else {
+				s5 =3D parse_current->next->next->next->next->next->data;
+			}
 		}
 	}
=20
@@ -3426,7 +3437,15 @@ int cil_gen_typetransition(struct cil_db *db, stru=
ct cil_tree_node *parse_curren
 		nametypetrans->obj_str =3D s3;
 		nametypetrans->name_str =3D s4;
 		nametypetrans->name =3D cil_gen_declared_string(db, s4, ast_node);
-		nametypetrans->result_str =3D s5;
+		if (s6) {
+			nametypetrans->match_type_str =3D s5;
+			nametypetrans->result_str =3D s6;
+		} else {
+			nametypetrans->result_str =3D s5;
+		}
+
+		ast_node->data =3D nametypetrans;
+		ast_node->flavor =3D CIL_NAMETYPETRANSITION;
 	} else {
 		struct cil_type_rule *rule =3D NULL;
 		cil_type_rule_init(&rule);
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_=
ast.c
index 1507edb4..bee91e4b 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -723,6 +723,7 @@ int cil_copy_nametypetransition(__attribute__((unused=
)) struct cil_db *db, void
 	new->obj_str =3D orig->obj_str;
 	new->name_str =3D orig->name_str;
 	new->name =3D orig->name;
+	new->match_type_str =3D orig->match_type_str;
 	new->result_str =3D orig->result_str;
=20
=20
diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_inter=
nal.h
index 47b67c89..16b4fc8a 100644
--- a/libsepol/cil/src/cil_internal.h
+++ b/libsepol/cil/src/cil_internal.h
@@ -114,6 +114,8 @@ extern char *CIL_KEY_TUNABLEIF;
 extern char *CIL_KEY_ALLOW;
 extern char *CIL_KEY_DONTAUDIT;
 extern char *CIL_KEY_TYPETRANSITION;
+extern char *CIL_KEY_PREFIX;
+extern char *CIL_KEY_SUFFIX;
 extern char *CIL_KEY_TYPECHANGE;
 extern char *CIL_KEY_CALL;
 extern char *CIL_KEY_TUNABLE;
@@ -588,6 +590,8 @@ struct cil_nametypetransition {
 	struct cil_class *obj;
 	char *name_str;
 	struct cil_symtab_datum *name;
+	char *match_type_str;
+	uint32_t match_type;
 	char *result_str;
 	void *result; /* type or alias */
=20
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.=
c
index e9a8f75d..9517e871 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1259,6 +1259,7 @@ static void cil_nametypetransition_to_policy(FILE *=
out, struct cil_nametypetrans
 	struct cil_symtab_datum *src, *tgt, *name, *res;
 	struct cil_list *class_list;
 	struct cil_list_item *i1;
+	const char *match_type_str =3D "";
=20
 	src =3D trans->src;
 	tgt =3D trans->tgt;
@@ -1267,7 +1268,21 @@ static void cil_nametypetransition_to_policy(FILE =
*out, struct cil_nametypetrans
=20
 	class_list =3D cil_expand_class(trans->obj);
 	cil_list_for_each(i1, class_list) {
-		fprintf(out, "type_transition %s %s : %s %s \"%s\";\n", src->fqn, tgt-=
>fqn, DATUM(i1->data)->fqn, res->fqn, name->fqn);
+		switch (trans->match_type) {
+		case FILENAME_TRANS_MATCH_EXACT:
+			match_type_str =3D "";
+			break;
+		case FILENAME_TRANS_MATCH_PREFIX:
+			match_type_str =3D " prefix";
+			break;
+		case FILENAME_TRANS_MATCH_SUFFIX:
+			match_type_str =3D " suffix";
+			break;
+		default:
+			match_type_str =3D "???";
+			break;
+		}
+		fprintf(out, "type_transition %s %s : %s %s \"%s\"%s;\n", src->fqn, tg=
t->fqn, DATUM(i1->data)->fqn, res->fqn, name->fqn, match_type_str);
 	}
 	cil_list_destroy(&class_list, CIL_FALSE);
 }
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
index 427a320c..1e692bd3 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -665,6 +665,18 @@ int cil_resolve_nametypetransition(struct cil_tree_n=
ode *current, struct cil_db
 		nametypetrans->name =3D name_datum;
 	}
=20
+	if (nametypetrans->match_type_str =3D=3D NULL) {
+		nametypetrans->match_type =3D FILENAME_TRANS_MATCH_EXACT;
+	} else if (nametypetrans->match_type_str =3D=3D CIL_KEY_PREFIX) {
+		nametypetrans->match_type =3D FILENAME_TRANS_MATCH_PREFIX;
+	} else if (nametypetrans->match_type_str =3D=3D CIL_KEY_SUFFIX) {
+		nametypetrans->match_type =3D FILENAME_TRANS_MATCH_SUFFIX;
+	} else {
+		cil_tree_log(current, CIL_ERR, "Invalid name match type \"%s\"", namet=
ypetrans->match_type_str);
+		rc =3D SEPOL_ERR;
+		goto exit;
+	}
+
 	rc =3D cil_resolve_name(current, nametypetrans->result_str, CIL_SYM_TYP=
ES, db, &result_datum);
 	if (rc !=3D SEPOL_OK) {
 		goto exit;
diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_writ=
e_ast.c
index f4f9f167..d6c6b8f1 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -1217,6 +1217,8 @@ void cil_write_ast_node(FILE *out, struct cil_tree_=
node *node)
 		} else {
 			fprintf(out, "%s ", rule->name_str);
 		}
+		if (rule->match_type !=3D FILENAME_TRANS_MATCH_EXACT)
+			fprintf(out, "%s ", rule->match_type_str);
 		fprintf(out, "%s", datum_or_str(DATUM(rule->result), rule->result_str)=
);
 		fprintf(out, ")\n");
 		break;
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
index 6682069e..5ee0fa16 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -321,6 +321,8 @@ typedef struct filename_trans_rule {
 	uint32_t tclass;
 	char *name;
 	uint32_t otype;	/* new type */
+ 	/* name match type, values from enum filename_trans_match_type */
+	uint32_t match_type;
 	struct filename_trans_rule *next;
 } filename_trans_rule_t;
=20
@@ -423,6 +425,14 @@ typedef struct genfs {
 /* OCON_NUM needs to be the largest index in any platform's ocontext arr=
ay */
 #define OCON_NUM   9
=20
+/* filename transitions table array indices */
+enum filename_trans_match_type {
+	FILENAME_TRANS_MATCH_EXACT,
+	FILENAME_TRANS_MATCH_PREFIX,
+	FILENAME_TRANS_MATCH_SUFFIX,
+	FILENAME_TRANS_MATCH_NUM,
+};
+
 /* section: module information */
=20
 /* scope_index_t holds all of the symbols that are in scope in a
@@ -593,8 +603,8 @@ typedef struct policydb {
 	hashtab_t range_tr;
=20
 	/* file transitions with the last path component */
-	hashtab_t filename_trans;
-	uint32_t filename_trans_count;
+	hashtab_t filename_trans[FILENAME_TRANS_MATCH_NUM];
+	uint32_t filename_trans_exact_count;
=20
 	ebitmap_t *type_attr_map;
=20
@@ -657,7 +667,8 @@ extern int policydb_sort_ocontexts(policydb_t *p);
 extern int policydb_filetrans_insert(policydb_t *p, uint32_t stype,
 				     uint32_t ttype, uint32_t tclass,
 				     const char *name, char **name_alloc,
-				     uint32_t otype, uint32_t *present_otype);
+				     uint32_t otype, uint32_t match_type,
+				     uint32_t *present_otype);
=20
 /* Deprecated */
 extern int policydb_context_isvalid(const policydb_t * p,
@@ -758,10 +769,11 @@ extern int policydb_set_target_platform(policydb_t =
*p, int platform);
 #define POLICYDB_VERSION_INFINIBAND		31 /* Linux-specific */
 #define POLICYDB_VERSION_GLBLUB		32
 #define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitio=
ns */
+#define POLICYDB_VERSION_PREFIX_SUFFIX	34 /* prefix and suffix filename =
transitions */
=20
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_COMP_FTRANS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PREFIX_SUFFIX
=20
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
@@ -784,9 +796,10 @@ extern int policydb_set_target_platform(policydb_t *=
p, int platform);
 #define MOD_POLICYDB_VERSION_INFINIBAND		19
 #define MOD_POLICYDB_VERSION_GLBLUB		20
 #define MOD_POLICYDB_VERSION_SELF_TYPETRANS	21
+#define MOD_POLICYDB_VERSION_PREFIX_SUFFIX	22
=20
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_SELF_TYPETRANS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_PREFIX_SUFFIX
=20
 #define POLICYDB_CONFIG_MLS    1
=20
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index e63414b1..93170a14 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1419,18 +1419,31 @@ static int expand_filename_trans_helper(expand_st=
ate_t *state,
 	rc =3D policydb_filetrans_insert(
 		state->out, s + 1, t + 1,
 		rule->tclass, rule->name,
-		NULL, mapped_otype, &present_otype
+		NULL, mapped_otype, rule->match_type, &present_otype
 	);
 	if (rc =3D=3D SEPOL_EEXIST) {
 		/* duplicate rule, ignore */
 		if (present_otype =3D=3D mapped_otype)
 			return 0;
=20
-		ERR(state->handle, "Conflicting name-based type_transition %s %s:%s \"=
%s\":  %s vs %s",
+		const char *match_str =3D "";
+		switch (rule->match_type) {
+		case FILENAME_TRANS_MATCH_EXACT:
+			match_str =3D "";
+			break;
+		case FILENAME_TRANS_MATCH_PREFIX:
+			match_str =3D " prefix";
+			break;
+		case FILENAME_TRANS_MATCH_SUFFIX:
+			match_str =3D " suffix";
+			break;
+		}
+		ERR(state->handle, "Conflicting name-based type_transition %s %s:%s \"=
%s\"%s:  %s vs %s",
 		    state->out->p_type_val_to_name[s],
 		    state->out->p_type_val_to_name[t],
 		    state->out->p_class_val_to_name[rule->tclass - 1],
 		    rule->name,
+		    match_str,
 		    state->out->p_type_val_to_name[present_otype - 1],
 		    state->out->p_type_val_to_name[mapped_otype - 1]);
 		return -1;
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 8ec79749..ed4f4c4d 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1882,6 +1882,7 @@ exit:
=20
 struct map_filename_trans_args {
 	struct policydb *pdb;
+	uint32_t match_type;
 	struct strs *strs;
 };
=20
@@ -1896,6 +1897,19 @@ static int map_filename_trans_to_str(hashtab_key_t=
 key, void *data, void *arg)
 	struct ebitmap_node *node;
 	uint32_t bit;
 	int rc;
+	const char *match_str =3D "";
+
+	switch (map_args->match_type) {
+	case FILENAME_TRANS_MATCH_EXACT:
+		match_str =3D "";
+		break;
+	case FILENAME_TRANS_MATCH_PREFIX:
+		match_str =3D " prefix";
+		break;
+	case FILENAME_TRANS_MATCH_SUFFIX:
+		match_str =3D " suffix";
+		break;
+	}
=20
 	tgt =3D pdb->p_type_val_to_name[ft->ttype - 1];
 	class =3D pdb->p_class_val_to_name[ft->tclass - 1];
@@ -1906,8 +1920,8 @@ static int map_filename_trans_to_str(hashtab_key_t =
key, void *data, void *arg)
 		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
 			src =3D pdb->p_type_val_to_name[bit];
 			rc =3D strs_create_and_add(strs,
-						 "(typetransition %s %s %s \"%s\" %s)",
-						 5, src, tgt, class, filename, new);
+						 "(typetransition %s %s %s \"%s\"%s %s)",
+						 6, src, tgt, class, filename, match_str, new);
 			if (rc)
 				return rc;
 		}
@@ -1932,7 +1946,23 @@ static int write_filename_trans_rules_to_cil(FILE =
*out, struct policydb *pdb)
 	args.pdb =3D pdb;
 	args.strs =3D strs;
=20
-	rc =3D hashtab_map(pdb->filename_trans, map_filename_trans_to_str, &arg=
s);
+	args.match_type =3D FILENAME_TRANS_MATCH_EXACT;
+	rc =3D hashtab_map(pdb->filename_trans[FILENAME_TRANS_MATCH_EXACT],
+			 map_filename_trans_to_str, &args);
+	if (rc !=3D 0) {
+		goto exit;
+	}
+
+	args.match_type =3D FILENAME_TRANS_MATCH_PREFIX;
+	rc =3D hashtab_map(pdb->filename_trans[FILENAME_TRANS_MATCH_PREFIX],
+			 map_filename_trans_to_str, &args);
+	if (rc !=3D 0) {
+		goto exit;
+	}
+
+	args.match_type =3D FILENAME_TRANS_MATCH_SUFFIX;
+	rc =3D hashtab_map(pdb->filename_trans[FILENAME_TRANS_MATCH_SUFFIX],
+			 map_filename_trans_to_str, &args);
 	if (rc !=3D 0) {
 		goto exit;
 	}
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
index b5b530d6..c72fc974 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1846,6 +1846,7 @@ exit:
=20
 struct map_filename_trans_args {
 	struct policydb *pdb;
+	uint32_t match_type;
 	struct strs *strs;
 };
=20
@@ -1860,6 +1861,19 @@ static int map_filename_trans_to_str(hashtab_key_t=
 key, void *data, void *arg)
 	struct ebitmap_node *node;
 	uint32_t bit;
 	int rc;
+	const char *match_str =3D "";
+
+	switch (map_args->match_type) {
+	case FILENAME_TRANS_MATCH_EXACT:
+		match_str =3D "";
+		break;
+	case FILENAME_TRANS_MATCH_PREFIX:
+		match_str =3D " prefix";
+		break;
+	case FILENAME_TRANS_MATCH_SUFFIX:
+		match_str =3D " suffix";
+		break;
+	}
=20
 	tgt =3D pdb->p_type_val_to_name[ft->ttype - 1];
 	class =3D pdb->p_class_val_to_name[ft->tclass - 1];
@@ -1870,8 +1884,8 @@ static int map_filename_trans_to_str(hashtab_key_t =
key, void *data, void *arg)
 		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
 			src =3D pdb->p_type_val_to_name[bit];
 			rc =3D strs_create_and_add(strs,
-						 "type_transition %s %s:%s %s \"%s\";",
-						 5, src, tgt, class, new, filename);
+						 "type_transition %s %s:%s %s \"%s\"%s;",
+						 6, src, tgt, class, new, filename, match_str);
 			if (rc)
 				return rc;
 		}
@@ -1896,7 +1910,23 @@ static int write_filename_trans_rules_to_conf(FILE=
 *out, struct policydb *pdb)
 	args.pdb =3D pdb;
 	args.strs =3D strs;
=20
-	rc =3D hashtab_map(pdb->filename_trans, map_filename_trans_to_str, &arg=
s);
+	args.match_type =3D FILENAME_TRANS_MATCH_EXACT;
+	rc =3D hashtab_map(pdb->filename_trans[FILENAME_TRANS_MATCH_EXACT],
+			 map_filename_trans_to_str, &args);
+	if (rc !=3D 0) {
+		goto exit;
+	}
+
+	args.match_type =3D FILENAME_TRANS_MATCH_PREFIX;
+	rc =3D hashtab_map(pdb->filename_trans[FILENAME_TRANS_MATCH_PREFIX],
+			 map_filename_trans_to_str, &args);
+	if (rc !=3D 0) {
+		goto exit;
+	}
+
+	args.match_type =3D FILENAME_TRANS_MATCH_SUFFIX;
+	rc =3D hashtab_map(pdb->filename_trans[FILENAME_TRANS_MATCH_SUFFIX],
+			 map_filename_trans_to_str, &args);
 	if (rc !=3D 0) {
 		goto exit;
 	}
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 3b7742bc..f432087f 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1440,6 +1440,7 @@ static int copy_filename_trans_list(filename_trans_=
rule_t * list,
 		new_rule->name =3D strdup(cur->name);
 		if (!new_rule->name)
 			goto err;
+		new_rule->match_type =3D cur->match_type;
=20
 		if (type_set_or_convert(&cur->stypes, &new_rule->stypes, module) ||
 		    type_set_or_convert(&cur->ttypes, &new_rule->ttypes, module))
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ee22dbbd..a90ee85d 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1611,6 +1611,7 @@ static int filename_trans_to_cil(int indent, struct=
 policydb *pdb, struct filena
 	unsigned int ttype;
 	struct type_set *ts;
 	struct filename_trans_rule *rule;
+	const char *match_str =3D "";
=20
 	for (rule =3D rules; rule !=3D NULL; rule =3D rule->next) {
 		ts =3D &rule->stypes;
@@ -1625,19 +1626,31 @@ static int filename_trans_to_cil(int indent, stru=
ct policydb *pdb, struct filena
 			goto exit;
 		}
=20
+		switch (rule->match_type) {
+		case FILENAME_TRANS_MATCH_EXACT:
+			match_str =3D "";
+			break;
+		case FILENAME_TRANS_MATCH_PREFIX:
+			match_str =3D " prefix";
+			break;
+		case FILENAME_TRANS_MATCH_SUFFIX:
+			match_str =3D " suffix";
+			break;
+		}
+
 		for (stype =3D 0; stype < num_stypes; stype++) {
 			for (ttype =3D 0; ttype < num_ttypes; ttype++) {
-				cil_println(indent, "(typetransition %s %s %s \"%s\" %s)",
+				cil_println(indent, "(typetransition %s %s %s \"%s\"%s %s)",
 					    stypes[stype], ttypes[ttype],
 					    pdb->p_class_val_to_name[rule->tclass - 1],
-					    rule->name,
+					    rule->name, match_str,
 					    pdb->p_type_val_to_name[rule->otype - 1]);
 			}
 			if (rule->flags & RULE_SELF) {
-				cil_println(indent, "(typetransition %s self %s \"%s\" %s)",
+				cil_println(indent, "(typetransition %s self %s \"%s\"%s %s)",
 					    stypes[stype],
 					    pdb->p_class_val_to_name[rule->tclass - 1],
-					    rule->name,
+					    rule->name, match_str,
 					    pdb->p_type_val_to_name[rule->otype - 1]);
 			}
 		}
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 6ba4f916..a1796844 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -208,6 +208,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
 	 .ocon_num =3D OCON_IBENDPORT + 1,
 	 .target_platform =3D SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type =3D POLICY_KERN,
+	 .version =3D POLICYDB_VERSION_PREFIX_SUFFIX,
+	 .sym_num =3D SYM_NUM,
+	 .ocon_num =3D OCON_IBENDPORT + 1,
+	 .target_platform =3D SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type =3D POLICY_BASE,
 	 .version =3D MOD_POLICYDB_VERSION_BASE,
@@ -334,6 +341,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
 	 .ocon_num =3D OCON_IBENDPORT + 1,
 	 .target_platform =3D SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type =3D POLICY_BASE,
+	 .version =3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX,
+	 .sym_num =3D SYM_NUM,
+	 .ocon_num =3D OCON_IBENDPORT + 1,
+	 .target_platform =3D SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type =3D POLICY_MOD,
 	 .version =3D MOD_POLICYDB_VERSION_BASE,
@@ -460,6 +474,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
 	 .ocon_num =3D 0,
 	 .target_platform =3D SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type =3D POLICY_MOD,
+	 .version =3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX,
+	 .sym_num =3D SYM_NUM,
+	 .ocon_num =3D 0,
+	 .target_platform =3D SEPOL_TARGET_SELINUX,
+	},
 };
=20
 #if 0
@@ -909,10 +930,14 @@ int policydb_init(policydb_t * p)
 	if (rc)
 		goto err;
=20
-	p->filename_trans =3D hashtab_create(filenametr_hash, filenametr_cmp, (=
1 << 10));
-	if (!p->filename_trans) {
-		rc =3D -ENOMEM;
-		goto err;
+	for (i =3D 0; i < FILENAME_TRANS_MATCH_NUM; i++) {
+		p->filename_trans[i] =3D hashtab_create(filenametr_hash,
+						      filenametr_cmp,
+						      (1 << 10));
+		if (!p->filename_trans[i]) {
+			rc =3D -ENOMEM;
+			goto err;
+		}
 	}
=20
 	p->range_tr =3D hashtab_create(rangetr_hash, rangetr_cmp, 256);
@@ -926,7 +951,9 @@ int policydb_init(policydb_t * p)
=20
 	return 0;
 err:
-	hashtab_destroy(p->filename_trans);
+	for (i =3D 0; i < FILENAME_TRANS_MATCH_NUM; i++) {
+		hashtab_destroy(p->filename_trans[i]);
+	}
 	hashtab_destroy(p->range_tr);
 	for (i =3D 0; i < SYM_NUM; i++) {
 		hashtab_destroy(p->symtab[i].table);
@@ -1564,8 +1591,10 @@ void policydb_destroy(policydb_t * p)
 	if (lra)
 		free(lra);
=20
-	hashtab_map(p->filename_trans, filenametr_destroy, NULL);
-	hashtab_destroy(p->filename_trans);
+	for (i =3D 0; i < FILENAME_TRANS_MATCH_NUM; i++) {
+		hashtab_map(p->filename_trans[i], filenametr_destroy, NULL);
+		hashtab_destroy(p->filename_trans[i]);
+	}
=20
 	hashtab_map(p->range_tr, range_tr_destroy, NULL);
 	hashtab_destroy(p->range_tr);
@@ -2566,7 +2595,7 @@ static int role_allow_read(role_allow_t ** r, struc=
t policy_file *fp)
 int policydb_filetrans_insert(policydb_t *p, uint32_t stype, uint32_t tt=
ype,
 			      uint32_t tclass, const char *name,
 			      char **name_alloc, uint32_t otype,
-			      uint32_t *present_otype)
+			      uint32_t match_type, uint32_t *present_otype)
 {
 	filename_trans_key_t *ft, key;
 	filename_trans_datum_t *datum, *last;
@@ -2576,7 +2605,8 @@ int policydb_filetrans_insert(policydb_t *p, uint32=
_t stype, uint32_t ttype,
 	key.name =3D (char *)name;
=20
 	last =3D NULL;
-	datum =3D hashtab_search(p->filename_trans, (hashtab_key_t)&key);
+	datum =3D hashtab_search(p->filename_trans[match_type],
+			       (hashtab_key_t)&key);
 	while (datum) {
 		if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
 			if (present_otype)
@@ -2624,7 +2654,8 @@ int policydb_filetrans_insert(policydb_t *p, uint32=
_t stype, uint32_t ttype,
 			ft->tclass =3D tclass;
 			ft->name =3D name_dup;
=20
-			if (hashtab_insert(p->filename_trans, (hashtab_key_t)ft,
+			if (hashtab_insert(p->filename_trans[match_type],
+					   (hashtab_key_t)ft,
 					   (hashtab_datum_t)datum)) {
 				free(name_dup);
 				free(datum);
@@ -2634,7 +2665,14 @@ int policydb_filetrans_insert(policydb_t *p, uint3=
2_t stype, uint32_t ttype,
 		}
 	}
=20
-	p->filename_trans_count++;
+        /*
+         * We need to keep track of the number of exact match filename
+	 * transitions for writing them in uncompressed format in older binary
+	 * policy versions. Other match types were not supported back then, so
+	 * it is not needed.
+         */
+        if (match_type =3D=3D FILENAME_TRANS_MATCH_EXACT)
+		p->filename_trans_exact_count++;
 	return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
 }
=20
@@ -2665,8 +2703,9 @@ static int filename_trans_read_one_compat(policydb_=
t *p, struct policy_file *fp)
 	tclass =3D le32_to_cpu(buf[2]);
 	otype  =3D le32_to_cpu(buf[3]);
=20
+	// This version does not contain other than exact filename transitions
 	rc =3D policydb_filetrans_insert(p, stype, ttype, tclass, name, &name,
-				       otype, NULL);
+				       otype, FILENAME_TRANS_MATCH_EXACT, NULL);
 	if (rc) {
 		if (rc !=3D SEPOL_EEXIST)
 			goto err;
@@ -2714,7 +2753,8 @@ out:
 	return rc;
 }
=20
-static int filename_trans_read_one(policydb_t *p, struct policy_file *fp=
)
+static int filename_trans_read_one(policydb_t *p, uint32_t match_type,
+				   struct policy_file *fp)
 {
 	filename_trans_key_t *ft =3D NULL;
 	filename_trans_datum_t **dst, *datum, *first =3D NULL;
@@ -2762,7 +2802,14 @@ static int filename_trans_read_one(policydb_t *p, =
struct policy_file *fp)
=20
 		datum->otype =3D le32_to_cpu(buf[0]);
=20
-		p->filename_trans_count +=3D ebitmap_cardinality(&datum->stypes);
+		/*
+		 * We need to keep track of the number of exact match filename
+		 * transitions for writing them in uncompressed format in older
+		 * binary policy versions. Other match types were not supported
+		 * back then, so it is not needed
+		 */
+		if (match_type =3D=3D FILENAME_TRANS_MATCH_EXACT)
+			p->filename_trans_exact_count +=3D ebitmap_cardinality(&datum->stypes=
);
=20
 		dst =3D &datum->next;
 	}
@@ -2778,7 +2825,7 @@ static int filename_trans_read_one(policydb_t *p, s=
truct policy_file *fp)
 	ft->tclass =3D tclass;
 	ft->name =3D name;
=20
-	rc =3D hashtab_insert(p->filename_trans, (hashtab_key_t)ft,
+	rc =3D hashtab_insert(p->filename_trans[match_type], (hashtab_key_t)ft,
 			    (hashtab_datum_t)first);
 	if (rc)
 		goto err;
@@ -2797,7 +2844,8 @@ err:
 	return -1;
 }
=20
-static int filename_trans_read(policydb_t *p, struct policy_file *fp)
+static int filename_trans_read(policydb_t *p, struct policy_file *fp,
+			       uint32_t match_type)
 {
 	unsigned int i;
 	uint32_t buf[1], nel;
@@ -2810,13 +2858,17 @@ static int filename_trans_read(policydb_t *p, str=
uct policy_file *fp)
=20
 	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
 		for (i =3D 0; i < nel; i++) {
+			/*
+			 * this version does not have other than exact match
+			 * transitions
+			 */
 			rc =3D filename_trans_read_one_compat(p, fp);
 			if (rc < 0)
 				return -1;
 		}
 	} else {
 		for (i =3D 0; i < nel; i++) {
-			rc =3D filename_trans_read_one(p, fp);
+			rc =3D filename_trans_read_one(p, match_type, fp);
 			if (rc < 0)
 				return -1;
 		}
@@ -3743,7 +3795,7 @@ static int role_allow_rule_read(role_allow_rule_t *=
* r, struct policy_file *fp)
 static int filename_trans_rule_read(policydb_t *p, filename_trans_rule_t=
 **r,
 				    struct policy_file *fp)
 {
-	uint32_t buf[3], nel, i, len;
+	uint32_t buf[4], nel, i, len;
 	unsigned int entries;
 	filename_trans_rule_t *ftr, *lftr;
 	int rc;
@@ -3782,7 +3834,9 @@ static int filename_trans_rule_read(policydb_t *p, =
filename_trans_rule_t **r,
 		if (type_set_read(&ftr->ttypes, fp))
 			return -1;
=20
-		if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYPETRANS)
+		if (p->policyvers >=3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX)
+			entries =3D 4;
+		else if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYPETRANS)
 			entries =3D 3;
 		else
 			entries =3D 2;
@@ -3794,6 +3848,8 @@ static int filename_trans_rule_read(policydb_t *p, =
filename_trans_rule_t **r,
 		ftr->otype =3D le32_to_cpu(buf[1]);
 		if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYPETRANS)
 			ftr->flags =3D le32_to_cpu(buf[2]);
+		if (p->policyvers >=3D  MOD_POLICYDB_VERSION_PREFIX_SUFFIX)
+			ftr->match_type =3D le32_to_cpu(buf[3]);
 	}
=20
 	return 0;
@@ -4356,7 +4412,11 @@ int policydb_read(policydb_t * p, struct policy_fi=
le *fp, unsigned verbose)
 		if (role_allow_read(&p->role_allow, fp))
 			goto bad;
 		if (r_policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS &&
-		    filename_trans_read(p, fp))
+		    filename_trans_read(p, fp, FILENAME_TRANS_MATCH_EXACT))
+			goto bad;
+		if (r_policyvers >=3D POLICYDB_VERSION_PREFIX_SUFFIX &&
+		    (filename_trans_read(p, fp, FILENAME_TRANS_MATCH_PREFIX) ||
+		     filename_trans_read(p, fp, FILENAME_TRANS_MATCH_SUFFIX)))
 			goto bad;
 	} else {
 		/* first read the AV rule blocks, then the scope tables */
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
index 8b87675f..d94f49aa 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1147,12 +1147,23 @@ static int validate_filename_trans_hashtab(sepol_=
handle_t *handle, const policyd
 {
 	map_arg_t margs =3D { flavors, handle, p };
=20
-	if (hashtab_map(p->filename_trans, validate_filename_trans, &margs)) {
-		ERR(handle, "Invalid filename trans");
-		return -1;
+	if (hashtab_map(p->filename_trans[FILENAME_TRANS_MATCH_EXACT],
+			validate_filename_trans, &margs))
+		goto bad;
+
+	if (p->policyvers >=3D POLICYDB_VERSION_PREFIX_SUFFIX) {
+		if (hashtab_map(p->filename_trans[FILENAME_TRANS_MATCH_PREFIX],
+				validate_filename_trans, &margs))
+			goto bad;
+		if (hashtab_map(p->filename_trans[FILENAME_TRANS_MATCH_SUFFIX],
+				validate_filename_trans, &margs))
+			goto bad;
 	}
=20
 	return 0;
+bad:
+	ERR(handle, "Invalid filename trans");
+	return -1;
 }
=20
 static int validate_context(const context_struct_t *con, validate_t flav=
ors[], int mls)
@@ -1374,6 +1385,15 @@ static int validate_filename_trans_rules(sepol_han=
dle_t *handle, const filename_
 		if (validate_simpletype(filename_trans->otype, p, flavors))
 			goto bad;
=20
+		switch (filename_trans->match_type) {
+		case FILENAME_TRANS_MATCH_EXACT:
+		case FILENAME_TRANS_MATCH_PREFIX:
+		case FILENAME_TRANS_MATCH_SUFFIX:
+			break;
+		default:
+			goto bad;
+		}
+
 		/* currently only the RULE_SELF flag can be set */
 		if ((filename_trans->flags & ~RULE_SELF) !=3D 0)
 			goto bad;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 283d11c8..6bcd7535 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -653,7 +653,8 @@ static int filename_write_one(hashtab_key_t key, void=
 *data, void *ptr)
 	return 0;
 }
=20
-static int filename_trans_write(struct policydb *p, void *fp)
+static int filename_trans_write(struct policydb *p, uint32_t match_type,
+				void *fp)
 {
 	size_t items;
 	uint32_t buf[1];
@@ -663,20 +664,25 @@ static int filename_trans_write(struct policydb *p,=
 void *fp)
 		return 0;
=20
 	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
-		buf[0] =3D cpu_to_le32(p->filename_trans_count);
+		/*
+		 * This version does not have other than exact match
+		 * transitions, there is no need to count other ones.
+		 */
+		buf[0] =3D cpu_to_le32(p->filename_trans_exact_count);
 		items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items !=3D 1)
 			return POLICYDB_ERROR;
=20
-		rc =3D hashtab_map(p->filename_trans, filename_write_one_compat,
-				 fp);
+		rc =3D hashtab_map(p->filename_trans[match_type],
+				 filename_write_one_compat, fp);
 	} else {
-		buf[0] =3D cpu_to_le32(p->filename_trans->nel);
+		buf[0] =3D cpu_to_le32(p->filename_trans[match_type]->nel);
 		items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items !=3D 1)
 			return POLICYDB_ERROR;
=20
-		rc =3D hashtab_map(p->filename_trans, filename_write_one, fp);
+		rc =3D hashtab_map(p->filename_trans[match_type],
+				 filename_write_one, fp);
 	}
 	return rc;
 }
@@ -1944,11 +1950,25 @@ static int filename_trans_rule_write(policydb_t *=
p, filename_trans_rule_t *t,
 {
 	int nel =3D 0;
 	size_t items, entries;
-	uint32_t buf[3], len;
+	uint32_t buf[4], len;
 	filename_trans_rule_t *ftr;
+	int discarding =3D 0;
=20
-	for (ftr =3D t; ftr; ftr =3D ftr->next)
-		nel++;
+	if (p->policyvers >=3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX) {
+		for (ftr =3D t; ftr; ftr =3D ftr->next)
+			nel++;
+	} else {
+		for (ftr =3D t; ftr; ftr =3D ftr->next) {
+			if (ftr->match_type =3D=3D FILENAME_TRANS_MATCH_EXACT)
+				nel++;
+			else
+				discarding =3D 1;
+		}
+		if (discarding) {
+			WARN(fp->handle,
+			     "Discarding prefix/suffix filename type transition rules");
+		}
+	}
=20
 	buf[0] =3D cpu_to_le32(nel);
 	items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
@@ -1956,6 +1976,9 @@ static int filename_trans_rule_write(policydb_t *p,=
 filename_trans_rule_t *t,
 		return POLICYDB_ERROR;
=20
 	for (ftr =3D t; ftr; ftr =3D ftr->next) {
+		if (p->policyvers < MOD_POLICYDB_VERSION_PREFIX_SUFFIX &&
+		    ftr->match_type !=3D FILENAME_TRANS_MATCH_EXACT)
+			continue;
 		len =3D strlen(ftr->name);
 		buf[0] =3D cpu_to_le32(len);
 		items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
@@ -1974,8 +1997,11 @@ static int filename_trans_rule_write(policydb_t *p=
, filename_trans_rule_t *t,
 		buf[0] =3D cpu_to_le32(ftr->tclass);
 		buf[1] =3D cpu_to_le32(ftr->otype);
 		buf[2] =3D cpu_to_le32(ftr->flags);
+		buf[3] =3D cpu_to_le32(ftr->match_type);
=20
-		if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYPETRANS) {
+		if (p->policyvers >=3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX) {
+			entries =3D 4;
+		} else if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYPETRANS) {
 			entries =3D 3;
 		} else if (!(ftr->flags & RULE_SELF)) {
 			entries =3D 2;
@@ -2370,12 +2396,29 @@ int policydb_write(policydb_t * p, struct policy_=
file *fp)
 		if (role_allow_write(p->role_allow, fp))
 			return POLICYDB_ERROR;
 		if (p->policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS) {
-			if (filename_trans_write(p, fp))
+			if (filename_trans_write(p, FILENAME_TRANS_MATCH_EXACT,
+						 fp))
 				return POLICYDB_ERROR;
 		} else {
-			if (p->filename_trans)
+			if (p->filename_trans[FILENAME_TRANS_MATCH_EXACT])
 				WARN(fp->handle, "Discarding filename type transition rules");
 		}
+		if (p->policyvers >=3D POLICYDB_VERSION_PREFIX_SUFFIX) {
+			if (filename_trans_write(p, FILENAME_TRANS_MATCH_PREFIX,
+						 fp) ||
+			    filename_trans_write(p, FILENAME_TRANS_MATCH_SUFFIX,
+						 fp))
+				return POLICYDB_ERROR;
+		} else {
+			if (p->filename_trans[FILENAME_TRANS_MATCH_PREFIX] &&
+			    p->filename_trans[FILENAME_TRANS_MATCH_PREFIX]->nel)
+				WARN(fp->handle,
+				     "Discarding prefix filename type transition rules");
+			if (p->filename_trans[FILENAME_TRANS_MATCH_SUFFIX] &&
+			    p->filename_trans[FILENAME_TRANS_MATCH_SUFFIX]->nel)
+				WARN(fp->handle,
+				     "Discarding suffix filename type transition rules");
+		}
 	} else {
 		if (avrule_block_write(p->global, num_syms, p, fp) =3D=3D -1) {
 			return POLICYDB_ERROR;
diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
index e6b78618..73e678a7 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -134,6 +134,8 @@
 	(typetransition device_t exec_type files console_device_t)
 	(typetransition exec_type self files console_device_t)
 	(typetransition exec_type self files "filename" console_device_t)
+	(typetransition exec_type self files "filename" prefix console_device_t=
)
+	(typetransition exec_type self files "filename" suffix console_device_t=
)
 	(typechange console_device_t device_t file user_tty_device_t)
 	(typechange exec_type device_t file user_tty_device_t)
 	(typechange exec_type self file console_device_t)
@@ -153,6 +155,8 @@
 	(rangetransition device_t kernel_t file ((s0) (s3 (not c3))))
=20
 	(typetransition device_t console_t file "some_file" getty_t)
+	(typetransition device_t console_t file "some_file" prefix getty_t)
+	(typetransition device_t console_t file "some_file" suffix getty_t)
 =09
 	(allow foo_type self (file (execute)))
 	(allow bin_t device_t (file (execute)))
--=20
2.42.0

