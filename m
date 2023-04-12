Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D81C77B6C
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 21:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjDLVEX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 17:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjDLVEO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 17:04:14 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E183CB
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 14:04:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id z3so4641750qvs.8
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681333450; x=1683925450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9CxkTezS9nFck5eyA2sZsFsgMGorv7xdhQJZI5fJZw=;
        b=UEp6mAOZv7PHknT3as6fONLEnTJ0qhFbOJuErLpWVCUn+WUsYT4mBKmyCW2VGA0bFg
         iV4MFoLViPA+UXXOGmzzYP3E+IlG2vAL8SFhFMGvPcgA6ZAqwUyDlldtowMq3zAzfy66
         7BHcv1C75CLvEIQKa7m3KcV9IdrQ7+qRt/N6VkFgu6bELc+2k2s0EErjXmj+kCvBIbp5
         rLkluKtwwWUqlROB1DuQPlYtZmG6U6FjkYmZZQ5J+BLnRDcF68lH3i0KLwjhFFJc9J2J
         MD0Slw/rqjBsrdNEeJ6TG8xd7tfNR25U78o/sT1gjM58+UcGdFucFFLsqJzw7YDQweRo
         tXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333450; x=1683925450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9CxkTezS9nFck5eyA2sZsFsgMGorv7xdhQJZI5fJZw=;
        b=WT7Pj9vKs2fy4cwLXThcnTsxQIdtqj8Mi4LFlZGD6Hn7dtonpD+4TWWqJb5CgTnS0i
         nP957QnZzTHHCeTVVqih/k0+tPNr5nPBOgoJlBUPiF98JXsHgKpCvli8belNLcbI9mdX
         W2v+SjjVRchQqsoKN+3j07+u79KtU0TQ+8ZPkIy4VrwP5xe0YM0/ACzzfkRnAQysjdBe
         qbyfWfTOQIUJOss+C6nWl1N1l3MncUnCrPqYMYo6Cnw1eTJEF2Abws3gCXss5tuDHPiQ
         plsqDliTsdxuEBMV7ba0IDkLDbD97zs3C8e48nu8CUNuz2yZm7Li4K9AVrCFzDgY44p6
         zHAQ==
X-Gm-Message-State: AAQBX9fvL5qO37riujL3sddw+pnElCxOJ2EjfqXRrc+1QaADeq+fperX
        +dL2AJ8KaxEwh7m98/O0hGpkg/P5L2g=
X-Google-Smtp-Source: AKy350ZGVFRBFs4oB3WOCHI6pL8qGMdK3huVPEsDNRv0Kh9KcqWf2/QBKn4++XJVl5E0SRQowjNTNw==
X-Received: by 2002:a05:6214:1c8e:b0:5ee:e4bc:a5a with SMTP id ib14-20020a0562141c8e00b005eee4bc0a5amr12658804qvb.17.1681333449782;
        Wed, 12 Apr 2023 14:04:09 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id oe6-20020a056214430600b005e16003edc9sm5025758qvb.104.2023.04.12.14.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:04:09 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/6] libsepol: Changes to ebitmap.h to fix compiler warnings
Date:   Wed, 12 Apr 2023 17:04:01 -0400
Message-Id: <20230412210406.522892-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412210406.522892-1-jwcart2@gmail.com>
References: <20230412210406.522892-1-jwcart2@gmail.com>
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
index 85b7ccfb..f3164781 100644
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
2.39.2

