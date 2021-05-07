Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F99C433B4
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 13:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C216145D
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 13:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbhEGNFx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 May 2021 09:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235836AbhEGNFx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 May 2021 09:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620392693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lASJYthDIsxknJlvXXycKIOfiMDukaQp3L1ZtsysbkU=;
        b=GEEO5npOaLpMa+/ENvLUiwZcOc15/kI5fo2DIc3KdmkY8H8q0NKLbjtUgymvWlVcinusg8
        hTXLz9BiYbK1MffTsxgtKhTGI0xpa+GnKdx02kOd/fvQ50upbfkby8Ef7z5/0QqjXjJNtp
        uQ4SKcJR8wuO03sQ22TqwArDBI5lw+s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-BXEgwnjTPD-1UShr9ImqZg-1; Fri, 07 May 2021 09:04:51 -0400
X-MC-Unique: BXEgwnjTPD-1UShr9ImqZg-1
Received: by mail-ej1-f72.google.com with SMTP id w2-20020a1709062f82b0290378745f26d5so2964518eji.6
        for <selinux@vger.kernel.org>; Fri, 07 May 2021 06:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lASJYthDIsxknJlvXXycKIOfiMDukaQp3L1ZtsysbkU=;
        b=DKxc1lxAEk/r675C22KPNq32rpNW0u7JMdSnRzqh2id7tzrI203RXNBhuW7uJ/u2rF
         uktbAeEzlpt9664j7aGRrOENi4oUnzXR6TjebiogTX2tpD8oLwnZfjGuqfm8AawaxvR0
         gaYlK2dq3ag5A/Z+C37CF8R8uF9gPWeSEaOcbruR46FwG+uHICc98GHME9IrCqUrQX1R
         Q/ZVDM7cqf1CkgcibRfhsF5H3jGrLAn+pctvDfRHqqBFR7s1IfR7cBCcXEeB1hohm9cE
         0fGl0/hBMVoyqSmjdsCJA6n9Km8TMBIr006Ku9W+9blWyxGEhQ9BTZKKdTYDOJ48OYmQ
         LPbQ==
X-Gm-Message-State: AOAM530JNaRb029VBQ7IU7QV7cVjhnn7QvuUQtKFKPRQI8eunTlOr6uM
        n8hihIyzGfcUbaNEkbS1Cqhc5Mip/pF0eyvMhpX83vp27uUxsOyfh107ZK8GB5hPWim8W2sIQnT
        lR/2lhvTTj/yQBVs8Py/a3aTWwdspfgLuEyt0aVvzEEg48+q0t7TBV17eI/DXOXkCvaNvjA==
X-Received: by 2002:a17:906:8588:: with SMTP id v8mr10018172ejx.550.1620392690477;
        Fri, 07 May 2021 06:04:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0rYTwHdlTkJTDbReNrVSOhPf8hiH6wVuW7u+/lbBVnSR0v5bMTKH6m1jwcDz9QdC8+G7OSg==
X-Received: by 2002:a17:906:8588:: with SMTP id v8mr10018154ejx.550.1620392690271;
        Fri, 07 May 2021 06:04:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id de49sm3489876ejc.16.2021.05.07.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 06:04:49 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: [PATCH] selinux: use strlcpy() when copying IB device name
Date:   Fri,  7 May 2021 15:04:45 +0200
Message-Id: <20210507130445.145457-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

While the buffer should be large enough (IB_DEVICE_NAME_MAX) for all
InfiniBand device names, it's better to be defensive and ensure the
string will be null-terminated even if the hook happens to receive a
longer name.

Found by a Coverity scan (BUFFER_SIZE warning).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 92f909a2e8f7..ec14ed56f508 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6864,7 +6864,7 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
 		return err;
 
 	ad.type = LSM_AUDIT_DATA_IBENDPORT;
-	strncpy(ibendport.dev_name, dev_name, sizeof(ibendport.dev_name));
+	strlcpy(ibendport.dev_name, dev_name, sizeof(ibendport.dev_name));
 	ibendport.port = port_num;
 	ad.u.ibendport = &ibendport;
 	return avc_has_perm(&selinux_state,
-- 
2.31.1

