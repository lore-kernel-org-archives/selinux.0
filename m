Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15289C433DB
	for <selinux@archiver.kernel.org>; Mon, 25 Jan 2021 08:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA15122CF6
	for <selinux@archiver.kernel.org>; Mon, 25 Jan 2021 08:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbhAYH6v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Jan 2021 02:58:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727290AbhAYH6p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Jan 2021 02:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611561438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cq7SLbgDGKXOIvrSXE5hw/JOl7B5idBunQYjdZp8jUw=;
        b=aZwY6uaGpG8yoxgsbahB4ELf+WaXJZMHqcY87y26N6JEECUQESL+sPR9BpD8aNcUtOtCuV
        50p4Uth2EIRjQQYIMd9d1i9Mr0eBiUUcabQYJTPyAaxscDtWQX5F4gUHXa/Y9OttgIvIhR
        BpGUC4koa6AiCfcWaXyZ+ZlY06x81NM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-bGLhO8nTN8esn2FnaUuLvg-1; Mon, 25 Jan 2021 02:57:16 -0500
X-MC-Unique: bGLhO8nTN8esn2FnaUuLvg-1
Received: by mail-ej1-f70.google.com with SMTP id x22so3444212ejb.10
        for <selinux@vger.kernel.org>; Sun, 24 Jan 2021 23:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cq7SLbgDGKXOIvrSXE5hw/JOl7B5idBunQYjdZp8jUw=;
        b=Cay7if4d4RdimgsgnU0BAoypOYRsaSOvFZvUHcnPLajVexSwg9MxO1a+h9LzIhPVJS
         FI0KQLtvxj6/LD17oLZWh6x+FyytZJEPFThyV92qV1uyl7sF1/TQJIYF+eyClsYCxsQ8
         cvu08RBYsKIPpWNrQ/0Yj0dUmb/YCh3zEqZ/FWy5iAtEDzLtt9cfN9GNCToSh7tbhFCN
         ZC6+J49qxKw8r/snkeyEcORC85agGTMoG/kfi0jBxg4nN4hSmpICn5EejxzEJ0CUEHFk
         QHJwKU06IUzJbpqflnI35xKy0uATbDXZ2Pzx8KOEzouXgwGMz4HPhDFXjqFNq5L/zCeM
         GJog==
X-Gm-Message-State: AOAM5320mrjEXVisFIvtNQFzKmqCp7f3QSl1sbC0S66JYIIHkznZXSue
        nEogfOU8Msm4YScTZaiaQmI0Uunt8EhLdalLe3Tv90HYDJxB1zPFFhFaQi/wH14IaDht5AGliOZ
        kUxD0fMmfFpoGZgzO2svldBKeRrZLbZ86uTyJqYqubPp6J4Jp/NNf69Z5dOdocoPFvhqxVw==
X-Received: by 2002:a05:6402:55:: with SMTP id f21mr326760edu.38.1611561435191;
        Sun, 24 Jan 2021 23:57:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+T5MYBggXImZl2a7We2SlYQxTO8zUS7mqnbpu2mzsNvaiaBEmUgVLrrHKzMRG0GQymt6biQ==
X-Received: by 2002:a05:6402:55:: with SMTP id f21mr326747edu.38.1611561434909;
        Sun, 24 Jan 2021 23:57:14 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id k21sm9968799edq.60.2021.01.24.23.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 23:57:14 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH testsuite] test_userfaultfd.te: grant test_uffd_domain CAP_SYS_PTRACE
Date:   Mon, 25 Jan 2021 08:57:13 +0100
Message-Id: <20210125075713.356704-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

userfaultfd(2) requires the caller to have CAP_SYS_PTRACE if the
vm.unprivileged_userfaultfd sysctl is set to 0, so grant all userfaultfd
test domains the corresponding SELinux permission, otherwise the tests
will fail when the sysctl is set to 0 (e.g. Fedora 34+).

While there, also remove a commented-out rule that doesn't need to be
there.

Fixes: 2ea007924363 ("selinux-testsuite: Add userfaultfd test")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_userfaultfd.te | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/policy/test_userfaultfd.te b/policy/test_userfaultfd.te
index e29723d..f15ef89 100644
--- a/policy/test_userfaultfd.te
+++ b/policy/test_userfaultfd.te
@@ -44,8 +44,10 @@ userfaultfd_domain_type(test_noioctl_uffd_t)
 # Domain for process that cannot read from userfaultfd
 userfaultfd_domain_type(test_noread_uffd_t)
 
+# userfaultfd(2) requires CAP_SYS_PTRACE
+allow test_uffd_domain self:capability { sys_ptrace };
+
 # Allow all of these domains to be executed
-#allow test_uffd_domain test_file_t:file { entrypoint map execute };
 miscfiles_domain_entry_test_files(test_uffd_domain)
 unconfined_runs_test(test_uffd_domain)
 userdom_sysadm_entry_spec_domtrans_to(test_uffd_domain)
-- 
2.29.2

