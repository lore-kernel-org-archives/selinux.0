Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BCBC388F9
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7881D20724
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gShIsbBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgJaL4K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 07:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727043AbgJaL4J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 07:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604145368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYrQJbkdrg54Gc+N/qM71BZB5xoYJ/RWA9WY/UFLS/g=;
        b=gShIsbBug0Qrknx3yEf8775mwS2B3lfgU1dzqUmNeSjC95BPZspMgSIvGrfKtSE+46uTW/
        qqq4xsaIT0uEzpQa+UcdrmJ0cXAZgDgHEy7hwH3dFzf4Zk0k5ZkROCO/99b/tLK3MbK75P
        3J/594iqMoV1IKWmaeizbGANMC3cDhg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-SstUUFscN1OafIWMuexafg-1; Sat, 31 Oct 2020 07:56:06 -0400
X-MC-Unique: SstUUFscN1OafIWMuexafg-1
Received: by mail-ed1-f69.google.com with SMTP id b16so3833074edn.6
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 04:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYrQJbkdrg54Gc+N/qM71BZB5xoYJ/RWA9WY/UFLS/g=;
        b=pJrkp7ry4MPHJKv93Gh9DOk9zjsAgR+CeodZ7FtOQPfjf4Z9yiGsEBRhQPwbjylZJS
         EZJlcj+rLjYXhkQW2235hjk8GS9yAu3CdXgOrrD8M1KfLyqxEkA23qooTikgKKQ5f9uX
         PJVK7ViYSQ378UbRRiCkRFaG5vyjCHjyKTXr6J6jJ8gpVMPjOTA1QcWhZ8/2Fi22h3Rz
         oqYu+WWIu/EcXc1zMb79aUY8YZo0lDOJczn60UrqXaeNDDts6ttHBXHHJm+314mefbP0
         XjKInmgN4aEyL5Jgo3L/ITJ88JxkNv0Oh4Z7PQfPV3gbsV40pUToulfYs5D4HmFgkVrc
         HEgA==
X-Gm-Message-State: AOAM531egixW0ckXeEWwjJL3/LvN14uXufFAPxsn8obD6jKGSRgoGfNZ
        uMRVHj/gCSn1ntlVPUNjtj3/cLpv2qTfJFk2R525gcxO8iSUD0zs7/Gcg/h8bzskhCX9m6EoibG
        YFdcEh5SxfwTR2YpqLw==
X-Received: by 2002:a17:906:814:: with SMTP id e20mr7293716ejd.367.1604145364581;
        Sat, 31 Oct 2020 04:56:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7LHmW0XZAw55V/NwGorDgFaZUfq64BVama5QAD7sj5vrrzq2v/F+meI4Q9VOQykXTgm9ugQ==
X-Received: by 2002:a17:906:814:: with SMTP id e20mr7293700ejd.367.1604145364430;
        Sat, 31 Oct 2020 04:56:04 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id y14sm4770746edo.69.2020.10.31.04.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 04:56:03 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH testsuite 1/3] README,travis: add e2fsprogs, jfsutils, and dosfstools to deps
Date:   Sat, 31 Oct 2020 12:55:59 +0100
Message-Id: <20201031115601.157591-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201031115601.157591-1-omosnace@redhat.com>
References: <20201031115601.157591-1-omosnace@redhat.com>
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

