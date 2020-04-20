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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8654AC54FCB
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6334E20775
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcYsarh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgDTPpv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgDTPpt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:45:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B265AC061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nu11so23464pjb.1
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M7QO7d/nGxQvtYBOljrVhg8Tk0kk4tiNZz4BHBU4WXo=;
        b=lcYsarh4JW8JOaYB2dALKvX0f5F8CWrMm5Eg/5vIXM4PuDFA9pfkqVgzOBMoUVZhha
         yjcSeqK8SnT3FokbAXyTOF6WOmY+/F5bc+1XjhmVeOyxZuRfjskACX+hI9FweL6D3BWn
         F9JQaVJoZPDwS20h0o+zPIZblRHWJpd8GldNIvAvQ4uCaubrK+gy43Yxe+N9sudCJJ8d
         e0iPrQaCO8tWdlJJNynuQo0iquE8PtniRPHNGfvkh5RUuGXSw0yelSzlqY3QvCo4dA7C
         DuVB5fEZ4Riso2O01xg1dBKqYZC1gm6AkPxO0iwk0O822r+U+wtimDJG2aNWi+iKKU0a
         c4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M7QO7d/nGxQvtYBOljrVhg8Tk0kk4tiNZz4BHBU4WXo=;
        b=inVgpedHNF0cH74aVwintAkrDJHNVDfaevQPIxim0CSb1pXUgPu8vsCDmdyUYoYkj9
         Y4C2zz10zWYC816k63xmKcIK5U0s3qn5yF8ybUfcq87t2k9w8wpc4a5d59GrSevXDHL2
         cRns9ve1I64miOoeK9fnCSZ9XmmNXgwFQe3kh03oAUKz65kH5polbnDAtXHDLAYJxKOs
         /XmBxjTbXdHvGIM8FG1DFVvV9XeqhPapWaLGWSzkm750/NqOBb1y2yWFa7kOsi3GY5eL
         5yYrigeCV4a1L23uILRf1JdaS8tsF3lkmJ3aDHOi6dAzJ/s2mkqFIKkA4S4SIaVpLSuz
         9G/w==
X-Gm-Message-State: AGi0Pub0C+lbu3xiAL1XHCfajNf4jzAp/BGUngFXbuZRw2FYAT3dHPSB
        WHqHWCwEydUcmV9y1if841AvNYL5woA=
X-Google-Smtp-Source: APiQypLYvCM3UtFFwlyxGDhj6ZB/Vapx4zp/1Ec0mN0WLhiigKBuwGQmbXxkPxIPYMmjHhq48ec54w==
X-Received: by 2002:a17:90a:68cb:: with SMTP id q11mr1704pjj.15.1587397549174;
        Mon, 20 Apr 2020 08:45:49 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:45:48 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 02/19] security_load_booleans: annotate deprecated
Date:   Mon, 20 Apr 2020 10:45:20 -0500
Message-Id: <20200420154537.30879-3-william.c.roberts@intel.com>
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
index 948ca0689a07..ae70479511db 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -325,7 +325,11 @@ extern int security_set_boolean_list(size_t boolcnt,
 /* Load policy boolean settings. Deprecated as local policy booleans no
  * longer supported. Will always return -1.
  */
-extern int security_load_booleans(char *path);
+extern int security_load_booleans(char *path)
+#ifdef __GNUC__
+__attribute__ ((deprecated))
+#endif
+;
 
 /* Check the validity of a security context. */
 extern int security_check_context(const char * con);
-- 
2.17.1

