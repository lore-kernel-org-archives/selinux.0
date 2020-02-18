Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A794C34036
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 11:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AA22173E
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 11:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bysc2cnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBRL1q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:27:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22816 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbgBRL1q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 06:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582025264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4UduJvBodzXH6fCuX6h5xLtJDteFVS8NU2Lr02w1Bcw=;
        b=bysc2cnc0+aJckSOG0Th9Tn+0cAqjvvs+iS7GH5tuGy80qG7Q8F+KSbnGPjnEDUJCAwmaN
        uomTRLPtvSQ0JAZ7/DItI2RMV8Q/M+ZN63GYONsphKAXU4W/sqEx9GPIkE0HzjAHku9cSB
        lr6tk8J2CRYNVI09kDCKbm7HZxlX/sw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-f3vKSbO4PZWIhQbITiiIqQ-1; Tue, 18 Feb 2020 06:27:39 -0500
X-MC-Unique: f3vKSbO4PZWIhQbITiiIqQ-1
Received: by mail-wm1-f69.google.com with SMTP id y7so982387wmd.4
        for <selinux@vger.kernel.org>; Tue, 18 Feb 2020 03:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4UduJvBodzXH6fCuX6h5xLtJDteFVS8NU2Lr02w1Bcw=;
        b=MxFqmHuayU47HitoD10NMMIvtbzUcGvIZxKxblKVMI0GvugbmHSwg10dyWL2lXChWu
         1iqxA1i4lZxBsDKg2pn/99GOquT/1+pYqAPhPEzejOaG3NORW7HhxQ/MOQCWnnXDjb7h
         H14jwdgvYFOZgoQvcSS39MxAc0iyvAYTtlKXhUkaHVdohZ/Y2jH3rTLl3RcudFtbeYJq
         qhjHoKyWDostzMnPOMIluPB2UPuAlK+iojnwRxftRxw1qm+3T2GEte31JfZPmEqpB3fr
         g4u6QOBzCAfEHElKcE3uu6tzWVG742Yj8s9Utbh2r1Hbm+ZzSMfO85mjiaZLfHWaDrqb
         iY+g==
X-Gm-Message-State: APjAAAVKaOVm/xgBI0nqlpa0hFsV3Aqc3QXDfDLBiYttKzhvbd9OoA0U
        9U9mW/sLcJBTCR/27aKRpls535hQxRDk9Spb5zMMlV6F4T9VM5TQrlJrX5Q/3E7iY8dJNAW2SWZ
        9lummXt/j9E/CojJ7pg==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr27773191wrt.267.1582025257262;
        Tue, 18 Feb 2020 03:27:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqywJw5UCprvkeyEhoV5PTw1BEQfwoPjl2j0vTXBLo1ZngvNO63JqV+zi1xYBPXivwC5GguiPQ==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr27773158wrt.267.1582025256901;
        Tue, 18 Feb 2020 03:27:36 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o7sm3108694wmh.11.2020.02.18.03.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 03:27:36 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3] selinux: optimize storage of filename transitions
Date:   Tue, 18 Feb 2020 12:27:34 +0100
Message-Id: <20200218112734.116064-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In these rules, each rule with the same (target type, target class,
filename) values is (in practice) always mapped to the same result type.
Therefore, it is much more efficient to group the rules by (ttype,
tclass, filename).

Thus, this patch drops the stype field from the key and changes the
datum to be a linked list of one or more structures that contain a
result type and an ebitmap of source types that map the given target to
the given result type under the given filename. The size of the hash
table is also incremented to 2048 to be more optimal for Fedora policy
(which currently has ~2500 unique (ttype, tclass, filename) tuples,
regardless of whether the 'unconfined' module is enabled).

Not only does this dramtically reduce memory usage when the policy
contains a lot of unconfined domains (ergo a lot of filename based
transitions), but it also slightly reduces memory usage of strongly
confined policies (modeled on Fedora policy with 'unconfined' module
disabled) and significantly reduces lookup times of these rules on
Fedora (roughly matches the performance of the rhashtable conversion
patch [1] posted recently to selinux@vger.kernel.org).

An obvious next step is to change binary policy format to match this
layout, so that disk space is also saved. However, since that requires
more work (including matching userspace changes) and this patch is
already beneficial on its own, I'm posting it separately.

Performance/memory usage comparison:

Kernel           | Policy load | Policy load   | Mem usage | Mem usage     | openbench
                 |             | (-unconfined) |           | (-unconfined) | (createfiles)
-----------------|-------------|---------------|-----------|---------------|--------------
reference        |       1,30s |         0,91s |      90MB |          77MB | 55 us/file
rhashtable patch |       0.98s |         0,85s |      85MB |          75MB | 38 us/file
this patch       |       0,95s |         0,87s |      75MB |          75MB | 40 us/file

(Memory usage is measured after boot. With SELinux disabled the memory
usage was ~60MB on the same system.)

[1] https://lore.kernel.org/selinux/20200116213937.77795-1-dev@lynxeye.de/T/

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Changes in v3:
 - filename_trans_read_one()
   - remove the 'newdatum' variable
   - uintptr_t -> u32 (leftover from a WIP version of this patch)
   - drop 'already_there', just goto out immediately
   - allocate 'ft' using kmemdup() instead of kzalloc()
 - filename_write_helper()
   - move strlen() call outside the loop
   - move declaration of 'node' outside the loop

 security/selinux/ss/policydb.c | 166 +++++++++++++++++++--------------
 security/selinux/ss/policydb.h |   8 +-
 security/selinux/ss/services.c |  16 ++--
 3 files changed, 110 insertions(+), 80 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 4b4efd3c0b3c..32b3a8acf96f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -336,11 +336,17 @@ static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 
 static int filenametr_destroy(void *key, void *datum, void *p)
 {
-	struct filename_trans *ft = key;
+	struct filename_trans_key *ft = key;
+	struct filename_trans_datum *next, *d = datum;
 
 	kfree(ft->name);
 	kfree(key);
-	kfree(datum);
+	do {
+		ebitmap_destroy(&d->stypes);
+		next = d->next;
+		kfree(d);
+		d = next;
+	} while (unlikely(d));
 	cond_resched();
 	return 0;
 }
@@ -406,12 +412,12 @@ out:
 
 static u32 filenametr_hash(struct hashtab *h, const void *k)
 {
-	const struct filename_trans *ft = k;
+	const struct filename_trans_key *ft = k;
 	unsigned long hash;
 	unsigned int byte_num;
 	unsigned char focus;
 
-	hash = ft->stype ^ ft->ttype ^ ft->tclass;
+	hash = ft->ttype ^ ft->tclass;
 
 	byte_num = 0;
 	while ((focus = ft->name[byte_num++]))
@@ -421,14 +427,10 @@ static u32 filenametr_hash(struct hashtab *h, const void *k)
 
 static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
 {
-	const struct filename_trans *ft1 = k1;
-	const struct filename_trans *ft2 = k2;
+	const struct filename_trans_key *ft1 = k1;
+	const struct filename_trans_key *ft2 = k2;
 	int v;
 
-	v = ft1->stype - ft2->stype;
-	if (v)
-		return v;
-
 	v = ft1->ttype - ft2->ttype;
 	if (v)
 		return v;
@@ -495,7 +497,7 @@ static int policydb_init(struct policydb *p)
 		goto out;
 
 	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
-					   (1 << 10));
+					   (1 << 11));
 	if (!p->filename_trans) {
 		rc = -ENOMEM;
 		goto out;
@@ -1882,64 +1884,84 @@ out:
 
 static int filename_trans_read_one(struct policydb *p, void *fp)
 {
-	struct filename_trans *ft;
-	struct filename_trans_datum *otype = NULL;
+	struct filename_trans_key key, *ft = NULL;
+	struct filename_trans_datum *last, *datum = NULL;
 	char *name = NULL;
-	u32 len;
+	u32 len, stype, otype;
 	__le32 buf[4];
 	int rc;
 
-	ft = kzalloc(sizeof(*ft), GFP_KERNEL);
-	if (!ft)
-		return -ENOMEM;
-
-	rc = -ENOMEM;
-	otype = kmalloc(sizeof(*otype), GFP_KERNEL);
-	if (!otype)
-		goto out;
-
 	/* length of the path component string */
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc)
-		goto out;
+		return rc;
 	len = le32_to_cpu(buf[0]);
 
 	/* path component string */
 	rc = str_read(&name, GFP_KERNEL, fp, len);
 	if (rc)
-		goto out;
-
-	ft->name = name;
+		return rc;
 
 	rc = next_entry(buf, fp, sizeof(u32) * 4);
 	if (rc)
 		goto out;
 
-	ft->stype = le32_to_cpu(buf[0]);
-	ft->ttype = le32_to_cpu(buf[1]);
-	ft->tclass = le32_to_cpu(buf[2]);
+	stype = le32_to_cpu(buf[0]);
+	key.ttype = le32_to_cpu(buf[1]);
+	key.tclass = le32_to_cpu(buf[2]);
+	key.name = name;
 
-	otype->otype = le32_to_cpu(buf[3]);
+	otype = le32_to_cpu(buf[3]);
 
-	rc = ebitmap_set_bit(&p->filename_trans_ttypes, ft->ttype, 1);
-	if (rc)
-		goto out;
+	last = NULL;
+	datum = hashtab_search(p->filename_trans, &key);
+	while (datum) {
+		if (unlikely(ebitmap_get_bit(&datum->stypes, stype - 1))) {
+			/* conflicting/duplicate rules are ignored */
+			datum = NULL;
+			goto out;
+		}
+		if (likely(datum->otype == otype))
+			break;
+		last = datum;
+		datum = datum->next;
+	}
+	if (!datum) {
+		rc = -ENOMEM;
+		datum = kmalloc(sizeof(*datum), GFP_KERNEL);
+		if (!datum)
+			goto out;
 
-	rc = hashtab_insert(p->filename_trans, ft, otype);
-	if (rc) {
-		/*
-		 * Do not return -EEXIST to the caller, or the system
-		 * will not boot.
-		 */
-		if (rc == -EEXIST)
-			rc = 0;
-		goto out;
+		ebitmap_init(&datum->stypes);
+		datum->otype = otype;
+		datum->next = NULL;
+
+		if (unlikely(last)) {
+			last->next = datum;
+		} else {
+			rc = -ENOMEM;
+			ft = kmemdup(&key, sizeof(key), GFP_KERNEL);
+			if (!ft)
+				goto out;
+
+			rc = hashtab_insert(p->filename_trans, ft, datum);
+			if (rc)
+				goto out;
+			name = NULL;
+
+			rc = ebitmap_set_bit(&p->filename_trans_ttypes,
+					     key.ttype, 1);
+			if (rc)
+				return rc;
+		}
 	}
-	return 0;
+	kfree(name);
+	return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
+
 out:
 	kfree(ft);
 	kfree(name);
-	kfree(otype);
+	kfree(datum);
 	return rc;
 }
 
@@ -1957,6 +1979,8 @@ static int filename_trans_read(struct policydb *p, void *fp)
 		return rc;
 	nel = le32_to_cpu(buf[0]);
 
+	p->filename_trans_count = nel;
+
 	for (i = 0; i < nel; i++) {
 		rc = filename_trans_read_one(p, fp);
 		if (rc)
@@ -3334,50 +3358,50 @@ static int range_write(struct policydb *p, void *fp)
 
 static int filename_write_helper(void *key, void *data, void *ptr)
 {
-	__le32 buf[4];
-	struct filename_trans *ft = key;
-	struct filename_trans_datum *otype = data;
+	struct filename_trans_key *ft = key;
+	struct filename_trans_datum *datum = data;
+	struct ebitmap_node *node;
 	void *fp = ptr;
+	__le32 buf[4];
 	int rc;
-	u32 len;
+	u32 bit, len = strlen(ft->name);
 
-	len = strlen(ft->name);
-	buf[0] = cpu_to_le32(len);
-	rc = put_entry(buf, sizeof(u32), 1, fp);
-	if (rc)
-		return rc;
+	do {
+		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
+			buf[0] = cpu_to_le32(len);
+			rc = put_entry(buf, sizeof(u32), 1, fp);
+			if (rc)
+				return rc;
 
-	rc = put_entry(ft->name, sizeof(char), len, fp);
-	if (rc)
-		return rc;
+			rc = put_entry(ft->name, sizeof(char), len, fp);
+			if (rc)
+				return rc;
 
-	buf[0] = cpu_to_le32(ft->stype);
-	buf[1] = cpu_to_le32(ft->ttype);
-	buf[2] = cpu_to_le32(ft->tclass);
-	buf[3] = cpu_to_le32(otype->otype);
+			buf[0] = cpu_to_le32(bit + 1);
+			buf[1] = cpu_to_le32(ft->ttype);
+			buf[2] = cpu_to_le32(ft->tclass);
+			buf[3] = cpu_to_le32(datum->otype);
 
-	rc = put_entry(buf, sizeof(u32), 4, fp);
-	if (rc)
-		return rc;
+			rc = put_entry(buf, sizeof(u32), 4, fp);
+			if (rc)
+				return rc;
+		}
+
+		datum = datum->next;
+	} while (unlikely(datum));
 
 	return 0;
 }
 
 static int filename_trans_write(struct policydb *p, void *fp)
 {
-	u32 nel;
 	__le32 buf[1];
 	int rc;
 
 	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
 		return 0;
 
-	nel = 0;
-	rc = hashtab_map(p->filename_trans, hashtab_cnt, &nel);
-	if (rc)
-		return rc;
-
-	buf[0] = cpu_to_le32(nel);
+	buf[0] = cpu_to_le32(p->filename_trans_count);
 	rc = put_entry(buf, sizeof(u32), 1, fp);
 	if (rc)
 		return rc;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 6459616f8487..41ad78a1f17b 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -89,15 +89,16 @@ struct role_trans {
 	struct role_trans *next;
 };
 
-struct filename_trans {
-	u32 stype;		/* current process */
+struct filename_trans_key {
 	u32 ttype;		/* parent dir context */
 	u16 tclass;		/* class of new object */
 	const char *name;	/* last path component */
 };
 
 struct filename_trans_datum {
-	u32 otype;		/* expected of new object */
+	struct ebitmap stypes;	/* bitmap of source types for this otype */
+	u32 otype;		/* resulting type of new object */
+	struct filename_trans_datum *next;	/* record for next otype*/
 };
 
 struct role_allow {
@@ -267,6 +268,7 @@ struct policydb {
 	struct ebitmap filename_trans_ttypes;
 	/* actual set of filename_trans rules */
 	struct hashtab *filename_trans;
+	u32 filename_trans_count;
 
 	/* bools indexed by (value - 1) */
 	struct cond_bool_datum **bool_val_to_struct;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 57b2c6252799..f90e6550eec8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1692,8 +1692,8 @@ static void filename_compute_type(struct policydb *policydb,
 				  u32 stype, u32 ttype, u16 tclass,
 				  const char *objname)
 {
-	struct filename_trans ft;
-	struct filename_trans_datum *otype;
+	struct filename_trans_key ft;
+	struct filename_trans_datum *datum;
 
 	/*
 	 * Most filename trans rules are going to live in specific directories
@@ -1703,14 +1703,18 @@ static void filename_compute_type(struct policydb *policydb,
 	if (!ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype))
 		return;
 
-	ft.stype = stype;
 	ft.ttype = ttype;
 	ft.tclass = tclass;
 	ft.name = objname;
 
-	otype = hashtab_search(policydb->filename_trans, &ft);
-	if (otype)
-		newcontext->type = otype->otype;
+	datum = hashtab_search(policydb->filename_trans, &ft);
+	while (datum) {
+		if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
+			newcontext->type = datum->otype;
+			return;
+		}
+		datum = datum->next;
+	}
 }
 
 static int security_compute_sid(struct selinux_state *state,
-- 
2.24.1

