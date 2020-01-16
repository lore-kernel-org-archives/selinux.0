Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9CBC33CAF
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 18:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB602064C
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 18:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5Vq81Do"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391242AbgAPSqH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:46:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22941 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729827AbgAPSqG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 13:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579200364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UAzyao1TQ5ueq5BVGFbgBqk1Mc1vWwB9I886SGbfV68=;
        b=O5Vq81DoylwVHlY6YoEud8JFdMLwgccuyfF6EYVD7bmm1lWDOFBXoathbRIqkB4w01gwO0
        2BVle05Gr272iaihw3p/MCLrl/grQssqe83R+XoWEP0+6O6GSCzcrpzjzyX/1X6WdD8UkQ
        X7ePWGeHvLr1TaqEr/SJUqSbycZf3Ws=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-s9VTWG1dMRq3bkeq4AP9FQ-1; Thu, 16 Jan 2020 13:46:03 -0500
X-MC-Unique: s9VTWG1dMRq3bkeq4AP9FQ-1
Received: by mail-wr1-f70.google.com with SMTP id j4so9560521wrs.13
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 10:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAzyao1TQ5ueq5BVGFbgBqk1Mc1vWwB9I886SGbfV68=;
        b=WELDxYeD5e7v8C+siJ8I1sfwJ8F6cI1RMu12apdb89YaE9LRcm3LD8vcxGTtAW2XB0
         bYh/CbR1pwl8SkkiBXTNuigt/tDcAZyu+gGmWd/MgCa0ttqJWhREL/+/d8jqtww3bhbq
         5USDQfW9Z6Rq/kz6VQJA8cOLboNtAnHp19jFTUmRlIXQiQZ9O5zE0Aeb0Q7KO968/Yki
         hdI1ModJ1DxZKIUZ65OU0zky7VdR5NYDbk2FqbB2++x/BGYWH3hWijDGTr2JmS8NaR6a
         0nRKReuriH7wKv1wUAGQTDNKW0Qf8q2/uyYkORvC1o5o6YF4kKOWRchSmwSynEvgKCMt
         +hqg==
X-Gm-Message-State: APjAAAXL/hvI0atOznLByX618Y6x+BfAp3rK4rLO7T1VyhwPSaO1sB+V
        eoKXDM6OPGvcKM9z4m/r5IY31Vu1ybLn2BnA5pOSG1DwwHw/38ZBe5P+B3Grali654ZXOJRrSz1
        0zCBwEwTNwZXVTTrzWw==
X-Received: by 2002:adf:82f3:: with SMTP id 106mr4822029wrc.69.1579200361908;
        Thu, 16 Jan 2020 10:46:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxMzclH95Oo8JrAJY6HqSPlqnC1pSvxL42O9ClCwTUHR6VTrH22vIHpa/29fwa3Ivkr6dukaA==
X-Received: by 2002:adf:82f3:: with SMTP id 106mr4822011wrc.69.1579200361695;
        Thu, 16 Jan 2020 10:46:01 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id l17sm29187324wro.77.2020.01.16.10.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:46:01 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] selinux: fix wrong buffer types in policydb.c
Date:   Thu, 16 Jan 2020 19:45:57 +0100
Message-Id: <20200116184557.344610-1-omosnace@redhat.com>
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
Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
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

