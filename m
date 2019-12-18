Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AD0C43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD6C218AC
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HLR7MUmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfLRO2U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:28:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35974 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfLRO2U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 09:28:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so1822133edp.3
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 06:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W1Al8laKqTBnlCOuNkd2XM0GKZObd13+4VWXRSzym8Q=;
        b=HLR7MUmKfXLGteR45I7o+Hp7y4z2NlM1uJGBBnJmVn28tojRNR7bDzF5ElJq8OzEIE
         Jm2TcBjhAXf1jmPWuxvTu+wHBTY4GYIn7P4CT7Q3jV5QDi/llKJYz4Ijo3hzl5Jwf9Oh
         yhfzi9HhwWotrUWewIe9GOYwoFBGzHG2Ve7W/7DTQyGZ83UZMLyZY/1GwZSp8ncPKM4k
         5Ak6as8/lKdpRWdIZaqWpb5Kkr9YjE85qw+vh4Tg/HC42zfTZ8bAlZoPRF0HWSqZalOA
         cawg2ueh0ao2FNCNs2Q2g4V+/zZdfDPdUefwsPyITKzER1gcAvo3nd84ysCcbnzMsa47
         Uhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1Al8laKqTBnlCOuNkd2XM0GKZObd13+4VWXRSzym8Q=;
        b=eLZiYqdhJb8nzlBBoeoOGZjXwBeISOT+mdafof0xtlHqYFM5j7UUOIMDLbqOKM7/pQ
         aCwbwmlsF6+rMcNdhOZmsRF/N7/0JMhbBhUZwQ7HD78y/PyzRAvelgSpThnACPwyc4sd
         2az3qwQaUZ0HPLQFbwm0fib2i4naV831tmm62V30cdz5fDKDTQP8Ae8Nf1XG60ykoxvX
         UpBCo/pPrrv1vJWMRExIEZcdddFd827olWoHdnl1aM3JdDNfQG1txmsskjw/Pjl7tF06
         eH9laR+j6wX5+aDUJI2JPjFvK+RfMTJszUjmE5VTGLdrzQ4QDH9IVY0LNeZbXGGvuQ2V
         s1qA==
X-Gm-Message-State: APjAAAVyE/9XOFhVXmavI1NeBDREaQzPfGr3TGE8SKYQcgEjtD0vcUIi
        6gf2Rc2R/uDxDVndlrr/DVYzJAvt
X-Google-Smtp-Source: APXvYqytV7ZrNCqeBck2CusxPd7OgeBbPrRi81cYka9zBDaSWGmVY36vsW3UJRfW6KGNyYK7LFsVNA==
X-Received: by 2002:a50:9b0b:: with SMTP id o11mr2706108edi.78.1576679298244;
        Wed, 18 Dec 2019 06:28:18 -0800 (PST)
Received: from desktopdebian.localdomain (x4d015122.dyn.telefonica.de. [77.1.81.34])
        by smtp.gmail.com with ESMTPSA id mh16sm96826ejb.46.2019.12.18.06.28.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:28:17 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 2/8] selinux-access: log warning on context acquisition failure
Date:   Wed, 18 Dec 2019 15:28:02 +0100
Message-Id: <20191218142808.30433-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218142808.30433-1-cgzones@googlemail.com>
References: <20191218142808.30433-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Relevant when testing in permissive mode, where the function does not return a failure.
This helps to configure a system in permissive mode, without getting surprising failures when switching to enforced mode.
---
 src/core/selinux-access.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/core/selinux-access.c b/src/core/selinux-access.c
index 9fd3099fea..4500e4452f 100644
--- a/src/core/selinux-access.c
+++ b/src/core/selinux-access.c
@@ -223,6 +223,7 @@ int mac_selinux_generic_access_check(
 
                 r = getfilecon_raw(path, &fcon);
                 if (r < 0) {
+                        log_warning_errno(errno, "SELinux getfilecon_raw on '%s' failed: %m (tclass=%s perm=%s)", path, tclass, permission);
                         r = sd_bus_error_setf(error, SD_BUS_ERROR_ACCESS_DENIED, "Failed to get file context on %s.", path);
                         goto finish;
                 }
@@ -231,6 +232,7 @@ int mac_selinux_generic_access_check(
         } else {
                 r = getcon_raw(&fcon);
                 if (r < 0) {
+                        log_warning_errno(errno, "SELinux getcon_raw failed: %m (tclass=%s perm=%s)", tclass, permission);
                         r = sd_bus_error_setf(error, SD_BUS_ERROR_ACCESS_DENIED, "Failed to get current context.");
                         goto finish;
                 }
-- 
2.24.1

