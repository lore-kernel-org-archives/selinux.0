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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA64C433E0
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0CC64E43
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 16:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhBUQF2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Feb 2021 11:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhBUQF2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Feb 2021 11:05:28 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4131CC061786
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 08:04:47 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jt13so25326099ejb.0
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 08:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+hVKPlQhE0KD5ArIF2XhQYoL24TLRbfMkh9Gvqh5+yg=;
        b=MGh8gjWv/lLab0/kyq2IcgN441NwuDq8N4BUXUlGZkorC8gFVzBEc/tZr0eTYsz26t
         buabBs2l76XYKe49jz3t9Td8rSBqtyuD0ck4fHt57luotubI5ok0p4oJ+z5OxRyuE2gv
         xlr7dI/mSxG0+NovrKqSKhZRB6NsPMV3uG4ZVDrgGwGUW/5xhCxhzvOlFzuwtLcs/Wl3
         LfgX7IO0ObT/eZNxrqVIY7bgDvIOqcqfeA67Zfe/vCuCBflP+lhhNclY0KiduhBRUdMA
         RJy5i6f7t9dOdifqYMiplEq6ozQUl54Isr/K9tRc4mukLmK2/ueoedrGfIiDHZOh6RaX
         S1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+hVKPlQhE0KD5ArIF2XhQYoL24TLRbfMkh9Gvqh5+yg=;
        b=kN1Kpk6C3zGx+amHsWQj5ciD43xhDhzEXdckz0VJdDu0TBkyXgMi//0Sv//pzrVNlV
         0sjMzAVMNC1MX8J87HKbowNqkJRA+8eHtzKa2XxlGvXJeCzYBXbRx6Bfzt2rFtzugBh+
         hIApB+BAEPmizybJulqVWLnsmDw/E2DDjUfZiSUCHJZek2r2teYYDpVukTI6Ngs+zH7k
         4iGRSOwISXkBbpD6WCMA9YoVBESxRWhJupC7IUXM3AEX3KYafKlJSX1zQJ91biERzwup
         KEN7ASPuMAPOsmJg9p0tCJaKWcnvwOjXTZSylTp0jOmv9kAquj1m9y834wlD9b0DCtNU
         PPqQ==
X-Gm-Message-State: AOAM532ceCrj11ynHkYitfOUvgPjfIwmpHmqR8GLFmC6BxUyXU/ZDl36
        eI8m7Z7eqKBLpgRQp++X/VTsKxoiQPdUbQ==
X-Google-Smtp-Source: ABdhPJzgIoV9RhbcDdZKeP4bntyfiBij6GyTQzN1GDDoMqKO2YymSzsoH30owAWW973Ul7y1E+4/rQ==
X-Received: by 2002:a17:906:ad90:: with SMTP id la16mr17028157ejb.42.1613923486071;
        Sun, 21 Feb 2021 08:04:46 -0800 (PST)
Received: from ?IPv6:2001:a61:3570:aa01:ed31:9d1f:3ad:d0a5? ([2001:a61:3570:aa01:ed31:9d1f:3ad:d0a5])
        by smtp.gmail.com with ESMTPSA id k9sm9779628edo.30.2021.02.21.08.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 08:04:45 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH v3] policycoreutils: sestatus belongs to bin not sbin
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        Petr Lautrbach <plautrba@redhat.com>,
        bauen1 <j2468h@googlemail.com>
Message-ID: <4f80b938-fb3d-ba0a-0c13-bfcfd76176f4@gmail.com>
Date:   Sun, 21 Feb 2021 17:04:44 +0100
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

Some tools hard code the old path, so a compatibility symlink is also
created.

Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
---
 policycoreutils/sestatus/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
index 8c4f45f8..3dbb792b 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -1,6 +1,7 @@
 # Installation directories.
 LINGUAS ?= ru
 PREFIX ?= /usr
+BINDIR ?= $(PREFIX)/bin
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 ETCDIR ?= /etc
@@ -16,8 +17,13 @@ sestatus: sestatus.o
 install: all
 	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
 	[ -d $(DESTDIR)$(MANDIR)/man5 ] || mkdir -p $(DESTDIR)$(MANDIR)/man5
+	-mkdir -p $(DESTDIR)$(BINDIR)
 	-mkdir -p $(DESTDIR)$(SBINDIR)
-	install -m 755 sestatus $(DESTDIR)$(SBINDIR)
+	# Some tools hard code /usr/sbin/sestatus ; add a compatibility symlink
+	# install will overwrite a symlink, so create the symlink before calling
+	# install to allow distributions with BINDIR == SBINDIR
+	ln -sf --relative $(DESTDIR)$(BINDIR)/sestatus $(DESTDIR)$(SBINDIR)
+	install -m 755 sestatus $(DESTDIR)$(BINDIR)
 	install -m 644 sestatus.8 $(DESTDIR)$(MANDIR)/man8
 	install -m 644 sestatus.conf.5 $(DESTDIR)$(MANDIR)/man5
 	for lang in $(LINGUAS) ; do \
-- 
2.30.1

