Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D14C33CB1
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 13:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AA9206D5
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 13:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeTMMXLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgAPNTg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:19:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50918 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726278AbgAPNTg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 08:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579180775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hLpfTKp5Fq1Q5Ygv9xQknVQGKrrwMZPPUNRRHNDb21E=;
        b=GeTMMXLzchzCSzXsUMsnN8582qhlC1v1aUuIKhe31ST07GAA1kmKNle03Voey34+3xEMQA
        IeP5uNMW/s6bOXBj8uxoaVAGUmLpEEh+JPGwUvfDuP4D7On4HWk2zK3IQNApNNmbVrUUD9
        oOHrTElqWYXTWhn3WKXUk3Sv7Ew5K1Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-GdlodUqRPYiVrWDXhtIkrg-1; Thu, 16 Jan 2020 08:19:33 -0500
X-MC-Unique: GdlodUqRPYiVrWDXhtIkrg-1
Received: by mail-wr1-f69.google.com with SMTP id w6so9197152wrm.16
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 05:19:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hLpfTKp5Fq1Q5Ygv9xQknVQGKrrwMZPPUNRRHNDb21E=;
        b=VEsvw2XR1zvmkZHvye6bxvb7/7IMDPQYs3BAzeeDkI1Be24fXJJaj7fRwDMjt7BTE4
         VxEYgNkJ0RTLHCjey+WN9A6L9vHRD36hpF1LaetvmmRmBpB6h1kzHpxFBft/p8jvwDjB
         eD3oS+yLN4u8I2T5+d9gN32ar+DYvf43nHTaBWA7X7glde+JSkrEv126Cgxe15Do6jD5
         U+o5T5ro5rtQgCyKICIupmWRg3w70czsywf1TmbXO5jgTvWDMVfDjxFk9U81CyCWKlb4
         k3+LkdcKjvCVqQ5Kj2qrjVcQJYveoftNdi0OEKpHQ7Z+baUDKzm6oPISS9DyYP/UIaVr
         r/dg==
X-Gm-Message-State: APjAAAU34f6k3DxXr0NEFcIF5YA7IAzEk64sni0MgJi8N59VytdFmDBn
        +QnzWRUNU6PoMxGCm//YERK6aefWhi94H40wPrfnkuS091Hbsme5YE30cT5ZQ41Sv502PZt7Wts
        yPkkhDd7LcVheU/HZ+Q==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr3496003wrr.340.1579180770784;
        Thu, 16 Jan 2020 05:19:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxu4OSQO+39KGug6ieQSTh+F9r4RuTl7lbNICttubZOrwuVJik/Bi1dx1wPZC1kRYidyfWnQg==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr3495990wrr.340.1579180770571;
        Thu, 16 Jan 2020 05:19:30 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o1sm29144211wrn.84.2020.01.16.05.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:19:29 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: fix sparse warnings in policydb.c
Date:   Thu, 16 Jan 2020 14:19:28 +0100
Message-Id: <20200116131928.315533-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Two places used u32 where there should have been __le32.

Fixes sparse warnings:
  CHECK   [...]/security/selinux/ss/services.c
[...]/security/selinux/ss/policydb.c:2669:16: warning: incorrect type in assignment (different base types)
[...]/security/selinux/ss/policydb.c:2669:16:    expected unsigned int
[...]/security/selinux/ss/policydb.c:2669:16:    got restricted __le32 [usertype]
[...]/security/selinux/ss/policydb.c:2674:24: warning: incorrect type in assignment (different base types)
[...]/security/selinux/ss/policydb.c:2674:24:    expected unsigned int
[...]/security/selinux/ss/policydb.c:2674:24:    got restricted __le32 [usertype]
[...]/security/selinux/ss/policydb.c:2675:24: warning: incorrect type in assignment (different base types)
[...]/security/selinux/ss/policydb.c:2675:24:    expected unsigned int
[...]/security/selinux/ss/policydb.c:2675:24:    got restricted __le32 [usertype]
[...]/security/selinux/ss/policydb.c:2676:24: warning: incorrect type in assignment (different base types)
[...]/security/selinux/ss/policydb.c:2676:24:    expected unsigned int
[...]/security/selinux/ss/policydb.c:2676:24:    got restricted __le32 [usertype]
[...]/security/selinux/ss/policydb.c:2681:32: warning: incorrect type in assignment (different base types)
[...]/security/selinux/ss/policydb.c:2681:32:    expected unsigned int
[...]/security/selinux/ss/policydb.c:2681:32:    got restricted __le32 [usertype]
[...]/security/selinux/ss/policydb.c:2701:16: warning: incorrect type in assignment (different base types)
[...]/security/selinux/ss/policydb.c:2701:16:    expected unsigned int
[...]/security/selinux/ss/policydb.c:2701:16:    got restricted __le32 [usertype]
[...]/security/selinux/ss/policydb.c:2706:24: warning: incorrect type in assignment (different base types)
[...]/security/selinux/ss/policydb.c:2706:24:    expected unsigned int
[...]/security/selinux/ss/policydb.c:2706:24:    got restricted __le32 [usertype]
[...]/security/selinux/ss/policydb.c:2707:24: warning: incorrect type in assignment (different base types)
[...]/security/selinux/ss/policydb.c:2707:24:    expected unsigned int
[...]/security/selinux/ss/policydb.c:2707:24:    got restricted __le32 [usertype]

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e369b0092cdf..2aa7f2e1a8e7 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2659,7 +2659,7 @@ static int role_trans_write(struct policydb *p, void *fp)
 {
 	struct role_trans *r = p->role_tr;
 	struct role_trans *tr;
-	u32 buf[3];
+	__le32 buf[3];
 	size_t nel;
 	int rc;
 
@@ -2691,7 +2691,7 @@ static int role_trans_write(struct policydb *p, void *fp)
 static int role_allow_write(struct role_allow *r, void *fp)
 {
 	struct role_allow *ra;
-	u32 buf[2];
+	__le32 buf[2];
 	size_t nel;
 	int rc;
 
-- 
2.24.1

