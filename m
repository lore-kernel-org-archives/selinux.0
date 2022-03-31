Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F63FC433F5
	for <selinux@archiver.kernel.org>; Thu, 31 Mar 2022 14:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiCaOtw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiCaOtu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Mar 2022 10:49:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F24121FF46
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:48:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a17so28459560edm.9
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WQOPOuPkhVBGmToDYqZgLtsuD/b3lfwf9bcY7XQFo34=;
        b=YeL3gXlaKYn8a/orcCH+5+BLSGzTCayD06L1XDNGwyoPzOVZjBtWnYkgs0ctQjPPyy
         Yszp0mxoATN91RIVfuUy6WUHuiBk+K+GXnNgu4fiVDGAPjepu1q57i3uFvkGfTeAb/Jn
         qCl4N14H7fOp/uWvh5d4oz/LpQHvcmjQhLnq+wLfXk1Qiz5Xc4fHbb1R3fjoo7ufEJf0
         SKc9d3eqm0IGC++qnLEkmFzHF2Jh590WLRc3NOXcniCwyhUkOjBb6xUZW26GVymSIhO7
         UoayCaNMda64SvJoQnqup1csbrIXXy2s1lhERBMkdMNugusUi18ds8NAAwvwGYiJBGw8
         br5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQOPOuPkhVBGmToDYqZgLtsuD/b3lfwf9bcY7XQFo34=;
        b=NymtB+HiZyNUzuCQ1ryILZ6rzdbHU9xCICGoCIfDixVxFCMMeCOYvLtMvC8akj9Z5F
         q9pSJqb/gV4/ty519jaFKrjsyBUAe0tUQmjDvRbm1MYY8ZtfePEH0MtLQVdRXF95GIR0
         wWSrbz5CEANlC0PikLCqvFE3CvoIKGSjsdjWojL91Cowp9GIt8h6DW7HNR5I1cHYURh9
         noABje2W46JqnS36z6Ax8Q00JMOntFeEUxKhUu/Y7PWEFGN1x4cYjz9R8IeaGjzsN8WE
         KZhSVp3bPJL2RnwB+e2aO7ODbN92U4tg5gcDKQvv4tWK5Wltp4wLPpSKvpHa7uZZ9NtN
         xc4A==
X-Gm-Message-State: AOAM533beptVx18+z+PR2qxQfebzghaLq6moIK8qz7Xo4YLGZOEPrTlK
        paCGdeXmqTv+96yhPRM/go6N9XF4gS0=
X-Google-Smtp-Source: ABdhPJxFxuHDIDFwl9dI8fD+32LWP+tQ865lRkDDKDiX+6PZ9BbW3EQWFrJAIUQqCHO5WNh+m2Iwog==
X-Received: by 2002:aa7:d7cb:0:b0:419:43f:efa9 with SMTP id e11-20020aa7d7cb000000b00419043fefa9mr16958620eds.75.1648738081649;
        Thu, 31 Mar 2022 07:48:01 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-065-043.77.6.pool.telefonica.de. [77.6.65.43])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7cb83000000b0041b573e2654sm3163368edt.94.2022.03.31.07.48.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:48:01 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 2/4] libsepol/cil: drop unused function cil_tree_error
Date:   Thu, 31 Mar 2022 16:47:50 +0200
Message-Id: <20220331144752.31495-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331144752.31495-1-cgzones@googlemail.com>
References: <20220331144752.31495-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It seems to be unused since its initial addition in 76ba6eaa
("Squashed 'libsepol/cil/' changes from 08520e9..28ad56e").

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_tree.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 525b60d4..6376c208 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -41,15 +41,6 @@
 #include "cil_parser.h"
 #include "cil_strpool.h"
 
-__attribute__((noreturn)) __attribute__((format (printf, 1, 2))) void cil_tree_error(const char* msg, ...)
-{
-	va_list ap;
-	va_start(ap, msg);
-	cil_vlog(CIL_ERR, msg, ap);
-	va_end(ap);
-	exit(1);
-}
-
 struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **info_kind, uint32_t *hll_line, char **path)
 {
 	int rc;
-- 
2.35.1

