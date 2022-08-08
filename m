Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE8CC25B0C
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 17:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiHHRg1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiHHRg0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 13:36:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C020413E8B
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 10:36:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a89so12250389edf.5
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=FndC9WBXKlxW/+HjI+6NDeqk6tCbX5qNytGC6ksicaQ=;
        b=ps9gO0QB3cZNpKjBU0guhnvCMBDdYWQefnEybs/yC5mLu+IieCj/oO4IQaWvjnVj0C
         o/uFjZjwQn2PQJnuelbSLXstnMz34tE8tbXpdtaLmL7Oqpzt/dNBaUrvYwz0QrFv7OXO
         fhGYmqgo9+M5XbSdd7AZTJh4V9egtCjsZRWB9gzFDN/xUAKpQpugA4xQwvEr6croGoq/
         WEbFKvmLp/0Y2uTMXUctpYazgbPHMe1qdgHeglMV9//uHMTlZcIL71CZwLvQv8ga+gCs
         5QvjUtVgRGeZ9SIG6UjfdxMooNlIslPM1SaQ2PuoE4j6kvUl5nTf72ue5X2tpcxkexfX
         I7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=FndC9WBXKlxW/+HjI+6NDeqk6tCbX5qNytGC6ksicaQ=;
        b=LqLCAzy59BLJyx++tTI4yued+5MOURwyQbxKyuqHo0BFscfjO7ml0IwOVI33HjbdrD
         clgivvcGvrlrlr6GyTZgLSiVGY1V7zVGVN0pDrNFSgyiJBTqM/FBTUaT3sf6CIG/LVHG
         boUSQsrKzz5O9x7plNhxjAVWCaeLlpsv3a8TG505GK77fHH0Z3CuX2I+9j1VUKY6fKll
         g6pEH6KjSBqyMJhaVgIfvkolkDQ5IIWEwN5cCashy1SMgKmim41VQqGJF1aLsxu+I1zp
         Avy22VIqLHJv2gWYfQrNMCgMJaucI2XjHlHIDs5hz/sMO5Qu2hgRan+UxFSUsiZEOa9G
         Vb8w==
X-Gm-Message-State: ACgBeo1wyPzY/ozKNH6CwA13bFlYxCthFnaNH77OeOqPMdisSzzhYeHv
        NJzUzKy16gpownLqkQWEBITM5LuEQpo=
X-Google-Smtp-Source: AA6agR5W7dfTuxsXoWLp/F4N1mJwDDXRy595jJYNR4R+DMnpgsNRPxhBvnW/4hY3di59KtQHVEV+ag==
X-Received: by 2002:a05:6402:3485:b0:43d:7fe0:74d1 with SMTP id v5-20020a056402348500b0043d7fe074d1mr18682140edc.413.1659980184340;
        Mon, 08 Aug 2022 10:36:24 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-248-038.77.0.pool.telefonica.de. [77.0.248.38])
        by smtp.gmail.com with ESMTPSA id h14-20020a50ed8e000000b0043a2b8ab377sm4844027edr.88.2022.08.08.10.36.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:36:23 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] restorecond: use strict function prototype for definition
Date:   Mon,  8 Aug 2022 19:36:20 +0200
Message-Id: <20220808173620.16760-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808173620.16760-1-cgzones@googlemail.com>
References: <20220808173620.16760-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Clang 15 starts to complain about non strict function definitions:

    user.c:172:10: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
    int start() {
             ^
              void

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 restorecond/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/restorecond/user.c b/restorecond/user.c
index 47b86823..3ae3ebbb 100644
--- a/restorecond/user.c
+++ b/restorecond/user.c
@@ -169,7 +169,7 @@ io_channel_callback
   return TRUE;
 }
 
-int start() {
+int start(void) {
 #ifdef HAVE_DBUS
 	GDBusConnection *bus;
 	GError *err = NULL;
-- 
2.36.1

