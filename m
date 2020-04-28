Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF64C83006
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 12:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF99206D6
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 12:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAurxeFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgD1MzY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:55:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47363 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbgD1MzY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 08:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588078522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8Beh0ZtRDv+pqL9Fu4g+3rKDacRNV0j6KHronz0naI=;
        b=XAurxeFHJI0uefa9uSOaW0GLlX2+DUg2RfTr04Dl+Ny/SBdV2Wb+W5IRfTFFOsI1YYqM/Z
        KKh45MDhcQbPg2Bc/5WHvZTpGxWOYqA82O4WFFfdagquam2cjmXmMiYR0lwqch5lnJdSYR
        7TqVSJIphLGiwleJQKKJRKQB6rJC0BA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-o5U4I7eAPM6Wh6LqBIFGsA-1; Tue, 28 Apr 2020 08:55:21 -0400
X-MC-Unique: o5U4I7eAPM6Wh6LqBIFGsA-1
Received: by mail-wr1-f70.google.com with SMTP id x15so12304598wrn.0
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 05:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8Beh0ZtRDv+pqL9Fu4g+3rKDacRNV0j6KHronz0naI=;
        b=WKAl5FSo+gT3rtAMvT7ZEQ5DpoNoCd1B814U9VdkehpEIBbVL5rv8xx4zsfOhX02kY
         C0rYTQ7xzh0pjxtzXDRZF2Fhsfwk9fVrJ1meabhTCfHJJB9HnGvKxxrIoJNJc0GfpNfg
         4VJMQenTcajRdWr3+vDnJHFc4e4BJc73ZEzpEYhUGTQH0ypSW8k1+S/Mh3dOqIfGVlgj
         InPK8u/SyiGzW7LUpy72t/rMPKP6worSygl7//phDEP4Neil33PUNS5hscUDsgm7fsiN
         TbzKGfKh8Vy3BNxa7YxQKX2QlCYbdFBicB1bowNS/kzflUQJmDbfRboFVlavbcly9WqY
         YGeg==
X-Gm-Message-State: AGi0PuakqoDW5vxa3BKNx/OBlzDdp3dewPe+uyJbzuDE/h2qFL3EBTS/
        tIgm7Wawk69TX3jvKWOF5Wj2p7oMmmA61iKIbdRYZ7eTtmsSYTUhB7+awbpThvqoJXZswf3CfbP
        zkq3OrQdApfAXCdDaAQ==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr4828849wmf.128.1588078520131;
        Tue, 28 Apr 2020 05:55:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypKDojD7+zMjLvjG3bElM1DJRCh6nJMuOBwDByYBPGFWdxWBE0ItbL6KGRoKW2In9kF9Pz6OFw==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr4828827wmf.128.1588078519923;
        Tue, 28 Apr 2020 05:55:19 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id y63sm3082438wmg.21.2020.04.28.05.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 05:55:19 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/4] selinux: simplify range_write()
Date:   Tue, 28 Apr 2020 14:55:11 +0200
Message-Id: <20200428125514.2780171-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200428125514.2780171-1-omosnace@redhat.com>
References: <20200428125514.2780171-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

No need to traverse the hashtab to count its elements, hashtab already
tracks it for us.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 1c0041576643..39cfe9df360c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -3404,14 +3404,6 @@ static int genfs_write(struct policydb *p, void *fp)
 	return 0;
 }
 
-static int hashtab_cnt(void *key, void *data, void *ptr)
-{
-	int *cnt = ptr;
-	*cnt = *cnt + 1;
-
-	return 0;
-}
-
 static int range_write_helper(void *key, void *data, void *ptr)
 {
 	__le32 buf[2];
@@ -3443,19 +3435,13 @@ static int range_write_helper(void *key, void *data, void *ptr)
 static int range_write(struct policydb *p, void *fp)
 {
 	__le32 buf[1];
-	int rc, nel;
+	int rc;
 	struct policy_data pd;
 
 	pd.p = p;
 	pd.fp = fp;
 
-	/* count the number of entries in the hashtab */
-	nel = 0;
-	rc = hashtab_map(p->range_tr, hashtab_cnt, &nel);
-	if (rc)
-		return rc;
-
-	buf[0] = cpu_to_le32(nel);
+	buf[0] = cpu_to_le32(p->range_tr->nel);
 	rc = put_entry(buf, sizeof(u32), 1, fp);
 	if (rc)
 		return rc;
-- 
2.25.4

