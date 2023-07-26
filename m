Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0694BC001DF
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 14:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjGZO0B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjGZOZ7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 10:25:59 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B629188
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:25:57 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a3790a0a48so4983790b6e.1
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381556; x=1690986356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLEYzh6JidfFIpdAlUcErWyClrJJVOubSE6R4Rudx2c=;
        b=DmPhVPbVsXsSkMnUAHvVuIclOenayEJt5ds4DAZKuPhnqefrszckSFMqaSJCrMnUpE
         Y3Az/suhD693tYT8mRplYZPYEn077vJSyeHQKuejg2ZwRfIdcWOYLvwA83mxMgjF7X2w
         U0RRFqDXMdQ9EVFF8zWwIoovAKeeYpu1+XSq2FGu1EtY1ZVoPgIraEFzEv2Tu2JlG2v+
         VMff7MGbPgg1sINmCxPGuvr8sc+3Fdnb7RNJqFr6RizVXZVtHtK8Hoze/ZHYRB2Rik3O
         7KdxydpSBxOLa8Z55+ZCTGG1/I280kUTyBq3Oj5cYu59DrTtXt72SRfCkC0kr5qdyTEb
         ejkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381556; x=1690986356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLEYzh6JidfFIpdAlUcErWyClrJJVOubSE6R4Rudx2c=;
        b=mFwfgcUW/C/fv5W4zeAHyBzdugJBPyMj/py/Oam2hqJsSFctt+xOCytcHvMUi1u2P9
         i1NsdTxAqBh1bwe6GK7NbD8IZH4D5n6GhMMYb+5MI6LutHGRjuciy5EcnzMLjO+83OO9
         uandtlOF/NJ7UX+CeAlxXTYMXtBPSXcwt3kiIjifQRmVSimeQUKk1I3ANwam74/7LXXs
         3Zq40+XGeZG0mo1LEnVGwT1eGC6nLLM8e4lp+HiHN48sGahqxoHRU9esgOUiYHCJbw4m
         d25Pgtxh0Avtus1H9XCTxxe2f/QMgTUyw6hi7Dwj7ERNEpTpDHWLB4/3nkm/VycKPBzN
         hR2A==
X-Gm-Message-State: ABy/qLbvgJwZIcQlXl7QnT2q1BrWmbdTw8HNqH3BnDh8HLogQBcOoNOj
        j2u7e4hkkqB5eNG9tk+0szUcc6TL52o4KA==
X-Google-Smtp-Source: APBJJlFwxXbzbtaiDiV7iht3UUtaMSxSOXDWKIzcdGzRiRNIs2FW195bu90nwWftcW8PyP/JBx1SzQ==
X-Received: by 2002:a05:6808:178d:b0:3a3:654d:b2e5 with SMTP id bg13-20020a056808178d00b003a3654db2e5mr2594603oib.42.1690381556204;
        Wed, 26 Jul 2023 07:25:56 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cf014000000b006362d4eeb6esm5066471qvk.144.2023.07.26.07.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:25:55 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     juraj@jurajmarcin.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/8] Revert "checkpolicy,libsepol: add prefix/suffix support to kernel policy"
Date:   Wed, 26 Jul 2023 10:25:44 -0400
Message-ID: <20230726142549.94685-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726142549.94685-1-jwcart2@gmail.com>
References: <20230726142549.94685-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This reverts commit 1174483d2924dc700673363b240fca2b9fe45786.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/test/dispol.c                  |  25 +----
 libsepol/include/sepol/policydb/avtab.h    |   2 -
 libsepol/include/sepol/policydb/policydb.h |   9 +-
 libsepol/src/avtab.c                       |  13 ---
 libsepol/src/kernel_to_cil.c               |  30 +-----
 libsepol/src/kernel_to_common.h            |   1 -
 libsepol/src/kernel_to_conf.c              |  30 +-----
 libsepol/src/policydb.c                    |   7 --
 libsepol/src/policydb_validate.c           |  11 +-
 libsepol/src/write.c                       | 113 ++++-----------------
 10 files changed, 30 insertions(+), 211 deletions(-)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 776bf54d..861fa903 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -129,7 +129,6 @@ typedef struct {
 	avtab_key_t *key;
 	policydb_t *p;
 	FILE *fp;
-	name_trans_match_t match;
 } render_name_trans_args_t;
 
 static int render_name_trans_helper(hashtab_key_t k, hashtab_datum_t d, void *a)
@@ -141,22 +140,7 @@ static int render_name_trans_helper(hashtab_key_t k, hashtab_datum_t d, void *a)
 	fprintf(args->fp, "type_transition ");
 	render_key(args->key, args->p, args->fp);
 	render_type(*otype, args->p, args->fp);
-	const char *match_str = "";
-	switch (args->match) {
-	case NAME_TRANS_MATCH_EXACT:
-		match_str = "";
-		break;
-	case NAME_TRANS_MATCH_PREFIX:
-		match_str = " PREFIX";
-		break;
-	case NAME_TRANS_MATCH_SUFFIX:
-		match_str = " SUFFIX";
-		break;
-	default:
-		fprintf(args->fp, "     ERROR: no valid name match type specified\n");
-		return -1;
-	}
-	fprintf(args->fp, " \"%s\"%s;\n", name, match_str);
+	fprintf(args->fp, " \"%s\";\n", name);
 
 	return 0;
 }
@@ -223,16 +207,9 @@ static int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t wha
 				.key = key,
 				.p = p,
 				.fp = fp,
-				.match = NAME_TRANS_MATCH_EXACT,
 			};
 			hashtab_map(datum->trans->name_trans.table,
 				    render_name_trans_helper, &args);
-			args.match = NAME_TRANS_MATCH_PREFIX;
-			hashtab_map(datum->trans->prefix_trans.table,
-				    render_name_trans_helper, &args);
-			args.match = NAME_TRANS_MATCH_SUFFIX;
-			hashtab_map(datum->trans->suffix_trans.table,
-				    render_name_trans_helper, &args);
 		}
 		if (key->specified & AVTAB_MEMBER) {
 			fprintf(fp, "type_member ");
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 870fb08a..5dc720cc 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -74,8 +74,6 @@ typedef struct avtab_key {
 typedef struct avtab_trans {
 	uint32_t otype;		/* resulting type of the new object */
 	symtab_t name_trans;	/* filename transitions */
-	symtab_t prefix_trans;	/* prefix filename transitions */
-	symtab_t suffix_trans;	/* prefix filename transitions */
 } avtab_trans_t;
 
 typedef struct avtab_extended_perms {
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index a2df4a62..5efd0a47 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -252,12 +252,6 @@ typedef struct av_extended_perms {
 	uint32_t perms[EXTENDED_PERMS_LEN];
 } av_extended_perms_t;
 
-typedef enum name_trans_match {
-	NAME_TRANS_MATCH_EXACT,
-	NAME_TRANS_MATCH_PREFIX,
-	NAME_TRANS_MATCH_SUFFIX,
-} name_trans_match_t;
-
 typedef struct avrule {
 /* these typedefs are almost exactly the same as those in avtab.h - they are
  * here because of the need to include neverallow and dontaudit messages */
@@ -729,11 +723,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_GLBLUB		32
 #define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitions */
 #define POLICYDB_VERSION_AVTAB_FTRANS	34 /* filename transitions moved to avtab */
-#define POLICYDB_VERSION_PREFIX_SUFFIX	35 /* prefix/suffix support for filename transitions */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PREFIX_SUFFIX
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_AVTAB_FTRANS
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 90cfb90b..2a9564ba 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -327,10 +327,6 @@ void avtab_trans_destroy(avtab_trans_t *trans)
 {
 	hashtab_map(trans->name_trans.table, avtab_trans_destroy_helper, NULL);
 	symtab_destroy(&trans->name_trans);
-	hashtab_map(trans->prefix_trans.table, avtab_trans_destroy_helper, NULL);
-	symtab_destroy(&trans->prefix_trans);
-	hashtab_map(trans->suffix_trans.table, avtab_trans_destroy_helper, NULL);
-	symtab_destroy(&trans->suffix_trans);
 }
 
 void avtab_destroy(avtab_t * h)
@@ -524,15 +520,6 @@ static int avtab_trans_read(policy_file_t *fp, uint32_t vers,
 	if (rc < 0)
 		goto bad;
 
-	if (vers >= POLICYDB_VERSION_PREFIX_SUFFIX) {
-		rc = avtab_read_name_trans(fp, &trans->prefix_trans);
-		if (rc < 0)
-			goto bad;
-		rc = avtab_read_name_trans(fp, &trans->suffix_trans);
-		if (rc < 0)
-			goto bad;
-	}
-
 	return SEPOL_OK;
 
 bad:
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 30a67017..8ed695f1 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1705,24 +1705,9 @@ static int name_trans_to_strs_helper(hashtab_key_t k, hashtab_datum_t d, void *a
 	char *name = k;
 	uint32_t *otype = d;
 	name_trans_to_strs_args_t *args = a;
-	const char *match_str = "";
-	switch (args->match) {
-	case NAME_TRANS_MATCH_EXACT:
-		match_str = "";
-		break;
-	case NAME_TRANS_MATCH_PREFIX:
-		match_str = " prefix";
-		break;
-	case NAME_TRANS_MATCH_SUFFIX:
-		match_str = " suffix";
-		break;
-	default:
-		ERR(NULL, "Unknown name match type: %" PRIu8, args->match);
-		return SEPOL_ERR;
-	}
-	return strs_create_and_add(args->strs, "(%s %s %s %s \"%s\"%s %s)", 7,
+	return strs_create_and_add(args->strs, "(%s %s %s %s \"%s\" %s)", 6,
 				   args->flavor, args->src, args->tgt,
-				   args->class, name, match_str,
+				   args->class, name,
 				   args->pdb->p_type_val_to_name[*otype - 1]);
 }
 
@@ -1810,20 +1795,9 @@ static int avtab_node_to_strs(struct policydb *pdb, avtab_key_t *key, avtab_datu
 			.src = src,
 			.tgt = tgt,
 			.class = class,
-			.match = NAME_TRANS_MATCH_EXACT,
 		};
 		rc = hashtab_map(datum->trans->name_trans.table,
 				 name_trans_to_strs_helper, &args);
-		if (rc < 0)
-			return rc;
-		args.match = NAME_TRANS_MATCH_PREFIX;
-		rc = hashtab_map(datum->trans->prefix_trans.table,
-				 name_trans_to_strs_helper, &args);
-		if (rc < 0)
-			return rc;
-		args.match = NAME_TRANS_MATCH_SUFFIX;
-		rc = hashtab_map(datum->trans->suffix_trans.table,
-				 name_trans_to_strs_helper, &args);
 	} else {
 		new = pdb->p_type_val_to_name[data - 1];
 
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index 07869e3d..b8ea237d 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -90,7 +90,6 @@ typedef struct {
 	const char *src;
 	const char *tgt;
 	const char *class;
-	name_trans_match_t match;
 } name_trans_to_strs_args_t;
 
 void sepol_indent(FILE *out, int indent);
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index b1699b39..eb14ccf1 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1683,26 +1683,11 @@ static int name_trans_to_strs_helper(hashtab_key_t k, hashtab_datum_t d, void *a
 	char *name = k;
 	uint32_t *otype = d;
 	name_trans_to_strs_args_t *args = a;
-	const char *match_str = "";
-	switch (args->match) {
-	case NAME_TRANS_MATCH_EXACT:
-		match_str = "";
-		break;
-	case NAME_TRANS_MATCH_PREFIX:
-		match_str = " PREFIX";
-		break;
-	case NAME_TRANS_MATCH_SUFFIX:
-		match_str = " SUFFIX";
-		break;
-	default:
-		ERR(NULL, "Unknown name match type: %" PRIu8, args->match);
-		return SEPOL_ERR;
-	}
-	return strs_create_and_add(args->strs, "%s %s %s:%s %s \"%s\"%s;", 7,
+	return strs_create_and_add(args->strs, "%s %s %s:%s %s \"%s\";", 6,
 				   args->flavor, args->src, args->tgt,
 				   args->class,
 				   args->pdb->p_type_val_to_name[*otype - 1],
-				   name, match_str);
+				   name);
 }
 
 static int avtab_node_to_strs(struct policydb *pdb, avtab_key_t *key, avtab_datum_t *datum, struct strs *strs)
@@ -1786,20 +1771,9 @@ static int avtab_node_to_strs(struct policydb *pdb, avtab_key_t *key, avtab_datu
 			.src = src,
 			.tgt = tgt,
 			.class = class,
-			.match = NAME_TRANS_MATCH_EXACT,
 		};
 		rc = hashtab_map(datum->trans->name_trans.table,
 				 name_trans_to_strs_helper, &args);
-		if (rc < 0)
-			return rc;
-		args.match = NAME_TRANS_MATCH_PREFIX;
-		rc = hashtab_map(datum->trans->prefix_trans.table,
-				 name_trans_to_strs_helper, &args);
-		if (rc < 0)
-			return rc;
-		args.match = NAME_TRANS_MATCH_SUFFIX;
-		rc = hashtab_map(datum->trans->suffix_trans.table,
-				 name_trans_to_strs_helper, &args);
 	} else {
 		new = pdb->p_type_val_to_name[data - 1];
 
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index f1f6cec6..37bb97a1 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -215,13 +215,6 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
-	{
-	 .type = POLICY_KERN,
-	 .version = POLICYDB_VERSION_PREFIX_SUFFIX,
-	 .sym_num = SYM_NUM,
-	 .ocon_num = OCON_IBENDPORT + 1,
-	 .target_platform = SEPOL_TARGET_SELINUX,
-	},
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 08b4a477..0b8e8eee 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -855,18 +855,11 @@ static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d, void *
 
 		/* also each transition must be non empty */
 		if (!d->trans->otype &&
-		    !hashtab_nel(d->trans->name_trans.table) &&
-		    !hashtab_nel(d->trans->name_trans.table) &&
-		    !hashtab_nel(d->trans->prefix_trans.table) &&
-		    !hashtab_nel(d->trans->suffix_trans.table))
+		    !hashtab_nel(d->trans->name_trans.table))
 			return -1;
 
-		/* and each name transition must be also valid */
+		/* and each filename transition must be also valid */
 		if (hashtab_map(d->trans->name_trans.table,
-				validate_name_trans_helper, margs) ||
-		    hashtab_map(d->trans->prefix_trans.table,
-				validate_name_trans_helper, margs) ||
-		    hashtab_map(d->trans->suffix_trans.table,
 				validate_name_trans_helper, margs))
 			return -1;
 	} else if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data, margs->policy, margs->flavors)) {
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index df47197c..d7f47c8d 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -133,43 +133,16 @@ static int avtab_trans_write(policydb_t *p, const avtab_trans_t *cur,
 	uint32_t buf32[2];
 
 	if (p->policyvers >= POLICYDB_VERSION_AVTAB_FTRANS) {
-		/* write otype and number of name transitions */
+		/* write otype and number of filename transitions */
 		buf32[0] = cpu_to_le32(cur->otype);
 		buf32[1] = cpu_to_le32(hashtab_nel(cur->name_trans.table));
 		items = put_entry(buf32, sizeof(uint32_t), 2, fp);
 		if (items != 2)
 			return -1;
 
-		/* write name transitions */
-		if (hashtab_map(cur->name_trans.table,
-				avtab_trans_write_helper, fp))
-			return -1;
-
-		if (p->policyvers >= POLICYDB_VERSION_PREFIX_SUFFIX) {
-			/* write number of prefix transitions */
-			buf32[0] = cpu_to_le32(hashtab_nel(
-					cur->prefix_trans.table));
-			items = put_entry(buf32, sizeof(uint32_t), 1, fp);
-			if (items != 1)
-				return -1;
-
-			/* write prefix transitions */
-			if (hashtab_map(cur->prefix_trans.table,
-					avtab_trans_write_helper, fp))
-				return -1;
-
-			/* write number of suffix transitions */
-			buf32[0] = cpu_to_le32(hashtab_nel(
-					cur->suffix_trans.table));
-			items = put_entry(buf32, sizeof(uint32_t), 1, fp);
-			if (items != 1)
-				return -1;
-
-			/* write suffix transitions */
-			if (hashtab_map(cur->suffix_trans.table,
-					avtab_trans_write_helper, fp))
-				return -1;
-		}
+		/* write filename transitions */
+		return hashtab_map(cur->name_trans.table,
+				   avtab_trans_write_helper, fp);
 	} else if (cur->otype) {
 		buf32[0] = cpu_to_le32(cur->otype);
 		items = put_entry(buf32, sizeof(uint32_t), 1, fp);
@@ -195,26 +168,14 @@ static int avtab_write_item(policydb_t * p,
 
 	/*
 	 * skip entries which only contain filename transitions in versions
-	 * before filename transitions were moved to avtab,
-	 * skip entries which only contain prefix/suffix transitions in versions
-	 * before prefix/suffix filename transitions
+	 * before filename transitions were moved to avtab
 	 */
-	if (cur->key.specified & AVTAB_TRANSITION) {
-		if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS &&
-		    cur->key.specified & AVTAB_TRANSITION &&
-		    !cur->datum.trans->otype) {
-                        /*
-                         * if oldvers, reduce nel, because this node will be
-                         * skipped
-			 */
-                        if (oldvers && nel)
-				(*nel)--;
-			return 0;
-		}
-		if (p->policyvers < POLICYDB_VERSION_PREFIX_SUFFIX &&
-		    !cur->datum.trans->otype &&
-		    !hashtab_nel(cur->datum.trans->name_trans.table))
-			return 0;
+	if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS &&
+	    cur->key.specified & AVTAB_TRANSITION && !cur->datum.trans->otype) {
+		/* if oldvers, reduce nel, because this node will be skipped */
+		if (oldvers && nel)
+			(*nel)--;
+		return 0;
 	}
 
 	if (oldvers) {
@@ -417,27 +378,17 @@ static int avtab_write(struct policydb *p, avtab_t * a, struct policy_file *fp)
 		 * filename transitions.
 		 */
 		nel = a->nel;
-		for (i = 0; i < a->nslot; i++) {
-			for (cur = a->htable[i]; cur; cur = cur->next) {
-				if (!(cur->key.specified & AVTAB_TRANSITION))
-					continue;
-                                if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS &&
-				    !cur->datum.trans->otype) {
-                                        /*
-                                         * entries containing only filename
-                                         * transitions are skipped and written
-                                         * out later
-                                         */
-                                        nel--;
-				} else if (p->policyvers < POLICYDB_VERSION_PREFIX_SUFFIX &&
-					   !cur->datum.trans->otype &&
-					   !hashtab_nel(cur->datum.trans->name_trans.table)) {
-					/*
-					 * entries containing only prefix/suffix
-					 * transitions are not supported in
-					 * previous versions
-					 */
-					nel--;
+		if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS) {
+			/*
+			 * entries containing only filename transitions are
+			 * skipped and written out later
+			 */
+			for (i = 0; i < a->nslot; i++) {
+				for (cur = a->htable[i]; cur; cur = cur->next) {
+					if ((cur->key.specified
+					     & AVTAB_TRANSITION) &&
+					    !cur->datum.trans->otype)
+						nel--;
 				}
 			}
 		}
@@ -2569,22 +2520,6 @@ static int avtab_has_filename_transitions(avtab_t *a)
 	return 0;
 }
 
-static int avtab_has_prefix_suffix_filename_transitions(avtab_t *a)
-{
-	uint32_t i;
-	struct avtab_node *cur;
-	for (i = 0; i < a->nslot; i++) {
-		for (cur = a->htable[i]; cur; cur = cur->next) {
-			if (cur->key.specified & AVTAB_TRANSITION) {
-				if (hashtab_nel(cur->datum.trans->prefix_trans.table)
-				    || hashtab_nel(cur->datum.trans->suffix_trans.table))
-					return 1;
-			}
-		}
-	}
-	return 0;
-}
-
 /*
  * Write the configuration data in a policy database
  * structure to a policy database binary representation
@@ -2751,10 +2686,6 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 	if (p->policy_type == POLICY_KERN) {
 		if (avtab_write(p, &p->te_avtab, fp))
 			return POLICYDB_ERROR;
-		if (avtab_has_prefix_suffix_filename_transitions(&p->te_avtab)) {
-			WARN(fp->handle,
-			     "Discarding filename prefix/suffix type transition rules");
-		}
 		if (p->policyvers < POLICYDB_VERSION_BOOL) {
 			if (p->p_bools.nprim)
 				WARN(fp->handle, "Discarding "
-- 
2.41.0

