Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F42C77B7F
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 10:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbjELKXv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 06:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbjELKXk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 06:23:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A51100F4
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-966400ee79aso1321726766b.0
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683887011; x=1686479011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdqR4pUMqP8H82QVZlZ9nX0C6mDk9sWHOx0UPmV5XNg=;
        b=jVOOhBonyxOtbJNAi6RRKsjAC6fmbkxL+SSfi6DgsY2HXgyQW1EV4jicub2xUixiiA
         5IuI/9QhPAK21Asezha4KbELGxv6g4TCtrLT5yovlVM+w8JJdvFAzyD2rF5XNP8jtU1/
         hoHPMRRHwvfFJMWjtoOsX/Ll+2MQKolfYxVWnFVUvEnBhIiCPp4B9pEcbNq3W+QpG8mQ
         XsyDiajFP5cGbKJRRo/f3w3oaYyD0tD1opJ50+4f7+1VRS6emeV+eX1E0ofgJTzUeo9y
         DMtmoGLKn2qGc3APm9H+LqnoPTmwIa34A5Q/eDV99hXWaNcDqZzEzLNbafGEdGBgCJ6W
         4lZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887011; x=1686479011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdqR4pUMqP8H82QVZlZ9nX0C6mDk9sWHOx0UPmV5XNg=;
        b=Bx0pR2pmJAq7+is/nPdJhyMwoNJx/36kDNymMl8Gk0O9mHKAPLskeVByZ8QTCbMRL4
         BkYbfnijU7oGsuCGbWVnUYuhnHHPX0wuReFBEp57tuBHYx/ip0tB/8mvB/amZ2qZRttC
         YBcp5AEAjKlIpbcvAhZI6SzWIxuXPPkxfa55pro1yzrxil4VAKu6O8DB7ZxFV5NPQHbd
         Isu/tpkNd5iwFdZ89bUQlsSi2NdOc7EVyge8ZMj44hs7bDjkZvGzcDCJEau9yWEWst8V
         NgoVQBJ43qxt11EbrjDP8tq/APA1tYOpE+DAz2GKdJYHugyUwQkC/1TmTZGWN4OUbFND
         RlWg==
X-Gm-Message-State: AC+VfDwVKzc2hVvlVh/7z2bSLP5UDo/h5jR/E/JVWJuaCV+AZTmrbiG2
        Gl1Wg73TICQHhqSv+0WbuERQuLtupraTiA==
X-Google-Smtp-Source: ACHHUZ7ABzJLmZ9TEni9+4qDR/fm8bIAekDJA/J6FW2VT6wGJAdC/JBhz55KmYMI0pPJ9sN7lnex0A==
X-Received: by 2002:a17:907:982:b0:965:7fba:6bcf with SMTP id bf2-20020a170907098200b009657fba6bcfmr20448043ejc.67.1683887011372;
        Fri, 12 May 2023 03:23:31 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id gz4-20020a170907a04400b009571293d6acsm5202920ejc.59.2023.05.12.03.23.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:23:31 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 7/9] secon: check selinux_raw_to_trans_context(3) for failure
Date:   Fri, 12 May 2023 12:23:20 +0200
Message-Id: <20230512102322.72235-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512102322.72235-1-cgzones@googlemail.com>
References: <20230512102322.72235-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    secon.c: In function ‘disp_con’:
    secon.c:634:9: error: ignoring return value of ‘selinux_raw_to_trans_context’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
      634 |         selinux_raw_to_trans_context(scon_raw, &scon_trans);
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/secon/secon.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index d624fa13..82266894 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -2,7 +2,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <assert.h>
-
+#include <errno.h>
 #include <string.h>
 
 #define xstreq(x, y) !strcmp(x, y)
@@ -631,7 +631,10 @@ static void disp_con(const char *scon_raw)
 	char *color_str = NULL;
 	struct context_color_t color = { .valid = 0 };
 
-	selinux_raw_to_trans_context(scon_raw, &scon_trans);
+	if (selinux_raw_to_trans_context(scon_raw, &scon_trans) < 0)
+		errx(EXIT_FAILURE, "Couldn't convert context %s:  %s",
+		     scon_raw, strerror(errno));
+
 	if (opts->disp_raw)
 		scon = scon_raw;
 	else
-- 
2.40.1

