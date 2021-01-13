Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4D7C433E0
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 02:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545BF23343
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 02:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbhAMVOr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 16:14:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728960AbhAMVOR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 16:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610572441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnhyG9u4hQYDPkbAHWeYwbGqmeC/GOjZ3EmrZsNzI5Y=;
        b=UtSLcQ54QrI0T5lTgMmr52O74ijm5gpZJAiDUdrnbviC4Pz4ixsiNdhiCKQpNC7AiLOqkO
        +JoekuY6ZSN8jawXvVa2zajNU//jJ5Pu5W5ziGFES3szmvbqM3OJhAjkPUPmyAkLAJ5tyl
        1lQCtU0vnEbQzy/IGpwrhb/HcwYSeLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-OxPMIX74OOCBW-KlNJhh1Q-1; Wed, 13 Jan 2021 16:09:57 -0500
X-MC-Unique: OxPMIX74OOCBW-KlNJhh1Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54CEE806661
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 21:09:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 850A160D08;
        Wed, 13 Jan 2021 21:09:55 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 2/2] setfiles: drop ABORT_ON_ERRORS and related code
Date:   Wed, 13 Jan 2021 22:09:48 +0100
Message-Id: <20210113210948.217575-2-plautrba@redhat.com>
In-Reply-To: <20210113210948.217575-1-plautrba@redhat.com>
References: <20210113210948.217575-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`setfiles -d` doesn't have any impact on number of errors before it
aborts. It always aborts on first invalid context in spec file.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/setfiles/Makefile      |  3 ---
 policycoreutils/setfiles/ru/setfiles.8 |  2 +-
 policycoreutils/setfiles/setfiles.8    |  3 +--
 policycoreutils/setfiles/setfiles.c    | 18 ------------------
 4 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index bc5a8db789a5..a3bbbe116b7f 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -5,8 +5,6 @@ SBINDIR ?= /sbin
 MANDIR = $(PREFIX)/share/man
 AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
 
-ABORT_ON_ERRORS=$(shell grep "^\#define ABORT_ON_ERRORS" setfiles.c | awk -S '{ print $$3 }')
-
 CFLAGS ?= -g -Werror -Wall -W
 override LDLIBS += -lselinux -lsepol
 
@@ -26,7 +24,6 @@ restorecon_xattr: restorecon_xattr.o restore.o
 
 man:
 	@cp -af setfiles.8 setfiles.8.man
-	@sed -i "s/ABORT_ON_ERRORS/$(ABORT_ON_ERRORS)/g" setfiles.8.man
 
 install: all
 	[ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
diff --git a/policycoreutils/setfiles/ru/setfiles.8 b/policycoreutils/setfiles/ru/setfiles.8
index 27815a3f1eee..910101452625 100644
--- a/policycoreutils/setfiles/ru/setfiles.8
+++ b/policycoreutils/setfiles/ru/setfiles.8
@@ -47,7 +47,7 @@ setfiles \- установить SELinux-контексты безопаснос
 проверить действительность контекстов относительно указанной двоичной политики.
 .TP
 .B \-d
-показать, какая спецификация соответствует каждому из файлов (не прекращать проверку после получения ошибок ABORT_ON_ERRORS).
+показать, какая спецификация соответствует каждому из файлов.
 .TP
 .BI \-e \ directory
 исключить каталог (чтобы исключить более одного каталога, этот параметр необходимо использовать соответствующее количество раз).
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index e328a5628682..4d28bc9a95c1 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -57,8 +57,7 @@ option will force a replacement of the entire context.
 check the validity of the contexts against the specified binary policy.
 .TP
 .B \-d
-show what specification matched each file (do not abort validation
-after ABORT_ON_ERRORS errors).
+show what specification matched each file.
 .TP
 .BI \-e \ directory
 directory to exclude (repeat option for more than one directory).
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 10692d6d94a0..92616571ef2a 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -23,14 +23,6 @@ static int nerr;
 
 #define STAT_BLOCK_SIZE 1
 
-/* setfiles will abort its operation after reaching the
- * following number of errors (e.g. invalid contexts),
- * unless it is used in "debug" mode (-d option).
- */
-#ifndef ABORT_ON_ERRORS
-#define ABORT_ON_ERRORS	10
-#endif
-
 #define SETFILES "setfiles"
 #define RESTORECON "restorecon"
 static int iamrestorecon;
@@ -56,15 +48,6 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
 	exit(-1);
 }
 
-void inc_err(void)
-{
-	nerr++;
-	if (nerr > ABORT_ON_ERRORS - 1 && !r_opts.debug) {
-		fprintf(stderr, "Exiting after %d errors.\n", ABORT_ON_ERRORS);
-		exit(-1);
-	}
-}
-
 void set_rootpath(const char *arg)
 {
 	if (strlen(arg) == 1 && strncmp(arg, "/", 1) == 0) {
@@ -97,7 +80,6 @@ int canoncon(char **contextp)
 		*contextp = tmpcon;
 	} else if (errno != ENOENT) {
 		rc = -1;
-		inc_err();
 	}
 
 	return rc;
-- 
2.30.0

