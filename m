Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC55CC433B4
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA5D61103
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhDHTQk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhDHTQh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 15:16:37 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F349C061760
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 12:16:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id m16so1689972qtx.9
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yT1pgVzVhgcQ0yx0VNCZ0mT9YDDPJwzu+O7bptRkNJ8=;
        b=WcJSJ5s4ja1/idIAWY7qxSdGvwaBED28NCWgC1jtr00ZDVaLuyL6vOa9Fk4Ju/mDd5
         JcjniUe+lC9E1+gJfAvcdMMYIh45oTuRaxwlMpD6jF2Df5X6xx7ps1ob4kyZ0kOrZja5
         ERKNB+I98CrbOdpPNOfanuU4WTeKCuFzdX43gjQwNPTGTXEW7Ck7+XCTIlplgTP8Hf9R
         UxkV9a/Ga56Sg9Mlljp3ucXC4mrOLKIS8KeJsOLZ0oDvkNIRGAI6RGBSCZsGwO0b/yF0
         IyEmiLNxPjX9pLBuVIZze9cRTu8zv/t5SV6LrJbpqtjdFLVSMiTTKTHJe/2iKw4QBU80
         kQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yT1pgVzVhgcQ0yx0VNCZ0mT9YDDPJwzu+O7bptRkNJ8=;
        b=n6vR/x3sfZiHGZEzIAfiXuKLj3Bnm8JxRGDknxxxjDDPb+QrZPlszxlXPW1LVttllo
         eDbuL0RfT04L5SL0qaY9ehVfCvgN5lHFQJ8pjtZTXVupQQi2R4sQi9lcJyL8fOuQ6EPs
         XGvNR3kCqMRd3b6L/Ye2Wu0IXMHbL6LS3AOeVffV9LaLBgftvpF0xOGSLH9/Rks/AfdT
         cYn89KlYvZ1+G5gEiwen+1t6Y6eVGPez2V0BYlZtQ71wJQT7qo+kfQvXp3C+KuKw+6os
         WUKG8GlSYSot7zcVryTF+5x9j4Rt1qNNSys7c6u1MhmfKPyLjBvvb+3uxsGMf8Z9V3a7
         OUcw==
X-Gm-Message-State: AOAM532GHCAKdoyOsJS99xBzaFx/ySFPy1FED2400YZaO6hGUHbeHtba
        a15Ay9DlH65sPl+07gBblCa9v35F9owd/w==
X-Google-Smtp-Source: ABdhPJwWgdNdW3/YY37VTj5K72E1E76pBg2EdbtFhWbB+crymIol6dZkYIkOMibEhLglAvnr6oSlbg==
X-Received: by 2002:ac8:5a0d:: with SMTP id n13mr9085479qta.211.1617909383746;
        Thu, 08 Apr 2021 12:16:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v128sm147949qkc.127.2021.04.08.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:16:23 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 01/11] libsepol/cil: Fix out-of-bound read of file context pattern ending with "\"
Date:   Thu,  8 Apr 2021 15:16:04 -0400
Message-Id: <20210408191614.262173-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408191614.262173-1-jwcart2@gmail.com>
References: <20210408191614.262173-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Based on patch by Nicolas Iooss, who writes:
  OSS-Fuzz found a Heap-buffer-overflow in the CIL compiler when trying
  to compile the following policy:

    (sid SID)
    (sidorder(SID))
    (filecon "\" any ())
    (filecon "" any ())

  When cil_post_fc_fill_data() processes "\", it goes beyond the NUL
  terminator of the string. Fix this by returning when '\0' is read
  after a backslash.

To be consistent with the function compute_diffdata() in
refpolicy/support/fc_sort.py, also increment str_len in this case.

Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28484
Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_post.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index d2ecbd43..fd4758dc 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -186,6 +186,13 @@ static void cil_post_fc_fill_data(struct fc_data *fc, const char *path)
 			break;
 		case '\\':
 			c++;
+			if (path[c] == '\0') {
+				if (!fc->meta) {
+					fc->stem_len++;
+				}
+				fc->str_len++;
+				return;
+			}
 			/* FALLTHRU */
 		default:
 			if (!fc->meta) {
-- 
2.26.3

