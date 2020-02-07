Return-Path: <SRS0=TwHm=33=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F14CC04EB5
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5523121741
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 14:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hMCbcBCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgBGOhy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:37:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37643 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGOhx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Feb 2020 09:37:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so3044363wmf.2
        for <selinux@vger.kernel.org>; Fri, 07 Feb 2020 06:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtrYDgCH6hh436xXc6nmTI2p9Jfl2D0sejcWpGKKjxY=;
        b=hMCbcBCQtUrivRy/hPxpTnDX0whIXtUsdB6569ufDZbtUBfxCmi4F0vnv8JN0Cncfq
         pDXDIDa6c/RjXIATD0C+LjNe1TKXpGStCCz/L0xM2rFZLTYhwFC96nyQfplqymfadKoZ
         BDJidmuBMdlijb5pP43o9HKu2FmdhDkzGdDQweHznBj88qaoSjk7eyg6BgRKSQF+hf+8
         VH0HtVYr8cTSTAgLu0TXjjHDJwze8r0kGcuYMkTugpMWcagk8sbiZeC2rRCdLeCHFXrx
         Xn/5Jpft6Cd8YVc6oNekJUhANlckkW2FhOAQFnNHBnN4WEN6wvYh7kep+8eBxkOJF0QX
         EkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jtrYDgCH6hh436xXc6nmTI2p9Jfl2D0sejcWpGKKjxY=;
        b=ffqWvnet/yXxbRcTcLK9yjFAIaZsNkgaW1gIqohGZgR1P3FVv7RK+6zvSUO/FcP2sf
         tuwlaazSFSYo8R8aZOPqzCxklNK9aiRYAFCP70DSt02yjOV6iPv0l+EGGO+TbwTWEC71
         6sRZ52J/JyqMZTcosd3Su3OqCexgr2TFGPNHK6I8azStf8+HCjjq2jPI4shytMWqDRJt
         6KELFf1X85MVi21r3vCBGhashfGO8F7C6D7HO+Zt7OXWTc97XNKEflncqWCuOAKmk0B0
         j1Jhwo0L0h8+9O5sIPM0hbkoK+PTj4L3wmpx/NyIWyPIEHJVB5g/MqDG1fSnJq4BB5Zh
         qnYQ==
X-Gm-Message-State: APjAAAX9eJGf8Zv7OfZZPp6aF2ZSz9CQujH00fSvROiiLX2TagfY7rZo
        JqqWUBbdi5ACj511IkHgDdTI6ezs
X-Google-Smtp-Source: APXvYqxL7KiBl/5NUD1jmPR9KFKiNdhZy3LJ6bkMki5eOzpU2J9rHPNejcCaEKduo5/DoOrNUDwl7w==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr4815187wml.110.1581086271461;
        Fri, 07 Feb 2020 06:37:51 -0800 (PST)
Received: from desktopdebian.localdomain (x4d0aee2e.dyn.telefonica.de. [77.10.238.46])
        by smtp.gmail.com with ESMTPSA id s8sm3590729wmh.26.2020.02.07.06.37.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 06:37:50 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: drop error return from is_selinux_enabled.3
Date:   Fri,  7 Feb 2020 15:37:44 +0100
Message-Id: <20200207143744.9944-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

is_selinux_enabled() does never return -1, do not say so in the manpage.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/is_selinux_enabled.3 | 1 -
 1 file changed, 1 deletion(-)

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

