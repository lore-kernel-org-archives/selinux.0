Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B5DC4332F
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjKINvc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKINvb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:51:31 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87081718
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:51:28 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1408483a12.0
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699537887; x=1700142687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKVMCIRV/AuXnz+tVgEzna5dSXNCWDnPusenuvAQ9s8=;
        b=CMIcaBS+HO0DUz3RCOeN+qr6SQqm8ZF0VkWthHE5yQbVGBBTwUXT2ab1i5Rc+h7fyn
         BnkTcKIsRHC1slgC6QL+dcxgc3lvZVasF3o/Io3hPfyc4rVzyj0Xvp5PmsHoFvLazRyc
         1GgtNMIvhy5NxKd9321euflsaZILV6B/TUdNhDJXVomIqTgpekXiDv95iN9eLpDfS1LF
         filjPik2Bk7xmJVPq5K3/gC62OshS1sF/7Reb5L4HLGnnln8XEn4FxjRl9+ldoXRfMDq
         HdsT41QH7ms9xXW+tfelNA6fgUMWcIrVKmcdrEpA6WvlRMWp6O0H2+Ym7cA8FbZotx9T
         V/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699537887; x=1700142687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKVMCIRV/AuXnz+tVgEzna5dSXNCWDnPusenuvAQ9s8=;
        b=css+f4W23JIF1JOGwpBf9r7/ocNjmXF3z84Xc/PyjBv+Pu9h6o0VRjeRkDf8hTYioj
         CFeijv+xQhq0RGeQb1tRkCJSsKZIVnthqSJz/gnJGLSGDWSUM741RjH8oSF05vzHPamw
         Us8HSfbXtAKuzN9riTBOUX/nSWqM2yqnTPzcRHWpXHcxkBk871Gqv+0xqwBRaUtIoTA+
         Z5hbod3qwqXvG/f9qOLFz1XEHpKG65N3zJryRy4Pzl19mIzc2A/xFepvxeGL0XCfiCJG
         L5XmB1tDjmwUN4DsiN+Y5s6ond1LPrXdxx3zM4eBYACu+TxHhMH2eCXmU31OfQ+W/PHz
         hlQA==
X-Gm-Message-State: AOJu0YwLNTy33eslsRKLVeUFkiEdCh1PmFDTUmT9WCRlXFROs62J/cpU
        DT2kVKEcFBakKND17kHLg13O9EDsIxc=
X-Google-Smtp-Source: AGHT+IEGmnP/GaUif7+TXNawKs/tSv7LFscTTri/T3AR24TUE228zNQz6YRHEbwcUBLnopIWGvwCpg==
X-Received: by 2002:a17:907:787:b0:9bd:ff07:a586 with SMTP id xd7-20020a170907078700b009bdff07a586mr4219973ejb.68.1699537886803;
        Thu, 09 Nov 2023 05:51:26 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id b4-20020a170906038400b0099bc8bd9066sm2581530eja.150.2023.11.09.05.51.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:51:26 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/4] libsepol: use str_read() where appropriate
Date:   Thu,  9 Nov 2023 14:51:18 +0100
Message-ID: <20231109135121.42380-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the internal helper str_read() in more places while reading strings
from a binary policy.  This improves readability and helps adjusting
future sanity checks on inputs in fewer places.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 199 +++++++++-------------------------------
 1 file changed, 41 insertions(+), 158 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index f9537caa..f608aba4 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2108,7 +2108,8 @@ static int common_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	if (zero_or_saturated(len))
+	rc = str_read(&key, fp, len);
+	if (rc < 0)
 		goto bad;
 
 	comdatum->s.value = le32_to_cpu(buf[1]);
@@ -2120,14 +2121,6 @@ static int common_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 		goto bad;
 	nel = le32_to_cpu(buf[3]);
 
-	key = malloc(len + 1);
-	if (!key)
-		goto bad;
-	rc = next_entry(key, fp, len);
-	if (rc < 0)
-		goto bad;
-	key[len] = 0;
-
 	for (i = 0; i < nel; i++) {
 		if (perm_read(p, comdatum->permissions.table, fp, comdatum->permissions.nprim))
 			goto bad;
@@ -2256,11 +2249,11 @@ static int class_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	if (zero_or_saturated(len))
+	rc = str_read(&key, fp, len);
+	if (rc < 0)
 		goto bad;
+
 	len2 = le32_to_cpu(buf[1]);
-	if (is_saturated(len2))
-		goto bad;
 	cladatum->s.value = le32_to_cpu(buf[2]);
 
 	if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
@@ -2272,22 +2265,10 @@ static int class_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 
 	ncons = le32_to_cpu(buf[5]);
 
-	key = malloc(len + 1);
-	if (!key)
-		goto bad;
-	rc = next_entry(key, fp, len);
-	if (rc < 0)
-		goto bad;
-	key[len] = 0;
-
 	if (len2) {
-		cladatum->comkey = malloc(len2 + 1);
-		if (!cladatum->comkey)
-			goto bad;
-		rc = next_entry(cladatum->comkey, fp, len2);
+		rc = str_read(&cladatum->comkey, fp, len2);
 		if (rc < 0)
 			goto bad;
-		cladatum->comkey[len2] = 0;
 
 		cladatum->comdatum = hashtab_search(p->p_commons.table,
 						    cladatum->comkey);
@@ -2369,21 +2350,14 @@ static int role_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	if (zero_or_saturated(len))
+	rc = str_read(&key, fp, len);
+	if (rc < 0)
 		goto bad;
 
 	role->s.value = le32_to_cpu(buf[1]);
 	if (policydb_has_boundary_feature(p))
 		role->bounds = le32_to_cpu(buf[2]);
 
-	key = malloc(len + 1);
-	if (!key)
-		goto bad;
-	rc = next_entry(key, fp, len);
-	if (rc < 0)
-		goto bad;
-	key[len] = 0;
-
 	if (ebitmap_read(&role->dominates, fp))
 		goto bad;
 
@@ -2460,9 +2434,6 @@ static int type_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 		goto bad;
 
 	len = le32_to_cpu(buf[pos]);
-	if (zero_or_saturated(len))
-		goto bad;
-
 	typdatum->s.value = le32_to_cpu(buf[++pos]);
 	if (policydb_has_boundary_feature(p)) {
 		uint32_t properties;
@@ -2503,13 +2474,9 @@ static int type_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 			goto bad;
 	}
 
-	key = malloc(len + 1);
-	if (!key)
-		goto bad;
-	rc = next_entry(key, fp, len);
+	rc = str_read(&key, fp, len);
 	if (rc < 0)
 		goto bad;
-	key[len] = 0;
 
 	if (hashtab_insert(h, key, typdatum))
 		goto bad;
@@ -2681,14 +2648,8 @@ static int filename_trans_read_one_compat(policydb_t *p, struct policy_file *fp)
 	if (rc < 0)
 		return -1;
 	len = le32_to_cpu(buf[0]);
-	if (zero_or_saturated(len))
-		return -1;
-
-	name = calloc(len + 1, sizeof(*name));
-	if (!name)
-		return -1;
 
-	rc = next_entry(name, fp, len);
+	rc = str_read(&name, fp, len);
 	if (rc < 0)
 		goto err;
 
@@ -2766,14 +2727,8 @@ static int filename_trans_read_one(policydb_t *p, struct policy_file *fp)
 	if (rc < 0)
 		return -1;
 	len = le32_to_cpu(buf[0]);
-	if (zero_or_saturated(len))
-		return -1;
-
-	name = calloc(len + 1, sizeof(*name));
-	if (!name)
-		return -1;
 
-	rc = next_entry(name, fp, len);
+	rc = str_read(&name, fp, len);
 	if (rc < 0)
 		goto err;
 
@@ -2957,16 +2912,9 @@ static int ocontext_read_xen(const struct policydb_compat_info *info,
 				if (rc < 0)
 					return -1;
 				len = le32_to_cpu(buf[0]);
-				if (zero_or_saturated(len))
-					return -1;
-
-				c->u.name = malloc(len + 1);
-				if (!c->u.name)
-					return -1;
-				rc = next_entry(c->u.name, fp, len);
+				rc = str_read(&c->u.name, fp, len);
 				if (rc < 0)
 					return -1;
-				c->u.name[len] = 0;
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
 					return -1;
@@ -3024,15 +2972,13 @@ static int ocontext_read_selinux(const struct policydb_compat_info *info,
 				if (rc < 0)
 					return -1;
 				len = le32_to_cpu(buf[0]);
-				if (zero_or_saturated(len) || len > 63)
+				if (len > 63)
 					return -1;
-				c->u.name = malloc(len + 1);
-				if (!c->u.name)
-					return -1;
-				rc = next_entry(c->u.name, fp, len);
+
+				rc = str_read(&c->u.name, fp, len);
 				if (rc < 0)
 					return -1;
-				c->u.name[len] = 0;
+
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
 					return -1;
@@ -3080,13 +3026,10 @@ static int ocontext_read_selinux(const struct policydb_compat_info *info,
 				if (port > UINT8_MAX || port == 0)
 					return -1;
 
-				c->u.ibendport.dev_name = malloc(len + 1);
-				if (!c->u.ibendport.dev_name)
-					return -1;
-				rc = next_entry(c->u.ibendport.dev_name, fp, len);
+				rc = str_read(&c->u.ibendport.dev_name, fp, len);
 				if (rc < 0)
 					return -1;
-				c->u.ibendport.dev_name[len] = 0;
+
 				c->u.ibendport.port = port;
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
@@ -3120,15 +3063,11 @@ static int ocontext_read_selinux(const struct policydb_compat_info *info,
 					return -1;
 				c->v.behavior = le32_to_cpu(buf[0]);
 				len = le32_to_cpu(buf[1]);
-				if (zero_or_saturated(len))
-					return -1;
-				c->u.name = malloc(len + 1);
-				if (!c->u.name)
-					return -1;
-				rc = next_entry(c->u.name, fp, len);
+
+				rc = str_read(&c->u.name, fp, len);
 				if (rc < 0)
 					return -1;
-				c->u.name[len] = 0;
+
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
 					return -1;
@@ -3196,23 +3135,17 @@ static int genfs_read(policydb_t * p, struct policy_file *fp)
 		if (rc < 0)
 			goto bad;
 		len = le32_to_cpu(buf[0]);
-		if (zero_or_saturated(len))
-			goto bad;
 		newgenfs = calloc(1, sizeof(genfs_t));
 		if (!newgenfs)
 			goto bad;
-		newgenfs->fstype = malloc(len + 1);
-		if (!newgenfs->fstype) {
-			free(newgenfs);
-			goto bad;
-		}
-		rc = next_entry(newgenfs->fstype, fp, len);
+
+		rc = str_read(&newgenfs->fstype, fp, len);
 		if (rc < 0) {
 			free(newgenfs->fstype);
 			free(newgenfs);
 			goto bad;
 		}
-		newgenfs->fstype[len] = 0;
+
 		for (genfs_p = NULL, genfs = p->genfs; genfs;
 		     genfs_p = genfs, genfs = genfs->next) {
 			if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
@@ -3243,16 +3176,10 @@ static int genfs_read(policydb_t * p, struct policy_file *fp)
 			if (rc < 0)
 				goto bad;
 			len = le32_to_cpu(buf[0]);
-			if (zero_or_saturated(len))
-				goto bad;
-			newc->u.name = malloc(len + 1);
-			if (!newc->u.name) {
-				goto bad;
-			}
-			rc = next_entry(newc->u.name, fp, len);
+			rc = str_read(&newc->u.name, fp, len);
 			if (rc < 0)
 				goto bad;
-			newc->u.name[len] = 0;
+
 			rc = next_entry(buf, fp, sizeof(uint32_t));
 			if (rc < 0)
 				goto bad;
@@ -3344,21 +3271,14 @@ static int user_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	if (zero_or_saturated(len))
+	rc = str_read(&key, fp, len);
+	if (rc < 0)
 		goto bad;
 
 	usrdatum->s.value = le32_to_cpu(buf[1]);
 	if (policydb_has_boundary_feature(p))
 		usrdatum->bounds = le32_to_cpu(buf[2]);
 
-	key = malloc(len + 1);
-	if (!key)
-		goto bad;
-	rc = next_entry(key, fp, len);
-	if (rc < 0)
-		goto bad;
-	key[len] = 0;
-
 	if (p->policy_type == POLICY_KERN) {
 		if (ebitmap_read(&usrdatum->roles.roles, fp))
 			goto bad;
@@ -3430,19 +3350,12 @@ static int sens_read(policydb_t * p
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	if (zero_or_saturated(len))
+	rc = str_read(&key, fp, len);
+	if (rc < 0)
 		goto bad;
 
 	levdatum->isalias = le32_to_cpu(buf[1]);
 
-	key = malloc(len + 1);
-	if (!key)
-		goto bad;
-	rc = next_entry(key, fp, len);
-	if (rc < 0)
-		goto bad;
-	key[len] = 0;
-
 	levdatum->level = malloc(sizeof(mls_level_t));
 	if (!levdatum->level || mls_read_level(levdatum->level, fp))
 		goto bad;
@@ -3476,20 +3389,13 @@ static int cat_read(policydb_t * p
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	if(zero_or_saturated(len))
+	rc = str_read(&key, fp, len);
+	if (rc < 0)
 		goto bad;
 
 	catdatum->s.value = le32_to_cpu(buf[1]);
 	catdatum->isalias = le32_to_cpu(buf[2]);
 
-	key = malloc(len + 1);
-	if (!key)
-		goto bad;
-	rc = next_entry(key, fp, len);
-	if (rc < 0)
-		goto bad;
-	key[len] = 0;
-
 	if (hashtab_insert(h, key, catdatum))
 		goto bad;
 
@@ -3865,17 +3771,10 @@ static int filename_trans_rule_read(policydb_t *p, filename_trans_rule_t **r,
 			return -1;
 
 		len = le32_to_cpu(buf[0]);
-		if (zero_or_saturated(len))
-			return -1;
 
-		ftr->name = malloc(len + 1);
-		if (!ftr->name)
-			return -1;
-
-		rc = next_entry(ftr->name, fp, len);
-		if (rc)
+		rc = str_read(&ftr->name, fp, len);
+		if (rc < 0)
 			return -1;
-		ftr->name[len] = 0;
 
 		if (type_set_read(&ftr->stypes, fp))
 			return -1;
@@ -4119,15 +4018,10 @@ static int scope_read(policydb_t * p, int symnum, struct policy_file *fp)
 	if (rc < 0)
 		goto cleanup;
 	key_len = le32_to_cpu(buf[0]);
-	if (zero_or_saturated(key_len))
-		goto cleanup;
-	key = malloc(key_len + 1);
-	if (!key)
-		goto cleanup;
-	rc = next_entry(key, fp, key_len);
+
+	rc = str_read(&key, fp, key_len);
 	if (rc < 0)
 		goto cleanup;
-	key[key_len] = '\0';
 
 	/* ensure that there already exists a symbol with this key */
 	if (hashtab_search(p->symtab[symnum].table, key) == NULL) {
@@ -4387,28 +4281,17 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 			goto bad;
 		}
 		len = le32_to_cpu(buf[0]);
-		if (zero_or_saturated(len))
-			goto bad;
-		if ((p->name = malloc(len + 1)) == NULL) {
-			goto bad;
-		}
-		if ((rc = next_entry(p->name, fp, len)) < 0) {
+		rc = str_read(&p->name, fp, len);
+		if (rc < 0)
 			goto bad;
-		}
-		p->name[len] = '\0';
+
 		if ((rc = next_entry(buf, fp, sizeof(uint32_t))) < 0) {
 			goto bad;
 		}
 		len = le32_to_cpu(buf[0]);
-		if (zero_or_saturated(len))
-			goto bad;
-		if ((p->version = malloc(len + 1)) == NULL) {
-			goto bad;
-		}
-		if ((rc = next_entry(p->version, fp, len)) < 0) {
+		rc = str_read(&p->version, fp, len);
+		if (rc < 0)
 			goto bad;
-		}
-		p->version[len] = '\0';
 	}
 
 	if ((p->policyvers >= POLICYDB_VERSION_POLCAP &&
-- 
2.42.0

