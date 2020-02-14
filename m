Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0882FC2BA83
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CC720848
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 18:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Q3A9850M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgBNSsB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:48:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39028 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbgBNSsB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 13:48:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so11780656wme.4
        for <selinux@vger.kernel.org>; Fri, 14 Feb 2020 10:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ydlgGRrBpiS8tKFc3JpzzUDdpOY4JEpAwQEJM6t6i7o=;
        b=Q3A9850M23eEW+LokOz4gBJvyp7uKrHoNbXvx9JjnIf0skAO/PxYg4xzEZn6/ZBnKu
         SzvgrxgJdNzCFLj2qJqjCODg6oRs3PAS98CAepooakHPhkfbLCDcliWMrot1rkMYhlTn
         9xzUQI1Av07fZa/yo52+qvHJmTtnU7m9zV64K7pXt0iA+r2Qw7H6tAsuZldzzLubz7l6
         eElqH31hhPRJwBGvujkwxIcpjm2B+iCAUlE751M2krB62OKR7+im8fbIijTBLpb4r3mh
         IEE+HJg6Hx2p0vRZHA1+1Rx5SORsbZ41hvVNelf9TbniqHJOQE/J73xIYkjzertXhgBw
         b6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydlgGRrBpiS8tKFc3JpzzUDdpOY4JEpAwQEJM6t6i7o=;
        b=UoH2W9JRgpz7uqT0zyFpUWt9gfGYSVPFmlr0LSa8HscNAsive6f1I5qe4q2OptT8Rq
         bWwg6zf5CuL7eYcQ38Bovk718RtD9zPShjav7ShKBkbxDPDOgTtJ02czq9igg6taIL+P
         VQZCK9EtINGOSBsSOOzxJfNnxAJTzjqVbfVdPZPQ7ZqdQ9JXVUMSNJ/gjObjVM1EjVQw
         z9ntgCwiAZChEJx9vYn+yaNDQDlzQrZkFCG7ixkdLRel2eC2umG8MKUsltMKmE8E3win
         53e1wgGd4/dEnHfokzfTjiGnTCPwPvXuXrsf2Q251NPX6FyQ7pLdKCxAhJKPqp7RDWWD
         K3Og==
X-Gm-Message-State: APjAAAX9ZAP6JiXf06BRc0lZDhisKCj+DKynSC3dSIVFYTDsNuHdSkW5
        URHSxlhl2+H0M/g1iEizOZKoPb1c
X-Google-Smtp-Source: APXvYqy8hA4PYKBAooNuh1GA+mWcVIoRMqBYvAuVO1zKcoR+vtuABF2401YPTLvr5zs6+UFWjSxu/g==
X-Received: by 2002:a05:600c:2944:: with SMTP id n4mr5939465wmd.22.1581706078802;
        Fri, 14 Feb 2020 10:47:58 -0800 (PST)
Received: from desktopdebian.localdomain (x4d03a90c.dyn.telefonica.de. [77.3.169.12])
        by smtp.gmail.com with ESMTPSA id f12sm8357261wmj.10.2020.02.14.10.47.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 10:47:58 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: drop error return from is_selinux_enabled documentation
Date:   Fri, 14 Feb 2020 19:47:51 +0100
Message-Id: <20200214184751.8211-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207143744.9944-1-cgzones@googlemail.com>
References: <20200207143744.9944-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since commit e3cab998b48ab293a9962faf9779d70ca339c65d ("libselinux
mountpoint changing patch.") for version 20120216 is_selinux_enabled()
does never return -1; drop mentions in the man-page and header file.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/selinux.h     | 2 +-
 libselinux/man/man3/is_selinux_enabled.3 | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 7922d96b..883d8b85 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -8,7 +8,7 @@
 extern "C" {
 #endif
 
-/* Return 1 if we are running on a SELinux kernel, or 0 if not or -1 if we get an error. */
+/* Return 1 if we are running on a SELinux kernel, or 0 otherwise. */
 extern int is_selinux_enabled(void);
 /* Return 1 if we are running on a SELinux MLS kernel, or 0 otherwise. */
 extern int is_selinux_mls_enabled(void);
diff --git a/libselinux/man/man3/is_selinux_enabled.3 b/libselinux/man/man3/is_selinux_enabled.3
index df62c225..a887b48c 100644
--- a/libselinux/man/man3/is_selinux_enabled.3
+++ b/libselinux/man/man3/is_selinux_enabled.3
@@ -15,7 +15,6 @@ is_selinux_mls_enabled \- check whether SELinux is enabled for (Multi Level Secu
 .SH "DESCRIPTION"
 .BR is_selinux_enabled ()
 returns 1 if SELinux is running or 0 if it is not. 
-On error, \-1 is returned.
 
 .BR is_selinux_mls_enabled ()
 returns 1 if SELinux is capable of running in MLS mode or 0 if it is not. To
-- 
2.25.0

