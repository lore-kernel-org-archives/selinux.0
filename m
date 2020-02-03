Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85520C33CAC
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 11:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4801720661
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 11:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuQIAQZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgBCL1e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:27:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55534 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727240AbgBCL1d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 06:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580729252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=groQhN/YZxlDjqvmsChyX9CqkmjqTvcLcJj3UeUg83k=;
        b=AuQIAQZbIoVJyj6os2CdTOxlIUi1TnXc35GSZKxe+yAK2BOa4SlMw179FzLZUV/jeNIt8M
        iWGYCFOO+D680tsdaMSNuiSTAGx2eoMrINa9yf65DcsUZgUIwJ1ZoxqcVdieYehRF5oUEz
        g6zHzwj0vmhS0gK9YcV1TqVNoKMV2Y8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-_qRNPyG_M_OFjtKSCbXXdw-1; Mon, 03 Feb 2020 06:27:31 -0500
X-MC-Unique: _qRNPyG_M_OFjtKSCbXXdw-1
Received: by mail-wr1-f72.google.com with SMTP id x15so8055290wrl.15
        for <selinux@vger.kernel.org>; Mon, 03 Feb 2020 03:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=groQhN/YZxlDjqvmsChyX9CqkmjqTvcLcJj3UeUg83k=;
        b=g1NrKENISV8E1INHnYE1p/tzAX/ks5v3oubc3sxjK6/D6Q8ekfJfTx3Y4eG2/dh20a
         YXIYaEH3HpyREVynROf2UcNhnSzNEz8dGgBHq6KM32s0aKjM/LtH3iHAqhduUZv02HGR
         FkBvyc0teo3nFb8YtQYNwW5H74UhMCwDb5JSCS2gVIHKlI7pHAPdpRNPWO+ZyZwGUA5V
         9jUfCbFylQlKHn0qxbwPnwcjDAi9IvKidNHhxlgTkHOTpWtP4XYUSxHw/yQu6zC49mnO
         BDB15LEpTyWPGfbod3juRg+BjpK64PhR3zWy1EQE/iBRGnXX7HEQ7vpfrshNOAipXlgX
         Ek2g==
X-Gm-Message-State: APjAAAXMRDlA/Z2tsDOmPPqr5H0iPynlZqisZxKYp1saJ20FTlDZgIxr
        0KTxJArqv0iiFPV+0fZh/2AbUrWI+MDrZtZauYPoosQHpuaKLuXMG7E/2i2ZBpwFtF7JnF+DjzU
        aASePxWzG3f7LxeDYXQ==
X-Received: by 2002:a05:600c:2c44:: with SMTP id r4mr27769777wmg.140.1580729249483;
        Mon, 03 Feb 2020 03:27:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyusbkRR9NxkFTqcTnIFtWhr10NvOJ2/vGYdhOsxzP/yXahXpkox9Pjvc17H3ueocKKJZp+Rw==
X-Received: by 2002:a05:600c:2c44:: with SMTP id r4mr27769754wmg.140.1580729249183;
        Mon, 03 Feb 2020 03:27:29 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b16sm22597593wmj.39.2020.02.03.03.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 03:27:28 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3 3/5] selinux: convert cond_av_list to array
Date:   Mon,  3 Feb 2020 12:27:21 +0100
Message-Id: <20200203112723.405341-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203112723.405341-1-omosnace@redhat.com>
References: <20200203112723.405341-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since it is fixed-size after allocation and we know the size beforehand,
using a plain old array is simpler and more efficient.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/ss/conditional.c | 124 ++++++++++++------------------
 security/selinux/ss/conditional.h |   8 +-
 2 files changed, 53 insertions(+), 79 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index e6d203b76545..82002b90809c 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -87,8 +87,9 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
  */
 void evaluate_cond_node(struct policydb *p, struct cond_node *node)
 {
+	struct avtab_node *avnode;
 	int new_state;
-	struct cond_av_list *cur;
+	u32 i;
 
 	new_state = cond_evaluate_expr(p, node->expr);
 	if (new_state != node->cur_state) {
@@ -96,19 +97,21 @@ void evaluate_cond_node(struct policydb *p, struct cond_node *node)
 		if (new_state == -1)
 			pr_err("SELinux: expression result was undefined - disabling all rules.\n");
 		/* turn the rules on or off */
-		for (cur = node->true_list; cur; cur = cur->next) {
+		for (i = 0; i < node->true_list.len; i++) {
+			avnode = node->true_list.nodes[i];
 			if (new_state <= 0)
-				cur->node->key.specified &= ~AVTAB_ENABLED;
+				avnode->key.specified &= ~AVTAB_ENABLED;
 			else
-				cur->node->key.specified |= AVTAB_ENABLED;
+				avnode->key.specified |= AVTAB_ENABLED;
 		}
 
-		for (cur = node->false_list; cur; cur = cur->next) {
+		for (i = 0; i < node->false_list.len; i++) {
+			avnode = node->false_list.nodes[i];
 			/* -1 or 1 */
 			if (new_state)
-				cur->node->key.specified &= ~AVTAB_ENABLED;
+				avnode->key.specified &= ~AVTAB_ENABLED;
 			else
-				cur->node->key.specified |= AVTAB_ENABLED;
+				avnode->key.specified |= AVTAB_ENABLED;
 		}
 	}
 }
@@ -128,16 +131,6 @@ int cond_policydb_init(struct policydb *p)
 	return 0;
 }
 
-static void cond_av_list_destroy(struct cond_av_list *list)
-{
-	struct cond_av_list *cur, *next;
-	for (cur = list; cur; cur = next) {
-		next = cur->next;
-		/* the avtab_ptr_t node is destroy by the avtab */
-		kfree(cur);
-	}
-}
-
 static void cond_node_destroy(struct cond_node *node)
 {
 	struct cond_expr *cur_expr, *next_expr;
@@ -146,8 +139,9 @@ static void cond_node_destroy(struct cond_node *node)
 		next_expr = cur_expr->next;
 		kfree(cur_expr);
 	}
-	cond_av_list_destroy(node->true_list);
-	cond_av_list_destroy(node->false_list);
+	/* the avtab_ptr_t nodes are destroyed by the avtab */
+	kfree(node->true_list.nodes);
+	kfree(node->false_list.nodes);
 }
 
 static void cond_list_destroy(struct policydb *p)
@@ -255,19 +249,18 @@ err:
 
 struct cond_insertf_data {
 	struct policydb *p;
+	struct avtab_node **dst;
 	struct cond_av_list *other;
-	struct cond_av_list *head;
-	struct cond_av_list *tail;
 };
 
 static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum *d, void *ptr)
 {
 	struct cond_insertf_data *data = ptr;
 	struct policydb *p = data->p;
-	struct cond_av_list *other = data->other, *list, *cur;
+	struct cond_av_list *other = data->other;
 	struct avtab_node *node_ptr;
-	u8 found;
-	int rc = -EINVAL;
+	u32 i;
+	bool found;
 
 	/*
 	 * For type rules we have to make certain there aren't any
@@ -277,7 +270,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 	if (k->specified & AVTAB_TYPE) {
 		if (avtab_search(&p->te_avtab, k)) {
 			pr_err("SELinux: type rule already exists outside of a conditional.\n");
-			goto err;
+			return -EINVAL;
 		}
 		/*
 		 * If we are reading the false list other will be a pointer to
@@ -292,24 +285,24 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 			if (node_ptr) {
 				if (avtab_search_node_next(node_ptr, k->specified)) {
 					pr_err("SELinux: too many conflicting type rules.\n");
-					goto err;
+					return -EINVAL;
 				}
-				found = 0;
-				for (cur = other; cur; cur = cur->next) {
-					if (cur->node == node_ptr) {
-						found = 1;
+				found = false;
+				for (i = 0; i < other->len; i++) {
+					if (other->nodes[i] == node_ptr) {
+						found = true;
 						break;
 					}
 				}
 				if (!found) {
 					pr_err("SELinux: conflicting type rules.\n");
-					goto err;
+					return -EINVAL;
 				}
 			}
 		} else {
 			if (avtab_search(&p->te_cond_avtab, k)) {
 				pr_err("SELinux: conflicting type rules when adding type rule for true.\n");
-				goto err;
+				return -EINVAL;
 			}
 		}
 	}
@@ -317,39 +310,22 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
 	if (!node_ptr) {
 		pr_err("SELinux: could not insert rule.\n");
-		rc = -ENOMEM;
-		goto err;
-	}
-
-	list = kzalloc(sizeof(*list), GFP_KERNEL);
-	if (!list) {
-		rc = -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}
 
-	list->node = node_ptr;
-	if (!data->head)
-		data->head = list;
-	else
-		data->tail->next = list;
-	data->tail = list;
+	*data->dst = node_ptr;
 	return 0;
-
-err:
-	cond_av_list_destroy(data->head);
-	data->head = NULL;
-	return rc;
 }
 
-static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list **ret_list, struct cond_av_list *other)
+static int cond_read_av_list(struct policydb *p, void *fp,
+			     struct cond_av_list *list,
+			     struct cond_av_list *other)
 {
-	int i, rc;
+	int rc;
 	__le32 buf[1];
-	u32 len;
+	u32 i, len;
 	struct cond_insertf_data data;
 
-	*ret_list = NULL;
-
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc)
 		return rc;
@@ -358,18 +334,24 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
 	if (len == 0)
 		return 0;
 
+	list->nodes = kcalloc(len, sizeof(*list->nodes), GFP_KERNEL);
+	if (!list->nodes)
+		return -ENOMEM;
+
 	data.p = p;
 	data.other = other;
-	data.head = NULL;
-	data.tail = NULL;
 	for (i = 0; i < len; i++) {
+		data.dst = &list->nodes[i];
 		rc = avtab_read_item(&p->te_cond_avtab, fp, p, cond_insertf,
 				     &data);
-		if (rc)
+		if (rc) {
+			kfree(list->nodes);
+			list->nodes = NULL;
 			return rc;
+		}
 	}
 
-	*ret_list = data.head;
+	list->len = len;
 	return 0;
 }
 
@@ -432,7 +414,7 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 	rc = cond_read_av_list(p, fp, &node->true_list, NULL);
 	if (rc)
 		goto err;
-	rc = cond_read_av_list(p, fp, &node->false_list, node->true_list);
+	rc = cond_read_av_list(p, fp, &node->false_list, &node->true_list);
 	if (rc)
 		goto err;
 	return 0;
@@ -511,24 +493,16 @@ static int cond_write_av_list(struct policydb *p,
 			      struct cond_av_list *list, struct policy_file *fp)
 {
 	__le32 buf[1];
-	struct cond_av_list *cur_list;
-	u32 len;
+	u32 i;
 	int rc;
 
-	len = 0;
-	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next)
-		len++;
-
-	buf[0] = cpu_to_le32(len);
+	buf[0] = cpu_to_le32(list->len);
 	rc = put_entry(buf, sizeof(u32), 1, fp);
 	if (rc)
 		return rc;
 
-	if (len == 0)
-		return 0;
-
-	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next) {
-		rc = avtab_write_item(p, cur_list->node, fp);
+	for (i = 0; i < list->len; i++) {
+		rc = avtab_write_item(p, list->nodes[i], fp);
 		if (rc)
 			return rc;
 	}
@@ -565,10 +539,10 @@ static int cond_write_node(struct policydb *p, struct cond_node *node,
 			return rc;
 	}
 
-	rc = cond_write_av_list(p, node->true_list, fp);
+	rc = cond_write_av_list(p, &node->true_list, fp);
 	if (rc)
 		return rc;
-	rc = cond_write_av_list(p, node->false_list, fp);
+	rc = cond_write_av_list(p, &node->false_list, fp);
 	if (rc)
 		return rc;
 
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index e474bdd3a0ed..5f97f678440e 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -39,8 +39,8 @@ struct cond_expr {
  * struct is for that list.
  */
 struct cond_av_list {
-	struct avtab_node *node;
-	struct cond_av_list *next;
+	struct avtab_node **nodes;
+	u32 len;
 };
 
 /*
@@ -53,8 +53,8 @@ struct cond_av_list {
 struct cond_node {
 	int cur_state;
 	struct cond_expr *expr;
-	struct cond_av_list *true_list;
-	struct cond_av_list *false_list;
+	struct cond_av_list true_list;
+	struct cond_av_list false_list;
 };
 
 int cond_policydb_init(struct policydb *p);
-- 
2.24.1

