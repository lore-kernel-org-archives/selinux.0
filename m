Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA9CC433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 19:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19ED5208D5
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 19:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYrCO+AP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgFQTXY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQTXY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 15:23:24 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758F4C06174E
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 12:23:24 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id er17so1602361qvb.8
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 12:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qd2nOG5Z3U0RV3aRZACTrfpR4fKlGw+v36zweX/lcGU=;
        b=BYrCO+APGaBa4aubR3hSXNfxmSEvGQ7EM2/4nUOfBqEs63oMrSYJcdE/EdrSn3dZck
         skNFEFuF5oQr/G45hq5SgwaFmy/eGX5CFUbxfxY76QDkFXDCTwgOlFy4ImQfZyv6Pvrl
         S9XCejhqj6ffdSne15fCX3HGAAtQ5/V8/T6Ctt68NVeJ5JbN/HfBGiixpQiF4uDO7S1w
         O6AO3WrLvCafsfxQ1sWNE+tOx1GoRxwcl501wywFtaN2iwpUc4OBWefMwd8DXP0XwOXB
         SZYG+DpS/dRSJ9RnBrQOur0EQkmirF2/ZL8YjYAeNYnu0AWLOIwB46bPWSMiKK7SK1BM
         xgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qd2nOG5Z3U0RV3aRZACTrfpR4fKlGw+v36zweX/lcGU=;
        b=micNuxyn+YqycWMERykxrCh9QeZgmtsmgPNXSLiaubOsQCbqbLns5JzLJ8yyg48EpW
         pA4YRQS9G+T917+6Fdx3hYU4HD2FElsq8fVKe2w45Y1SK3YB6JjQNS0x1TGssvpJDyy9
         DJLHuof9xySyXr+k+E4WQvQdVqvKMNleMGPtfH7x4/rPO6dkJZrww5Uxi5wFRDfWOssm
         57Cgawa0feG6ekIa0/yVNcpucys5kgNv+P88+7c6eMcH1BacHqb/i5QRAasEetYKpoGw
         neTJgCMtz2aKCQgtvfcuSIDEZQBHqfKnVTD2UY+VjoO/RBVTssWuyVa5Yc3OrOYmTcv2
         VO/g==
X-Gm-Message-State: AOAM5331kNUOy7yO+Eip2mWkjk11IRGMbJ4yxzUszOcLz6XxIuViBvFD
        gQE+Whr01GBrVdtop9MoKwEY2koKNXU=
X-Google-Smtp-Source: ABdhPJzfRzqnTEf97pzNtsAX3zlffiMM4rdbGIU6OKPz6sRc66S71D1UmNoMi5Cq3LzbDwVUSafKbg==
X-Received: by 2002:a0c:fd41:: with SMTP id j1mr172485qvs.107.1592421802649;
        Wed, 17 Jun 2020 12:23:22 -0700 (PDT)
Received: from puritycontrol.fios-router.home (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id d9sm767682qtq.56.2020.06.17.12.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 12:23:22 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        bauen1 <j2468h@googlemail.com>
Subject: [PATCH] selinux: log error messages on required process class / permissions
Date:   Wed, 17 Jun 2020 15:23:09 -0400
Message-Id: <20200617192309.69595-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In general SELinux no longer treats undefined object classes or permissions
in the policy as a fatal error, instead handling them in accordance with
handle_unknown. However, the process class and process transition and
dyntransition permissions are still required to be defined due to
dependencies on these definitions for default labeling behaviors,
role and range transitions in older policy versions that lack an explicit
class field, and role allow checking.  Log error messages in these cases
since otherwise the policy load will fail silently with no indication
to the user as to the underlying cause.  While here, fix the checking for
process transition / dyntransition so that omitting either permission is
handled as an error; both are needed in order to ensure that role allow
checking is consistently applied.

Reported-by: bauen1 <j2468h@googlemail.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/policydb.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 98f343005d6b..6f8115224852 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2376,7 +2376,7 @@ int policydb_read(struct policydb *p, void *fp)
 	struct role_trans_datum *rtd = NULL;
 	int i, j, rc;
 	__le32 buf[4];
-	u32 len, nprim, nel;
+	u32 len, nprim, nel, perm;
 
 	char *policydb_str;
 	struct policydb_compat_info *info;
@@ -2519,8 +2519,10 @@ int policydb_read(struct policydb *p, void *fp)
 
 	rc = -EINVAL;
 	p->process_class = string_to_security_class(p, "process");
-	if (!p->process_class)
+	if (!p->process_class) {
+		pr_err("SELinux: process class is required, not defined in policy\n");
 		goto bad;
+	}
 
 	rc = avtab_read(&p->te_avtab, fp, p);
 	if (rc)
@@ -2618,10 +2620,18 @@ int policydb_read(struct policydb *p, void *fp)
 		goto bad;
 
 	rc = -EINVAL;
-	p->process_trans_perms = string_to_av_perm(p, p->process_class, "transition");
-	p->process_trans_perms |= string_to_av_perm(p, p->process_class, "dyntransition");
-	if (!p->process_trans_perms)
+	perm = string_to_av_perm(p, p->process_class, "transition");
+	if (!perm) {
+		pr_err("SELinux: process transition permission is required, not defined in policy\n");
+		goto bad;
+	}
+	p->process_trans_perms = perm;
+	perm = string_to_av_perm(p, p->process_class, "dyntransition");
+	if (!perm) {
+		pr_err("SELinux: process dyntransition permission is required, not defined in policy\n");
 		goto bad;
+	}
+	p->process_trans_perms |= perm;
 
 	rc = ocontext_read(p, info, fp);
 	if (rc)
-- 
2.25.1

