Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB47C54FCB
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCAB20775
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqKNIbV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgDTPps (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgDTPpr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:45:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94975C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:47 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b8so5114848pfp.8
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mK6rHo6KUM5WsO4Xh6SckGgAQp4XOee8g5xpZh7S2Rc=;
        b=GqKNIbV1sbNcXLdAAkGDVdUWmARLKh7zKlyFKdK+03x5ONPcLKMxXVxePXABL6/iV0
         FBPMbKlcw6JnQdprZJ9jgQzO+LLiBhU3xH+hWJusOGgej7sPHBf2mHmFK4AwyzFgq3IT
         rninrJ7VVULgLU/7JT2FwgZUgW3Jm39SSjO3+TKB2VAdb+0rYrCCbYHb0zK37VgBGAH3
         OxjY/heYBOQFnZ1Dk2GjNvdFKbqRMHlpLm1KuyZk74sqUBXeA5Ni6y89Rtc6iYlGTEXe
         92HEe8HLso/b2o1L9NkKpjlB1Z2byRBDjSt3wNNvFdGRBwD/0agYeKfh/yNXWCuZRO64
         HB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mK6rHo6KUM5WsO4Xh6SckGgAQp4XOee8g5xpZh7S2Rc=;
        b=lOH3qyqaWZB5C0IVC5WAy+i1tDRZwtBO6a2MECrEy7dZA3YYm8HmTCdTFIRhnSUcCd
         WnjfUgf+OMMUb3n5tAfc1XQDaDrZQL5lY8DicRCABNBchEO2YsKHX97yOrnijrWERTHs
         6u8YHWa2cnog1fq1F4V7pjHd5skrDVSKEDF0bDKmL3bkYBD7dKjPZZ2NuH6VcbVP2uTr
         pA2Ln8nZcM9/VBxjCbS0a8RecQe8o0SB6Hlw3i8eGTZ+gQv9m6skpLEo0HteT5KRN0dM
         LXsiBGm2epdE56TCu+csjfMc+DXrmqyC85sjSvX3u3JioUo3rhyydYsVx71qMOYOo/1u
         Mfyg==
X-Gm-Message-State: AGi0PuYAnEid+tHSXJ4xcCGyoKzTO5OCOklUAGm7ZRzHFpkIlvoipITW
        oFszQeORreYtN4KNDI7Kqv8=
X-Google-Smtp-Source: APiQypIDZvkBXBdkuuy8/pzIDEBM7Y23gcYK4XoUIa8Ey5uFXNRldaiENejv24j9hoxepa99ojqrqw==
X-Received: by 2002:aa7:9207:: with SMTP id 7mr17167967pfo.178.1587397547080;
        Mon, 20 Apr 2020 08:45:47 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:45:46 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 01/19] security_load_booleans: update return comment
Date:   Mon, 20 Apr 2020 10:45:19 -0500
Message-Id: <20200420154537.30879-2-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

The code returns -1 not 0, correct it.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 6a512b383325..948ca0689a07 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -323,7 +323,7 @@ extern int security_set_boolean_list(size_t boolcnt,
 				     SELboolean * boollist, int permanent);
 
 /* Load policy boolean settings. Deprecated as local policy booleans no
- * longer supported. Will always return 0.
+ * longer supported. Will always return -1.
  */
 extern int security_load_booleans(char *path);
 
-- 
2.17.1

