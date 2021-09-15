Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE28C433F5
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 16:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EE761216
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 16:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhIOQZi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhIOQZc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Sep 2021 12:25:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B86C0613D8
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 09:24:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g21so5704965edw.4
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8L1ObEbhewVu5Z9L+F5pzMdKDppRrP8OC4GS9huW5tg=;
        b=hR7XWEFYJgEALLGJNOqB0F2cbk7SgsXdibmukCsOBrXOfgnf0K1jW2SvX2W8/REsIJ
         j/Rg/9YB5rPc95AgYzWw0j+iyQB2RtyqAkHKJ23Xu4ZF+zFdeKhWCRMkbOGmKG24XlDZ
         u6M1qArSkDMmlqZb85Bm3o+SAAJwp1AKmqEYFsFVukvISgkszZV7lXZqyVCaNU6EoZmn
         oB2cwAo8GRULNHeVUExTW+dnyPGlyoOcC5lq7n5/FdAuj7jtRDrxVLPI+BqExSduzUyO
         c4F17gAIb9LgCuHFeSEtDNq3sVBXeRHXMEVI9oqh+gblLvWl/m4VACrWtAPMCNd53pYz
         SsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8L1ObEbhewVu5Z9L+F5pzMdKDppRrP8OC4GS9huW5tg=;
        b=JRS0IJPGGARh+HHWEtLFTeAxqbfC66cnIhwJ0ia5j2TGK6GM831QoX4bZo2FwyacOJ
         u2CUKnxUPR3o1r9DZhhW43oPBvXzwCXwmxM72tnypZiMZkAMBvfk3TrUjSQRTX6lqB+F
         ODPtjHyZWMiIiKzXnulWvGVFcVieKzOjv3QBBl2ij6gB/TVSeu+l0J5Mg3pfxzP4Fyft
         9Xy7t1O2JttmFV+32SWWv3xpSb1su96b/5yb7L1cw2txcfBBpX6hp7gTJcVbGF9A3fuP
         dSfzwuYkPKBmmFYKbDF3zCaQQI1y+3X5CfZdgsgbiHYbP55rXtvQIcVQ4mgXEv7p3kOV
         7nMg==
X-Gm-Message-State: AOAM532RU3S2rt9K9H+2k7Nigi8IfFF4XGFrPiM+i26v+UlzGNcA1hfO
        lHwV51ywYoKFowQT839BejibWYk6CSg=
X-Google-Smtp-Source: ABdhPJx3rntDXISX2moUzlJMKri4GvivfbdRy5GftVRFmTQIkf2r5ym+7Vo5NMfIYCfupTQ8U+7r1A==
X-Received: by 2002:a17:906:b46:: with SMTP id v6mr888926ejg.262.1631723038827;
        Wed, 15 Sep 2021 09:23:58 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-239-251.95.112.pool.telefonica.de. [95.112.239.251])
        by smtp.gmail.com with ESMTPSA id x25sm192699ejy.46.2021.09.15.09.23.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:23:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: enable genfscon labeling for securityfs
Date:   Wed, 15 Sep 2021 18:23:26 +0200
Message-Id: <20210915162326.392808-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add support for genfscon per-file labeling of securityfs files. This allows
for separate labels and therby permissions for different files, e.g.
/sys/kernel/security/integrity/ima/policy.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6517f221d52c..a18626424731 100644
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

