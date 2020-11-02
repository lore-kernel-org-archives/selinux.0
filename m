Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D69C388F2
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 08:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9C9206DC
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 08:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4zL3ete"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgKBIfZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 03:35:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727806AbgKBIfZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 03:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604306123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYrQJbkdrg54Gc+N/qM71BZB5xoYJ/RWA9WY/UFLS/g=;
        b=M4zL3eteNlyPD5a8NxRkNEdrz98NkIJ5O/JfEmykgZqzk+zJC0hDSXkVj/36hvqukB3Ces
        zD8CWqzijQlHxCkSoOXnOwBCp1u9MUmi1O90oQOSw69UTEIgjv5pJNiuHS/SMfjkhDwdM2
        OO6e+/dwB+VyGH4C4lvOc4zhLLHqLts=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-_CEdTo-jO8yStH9rh0It2g-1; Mon, 02 Nov 2020 03:35:22 -0500
X-MC-Unique: _CEdTo-jO8yStH9rh0It2g-1
Received: by mail-ed1-f69.google.com with SMTP id bs10so5823010edb.22
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 00:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYrQJbkdrg54Gc+N/qM71BZB5xoYJ/RWA9WY/UFLS/g=;
        b=fbTMEJyUdZGbGgOwlgVaO5F/6mtEYrQQuQkS3DvJjHI3kv5Qr3PRuxaCBa0CBL0QJ8
         BEE2deWPkSunWh65p33lgilMzh8ZqDowRQyUeGYjP9Une+TuWKBKu7XpMa82MimpchYL
         n9KRFtA12/pMYo+6ajeGs5W+ZxqFYlwF5Z759fNijww5CJONGc1MN6mPyJzCVrG9/6Mp
         yuROM5b99HK4wB0NKFMRc1PurEppF+JN0jgzoBO1WBlFs9CyaBi+JGFBqkQ79nqOdFYr
         nX/vnKP6GqklT1Z2zs5OrDENGSwDUDP7mkq9yJ5PqaEMm101WwmLAzTAw9DnsBRrUSWe
         PtJQ==
X-Gm-Message-State: AOAM530maM0RhW4Un9t6lNs7It3OwT1lpgkXOBkSaxpeKUV6PqXiVtdC
        gGP+tX4Lq3k/tCqTSoYdub2hFEUNCMEVW7nco6P68qpvUSkXMnkhZNkw9BFHoGO6U5FuvtjBvC4
        VAg74j/cGfO4hkpQasQ==
X-Received: by 2002:a17:906:824a:: with SMTP id f10mr15292753ejx.167.1604306120363;
        Mon, 02 Nov 2020 00:35:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+LlzxrudqYDK2dHM6dlK5nwXR/NZo4EGsstF3ypyQliqV2dhUevxTwISwjAFo2qUj+VbwcA==
X-Received: by 2002:a17:906:824a:: with SMTP id f10mr15292744ejx.167.1604306120218;
        Mon, 02 Nov 2020 00:35:20 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id bk13sm9293716ejb.58.2020.11.02.00.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:35:19 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH testsuite v2 1/4] README,travis: add e2fsprogs, jfsutils, and dosfstools to deps
Date:   Mon,  2 Nov 2020 09:35:13 +0100
Message-Id: <20201102083516.477149-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102083516.477149-1-omosnace@redhat.com>
References: <20201102083516.477149-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

They are needed for ext4, jfs, and vfat tests, which will become
executed by default in an upcoming patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 README.md                  | 6 ++++++
 travis-ci/run-testsuite.sh | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/README.md b/README.md
index 838a082..1149f30 100644
--- a/README.md
+++ b/README.md
@@ -58,6 +58,9 @@ similar dependencies):
 * keyutils-libs-devel _(tools used by the keys tests)_
 * kernel-devel _(used by the kernel module tests)_
 * quota, xfsprogs-devel and libuuid-devel _(used by the filesystem tests)_
+* e2fsprogs _(used by the ext4 filesystem tests)_
+* jfsutils _(used by the jfs filesystem tests)_
+* dosfstools _(used by the vfat filesystem tests)_
 * nftables _(used by inet_socket and sctp tests if ver >= 9.3 for secmark testing )_
 
 On a modern Fedora system you can install these dependencies with the
@@ -81,6 +84,9 @@ following command (NOTE: On Fedora 32 and below you need to remove
 		quota \
 		xfsprogs-devel \
 		libuuid-devel \
+		e2fsprogs \
+		jfsutils \
+		dosfstools \
 		nftables \
 		kernel-devel-$(uname -r) \
 		kernel-modules-$(uname -r)
diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
index 051f9d8..bd9073c 100755
--- a/travis-ci/run-testsuite.sh
+++ b/travis-ci/run-testsuite.sh
@@ -38,6 +38,9 @@ dnf install -y \
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

