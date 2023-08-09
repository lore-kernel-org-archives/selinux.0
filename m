Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0511AC001DE
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 21:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjHIVCF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjHIVCE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 17:02:04 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431501BCF
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 14:02:04 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76754b9eac0so21895685a.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 14:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691614923; x=1692219723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd/V3tsSrSFG94E7Lt5MZAnsyhm2M4lM1vc3oJQ8Rlw=;
        b=sX6ooF62zuIEBzIug9C3AeZMe++yvGLwTJbfpp87glPO8Q/dH/nKBr3TEUog3rwrmP
         yQta9Ca+ispREDpE5Vq59M+NubNO1vJv+/l9YcsjVmR9drhKfXB6Jnbb5Sw2TcYSQtLa
         FQMgPGW2+phsjfbi8RXHrsWWS4ZdcZk+SAo6Zk7lmzXeMvflI2UIXs7V9Mfv93fly0b+
         KLHLlyKE/GbEh2HetoKR7US+8IC2vQ4XdSmLzYaYD+3t7s0K6/I3oXdfQOpksDFeGgR5
         0+cOtZfemXe4pZWsT7cHqvCKRGK+REaYlgnK+O7Ccsa1Gi1JbO6Q6WWBhsRaFHZxG/7j
         z+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691614923; x=1692219723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wd/V3tsSrSFG94E7Lt5MZAnsyhm2M4lM1vc3oJQ8Rlw=;
        b=fjOcwAF98Z9tRax1AxR9FGEjrto32g0xXgoV9FKHmPkinfQRJJ2J2Xfozc+EGkrqo5
         KW2wBkyncbuX7Dhc6j/uhSqHjt7MRSiWMQiLCDyd4gX3Td/cbRiMHjPrJSTgZ1iuRkPc
         GdtaESyM7J4SJu8tq2vmFUWV9WjYX5Hgt6SQZGq6wRP3ZzrtP8O46ES7HPohXHgKLzHI
         2oCTb+xnt5VZAHQIl2rNONFctwoeEy0/kgP0x4ubdyKvuv4IoOtGLvplS5McfN68peDE
         denJbeBSL/USBPWVIoBStis0pYKRn0D+FvJoyRHiszgIszU0PE3/6TZUHP7kKpZsq9Nf
         1qTA==
X-Gm-Message-State: AOJu0YyZ1bDuAwav3EaRtXEf3unwLhkWSX+yCm3zAYw3G/+dPLTaiZ4t
        j3Le+EiohS4aSPN0vvE9qOqw17cTq28=
X-Google-Smtp-Source: AGHT+IG4587XKBVMnlJLhmuECjK45ir7Sk4hKkhQxwLFv5fvlxClTMIqyJ/0+lHIkG2WPi99l8Mllg==
X-Received: by 2002:a05:620a:4714:b0:76c:c41a:f1a1 with SMTP id bs20-20020a05620a471400b0076cc41af1a1mr225029qkb.8.1691614922993;
        Wed, 09 Aug 2023 14:02:02 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a10b400b00766fbeb3e7csm4208287qkk.132.2023.08.09.14.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:02:02 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/9 v4] libsepol/cil: Add cil_list_is_empty macro
Date:   Wed,  9 Aug 2023 17:01:50 -0400
Message-ID: <20230809210157.112275-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809210157.112275-1-jwcart2@gmail.com>
References: <20230809210157.112275-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a macro, called cil_list_is_empty, that returns true if the
list pointer or list head is NULL.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_list.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/cil/src/cil_list.h b/libsepol/cil/src/cil_list.h
index 6b4708a0..f974fddc 100644
--- a/libsepol/cil/src/cil_list.h
+++ b/libsepol/cil/src/cil_list.h
@@ -44,6 +44,9 @@ struct cil_list_item {
 	void *data;
 };
 
+#define cil_list_is_empty(list) \
+	((list) == NULL || (list)->head == NULL)
+
 #define cil_list_for_each(item, list) \
 	for (item = (list)->head; item != NULL; item = item->next)
 
-- 
2.41.0

