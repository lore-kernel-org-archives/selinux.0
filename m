Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEFFC2BA17
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 16:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAD024917
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 16:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRBb/1kI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgDFQgF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:36:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbgDFQgF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 12:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586190963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FN2IciVmlgH++hCn0tu4bxOvL+zdMxiugUBauBIQTLw=;
        b=WRBb/1kI9j93CZ6pM6vhqmJjT+CTHhPj85N8MxF31JompsNm3hG1CBTFkxUllXfEW2hPKG
        Z1a8zNlbPtRL24dm4zI/TuxF7cto7Nq0nfUNa+yF3ISgUfDzMBD4oH7LVU/iqZlZpCyFCM
        KWjAbCPiLrTRbscTEJvqI9ih9/N8u3o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-PluQ5vo3PxqQy5u_2bvDjQ-1; Mon, 06 Apr 2020 12:36:01 -0400
X-MC-Unique: PluQ5vo3PxqQy5u_2bvDjQ-1
Received: by mail-wr1-f71.google.com with SMTP id g6so82046wru.8
        for <selinux@vger.kernel.org>; Mon, 06 Apr 2020 09:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FN2IciVmlgH++hCn0tu4bxOvL+zdMxiugUBauBIQTLw=;
        b=RTuEBzSv8SGnjT65mJs7FAWFEzbg4fJzZy/4Sf01v+MtJNJ9Z97U18TxmqINN6ejKz
         YRJkLUvb1g2mYd20c5oNZ4PVicGD6Jr4rg/F7+TuRoEo9qRl+t2DE4n5YsVBOA3Iwrm7
         2LpFOe0arJDWHpaE/KyubkMRBofbo/44/lBa0/6PkHWhQAKfYAgDSt/6VdZ02xwOYJ7p
         DYVXMdlD5OeZ2LyVsBSUAcE60vrfxiEl+dr8zBURDn/sF6s2bI//r1VbNX+PTyUqs98z
         IDQKfGstub3AYp/rRNfWpvrTuP0tGAWVl6bPvahjXwZvHCG4cNBmY44ff4vczjkXr2XK
         4pIg==
X-Gm-Message-State: AGi0PubYaTcfHicKvnOxbrhNVSJDZNF/8IW1SDEfbcZw01XMI0Pre5Cr
        HpdXYd0CAMEfPsSByHcfDYE09F6vwZmrTN6eCXWxZXQPJ/CnSTut/mq5wIsQGwYGXb+buQRfNtR
        TLy6KZY7oZyMShUGx6A==
X-Received: by 2002:a05:600c:2a52:: with SMTP id x18mr2569wme.37.1586190959524;
        Mon, 06 Apr 2020 09:35:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypKV0Xwe273/i4K5n3WxYfnuraWPqdpfX+H60i/XwQBFglkatrBE+xm9u6Gsmd8ey9kjsKaRzQ==
X-Received: by 2002:a05:600c:2a52:: with SMTP id x18mr2534wme.37.1586190959092;
        Mon, 06 Apr 2020 09:35:59 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id a67sm139856wmc.30.2020.04.06.09.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:35:58 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: store role transitions in a hash table
Date:   Mon,  6 Apr 2020 18:35:56 +0200
Message-Id: <20200406163556.997001-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently, they are stored in a linked list, which adds significant
overhead to security_transition_sid(). On Fedora, with 428 role
transitions in policy, converting this list to a hash table cuts down
its run time by about 50%. This was measured by running 'stress-ng -t 30
--metrics-brief --msg 0' under perf with and without this patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 138 ++++++++++++++++++++++-----------
 security/selinux/ss/policydb.h |   8 +-
 security/selinux/ss/services.c |  21 +++--
 3 files changed, 107 insertions(+), 60 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 70ecdc78efbd..4f0cfffd008d 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -352,6 +352,13 @@ static int range_tr_destroy(void *key, void *datum, void *p)
 	return 0;
 }
 
+static int role_tr_destroy(void *key, void *datum, void *p)
+{
+	kfree(key);
+	kfree(datum);
+	return 0;
+}
+
 static void ocontext_destroy(struct ocontext *c, int i)
 {
 	if (!c)
@@ -458,6 +465,30 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
 	return v;
 }
 
+static u32 role_trans_hash(struct hashtab *h, const void *k)
+{
+	const struct role_trans_key *key = k;
+
+	return (key->role + (key->type << 3) + (key->tclass << 5)) &
+		(h->size - 1);
+}
+
+static int role_trans_cmp(struct hashtab *h, const void *k1, const void *k2)
+{
+	const struct role_trans_key *key1 = k1, *key2 = k2;
+	int v;
+
+	v = key1->role - key2->role;
+	if (v)
+		return v;
+
+	v = key1->type - key2->type;
+	if (v)
+		return v;
+
+	return key1->tclass - key2->tclass;
+}
+
 /*
  * Initialize a policy database structure.
  */
@@ -728,7 +759,6 @@ void policydb_destroy(struct policydb *p)
 	struct genfs *g, *gtmp;
 	int i;
 	struct role_allow *ra, *lra = NULL;
-	struct role_trans *tr, *ltr = NULL;
 
 	for (i = 0; i < SYM_NUM; i++) {
 		cond_resched();
@@ -775,12 +805,8 @@ void policydb_destroy(struct policydb *p)
 
 	cond_policydb_destroy(p);
 
-	for (tr = p->role_tr; tr; tr = tr->next) {
-		cond_resched();
-		kfree(ltr);
-		ltr = tr;
-	}
-	kfree(ltr);
+	hashtab_map(p->role_tr, role_tr_destroy, NULL);
+	hashtab_destroy(p->role_tr);
 
 	for (ra = p->role_allow; ra; ra = ra->next) {
 		cond_resched();
@@ -2251,7 +2277,8 @@ out:
 int policydb_read(struct policydb *p, void *fp)
 {
 	struct role_allow *ra, *lra;
-	struct role_trans *tr, *ltr;
+	struct role_trans_key *rtk = NULL;
+	struct role_trans_datum *rtd = NULL;
 	int i, j, rc;
 	__le32 buf[4];
 	u32 len, nprim, nel;
@@ -2416,39 +2443,50 @@ int policydb_read(struct policydb *p, void *fp)
 	if (rc)
 		goto bad;
 	nel = le32_to_cpu(buf[0]);
-	ltr = NULL;
+
+	p->role_tr = hashtab_create(role_trans_hash, role_trans_cmp, nel);
+	if (!p->role_tr)
+		goto bad;
 	for (i = 0; i < nel; i++) {
 		rc = -ENOMEM;
-		tr = kzalloc(sizeof(*tr), GFP_KERNEL);
-		if (!tr)
+		rtk = kmalloc(sizeof(*rtk), GFP_KERNEL);
+		if (!rtk)
 			goto bad;
-		if (ltr)
-			ltr->next = tr;
-		else
-			p->role_tr = tr;
+
+		rc = -ENOMEM;
+		rtd = kmalloc(sizeof(*rtd), GFP_KERNEL);
+		if (!rtd)
+			goto bad;
+
 		rc = next_entry(buf, fp, sizeof(u32)*3);
 		if (rc)
 			goto bad;
 
 		rc = -EINVAL;
-		tr->role = le32_to_cpu(buf[0]);
-		tr->type = le32_to_cpu(buf[1]);
-		tr->new_role = le32_to_cpu(buf[2]);
+		rtk->role = le32_to_cpu(buf[0]);
+		rtk->type = le32_to_cpu(buf[1]);
+		rtd->new_role = le32_to_cpu(buf[2]);
 		if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
 			rc = next_entry(buf, fp, sizeof(u32));
 			if (rc)
 				goto bad;
-			tr->tclass = le32_to_cpu(buf[0]);
+			rtk->tclass = le32_to_cpu(buf[0]);
 		} else
-			tr->tclass = p->process_class;
+			rtk->tclass = p->process_class;
 
 		rc = -EINVAL;
-		if (!policydb_role_isvalid(p, tr->role) ||
-		    !policydb_type_isvalid(p, tr->type) ||
-		    !policydb_class_isvalid(p, tr->tclass) ||
-		    !policydb_role_isvalid(p, tr->new_role))
+		if (!policydb_role_isvalid(p, rtk->role) ||
+		    !policydb_type_isvalid(p, rtk->type) ||
+		    !policydb_class_isvalid(p, rtk->tclass) ||
+		    !policydb_role_isvalid(p, rtd->new_role))
+			goto bad;
+
+		rc = hashtab_insert(p->role_tr, rtk, rtd);
+		if (rc)
 			goto bad;
-		ltr = tr;
+
+		rtk = NULL;
+		rtd = NULL;
 	}
 
 	rc = next_entry(buf, fp, sizeof(u32));
@@ -2536,6 +2574,8 @@ int policydb_read(struct policydb *p, void *fp)
 out:
 	return rc;
 bad:
+	kfree(rtk);
+	kfree(rtd);
 	policydb_destroy(p);
 	goto out;
 }
@@ -2653,39 +2693,45 @@ static int cat_write(void *vkey, void *datum, void *ptr)
 	return 0;
 }
 
-static int role_trans_write(struct policydb *p, void *fp)
+static int role_trans_write_one(void *key, void *datum, void *ptr)
 {
-	struct role_trans *r = p->role_tr;
-	struct role_trans *tr;
+	struct role_trans_key *rtk = key;
+	struct role_trans_datum *rtd = datum;
+	struct policy_data *pd = ptr;
+	void *fp = pd->fp;
+	struct policydb *p = pd->p;
 	__le32 buf[3];
-	size_t nel;
 	int rc;
 
-	nel = 0;
-	for (tr = r; tr; tr = tr->next)
-		nel++;
-	buf[0] = cpu_to_le32(nel);
-	rc = put_entry(buf, sizeof(u32), 1, fp);
+	buf[0] = cpu_to_le32(rtk->role);
+	buf[1] = cpu_to_le32(rtk->type);
+	buf[2] = cpu_to_le32(rtd->new_role);
+	rc = put_entry(buf, sizeof(u32), 3, fp);
 	if (rc)
 		return rc;
-	for (tr = r; tr; tr = tr->next) {
-		buf[0] = cpu_to_le32(tr->role);
-		buf[1] = cpu_to_le32(tr->type);
-		buf[2] = cpu_to_le32(tr->new_role);
-		rc = put_entry(buf, sizeof(u32), 3, fp);
+	if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
+		buf[0] = cpu_to_le32(rtk->tclass);
+		rc = put_entry(buf, sizeof(u32), 1, fp);
 		if (rc)
 			return rc;
-		if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
-			buf[0] = cpu_to_le32(tr->tclass);
-			rc = put_entry(buf, sizeof(u32), 1, fp);
-			if (rc)
-				return rc;
-		}
 	}
-
 	return 0;
 }
 
+static int role_trans_write(struct policydb *p, void *fp)
+{
+	struct policy_data pd = { .p = p, .fp = fp };
+	__le32 buf[1];
+	int rc;
+
+	buf[0] = cpu_to_le32(p->role_tr->nel);
+	rc = put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	return hashtab_map(p->role_tr, role_trans_write_one, &pd);
+}
+
 static int role_allow_write(struct role_allow *r, void *fp)
 {
 	struct role_allow *ra;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 72e2932fb12d..d3adb522d3f3 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -81,12 +81,14 @@ struct role_datum {
 	struct ebitmap types;		/* set of authorized types for role */
 };
 
-struct role_trans {
+struct role_trans_key {
 	u32 role;		/* current role */
 	u32 type;		/* program executable type, or new object type */
 	u32 tclass;		/* process class, or new object class */
+};
+
+struct role_trans_datum {
 	u32 new_role;		/* new role */
-	struct role_trans *next;
 };
 
 struct filename_trans_key {
@@ -261,7 +263,7 @@ struct policydb {
 	struct avtab te_avtab;
 
 	/* role transitions */
-	struct role_trans *role_tr;
+	struct hashtab *role_tr;
 
 	/* file transitions with the last path component */
 	/* quickly exclude lookups when parent ttype has no rules */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8ad34fd031d1..3cb8ec7b09a3 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1731,7 +1731,6 @@ static int security_compute_sid(struct selinux_state *state,
 	struct class_datum *cladatum = NULL;
 	struct context *scontext, *tcontext, newcontext;
 	struct sidtab_entry *sentry, *tentry;
-	struct role_trans *roletr = NULL;
 	struct avtab_key avkey;
 	struct avtab_datum *avdatum;
 	struct avtab_node *node;
@@ -1864,16 +1863,16 @@ static int security_compute_sid(struct selinux_state *state,
 	/* Check for class-specific changes. */
 	if (specified & AVTAB_TRANSITION) {
 		/* Look for a role transition rule. */
-		for (roletr = policydb->role_tr; roletr;
-		     roletr = roletr->next) {
-			if ((roletr->role == scontext->role) &&
-			    (roletr->type == tcontext->type) &&
-			    (roletr->tclass == tclass)) {
-				/* Use the role transition rule. */
-				newcontext.role = roletr->new_role;
-				break;
-			}
-		}
+		struct role_trans_datum *rtd;
+		struct role_trans_key rtk = {
+			.role = scontext->role,
+			.type = scontext->type,
+			.tclass = tclass,
+		};
+
+		rtd = hashtab_search(policydb->role_tr, &rtk);
+		if (rtd)
+			newcontext.role = rtd->new_role;
 	}
 
 	/* Set the MLS attributes.
-- 
2.25.1

