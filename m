Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85C4C4CECD
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4C4206E2
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZB+twYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD0UXX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbgD0UXX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F185DC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a7so119363pju.2
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mK6rHo6KUM5WsO4Xh6SckGgAQp4XOee8g5xpZh7S2Rc=;
        b=fZB+twYM71wNLxt3xDYb25xCNKk9LqZUoXP38gChuzp3mgGHkPNsU1Z4G5fwrLYppV
         csD0W6D76i+hHClwaLlHW+OYE//KaNGvb+WBr3XGEfjd2Y8PXUxq6F/GxkqUZ5o+hdJt
         kbfH8LmOORcwVPrytbJfTke08LRZ6n9C70UWPTjszKSFNDtBvkCW6SbwR6t9NdqYVl04
         CkCPuiU8emw3cbOvAJRK+BQMGLQBZ4DGe2mKckvCgWLan4VacgbIBnbUxtvGwG00Bdr5
         wK+FXCoFFJik/tgMcLKoohx2cdWZrSdCLobcDeSc/vU6glNJoaYZxCv8BhitUdZGr4JL
         6Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mK6rHo6KUM5WsO4Xh6SckGgAQp4XOee8g5xpZh7S2Rc=;
        b=bUkHL3pjMrbpc0ASdadD6QPnVB8wh0jNQwTGVdvaw6xg/+YbRWtz+yiJr7YHJz4ICg
         Jlk2mjfVUdMm+ehLLKixU8LLmejCInKERwJEyatsilbeKSO7VtEDJUCt0YUFxl5y+qxR
         6TFAuZaFUPJxBkmubkZRK4TlBtJDJkRjMinFnqn6LmIG7gvPyRqy180VxXXNJgcyLbl0
         AapsZb6J/3SpZ1SEIU1F0/E0C1A4mu+st66AuB5mC1ZWHl3wxyhyFpk6mRwGQ4MHk3Gc
         T/D0SiGxkbtMd74SQj8Gp/xlBznISXnr557TimnURNKi18N37RKyeCPWUO7aSwm0xiGh
         tWIg==
X-Gm-Message-State: AGi0PuYA6KrKot8455J9G68QEzuKjqIYdnuqInOE7RubQ3gmUDLfh3gk
        MYvLs+hpRMFOnnLP98/+eFU=
X-Google-Smtp-Source: APiQypLD+KpLwkIU0sUo7FoQe26dc0YKM0jKApVWk8dd6xe06cr96jLeFXROPs+e9iGat8v3AokuSw==
X-Received: by 2002:a17:902:bb97:: with SMTP id m23mr3050547pls.253.1588019002448;
        Mon, 27 Apr 2020 13:23:22 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:21 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 01/18] security_load_booleans: update return comment
Date:   Mon, 27 Apr 2020 15:22:58 -0500
Message-Id: <20200427202315.4943-2-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200427202315.4943-1-william.c.roberts@intel.com>
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

