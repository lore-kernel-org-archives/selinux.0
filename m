Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3D1C2BA83
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 11:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04189206D7
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 11:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0uv0u22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgBLLXE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:23:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43592 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727987AbgBLLXE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 06:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581506583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0N3pE6LzBiwArVG+HIPyyf3WUV03RR96TqlScRyuW9w=;
        b=h0uv0u22cTyIciAWa+xR2Wp3nw/laB1/VciWqhdqjQUD8sa+RD8bUfoJJ+xVCToFfmM7lw
        UeJVJdV9arqNOYxUb/BgO1d/2YayLz5CSn+HPGC575RalhvMDyirqKuedlzpFnMtEOHdRj
        B7xnAx8FeLQX/NEYS6eMkD8HaVw4kbE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-9-PjeAnlM-K6dfq0AgD1Tg-1; Wed, 12 Feb 2020 06:23:01 -0500
X-MC-Unique: 9-PjeAnlM-K6dfq0AgD1Tg-1
Received: by mail-wr1-f69.google.com with SMTP id s13so673227wrb.21
        for <selinux@vger.kernel.org>; Wed, 12 Feb 2020 03:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0N3pE6LzBiwArVG+HIPyyf3WUV03RR96TqlScRyuW9w=;
        b=L2oTskuOyYM4KnXsMO5t3fTP/yW1zEMrIT5c/barPWMJZWKsmfjz4ejqF2vSM4eXTr
         VR8WzGAZWvEn3k7Z7NsT3i847Gmm5BZ06GLIA2Qi8SOEX1aq6p/xlHnHH6ZjxiCPyLBQ
         P/FT1OUiXR/r/Jeu2m+shWwhzjhJSad3ffUZhPJTRR2wOwiOYaECWOZE0uv1q5rsQ40I
         tVzBReK02TztaphS/5PIHX67WXwCuhELtKPeEOoIrgsN0ORfTOq0XzkWo8RcmW0nQSSU
         pXS2nwXoMHlCphOgJaFdAYEcLH5qBwUPILmF/My+HuAQeNn7uHeFgM71qRTmXjlNMKxg
         gCTw==
X-Gm-Message-State: APjAAAX6YoGUVcvN8L4GZ3sE91SR9HkXlB1DhHtFeuBExJp39G6kTieN
        7cQxjfwC8/w8dJmjwkd0gNBHssQEmW/t3Y84sfWJxjTqT0MDVEzBFiK4tUSguDJFO+OZ9+iNjAl
        0NAR+zGSw0UGXF6UNKQ==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr14523980wrp.355.1581506579857;
        Wed, 12 Feb 2020 03:22:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwVAkT37A8sv6KBc3YfKXxulDbyfmd578xEly40dkWkCHyEb5owh8An4lNdiofiAjHSr3zzw==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr14523945wrp.355.1581506579525;
        Wed, 12 Feb 2020 03:22:59 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c9sm282160wmc.47.2020.02.12.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 03:22:58 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2 1/2] selinux: factor out loop body from filename_trans_read()
Date:   Wed, 12 Feb 2020 12:22:54 +0100
Message-Id: <20200212112255.105678-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212112255.105678-1-omosnace@redhat.com>
References: <20200212112255.105678-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It simplifies cleanup in the error path. This will be extra useful in
later patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 122 +++++++++++++++++----------------
 1 file changed, 63 insertions(+), 59 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 2aa7f2e1a8e7..981797bfc547 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1880,88 +1880,92 @@ out:
 	return rc;
 }
 
-static int filename_trans_read(struct policydb *p, void *fp)
+static int filename_trans_read_one(struct policydb *p, void *fp)
 {
 	struct filename_trans *ft;
-	struct filename_trans_datum *otype;
-	char *name;
-	u32 nel, len;
+	struct filename_trans_datum *otype = NULL;
+	char *name = NULL;
+	u32 len;
 	__le32 buf[4];
-	int rc, i;
+	int rc;
 
-	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
-		return 0;
+	ft = kzalloc(sizeof(*ft), GFP_KERNEL);
+	if (!ft)
+		return -ENOMEM;
+
+	rc = -ENOMEM;
+	otype = kmalloc(sizeof(*otype), GFP_KERNEL);
+	if (!otype)
+		goto out;
 
+	/* length of the path component string */
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc)
-		return rc;
-	nel = le32_to_cpu(buf[0]);
-
-	for (i = 0; i < nel; i++) {
-		otype = NULL;
-		name = NULL;
-
-		rc = -ENOMEM;
-		ft = kzalloc(sizeof(*ft), GFP_KERNEL);
-		if (!ft)
-			goto out;
-
-		rc = -ENOMEM;
-		otype = kmalloc(sizeof(*otype), GFP_KERNEL);
-		if (!otype)
-			goto out;
-
-		/* length of the path component string */
-		rc = next_entry(buf, fp, sizeof(u32));
-		if (rc)
-			goto out;
-		len = le32_to_cpu(buf[0]);
+		goto out;
+	len = le32_to_cpu(buf[0]);
 
-		/* path component string */
-		rc = str_read(&name, GFP_KERNEL, fp, len);
-		if (rc)
-			goto out;
+	/* path component string */
+	rc = str_read(&name, GFP_KERNEL, fp, len);
+	if (rc)
+		goto out;
 
-		ft->name = name;
+	ft->name = name;
 
-		rc = next_entry(buf, fp, sizeof(u32) * 4);
-		if (rc)
-			goto out;
+	rc = next_entry(buf, fp, sizeof(u32) * 4);
+	if (rc)
+		goto out;
 
-		ft->stype = le32_to_cpu(buf[0]);
-		ft->ttype = le32_to_cpu(buf[1]);
-		ft->tclass = le32_to_cpu(buf[2]);
+	ft->stype = le32_to_cpu(buf[0]);
+	ft->ttype = le32_to_cpu(buf[1]);
+	ft->tclass = le32_to_cpu(buf[2]);
 
-		otype->otype = le32_to_cpu(buf[3]);
+	otype->otype = le32_to_cpu(buf[3]);
 
-		rc = ebitmap_set_bit(&p->filename_trans_ttypes, ft->ttype, 1);
-		if (rc)
-			goto out;
+	rc = ebitmap_set_bit(&p->filename_trans_ttypes, ft->ttype, 1);
+	if (rc)
+		goto out;
 
-		rc = hashtab_insert(p->filename_trans, ft, otype);
-		if (rc) {
-			/*
-			 * Do not return -EEXIST to the caller, or the system
-			 * will not boot.
-			 */
-			if (rc != -EEXIST)
-				goto out;
-			/* But free memory to avoid memory leak. */
-			kfree(ft);
-			kfree(name);
-			kfree(otype);
-		}
+	rc = hashtab_insert(p->filename_trans, ft, otype);
+	if (rc) {
+		/*
+		 * Do not return -EEXIST to the caller, or the system
+		 * will not boot.
+		 */
+		if (rc == -EEXIST)
+			rc = 0;
+		goto out;
 	}
-	hash_eval(p->filename_trans, "filenametr");
 	return 0;
 out:
 	kfree(ft);
 	kfree(name);
 	kfree(otype);
-
 	return rc;
 }
 
+static int filename_trans_read(struct policydb *p, void *fp)
+{
+	u32 nel;
+	__le32 buf[1];
+	int rc, i;
+
+	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
+		return 0;
+
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc)
+		return rc;
+	nel = le32_to_cpu(buf[0]);
+
+	for (i = 0; i < nel; i++) {
+		rc = filename_trans_read_one(p, fp);
+		if (rc)
+			return rc;
+	}
+	hash_eval(p->filename_trans, "filenametr");
+	return 0;
+}
+
 static int genfs_read(struct policydb *p, void *fp)
 {
 	int i, j, rc;
-- 
2.24.1

