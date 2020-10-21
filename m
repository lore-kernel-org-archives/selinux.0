Return-Path: <SRS0=8FG4=D4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6631FC55178
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 14:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDEAD22275
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 14:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Zya45OWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443041AbgJUOgI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443653AbgJUOgG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Oct 2020 10:36:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECF0C0613CF
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 07:36:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 19so1565838pge.12
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h5IfM6guW6B3RSJ1rsIjsIl7wSkGDlGnxtMT/gpjYMo=;
        b=Zya45OWIGPC3ePckd3SycrwmYNwn03HkOHrw278mpPCxun1qgmI9rKRc3CRNDZ3X+g
         ZDRJ5VZImWE3Ysavbptc26RNMu3HGyvkElDo+nAuusGjoBN9xsWZdjFvECrB0ogZGiFN
         OTM8hXWCJQoAPwPglaoYR146fHsILsUWefVbdvUcnwqQPbA+SnpVj8YFyPm7Aq8Crhw5
         lN52WTHolRfVzf6xm+oC8t1bRllWoFsyqEuR4pXOI0ywJDM2G2dwnzPFFgV7Kv1kDX/0
         xkymVICUsZF9ESY/EAaya3lloCVk1sMdnAfkLZNOcor4/phoQalFyoNWQVqefuaE8b/s
         rQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5IfM6guW6B3RSJ1rsIjsIl7wSkGDlGnxtMT/gpjYMo=;
        b=jnauhj+jwkS2Ml8+7d8R5Lc4w0gg88IrR4/JVGBFMUWynfwFfqCXSFuNqwGi6/c4A3
         I0o8cMf8ZAwNE3bFHbXnKy1lbUg4gPIvr1jRYohoMEOOj0/ZR+fvp1o/a6lbNubKB0Z1
         9pi8VmUg6zKDIN5XJVPn9zhYlzZfCDDOpz/MYxCf29XiPRTGUwEpjXmORNg26vvtdWyb
         bTaqFblRbT2XuJ3G2GnxQ7wbhACrJaKI7SPFgiYGh08mkRYTug1yvmIVFgXJR0rqqqzL
         yrn2OMogzpjQOqBTmzYYgQKCzAhT1QpVveovTHP7rSpHsuhdbxyCoToMG1iCgbUv/cBM
         Aq1g==
X-Gm-Message-State: AOAM530hZ0MqLXu0M5qj0aixpHG/d1oX1+Dovq+LGzZqBOvPEhHeay2j
        XfwYxcLhj9Mvi6kSZlQjMu6W0g==
X-Google-Smtp-Source: ABdhPJxh+ge7ZHCwelFp9NqbRZRp0P2H0PweyY4nqCRDW2Yx6mWo1fwl5leh26kJfD52xlSQoS47jw==
X-Received: by 2002:a05:6a00:15cb:b029:156:543:8e00 with SMTP id o11-20020a056a0015cbb029015605438e00mr3855414pfu.65.1603290965340;
        Wed, 21 Oct 2020 07:36:05 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:4a0f:cfff:fe35:d61b])
        by smtp.gmail.com with ESMTPSA id y5sm2759196pgo.5.2020.10.21.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 07:36:04 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <john.stultz@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: [PATCH v18 4/4] overlayfs: inode_owner_or_capable called during execv
Date:   Wed, 21 Oct 2020 07:35:33 -0700
Message-Id: <20201021143533.115895-5-salyzyn@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021143533.115895-1-salyzyn@android.com>
References: <20201021143533.115895-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: John Stultz <john.stultz@linaro.org>

Using old_creds as an indication that we are not overriding the
credentials, bypass call to inode_owner_or_capable.  This solves
a problem with all execv calls being blocked when using the caller's
credentials.

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Fixes: 05acefb4872da ("ovl: check permission to open real file")
To: linux-fsdevel@vger.kernel.org
To: linux-unionfs@vger.kernel.org
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: selinux@vger.kernel.org

v18 - rebase

v17 - rebase

v16 - introduced fix over rebased series
---
 fs/overlayfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index b1357bb067d9..9ab9663b02d8 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -53,7 +53,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 	err = inode_permission(realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
-	} else if (!inode_owner_or_capable(realinode)) {
+	} else if (old_cred && !inode_owner_or_capable(realinode)) {
 		realfile = ERR_PTR(-EPERM);
 	} else {
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
-- 
2.29.0.rc1.297.gfa9743e501-goog

