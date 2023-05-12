Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDD4C77B7F
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 10:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbjELKXi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 06:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbjELKXg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 06:23:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB5E83DC
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc3a2d333so14709259a12.0
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683887009; x=1686479009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLD47pdN7dbz+LdUU+chc5+5RmX7jMC7mzVzLHjiVJU=;
        b=B9AQWv+8CM4r86C7VVl14kDI+BLpqD69bjmUvGCeqrUlw7+u/i6u0ZpakxgLYfmQHo
         MuRhJ87pyNQ2x8qDvYBZtZ24vcBkBqlM75bdumkf+IgwQ7aRBysHLRfXLDR3fg2KBbvh
         +kOVnjnRL21EPa6WYzkEGpVt6h4g3tvUbzY59FI37s6+/DaJ+u1bFgGyvKfuNCbzgKY1
         y34YtsYSBfzGqfqupoBMY/m7Urj1amLKnxJVCnySnx/iGmwp7THBPbmS3mizn0AgIsf2
         pThOJEu0qV9zZlzVm5ZTqsSARDUUqfY5xvF248J1GY6KjPGCc8ajvck6e4NWHBn0G//B
         sN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887009; x=1686479009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLD47pdN7dbz+LdUU+chc5+5RmX7jMC7mzVzLHjiVJU=;
        b=XMc4rUn0r+QEb4uUfsSoM3fhoaPOwaOkW/G4osPa19+h0GG4cpm3UFBLMgmXlAm5HN
         4jp/CAfXKcxbu78Ul183HcMfxUcYIPodPsrvoh9/8PHmUJH+yLxO0YN5aABAwau4ae0Q
         Z6h1A0u+DDMW9TB9rMb/NGec/lY17gmgxBH5y4IfBIc6B8Q9K17t2UVATcPi/YYOWfmj
         ib/IT0gQ2xfHwvkz6RACMg7ZmNjn66/GQiwHU+IisG3NCludCUuXlJAXs2wYQfGyUgz3
         AYvF3RwIRsi38Orukq7+d43tGCMOetR25oxrOzUl36l3NGOdVDxVwXUg6UVv3ZHYgVgI
         1nYg==
X-Gm-Message-State: AC+VfDyTtOOXmeUZmvzXjWUdz9k3IKVFlkln3Ulgct/GdAF0bsh1rqp0
        CEWEwMwQeeDpObiwAzR/9pZ71tsIHZ3hqg==
X-Google-Smtp-Source: ACHHUZ5/l9cx0effsYbu6OLHy2iL+nLh7lATKylDWzDVeQHm0Fl4KraEAGyVVw9KJcj2NJaMhAHGaQ==
X-Received: by 2002:a17:907:1607:b0:94f:1c90:cb71 with SMTP id hb7-20020a170907160700b0094f1c90cb71mr24971704ejc.65.1683887009047;
        Fri, 12 May 2023 03:23:29 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id gz4-20020a170907a04400b009571293d6acsm5202920ejc.59.2023.05.12.03.23.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:23:28 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 3/9] libselinux: declare avc_open(3) options parameter const
Date:   Fri, 12 May 2023 12:23:16 +0200
Message-Id: <20230512102322.72235-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512102322.72235-1-cgzones@googlemail.com>
References: <20230512102322.72235-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The first parameter of avc_open(3) is a read-only array of options.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/avc.h | 2 +-
 libselinux/man/man3/avc_open.3   | 2 +-
 libselinux/src/avc.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 92c79988..3e75cbad 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -201,7 +201,7 @@ extern int avc_init(const char *msgprefix,
  * is set to "avc" and any callbacks desired should be specified via
  * selinux_set_callback().  Available options are listed above.
  */
-extern int avc_open(struct selinux_opt *opts, unsigned nopts) selinux_access((read_only, 1, 2)) selinux_nodiscard;
+extern int avc_open(const struct selinux_opt *opts, unsigned nopts) selinux_access((read_only, 1, 2)) selinux_nodiscard;
 
 /**
  * avc_cleanup - Remove unused SIDs and AVC entries.
diff --git a/libselinux/man/man3/avc_open.3 b/libselinux/man/man3/avc_open.3
index 55683bb6..74f85593 100644
--- a/libselinux/man/man3/avc_open.3
+++ b/libselinux/man/man3/avc_open.3
@@ -10,7 +10,7 @@ avc_open, avc_destroy, avc_reset, avc_cleanup \- userspace SELinux AVC setup and
 .br
 .B #include <selinux/avc.h>
 .sp
-.BI "int avc_open(struct selinux_opt *" options ", unsigned " nopt ");"
+.BI "int avc_open(const struct selinux_opt *" options ", unsigned " nopt ");"
 .sp
 .BI "void avc_destroy(void);"
 .sp
diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 8d5983a2..634badf9 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -225,7 +225,7 @@ static int avc_init_internal(const char *prefix,
 	return rc;
 }
 
-int avc_open(struct selinux_opt *opts, unsigned nopts)
+int avc_open(const struct selinux_opt *opts, unsigned nopts)
 {
 	avc_setenforce = 0;
 
-- 
2.40.1

