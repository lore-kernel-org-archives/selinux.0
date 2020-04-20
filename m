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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A42CC3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D1820775
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHiyM7X7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgDTPp6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgDTPp5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:45:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9457FC061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d17so5256773pgo.0
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=81qiqqHZ0AyplMqb6jelzpOhXR4sKkoaMjUETNEc6io=;
        b=oHiyM7X7MWBqUity/tvpGwcvcpjScvatO74fnADFLco3XV5s8vFTDRo0B8OtwuCDRZ
         hjp8K4MxLmOvceq3glKbPbBoziVQB9UffODYtfCXJRrM6KYBtIS7EpZBnTH7HJqp/wun
         +iKv9nbSlcd72a0wna4CJbRiC2bz0XxbXuyw9EpJ4SedeVYVu2OiBGpRZ96A87ERYwhb
         yS31rZTbMtNp5yARNdrHyo7Y6YMp+83YtdlpjNHed2iz7gnxAjz1Ym7DMvemcliy2Sv3
         sbXu9zmAgqK9HSjA+W32EZ6tL3Swa1bZv6mii2dJMqHXL6v2Tv2AIczcUV0Vc7syg+us
         D6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=81qiqqHZ0AyplMqb6jelzpOhXR4sKkoaMjUETNEc6io=;
        b=f7YqKYOBxhgw2H6bpraEcIhSGB+SnGNMsXJ6/NvfuGjLZ0gJ4UFYoUc2DMZmQfNjjf
         7hl55StjYZGrSGq0P+1MRarUBK7xREC8DkMk23kAn8V7971m5q8ZarN9/8KgbQXqm89K
         LcBVMp4StwN/oLHQpr2JUFWkVVDkfPPynqaRyeV7yHGi3U3jpd1nmaIWynU0y1YXAQnh
         m40DcmMq/nJf8kHLFII7EwJCHtrrBw+IN8kK274gytea0BfzOzLybiR3pd8BXVos9Jo4
         0ax3wpwmK+Gb7XmSNZcqGS7jcrSL3TtOGZnbr1YmVACoqzO+bTr+KI2nWt1+P7R8kX6Z
         TSPQ==
X-Gm-Message-State: AGi0PuY+cU4rhgvevAw/BqubAXMJn64bvJ1pM5TkGtjA8lxSz6H7LwqR
        qlQTW4ZookjJHt00+3CsMsE=
X-Google-Smtp-Source: APiQypKDx1FyMK29YGcg47ZZtOWZ9hvIw4Oezh1aFvTDYIY682//a2gf7R1hrW8ZpzVfKlD5ljDnlA==
X-Received: by 2002:a63:d74e:: with SMTP id w14mr16635087pgi.157.1587397557086;
        Mon, 20 Apr 2020 08:45:57 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:45:56 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 06/19] sidget: annotate deprecated
Date:   Mon, 20 Apr 2020 10:45:24 -0500
Message-Id: <20200420154537.30879-7-william.c.roberts@intel.com>
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
 libselinux/include/selinux/avc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 46c51419f588..0589935651b4 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -64,7 +64,11 @@ extern int avc_context_to_sid_raw(const char * ctx, security_id_t * sid);
  * reference count).  Note that avc_context_to_sid() also
  * increments reference counts.
  */
-extern int sidget(security_id_t sid);
+extern int sidget(security_id_t sid)
+#ifdef __GNUC__
+__attribute__ ((deprecated))
+#endif
+;
 
 /**
  * sidput - decrement SID reference counter.
-- 
2.17.1

