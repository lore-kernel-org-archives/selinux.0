Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72039C433E0
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 20:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3876C64E35
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 20:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBMUoA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Feb 2021 15:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMUn7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 13 Feb 2021 15:43:59 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F789C061574
        for <selinux@vger.kernel.org>; Sat, 13 Feb 2021 12:43:19 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u16so2810582wmq.1
        for <selinux@vger.kernel.org>; Sat, 13 Feb 2021 12:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7iwU5bCzAJQLEQMbPqLfQceTv6Q2lSfs6byFoMWhOjA=;
        b=hn+5n3vZ4VwM2QEx72QL2s7Vm1ocUN7kQkv59U34rzSPTcneiDwzch7e4MV20Cea60
         6vX+Mx64IUGGKobOc7FTObd+33iO7DxJa2WSbGNOCFxk9nG7QB7RxG97R7peNlUMfSrT
         G+mLWRrdGzwJR8kTuOZq5p39N7ZoBx6/C/SwygsfiNIFz11DA8d22sOc153Ya01Z/1fh
         gnhCQTgqUwqCxJcxgP6W/sTlyixuCO5ZjE5pOtEd9VduHMWGj0cVNMRc6YXdwq7LzUDV
         V44Pd1IL+1sP4Nf+dcgJUFoqia/tasP+a6IDVDmLYYVBYSgXYuP3Glq3xJ5AOyFt3DFI
         Fo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7iwU5bCzAJQLEQMbPqLfQceTv6Q2lSfs6byFoMWhOjA=;
        b=PY4cEqT3ilf/oj+olaEMHTuKkCBvTscr9lW8K1IVAj8qtmAInV3CLdeRDwah5xbC/u
         wn8jPD0bsN5kE71KaKWbqxSgtiJqJAQloFBK1lc27pThk0RRlO4eYceTp6V1sj/EA122
         fcIZX2Nbe1OUzAZb84aPU6+ZJFnqKX4POzjFN/TkhlNOUKamrpsE1/CFt3TpGOuOdT1F
         11K6OitnhCpmfimPFBoD3+FZd5SSSGfg2N9kTgC/fw2naZSpAg185p2eF5IAXRq8yGfV
         pqqizb0piKknwuVcC+N++MzmMD8/qd9Bs8pjsEfMlfYvO6IIEZA52v6Xj9gclATruM1k
         C1lA==
X-Gm-Message-State: AOAM532D7co2WcgJjToL1EOW1dzGBZiOgyH818UtvS/HI4qJBxdTI6bg
        0KKink3u7gXgwP7GoV+1CXE=
X-Google-Smtp-Source: ABdhPJy7yYJfT24Cr2N8NHBEfQcIhs9P+2WD4osCp9DksoXu9hWIJjY/RefbeiGIgi/DatrvYYE+eg==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr7888571wmb.134.1613248997793;
        Sat, 13 Feb 2021 12:43:17 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id c6sm12923612wrt.26.2021.02.13.12.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 12:43:17 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH] policycoretuils: sestatus belongs to bin not sbin
To:     selinux@vger.kernel.org
Cc:     j2468h@googlemail.com
Message-ID: <65111b4f-23b9-6758-9cd6-d2f8429916fb@gmail.com>
Date:   Sat, 13 Feb 2021 21:43:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It is quite useful even to non-privileged users and doesn't require any
privileges to work, except for maybe -v.

Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
---

 Only tested by running `make DESTDIR="$PWD" install` and checking that
 sestatus ends up at /usr/bin/sestatus

 policycoreutils/sestatus/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
index 8c4f45f8..ac113814 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -1,7 +1,7 @@
 # Installation directories.
 LINGUAS ?= ru
 PREFIX ?= /usr
-SBINDIR ?= $(PREFIX)/sbin
+BINDIR ?= $(PREFIX)/bin
 MANDIR = $(PREFIX)/share/man
 ETCDIR ?= /etc
 
@@ -16,8 +16,8 @@ sestatus: sestatus.o
 install: all
 	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
 	[ -d $(DESTDIR)$(MANDIR)/man5 ] || mkdir -p $(DESTDIR)$(MANDIR)/man5
-	-mkdir -p $(DESTDIR)$(SBINDIR)
-	install -m 755 sestatus $(DESTDIR)$(SBINDIR)
+	-mkdir -p $(DESTDIR)$(BINDIR)
+	install -m 755 sestatus $(DESTDIR)$(BINDIR)
 	install -m 644 sestatus.8 $(DESTDIR)$(MANDIR)/man8
 	install -m 644 sestatus.conf.5 $(DESTDIR)$(MANDIR)/man5
 	for lang in $(LINGUAS) ; do \
-- 
2.30.0

