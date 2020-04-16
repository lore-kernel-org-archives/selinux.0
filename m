Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334AAC2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072D5221EB
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 17:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5mas0XO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgDPROG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:14:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24104 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727795AbgDPROF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 13:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587057242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U6cooELyDT4EjFhJ0HjJ7fA958SH/FZrVI/yUqsLiho=;
        b=J5mas0XOYQC7z2OivUa2NjxtekM6HfKbRqpUOs+s+VrzZ8htTnHe/uGs/BBCeX8l5Ph9Bf
        uh3n3oS9VB5HbOQbANnAvE4A5fb7SQ9YjwxlWtmjznh9Bbsw+zykO6UX9DUUyuPeWrMU3B
        /v/OiNZXVH081Xd3J+5ZWOW++7PT6uU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-ySc_SQHwO3Wtk8z0uq8zIA-1; Thu, 16 Apr 2020 13:14:00 -0400
X-MC-Unique: ySc_SQHwO3Wtk8z0uq8zIA-1
Received: by mail-wm1-f71.google.com with SMTP id c129so1453282wme.8
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 10:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U6cooELyDT4EjFhJ0HjJ7fA958SH/FZrVI/yUqsLiho=;
        b=W6HEZuVAVJm6UUoB7Jehit7bnWklML7AyS+4ME33w6FFRe6rvKOJkwmc2BnptCxYyz
         3m7kCvSgtcBa0UA0OOgyXD5jkDFgvkbYdcONmLEFkp0U+d5Ekc4dCcpdAbhAQioI1V7d
         bQdPZDnQT7NOz3qvPHR6a1eoVQBmx1BdGRY4IB+UuHCUFGyXSADFMMRDj7eaIkidZEDQ
         xc3MlZUQbk6D93ayAEnurc5dTkRw+Ejng2JYZVjdaY5OuhxEjVqNYlxOjUGBwB5WJBRp
         U7Vzyt3UfUX7Ja4JeBvB6FheuVVHeiMO/psjmb1aS3ImhLIW8a4uX/xi4g7TWyZVbVy9
         iMGA==
X-Gm-Message-State: AGi0PuZZqpMrB3dVyYv9MpRb+s0qfByBEbKPmp8qDMErkSgGleWWh0y/
        Qpxntd4JsRyAV5RGzYPEQFASmjOm227n94JYn4wzyV0VwFRsu75kbtIleSOOO54YWxEQ/c4lJQR
        H8JxGNBipsqZEqS/w9Q==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr20348521wrx.345.1587057238682;
        Thu, 16 Apr 2020 10:13:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypJerB7JOkTCkFnnkBeOQ/NzcLAKgfv8FxJqmRgcpAum4i+o/9vx5S2GkY4qBpxP2NALTGYT+g==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr20348495wrx.345.1587057238394;
        Thu, 16 Apr 2020 10:13:58 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id o18sm2030976wrp.23.2020.04.16.10.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:13:57 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] selinux: implement new format of filename transitions
Date:   Thu, 16 Apr 2020 19:13:55 +0200
Message-Id: <20200416171355.560244-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Implement a new, more space-efficient way of storing filename
transitions in the binary policy. The internal structures have already
been converted to this new representation; this patch just implements
reading/writing an equivalent represntation from/to the binary policy.

This new format reduces the size of Fedora policy from 7.6 MB to only
3.3 MB (with policy optimization enabled in both cases). With the
unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.

The time to load policy into kernel is also shorter with the new format.
On Fedora Rawhide x86_64 it dropped from 157 ms to 106 ms; without the
unconfined module from 115 ms to 105 ms.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Changes in v2:
 - rename the read/write helpers
 - move update of filename_trans_ttypes in filename_trans_read_helper()
   to later in the function
 - make filename_trans_read_helper() count filename_trans_count
   correctly

 security/selinux/include/security.h |   3 +-
 security/selinux/ss/policydb.c      | 212 ++++++++++++++++++++++++----
 2 files changed, 189 insertions(+), 26 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index d6036c018cf2..b0e02cfe3ce1 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -41,10 +41,11 @@
 #define POLICYDB_VERSION_XPERMS_IOCTL	30
 #define POLICYDB_VERSION_INFINIBAND		31
 #define POLICYDB_VERSION_GLBLUB		32
+#define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitions */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_GLBLUB
+#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_COMP_FTRANS
 
 /* Mask for just the mount related flags */
 #define SE_MNTMASK	0x0f
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 70ecdc78efbd..9db4f0ef0f70 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -154,6 +154,11 @@ static struct policydb_compat_info policydb_compat[] = {
 		.sym_num	= SYM_NUM,
 		.ocon_num	= OCON_NUM,
 	},
+	{
+		.version	= POLICYDB_VERSION_COMP_FTRANS,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
+	},
 };
 
 static struct policydb_compat_info *policydb_lookup_compat(int version)
@@ -461,23 +466,16 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
 /*
  * Initialize a policy database structure.
  */
-static int policydb_init(struct policydb *p)
+static void policydb_init(struct policydb *p)
 {
 	memset(p, 0, sizeof(*p));
 
 	avtab_init(&p->te_avtab);
 	cond_policydb_init(p);
 
-	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
-					   (1 << 11));
-	if (!p->filename_trans)
-		return -ENOMEM;
-
 	ebitmap_init(&p->filename_trans_ttypes);
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
-
-	return 0;
 }
 
 /*
@@ -1841,7 +1839,7 @@ out:
 	return rc;
 }
 
-static int filename_trans_read_one(struct policydb *p, void *fp)
+static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
 {
 	struct filename_trans_key key, *ft = NULL;
 	struct filename_trans_datum *last, *datum = NULL;
@@ -1924,6 +1922,99 @@ out:
 	return rc;
 }
 
+static int filename_trans_read_helper(struct policydb *p, void *fp)
+{
+	struct filename_trans_key *ft = NULL;
+	struct filename_trans_datum **dst, *datum, *first = NULL;
+	char *name = NULL;
+	u32 len, ttype, tclass, ndatum, i;
+	__le32 buf[3];
+	int rc;
+
+	/* length of the path component string */
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc)
+		return rc;
+	len = le32_to_cpu(buf[0]);
+
+	/* path component string */
+	rc = str_read(&name, GFP_KERNEL, fp, len);
+	if (rc)
+		return rc;
+
+	rc = next_entry(buf, fp, sizeof(u32) * 3);
+	if (rc)
+		goto out;
+
+	ttype = le32_to_cpu(buf[0]);
+	tclass = le32_to_cpu(buf[1]);
+
+	ndatum = le32_to_cpu(buf[2]);
+	if (ndatum == 0) {
+		pr_err("SELinux:  Filename transition key with no datum\n");
+		rc = -ENOENT;
+		goto out;
+	}
+
+	dst = &first;
+	for (i = 0; i < ndatum; i++) {
+		rc = -ENOMEM;
+		datum = kmalloc(sizeof(*datum), GFP_KERNEL);
+		if (!datum)
+			goto out;
+
+		*dst = datum;
+
+		/* ebitmap_read() will at least init the bitmap */
+		rc = ebitmap_read(&datum->stypes, fp);
+		if (rc)
+			goto out;
+
+		rc = next_entry(buf, fp, sizeof(u32));
+		if (rc)
+			goto out;
+
+		datum->otype = le32_to_cpu(buf[0]);
+		datum->next = NULL;
+
+		dst = &datum->next;
+	}
+
+	rc = -ENOMEM;
+	ft = kmalloc(sizeof(*ft), GFP_KERNEL);
+	if (!ft)
+		goto out;
+
+	ft->ttype = ttype;
+	ft->tclass = tclass;
+	ft->name = name;
+
+	rc = hashtab_insert(p->filename_trans, ft, first);
+	if (rc == -EEXIST)
+		pr_err("SELinux:  Duplicate filename transition key\n");
+	if (rc)
+		goto out;
+
+	rc = ebitmap_set_bit(&p->filename_trans_ttypes, ttype, 1);
+	if (rc)
+		return rc;
+
+	p->filename_trans_count += ndatum;
+	return 0;
+
+out:
+	kfree(ft);
+	kfree(name);
+	while (first) {
+		datum = first;
+		first = first->next;
+
+		ebitmap_destroy(&datum->stypes);
+		kfree(datum);
+	}
+	return rc;
+}
+
 static int filename_trans_read(struct policydb *p, void *fp)
 {
 	u32 nel;
@@ -1938,12 +2029,29 @@ static int filename_trans_read(struct policydb *p, void *fp)
 		return rc;
 	nel = le32_to_cpu(buf[0]);
 
-	p->filename_trans_count = nel;
+	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+		p->filename_trans_count = nel;
+		p->filename_trans = hashtab_create(filenametr_hash,
+						   filenametr_cmp, (1 << 11));
+		if (!p->filename_trans)
+			return -ENOMEM;
 
-	for (i = 0; i < nel; i++) {
-		rc = filename_trans_read_one(p, fp);
-		if (rc)
-			return rc;
+		for (i = 0; i < nel; i++) {
+			rc = filename_trans_read_helper_compat(p, fp);
+			if (rc)
+				return rc;
+		}
+	} else {
+		p->filename_trans = hashtab_create(filenametr_hash,
+						   filenametr_cmp, nel);
+		if (!p->filename_trans)
+			return -ENOMEM;
+
+		for (i = 0; i < nel; i++) {
+			rc = filename_trans_read_helper(p, fp);
+			if (rc)
+				return rc;
+		}
 	}
 	hash_eval(p->filename_trans, "filenametr");
 	return 0;
@@ -2259,9 +2367,7 @@ int policydb_read(struct policydb *p, void *fp)
 	char *policydb_str;
 	struct policydb_compat_info *info;
 
-	rc = policydb_init(p);
-	if (rc)
-		return rc;
+	policydb_init(p);
 
 	/* Read the magic number and string length. */
 	rc = next_entry(buf, fp, sizeof(u32) * 2);
@@ -3326,7 +3432,7 @@ static int range_write(struct policydb *p, void *fp)
 	return 0;
 }
 
-static int filename_write_helper(void *key, void *data, void *ptr)
+static int filename_write_helper_compat(void *key, void *data, void *ptr)
 {
 	struct filename_trans_key *ft = key;
 	struct filename_trans_datum *datum = data;
@@ -3363,26 +3469,82 @@ static int filename_write_helper(void *key, void *data, void *ptr)
 	return 0;
 }
 
-static int filename_trans_write(struct policydb *p, void *fp)
+static int filename_write_helper(void *key, void *data, void *ptr)
 {
-	__le32 buf[1];
+	struct filename_trans_key *ft = key;
+	struct filename_trans_datum *datum;
+	void *fp = ptr;
+	__le32 buf[3];
 	int rc;
+	u32 ndatum, len = strlen(ft->name);
 
-	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
-		return 0;
-
-	buf[0] = cpu_to_le32(p->filename_trans_count);
+	buf[0] = cpu_to_le32(len);
 	rc = put_entry(buf, sizeof(u32), 1, fp);
 	if (rc)
 		return rc;
 
-	rc = hashtab_map(p->filename_trans, filename_write_helper, fp);
+	rc = put_entry(ft->name, sizeof(char), len, fp);
 	if (rc)
 		return rc;
 
+	ndatum = 0;
+	datum = data;
+	do {
+		ndatum++;
+		datum = datum->next;
+	} while (unlikely(datum));
+
+	buf[0] = cpu_to_le32(ft->ttype);
+	buf[1] = cpu_to_le32(ft->tclass);
+	buf[2] = cpu_to_le32(ndatum);
+	rc = put_entry(buf, sizeof(u32), 3, fp);
+	if (rc)
+		return rc;
+
+	datum = data;
+	do {
+		rc = ebitmap_write(&datum->stypes, fp);
+		if (rc)
+			return rc;
+
+		buf[0] = cpu_to_le32(datum->otype);
+		rc = put_entry(buf, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+
+		datum = datum->next;
+	} while (unlikely(datum));
+
 	return 0;
 }
 
+static int filename_trans_write(struct policydb *p, void *fp)
+{
+	__le32 buf[1];
+	int rc;
+
+	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
+		return 0;
+
+	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+		buf[0] = cpu_to_le32(p->filename_trans_count);
+		rc = put_entry(buf, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+
+		rc = hashtab_map(p->filename_trans,
+				 filename_write_helper_compat, fp);
+	} else {
+		buf[0] = cpu_to_le32(p->filename_trans->nel);
+		rc = put_entry(buf, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+
+		rc = hashtab_map(p->filename_trans, filename_write_helper, fp);
+	}
+	return rc;
+}
+
 /*
  * Write the configuration data in a policy database
  * structure to a policy database binary representation
-- 
2.25.2

