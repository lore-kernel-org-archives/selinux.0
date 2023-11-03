Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92DDC4332F
	for <selinux@archiver.kernel.org>; Fri,  3 Nov 2023 17:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345897AbjKCRaj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Nov 2023 13:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345980AbjKCRah (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Nov 2023 13:30:37 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2A0D5A
        for <selinux@vger.kernel.org>; Fri,  3 Nov 2023 10:30:29 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-777745f1541so148461985a.0
        for <selinux@vger.kernel.org>; Fri, 03 Nov 2023 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699032627; x=1699637427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyoUziWddHB0KfSl/Q8qSYrSYsOUjaBuopQv6+/+rY0=;
        b=MN7CUyZQf4TU2exe/r0P6+B+cHlBK3eECd51mTfm1vpu0MwSr60w2vCQADgyFYAb2L
         zFxdlSwfauflXSRHvNddUBXHYCd4lpOddtMWGYsw6J/JkBj8hRjANJ0BDKps6r97EGDR
         fHvcLc2jIFKUOePjm060fHTtCSaRJvohxvw/k73JC6gnvya+rR89SZl65/pIkKS/RScb
         Yl8bCfYJd/afxygUNrFngKm/Jc0Ck4+9Yz2OHCpsKH15e5DyeAXp6MOLQmegZa1TZsPh
         PJkNkbOWmeT9TJiUB5amrgEo/Ki8IEWhvn7EAEgOQ9ZFyCujZcjN+9YSRoBz0LLPwZhc
         huLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699032627; x=1699637427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyoUziWddHB0KfSl/Q8qSYrSYsOUjaBuopQv6+/+rY0=;
        b=Ld/tT5310at7uL7dsbka1SKSr/XEm0FuXcgvkTsCIlCb6D5T+V7CReKXsXRc5bX5dK
         +zn8ougBztiAM/A/RT4gXMX9wrfAUhC6nmbWVXkEbB8/U2RCyEVzCqcHajPOSC8kJuwi
         lbR/EsUI+pwIqSlkJHNfeoWibasmqzsfosj0gE7iA5DP4PzmKDu/aKlnFTIZQOKOIaAX
         Y8WBGuaUxkD5F+IitihWAjZ3V7jc3TNlPv5p82XTN8UtFway1u7/lzNotfAWVma00PWH
         hnS7AQ+7HMM9ildwhl//OIPfmHslXLARrQBbukrVx3VPzIeeao4DLSeIvJ6MCPG80A0J
         xg1w==
X-Gm-Message-State: AOJu0YzAL61TYL2I21JNIDmEI/TCDI83xAsBkc0SkDjj5ANLsEwJs8ua
        ZufPNcdqLGdzIoedFD2BAxpNce7Rkas=
X-Google-Smtp-Source: AGHT+IE6oxiTGI6eodnI1WEgKVvDkk42ovJ2mLi+QUDIAoTav8JvCPtdsXkeQ9DPID3lCsqtysr0UA==
X-Received: by 2002:a05:620a:2b8b:b0:778:96ec:661 with SMTP id dz11-20020a05620a2b8b00b0077896ec0661mr22584885qkb.73.1699032627585;
        Fri, 03 Nov 2023 10:30:27 -0700 (PDT)
Received: from ip-10-113-85-151.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a291200b007789a3499casm901426qkp.115.2023.11.03.10.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:30:26 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH v5 2/3] selinux: fix conditional avtab slot hint
Date:   Fri,  3 Nov 2023 17:29:52 +0000
Message-Id: <20231103172953.24667-3-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103172953.24667-1-jsatterfield.linux@gmail.com>
References: <20231103172953.24667-1-jsatterfield.linux@gmail.com>
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
index 697eb4352439..a9227674899b 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -340,7 +340,7 @@ static const uint16_t spec_order[] = {
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    int (*insertf)(struct avtab *a, const struct avtab_key *k,
 				   const struct avtab_datum *d, void *p),
-		    void *p)
+		    void *p, u32 *nrules)
 {
 	__le16 buf16[4];
 	u16 enabled;
@@ -414,6 +414,11 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
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
@@ -492,6 +497,12 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
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
 
@@ -525,7 +536,7 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
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

