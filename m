Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC942C00140
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 17:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbiHHRf4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHHRfy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 13:35:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48664F2
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 10:35:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t5so12198597edc.11
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=4fQ9B9qEpwwJQyv6wBpDhpiaSeiBC2jwD4rNbDThYHU=;
        b=g9t7+AHAm7xJLhXuRXN1WHYYHXbGxuxlvhVtI/5y4jEhQVtlTG/z/12jM8PGxuXgM6
         6iY4OW3j9x1oX+c2ghC6IG88Vgn2vaH9Kl+JLJNBM+4YTgzR1KHKFGdJjwGBX4f7xxdk
         XhEhzZxOhAQIB1TfTdFRCE/qSbRiGKS3ZvMX0RfrU8EwhKDhVIJb7IPnlc3TjFOpdF27
         1V1JcKFZf/0Rl9TIlx3VswdPI+8l6bcp1Ew/bw/8hSCDKgrZS50bdUw30lJhVkocegBl
         PYV1iGWUD0u2A7/ICyEGnJUM+qXgvREDKZ4r7Myk0KQP9G6OG3yL7+RUxIfx70L1Otxk
         hzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=4fQ9B9qEpwwJQyv6wBpDhpiaSeiBC2jwD4rNbDThYHU=;
        b=KBeB1wGT9J8ZgSlCyy3C8U6YPSmbATOBGX5XkMHeinb8dEOwpwR1z6qa3O2fSQokOx
         umgddWSr3FibQlC6q7D8jLDfVjpW6FwjZFDPItPntPB8ZDPErlphU/Rx5qDlnEhPTLdf
         cHXDqEUrfEiqtHzydBPXVUBf/TVJCBWH957WOpLS76PGOdzdBAcDerwijqSCUWuOlYo2
         Z+6ASZfn972M2XMeKMMsQ2VK54VqV6wOoC3w081IVRKMrlbeOoOoWPuk11elVupxGyfl
         tFHaLRrCJg4H8aUmeJ1dA0qWrrD60AfY7PRsxQtpehDhdvyNl9cvgquidgAP35Tuag9w
         XNQQ==
X-Gm-Message-State: ACgBeo2o5LgIxK/UwAptIBtn07JrOkc4xOAaB97sVeQ/JBjK2DGMQBaz
        1oRM/HnLPfv5shEUjJpd6lJsZ5wNCIs=
X-Google-Smtp-Source: AA6agR6CiHazJAF7ANSvrQX25KoeZSLgraS+h9uUhsjs76vwhagkKgs9zF9j8wM/Y+UGDRWPq1b3Rg==
X-Received: by 2002:a05:6402:42d5:b0:43b:5cbc:eeba with SMTP id i21-20020a05640242d500b0043b5cbceebamr18377859edc.3.1659980151814;
        Mon, 08 Aug 2022 10:35:51 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-248-038.77.0.pool.telefonica.de. [77.0.248.38])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906293200b0072af92fa086sm107844ejd.32.2022.08.08.10.35.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:35:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux/utils: install into bin PATH
Date:   Mon,  8 Aug 2022 19:35:47 +0200
Message-Id: <20220808173547.16638-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The libselinux utilities are mostly wrappers around libselinux
functionality accessing the selinuxfs, which is largely usable for
unprivileged users.
Install the utilities into the normal path to be found in scripts run by
unprivileged users.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 801066cb..739f2020 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -1,6 +1,6 @@
 # Installation directories.
 PREFIX ?= /usr
-SBINDIR ?= $(PREFIX)/sbin
+BINDIR ?= $(PREFIX)/bin
 
 OS ?= $(shell uname)
 
@@ -56,8 +56,8 @@ sefcontext_compile: LDLIBS += ../src/libselinux.a $(PCRE_LDLIBS) -lsepol
 all: $(TARGETS)
 
 install: all
-	-mkdir -p $(DESTDIR)$(SBINDIR)
-	install -m 755 $(TARGETS) $(DESTDIR)$(SBINDIR)
+	-mkdir -p $(DESTDIR)$(BINDIR)
+	install -m 755 $(TARGETS) $(DESTDIR)$(BINDIR)
 
 clean:
 	rm -f $(TARGETS) *.o *~
-- 
2.36.1

