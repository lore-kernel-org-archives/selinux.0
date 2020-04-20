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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FE3C3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2355D2082E
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVT6X8J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgDTPqI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbgDTPqI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:46:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09912C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o185so4710664pgo.3
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W1L3bA+GPmHiUflkrWsIYtotwIeleU9ISeIFILRnHcw=;
        b=UVT6X8J3xKGjtBL8XIqL58pmncctW5rYhujyQ0Hj5rFqjt4f+68ZrGahvRvXjn4NOp
         DHDkaxYe/zMUpxqjmF9gjdNo4CANWJlW65wAoTWXvm7W3WeFPfwbiN1qujOVzzhhfIj6
         TlqbbuhmBbdng5qRWK5XywhvYPfhZ1yb2Ddtgc8Hn87udWp2x2P+Xn9wbEzgSQepfRYI
         Sj5cxlXAFK/3/xZdQM7zhhzQdUuL8UWDJRiZ3iP/YE/y6riw8cB4dSel8lnnUGGhCGIC
         l8NydaPQyqLg7WVzdjehlFb9BfFPM0134RckPkmhDVsopX01hIg8+sCh3Sc6oN2QlHkD
         IW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W1L3bA+GPmHiUflkrWsIYtotwIeleU9ISeIFILRnHcw=;
        b=WQpjeYY/mm8rbtVlJduHNZPWdjB/FUT9rBvwQ5Oo3B+wDQSUX1pS8vo/Y1UUq5vaNq
         Pb96XWCW6uxJSTkXjCm5eOYylZkcXhraGQzB7cWrd+H7BmH7VUc1SDnsay+Pysj+4UUD
         Y/hEEFkeR4xR/fTs4C33yFJYCTOnALi2aAMS0lrL+YHJI3HQHAWr9BFTg32C9wS/qOpw
         LJYDhJAfETcLcrNKFBdCPz4giPepvuIeq6OJL6ne5BocMtq76UIxAl/4uZxkzte1f7D5
         g3fgjRCFsUsk/O0TW7gRFMpWvJVCz0+TNhKDZGgPwqhWJ+NJf4/HWjV8p4yR2jSHM1+p
         OUhQ==
X-Gm-Message-State: AGi0PuZigvG42z4Pp6I/zpxDt+tiy7fEU9PerG4LGUwM4sgx653rA5Vr
        mOOf2SNWUdUjFuyt7YN3ARs=
X-Google-Smtp-Source: APiQypKxT/w9o0vS8njDuClNUzSOCXUNPEjK6GLqO4ogHdDnBX9uUVhZj5LOMb4x0VyQXQ6iMLs0+w==
X-Received: by 2002:a62:144b:: with SMTP id 72mr17648481pfu.246.1587397567524;
        Mon, 20 Apr 2020 08:46:07 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:46:07 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 11/19] matchpathcon: annotate deprecated
Date:   Mon, 20 Apr 2020 10:45:29 -0500
Message-Id: <20200420154537.30879-12-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index b04f34a1b3bb..5633cf40607d 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -494,7 +494,11 @@ extern int realpath_not_final(const char *name, char *resolved_path);
    If matchpathcon_init has not already been called, then this function
    will call it upon its first invocation with a NULL path. */
 extern int matchpathcon(const char *path,
-			mode_t mode, char ** con);
+			mode_t mode, char ** con)
+#ifdef __GNUC__
+	__attribute__ ((deprecated("Use selabel_lookup instead")))
+#endif
+;
 
 /* Same as above, but return a specification index for 
    later use in a matchpathcon_filespec_add() call - see below. */
-- 
2.17.1

