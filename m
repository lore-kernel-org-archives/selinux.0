Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAB6C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 07:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D06120639
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 07:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6Si54+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgHYHAm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:00:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47369 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729268AbgHYHA1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 03:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598338804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjYfETYgavsV8Y7+RSnL/aX7yPOhdabiGgvItnkFZqw=;
        b=F6Si54+OylKIDzzCwaAyfVr25LVnPsySGXTj7ZvznDYocXvT/5DtrmyjD7eFebPWooUsUF
        63N+newkMBms9nRbnwwGRqzhwApMZhr9qjcs80E/ruDc+hua7V0M/U4gDxVQtUjclL4D14
        iEHW5TGX61uDtQwQSZljOrtyFoUVB2A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-P6OwovvMNWyOsC1cYAlrVw-1; Tue, 25 Aug 2020 02:59:59 -0400
X-MC-Unique: P6OwovvMNWyOsC1cYAlrVw-1
Received: by mail-wm1-f71.google.com with SMTP id u144so379459wmu.3
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 23:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjYfETYgavsV8Y7+RSnL/aX7yPOhdabiGgvItnkFZqw=;
        b=o2eWudKAnXlZoPnldfSW1SDb2wG7j8VZJXccaI7f5Vb1t6kUBvbSvKwYZdsokLcEdc
         5BmiIjVSr8BV9coGlnjlvt2zlhaXB1+E1wOGiBmdrTKloeaTDvwspYWraBmFKwCN0i6i
         rd9mtuHEZuxahVOoONXiGg1VgeQTCKz79FVX6nKLiqPYsXppOhAXSjWuy9+MX0s8wbd5
         /5i29qIoVUPSJLQUNiz7sn4oDXzL3k+E/RCvOylEAd5wVDlxuVGYr89WeUsw3uCRDu64
         yD0DSj9C3YdFfxJRWSrVWlcyQbo68EjQQ4/YojjPipUy6defOgk0RmFzrKUqg28VZ8W8
         +wRQ==
X-Gm-Message-State: AOAM5308FO6aLpzIayxm1f8iWnhjVO4hjf0xwIFMni7/cbD1ENhK9E+o
        PxEnDpMGOdfgJ1HYeQxzelmrBo5BzsRv/cxMedyX/9vJi4omwAQwUHOBFrTtYXAjv39dvtjroY6
        367LisT3fAJcj4fObhg==
X-Received: by 2002:adf:8445:: with SMTP id 63mr8860029wrf.375.1598338798174;
        Mon, 24 Aug 2020 23:59:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2o2insVlDEjabgGzeEz77p/VPnnoFDuJ6+Sj0cKaDN9DaWdnHRidyl6uVR+CKU8uR9+KJ5w==
X-Received: by 2002:adf:8445:: with SMTP id 63mr8860012wrf.375.1598338797932;
        Mon, 24 Aug 2020 23:59:57 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id h6sm28714644wrv.40.2020.08.24.23.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 23:59:56 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/2] selinux: drop the gfp_t argument from str_read()
Date:   Tue, 25 Aug 2020 08:59:53 +0200
Message-Id: <20200825065953.1566718-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825065953.1566718-1-omosnace@redhat.com>
References: <20200825065953.1566718-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Now that all callers specify GFP_KERNEL here, the argument is no longer
necessary and the function can just use GFP_KERNEL directly.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 36 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index c1437de04e1d9..a7b6b2f5d71d9 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1074,7 +1074,7 @@ out:
  * binary representation file.
  */
 
-static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
+static int str_read(char **strp, void *fp, u32 len)
 {
 	int rc;
 	char *str;
@@ -1082,7 +1082,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
 	if ((len == 0) || (len == (u32)-1))
 		return -EINVAL;
 
-	str = kmalloc(len + 1, flags | __GFP_NOWARN);
+	str = kmalloc(len + 1, GFP_KERNEL | __GFP_NOWARN);
 	if (!str)
 		return -ENOMEM;
 
@@ -1116,7 +1116,7 @@ static int perm_read(struct policydb *p, struct symtab *s, void *fp)
 	len = le32_to_cpu(buf[0]);
 	perdatum->value = le32_to_cpu(buf[1]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1155,7 +1155,7 @@ static int common_read(struct policydb *p, struct symtab *s, void *fp)
 		goto bad;
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1322,12 +1322,12 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 
 	ncons = le32_to_cpu(buf[5]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, fp, len);
 	if (rc)
 		goto bad;
 
 	if (len2) {
-		rc = str_read(&cladatum->comkey, GFP_KERNEL, fp, len2);
+		rc = str_read(&cladatum->comkey, fp, len2);
 		if (rc)
 			goto bad;
 
@@ -1413,7 +1413,7 @@ static int role_read(struct policydb *p, struct symtab *s, void *fp)
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		role->bounds = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1479,7 +1479,7 @@ static int type_read(struct policydb *p, struct symtab *s, void *fp)
 		typdatum->primary = le32_to_cpu(buf[2]);
 	}
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1543,7 +1543,7 @@ static int user_read(struct policydb *p, struct symtab *s, void *fp)
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		usrdatum->bounds = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1588,7 +1588,7 @@ static int sens_read(struct policydb *p, struct symtab *s, void *fp)
 	len = le32_to_cpu(buf[0]);
 	levdatum->isalias = le32_to_cpu(buf[1]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1630,7 +1630,7 @@ static int cat_read(struct policydb *p, struct symtab *s, void *fp)
 	catdatum->value = le32_to_cpu(buf[1]);
 	catdatum->isalias = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1904,7 +1904,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
 	len = le32_to_cpu(buf[0]);
 
 	/* path component string */
-	rc = str_read(&name, GFP_KERNEL, fp, len);
+	rc = str_read(&name, fp, len);
 	if (rc)
 		return rc;
 
@@ -1988,7 +1988,7 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 	len = le32_to_cpu(buf[0]);
 
 	/* path component string */
-	rc = str_read(&name, GFP_KERNEL, fp, len);
+	rc = str_read(&name, fp, len);
 	if (rc)
 		return rc;
 
@@ -2128,7 +2128,7 @@ static int genfs_read(struct policydb *p, void *fp)
 		if (!newgenfs)
 			goto out;
 
-		rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len);
+		rc = str_read(&newgenfs->fstype, fp, len);
 		if (rc)
 			goto out;
 
@@ -2167,7 +2167,7 @@ static int genfs_read(struct policydb *p, void *fp)
 			if (!newc)
 				goto out;
 
-			rc = str_read(&newc->u.name, GFP_KERNEL, fp, len);
+			rc = str_read(&newc->u.name, fp, len);
 			if (rc)
 				goto out;
 
@@ -2261,7 +2261,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 					goto out;
 				len = le32_to_cpu(buf[0]);
 
-				rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
+				rc = str_read(&c->u.name, fp, len);
 				if (rc)
 					goto out;
 
@@ -2307,7 +2307,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 					goto out;
 
 				len = le32_to_cpu(buf[1]);
-				rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
+				rc = str_read(&c->u.name, fp, len);
 				if (rc)
 					goto out;
 
@@ -2370,7 +2370,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 					goto out;
 				len = le32_to_cpu(buf[0]);
 
-				rc = str_read(&c->u.ibendport.dev_name, GFP_KERNEL, fp, len);
+				rc = str_read(&c->u.ibendport.dev_name, fp, len);
 				if (rc)
 					goto out;
 
-- 
2.26.2

