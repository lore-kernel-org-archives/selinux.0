Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75659C35247
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 11:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4201520661
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 11:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ss6SUdld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBCL1f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:27:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29582 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727764AbgBCL1e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 06:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580729253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LL0L5LM5NstMeBADEcQiQzUcWHSB6Kx4MCuR+9ZHU+0=;
        b=Ss6SUdldUGPHxHky+18VQgHBN3g3iFtFbF/GXBLexyn+nzgW5+NxMmb5kT/SeGupfzFZ7r
        LaG+ahEiElFkNG8LRkJXtOT0WpkeVYcpL+i19EUwNUihfCx4V8/Pf00wdl6PKf+jYW8ntC
        KiXklXPT9k/QK6DAtX5Q7S+8/sE+EDo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-ILFBEK2FOteDaZLeATnYdw-1; Mon, 03 Feb 2020 06:27:32 -0500
X-MC-Unique: ILFBEK2FOteDaZLeATnYdw-1
Received: by mail-wr1-f71.google.com with SMTP id f10so8118157wro.14
        for <selinux@vger.kernel.org>; Mon, 03 Feb 2020 03:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LL0L5LM5NstMeBADEcQiQzUcWHSB6Kx4MCuR+9ZHU+0=;
        b=PP0kTeNxc9aP/Af2S78k6pCIynfXzqQloYANp9pSyvdM+PP+4vfXeryel3EzdqjJ67
         MSAIHrDyHj2oNaCC7QSmpJ7QQJFZ2wSsxcKvChuga+Rwt+hKCJzSBUjk1zyzakfLZAnp
         M/86ycQb1JCrsMt1gTECozXIYhAXjEGrnzDpOwr+f3BzLKHWHEYtqXrcp4JnJK2jpMWW
         KbVUQWkcdSgZj+rH50JkazpO9XCJKSdFZdJLJmo+82x0IqprWAQpIvHsCicNovCtll1Q
         Gs4zyOhrSjLaX9ZqnIHm/yDw+yEnSehN7VYe0CLKIevTqfqOCmgmPb+IxsTYTQhUzwHN
         vK7A==
X-Gm-Message-State: APjAAAX2/eMeXFYWTBE8iSHnxUsPY5NNbry7qGq/NmJ73SM5nfhB4Kdt
        4jPezLleh1s9qhX1L4+vl12DGRQ6W5GC3kxQj4AuXwQLX5wihxNuWA+Mod0WgzuIkuVWHAQE+uu
        eGSC1vFrQSB3UgHm55w==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr29924154wmi.17.1580729250301;
        Mon, 03 Feb 2020 03:27:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwz2/NZq3dgLCCZvXiWBN43/B1t1AGgT4g5eEHbU17LZRUcMauKCDzB463bckTWTnO+vzipiQ==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr29924124wmi.17.1580729250044;
        Mon, 03 Feb 2020 03:27:30 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b16sm22597593wmj.39.2020.02.03.03.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 03:27:29 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3 4/5] selinux: convert cond_expr to array
Date:   Mon,  3 Feb 2020 12:27:22 +0100
Message-Id: <20200203112723.405341-5-omosnace@redhat.com>
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
 security/selinux/ss/conditional.c | 62 ++++++++++++-------------------
 security/selinux/ss/conditional.h | 14 ++++---
 2 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 82002b90809c..669b766c260b 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -23,18 +23,19 @@
  */
 static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
 {
-
-	struct cond_expr *cur;
+	u32 i;
 	int s[COND_EXPR_MAXDEPTH];
 	int sp = -1;
 
-	for (cur = expr; cur; cur = cur->next) {
-		switch (cur->expr_type) {
+	for (i = 0; i < expr->len; i++) {
+		struct cond_expr_node *node = &expr->nodes[i];
+
+		switch (node->expr_type) {
 		case COND_BOOL:
 			if (sp == (COND_EXPR_MAXDEPTH - 1))
 				return -1;
 			sp++;
-			s[sp] = p->bool_val_to_struct[cur->bool - 1]->state;
+			s[sp] = p->bool_val_to_struct[node->bool - 1]->state;
 			break;
 		case COND_NOT:
 			if (sp < 0)
@@ -91,7 +92,7 @@ void evaluate_cond_node(struct policydb *p, struct cond_node *node)
 	int new_state;
 	u32 i;
 
-	new_state = cond_evaluate_expr(p, node->expr);
+	new_state = cond_evaluate_expr(p, &node->expr);
 	if (new_state != node->cur_state) {
 		node->cur_state = new_state;
 		if (new_state == -1)
@@ -133,12 +134,7 @@ int cond_policydb_init(struct policydb *p)
 
 static void cond_node_destroy(struct cond_node *node)
 {
-	struct cond_expr *cur_expr, *next_expr;
-
-	for (cur_expr = node->expr; cur_expr; cur_expr = next_expr) {
-		next_expr = cur_expr->next;
-		kfree(cur_expr);
-	}
+	kfree(node->expr.nodes);
 	/* the avtab_ptr_t nodes are destroyed by the avtab */
 	kfree(node->true_list.nodes);
 	kfree(node->false_list.nodes);
@@ -355,7 +351,7 @@ static int cond_read_av_list(struct policydb *p, void *fp,
 	return 0;
 }
 
-static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
+static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
 {
 	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
 		pr_err("SELinux: conditional expressions uses unknown operator.\n");
@@ -372,43 +368,37 @@ static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
 static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 {
 	__le32 buf[2];
-	u32 len, i;
+	u32 i, len;
 	int rc;
-	struct cond_expr *expr = NULL, *last = NULL;
 
 	rc = next_entry(buf, fp, sizeof(u32) * 2);
 	if (rc)
-		goto err;
+		return rc;
 
 	node->cur_state = le32_to_cpu(buf[0]);
 
 	/* expr */
 	len = le32_to_cpu(buf[1]);
+	node->expr.nodes = kcalloc(len, sizeof(*node->expr.nodes), GFP_KERNEL);
+	if (!node->expr.nodes)
+		return -ENOMEM;
+
+	node->expr.len = len;
 
 	for (i = 0; i < len; i++) {
+		struct cond_expr_node *expr = &node->expr.nodes[i];
+
 		rc = next_entry(buf, fp, sizeof(u32) * 2);
 		if (rc)
 			goto err;
 
-		rc = -ENOMEM;
-		expr = kzalloc(sizeof(*expr), GFP_KERNEL);
-		if (!expr)
-			goto err;
-
 		expr->expr_type = le32_to_cpu(buf[0]);
 		expr->bool = le32_to_cpu(buf[1]);
 
-		if (!expr_isvalid(p, expr)) {
+		if (!expr_node_isvalid(p, expr)) {
 			rc = -EINVAL;
-			kfree(expr);
 			goto err;
 		}
-
-		if (i == 0)
-			node->expr = expr;
-		else
-			last->next = expr;
-		last = expr;
 	}
 
 	rc = cond_read_av_list(p, fp, &node->true_list, NULL);
@@ -513,27 +503,23 @@ static int cond_write_av_list(struct policydb *p,
 static int cond_write_node(struct policydb *p, struct cond_node *node,
 		    struct policy_file *fp)
 {
-	struct cond_expr *cur_expr;
 	__le32 buf[2];
 	int rc;
-	u32 len = 0;
+	u32 i;
 
 	buf[0] = cpu_to_le32(node->cur_state);
 	rc = put_entry(buf, sizeof(u32), 1, fp);
 	if (rc)
 		return rc;
 
-	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = cur_expr->next)
-		len++;
-
-	buf[0] = cpu_to_le32(len);
+	buf[0] = cpu_to_le32(node->expr.len);
 	rc = put_entry(buf, sizeof(u32), 1, fp);
 	if (rc)
 		return rc;
 
-	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = cur_expr->next) {
-		buf[0] = cpu_to_le32(cur_expr->expr_type);
-		buf[1] = cpu_to_le32(cur_expr->bool);
+	for (i = 0; i < node->expr.len; i++) {
+		buf[0] = cpu_to_le32(node->expr.nodes[i].expr_type);
+		buf[1] = cpu_to_le32(node->expr.nodes[i].bool);
 		rc = put_entry(buf, sizeof(u32), 2, fp);
 		if (rc)
 			return rc;
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 5f97f678440e..4677c6ff7450 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -19,7 +19,7 @@
  * A conditional expression is a list of operators and operands
  * in reverse polish notation.
  */
-struct cond_expr {
+struct cond_expr_node {
 #define COND_BOOL	1 /* plain bool */
 #define COND_NOT	2 /* !bool */
 #define COND_OR		3 /* bool || bool */
@@ -28,9 +28,13 @@ struct cond_expr {
 #define COND_EQ		6 /* bool == bool */
 #define COND_NEQ	7 /* bool != bool */
 #define COND_LAST	COND_NEQ
-	__u32 expr_type;
-	__u32 bool;
-	struct cond_expr *next;
+	u32 expr_type;
+	u32 bool;
+};
+
+struct cond_expr {
+	struct cond_expr_node *nodes;
+	u32 len;
 };
 
 /*
@@ -52,7 +56,7 @@ struct cond_av_list {
  */
 struct cond_node {
 	int cur_state;
-	struct cond_expr *expr;
+	struct cond_expr expr;
 	struct cond_av_list true_list;
 	struct cond_av_list false_list;
 };
-- 
2.24.1

