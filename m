Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4CFC433EF
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D950160EFE
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhKEPcZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhKEPcZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:32:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B68C061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:29:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f8so34563702edy.4
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bi0QwuruKmi7pIXFO8mudiuLNNz5CAYIqS8ARjP7CBE=;
        b=M6B1QchW53qhnHD3DhYM/Z0uManQGRrrdRbstJJGByATt5uBFFXl7olRNgKefq7tnJ
         nW+ZFB9fu+RXdCOx8WOp8DPsbpt/XAh/7GBh/560qCGWcOuLTSELp8Tgik9XI+/lGSea
         WV+UAW1AfHRREko15xk/Nx9fu2ucsEk550VtWJqv4ng/LEsP0IwjIRW+iwjvYcM8R7/8
         HFErLhlsrFvhXP9QMIU18punyva0GFcGpi2k0rXPcRRtXZcek6jsKF0RoTzMuZGZTW2E
         Rm6+dSRMLpRZGLQPaZBdlDQGKkX9RKHLgUah5pT34E25pjgYJlqAg8WdcR+UMPdVLw20
         DUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bi0QwuruKmi7pIXFO8mudiuLNNz5CAYIqS8ARjP7CBE=;
        b=mRwAiRXLw2+0KfFRrF4ggLKkH5oKLvJY3yFyLNDJABhBWTKqVemV12I2MH8h4fkXl7
         lEhdN8qdd2Q42HVL8AOetQT0HN53F1v48adgAcCvSPPQHjIJ9H2rz20Av5WuzEcUiu5v
         uJxy7CBsPCOYjLt+uYzFr7Gnu+ZI1DTww4IjhrJHt0wmT5KVqkzPD4g3sMhL1yRGpNha
         MJyh+kYYmsJzvOrpK0fUF/PnjubAMBzLySdxjHdjJop+smBiJh5JobtWfaVLqXMeaVO+
         hv06u9hq8cZbNCgqUK3h7Zvc/ftSmQ/TyQTNt8bLjAHq3wvsz1CpGYeeNn9p30DRJ7mB
         sZsw==
X-Gm-Message-State: AOAM531qReOottMZlSgc9PhbtVSLDporbycGvnFdI1l5YUjNnRMad/Sw
        ZJ5udVhGEoNTd/jInP9Ed1iHaHkE6D0=
X-Google-Smtp-Source: ABdhPJzOZVfbk5Sq+XEr7rq6OiLL3Kj0KanIHvECId3ygcgspmkFYIGTv6RRkXR+8hg6NILzEqeEDw==
X-Received: by 2002:a50:ee01:: with SMTP id g1mr52523737eds.389.1636126183932;
        Fri, 05 Nov 2021 08:29:43 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id qb21sm4749799ejc.78.2021.11.05.08.29.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:29:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libsepol: avoid passing NULL pointer to memcpy
Date:   Fri,  5 Nov 2021 16:29:37 +0100
Message-Id: <20211105152937.36412-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211021140839.7439-1-cgzones@googlemail.com>
References: <20211021140839.7439-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

memcpy(3) might be annotated with the function attribute nonnull and
UBSan then complains:

    module.c:296:3: runtime error: null pointer passed as argument 2, which is declared to never be null
        #0 0x7f2468efa5b3 in link_netfilter_contexts ./libsepol/src/module.c:296
        #1 0x7f2468efa5b3 in sepol_link_packages ./libsepol/src/module.c:337
        #2 0x562331e9e123 in main ./semodule-utils/semodule_link/semodule_link.c:145
        #3 0x7f2467e247ec in __libc_start_main ../csu/libc-start.c:332
        #4 0x562331e9d2a9 in _start (./destdir/usr/bin/semodule_link+0x32a9)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
  include length addition into if block

---
 libsepol/src/module.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/module.c b/libsepol/src/module.c
index 02a5de2c..b718751e 100644
--- a/libsepol/src/module.c
+++ b/libsepol/src/module.c
@@ -293,11 +293,14 @@ static int link_netfilter_contexts(sepol_module_package_t * base,
 	}
 	base->netfilter_contexts = base_context;
 	for (i = 0; i < num_modules; i++) {
-		memcpy(base->netfilter_contexts + base->netfilter_contexts_len,
-		       modules[i]->netfilter_contexts,
-		       modules[i]->netfilter_contexts_len);
-		base->netfilter_contexts_len +=
-		    modules[i]->netfilter_contexts_len;
+		if (modules[i]->netfilter_contexts_len > 0) {
+			memcpy(base->netfilter_contexts + base->netfilter_contexts_len,
+			       modules[i]->netfilter_contexts,
+			       modules[i]->netfilter_contexts_len);
+			base->netfilter_contexts_len +=
+			    modules[i]->netfilter_contexts_len;
+		}
+
 	}
 	return 0;
 }
-- 
2.33.1

