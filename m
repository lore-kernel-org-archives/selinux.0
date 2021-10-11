Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7975C433FE
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9217460EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhJKQ2d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhJKQ2b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E95C06161C
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t16so48115166eds.9
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uC+ySgpi2s/zDncbkZX9xqTdu0SZPJdJ+rLGpoLiySg=;
        b=CzCIbh1eQW7UQCE53YxSG6U1zLGRbGykk/205keGKzyCi/pnHtFKBW28V9ArNrYu5B
         ae2qIXJETyEHTTb1aEfFT4CrpYrMdFJZSkmqUNxmu0vG9gdRfcmf89YiPc1EpYPJwlVX
         4ewU+6e7U85dviBfUQxmXg3VGQuiBJmeEQCq1mdLFPfNIFb8fj6vmAe/qShGbjSivQDx
         9u3mkL6SlNoBC1cGOOJFIc5aiyDbaiZINCC4kwM5mEse2PlrKSknlCzzWWHS1cHuwShT
         BhSR/IPK2cANhKKeK7yC92KW+FaFDG1w4d+LaB9/51djBopCOhHZ08oloVi4zxntAH/r
         waAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uC+ySgpi2s/zDncbkZX9xqTdu0SZPJdJ+rLGpoLiySg=;
        b=XSUKa9esA7Mn1Kv9XVoKK0UFHkUPQ53JA3t5+AmewmvsSDDb3YN+MUsEHakVZp/e/C
         Bc2YJD4TsDmgHKq0neEFuNZVCndAFr/11fyE0pYp1XE3fDu90/pkF86E2mpe0A7usDo/
         ACnmk08bHDlXQpSNQc9EeLoWN9x9SXPRvwg83pvpcQIqDwGJo2FQBhWoe9ovhT/u3tes
         VSYakoSUoofjSh2m8SYAuqhEnIhv09h8m65HnuQ3258grtcGCNqImw5MKl5ln00rolIk
         6jTp5L7MqSdxakfaoLbBS10VcPlhmD5UK6ypIfUqCoADsEkfENPnpoKORxveGFsAT7u0
         mksQ==
X-Gm-Message-State: AOAM530p4PBimuHQnU+ziIYQPbVmomwA53d4eHfM5kXTkCOcv7mI3keF
        hsl0EaNuvujuaioVsoDUxn8gSX47RbY=
X-Google-Smtp-Source: ABdhPJzZhyUWNAPbqFTUcuunvOb5E24uEjL+voNwVoZ7I4e46Acutz2aPR2iz1f7SLTiahaMNlx3JA==
X-Received: by 2002:a17:907:77cd:: with SMTP id kz13mr27299833ejc.59.1633969589466;
        Mon, 11 Oct 2021 09:26:29 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:29 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 15/35] libsepol: reject invalid default targets
Date:   Mon, 11 Oct 2021 18:25:13 +0200
Message-Id: <20211011162533.53404-16-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Reject loading a policy with invalid default targets so that all
following code, e.g. the different output modes, do not need to handle
unsupported ones.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 980af059..5e8b4a3f 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2313,8 +2313,37 @@ static int class_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 		if (rc < 0)
 			goto bad;
 		cladatum->default_user = le32_to_cpu(buf[0]);
+		switch (cladatum->default_user) {
+		case 0:
+		case DEFAULT_SOURCE:
+		case DEFAULT_TARGET:
+			break;
+		default:
+			goto bad;
+		}
 		cladatum->default_role = le32_to_cpu(buf[1]);
+		switch (cladatum->default_role) {
+		case 0:
+		case DEFAULT_SOURCE:
+		case DEFAULT_TARGET:
+			break;
+		default:
+			goto bad;
+		}
 		cladatum->default_range = le32_to_cpu(buf[2]);
+		switch (cladatum->default_range) {
+		case 0:
+		case DEFAULT_SOURCE_LOW:
+		case DEFAULT_SOURCE_HIGH:
+		case DEFAULT_SOURCE_LOW_HIGH:
+		case DEFAULT_TARGET_LOW:
+		case DEFAULT_TARGET_HIGH:
+		case DEFAULT_TARGET_LOW_HIGH:
+		case DEFAULT_GLBLUB:
+			break;
+		default:
+			goto bad;
+		}
 	}
 
 	if ((p->policy_type == POLICY_KERN &&
@@ -2325,6 +2354,14 @@ static int class_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 		if (rc < 0)
 			goto bad;
 		cladatum->default_type = le32_to_cpu(buf[0]);
+		switch (cladatum->default_type) {
+		case 0:
+		case DEFAULT_SOURCE:
+		case DEFAULT_TARGET:
+			break;
+		default:
+			goto bad;
+		}
 	}
 
 	if (hashtab_insert(h, key, cladatum))
-- 
2.33.0

