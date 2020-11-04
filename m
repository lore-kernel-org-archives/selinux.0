Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F517C388F9
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 07:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CA82080D
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 07:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpbmKIIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgKDHbr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 02:31:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726259AbgKDHbr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 02:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604475105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y3zxkW0DLch+JZQpm8phcGwFSJnvd1w78cPQYKDVaW8=;
        b=CpbmKIIvXL0gAtG6PRqkUaoHCCrWISXi3EsgsjKw+Frum8mI1edZqyuyMWBSZEpEGfqvKr
        hQkpiMUoYvaMEWKOdbhh/eQd99t+lD3Rrwp+0a4sFbBiEgsIu9WPPl6diRI9xWwdSiEyGn
        XXZ5FKfmyE7/RmSWqMOHy5p6XB6fV7E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-1NBDEhUqNVWmu6e_XU-f_Q-1; Wed, 04 Nov 2020 02:31:44 -0500
X-MC-Unique: 1NBDEhUqNVWmu6e_XU-f_Q-1
Received: by mail-wm1-f71.google.com with SMTP id o19so871757wme.2
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2020 23:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3zxkW0DLch+JZQpm8phcGwFSJnvd1w78cPQYKDVaW8=;
        b=L0l5TgiQp4mybqswrHWvqkeQy+aeJSEU7FTEJ4WZvOzNi3nC70cKeodG1f4nEh/XeL
         LJgesC46ZagbWNRNt3z9m3gV7IrX2veMjzfPgu3K/UrNqnj4Gzlzl5U1lCI3bg3bjdPz
         Qfda+cOaX6DF+JQPgFlGrMJ5UUaOojIHs9YenqaV3NRdWmL+YAn8wvRDqxUeUEmVUyvU
         3Qb/WEOmYzrO6zNmWXS2Wa35cW/mQHGredF6Uk9P2K/xZNBPvSWNMOQWFRGQky2Hj5Lb
         DJcT3lQ3p9ZPhHXA5xl/J6Zh+0d4Slor2bbOfH6UK8SAud6PR8A0Iy/YLcv8ISJ2Y6Pj
         0x6A==
X-Gm-Message-State: AOAM532dXy/UXhyM5aTzX2rHh4+CdX3LjOxrncpQxmKgtHHPcEV2DIyE
        i3jJvQSOMIp7ouK7TJY2QwS205hc6M7wEjnhhKdMRaYk+daaGDQey5IeeJGiXAwDs8djSwBgN6V
        8XKQIX3+wmHhnFI+O5A==
X-Received: by 2002:a1c:6002:: with SMTP id u2mr2544538wmb.29.1604475102693;
        Tue, 03 Nov 2020 23:31:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDsFdZYJXnQRmKq/JYfAVwWoR8cRJ0mdEb5CtoKJ5udME/G1SeOirl9jcYTdr060Lc4axUMA==
X-Received: by 2002:a1c:6002:: with SMTP id u2mr2544527wmb.29.1604475102517;
        Tue, 03 Nov 2020 23:31:42 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id l3sm1267610wmg.32.2020.11.03.23.31.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 23:31:41 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/Makefile: silence modprobe output
Date:   Wed,  4 Nov 2020 08:31:40 +0100
Message-Id: <20201104073140.819579-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid obtrusive error messages when the kernel doesn't support some of
the filesystems.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index b441031..4c00b5f 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -19,7 +19,7 @@ MAX_KERNEL_POLICY := $(shell cat $(SELINUXFS)/policyvers)
 POL_TYPE := $(shell ./pol_detect $(SELINUXFS))
 
 # Filter out unavailable filesystems
-FILESYSTEMS := $(foreach fs,$(FILESYSTEMS),$(shell modprobe $(fs) && echo $(fs)))
+FILESYSTEMS := $(foreach fs,$(FILESYSTEMS),$(shell modprobe $(fs) &>/dev/null && echo $(fs)))
 
 SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	fdreceive inherit link mkdir msg open ptrace readlink relabel rename \
-- 
2.26.2

