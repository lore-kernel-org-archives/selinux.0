Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE8DC433E2
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 07:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC7B20737
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 07:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Giz6cTXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgICH2T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbgICH2T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 03:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599118097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3YPs95J8o2rUojb+mSxzzQugHatfYMFg+XPv62J3M24=;
        b=Giz6cTXXchiHp7w9CLpFsYkqm1lOgf8CmzPVzeTlIWXC2O1IDDRY2+fsDSn51Lci8devXq
        sPP2R85Qbcjty0LMBe4ZYPkAGfzmMDoTB/Ofq9zIjFIxeeOJlcbi/7trfHNrGwhCxm1rHY
        POHzgfNzmWpJ7Qh7peu4RyRc8gSjdSk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-4QAp1-X6Nki4G9jJ55kTfg-1; Thu, 03 Sep 2020 03:28:16 -0400
X-MC-Unique: 4QAp1-X6Nki4G9jJ55kTfg-1
Received: by mail-wm1-f70.google.com with SMTP id w3so632493wmg.4
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 00:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YPs95J8o2rUojb+mSxzzQugHatfYMFg+XPv62J3M24=;
        b=SE91W2d0pnmFGNRrxa/dkZHJw+BvhFLlwCbcuQsFU3Np7f11+Yp9VzezrYcSPZlo94
         GVOy6faoSyRjTSAc7WURfprVyGH9oGuhpuhGTclMcpIDO3gS7xh1tdWuaR4s0M44fDDV
         kxN89kzHLKFK0ZUHoLVi8naRVLVXgTZMZHPWuVRSt4APpLDghLrHi1qywez/3eE0mNvK
         6Da0Z3MdAia5am4foyJ5RYuJPNHuI0dlIYIo29IwH+NHeLWFEMveETEIsG01+rmmadSG
         d6gnC/zPbH3/j2bBor/vEifdwLLCTAogdQbFK8oEN3cL4VVG+bNQ+ff2yXQF20ieFqML
         taqg==
X-Gm-Message-State: AOAM532xGzk8AxRDqdb1Hs8j/IVfFbj8REBV63ykDst+HTjcmf5lHJNh
        KifYcSYm4rgcuir5rKHvaZO0o0FALU/QBHi9Ns+RvCXsSmKqGvYdBEjUb7QxWP6xLkOdes3D0rg
        wlPoH2NWmzLjmkKyB+A==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr835947wrv.369.1599118094787;
        Thu, 03 Sep 2020 00:28:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmMNU8A4rOHrFipyPWTia5ems1BQIqj3S+WtJRwRlSKLha+NKg/elNFKtIecW+k1UjPUSIXQ==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr835928wrv.369.1599118094517;
        Thu, 03 Sep 2020 00:28:14 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id q192sm3228446wme.13.2020.09.03.00.28.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 00:28:13 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/Makefile: add kernel version check for watchkey
Date:   Thu,  3 Sep 2020 09:28:12 +0200
Message-Id: <20200903072812.2281009-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The corresponding header files might be available even when the running
kernel doesn't support the tested functionality, so add a kernel version
check for this test (key notifications were introduced in kernel 5.8).

Fixes: 34b7da22ef88 ("selinux-testsuite: Add check for key changes on watch_queue")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile b/tests/Makefile
index 919335b..001639b 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -124,8 +124,10 @@ endif
 endif
 
 ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/support/all_perms.spt && test -e $(INCLUDEDIR)/linux/watch_queue.h && grep -qs KEYCTL_WATCH_KEY $(INCLUDEDIR)/linux/keyctl.h && echo true),true)
+ifneq ($(shell ./kvercmp $$(uname -r) 5.8),-1)
 SUBDIRS += watchkey
 endif
+endif
 
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
-- 
2.26.2

