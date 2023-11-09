Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898F0C4332F
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjKINx0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKINxZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:53:25 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93E272C
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:53:23 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c603e235d1so142844966b.3
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699538002; x=1700142802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eV/5zBGqI9wBbtRO3IkTlt9j9AqN38cNWSn30T5kJhg=;
        b=hWILlDbbIOYSeXSWrjEqkR2XRT4QthnIXhrW9ja8j8kS4ArVlezBdTQINHlHIGdoJp
         +MYJURpKEx/UIptf3ISu8ARrl5pOMn5qjPsN5Ym7Fe7NLjxBqSWpeW3eOWX5NWFehtBt
         A7U/izeXbinEYm6gpWkluaeyVgADRGAoach3kNxEjPGc7sg9b/MKvzo/R8PzstI9gIq/
         yQy6vSFGrOoASaZkSRtsio/Q8Dd/BHnq99/1szyNlZg4t+o9dmw3kgDWRRPy/XMJ8pe5
         lGuWWUyIyGMz+eYZMdN6AmHA65lqHgNiCY7rkr3wSTExwdIV0Z4bu8zBglC3EiX9ojB2
         wumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699538002; x=1700142802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eV/5zBGqI9wBbtRO3IkTlt9j9AqN38cNWSn30T5kJhg=;
        b=a36BSpViLeab9O24eVuQQ2JtL67Vx59gODMX1SAjGy2jF0ksZm4lrmmMxt+53YRgav
         WOXl3/58x6K9eq3T38tXWcT4jEIWThsWdCd8+sqzvfH69wIB10568steBEQ+63X+nE/u
         b4OeckZJGh6QKr6FY2akZLLqlVGynIayHYxLp3BYKkVSLU/vv+7v/PLROXo2NFjF4KuE
         br6SPpoDsc7ZwAD8e3KyTmiwiDTcVsHAGUnnuZKDOJiEKQIwSx7+j+wrOTdQDGBppV5A
         QBfEdzSYEyrgzXbjN1I9vbUyyH8nH3qyrTytnHKH9wybzgcBX7HvIGEeJU+RmKAb2G/o
         eSHQ==
X-Gm-Message-State: AOJu0YwzjWsApg4Rs+0QssxklakX5xTTymr0MCgYljvxs1OF5aC/WIjF
        uPHr5490+8LpEsNxn6bEd7D4Eu1ru8k=
X-Google-Smtp-Source: AGHT+IFCbaiC0jC8Ls2li6AQ8omTujRM6LInDWGqhjhCtmoESg1aBLRmEUy90ODAAetAnr+S23Alug==
X-Received: by 2002:a17:907:968c:b0:9c3:c2e1:a38e with SMTP id hd12-20020a170907968c00b009c3c2e1a38emr4486195ejc.15.1699538001868;
        Thu, 09 Nov 2023 05:53:21 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id q8-20020a1709060e4800b009de61c89f6fsm2549900eji.1.2023.11.09.05.53.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:53:21 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 5/5] libsepol: avoid memory corruption on realloc failure
Date:   Thu,  9 Nov 2023 14:53:15 +0100
Message-ID: <20231109135315.44095-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135315.44095-1-cgzones@googlemail.com>
References: <20231109135315.44095-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use a single pointer variable for the realloc(3) result to not
immediately override the source pointer.

Also don't unnecessarily copy the first character.

Reported by Clang Analyzer:

    services.c:810:14: warning: Assigned value is garbage or undefined [core.uninitialized.Assign]
      810 |                                         **r_buf = **new_buf;
          |                                                 ^ ~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/services.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 51bd56a0..738a3404 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -787,8 +787,8 @@ mls_ops:
 
 	if (r_buf && ((s[0] == 0) || ((s[0] == 1 &&
 				(flags & SHOW_GRANTED) == SHOW_GRANTED)))) {
-		int len, new_buf_len;
-		char *p, **new_buf = r_buf;
+		int len;
+		char *p;
 		/*
 		* These contain the constraint components that are added to the
 		* callers reason buffer.
@@ -801,13 +801,13 @@ mls_ops:
 				len = snprintf(p, reason_buf_len - reason_buf_used,
 						"%s", buffers[x]);
 				if (len < 0 || len >= reason_buf_len - reason_buf_used) {
-					new_buf_len = reason_buf_len + REASON_BUF_SIZE;
-					*new_buf = realloc(*r_buf, new_buf_len);
-					if (!*new_buf) {
+					int new_buf_len = reason_buf_len + REASON_BUF_SIZE;
+					char *new_buf = realloc(*r_buf, new_buf_len);
+					if (!new_buf) {
 						ERR(NULL, "failed to realloc reason buffer");
 						goto out1;
 					}
-					**r_buf = **new_buf;
+					*r_buf = new_buf;
 					reason_buf_len = new_buf_len;
 					continue;
 				} else {
-- 
2.42.0

