Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933B7C35280
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 10:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2B5206BB
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 10:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZyWzRmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfI3Ks7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:48:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730819AbfI3Ks6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 06:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569840537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQEWCI4zrRbNDLydgsD/oUtWE4aVLGVSgvae4a4jNFM=;
        b=SZyWzRmMKhQKvDtjYPmO5+1P0MaVX4DG+rfMTmE0S1Jjl9u4tw/sUBMPuq7WuAxNx+f4fF
        34abVVIrITXOFjD9Lmt1EycBid4SNLLDTeJhpqLgCWwmbeqH/X60idy44hqorkF/hqBLSe
        r4cH/BVlGfHUANPAkEs4pSpZ3uDbgIY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-7-gX3WbtM72JJlJk0SBZ-w-1; Mon, 30 Sep 2019 06:48:56 -0400
Received: by mail-wm1-f70.google.com with SMTP id z205so5753381wmb.7
        for <selinux@vger.kernel.org>; Mon, 30 Sep 2019 03:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SwD3Kkv8vnB+IDCfPWJogQpWTS/cY3Ka0V1TrAc0g0=;
        b=fhNIlh/WJvpJjgPQiSUYR8ICgRuiTIBsEI+iXzj4Filpn+XXoSm4SKJmbpsZdZt9dt
         d+LWSifiqfI7ALLywdLuZlM7zUptb4XPdAQxuY66klTly/c5aek1EVU8oNfENV2SYRJ8
         EtWDZkrY+YnWgYWSnqdvPWKAeTyQx+oHcNO9pxQV5DMshwuPvniJGOl/YAO8ONI1gOaj
         xxVAcLwq53khXxvKUy5ajQzOfit+OmTnz+oXDf3QmzHSchbiHp8Ee+xygZzl7q8Mannw
         LftwUQvwOmzrEipExmWUuXXE9BQArW8LmCr+eTY2hjd01Wpo0QbSPbufsPqTWS9ZdRDJ
         agVg==
X-Gm-Message-State: APjAAAURx/DZ6EF9k6Ffxdm5z0ukjVN8bcjSD1toj+8cUb4UuvkHQ/Ut
        +s9VIi4oIVUphKk4egkaw8oKGTMHjm16WDhTvRlSxeniNvkfipFLUeF15xSo0gw78eQFMIE4iws
        z0hrrNtZizMf4AzdgiA==
X-Received: by 2002:a7b:c404:: with SMTP id k4mr18023678wmi.90.1569840535086;
        Mon, 30 Sep 2019 03:48:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzur8udK5NuQSzjltPIWuL+vA/yt/7StoOU1vwDncjIy43oWFsV/PCod3zUOPK42jPBaDtv6A==
X-Received: by 2002:a7b:c404:: with SMTP id k4mr18023663wmi.90.1569840534862;
        Mon, 30 Sep 2019 03:48:54 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i73sm27081254wmg.33.2019.09.30.03.48.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 03:48:53 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 1/3] policy: consolidate macros for home dirs access
Date:   Mon, 30 Sep 2019 12:48:48 +0200
Message-Id: <20190930104850.5482-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190930104850.5482-1-omosnace@redhat.com>
References: <20190930104850.5482-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 7-gX3WbtM72JJlJk0SBZ-w-1
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
2.21.0

