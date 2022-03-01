Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A03FC433F5
	for <selinux@archiver.kernel.org>; Tue,  1 Mar 2022 22:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiCAWxr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Mar 2022 17:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiCAWxq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Mar 2022 17:53:46 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC103122E
        for <selinux@vger.kernel.org>; Tue,  1 Mar 2022 14:53:04 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id bt3so120180qtb.0
        for <selinux@vger.kernel.org>; Tue, 01 Mar 2022 14:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=SC1zqStLObY/uHgTgUFRdiC38TmeX/tZsTT4bA6ZyYw=;
        b=zGIo1COzUFw1qX4auChD/wgtNutyhhE74M/WM43ASAFcqKuP8NXVYQT01uvcQNuyXv
         YcoMAmvLeNvb/ZFRa6ZKPr2G5IqFrzveTIoT7Ngh80J8SrgW2Ab5UcEZVXvwsae1A99w
         1lovi6Go2B94Cy+U9OoVt4dumTpJLZr0W220+3iLfiDsxIoXukh21+EAYKYZxCOZGjqd
         nw+6JRCJSXMMwwX2eafnVHw9VSZh5ZwiHq/Tjeu2Y0GUXk5HHezVmzXKezP6aAYDajVd
         LaOCiygiejDqR/IufXgF2XrDR+BHhFw97tCDkEoJJDTIh/Tvuq8nylBT+/pnr5mor5b2
         erKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=SC1zqStLObY/uHgTgUFRdiC38TmeX/tZsTT4bA6ZyYw=;
        b=ZWCOmomk1uKWsaiOqr96wCKl7cVxfw3v/4wBdggy3cGE3r5oKXmYaihYxkDJ3IklWk
         I8lzkO3Bj9VxYqJI8eI1s7Vf0zmuvWvgyhSizLePQWvu1SKrbBB0/t7m5HQ2peHaao0K
         ttlAtYYWecwsMqZXH/jW+DUa586vTv8PjiXf/pC22gtHZ2Po/4ZiQBlhTV9/KjCPQ8B9
         dQM19a1pKs/JygBkiOX3XersxsAKAgf0B65kMG8ukcrzMiGcvw+tnMcQ9U+6XzEV7XdR
         gpMXSl2fTg7M0FPW0iRbRh6tfEEy7P0ggf/sqh5WbnO+6jodEX06cNAagRuzvNjSaDJU
         14ag==
X-Gm-Message-State: AOAM5327c/FsbQlUTgG/irgOwtmTzU2T4tGiBt+2eEj8ZpZSWxcvpldW
        9/zPZiJPU0EfaPNLqUn8l7+csdbVKKeV
X-Google-Smtp-Source: ABdhPJyeAL9+ON+CumVNTmV2UMJ0IXkijOpTgPLeK7/2HWMkYrwEYgLEVfGrhApULYDlZJ7tTs3hWw==
X-Received: by 2002:a05:622a:1a14:b0:2de:6a6:d859 with SMTP id f20-20020a05622a1a1400b002de06a6d859mr22032507qtb.383.1646175182782;
        Tue, 01 Mar 2022 14:53:02 -0800 (PST)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id 141-20020a370393000000b00649498f69dbsm7426545qkd.91.2022.03.01.14.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 14:53:02 -0800 (PST)
Subject: [RFC PATCH] selinux: runtime disable is deprecated,
 add some ssleep() discomfort
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Tue, 01 Mar 2022 17:53:01 -0500
Message-ID: <164617518151.117500.8843073220563946007.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We deprecated the SELinux runtime disable functionality in Linux
v5.6, and it is time to get a bit more serious about removing it.
Add a five second sleep to anyone using it to help draw their
attention to the deprecation and provide a URL which helps explain
things in more detail, including how to add kernel command line
parameters to some of the more popular Linux distributions.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/selinuxfs.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f2f6203e0fff..3739155ee0db 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -293,6 +293,8 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 	 *       kernel releases until eventually it is removed
 	 */
 	pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
+	pr_err("SELinux:  https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable\n");
+	ssleep(5);
 
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;

