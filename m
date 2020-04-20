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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CECC3A5A0
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061D12078E
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU3JTs3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgDTPqI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgDTPqG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:46:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6307C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so27212pjw.0
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/gdQpJrLZSitamhMTzbbXA6Ho/ldV9+TjII6aENSShU=;
        b=GU3JTs3HbFtvHvNS2hjEWIJWM5zbwmrzG+0qG9JRNvdzpy9WLaA9p9bRIGR7Fkv1OI
         fQ2Ccln59zJCu4/klsYhgOdAhXp+Hm3Feq/DknWK6dLZsyemZAS1hAu1ZDWAYoc2L6aU
         yxtwD+2LKByOGJ0XfP0J3S/eyxeBQ5RV1d0o6dmVIjSTjTUfxmftNI+YizufK510aYZ7
         Wjaq75/YHgHJC4OCEnK9ifz1DMsiqEsx7aHYAm5oDsv287UP7B3SfCzo4sYEx1TEqmGa
         9pCFQXy+yTA7hhzFW5mFU0KONYGM+KMLKkzSUrLgUAZDGQGPYwoR2wfuLYLLXY5Trm+W
         yRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/gdQpJrLZSitamhMTzbbXA6Ho/ldV9+TjII6aENSShU=;
        b=ALXjtRTjZ++6fCvRLzkjXRGzVqqbzUM/gD8m8FsvcltI19spj/rPJv4r2GU9A/gvQG
         ZB+iQgc8xtwoHwEVVlHDEtPIBVJRCnqFYMFYKC4P/QaYcEJDMcE7Au6WbIKqCH/qFE2z
         ob55pUxumkGm9a3QrnN912BCv1PJENEC2thCyWW+eM1HZtsJ1TnCb2g/PCcZkg5//n0A
         T7tYuwI4fPRKAb3q14iV3ppZux7mauwDEeRZ5XbFxkMbP4pjRlm3vvnjlb19BqdBqy6o
         SBb7rUoZ4ZEeunYYmftTTuXigev3hnDmsaXeGV6KY/7tud0cp7jUrFqtvMD7+mKSNdtR
         owrw==
X-Gm-Message-State: AGi0PuYh0CIwhkMrQvi836gkHZH2rkKAffqEtA+F8qcLdk8Shnr4ZJFz
        sO0FI62R5X/J00Ij6QpOPNI=
X-Google-Smtp-Source: APiQypLcEqwR8fZte9S2DwbpghmeyvjAjgrleZep6V0j2b5BD7DVvzy04IM22whyK9mdId/o/Y7OSQ==
X-Received: by 2002:a17:90a:be12:: with SMTP id a18mr14015pjs.162.1587397565431;
        Mon, 20 Apr 2020 08:46:05 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:46:04 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 10/19] matchpathcon_fini: annotate deprecated
Date:   Mon, 20 Apr 2020 10:45:28 -0500
Message-Id: <20200420154537.30879-11-william.c.roberts@intel.com>
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
index 940c43eff8c9..b04f34a1b3bb 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -476,7 +476,11 @@ extern int matchpathcon_init(const char *path)
 extern int matchpathcon_init_prefix(const char *path, const char *prefix);
 
 /* Free the memory allocated by matchpathcon_init. */
-extern void matchpathcon_fini(void);
+extern void matchpathcon_fini(void)
+#ifdef __GNUC__
+   __attribute__ ((deprecated("Use selabel_close")))
+#endif
+;
 
 /* Resolve all of the symlinks and relative portions of a pathname, but NOT
  * the final component (same a realpath() unless the final component is a
-- 
2.17.1

