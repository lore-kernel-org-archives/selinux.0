Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B62C0015E
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjHIUkw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHIUkv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:40:51 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C34FF
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:40:51 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-409ae93bbd0so1103901cf.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691613650; x=1692218450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbOdQYH6aeZrzn2MDIJ5QdrJLMu6SEX+NSD6BMtE0hI=;
        b=D8NZZRnftrvgADy7hV+lKLpv9npnPuPfchq3YUUGPA6EyPjVe4TDpMt4/16KPGA3Qp
         sWhMTrbQuQp4f6K5+Hkclu2KBf6b2XDW1YbhkZ61zzmns7xwzmgD3KqlR4vaWmWwJ61E
         NR+5FuntOFAjxktOW4cqfNal8QVTUIy2numSVWuOb1GwCwbs4BpIMYOTNjROMbOfE7sJ
         7uVcMtedlrsWElvkMrs2scMrJKaMz5cvB25+1GfHQiVaXZJZYATAr3iF+evzxGXJaJjz
         VzTMbB9HVtx3LmdgCuwwgV3ql5fuhYByhEFBOtk/rS/+8ocU4MgNBayekXRNjXA/Sifz
         I7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613650; x=1692218450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbOdQYH6aeZrzn2MDIJ5QdrJLMu6SEX+NSD6BMtE0hI=;
        b=FS0HsR519KNKif27z9bgpS/DrGvIsTyX32fZSdzGSgyi6okExUXkdmYR7wScVosElg
         vI/Jv7c1uSi/sRmOl/uATORTRo3DzhzxoKsVXT3YqYz0EoWfQ1sVQbWHvXOuVBDYKlhZ
         ywQ3k7S7yCokgmi/1f2xkr5lZEepzlIOYtg+PYWhxLY2XuG3TAVen6+yBBvUgb/l9tnp
         XzuQ2rO/0etuIS2EHQXM5GS8wtOLSfHL+qJli2EWonyEAzeaz+FJfSrzi8FVlMkZYhbb
         ULZhuZ9DAFkjSS5B3t36A/UfRqRD8s3OWoWiyvcCpyejpoIGGDkUTulXo9ejdG1PBgTu
         3qJw==
X-Gm-Message-State: AOJu0Yx4L11/C13HsNGQxtc5lczLS2UYcgUGU/ayRI7NIqAigbUBfI0e
        5Cr5arJdFfPMm7m7C3O7d9k2VhiEWz8=
X-Google-Smtp-Source: AGHT+IEfuNliwoJO5Sp9GVcnV99rdoEh8dVdK50MbG+eoSUDYDhwX/lE3UcAWl8xVOJYZgA4IAosmA==
X-Received: by 2002:a05:622a:3:b0:403:e9e2:3d03 with SMTP id x3-20020a05622a000300b00403e9e23d03mr584914qtw.47.1691613650015;
        Wed, 09 Aug 2023 13:40:50 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05622a14d200b0041020e8e261sm711295qtx.1.2023.08.09.13.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:40:49 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, cgzones@googlemail.com,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/7 v2] libsepol: Changes to ebitmap.h to fix compiler warnings
Date:   Wed,  9 Aug 2023 16:40:40 -0400
Message-ID: <20230809204046.110783-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809204046.110783-1-jwcart2@gmail.com>
References: <20230809204046.110783-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When compiling with the "-Wnull-dereference" flag, the compiler is
not smart enough to realize that anytime the ebitmap_t node field is
NULL, the highbit field will equal 0. This causes false positive
warnings to be generated.

Change the ebitmap_is_empty() and ebitmap_length() macros to check
for the node being NULL instead of just relying on the value of
highbit to eliminate these false warnings.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/include/sepol/policydb/ebitmap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include/sepol/policydb/ebitmap.h
index c434c4ba..7e19c301 100644
--- a/libsepol/include/sepol/policydb/ebitmap.h
+++ b/libsepol/include/sepol/policydb/ebitmap.h
@@ -39,8 +39,8 @@ typedef struct ebitmap {
 	uint32_t highbit;	/* highest position in the total bitmap */
 } ebitmap_t;
 
-#define ebitmap_is_empty(e) (((e)->highbit) == 0)
-#define ebitmap_length(e) ((e)->highbit)
+#define ebitmap_is_empty(e) (((e)->node) == NULL)
+#define ebitmap_length(e) ((e)->node ? (e)->highbit : 0)
 #define ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)
 #define ebitmap_startnode(e) ((e)->node)
 
-- 
2.41.0

