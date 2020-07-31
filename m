Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A865DC433E1
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 11:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE612245C
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 11:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULvjHfe6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbgGaLKw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:10:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49781 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732385AbgGaLKv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 07:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596193849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LRs9SwzFJJLEQYIvYLApXbk5QY6LnOu6C0+6sPR5cQU=;
        b=ULvjHfe6m8cLRPaOWILdOBJ3NLVgFntF1xVkyidCSGpZVb5VpIhaWd6Vl/VQ4A9ubqL4vo
        tQZmdKPp/kLtZl4rL/Q3Jg7zphnPqSbVo1xkLrU3Y3GN2FLyBJIcz2qE5YMFqGT8sMqXHM
        +bexWlr3cgU1aZH8QyayMPP4ISvWHAw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-8kfNGBUhMuycdmNbx7TklQ-1; Fri, 31 Jul 2020 07:10:48 -0400
X-MC-Unique: 8kfNGBUhMuycdmNbx7TklQ-1
Received: by mail-ej1-f70.google.com with SMTP id l18so10965028ejn.17
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 04:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRs9SwzFJJLEQYIvYLApXbk5QY6LnOu6C0+6sPR5cQU=;
        b=pliE8dfB5mm69oozufU5l6IK0HOXe1VhEL+cvn9aX6w61Cgz5XkQDxTLcpcG6x87B/
         nxdbvvaRIBlyxe5ox1baRPZKaAAimRyGHBlAduCMeuLTcqQeJHWW22k6KyUZF0J2xDmw
         E5q9eVT8xn/MqBpFpRxkFLXjXGd6/Po9OP9sASyFJReLb5McvchJ/ILj94GAZzoWQwm2
         S8xAnvoxzbKilm/pY5XKQWXXpSHbQ+K+GB0ctKUs9afqJ/zRFOFZ/+oenwwL9SsWOpoH
         ddcD4xxFltHKuFAOciruTbj5X9vB3j2hiMdZiMuPw5yBzb+UfEHmapa1sSzN5cxBRFMR
         Nbsw==
X-Gm-Message-State: AOAM530Z+pPiPuCVpkdAaVg7V2U9h+lyCVeEqfEKhlizRHeJzW0uS/+R
        so3U3A/YPmctteW2lWFPV7aInB+0G5Y4KGvuV0781gn5eUXpLkjQ7PmkoAybBqX5Z9fJjXtBDso
        kkDS3/1SJ5eRHLOotmA==
X-Received: by 2002:a17:906:eb4f:: with SMTP id mc15mr3376019ejb.435.1596193845809;
        Fri, 31 Jul 2020 04:10:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDR1TdguT8ZnzyyE2NkPi2ES3EfCq2Os/qar7rzCzNOt0ksjUxjRPP9QsuIt+ZEswtQ6DLaA==
X-Received: by 2002:a17:906:eb4f:: with SMTP id mc15mr3376003ejb.435.1596193845576;
        Fri, 31 Jul 2020 04:10:45 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:8a6a:ec88:3ed7:44b3])
        by smtp.gmail.com with ESMTPSA id bq8sm8935971ejb.103.2020.07.31.04.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 04:10:45 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v6 2/2] libsepol: implement POLICYDB_VERSION_COMP_FTRANS
Date:   Fri, 31 Jul 2020 13:10:35 +0200
Message-Id: <20200731111035.498656-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731111035.498656-1-omosnace@redhat.com>
References: <20200731111035.498656-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Implement a new, more space-efficient form of storing filename
transitions in the binary policy. The internal structures have already
been converted to this new representation; this patch just implements
reading/writing an equivalent representation from/to the binary policy.

This new format reduces the size of Fedora policy from 7.6 MB to only
3.3 MB (with policy optimization enabled in both cases). With the
unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/include/sepol/policydb/policydb.h |   3 +-
 libsepol/src/policydb.c                    | 209 +++++++++++++++++----
 libsepol/src/write.c                       |  73 ++++++-
 3 files changed, 242 insertions(+), 43 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index c3180c61..9ef43abc 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -755,10 +755,11 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 #define POLICYDB_VERSION_XPERMS_IOCTL	30 /* Linux-specific */
 #define POLICYDB_VERSION_INFINIBAND		31 /* Linux-specific */
 #define POLICYDB_VERSION_GLBLUB		32
+#define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitions */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_GLBLUB
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_COMP_FTRANS
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 0b98d50b..ce8f3ad7 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -200,6 +200,13 @@ static struct policydb_compat_info policydb_compat[] = {
 	 .ocon_num = OCON_IBENDPORT + 1,
 	 .target_platform = SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_COMP_FTRANS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_IBENDPORT + 1,
+	 .target_platform = SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
@@ -2669,65 +2676,201 @@ int policydb_filetrans_insert(policydb_t *p, uint32_t stype, uint32_t ttype,
 	return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
 }
 
-int filename_trans_read(policydb_t *p, struct policy_file *fp)
+static int filename_trans_read_one_compat(policydb_t *p, struct policy_file *fp)
 {
-	unsigned int i;
-	uint32_t buf[4], nel, len, stype, ttype, tclass, otype;
+	uint32_t buf[4], len, stype, ttype, tclass, otype;
+	char *name = NULL;
 	int rc;
-	char *name;
 
 	rc = next_entry(buf, fp, sizeof(uint32_t));
 	if (rc < 0)
 		return -1;
-	nel = le32_to_cpu(buf[0]);
+	len = le32_to_cpu(buf[0]);
+	if (zero_or_saturated(len))
+		return -1;
 
-	for (i = 0; i < nel; i++) {
-		name = NULL;
+	name = calloc(len + 1, sizeof(*name));
+	if (!name)
+		return -1;
 
-		rc = next_entry(buf, fp, sizeof(uint32_t));
-		if (rc < 0)
-			goto err;
-		len = le32_to_cpu(buf[0]);
-		if (zero_or_saturated(len))
+	rc = next_entry(name, fp, len);
+	if (rc < 0)
+		goto err;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
+	if (rc < 0)
+		goto err;
+
+	stype  = le32_to_cpu(buf[0]);
+	ttype  = le32_to_cpu(buf[1]);
+	tclass = le32_to_cpu(buf[2]);
+	otype  = le32_to_cpu(buf[3]);
+
+	rc = policydb_filetrans_insert(p, stype, ttype, tclass, name, &name,
+				       otype, NULL);
+	if (rc) {
+		if (rc != SEPOL_EEXIST)
 			goto err;
+		/*
+		 * Some old policies were wrongly generated with
+		 * duplicate filename transition rules.  For backward
+		 * compatibility, do not reject such policies, just
+		 * ignore the duplicate.
+		 */
+	}
+	free(name);
+	return 0;
+err:
+	free(name);
+	return -1;
+}
+
+static int filename_trans_check_datum(filename_trans_datum_t *datum)
+{
+	ebitmap_t stypes, otypes;
+	int rc = -1;
+
+	ebitmap_init(&stypes);
+	ebitmap_init(&otypes);
+
+	while (datum) {
+		if (ebitmap_get_bit(&otypes, datum->otype))
+			goto out;
+
+		if (ebitmap_set_bit(&otypes, datum->otype, 1))
+			goto out;
+
+		if (ebitmap_match_any(&stypes, &datum->stypes))
+			goto out;
 
-		name = calloc(len + 1, sizeof(*name));
-		if (!name)
+		if (ebitmap_union(&stypes, &datum->stypes))
+			goto out;
+
+		datum = datum->next;
+	}
+	rc = 0;
+out:
+	ebitmap_destroy(&stypes);
+	ebitmap_destroy(&otypes);
+	return rc;
+}
+
+static int filename_trans_read_one(policydb_t *p, struct policy_file *fp)
+{
+	filename_trans_key_t *ft = NULL;
+	filename_trans_datum_t **dst, *datum, *first = NULL;
+	unsigned int i;
+	uint32_t buf[3], len, ttype, tclass, ndatum;
+	char *name = NULL;
+	int rc;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	len = le32_to_cpu(buf[0]);
+	if (zero_or_saturated(len))
+		return -1;
+
+	name = calloc(len + 1, sizeof(*name));
+	if (!name)
+		return -1;
+
+	rc = next_entry(name, fp, len);
+	if (rc < 0)
+		goto err;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
+	if (rc < 0)
+		goto err;
+
+	ttype = le32_to_cpu(buf[0]);
+	tclass = le32_to_cpu(buf[1]);
+	ndatum = le32_to_cpu(buf[2]);
+	if (ndatum == 0)
+		goto err;
+
+	dst = &first;
+	for (i = 0; i < ndatum; i++) {
+		datum = malloc(sizeof(*datum));
+		if (!datum)
 			goto err;
 
-		rc = next_entry(name, fp, len);
+		*dst = datum;
+
+		/* ebitmap_read() will at least init the bitmap */
+		rc = ebitmap_read(&datum->stypes, fp);
 		if (rc < 0)
 			goto err;
 
-		rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
+		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
 			goto err;
 
-		stype  = le32_to_cpu(buf[0]);
-		ttype  = le32_to_cpu(buf[1]);
-		tclass = le32_to_cpu(buf[2]);
-		otype  = le32_to_cpu(buf[3]);
+		datum->otype = le32_to_cpu(buf[0]);
 
-		rc = policydb_filetrans_insert(p, stype, ttype, tclass, name,
-					       &name, otype, NULL);
-		if (rc) {
-			if (rc != SEPOL_EEXIST)
-				goto err;
-			/*
-			 * Some old policies were wrongly generated with
-			 * duplicate filename transition rules.  For backward
-			 * compatibility, do not reject such policies, just
-			 * ignore the duplicate.
-			 */
-		}
-		free(name);
+		p->filename_trans_count += ebitmap_cardinality(&datum->stypes);
+
+		dst = &datum->next;
 	}
+	*dst = NULL;
+
+	if (ndatum > 1 && filename_trans_check_datum(first))
+		goto err;
+
+	ft = malloc(sizeof(*ft));
+	if (!ft)
+		goto err;
+
+	ft->ttype = ttype;
+	ft->tclass = tclass;
+	ft->name = name;
+
+	rc = hashtab_insert(p->filename_trans, (hashtab_key_t)ft,
+			    (hashtab_datum_t)first);
+	if (rc)
+		goto err;
+
 	return 0;
 err:
+	free(ft);
 	free(name);
+	while (first) {
+		datum = first;
+		first = first->next;
+
+		ebitmap_destroy(&datum->stypes);
+		free(datum);
+	}
 	return -1;
 }
 
+int filename_trans_read(policydb_t *p, struct policy_file *fp)
+{
+	unsigned int i;
+	uint32_t buf[1], nel;
+	int rc;
+
+	rc = next_entry(buf, fp, sizeof(uint32_t));
+	if (rc < 0)
+		return -1;
+	nel = le32_to_cpu(buf[0]);
+
+	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+		for (i = 0; i < nel; i++) {
+			rc = filename_trans_read_one_compat(p, fp);
+			if (rc < 0)
+				return -1;
+		}
+	} else {
+		for (i = 0; i < nel; i++) {
+			rc = filename_trans_read_one(p, fp);
+			if (rc < 0)
+				return -1;
+		}
+	}
+	return 0;
+}
+
 static int ocontext_read_xen(struct policydb_compat_info *info,
 	policydb_t *p, struct policy_file *fp)
 {
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index d3aee8d5..84bcaf3f 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -569,7 +569,7 @@ static int role_allow_write(role_allow_t * r, struct policy_file *fp)
 	return POLICYDB_SUCCESS;
 }
 
-static int filename_write_helper(hashtab_key_t key, void *data, void *ptr)
+static int filename_write_one_compat(hashtab_key_t key, void *data, void *ptr)
 {
 	uint32_t bit, buf[4];
 	size_t items, len;
@@ -605,6 +605,54 @@ static int filename_write_helper(hashtab_key_t key, void *data, void *ptr)
 	return 0;
 }
 
+static int filename_write_one(hashtab_key_t key, void *data, void *ptr)
+{
+	uint32_t buf[3];
+	size_t items, len, ndatum;
+	filename_trans_key_t *ft = (filename_trans_key_t *)key;
+	filename_trans_datum_t *datum;
+	void *fp = ptr;
+
+	len = strlen(ft->name);
+	buf[0] = cpu_to_le32(len);
+	items = put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return POLICYDB_ERROR;
+
+	items = put_entry(ft->name, sizeof(char), len, fp);
+	if (items != len)
+		return POLICYDB_ERROR;
+
+	ndatum = 0;
+	datum = data;
+	do {
+		ndatum++;
+		datum = datum->next;
+	} while (datum);
+
+	buf[0] = cpu_to_le32(ft->ttype);
+	buf[1] = cpu_to_le32(ft->tclass);
+	buf[2] = cpu_to_le32(ndatum);
+	items = put_entry(buf, sizeof(uint32_t), 3, fp);
+	if (items != 3)
+		return POLICYDB_ERROR;
+
+	datum = data;
+	do {
+		if (ebitmap_write(&datum->stypes, fp))
+			return POLICYDB_ERROR;
+
+		buf[0] = cpu_to_le32(datum->otype);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
+
+		datum = datum->next;
+	} while (datum);
+
+	return 0;
+}
+
 static int filename_trans_write(struct policydb *p, void *fp)
 {
 	size_t items;
@@ -614,16 +662,23 @@ static int filename_trans_write(struct policydb *p, void *fp)
 	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
 		return 0;
 
-	buf[0] = cpu_to_le32(p->filename_trans_count);
-	items = put_entry(buf, sizeof(uint32_t), 1, fp);
-	if (items != 1)
-		return POLICYDB_ERROR;
+	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+		buf[0] = cpu_to_le32(p->filename_trans_count);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
 
-	rc = hashtab_map(p->filename_trans, filename_write_helper, fp);
-	if (rc)
-		return rc;
+		rc = hashtab_map(p->filename_trans, filename_write_one_compat,
+				 fp);
+	} else {
+		buf[0] = cpu_to_le32(p->filename_trans->nel);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
 
-	return 0;
+		rc = hashtab_map(p->filename_trans, filename_write_one, fp);
+	}
+	return rc;
 }
 
 static int role_set_write(role_set_t * x, struct policy_file *fp)
-- 
2.26.2

