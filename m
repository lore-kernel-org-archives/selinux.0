Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEBBC47409
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 11:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771D02082E
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 11:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUOThVPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgBCL1f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:27:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60993 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727541AbgBCL1e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 06:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580729253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HfSkkgAS1lHWJhOfFrM9jV3tycaprszdFwk53QWSd6M=;
        b=ZUOThVPsmabxL36+JF3suX93jCBkjW9vg9oyikf9iKmcTWJ20tsj6+SoHWeUriGAzrcT5e
        gxsDTUOblWaj3yx5sofuYYDPKYBWBa0A/XOWOpaCrd6HOzKJX/iY5uGFiYVDW2jc7hvJjx
        Jh8kf95U3dTJ9E7pamhFs2ZmrMmrd74=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-ItlE5-J-M0GdXh1_Pijozw-1; Mon, 03 Feb 2020 06:27:30 -0500
X-MC-Unique: ItlE5-J-M0GdXh1_Pijozw-1
Received: by mail-wr1-f70.google.com with SMTP id o6so8053818wrp.8
        for <selinux@vger.kernel.org>; Mon, 03 Feb 2020 03:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfSkkgAS1lHWJhOfFrM9jV3tycaprszdFwk53QWSd6M=;
        b=L6q/f3Sa47Dx8yU5SAxs3p0Rfe+/dI/bTmb7aFUCiJkE37cQHrTAkJUwFo3Yr+9+aI
         YiYh2sH7WlcVCeMqjKV6W6dZ46vP1NphrJAnlxYufgw9Chn2yHlZ9OU22/0vMSJ1bUWE
         Z3Q1tOqsHkVNHWsBbLgTkHcFyF8IlBbYNjcpLeIlOp9PdKxf2F1QDsaZNClnnK6FF/+t
         FWtc0bIPf/AhkDBU02zs9lphzhcFd1Jufbf1pr73AHgYzogiAn4iIMp0Y/rHc1XDIsZ8
         OKGa8qnxZSZbPcZd56LH4piDzLZv4mapS01bitUtKIkyINbLKebGH7gLg3rlXmOWIo0L
         4Nsg==
X-Gm-Message-State: APjAAAUfIPwJlC6kiHCxNfH1lSbfojMhUXyovfDZwnoY+q06YfdhmtVA
        /vxoJ2PjXA+7h1h1lHUXGeLBH+CEcbPF6apForB8dtIP69U2dd7o00AV30zuaP5izbs33pqLpi9
        Z/GcyCEowCYLv1v9zAw==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr28548470wml.107.1580729248511;
        Mon, 03 Feb 2020 03:27:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLPGTnPxWAL7tndnxwiw9rI5qvDGTB5tYqAU3cyq5WtNVL7tnwsT4sVgEaC/52+paYWrU2Fg==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr28548439wml.107.1580729248242;
        Mon, 03 Feb 2020 03:27:28 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b16sm22597593wmj.39.2020.02.03.03.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 03:27:27 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3 2/5] selinux: convert cond_list to array
Date:   Mon,  3 Feb 2020 12:27:20 +0100
Message-Id: <20200203112723.405341-3-omosnace@redhat.com>
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

While there, also fix signedness of some related variables/parameters.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/include/conditional.h |  8 ++--
 security/selinux/selinuxfs.c           |  4 +-
 security/selinux/ss/conditional.c      | 54 ++++++++++----------------
 security/selinux/ss/conditional.h      |  3 +-
 security/selinux/ss/policydb.c         |  2 +-
 security/selinux/ss/policydb.h         |  3 +-
 security/selinux/ss/services.c         | 28 ++++++-------
 7 files changed, 43 insertions(+), 59 deletions(-)

diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
index 0ab316f61da0..539ab357707d 100644
--- a/security/selinux/include/conditional.h
+++ b/security/selinux/include/conditional.h
@@ -14,12 +14,10 @@
 #include "security.h"
 
 int security_get_bools(struct selinux_state *state,
-		       int *len, char ***names, int **values);
+		       u32 *len, char ***names, int **values);
 
-int security_set_bools(struct selinux_state *state,
-		       int len, int *values);
+int security_set_bools(struct selinux_state *state, u32 len, int *values);
 
-int security_get_bool_value(struct selinux_state *state,
-			    int index);
+int security_get_bool_value(struct selinux_state *state, u32 index);
 
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
index 04593062008d..e6d203b76545 100644
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
 
-	for (i = 0; i < len; i++) {
-		rc = -ENOMEM;
-		node = kzalloc(sizeof(*node), GFP_KERNEL);
-		if (!node)
-			goto err;
+	p->cond_list_len = len;
 
-		rc = cond_read_node(p, node, fp);
+	for (i = 0; i < len; i++) {
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
index 2aa7f2e1a8e7..8ac9b9ffc83c 100644
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
index ff43a35bb874..8fc8ec317bb6 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2868,10 +2868,11 @@ out:
 }
 
 int security_get_bools(struct selinux_state *state,
-		       int *len, char ***names, int **values)
+		       u32 *len, char ***names, int **values)
 {
 	struct policydb *policydb;
-	int i, rc;
+	u32 i;
+	int rc;
 
 	if (!selinux_initialized(state)) {
 		*len = 0;
@@ -2925,12 +2926,11 @@ err:
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
 
@@ -2958,8 +2958,8 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
 			policydb->bool_val_to_struct[i]->state = 0;
 	}
 
-	for (cur = policydb->cond_list; cur; cur = cur->next)
-		evaluate_cond_node(policydb, cur);
+	for (i = 0; i < policydb->cond_list_len; i++)
+		evaluate_cond_node(policydb, &policydb->cond_list[i]);
 
 	seqno = ++state->ss->latest_granting;
 	rc = 0;
@@ -2975,11 +2975,11 @@ out:
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
 
@@ -2999,10 +2999,10 @@ out:
 static int security_preserve_bools(struct selinux_state *state,
 				   struct policydb *policydb)
 {
-	int rc, nbools = 0, *bvalues = NULL, i;
+	int rc, *bvalues = NULL;
 	char **bnames = NULL;
 	struct cond_bool_datum *booldatum;
-	struct cond_node *cur;
+	u32 i, nbools = 0;
 
 	rc = security_get_bools(state, &nbools, &bnames, &bvalues);
 	if (rc)
@@ -3012,8 +3012,8 @@ static int security_preserve_bools(struct selinux_state *state,
 		if (booldatum)
 			booldatum->state = bvalues[i];
 	}
-	for (cur = policydb->cond_list; cur; cur = cur->next)
-		evaluate_cond_node(policydb, cur);
+	for (i = 0; i < policydb->cond_list_len; i++)
+		evaluate_cond_node(policydb, &policydb->cond_list[i]);
 
 out:
 	if (bnames) {
-- 
2.24.1

