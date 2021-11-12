Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F89C4332F
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AC760296
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhKLPpE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbhKLPpE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 10:45:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7FEC061767
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:13 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t18so19894848edd.8
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=01k59ErtnpXUonzYLl2IvtmRKPZ7C13OJe8usqouAM8=;
        b=Whq0b2BcPDdiTSuBReAfJbZ9TKbPPDvBNxRyGqszwAocBqfvWjPXWUgJ2oGWjQeRcy
         JTKFu8vkKUwWILOQ9i+QDoFumNRvZ4QlHDHzBxIj867h5SMxvi7QubNuzdVMmMu0iQAQ
         ci0WMTpzb/AiYo52o6HyivZ6k2svgMoFjUAVD+fRTVFsr5gYloTtRDphb4jfSRTv1rFG
         7Qy/BpJrI4LIPYQ0sK7Y9oU+q2XKV/k2bTHEx/fHljBiopqxt5T8AdxRcr6royQFrh4k
         obkk7k3rkqplMVLPkBVsp+K25rEhucUCkL3y7NhtQtJks8cAjE6kxIlwsGpqt9WoLAog
         VIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=01k59ErtnpXUonzYLl2IvtmRKPZ7C13OJe8usqouAM8=;
        b=k5TLetCTVDal+xlew6Os0qwH/C0RgqCH63BRBbyaQ/5WstGOcrDacYotgtcvKEJe2o
         QrwwlMUbUVoYLztZB5/MirYsDW8UmEHlRzw7qjv47UJEs3eJ1HUEY0D+S4GYMOUujJA6
         OBOIN8r0FyZDsQxQqZ+SLlKuKzHytc1K97QItpJ6xO97wNmmK7Dm2kUk7IAReM3gkgoc
         qNTgpnSInYrhrtJLZE1RfXK/+MMxqYRQh/C4RiIvTuanzkvP6ZGqAU74ENTZMNy0Y611
         D9DkNCU5ozMUWqZWeeKUoMFUpUZNIaVwQX3ygergdmq+wpHtOIXUvCCw2KmU8xT1oacn
         FQXQ==
X-Gm-Message-State: AOAM532UV8Tio69XuMDMawD+bIArXuDXr2X9a6XoP7j0wjHDv/tU1CHV
        XWyVAoydtr7tyDVovnqUn3OxCD0u3lQ=
X-Google-Smtp-Source: ABdhPJwb+ySCRUK0uX64FhViLZpDKx0oQejvfrE1uH7mx3Y60TBUzBrs2k7wDpwQjbyX4cEvivS+dA==
X-Received: by 2002:a05:6402:4388:: with SMTP id o8mr22586416edc.342.1636731731996;
        Fri, 12 Nov 2021 07:42:11 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-195-130.77.0.pool.telefonica.de. [77.0.195.130])
        by smtp.gmail.com with ESMTPSA id m9sm2628914eje.102.2021.11.12.07.42.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:42:11 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 10/12] libsemanage: mark local functions static
Date:   Fri, 12 Nov 2021 16:41:59 +0100
Message-Id: <20211112154201.78217-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112154201.78217-1-cgzones@googlemail.com>
References: <20211112154201.78217-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    utilities.c:295:18: warning: no previous prototype for ‘list_addafter_controlmem’ [-Wmissing-prototypes]
      295 | semanage_list_t *list_addafter_controlmem(semanage_list_t * item, char *data)
          |                  ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/utilities.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index fc5a6a51..fdbb8ad6 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -292,7 +292,7 @@ char *semanage_str_replace(const char *search, const char *replace,
  *
  * returns the newly created node or NULL on error
  */
-semanage_list_t *list_addafter_controlmem(semanage_list_t * item, char *data)
+static semanage_list_t *list_addafter_controlmem(semanage_list_t * item, char *data)
 {
 	semanage_list_t *temp = malloc(sizeof(semanage_list_t));
 
-- 
2.33.1

