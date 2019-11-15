Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0592C43215
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10B52073A
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2QFhc8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfKOPQa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:16:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22123 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727567AbfKOPQa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Nov 2019 10:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573830989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FnLHKvYQc3vsdYzWgpIIggk89GVKmbUmayNRUHsOcQc=;
        b=Q2QFhc8exafD+a2RtVXRiEe5hJ/Eix/jEAf4kWDgNZA+pV0Hlr7zftkjBbqh634W7XL2Zd
        Tr69xxtwAkMG6KVAYQVEfrwVY0YqA0JrNkcQCDHBPz2RS+o46UdHKn0DYcgwqkA17I8uwR
        E94WUEOGPbYTtoQ8duSfIGC9I2twQJc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-tE7yWCpWMEyPq2crTcjFcQ-1; Fri, 15 Nov 2019 10:16:27 -0500
Received: by mail-wm1-f71.google.com with SMTP id i23so6159149wmb.3
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2019 07:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWjE/d7z6BwpR4PPpVq9L9bDrB7HwMPHHpXoA1MpMFw=;
        b=l1tUzZl4o+i4EJfRoFvT7Mr0EefCnQIlBnFYUPqXYJCSietc5Mojef1XwJ4uOzrPtP
         hSAWfcbpw8mCSOTc+aARQGASdqHuRrBsouYXA+o0+iLlpmNTxUet/LcOpw9IqFoGgS3W
         iiUnLgsBpkJclqrSP3cJqXBlk7jUaTZZKKFlv7roI5tZYjgJcVupl+ekOmf8e8eQEca9
         P82ejYnm3G4C3ELR2FxmB0y3LahVNh6CDg8pOwkg691xJpVJj6JP+Xaq27Mzbq8N4/rG
         tn+zRNdU+TP8yBPgDgrp4Ixb9b7QdQ4qLd3JoUK5RiGcN9KcMyKRKb1roigAYBJUJy+r
         Lwhw==
X-Gm-Message-State: APjAAAWOtCxgn8XehHpWlfTnZtXFLBWfZMXwdK36tDO6id9t/Zv0SJLP
        BnKZWdulQg+ApPblg2q2jwEkUWsgxMk8tdlu94xWPYseHgoQ/eXenrZsYOWtlKgPaTuoaZlJGAO
        KgUSVygjqLZiRNmNmrg==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr16097901wme.76.1573830986472;
        Fri, 15 Nov 2019 07:16:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbMqgypeVXj7F5mwu3wXRq1mvsmuiErI7Id5RYyFh+L5HbTttKhk/bY4ri9heuvNXjY+Q0Xw==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr16097863wme.76.1573830986220;
        Fri, 15 Nov 2019 07:16:26 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j63sm10337239wmj.46.2019.11.15.07.16.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 07:16:25 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v2 1/3] policy: consolidate macros for home dirs access
Date:   Fri, 15 Nov 2019 16:16:21 +0100
Message-Id: <20191115151623.265770-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115151623.265770-1-omosnace@redhat.com>
References: <20191115151623.265770-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: tE7yWCpWMEyPq2crTcjFcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use userdom_search_generic_user_home_dirs(), which is always defined,
and redefine it to match what overlayfs was doing (just in case),

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_overlayfs.te | 6 ++----
 policy/test_policy.if    | 9 +++++++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
index 6f1756e..f56ef78 100644
--- a/policy/test_overlayfs.te
+++ b/policy/test_overlayfs.te
@@ -50,8 +50,7 @@ fs_mount_xattr_fs(test_overlay_mounter_t)
 corecmd_shell_entry_type(test_overlay_mounter_t)
 corecmd_exec_bin(test_overlay_mounter_t)
=20
-userdom_search_admin_dir(test_overlay_mounter_t)
-userdom_search_user_home_content(test_overlay_mounter_t)
+userdom_search_generic_user_home_dirs(test_overlay_mounter_t)
=20
 mount_exec(test_overlay_mounter_t)
 mount_rw_pid_files(test_overlay_mounter_t)
@@ -122,8 +121,7 @@ corecmd_exec_bin(test_overlay_client_t)
 kernel_read_system_state(test_overlay_client_t)
 kernel_read_proc_symlinks(test_overlay_client_t)
=20
-userdom_search_admin_dir(test_overlay_client_t)
-userdom_search_user_home_content(test_overlay_client_t)
+userdom_search_generic_user_home_dirs(test_overlay_client_t)
=20
 fs_getattr_xattr_fs(test_overlay_client_t)
=20
diff --git a/policy/test_policy.if b/policy/test_policy.if
index 5f4000f..40e7499 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -61,8 +61,13 @@ interface(`userdom_sysadm_entry_spec_domtrans_to',`
 ')
 ')
=20
-ifdef(`userdom_search_generic_user_home_dirs', `', ` dnl
+ifdef(`userdom_search_admin_dir', ` dnl
 interface(`userdom_search_generic_user_home_dirs', `
-    userdom_search_user_home_dirs($1)
+    userdom_search_user_home_content($1)
+    userdom_search_admin_dir($1)
+')
+', ` dnl
+interface(`userdom_search_generic_user_home_dirs', `
+    userdom_search_user_home_content($1)
 ')
 ')
--=20
2.23.0

