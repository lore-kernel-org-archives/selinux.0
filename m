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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574D2C54EEB
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0A42073C
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qc9nAOPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgD0UXZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbgD0UXY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:24 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B116FC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s10so7429235plr.1
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M7QO7d/nGxQvtYBOljrVhg8Tk0kk4tiNZz4BHBU4WXo=;
        b=qc9nAOPGwU7y0iPbQnKI/ybwzkDqYPqR/yLpr9KE1AzAf3CiR6I0Jln3bL0jCFZOMO
         rlYieJihOoRbEyArLmf7F/zlLBCDWzVPxCdMDHhipy5+ql+5RbJIk6EDlEQQshX9PWQP
         DK8kCfHYkLmcrLNxteYZEG44PpfsJuJ5wqRo+4MYLo+JxLK8SBLbjKu5+tIbQ0rIhE75
         QZSBc/K+Z2etPuW3VjBBBQWGZflIK3YpwhOe2v2vY46pbYuP78Q9uHInmo3DLLhlKXmG
         mPKg8w3wdYKlE7NtmtKRt42QTTQRFIEr6OcihO5Tf3WeqTkAmDkFP2kB2IwOsTgeh4Q1
         ewCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M7QO7d/nGxQvtYBOljrVhg8Tk0kk4tiNZz4BHBU4WXo=;
        b=ekBwfY0oeTGkTU4C5LSSE1vlWmGI2F4Yd3WPQ5va5Jk97z7lkTyWi0a/tWV6rqVXOg
         dlaSvWEr/22udnicPDFMP1kIRoRY4fcYt+V5nogbRhgL/zd13gjbEcFmBvty/JjfJwOf
         Dq5UYz8wqPiisu29CwgzWqm7YYRsPHGW6+4AOyAjLRlpGy1n7oA59IA9lVyseYXHGX/6
         ikwTcQUrlvn3yImR8ZMhMZdZoPIhRYRfGlYqlAO5jHnJBPmryX0jOk+ff1AjF5X3Txi4
         iMb1Fzv7FZGyGNNEsYOcXKPmrb2WnuKgxPTHzcqdsUMQJfN6D2/Y2eT2mC28OBJnL7Tc
         Tppg==
X-Gm-Message-State: AGi0PuZ/MkYCaHK0plSIz+XpVHvdqrJV8TH8FXjFWdb28os8jkpSRgX/
        95oNdBBiMjUPbABU6effBMs=
X-Google-Smtp-Source: APiQypJMWdkPTIZfjDSkUt+WgZsLTJRcPyyyv5bmFWOrh0YSPiG1gl8J4eujpIUG9gnhjUTcREk6ug==
X-Received: by 2002:a17:902:8641:: with SMTP id y1mr9185322plt.27.1588019004196;
        Mon, 27 Apr 2020 13:23:24 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:23 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 02/18] security_load_booleans: annotate deprecated
Date:   Mon, 27 Apr 2020 15:22:59 -0500
Message-Id: <20200427202315.4943-3-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200427202315.4943-1-william.c.roberts@intel.com>
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

