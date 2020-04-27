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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF9FC4CECD
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30BB8206E2
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLnQ4OIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgD0UXb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbgD0UXb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9918DC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so121776pjw.0
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=81qiqqHZ0AyplMqb6jelzpOhXR4sKkoaMjUETNEc6io=;
        b=BLnQ4OIcjMkUPEOd+5+0g1OjRSulTaeC3sfLKyuAd6p6o8tFX1zoFFGN9rvAlWs0qn
         zQI3v0wip6Btk7Phwfvsksz4b8y34ogFDpHlxAIn+rkFn30fwrU5kIHV6O063BEcXSpZ
         sYNQWcmatKZvNu7Nv9hUuqSsnFhN/OanDzZVcXLQbXaOSlQ3/ovmYwip4qBJVja04kdK
         x6uWPI0KAmwUqpHcUVfIvJcNNjIvkGw89ipoLgtvvvjmhwTVPHcRxT1SJde33xKH6+3v
         MM8eDSsvhoe4c8YeHe33Ni0yELzUkHC2jyTvKY9qk8NZvhAZJ+iRCSUJ1RHxhZMZX7vL
         jCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=81qiqqHZ0AyplMqb6jelzpOhXR4sKkoaMjUETNEc6io=;
        b=o3GBzkOoE0ywnnxz6dAhYENz6KZY9FP8L4F8PTKGMdsn3O8I0Wh39jZi5msiGNVogh
         57EurvUeEcvkGhW1dlcIWuUVxkOzq8J6WwF4oKc0nnuTRTzA/9mnqncg5c8CHsp5G1Nq
         O2m7cgxszh1AtclGl8CYyp2QovuWEDBwEH9HhEmX6iAp2/SnguZ6grWLAGqgHWJ/mazn
         v4A+K5R5i/IaSGTPeMV75e2NsqKMFDx6CRQA2YTJslnNkDzcJ5CcWlyopIxdV4Cib/U+
         vyD5TbNBhsIwUW0vJjo7L8/kH+Wn/WOaRZfkGnzHtuqIq/U9JvmkYLdFb/KXksB0NdV9
         7Nkg==
X-Gm-Message-State: AGi0PuYha4qICWqi3oTvvjUQ5VKDPH7r7hi0QfW1qwkMdZ40hiDAcDMt
        I1MF+WXuxwZ6ZHKOfKoIJgx738H6UPo=
X-Google-Smtp-Source: APiQypI8HxD5i6fJ0aXnWu756avO2hYmR0ixy6G+usrRDV2YlXFCN5tBeJjSZlk27w6gL4cBUgi3zA==
X-Received: by 2002:a17:90a:1fcd:: with SMTP id z13mr465840pjz.151.1588019011087;
        Mon, 27 Apr 2020 13:23:31 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:30 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 06/18] sidget: annotate deprecated
Date:   Mon, 27 Apr 2020 15:23:03 -0500
Message-Id: <20200427202315.4943-7-william.c.roberts@intel.com>
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

