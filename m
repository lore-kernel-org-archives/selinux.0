Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E817C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 16:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF1F20838
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 16:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyuD9ZeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgBFQzf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:55:35 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:38503 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFQze (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 11:55:34 -0500
Received: by mail-pl1-f201.google.com with SMTP id t17so3553926ply.5
        for <selinux@vger.kernel.org>; Thu, 06 Feb 2020 08:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c8SLYwNN21iArK53Veq5gkGT51jTwqTXEnO7G5w7whE=;
        b=tyuD9ZeMbgadQgpQK0RzWWuMzIWdE4+SLbg1hGyrL8AfJx/KN5gUSIAx6bfGQdJ7jN
         BAaUbzZ6e0vCdULGSjGGHtl+0dFj3fGsfKFu6rwa9P3mBUR5QhmtcNnK9B8cu4XdADLb
         NhRAEntU1RCmd4desA/YqzSbh0dIFNuuEOwUf71c7KmnrRexJtqx1aI6Dp3SM6TZNbiQ
         SOi+jXpX9jVICA1lea4p6WO6EalU/2sOgjUMZF6TglIZrDKw154wJjGzBqNmK4fDrsCM
         os6Hf5fFCAkt3KYs9ltaKfI925eqbGvv6y8t6HBTUCRd2GEcH8wxQiMuUBSe1jQkMDWa
         v+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c8SLYwNN21iArK53Veq5gkGT51jTwqTXEnO7G5w7whE=;
        b=A8KsaJiKxt0cBZG9dfK2f48IoNoeFO7efsNLM+ibHZQfWONvQw1FkpvhitGQ4tu0BK
         fLMprBqkiLZlXuA2nPaMmEg4eBQRe+1sCNA0/mY+UETJJfgtfv9PYR4ONf0e7+1VcsEn
         ZO/T+gxCU3geO0QQCEgP+CXHs2p6LmGQLqH7zUaWz7LKNOrH6Wc9KnCW1r0jOV+ncPom
         sVbE4EsL/9oY8JoIbYDBaciHnuDK1iDuo5YSl/oUCWdNmPast7mJfx8TJ1PJVS1CPSFj
         FtXTlj4EEaV3xIXITNGgNCFpTEx07zqhinVCCJYZO9xQ/O1aRpUHyPnAs/oiGKEX8vSL
         49eQ==
X-Gm-Message-State: APjAAAU1oykW0Ia+N/t+31sbmGuqf3X0H2O/s2kUqfKg9eWjmPiPKm2U
        ROebT16Aif8jNlGc3RAwT4LnLicgUOxD/Fc=
X-Google-Smtp-Source: APXvYqyDb5yj5Im25+WkOnV2M9Efe6GdsgMRA6RJp2TP5qJAxvkVPYUOcnstoWbfHRY6qOD/CEf6fuJnYxqPXvM=
X-Received: by 2002:a63:e042:: with SMTP id n2mr4883228pgj.308.1581008132761;
 Thu, 06 Feb 2020 08:55:32 -0800 (PST)
Date:   Thu,  6 Feb 2020 08:55:27 -0800
Message-Id: <20200206165527.211350-1-smoreland@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] security: selinux: allow per-file labeling for bpffs
From:   Steven Moreland <smoreland@google.com>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Cc:     "Connor O'Brien" <connoro@google.com>,
        Steven Moreland <smoreland@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Connor O'Brien <connoro@google.com>

Add support for genfscon per-file labeling of bpffs files. This allows
for separate permissions for different pinned bpf objects, which may
be completely unrelated to each other.

Change-Id: I03ae28d3afea70acd6dc53ebf810b34b357b6eb5
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: Steven Moreland <smoreland@google.com>
---
 security/selinux/hooks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index de4887742d7c..4f9396e6ce8c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -872,6 +872,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	    !strcmp(sb->s_type->name, "sysfs") ||
 	    !strcmp(sb->s_type->name, "pstore") ||
 	    !strcmp(sb->s_type->name, "binder") ||
+	    !strcmp(sb->s_type->name, "bpf") ||
 	    !strcmp(sb->s_type->name, "cgroup") ||
 	    !strcmp(sb->s_type->name, "cgroup2"))
 		sbsec->flags |= SE_SBGENFS;
-- 
2.25.0.341.g760bfbb309-goog

