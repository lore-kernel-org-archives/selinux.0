Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4698C4167D
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 15:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376930AbjKBPqS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376924AbjKBPp5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 11:45:57 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61703196
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 08:45:51 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7788f727dd7so63230185a.1
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698939949; x=1699544749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37TsIMvU9JcPC5N95mNkvxxE12nyBJOHfDfe3banLDc=;
        b=NiGI3Jv0h/HVq9/JZoFSBz5L9M+oEXEVY7nc6kLhKtmJPi5rwHh18Bk3iemeiEesXI
         vPjWvO0IDC3IJDXtpmrfzkFT6KfUejO/NDSqcj/fJ8litFbB6KWEYYdVi7/ZGfJccwfd
         LzaBAxTHvHeJ3xdzx06ucBDZ5nA7NqJq9KO8Qz5QdR9zKSpiRkJ8TAWWKd9PNA0BudnT
         iDm2Y7c6bVuABgux2VrSOXHGrlntHgGtEe62k8y/4AG87wOU4Y43/15YOi8K3TE4J3qM
         EYBB9jvgVNI2/LDqsywGiq8dldVAjWmhOTvNP4nzdz0g/In1loGj4KiJY91zpaYbQKAV
         eQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939949; x=1699544749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37TsIMvU9JcPC5N95mNkvxxE12nyBJOHfDfe3banLDc=;
        b=WjD2T9Z+vQygLr9PVBVZAfqMyJ+eTbl8JKggO69Fox5keSX9ZqYMBx9E+1LH/n9BeR
         o8szlmLXq6wcfbsDpgRvNtDrWgagZUFyXh8DRAnar8vx34U0caGDeVqDJ6VC6f4b90ZE
         1q4bWMH4MKVKXboe3+jaUxUCSOrxu0qLXkE8ND/hQyRe0QerUagWu9pDbwWqm30LxZ2g
         xK8QOKn9jemRyriK0i8qSzPioegJ1b4BUHD/W6AGjUTr5if5SfBN+LSG4pOqpXg51M8m
         qrnm5uq1/E8ngE9w39VH4ogdXvpjWvVSLW1P2nTzXDqkMK5dhVAhlXAVGNMZW15BBP+U
         9fSg==
X-Gm-Message-State: AOJu0YyepmbqQMAHulQwFT4aLTmiZUFEZrxLC4gNghmkiS5FrrrxhI1z
        orvIKoRi91Q7g1Do6uSXhwcST1ZPixY=
X-Google-Smtp-Source: AGHT+IGNwp4TgrlE3QgwKIeA1GvMEhlHehEEaj/oenEJdylsmU5OslhmwYwavHNndZWo2x9aYJQDEw==
X-Received: by 2002:a05:620a:400a:b0:774:9dc7:ce3d with SMTP id h10-20020a05620a400a00b007749dc7ce3dmr21096404qko.12.1698939949429;
        Thu, 02 Nov 2023 08:45:49 -0700 (PDT)
Received: from ip-10-113-85-151.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id l1-20020a05620a210100b0076e1e2d6496sm37691qkl.104.2023.11.02.08.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 08:45:48 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH v4 2/3] selinux: fix conditional avtab slot hint
Date:   Thu,  2 Nov 2023 15:45:23 +0000
Message-Id: <20231102154524.12006-3-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102154524.12006-1-jsatterfield.linux@gmail.com>
References: <20231102154524.12006-1-jsatterfield.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Due to how conditional rules are written in the binary policy, the
code responsible for loading does not know how many conditional rules
there are before creating the avtab structure. Instead, it uses the
number of elements in the non-conditional avtab as a hint and allocates
the hash table based on it. In the refpolicy and default Fedora policy,
the actual sizes of these tables are not similar (~85k vs ~10k) thereby
creating more slots than needed and resulting in wasted memory.

This patch introduces a two-pass algorithm to calculate the conditional
rule count before allocating the avtab nodes array. Albeit with a slight
performance penalty in reading a portion of the binary policy twice,
this causes the number of hash slots for the conditional array to become
4096 instead of 32768. At 8-bytes per slot on 64-bit architectures, this
results in a net savings of 224 KB of heap memory.

Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
---
 security/selinux/ss/avtab.c       | 15 ++++++++++--
 security/selinux/ss/avtab.h       |  2 +-
 security/selinux/ss/conditional.c | 38 ++++++++++++++++++++-----------
 security/selinux/ss/conditional.h |  2 +-
 4 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 672a524e6dee..f437bd588b04 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -338,7 +338,7 @@ static const uint16_t spec_order[] = {
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    int (*insertf)(struct avtab *a, const struct avtab_key *k,
 				   const struct avtab_datum *d, void *p),
-		    void *p)
+		    void *p, u32 *nrules)
 {
 	__le16 buf16[4];
 	u16 enabled;
@@ -412,6 +412,11 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 			if (val & spec_order[i]) {
 				key.specified = spec_order[i] | enabled;
 				datum.u.data = le32_to_cpu(buf32[items++]);
+				/* first pass of conditional table read */
+				if (nrules) {
+					(*nrules)++;
+					continue;
+				}
 				rc = insertf(a, &key, &datum, p);
 				if (rc)
 					return rc;
@@ -490,6 +495,12 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		pr_err("SELinux: avtab: invalid type\n");
 		return -EINVAL;
 	}
+
+	/* first pass of conditional table read */
+	if (nrules) {
+		(*nrules)++;
+		return 0;
+	}
 	return insertf(a, &key, &datum, p);
 }
 
@@ -523,7 +534,7 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL);
+		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL, NULL);
 		if (rc) {
 			if (rc == -ENOMEM)
 				pr_err("SELinux: avtab: out of memory\n");
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 3c3904bf02b0..86fb6f793eec 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -104,7 +104,7 @@ struct policydb;
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    int (*insert)(struct avtab *a, const struct avtab_key *k,
 				  const struct avtab_datum *d, void *p),
-		    void *p);
+		    void *p, u32 *nrules);
 
 int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
 int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp);
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 81ff676f209a..810319bf0e60 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -321,9 +321,9 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
 	return 0;
 }
 
-static int cond_read_av_list(struct policydb *p, void *fp,
+static int cond_read_av_list(struct policydb *p, struct policy_file *fp,
 			     struct cond_av_list *list,
-			     struct cond_av_list *other)
+			     struct cond_av_list *other, u32 *nrules)
 {
 	int rc;
 	__le32 buf[1];
@@ -347,7 +347,7 @@ static int cond_read_av_list(struct policydb *p, void *fp,
 	for (i = 0; i < len; i++) {
 		data.dst = &list->nodes[i];
 		rc = avtab_read_item(&p->te_cond_avtab, fp, p, cond_insertf,
-				     &data);
+				     &data, nrules);
 		if (rc) {
 			kfree(list->nodes);
 			list->nodes = NULL;
@@ -373,7 +373,8 @@ static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
 	return 1;
 }
 
-static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
+static int cond_read_node(struct policydb *p, struct cond_node *node,
+			  struct policy_file *fp, u32 *nrules)
 {
 	__le32 buf[2];
 	u32 i, len;
@@ -407,16 +408,17 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 			return -EINVAL;
 	}
 
-	rc = cond_read_av_list(p, fp, &node->true_list, NULL);
+	rc = cond_read_av_list(p, fp, &node->true_list, NULL, nrules);
 	if (rc)
 		return rc;
-	return cond_read_av_list(p, fp, &node->false_list, &node->true_list);
+	return cond_read_av_list(p, fp, &node->false_list, &node->true_list, nrules);
 }
 
-int cond_read_list(struct policydb *p, void *fp)
+int cond_read_list(struct policydb *p, struct policy_file *fp)
 {
 	__le32 buf[1];
-	u32 i, len;
+	struct policy_file tmp_fp;
+	u32 i, len, nrules;
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof(buf));
@@ -428,15 +430,25 @@ int cond_read_list(struct policydb *p, void *fp)
 	p->cond_list = kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
 	if (!p->cond_list)
 		return -ENOMEM;
+	p->cond_list_len = len;
+
+	/* first pass to only calculate the avrule count */
+	tmp_fp = *fp;
+	nrules = 0;
+	for (i = 0; i < p->cond_list_len; i++) {
+		rc = cond_read_node(p, &p->cond_list[i], &tmp_fp, &nrules);
+		if (rc)
+			goto err;
+		cond_node_destroy(&p->cond_list[i]);
+	}
 
-	rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
+	rc = avtab_alloc(&(p->te_cond_avtab), nrules);
 	if (rc)
 		goto err;
 
-	p->cond_list_len = len;
-
-	for (i = 0; i < len; i++) {
-		rc = cond_read_node(p, &p->cond_list[i], fp);
+	/* second pass to read in the conditional nodes */
+	for (i = 0; i < p->cond_list_len; i++) {
+		rc = cond_read_node(p, &p->cond_list[i], fp, NULL);
 		if (rc)
 			goto err;
 	}
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 5a7b51278dc6..62a12d00cac9 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -70,7 +70,7 @@ int cond_destroy_bool(void *key, void *datum, void *p);
 int cond_index_bool(void *key, void *datum, void *datap);
 
 int cond_read_bool(struct policydb *p, struct symtab *s, void *fp);
-int cond_read_list(struct policydb *p, void *fp);
+int cond_read_list(struct policydb *p, struct policy_file *fp);
 int cond_write_bool(void *key, void *datum, void *ptr);
 int cond_write_list(struct policydb *p, void *fp);
 
-- 
2.34.1

