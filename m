Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C812C433E1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 15:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B442071E
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 15:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaO1XoAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgHXPwX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:52:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55111 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726999AbgHXPwV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 11:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598284339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjYfETYgavsV8Y7+RSnL/aX7yPOhdabiGgvItnkFZqw=;
        b=MaO1XoAStAunLrTKGrh9AaMa1KHTcxjElGqE5URs6MEktblOZgiySQX9WXkkSwobxcH/7d
        XVrSH6zwUJzxp/GTG/NZfncTzTHEQQiW5RPBZkkkvoXGIy9DjTw0TRPiz6x6ww7DnVBMNe
        nThiLoxvIWvld/89azQMv4JQ2lVi9QM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-HpgFCuMAMxKraRdiwgHKRw-1; Mon, 24 Aug 2020 11:52:16 -0400
X-MC-Unique: HpgFCuMAMxKraRdiwgHKRw-1
Received: by mail-wm1-f72.google.com with SMTP id p23so3756096wmc.2
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 08:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjYfETYgavsV8Y7+RSnL/aX7yPOhdabiGgvItnkFZqw=;
        b=K8j3+9b6463TBx33IikuDL4OQsy8a1qVwIepFG5XGRzInoe+LnB3OGNU8nszE4FjRI
         CRFq08gR89P14yjcSLiL7MsRXn0KQXM3w3uBSpVNGLy/6gMmzI5zTizN2b2wLuN1n9jT
         HWR4H8L+9now+6qnI+ya86ZiTPtjfu6aG7SHrwjx8zVMgMKzdo3oH4eKNfo7wqADMDMk
         jA62gl1VrWJnt3XDcfSrgnYj78i12Bfdc+fjCbxR+ySiRyZrzrgiLIUoxkhxg48ioPQ3
         gX1YG0uW9y7oPbq4w8Wo2HvIN2AYmi6lBz02dDwGq5+oXktip6BfsHiUWYXOzRnocNME
         ZyQQ==
X-Gm-Message-State: AOAM531TMSaLftaseDTxRsaqOR3FZAmynP1+54gQBpU3cckMZR7RUrqN
        NhXg81DXvZCGv/ZKuVeYVb3G90WutbferweWPLguyVVxmQnOCXGuvhiXgDrYec4BKoiBqpWWJxx
        aEZ2fO2Ttv2ooTNZ86A==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr6061797wrq.327.1598284335179;
        Mon, 24 Aug 2020 08:52:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq6PjSNdasZHM1Zz3kuLg4xHQnQu6H63XS6NnZaxKWvMkQNqsNTuyYKrARcq4Xd26KnN3sBA==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr6061780wrq.327.1598284334956;
        Mon, 24 Aug 2020 08:52:14 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id x133sm25684215wmg.39.2020.08.24.08.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:52:14 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] selinux: drop the gfp_t argument from str_read()
Date:   Mon, 24 Aug 2020 17:52:10 +0200
Message-Id: <20200824155210.1481720-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824155210.1481720-1-omosnace@redhat.com>
References: <20200824155210.1481720-1-omosnace@redhat.com>
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

