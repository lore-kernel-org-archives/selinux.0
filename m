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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D75C07E9B
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7807A61C44
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhGFR5W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhGFR5W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA1DC06175F
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ch27so2767641edb.10
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GXzSwc3kOjwrGoieF8dJoOtvkZdbaczvdd+y7gCnqgA=;
        b=Kjgk5TfSNcOtr5DhYPV65HaJEdlLZDSHybMA3yR9fBP5f41+1E10F4ChMuxrwuQyA1
         Aeb8/hVdBVVLBWdWAdRbI92IjtD4uV9SkQUHTswtOmoCmMVIbRV6RKm/SOyXrf/1y22e
         8ptpkK1I/MPElcbnXR289Mx0FufpwMlMpmKe2zEz9/maJZCDMEDEaL8FSzxY4q7/xEXH
         yCbKydYcwIIlY9MobTXcpS2k+JO/lVnUu6RJeFoqYUiyddQ47p7yfdZQ4y8bcJfe8wNJ
         IBDtB+RfrIQhpG1mKMwXGxlFbYMMXNsN6SFOphYnG7upAJvNr/Jedmk97IrACphr4yEk
         /lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GXzSwc3kOjwrGoieF8dJoOtvkZdbaczvdd+y7gCnqgA=;
        b=QWxFpI3662QUOkNTfCvAiDA66zex749fsAX83iCnAnUBhZoDsCZZ9TFJBQONo0RgQH
         1nEDGqfwkXHLiQ2xjAGETwrtmU8lZ4gFX67Mfz9m2+g3UZVI6hpo+aUvOZpSUxC1FpLI
         DoqAuu0PuXW0VFB9xWA68HfKcdd7jg0vCXKtQMzoAJIHYMsXj5E3cJwztuNivEVEPDeM
         oKltZ4k9Gij+p68h7L7e8iyPbt5HKhfXAwQlyxoozOwkMXxnBToDUDWAJCp5+pnQJdwR
         hy8QzEDgOMq5bffb/f23+tv2kVXTlK0hLCQCpwW9XBz3KVu4U9g2BnBv7R+u5ld0V+r5
         +Spg==
X-Gm-Message-State: AOAM532PNyKe2jcuFU3BrHVuNX2khm/Eo4we59EvXxzA+fCSQb5T6zmJ
        UNDjamKx9iRi8jPiwCHFQUZOb2jvAOg=
X-Google-Smtp-Source: ABdhPJzp8zRj4+t95Pp8T1lhuyRJG1z9q99xvQY9g41e8e3A9iWRVMOkNojr5t96/pcK7SRyVV74zw==
X-Received: by 2002:aa7:dbc8:: with SMTP id v8mr24415104edt.242.1625594080821;
        Tue, 06 Jul 2021 10:54:40 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:40 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 02/13] checkpolicy: drop -pipe compile option
Date:   Tue,  6 Jul 2021 19:54:22 +0200
Message-Id: <20210706175433.29270-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706175433.29270-1-cgzones@googlemail.com>
References: <20210706175433.29270-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The compiler option -pipe does not affect the generated code; it affects
whether the compiler uses temporary files or pipes. As the benefit might
vary from system to system usually its up to the packager or build
framework to set it.
Also these are the only places where the flag is used.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/Makefile      | 2 +-
 checkpolicy/test/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index be63c018..f9e1fc7c 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -10,7 +10,7 @@ TARGETS = checkpolicy checkmodule
 LEX = flex
 YACC = bison -y
 
-CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
+CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -fno-strict-aliasing
 
 # If no specific libsepol.a is specified, fall back on LDFLAGS search path
 # Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index e2a332b5..8e5d16b3 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for building the dispol program
 #
-CFLAGS ?= -g -Wall -W -Werror -O2 -pipe
+CFLAGS ?= -g -Wall -W -Werror -O2
 
 # If no specific libsepol.a is specified, fall back on LDFLAGS search path
 # Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
-- 
2.32.0

