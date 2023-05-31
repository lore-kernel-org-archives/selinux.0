Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67525C7EE2F
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 11:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjEaLuX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 07:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbjEaLuU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 07:50:20 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A17123
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 04:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685533810; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Jgs5+FPLyFODA4iBCmZDPXXyCc4NoRb/NIOrSy+WvzxGu21wbpSD6axcJOvEwLGV2W3/c2aSAVkIlaRoHUPBVhDO/xWkDKD0VCWuL/CkR0933X4LNUB4GsKuetDRkqQhhO3mO6vSRFbMqqgJ0IMfFZ6GXhXUDqG/1qg4rcRTGEI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685533810; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=WQrQZbDHPe6M8BVXvXlQLQPMzAA43u63+5hh2oEHMyw=; 
        b=cGCLwZIIye4XglitiPaiPpWnFdTdVO6r8GKAoiHpjaw4gq/nWvzFsY+mGnHJ3cXUCCLMkl5wH2pynnJurLDmXD32CDAaYkoAs1nhQvfL2WMzX/SX8onkPmWFDGQQK/CFBnSaUdzWoIYhIoN2yfqVNuV5YiMYb3ggbV65R8uBm0U=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685533810;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=WQrQZbDHPe6M8BVXvXlQLQPMzAA43u63+5hh2oEHMyw=;
        b=Xokcaftb3z80UvrYLHW06qICDEUqD4nY/Srbd4/+xwBgvbemlHLfaVMMFlZ5MuBt
        31ejPph4UUlZQ9SScr0iH8w0GPRhbOk3Lp+wLiXz6izrapqS4sSTD7rXuqOfx3WqZ2o
        TRBP0dTdrnBICNMn1r3bRvI0Ln+oI2maphoB6QUQ=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1685533806790703.6871953671595; Wed, 31 May 2023 13:50:06 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 3750C2081F76;
        Wed, 31 May 2023 11:50:06 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 6/8] checkpolicy, libsepol: add prefix/suffix support to kernel policy
Date:   Wed, 31 May 2023 13:49:12 +0200
Message-Id: <20230531114914.2237609-7-juraj@jurajmarcin.com>
In-Reply-To: <20230531114914.2237609-1-juraj@jurajmarcin.com>
References: <20230531114914.2237609-1-juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently, filename type transitions support only exact name matching.
However, in practice, the names contain variable parts. This leads to
many duplicated rules in the policy that differ only in the part of the
name, or it is even impossible to cover all possible combinations.

This patch extends the filename type transitions structures to include
new types of filename transitions - prefix and suffix filename
transitions. It also implements the reading and writing of those rules
in the kernel binary policy format together with increasing its version.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 checkpolicy/test/dispol.c                  | 25 +++++++++-
 libsepol/include/sepol/policydb/avtab.h    |  2 +
 libsepol/include/sepol/policydb/policydb.h |  9 +++-
 libsepol/src/avtab.c                       | 13 +++++
 libsepol/src/kernel_to_cil.c               | 30 +++++++++++-
 libsepol/src/kernel_to_common.h            |  1 +
 libsepol/src/kernel_to_conf.c              | 30 +++++++++++-
 libsepol/src/policydb.c                    |  7 +++
 libsepol/src/policydb_validate.c           | 10 +++-
 libsepol/src/write.c                       | 55 ++++++++++++++++++++--
 10 files changed, 170 insertions(+), 12 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 4455407c..064cbd4e 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -82,6 +82,7 @@ typedef struct {
 	avtab_key_t *key;
 	policydb_t *p;
 	FILE *fp;
+	name_trans_match_t match;
 } render_name_trans_args_t;
=20
 static int render_name_trans_helper(hashtab_key_t k, hashtab_datum_t d, =
void *a)
@@ -93,7 +94,22 @@ static int render_name_trans_helper(hashtab_key_t k, h=
ashtab_datum_t d, void *a)
 	fprintf(args->fp, "type_transition ");
 	render_key(args->key, args->p, args->fp);
 	render_type(*otype, args->p, args->fp);
-	fprintf(args->fp, " \"%s\";\n", name);
+	const char *match_str =3D "";
+	switch (args->match) {
+	case NAME_TRANS_MATCH_EXACT:
+		match_str =3D "";
+		break;
+	case NAME_TRANS_MATCH_PREFIX:
+		match_str =3D " MATCH_PREFIX";
+		break;
+	case NAME_TRANS_MATCH_SUFFIX:
+		match_str =3D " MATCH_SUFFIX";
+		break;
+	default:
+		fprintf(args->fp, "     ERROR: no valid name match type specified\n");
+		return -1;
+	}
+	fprintf(args->fp, " \"%s\"%s;\n", name, match_str);
=20
 	return 0;
 }
@@ -160,9 +176,16 @@ static int render_av_rule(avtab_key_t * key, avtab_d=
atum_t * datum, uint32_t wha
 				.key =3D key,
 				.p =3D p,
 				.fp =3D fp,
+				.match =3D NAME_TRANS_MATCH_EXACT,
 			};
 			hashtab_map(datum->trans->name_trans.table,
 				    render_name_trans_helper, &args);
+			args.match =3D NAME_TRANS_MATCH_PREFIX;
+			hashtab_map(datum->trans->prefix_trans.table,
+				    render_name_trans_helper, &args);
+			args.match =3D NAME_TRANS_MATCH_SUFFIX;
+			hashtab_map(datum->trans->suffix_trans.table,
+				    render_name_trans_helper, &args);
 		}
 		if (key->specified & AVTAB_MEMBER) {
 			fprintf(fp, "type_member ");
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/s=
epol/policydb/avtab.h
index 5dc720cc..870fb08a 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -74,6 +74,8 @@ typedef struct avtab_key {
 typedef struct avtab_trans {
 	uint32_t otype;		/* resulting type of the new object */
 	symtab_t name_trans;	/* filename transitions */
+	symtab_t prefix_trans;	/* prefix filename transitions */
+	symtab_t suffix_trans;	/* prefix filename transitions */
 } avtab_trans_t;
=20
 typedef struct avtab_extended_perms {
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
index 5efd0a47..a2df4a62 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -252,6 +252,12 @@ typedef struct av_extended_perms {
 	uint32_t perms[EXTENDED_PERMS_LEN];
 } av_extended_perms_t;
=20
+typedef enum name_trans_match {
+	NAME_TRANS_MATCH_EXACT,
+	NAME_TRANS_MATCH_PREFIX,
+	NAME_TRANS_MATCH_SUFFIX,
+} name_trans_match_t;
+
 typedef struct avrule {
 /* these typedefs are almost exactly the same as those in avtab.h - they=
 are
  * here because of the need to include neverallow and dontaudit messages=
 */
@@ -723,10 +729,11 @@ extern int policydb_set_target_platform(policydb_t =
*p, int platform);
 #define POLICYDB_VERSION_GLBLUB		32
 #define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitio=
ns */
 #define POLICYDB_VERSION_AVTAB_FTRANS	34 /* filename transitions moved t=
o avtab */
+#define POLICYDB_VERSION_PREFIX_SUFFIX	35 /* prefix/suffix support for f=
ilename transitions */
=20
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_AVTAB_FTRANS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PREFIX_SUFFIX
=20
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 33441a34..45cbb3a1 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -327,6 +327,10 @@ void avtab_trans_destroy(avtab_trans_t *trans)
 {
 	hashtab_map(trans->name_trans.table, avtab_trans_destroy_helper, NULL);
 	symtab_destroy(&trans->name_trans);
+	hashtab_map(trans->prefix_trans.table, avtab_trans_destroy_helper, NULL=
);
+	symtab_destroy(&trans->prefix_trans);
+	hashtab_map(trans->suffix_trans.table, avtab_trans_destroy_helper, NULL=
);
+	symtab_destroy(&trans->suffix_trans);
 }
=20
 void avtab_destroy(avtab_t * h)
@@ -520,6 +524,15 @@ static int avtab_trans_read(policy_file_t *fp, uint3=
2_t vers,
 	if (rc < 0)
 		goto bad;
=20
+	if (vers >=3D POLICYDB_VERSION_PREFIX_SUFFIX) {
+		rc =3D avtab_read_name_trans(fp, &trans->prefix_trans);
+		if (rc < 0)
+			goto bad;
+		rc =3D avtab_read_name_trans(fp, &trans->suffix_trans);
+		if (rc < 0)
+			goto bad;
+	}
+
 	return SEPOL_OK;
=20
 bad:
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 655581ef..fd036fa9 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1706,9 +1706,24 @@ static int name_trans_to_strs_helper(hashtab_key_t=
 k, hashtab_datum_t d, void *a
 	char *name =3D k;
 	uint32_t *otype =3D d;
 	name_trans_to_strs_args_t *args =3D a;
-	return strs_create_and_add(args->strs, "(%s %s %s %s \"%s\" %s)", 6,
+	const char *match_str =3D "";
+	switch (args->match) {
+	case NAME_TRANS_MATCH_EXACT:
+		match_str =3D "";
+		break;
+	case NAME_TRANS_MATCH_PREFIX:
+		match_str =3D " MATCH_PREFIX";
+		break;
+	case NAME_TRANS_MATCH_SUFFIX:
+		match_str =3D " MATCH_SUFFIX";
+		break;
+	default:
+		sepol_log_err("Unknown name match type: %" PRIu8, args->match);
+		return SEPOL_ERR;
+	}
+	return strs_create_and_add(args->strs, "(%s %s %s %s \"%s\"%s %s)", 6,
 				   args->flavor, args->src, args->tgt,
-				   args->class, name,
+				   args->class, name, match_str,
 				   args->pdb->p_type_val_to_name[*otype - 1]);
 }
=20
@@ -1796,9 +1811,20 @@ static int avtab_node_to_strs(struct policydb *pdb=
, avtab_key_t *key, avtab_datu
 			.src =3D src,
 			.tgt =3D tgt,
 			.class =3D class,
+			.match =3D NAME_TRANS_MATCH_EXACT,
 		};
 		rc =3D hashtab_map(datum->trans->name_trans.table,
 				 name_trans_to_strs_helper, &args);
+		if (rc < 0)
+			return rc;
+		args.match =3D NAME_TRANS_MATCH_PREFIX;
+		rc =3D hashtab_map(datum->trans->prefix_trans.table,
+				 name_trans_to_strs_helper, &args);
+		if (rc < 0)
+			return rc;
+		args.match =3D NAME_TRANS_MATCH_SUFFIX;
+		rc =3D hashtab_map(datum->trans->suffix_trans.table,
+				 name_trans_to_strs_helper, &args);
 	} else {
 		new =3D pdb->p_type_val_to_name[data - 1];
=20
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_com=
mon.h
index eee2e1a0..2a1cae85 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -90,6 +90,7 @@ typedef struct {
 	const char *src;
 	const char *tgt;
 	const char *class;
+	name_trans_match_t match;
 } name_trans_to_strs_args_t;
=20
 __attribute__ ((format(printf, 1, 2)))
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
index 065f84eb..50fad1fb 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1684,11 +1684,26 @@ static int name_trans_to_strs_helper(hashtab_key_=
t k, hashtab_datum_t d, void *a
 	char *name =3D k;
 	uint32_t *otype =3D d;
 	name_trans_to_strs_args_t *args =3D a;
-	return strs_create_and_add(args->strs, "%s %s %s:%s %s \"%s\";", 6,
+	const char *match_str =3D "";
+	switch (args->match) {
+	case NAME_TRANS_MATCH_EXACT:
+		match_str =3D "";
+		break;
+	case NAME_TRANS_MATCH_PREFIX:
+		match_str =3D " MATCH_PREFIX";
+		break;
+	case NAME_TRANS_MATCH_SUFFIX:
+		match_str =3D " MATCH_SUFFIX";
+		break;
+	default:
+		sepol_log_err("Unknown name match type: %" PRIu8, args->match);
+		return SEPOL_ERR;
+	}
+	return strs_create_and_add(args->strs, "%s %s %s:%s %s \"%s\"%s;", 6,
 				   args->flavor, args->src, args->tgt,
 				   args->class,
 				   args->pdb->p_type_val_to_name[*otype - 1],
-				   name);
+				   name, match_str);
 }
=20
 static int avtab_node_to_strs(struct policydb *pdb, avtab_key_t *key, av=
tab_datum_t *datum, struct strs *strs)
@@ -1772,9 +1787,20 @@ static int avtab_node_to_strs(struct policydb *pdb=
, avtab_key_t *key, avtab_datu
 			.src =3D src,
 			.tgt =3D tgt,
 			.class =3D class,
+			.match =3D NAME_TRANS_MATCH_EXACT,
 		};
 		rc =3D hashtab_map(datum->trans->name_trans.table,
 				 name_trans_to_strs_helper, &args);
+		if (rc < 0)
+			return rc;
+		args.match =3D NAME_TRANS_MATCH_PREFIX;
+		rc =3D hashtab_map(datum->trans->prefix_trans.table,
+				 name_trans_to_strs_helper, &args);
+		if (rc < 0)
+			return rc;
+		args.match =3D NAME_TRANS_MATCH_SUFFIX;
+		rc =3D hashtab_map(datum->trans->suffix_trans.table,
+				 name_trans_to_strs_helper, &args);
 	} else {
 		new =3D pdb->p_type_val_to_name[data - 1];
=20
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 3776292a..bd1a151d 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -215,6 +215,13 @@ static const struct policydb_compat_info policydb_co=
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
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
index 66e8cb54..74f56842 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -851,11 +851,17 @@ static int validate_avtab_key_and_datum(avtab_key_t=
 *k, avtab_datum_t *d, void *
=20
 		/* also each transition must be non empty */
 		if (!d->trans->otype &&
-		    (!d->trans->name_trans.table || !d->trans->name_trans.table->nel))
+		    hashtab_is_empty(d->trans->name_trans.table) &&
+		    hashtab_is_empty(d->trans->prefix_trans.table) &&
+		    hashtab_is_empty(d->trans->suffix_trans.table))
 			return -1;
=20
-		/* and each filename transition must be also valid */
+		/* and each name transition must be also valid */
 		if (hashtab_map(d->trans->name_trans.table,
+				validate_name_trans_helper, margs) ||
+		    hashtab_map(d->trans->prefix_trans.table,
+				validate_name_trans_helper, margs) ||
+		    hashtab_map(d->trans->suffix_trans.table,
 				validate_name_trans_helper, margs))
 			return -1;
 	} else if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data, =
margs->policy, margs->flavors)) {
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 5ba3f2b0..92a7b6cf 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -133,16 +133,43 @@ static int avtab_trans_write(policydb_t *p, const a=
vtab_trans_t *cur,
 	uint32_t buf32[2];
=20
 	if (p->policyvers >=3D POLICYDB_VERSION_AVTAB_FTRANS) {
-		/* write otype and number of filename transitions */
+		/* write otype and number of name transitions */
 		buf32[0] =3D cpu_to_le32(cur->otype);
 		buf32[1] =3D cpu_to_le32(hashtab_nel(cur->name_trans.table));
 		items =3D put_entry(buf32, sizeof(uint32_t), 2, fp);
 		if (items !=3D 2)
 			return -1;
=20
-		/* write filename transitions */
-		return hashtab_map(cur->name_trans.table,
-				   avtab_trans_write_helper, fp);
+		/* write name transitions */
+		if (hashtab_map(cur->name_trans.table,
+				avtab_trans_write_helper, fp))
+			return -1;
+
+		if (p->policyvers >=3D POLICYDB_VERSION_PREFIX_SUFFIX) {
+			/* write number of prefix transitions */
+			buf32[0] =3D cpu_to_le32(hashtab_nel(
+					cur->prefix_trans.table));
+			items =3D put_entry(buf32, sizeof(uint32_t), 1, fp);
+			if (items !=3D 1)
+				return -1;
+
+			/* write prefix transitions */
+			if (hashtab_map(cur->prefix_trans.table,
+					avtab_trans_write_helper, fp))
+				return -1;
+
+			/* write number of suffix transitions */
+			buf32[0] =3D cpu_to_le32(hashtab_nel(
+					cur->suffix_trans.table));
+			items =3D put_entry(buf32, sizeof(uint32_t), 1, fp);
+			if (items !=3D 1)
+				return -1;
+
+			/* write suffix transitions */
+			if (hashtab_map(cur->suffix_trans.table,
+					avtab_trans_write_helper, fp))
+				return -1;
+		}
 	} else if (cur->otype) {
 		buf32[0] =3D cpu_to_le32(cur->otype);
 		items =3D put_entry(buf32, sizeof(uint32_t), 1, fp);
@@ -2519,6 +2546,22 @@ static int avtab_has_filename_transitions(avtab_t =
*a)
 	return 0;
 }
=20
+static int avtab_has_prefix_suffix_filename_transitions(avtab_t *a)
+{
+	uint32_t i;
+	struct avtab_node *cur;
+	for (i =3D 0; i < a->nslot; i++) {
+		for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
+			if (cur->key.specified & AVTAB_TRANSITION) {
+				if (hashtab_nel(cur->datum.trans->prefix_trans.table)
+				    || hashtab_nel(cur->datum.trans->suffix_trans.table))
+					return 1;
+			}
+		}
+	}
+	return 0;
+}
+
 /*
  * Write the configuration data in a policy database
  * structure to a policy database binary representation
@@ -2685,6 +2728,10 @@ int policydb_write(policydb_t * p, struct policy_f=
ile *fp)
 	if (p->policy_type =3D=3D POLICY_KERN) {
 		if (avtab_write(p, &p->te_avtab, fp))
 			return POLICYDB_ERROR;
+		if (avtab_has_prefix_suffix_filename_transitions(&p->te_avtab)) {
+			WARN(fp->handle,
+			     "Discarding filename prefix/suffix type transition rules");
+		}
 		if (p->policyvers < POLICYDB_VERSION_BOOL) {
 			if (p->p_bools.nprim)
 				WARN(fp->handle, "Discarding "
--=20
2.40.0

