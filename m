Return-Path: <SRS0=745E=5M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D86C43331
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 15:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430862072F
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 15:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaZe6glp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC0PVQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:21:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57380 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbgC0PVQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Mar 2020 11:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1blPuC8cDlTH93Jr9nXfNpES5GP+LPNmplVpsvC4b0=;
        b=PaZe6glpH01Qn/p5AvSlDeuP/79x1IMePeymFOyI/iGmDrSFyPJpsD7gqBcNE6VdqWSoJX
        s/PScBULa8oAbcVKEXs1X10RIs6LqEiAj23KgkqoWVIV7xouAQull6l/x4WCuA77qp6IX7
        Szi02bdT37AyuRWwsm5jyC+G1UnBS9E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-AIWEi6QjNEu2IvssMQigqA-1; Fri, 27 Mar 2020 11:21:13 -0400
X-MC-Unique: AIWEi6QjNEu2IvssMQigqA-1
Received: by mail-wm1-f71.google.com with SMTP id m4so5696494wme.0
        for <selinux@vger.kernel.org>; Fri, 27 Mar 2020 08:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r1blPuC8cDlTH93Jr9nXfNpES5GP+LPNmplVpsvC4b0=;
        b=LvztGIoqvESdstnlamplrtMF1fCPIYXjrEgKqliiIVUaR6wAgxexOOytWjdVGpqj5q
         QL9v7IUeWUkWSJ10L8jiOBHzSwKmI9VdC+UUQQh+uEpcqv4YhcMhYUvyduOxi6LVELJ8
         +yoNBA4RjQJWCEovSg+PWAdu3mkZ62RuWTeUdwQTQsxoz80qqYciu3b5hkkcdDJtydNT
         HUmi11b9U1Up4/QN7xaptLL+VYmP/y4OTpAB9epEDANU88pPZYIICMdsvUCM4ENcZXv+
         Ww4bOwcO5fBLOcotxMryoIzj+USXnZQaQMuI1M81d6ohYCaMpBk8XXLTqVgJ7sM8BgHH
         3S1Q==
X-Gm-Message-State: ANhLgQ0d1d60ojNdBndU3jFtMGcAseQBs4GNSMMKZMfVNgGQfoCmUHzo
        byDCChm6dqYVd/+ZOSF3fh30j0uYk4cLXf6kbnw7Qit7ekLgZsK/DkNpyO9m+r7n2vdJNnGfzZU
        Fpa9w4uQ3BxfVrcHfew==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr16751021wrs.39.1585322472031;
        Fri, 27 Mar 2020 08:21:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuP6fTxd3RzonNjXqG+toYGwICJs5jJo9MFRZr+5dpdF3X5uCBRQp/+bH3EarlptBFKrqvW3w==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr16750984wrs.39.1585322471673;
        Fri, 27 Mar 2020 08:21:11 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id t21sm8284746wmt.43.2020.03.27.08.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:21:11 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Chris PeBenito <pebenito@ieee.org>
Subject: [PATCH 2/2] libsepol: implement POLICYDB_VERSION_COMP_FTRANS
Date:   Fri, 27 Mar 2020 16:21:07 +0100
Message-Id: <20200327152107.95915-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327152107.95915-1-omosnace@redhat.com>
References: <20200327152107.95915-1-omosnace@redhat.com>
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
 libsepol/src/policydb.c                    | 217 +++++++++++++++++----
 libsepol/src/write.c                       |  72 ++++++-
 3 files changed, 241 insertions(+), 51 deletions(-)

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
index 6b121d66..f108e4af 100644
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
@@ -2661,73 +2668,201 @@ int policydb_filetrans_insert(policydb_t *p, uint32_t stype, uint32_t ttype,
 	return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
 }
 
-int filename_trans_read(policydb_t *p, struct policy_file *fp)
+static int filename_trans_read_one_old(policydb_t *p, struct policy_file *fp)
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
+		WARN(fp->handle,
+		     "Duplicate name-based type_transition %s %s:%s \"%s\":  %s, ignoring",
+		     p->p_type_val_to_name[stype - 1],
+		     p->p_type_val_to_name[ttype - 1],
+		     p->p_class_val_to_name[tclass - 1],
+		     name,
+		     p->p_type_val_to_name[otype - 1]);
+		/* continue, ignoring this one */
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
+static int filename_trans_read_one_new(policydb_t *p, struct policy_file *fp)
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
-			 * issue a warning and ignore the duplicate.
-			 */
-			WARN(fp->handle,
-			     "Duplicate name-based type_transition %s %s:%s \"%s\":  %s, ignoring",
-			     p->p_type_val_to_name[stype - 1],
-			     p->p_type_val_to_name[ttype - 1],
-			     p->p_class_val_to_name[tclass - 1],
-			     name,
-			     p->p_type_val_to_name[otype - 1]);
-			/* continue, ignoring this one */
-		}
-		free(name);
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
+	p->filename_trans_count++;
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
+			rc = filename_trans_read_one_old(p, fp);
+			if (rc < 0)
+				return -1;
+		}
+	} else {
+		for (i = 0; i < nel; i++) {
+			rc = filename_trans_read_one_new(p, fp);
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
index d3aee8d5..9c74d9f5 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -569,7 +569,7 @@ static int role_allow_write(role_allow_t * r, struct policy_file *fp)
 	return POLICYDB_SUCCESS;
 }
 
-static int filename_write_helper(hashtab_key_t key, void *data, void *ptr)
+static int filename_write_one_old(hashtab_key_t key, void *data, void *ptr)
 {
 	uint32_t bit, buf[4];
 	size_t items, len;
@@ -605,6 +605,54 @@ static int filename_write_helper(hashtab_key_t key, void *data, void *ptr)
 	return 0;
 }
 
+static int filename_write_one_new(hashtab_key_t key, void *data, void *ptr)
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
@@ -614,16 +662,22 @@ static int filename_trans_write(struct policydb *p, void *fp)
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
+		rc = hashtab_map(p->filename_trans, filename_write_one_old, fp);
+	} else {
+		buf[0] = cpu_to_le32(p->filename_trans->nel);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return POLICYDB_ERROR;
 
-	return 0;
+		rc = hashtab_map(p->filename_trans, filename_write_one_new, fp);
+	}
+	return rc;
 }
 
 static int role_set_write(role_set_t * x, struct policy_file *fp)
-- 
2.25.1

