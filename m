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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCB0C54FCB
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBD720775
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i19mJLRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgDTPpy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgDTPpy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:45:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C6C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:53 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id np9so14400pjb.4
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hj+i+tMN050sCBe+IQticD3qraeN9Ogi50YT5Ooklvk=;
        b=i19mJLRI09+tdf+BRw4/bRm0gMz1nLZMh//xSBHDi3zplnXAF9dnchGuZ9YNcCTFkX
         QgXWQxKywdOw37ivcv08ZHOd1/rff/hp9ZKbxxN3R+MQMWqMVNTKJm1xuLqml7TyexLB
         29H8FNDymV2YXM0B0oIyMYA6eeDvIiRu9ungHBTnbhUOkSWBGlcACK/NSg4ZX3WK2+b7
         +WFeUWG6S1IMMetRVBEROQqn8FDz3KfHs0lzi/GVquxfPhNCU7gdoU5+DmeXeNtzoeZv
         T98kFgT0jgGZuOnSuPGFQYHW9mK64Bh7GtZKnatWnQSy+co6dZcuZT8+6w5ur4qSBBPO
         AvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hj+i+tMN050sCBe+IQticD3qraeN9Ogi50YT5Ooklvk=;
        b=lbZfiQwqlywvhzAPy7u25J0ZiB1J07ZUJlc6ntpHck5GLyJ3iomvfmgZlOAPGFTXaV
         BbLPMH2Wpe4KmVrzATbAOgW5749KIAW/rzwYoe5iHH4slxAJsEtRaj/GWldFy/+lcTcH
         A+TjCxbNdO7eIsVthy+m/ERzoSgz9wsJPlg8TJOhQoNISJVHB6WPxD5oybQo2Rfaen3Z
         2cgCSq3yyPged400Yy6v0gEKFwVh+qoE36Knot6Malkd4cVY0fj+6PiBaGzojLkv5x92
         B17akJSw4axEbr6W6XPbIXavm5hOB04o3QA1V8jYwvPLCjcP4+3eUDvGY2sGdXC7gesp
         ktPw==
X-Gm-Message-State: AGi0PuYkaqFl2wDus1HskjX3b6b55P07snsmHNuzV4Ivk2j9oeCPkHv4
        Ylvfr0U4qIWM9VmqlboltUq7SiqjfOA=
X-Google-Smtp-Source: APiQypKzmTu0HPbQiucV9jLsZyjUTuPw4AzO6sZPwyI+hLpaZzhiII2tTOyPc0jmyHpWQfviuuJZ3g==
X-Received: by 2002:a17:90a:3327:: with SMTP id m36mr25206pjb.116.1587397553378;
        Mon, 20 Apr 2020 08:45:53 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:45:52 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 04/19] selinux_users_path: annotate deprecated
Date:   Mon, 20 Apr 2020 10:45:22 -0500
Message-Id: <20200420154537.30879-5-william.c.roberts@intel.com>
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
index 19b22c166651..75f65e367bf4 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -586,7 +586,11 @@ __attribute__ ((deprecated))
 ;
 extern const char *selinux_customizable_types_path(void);
 /* Deprecated as policy ./users no longer supported. */
-extern const char *selinux_users_path(void);
+extern const char *selinux_users_path(void)
+#ifdef __GNUC__
+__attribute__ ((deprecated))
+#endif
+;
 extern const char *selinux_usersconf_path(void);
 extern const char *selinux_translations_path(void);
 extern const char *selinux_colors_path(void);
-- 
2.17.1

