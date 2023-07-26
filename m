Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59951C001DC
	for <selinux@archiver.kernel.org>; Wed, 26 Jul 2023 14:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjGZO0C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjGZO0B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jul 2023 10:26:01 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB57E4D
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:25:59 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9c57c4d12so5430730a34.1
        for <selinux@vger.kernel.org>; Wed, 26 Jul 2023 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381558; x=1690986358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpBR41DJTJEZdtrQT+uRJvpbMCAqB6uKcRO5S+6upyE=;
        b=WFJwXYipIw3oPb4c8H/YLSWl0LH7QSYo56aqbw7QB2hFDZdC2jVV7PFt3QpIA0c1Sc
         U9E2Ot0LbN2+/0CLj29u/8afV0TX+koyoIPsbJUxnotzKOPRYpRH3k4X54QkBd4RBeOp
         pyQ7hDmWPAkzLgrgIIFz09nweXnfF34WGyiPO/HLy2ok85QkZ0yKTj9/Kk/sG+pOrsTY
         4Vjwi34aMonv+0gZYvF5KhWwkx5Q5kfe+B/uZ1u05e07qg1bKdO358LlJKANIj6LBikp
         ut75jFUAUzRB/7fqUPO6hNThapTj7+d8MeCSstlXNoMUYhS7kKUfXx3GIUQcufKnNUaG
         v9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381558; x=1690986358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpBR41DJTJEZdtrQT+uRJvpbMCAqB6uKcRO5S+6upyE=;
        b=ha5YkGv/BNEB7obybbRYhul1KWof2XgiMS5Sz2XQJO5HGyAiirS/u+HZV8qp91bKSt
         5P97ZlB18birExhhNyN3kQxqjYzHchDfqZxBph7ACkIDYVsHTK+D/dOnODU0cZJnJO62
         UP03JLVGEurTjGnZ3Ar38ws11wVGhP5wShcs3WIMLvKeSrbFNsG1JzpUVED12mDFsnM1
         8Zwk/V7mYcInc22WAUA9guX7VM3NLzOnJBdWjeOz0FrfUeVNUa+YkFdnPlIEtWb8E7A2
         WDpvgkRxCKhzq05ryhH5dbpV9VDtnesS+wq7m2BFth1I4UbsGleA3okbXJ8EXgUZ6/Be
         U5Ew==
X-Gm-Message-State: ABy/qLYnLNpUc0MBsOJXEReYUlZDjRcLbewCL6cxqvyEztAapwhlJN9O
        xHQjlTRPtiR+iDpFKu9xIkHXMYmPIJPvSQ==
X-Google-Smtp-Source: APBJJlFWeDwmzRZt/Iv+QfnXAf4fgT17P1FLCTOywgjmJgqsiuYf9SaxrwuQTgfKvT0UR0dnqTMDgQ==
X-Received: by 2002:a05:6808:3095:b0:3a4:19fd:672 with SMTP id bl21-20020a056808309500b003a419fd0672mr2875696oib.36.1690381558065;
        Wed, 26 Jul 2023 07:25:58 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id z20-20020a0cf014000000b006362d4eeb6esm5066471qvk.144.2023.07.26.07.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:25:57 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     juraj@jurajmarcin.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/8] Revert "libsepol: implement new kernel binary format for avtab"
Date:   Wed, 26 Jul 2023 10:25:46 -0400
Message-ID: <20230726142549.94685-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726142549.94685-1-jwcart2@gmail.com>
References: <20230726142549.94685-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This reverts commit 7b77edd91946d8a415cddc596765d8c2e8bd6f63.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/include/sepol/policydb/policydb.h |  3 +-
 libsepol/src/avtab.c                       | 88 ++--------------------
 libsepol/src/policydb.c                    |  8 --
 libsepol/src/write.c                       | 86 ++++-----------------
 4 files changed, 21 insertions(+), 164 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 528c1cad..d30f26af 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -722,11 +722,10 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_INFINIBAND		31 /* Linux-specific */
 #define POLICYDB_VERSION_GLBLUB		32
 #define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitions */
-#define POLICYDB_VERSION_AVTAB_FTRANS	34 /* filename transitions moved to avtab */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_AVTAB_FTRANS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_COMP_FTRANS
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 2a9564ba..eef259cf 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -446,87 +446,6 @@ void avtab_hash_eval(avtab_t * h, char *tag)
 	     tag, h->nel, slots_used, h->nslot, max_chain_len);
 }
 
-static int avtab_read_name_trans(policy_file_t *fp, symtab_t *target)
-{
-	int rc;
-	uint32_t buf32[2], nel, i, len, *otype = NULL;
-	char *name = NULL;
-
-	/* read number of name transitions */
-	rc = next_entry(buf32, fp, sizeof(uint32_t) * 1);
-	if (rc < 0)
-		return rc;
-	nel = le32_to_cpu(buf32[0]);
-
-	rc = symtab_init(target, nel);
-	if (rc < 0)
-		return rc;
-
-	/* read name transitions */
-	for (i = 0; i < nel; i++) {
-		rc = SEPOL_ENOMEM;
-		otype = malloc(sizeof(uint32_t));
-		if (!otype)
-			goto exit;
-
-		/* read name transition otype and name length */
-		rc = next_entry(buf32, fp, sizeof(uint32_t) * 2);
-		if (rc < 0)
-			goto exit;
-		*otype = le32_to_cpu(buf32[0]);
-		len = le32_to_cpu(buf32[1]);
-
-		/* read the name */
-		rc = str_read(&name, fp, len);
-		if (rc < 0)
-			goto exit;
-
-		rc = hashtab_insert(target->table, name, otype);
-		if (rc < 0)
-			goto exit;
-		otype = NULL;
-		name = NULL;
-	}
-
-exit:
-	free(otype);
-	free(name);
-	return rc;
-}
-
-static int avtab_trans_read(policy_file_t *fp, uint32_t vers,
-			    avtab_trans_t *trans)
-{
-	int rc;
-	uint32_t buf32[1];
-
-	if (vers < POLICYDB_VERSION_AVTAB_FTRANS) {
-		rc = next_entry(buf32, fp, sizeof(uint32_t));
-		if (rc < 0) {
-			ERR(fp->handle, "truncated entry");
-			return SEPOL_ERR;
-		}
-		trans->otype = le32_to_cpu(*buf32);
-		return SEPOL_OK;
-	}
-
-	/* read otype */
-	rc = next_entry(buf32, fp, sizeof(uint32_t) * 1);
-	if (rc < 0)
-		return rc;
-	trans->otype = le32_to_cpu(buf32[0]);
-
-	rc = avtab_read_name_trans(fp, &trans->name_trans);
-	if (rc < 0)
-		goto bad;
-
-	return SEPOL_OK;
-
-bad:
-	avtab_trans_destroy(trans);
-	return rc;
-}
-
 /* Ordering of datums in the original avtab format in the policy file. */
 static const uint16_t spec_order[] = {
 	AVTAB_ALLOWED,
@@ -690,9 +609,12 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 			xperms.perms[i] = le32_to_cpu(buf32[i]);
 		datum.xperms = &xperms;
 	} else if (key.specified & AVTAB_TRANSITION) {
-		rc = avtab_trans_read(fp, vers, &trans);
-		if (rc < 0)
+		rc = next_entry(buf32, fp, sizeof(uint32_t));
+		if (rc < 0) {
+			ERR(fp->handle, "truncated entry");
 			return -1;
+		}
+		trans.otype = le32_to_cpu(*buf32);
 		datum.trans = &trans;
 	} else {
 		rc = next_entry(buf32, fp, sizeof(uint32_t));
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index b15d4163..4913ee21 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -208,13 +208,6 @@ static const struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
-	{
-	 .type = POLICY_KERN,
-	 .version = POLICYDB_VERSION_AVTAB_FTRANS,
-	 .sym_num = SYM_NUM,
-	 .ocon_num = OCON_IBENDPORT + 1,
-	 .target_platform = SEPOL_TARGET_SELINUX,
-	},
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -4106,7 +4099,6 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		if (role_allow_read(&p->role_allow, fp))
 			goto bad;
 		if (r_policyvers >= POLICYDB_VERSION_FILENAME_TRANS &&
-		    r_policyvers < POLICYDB_VERSION_AVTAB_FTRANS &&
 		    avtab_filename_trans_read(fp, r_policyvers, &p->te_avtab))
 			goto bad;
 	} else {
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 68495198..2035b350 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -102,56 +102,6 @@ static uint16_t spec_order[] = {
 	AVTAB_MEMBER
 };
 
-static int avtab_trans_write_helper(hashtab_key_t hkey, hashtab_datum_t hdatum,
-				    void *fp)
-{
-	char *name = hkey;
-	uint32_t *otype = hdatum;
-	uint32_t buf32[2], len;
-	size_t items;
-
-	/* write filename transition otype and name length */
-	len = strlen(name);
-	buf32[0] = cpu_to_le32(*otype);
-	buf32[1] = cpu_to_le32(len);
-	items = put_entry(buf32, sizeof(uint32_t), 2, fp);
-	if (items != 2)
-		return -1;
-
-	/* write filename transition name */
-	items = put_entry(name, sizeof(char), len, fp);
-	if (items != len)
-		return -1;
-
-	return 0;
-}
-
-static int avtab_trans_write(policydb_t *p, const avtab_trans_t *cur,
-			     policy_file_t *fp)
-{
-	size_t items;
-	uint32_t buf32[2];
-
-	if (p->policyvers >= POLICYDB_VERSION_AVTAB_FTRANS) {
-		/* write otype and number of filename transitions */
-		buf32[0] = cpu_to_le32(cur->otype);
-		buf32[1] = cpu_to_le32(hashtab_nel(cur->name_trans.table));
-		items = put_entry(buf32, sizeof(uint32_t), 2, fp);
-		if (items != 2)
-			return -1;
-
-		/* write filename transitions */
-		return hashtab_map(cur->name_trans.table,
-				   avtab_trans_write_helper, fp);
-	} else if (cur->otype) {
-		buf32[0] = cpu_to_le32(cur->otype);
-		items = put_entry(buf32, sizeof(uint32_t), 1, fp);
-		if (items != 1)
-			return -1;
-	}
-	return 0;
-}
-
 static int avtab_write_item(policydb_t * p,
 			    avtab_ptr_t cur, struct policy_file *fp,
 			    unsigned merge, unsigned commit, uint32_t * nel)
@@ -166,12 +116,8 @@ static int avtab_write_item(policydb_t * p,
 				&& p->policyvers < POLICYDB_VERSION_AVTAB);
 	unsigned int i;
 
-	/*
-	 * skip entries which only contain filename transitions in versions
-	 * before filename transitions were moved to avtab
-	 */
-	if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS &&
-	    cur->key.specified & AVTAB_TRANSITION && !cur->datum.trans->otype) {
+	/* skip entries which only contain filename transitions */
+	if (cur->key.specified & AVTAB_TRANSITION && !cur->datum.trans->otype) {
 		/* if oldvers, reduce nel, because this node will be skipped */
 		if (oldvers && nel)
 			(*nel)--;
@@ -325,7 +271,9 @@ static int avtab_write_item(policydb_t * p,
 		if (items != 8)
 			return POLICYDB_ERROR;
 	} else if (cur->key.specified & AVTAB_TRANSITION) {
-		if (avtab_trans_write(p, cur->datum.trans, fp) < 0)
+		buf32[0] = cpu_to_le32(cur->datum.trans->otype);
+		items = put_entry(buf32, sizeof(uint32_t), 1, fp);
+		if (items != 1)
 			return POLICYDB_ERROR;
 	} else {
 		buf32[0] = cpu_to_le32(cur->datum.data);
@@ -378,18 +326,15 @@ static int avtab_write(struct policydb *p, avtab_t * a, struct policy_file *fp)
 		 * filename transitions.
 		 */
 		nel = a->nel;
-		if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS) {
-			/*
-			 * entries containing only filename transitions are
-			 * skipped and written out later
-			 */
-			for (i = 0; i < a->nslot; i++) {
-				for (cur = a->htable[i]; cur; cur = cur->next) {
-					if ((cur->key.specified
-					     & AVTAB_TRANSITION) &&
-					    !cur->datum.trans->otype)
-						nel--;
-				}
+		/*
+		 * entries containing only filename transitions are skipped and
+		 * written out later
+		 */
+		for (i = 0; i < a->nslot; i++) {
+			for (cur = a->htable[i]; cur; cur = cur->next) {
+				if (cur->key.specified & AVTAB_TRANSITION &&
+				    !cur->datum.trans->otype)
+					nel--;
 			}
 		}
 		nel = cpu_to_le32(nel);
@@ -2681,8 +2626,7 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 		if (role_allow_write(p->role_allow, fp))
 			return POLICYDB_ERROR;
 		if (p->policyvers >= POLICYDB_VERSION_FILENAME_TRANS) {
-			if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS &&
-			    avtab_filename_trans_write(p, &p->te_avtab, fp))
+			if (avtab_filename_trans_write(p, &p->te_avtab, fp))
 				return POLICYDB_ERROR;
 		} else if (avtab_has_filename_transitions(&p->te_avtab)) {
 			WARN(fp->handle,
-- 
2.41.0

