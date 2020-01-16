Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8872C33CB3
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 12:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6A720663
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 12:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsEJ1C0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgAPMEt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:04:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48822 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbgAPMEt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 07:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579176287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8jCeJfF+XaWtJWOCFSjTvcNvVK1/zN3k1Y6FaNKIT08=;
        b=FsEJ1C0UDr2p/5r384csZcI+WD5IRAv8H1JvYHuEmcJTfKq26vVHfRedLI8y1Ys3E9MKEg
        kJ2oawg8h2kDHLTVu5teJsynPZtx7u68OUdEMdBi09/3tQ2pONfaIRGFdmhZR+yDWuW2wk
        Wu7wZE0IeZU0VMffShr1R97y6TO5g4c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-KXMGyQcvOc-zJTQwcBHNCQ-1; Thu, 16 Jan 2020 07:04:46 -0500
X-MC-Unique: KXMGyQcvOc-zJTQwcBHNCQ-1
Received: by mail-wm1-f70.google.com with SMTP id 18so1130471wmp.0
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 04:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8jCeJfF+XaWtJWOCFSjTvcNvVK1/zN3k1Y6FaNKIT08=;
        b=kuv3sprdgdfVBsMzKd+KPt4Nt34frvkMibypH5PGB+zOaLvl10eAUm5dBQcM8HKLRf
         cOcPyFP/SHWBjOcBnFOfkc5cKSI1OIU4rD3fbJpVjHT0DWkZaxXmGOfkjm6BzxgfAy8q
         bNl0fibW/106wdghz+7lM5LvEaI/5EvGVQVzjvR/dXfiRCoxGxiA+U9MqIHpZfrXvCAg
         4OAfTjKeIGCeWOFw4C81sIaV6h7VRVoOO1NUXW6bE2xcnI6QGK4CWTUhazoWYOAtSPpn
         seswi6OATz59BNxr3OBcQfRIhqgPMALfhEotzLqzAjL8wNrup1q9+dCbc8LhaaI4Klig
         mCDA==
X-Gm-Message-State: APjAAAXTU++tyw+fJb6tlyYHXAcj0EeOg/Ck9OH4rkG8NtfjO3PI27Zy
        bWo5u45Nx+UAFyNJHlZUyURJVWwKY5P8lo88/tBLFKXaagbuSNu9YkpJ4Y+JiK0fLJ593wyBJP6
        j/1VIzXHtYh8kpodO+g==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr5866129wmi.128.1579176285037;
        Thu, 16 Jan 2020 04:04:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqznO+akwHffBifyLMRiSjxG3wx8bcbbQ/EWMVgHH/bw9BYw+1dis3Qb5a4ONzCGD3j6jUxNoQ==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr5866100wmi.128.1579176284712;
        Thu, 16 Jan 2020 04:04:44 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b67sm278117wmc.38.2020.01.16.04.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:04:43 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 3/6] selinux: convert cond_list to array
Date:   Thu, 16 Jan 2020 13:04:36 +0100
Message-Id: <20200116120439.303034-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116120439.303034-1-omosnace@redhat.com>
References: <20200116120439.303034-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since it is fixed-size after allocation and we know the size beforehand,
using a plain old array is simpler and more efficient.

While there, also fix signedness of some related variables/parameters.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/include/conditional.h |  6 +--
 security/selinux/selinuxfs.c           |  4 +-
 security/selinux/ss/conditional.c      | 54 ++++++++++----------------
 security/selinux/ss/conditional.h      |  3 +-
 security/selinux/ss/policydb.c         |  2 +-
 security/selinux/ss/policydb.h         |  3 +-
 security/selinux/ss/services.c         | 27 +++++++------
 7 files changed, 42 insertions(+), 57 deletions(-)

diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
index 0ab316f61da0..ffb9a33341f8 100644
--- a/security/selinux/include/conditional.h
+++ b/security/selinux/include/conditional.h
@@ -14,12 +14,12 @@
 #include "security.h"
 
 int security_get_bools(struct selinux_state *state,
-		       int *len, char ***names, int **values);
+		       u32 *len, char ***names, int **values);
 
 int security_set_bools(struct selinux_state *state,
-		       int len, int *values);
+		       u32 len, int *values);
 
 int security_get_bool_value(struct selinux_state *state,
-			    int index);
+			    u32 index);
 
 #endif
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 79c710911a3c..296ce86e8b1f 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1327,14 +1327,14 @@ static void sel_remove_entries(struct dentry *de)
 
 static int sel_make_bools(struct selinux_fs_info *fsi)
 {
-	int i, ret;
+	int ret;
 	ssize_t len;
 	struct dentry *dentry = NULL;
 	struct dentry *dir = fsi->bool_dir;
 	struct inode *inode = NULL;
 	struct inode_security_struct *isec;
 	char **names = NULL, *page;
-	int num;
+	u32 i, num;
 	int *values = NULL;
 	u32 sid;
 
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 04593062008d..c8a02c9b23ee 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -119,6 +119,7 @@ int cond_policydb_init(struct policydb *p)
 
 	p->bool_val_to_struct = NULL;
 	p->cond_list = NULL;
+	p->cond_list_len = 0;
 
 	rc = avtab_init(&p->te_cond_avtab);
 	if (rc)
@@ -147,27 +148,22 @@ static void cond_node_destroy(struct cond_node *node)
 	}
 	cond_av_list_destroy(node->true_list);
 	cond_av_list_destroy(node->false_list);
-	kfree(node);
 }
 
-static void cond_list_destroy(struct cond_node *list)
+static void cond_list_destroy(struct policydb *p)
 {
-	struct cond_node *next, *cur;
+	u32 i;
 
-	if (list == NULL)
-		return;
-
-	for (cur = list; cur; cur = next) {
-		next = cur->next;
-		cond_node_destroy(cur);
-	}
+	for (i = 0; i < p->cond_list_len; i++)
+		cond_node_destroy(&p->cond_list[i]);
+	kfree(p->cond_list);
 }
 
 void cond_policydb_destroy(struct policydb *p)
 {
 	kfree(p->bool_val_to_struct);
 	avtab_destroy(&p->te_cond_avtab);
-	cond_list_destroy(p->cond_list);
+	cond_list_destroy(p);
 }
 
 int cond_init_bool_indexes(struct policydb *p)
@@ -447,7 +443,6 @@ err:
 
 int cond_read_list(struct policydb *p, void *fp)
 {
-	struct cond_node *node, *last = NULL;
 	__le32 buf[1];
 	u32 i, len;
 	int rc;
@@ -458,29 +453,24 @@ int cond_read_list(struct policydb *p, void *fp)
 
 	len = le32_to_cpu(buf[0]);
 
+	p->cond_list = kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
+	if (!p->cond_list)
+		return rc;
+
 	rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
 	if (rc)
 		goto err;
 
 	for (i = 0; i < len; i++) {
-		rc = -ENOMEM;
-		node = kzalloc(sizeof(*node), GFP_KERNEL);
-		if (!node)
-			goto err;
-
-		rc = cond_read_node(p, node, fp);
+		rc = cond_read_node(p, &p->cond_list[i], fp);
 		if (rc)
 			goto err;
-
-		if (i == 0)
-			p->cond_list = node;
-		else
-			last->next = node;
-		last = node;
 	}
+
+	p->cond_list_len = len;
 	return 0;
 err:
-	cond_list_destroy(p->cond_list);
+	cond_list_destroy(p);
 	p->cond_list = NULL;
 	return rc;
 }
@@ -585,23 +575,19 @@ static int cond_write_node(struct policydb *p, struct cond_node *node,
 	return 0;
 }
 
-int cond_write_list(struct policydb *p, struct cond_node *list, void *fp)
+int cond_write_list(struct policydb *p, void *fp)
 {
-	struct cond_node *cur;
-	u32 len;
+	u32 i;
 	__le32 buf[1];
 	int rc;
 
-	len = 0;
-	for (cur = list; cur != NULL; cur = cur->next)
-		len++;
-	buf[0] = cpu_to_le32(len);
+	buf[0] = cpu_to_le32(p->cond_list_len);
 	rc = put_entry(buf, sizeof(u32), 1, fp);
 	if (rc)
 		return rc;
 
-	for (cur = list; cur != NULL; cur = cur->next) {
-		rc = cond_write_node(p, cur, fp);
+	for (i = 0; i < p->cond_list_len; i++) {
+		rc = cond_write_node(p, &p->cond_list[i], fp);
 		if (rc)
 			return rc;
 	}
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index d86ef286ca84..e474bdd3a0ed 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -55,7 +55,6 @@ struct cond_node {
 	struct cond_expr *expr;
 	struct cond_av_list *true_list;
 	struct cond_av_list *false_list;
-	struct cond_node *next;
 };
 
 int cond_policydb_init(struct policydb *p);
@@ -69,7 +68,7 @@ int cond_index_bool(void *key, void *datum, void *datap);
 int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp);
 int cond_read_list(struct policydb *p, void *fp);
 int cond_write_bool(void *key, void *datum, void *ptr);
-int cond_write_list(struct policydb *p, struct cond_node *list, void *fp);
+int cond_write_list(struct policydb *p, void *fp);
 
 void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
 		struct av_decision *avd, struct extended_perms *xperms);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e369b0092cdf..ef1718394dee 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -3483,7 +3483,7 @@ int policydb_write(struct policydb *p, void *fp)
 	if (rc)
 		return rc;
 
-	rc = cond_write_list(p, p->cond_list, fp);
+	rc = cond_write_list(p, fp);
 	if (rc)
 		return rc;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 69b24191fa38..6459616f8487 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -272,8 +272,9 @@ struct policydb {
 	struct cond_bool_datum **bool_val_to_struct;
 	/* type enforcement conditional access vectors and transitions */
 	struct avtab te_cond_avtab;
-	/* linked list indexing te_cond_avtab by conditional */
+	/* array indexing te_cond_avtab by conditional */
 	struct cond_node *cond_list;
+	u32 cond_list_len;
 
 	/* role allows */
 	struct role_allow *role_allow;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b9eda7d89e22..b0f71afcf4b8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2864,10 +2864,11 @@ out:
 }
 
 int security_get_bools(struct selinux_state *state,
-		       int *len, char ***names, int **values)
+		       u32 *len, char ***names, int **values)
 {
 	struct policydb *policydb;
-	int i, rc;
+	u32 i;
+	int rc;
 
 	if (!state->initialized) {
 		*len = 0;
@@ -2921,12 +2922,11 @@ err:
 }
 
 
-int security_set_bools(struct selinux_state *state, int len, int *values)
+int security_set_bools(struct selinux_state *state, u32 len, int *values)
 {
 	struct policydb *policydb;
-	int i, rc;
-	int lenp, seqno = 0;
-	struct cond_node *cur;
+	int rc;
+	u32 i, lenp, seqno = 0;
 
 	write_lock_irq(&state->ss->policy_rwlock);
 
@@ -2954,8 +2954,8 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
 			policydb->bool_val_to_struct[i]->state = 0;
 	}
 
-	for (cur = policydb->cond_list; cur; cur = cur->next)
-		evaluate_cond_node(policydb, cur);
+	for (i = 0; i < policydb->cond_list_len; i++)
+		evaluate_cond_node(policydb, &policydb->cond_list[i]);
 
 	seqno = ++state->ss->latest_granting;
 	rc = 0;
@@ -2971,11 +2971,11 @@ out:
 }
 
 int security_get_bool_value(struct selinux_state *state,
-			    int index)
+			    u32 index)
 {
 	struct policydb *policydb;
 	int rc;
-	int len;
+	u32 len;
 
 	read_lock(&state->ss->policy_rwlock);
 
@@ -2996,8 +2996,7 @@ static void security_preserve_bools(struct policydb *oldpolicydb,
 				    struct policydb *newpolicydb)
 {
 	struct cond_bool_datum *booldatum;
-	struct cond_node *cur;
-	int i;
+	u32 i;
 
 	for (i = 0; i < oldpolicydb->p_bools.nprim; i++) {
 		const char *name = sym_name(oldpolicydb, SYM_BOOLS, i);
@@ -3007,8 +3006,8 @@ static void security_preserve_bools(struct policydb *oldpolicydb,
 		if (booldatum)
 			booldatum->state = value;
 	}
-	for (cur = newpolicydb->cond_list; cur; cur = cur->next)
-		evaluate_cond_node(newpolicydb, cur);
+	for (i = 0; i < newpolicydb->cond_list_len; i++)
+		evaluate_cond_node(newpolicydb, &newpolicydb->cond_list[i]);
 }
 
 /*
-- 
2.24.1

