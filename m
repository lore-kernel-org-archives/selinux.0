Return-Path: <SRS0=4SPy=7P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84796C433DF
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 12:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C646206A2
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 12:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sJXtjDBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFBMsE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMsD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Jun 2020 08:48:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFB3C05BD43
        for <selinux@vger.kernel.org>; Tue,  2 Jun 2020 05:48:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b11so10476405qtt.3
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2020 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=h6k3xqd8pEo9ERkQ/sC0uZaOhnwyrdluZ2TAAs5gC1c=;
        b=sJXtjDBu8/tS/XDineD7LQrAM5HLJWRdpdOoTY8WKWIhw9ffB8Z2JA8+pcBLHMtHcd
         nDUBm4NxuF2eYydr8UemxLuLveFYqUfzphDYCUd/aZxcF+SQCyBCXT5DFg0MK9PHSIA7
         UUn+p1vZF7Q9j96yYUIRDGQ4qeJnvF3W2XqGWuY9gKoZZTCvf7WIuxeK7TgluQhJBLR7
         QCmg7EyikDBh1VnyCAoNVHCHpjvnhT3LNaF+hs0HG4ImmnI5dJ0VKlN4lzMhQpJbYidM
         twArsQqjjTIrRFGHIIHVbbDrtPRGukfuKhiDHiaEXcvo0ut2rvimKV4hTYA6ilGMhIfo
         JMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=h6k3xqd8pEo9ERkQ/sC0uZaOhnwyrdluZ2TAAs5gC1c=;
        b=DDIV8SY9KcZOfmrrrVHRnAHSiRGHkBNHegJ79Dc4txe1Fqc1t9fT2pUtEporPVhIrA
         2kBJUYqSuM2moajv4OSDYbN1MjUTo6LCHmnT6sB0EqPphd5quQUmfr3UIC15W1+/rQ/Q
         gnX7mjeIAIpg55JoJtyyyNvZZa2o0L7b6wZiR68AiqS5ufUbZ7eJJAnfeNkSKw8CchG6
         FLQnCTBjVk8P0cTgzKr9aTXqHJ9HU/871Cby8j5qRZLzCIUy34Ly5IQVow8bVIMy5gRG
         DGYBSk3T+MjefiYu+wCeDaZFN+tJYWbl+Jlmn9rxbFTcHCjY72ZRnp3Vs71HNUALBB24
         JEKw==
X-Gm-Message-State: AOAM533hT7umP7AtN6vm+/m7lrFUEaXCPwgPuV+3GdxvtT/WuEBijnfI
        SlYU6i9HHuU9jUc4hJ3R4syo718WLA==
X-Google-Smtp-Source: ABdhPJywaKNrVZaQtAUU8BcS3WZb8Hb69xL0J5XALE5xG61wvClpzMF6fNKtEF7UYszRd9Alhs2qPw==
X-Received: by 2002:aed:3889:: with SMTP id k9mr27761879qte.347.1591102080289;
        Tue, 02 Jun 2020 05:48:00 -0700 (PDT)
Received: from localhost (pool-71-245-238-133.bstnma.fios.verizon.net. [71.245.238.133])
        by smtp.gmail.com with ESMTPSA id f43sm2737210qte.58.2020.06.02.05.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 05:47:59 -0700 (PDT)
Subject: [RFC PATCH] selinux: runtime disable is deprecated,
 add some ssleep() discomfort
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Tue, 02 Jun 2020 08:47:58 -0400
Message-ID: <159110207843.57260.5661475689740939480.stgit@chester>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We deprecated the SELinux runtime disable functionality in Linux
v5.6, add a five second sleep to anyone using it to help draw their
attention to the deprecation.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/selinuxfs.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4781314c2510..07af1334d9c9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -30,6 +30,7 @@
 #include <linux/uaccess.h>
 #include <linux/kobject.h>
 #include <linux/ctype.h>
+#include <linux/delay.h>
 
 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */
@@ -287,6 +288,7 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 	 *       kernel releases until eventually it is removed
 	 */
 	pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
+	ssleep(5);
 
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;

