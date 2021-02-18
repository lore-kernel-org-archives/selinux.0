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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9136C433E9
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 19:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9287C64E79
	for <selinux@archiver.kernel.org>; Thu, 18 Feb 2021 19:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhBRTUA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhBRSgh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Feb 2021 13:36:37 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEAAC061A31
        for <selinux@vger.kernel.org>; Thu, 18 Feb 2021 10:33:59 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id t11so7305612ejx.6
        for <selinux@vger.kernel.org>; Thu, 18 Feb 2021 10:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HZwVlj2Vkd9q7P10EUX2HGlsfyBSthfF69HL2iDPAgk=;
        b=dy51P1Xj68b6ii+FyjG1uMfc4LmTFCjTpBAQBthqA516GZ6niausc8HYFmfCQ0nf6H
         IBQYW5cKubNV0YQXv5RaRyHEX6Lm42ytbos+OXlJp50F2B43YptY7L5KIAlq4U7/eb5V
         BMAuqivBHhufU9BxfZd9n/0jEuPmHqvD5kz+Nrd00h8H4+FCwOgCVKC0+ZprmxnuKjYr
         YGCyHYw39fi27VWdwBjZEuOsVaOkho7vIR44O+3o1qvJIagImYc2/IdlqplI4b2B0C2f
         GYYqM+NgtmUMIbJXZwuq6yxCWqSSA1VeEH0G9sznKLY0BcLWeY4SjVIGJ3QU2nrZeqWI
         U10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZwVlj2Vkd9q7P10EUX2HGlsfyBSthfF69HL2iDPAgk=;
        b=m2NyamXsHiIeLPOzRl7RKwqDdAr+eOgXv57e73n8ZAoIbXNtWifL+GM4Gif29p21ik
         4ZCBDwglkwPLfPx10bIbdNVHK/a2gg1KksHvSn6KhXLLXlCUnNC8HqKxCKZf7S+/BghU
         e9wHof+YvcHy26VZngEdloujf4R4WD/lC3UYcv7+sAJ21OdKq55dYzR4Xakp7C9cxg2T
         OGf2GEge2SDWc36hxY89Jx4W24ZzRfPmhQ9igIMpDFRxhidWHdeJiRIBGly3e/JweVT1
         Ew4BbSXF5zn0vJxHDE7TmW6C5e+KjEtfMn+l0pjBrfRA4FYn6y4M8a3xudTo3+BeYZch
         WKjA==
X-Gm-Message-State: AOAM531z920Ph72QGTI9Q+KbGin1welW5MOyArHr06kwF76IEMsjT6t/
        RhaW/+Xz7vJplTBFC2uhtRc=
X-Google-Smtp-Source: ABdhPJyrJjcZxDesGLEPiPnsiGEYTq6LKjFNmfOn0JPI77axB4py6mR/MxFSKhugKa2BVmivTN3KYQ==
X-Received: by 2002:a17:906:240c:: with SMTP id z12mr5304405eja.314.1613673238061;
        Thu, 18 Feb 2021 10:33:58 -0800 (PST)
Received: from ?IPv6:2001:a61:3570:aa01:ed31:9d1f:3ad:d0a5? ([2001:a61:3570:aa01:ed31:9d1f:3ad:d0a5])
        by smtp.gmail.com with ESMTPSA id y21sm1127032ejj.31.2021.02.18.10.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 10:33:57 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH v2] policycoreutils: sestatus belongs to bin not sbin
To:     selinux@vger.kernel.org
Cc:     bauen1 <j2468h@googlemail.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
References: <CAJfZ7=keAs69Az0O8jkdfkAPvAYjQ=pqzV=t+ktLQ2KqU3Y6jQ@mail.gmail.com>
Message-ID: <a88cc4b7-273d-6d1c-6b63-06b139442878@gmail.com>
Date:   Thu, 18 Feb 2021 19:33:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=keAs69Az0O8jkdfkAPvAYjQ=pqzV=t+ktLQ2KqU3Y6jQ@mail.gmail.com>
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
index 8c4f45f8..e108f96f 100644
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
+	# Some tools hardcode /usr/sbin/sestatus ; add a compatibility symlink
+	# install will overwrite a symlink, so create the symlink before calling
+	# install to allow distributions with BINDIR == SBINDIR
+	ln -s ../bin/sestatus $(DESTDIR)$(SBINDIR)
+	install -m 755 sestatus $(DESTDIR)$(BINDIR)
 	install -m 644 sestatus.8 $(DESTDIR)$(MANDIR)/man8
 	install -m 644 sestatus.conf.5 $(DESTDIR)$(MANDIR)/man5
 	for lang in $(LINGUAS) ; do \
-- 
2.30.1

