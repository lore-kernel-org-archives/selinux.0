Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C39C352A3
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 16:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E0E20714
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 16:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sm1qxlOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbgBKQkE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:40:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58091 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728049AbgBKQkD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 11:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581439201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0N3pE6LzBiwArVG+HIPyyf3WUV03RR96TqlScRyuW9w=;
        b=Sm1qxlOU2nC4KW71/1XLx1t66e6A0OYo9eNomQ87yPYyfGf3WhJkw9JL9BQY5MrTNxBSSA
        IPQvYnQbXVDB7OMJunb+abr/1FnHIQIHxhgpBr6d20N//nfoJGGsEch4+Kir6Wltdp4Cpv
        QRoeFQ+JEOHbETik0qelMOIi9BRbscU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-aJONQ0hKPCGK6lQS-FwMZg-1; Tue, 11 Feb 2020 11:39:58 -0500
X-MC-Unique: aJONQ0hKPCGK6lQS-FwMZg-1
Received: by mail-wm1-f72.google.com with SMTP id 7so1673782wmf.9
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 08:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0N3pE6LzBiwArVG+HIPyyf3WUV03RR96TqlScRyuW9w=;
        b=PrRU7WLf4lYAUS38mIMYMcrKHFYS9mF16C9/UCjqEuuKsjygb7/nuv2kU4bdcNKLGA
         eGSmcdW002IkQcjibQ7SFllUU6PArCJoEImrnMJHXOGDfijoEtkYDTboRb/XRS0XDnlw
         Q/L7ySUrjQrYuRImWvRjlRcadaTZXHa3YgYFowDJ2/nPfpq0n1fwL9cpaMZr5GXHKIeb
         vJc05FOOieExcK4qvXeBTBuYoK9YzK6g9N8ibhc4GnGrilQLr5TMIm5sFE9tR6hCuc0x
         TgRotAXWYlgaZ/zXn/+vPYmDIDt04KCqNrMlJHSymqaBkuU8qetRzttQ1sqrufRZFsRn
         v/hw==
X-Gm-Message-State: APjAAAURn+Cxjvqu0RHfLWTT+Rq6mq1W9T4nuA6fvgHzQYb0TnT8tYIG
        KSbkImGDsOi/qKERC6RDQauLEzFn0OP1fPHPgWw7sg/R0w1Of1tXoSG69Zo0p0e11T2oQUpSCIS
        UpgWQcsnwQe1tF3XT3Q==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr6363238wmc.36.1581439196763;
        Tue, 11 Feb 2020 08:39:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQEgXkHeXnwCiB12sDO7b3Q/ouCOH8BP5l4ZWQ2L+Ps0zbc41fEwfxmrL+qs4wCHgh9bG10g==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr6363219wmc.36.1581439196522;
        Tue, 11 Feb 2020 08:39:56 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k10sm5831076wrd.68.2020.02.11.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 08:39:56 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/2] selinux: factor out loop body from filename_trans_read()
Date:   Tue, 11 Feb 2020 17:39:52 +0100
Message-Id: <20200211163953.12231-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200211163953.12231-1-omosnace@redhat.com>
References: <20200211163953.12231-1-omosnace@redhat.com>
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

