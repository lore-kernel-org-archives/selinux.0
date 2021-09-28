Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41878C433F5
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28FED611BD
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241542AbhI1Pl4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbhI1Plz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 11:41:55 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120F0C06161C
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:40:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y35so33797945ede.3
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JKJwRMmC9RQg7RmpZBcwxXbOx2bb3YryZItEDcm87Bo=;
        b=BGjGmNOO3YGYAcj3s40bj2uys6xOnXC6D8xOWsQ9MwYwn2q/ETe7AtYjSc0vCyQEkg
         G1LbD4fyMObinEv6t9+eAQu0Njbo19lZJI199W1PD86WvWdpixo7ON7dwXxObwmvjmGr
         EqYrMYuOLorFvGBYH5obSHPy+ltTYu+cPVb/CPXDjhSVkXApO+s3VqmzCifcT0l2NapW
         rOLgprFBvKvnmEVDCq/Q6lPySPYAbLvq5VXfAYsi6p5pworcxcIHhuB2yURHb/JXbCXU
         ZXa//EhylrurbUoLG0Z0xSEWUuG7lAJ6giwHZeKvceIQDlYQH5D0gZtFjqAVLvhDTo9r
         OSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKJwRMmC9RQg7RmpZBcwxXbOx2bb3YryZItEDcm87Bo=;
        b=bZC/j8mTMy+TogeuI5/ZcJuJs4rg5dtAW9KXWxPEfNME/5vXUJsu5qm9zFdkxbUdUP
         5H/G6M2giuPKfzvBosck9wckEalOHOiAa8iQx8pKSijBh+l5SOrpYJQNDgvuFJR7R50a
         tMwsgpVc9BOnrJ2KZaMunapdKIFtahGlD38tqRDXG2YdWibYfw3ayapWdMckXXG9OZqW
         81OkcER833eg5L2BtGuiNINYW3wUgnus/y8XZ9woEYsMfIQyba71k6ii5VAEqS260f4Z
         wKI2VsqwrtpDop/NLiMwVLzL+qorcRcNmCg7NP0y42goJ4//O/T78QzQRfETvQ4Iljp9
         BSEg==
X-Gm-Message-State: AOAM533VbqWPDyE/7h+JwzMVwSBEK/cm7lnhlgBvkIMsM1NKT1bgVDB2
        f04DpAKNR6s13Kg5MgW2DwIX/g44Vyg=
X-Google-Smtp-Source: ABdhPJzTN9pTSdSpLGZ+uQulcXwfiV5Slk9g/64r3H++H0evkxNjkrRqSrUiR7Ys3pWYbbN59/TovA==
X-Received: by 2002:a17:906:4f96:: with SMTP id o22mr7365658eju.169.1632843579528;
        Tue, 28 Sep 2021 08:39:39 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-152-081.95.112.pool.telefonica.de. [95.112.152.81])
        by smtp.gmail.com with ESMTPSA id l12sm2316399ejo.41.2021.09.28.08.39.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:39:38 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] selinux: enable genfscon labeling for securityfs
Date:   Tue, 28 Sep 2021 17:39:31 +0200
Message-Id: <20210928153931.9557-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915162326.392808-1-cgzones@googlemail.com>
References: <20210915162326.392808-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add support for genfscon per-file labeling of securityfs files.  This allows
for separate labels and thereby access control for different files.
For example a genfscon statement

    genfscon securityfs /integrity/ima/policy system_u:object_r:ima_policy_t:s0

will set a private label to the IMA policy file and thus allow to
control the ability to set the IMA policy.
Setting labels directly with setxattr(2), e.g. by chcon(1) or
setfiles(8), is still not supported.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - improve commit description


 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 012e8504ed9e..549f631e9832 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -760,7 +760,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	    !strcmp(sb->s_type->name, "tracefs") ||
 	    !strcmp(sb->s_type->name, "binder") ||
 	    !strcmp(sb->s_type->name, "bpf") ||
-	    !strcmp(sb->s_type->name, "pstore"))
+	    !strcmp(sb->s_type->name, "pstore") ||
+	    !strcmp(sb->s_type->name, "securityfs"))
 		sbsec->flags |= SE_SBGENFS;
 
 	if (!strcmp(sb->s_type->name, "sysfs") ||
-- 
2.33.0

