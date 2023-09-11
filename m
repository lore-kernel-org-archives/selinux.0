Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14153CA0ECB
	for <selinux@archiver.kernel.org>; Mon, 11 Sep 2023 22:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbjIKWLB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Sep 2023 18:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbjIKOYz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Sep 2023 10:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94F3DE54
        for <selinux@vger.kernel.org>; Mon, 11 Sep 2023 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694442243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uRBy/5hifpXCoen/qJhmmaxJlCG9fz8e4gG1zbFX/1o=;
        b=PY8AMyTJ/XH6Kps2cYdxXgNq8sYAohWT81b+tqlL7bg567e0oeXd13suJLFWPoI4iORzKT
        F9Q2dI+RQiaR+4MAksh/m7Wdq5POxpWLENB6VU9xfdzEqpmg6y18dQEEoX2jrgpgZdX9kP
        0UUG29kJiokGjjFDu5/E2Inml5hUI3U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-fHvWSj4pP4yzmLN5OLIOUw-1; Mon, 11 Sep 2023 10:24:01 -0400
X-MC-Unique: fHvWSj4pP4yzmLN5OLIOUw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-401db25510fso33933435e9.1
        for <selinux@vger.kernel.org>; Mon, 11 Sep 2023 07:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694442240; x=1695047040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRBy/5hifpXCoen/qJhmmaxJlCG9fz8e4gG1zbFX/1o=;
        b=HT7GBtT4kd2r8ltgHvIVvo86/Spf6LL7orNboejL83+JaPRpYTkAaj782nuO0QyNj2
         gA7T+/GudIO2zkg6QfOXhtBfGg9f2zLxqjquKDJX9EIMFf3KpWgmJflw5uNJlCvQ2r0K
         M4efSyjsbcCPKhvGN6cB1ZTUQ/daMOtzYCent55zBhaWDoFC8/qwEJcDE8OjX+/i3pcp
         pLxQGHQL1cgHPAZgJ2pY4t1U2mzd9cmP1guIXtTe7i7dP+vRGfVlEQ7reGgpnuAF/g44
         V/QSyEYdLA1Mu0IWnjF0uqDUwS46YxqbiHYl6qb7ifIvXXuoiWFN0zIKYh3+HCw+Ud5y
         3YPg==
X-Gm-Message-State: AOJu0YzxavhhsNc23079t2QxUdweh8vhAMw0nrNBWlGQXT0gnDUev4nL
        s37DXluXCCGTn0CxBl26bHzXgTr6iHXAp5VJU+x+ov/ZYC5MiGerEFUcnuF0dGaweTyQPi9deEh
        VbvXkauZtqs14MPHv+A==
X-Received: by 2002:a7b:cbd1:0:b0:3fc:a49:4c05 with SMTP id n17-20020a7bcbd1000000b003fc0a494c05mr7916588wmi.40.1694442240424;
        Mon, 11 Sep 2023 07:24:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3zMpKjEdJmmCLNeJZXrAZudqrekd0jemCiU1mmGpQotLlsulhOtjU19kH5XisEZuTTQ7n+A==
X-Received: by 2002:a7b:cbd1:0:b0:3fc:a49:4c05 with SMTP id n17-20020a7bcbd1000000b003fc0a494c05mr7916569wmi.40.1694442240086;
        Mon, 11 Sep 2023 07:24:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b003fc04d13242sm13357490wmi.0.2023.09.11.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 07:23:59 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Adam Williamson <awilliam@redhat.com>
Subject: [PATCH] selinux: fix handling of empty opts in selinux_fs_context_submount()
Date:   Mon, 11 Sep 2023 16:23:58 +0200
Message-ID: <20230911142358.883728-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selinux_set_mnt_opts() relies on the fact that the mount options pointer
is always NULL when all options are unset (specifically in its
!selinux_initialized() branch. However, the new
selinux_fs_context_submount() hook breaks this rule by allocating a new
structure even if no options are set. That causes any submount created
before a SELinux policy is loaded to be rejected in
selinux_set_mnt_opts().

Fix this by making selinux_fs_context_submount() leave fc->security
set to NULL when there are no options to be copied from the reference
superblock.

Reported-by: Adam Williamson <awilliam@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2236345
Fixes: d80a8f1b58c2 ("vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 10350534de6d6..2aa0e219d7217 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2775,14 +2775,20 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
 static int selinux_fs_context_submount(struct fs_context *fc,
 				   struct super_block *reference)
 {
-	const struct superblock_security_struct *sbsec;
+	const struct superblock_security_struct *sbsec = selinux_superblock(reference);
 	struct selinux_mnt_opts *opts;
 
+	/*
+	 * Ensure that fc->security remains NULL when no options are set
+	 * as expected by selinux_set_mnt_opts().
+	 */
+	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
+		return 0;
+
 	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
 		return -ENOMEM;
 
-	sbsec = selinux_superblock(reference);
 	if (sbsec->flags & FSCONTEXT_MNT)
 		opts->fscontext_sid = sbsec->sid;
 	if (sbsec->flags & CONTEXT_MNT)
-- 
2.41.0

