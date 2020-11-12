Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A49CC2D0A3
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 09:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46D9216FD
	for <selinux@archiver.kernel.org>; Thu, 12 Nov 2020 09:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+aE/4iW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKLJP3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Nov 2020 04:15:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725966AbgKLJP2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Nov 2020 04:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605172527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+bUfdGb2lny+CxNYcFb1v3dpi0kGnTY+rxIrgq+L3JM=;
        b=A+aE/4iWQHCPvRkMEFo5CeavAFI0P4iN4K53YhI37e3pGAz6MzKEJes6eACqYBDxdQYhP4
        anSZoU++N+52QoI6DITmINIuiAwGGtxFYE6D0wYsg+mCDXvY/v25aXnLgAVz5NaX1+4Wsl
        Ur2DMwDjjn2NKP4SRS4a7GtucLngZts=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-6aS_oNP4NdiHiRbfH64l5A-1; Thu, 12 Nov 2020 04:15:23 -0500
X-MC-Unique: 6aS_oNP4NdiHiRbfH64l5A-1
Received: by mail-wm1-f70.google.com with SMTP id o81so1533106wma.0
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 01:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+bUfdGb2lny+CxNYcFb1v3dpi0kGnTY+rxIrgq+L3JM=;
        b=Fku9kko9rjHIma5+U2c2VbyjeZqUMb4WsGeLFDWp7cEsHT3Rz9eorP9YOqWi++qt4x
         9nV/djIqRAJwCu7UwNmD4XIJotOGKMHomxCamNqU8qRq8XeDlkAKnTDzmf3uiXOu5Fl1
         Mfuif1kfHqEneEDBDmu5jPpDFuH1No2FG4p4a2EhqamXVUvxubAg2OjejG8DRPFNBBN+
         TFYecJ/nA6nVM4XcEuvkUWvlqCaLg8ZFvCkD7HGdvK6rJRneJOLttoBXRQzUbXYJlg64
         KetQckRO/edQVspBJWmHdzssc0c/TZtUUlt/DrptOu5J5HAV6ojo3K/WQ2QZKoYCMTeJ
         78Pg==
X-Gm-Message-State: AOAM533iThxIZAlnAbj/0MyyLtPT/VfabClPAI+mvDrlCC+r0W0Mwxim
        gVhkMBtZxajgomfQ3wA+0beG/6SkafmHjA4MV79CfcFpxjMQK7hSdgLMtbqGZRNdMbE1T/vnym/
        htYCYRzRza7r+C1241ckuDy4TI0fIerJpyNsI1vr6KAJYNqFdH/U5Kzo/4TZjHQVVHAROvg==
X-Received: by 2002:a1c:1d51:: with SMTP id d78mr8475419wmd.60.1605172521537;
        Thu, 12 Nov 2020 01:15:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVJycN3HzkBHC4+WwXDuSJ4FLIPE31SikdexDNJBCYW2spULJy/kfdu/4KYVdy6P+MuAsyTQ==
X-Received: by 2002:a1c:1d51:: with SMTP id d78mr8475403wmd.60.1605172521247;
        Thu, 12 Nov 2020 01:15:21 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id n8sm5279098wmc.11.2020.11.12.01.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 01:15:20 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: [PATCH userspace] ci: add new dependencies needed by selinux-testsuite
Date:   Thu, 12 Nov 2020 10:15:19 +0100
Message-Id: <20201112091519.577246-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The testsuite now runs filesystem tests also on other filesystems than
just the default ext4. [1] That means a few more userspace utilities are
needed to format these filesystems. [2]

[1] https://github.com/SELinuxProject/selinux-testsuite/commit/071ec9c5e5f0442aae0b14f455ea6e6b34ada1e0
[2] https://github.com/SELinuxProject/selinux-testsuite/commit/d4e507f78a1784334611421cdfa3683a8214b22d

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 scripts/ci/fedora-test-runner.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
index 78218963..be2cb7d8 100755
--- a/scripts/ci/fedora-test-runner.sh
+++ b/scripts/ci/fedora-test-runner.sh
@@ -58,6 +58,9 @@ dnf install -y \
     quota \
     xfsprogs-devel \
     libuuid-devel \
+    e2fsprogs \
+    jfsutils \
+    dosfstools \
     kernel-devel-"$(uname -r)" \
     kernel-modules-"$(uname -r)"
 
-- 
2.26.2

