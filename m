Return-Path: <SRS0=dl6L=A4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E9EC433DF
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 11:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC2E20768
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 11:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MM4RIXgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgGQLsP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:48:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21996 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgGQLsO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jul 2020 07:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594986492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zwfcwDp/reOTKziGyU5Ea7ty4EeMX1oommsRqtNmyeU=;
        b=MM4RIXgw1YxlWCOixMeTEKsri1ig/aS1d3S9ai/NsC4WJVKvh1Dky3rFC7erg6Q/eDMqWk
        9LbpDvrKtUgsfgpWItOYwiWSepcpBI3+Cpg2BRRWRc/pnm6Kpc0bg5oDItEyoPZpTRAMmc
        ExOZV5Fr0p2oEs1N63kMYUX3VD73lSo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-FaRtsDZoMWazodYttbRH-w-1; Fri, 17 Jul 2020 07:48:10 -0400
X-MC-Unique: FaRtsDZoMWazodYttbRH-w-1
Received: by mail-ed1-f70.google.com with SMTP id d3so5603585edq.14
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2020 04:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwfcwDp/reOTKziGyU5Ea7ty4EeMX1oommsRqtNmyeU=;
        b=D7yTWPQbgrRRivkzapbyo7rnGzvFyHE8K69yeX6AXyVnludSt81b3ej0OVoPT9KbH8
         lwqA1gScc3fkRiJy8wyfL/H9r3sF0nWxLgHDFO0oFykdOyql2p4rMET6lcSfI9vOgH64
         5TvDb1hS3OGx2BNGZ0TlGpG4OZdrHUjtR92WSk3j/nTqPBpcyi3ZdsJpv1BxMXh10kSP
         Q0oAYuqqAlSoT3S+59KTj6Qd3SerqC4MAEwObTlB3HX8q265tVt0LnFFeb5+gn+J28x5
         91/J5TNdJzZXtATXHX+35uzQDDS6Ua+D5UCKCfzRFvXrM2JyJXg066vdQ9H5Sh5o0jqg
         dopg==
X-Gm-Message-State: AOAM5331zUeK2pBCi/Mi6T5hM3a5E8tjpaKDnKyUMz7aGImyPnwRg3EX
        06N9a388/FXGk5fmVufGxsT1sy0aQOEXj6d9DbyeZim7b6Pj+oKkBAoDfIQKyr5Hqv0gPUs/uRd
        h6BUs7Cvea91abhXidA==
X-Received: by 2002:a05:6402:16c7:: with SMTP id r7mr8976117edx.288.1594986488598;
        Fri, 17 Jul 2020 04:48:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQQ/5ol4fZKXFQSSd8LeCTH9mkCZzcFPDH2+YclfFdSMqvSqglZw/MuYXwq3gTDs0VfO2kXQ==
X-Received: by 2002:a05:6402:16c7:: with SMTP id r7mr8976094edx.288.1594986488205;
        Fri, 17 Jul 2020 04:48:08 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:8a6a:ec88:3ed7:44b3])
        by smtp.gmail.com with ESMTPSA id x11sm7800957ejv.81.2020.07.17.04.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 04:48:07 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v4 2/2] libsepol: implement POLICYDB_VERSION_COMP_FTRANS
Date:   Fri, 17 Jul 2020 13:48:04 +0200
Message-Id: <20200717114804.762125-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717114804.762125-1-omosnace@redhat.com>
References: <20200717114804.762125-1-omosnace@redhat.com>
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
 libsepol/src/policydb.c                    | 202 +++++++++++++++++----
 libsepol/src/write.c                       |  73 +++++++-
 3 files changed, 235 insertions(+), 43 deletions(-)

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
index e9409a41..659f4308 100644
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
@@ -2661,65 +2668,194 @@ int policydb_filetrans_insert(policydb_t *p, uint32_t stype, uint32_t ttype,
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
+		 * issue a warning and ignore the duplicate.
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
+
+	ebitmap_init(&stypes);
+	ebitmap_init(&otypes);
+
+	while (datum) {
+		if (ebitmap_get_bit(&otypes, datum->otype))
+			return -1;
+
+		if (ebitmap_set_bit(&otypes, datum->otype, 1))
+			return -1;
 
-		name = calloc(len + 1, sizeof(*name));
-		if (!name)
+		if (ebitmap_match_any(&stypes, &datum->stypes))
+			return -1;
+
+		if (ebitmap_union(&stypes, &datum->stypes))
+			return -1;
+	}
+	return 0;
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

