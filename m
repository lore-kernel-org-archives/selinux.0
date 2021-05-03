Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AE4C43461
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271536121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhECRzB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhECRy4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D748C061345
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w3so9193666ejc.4
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+l5WaM/XLDKsSixonjdGaNfRI3ejaxla3T48dQ0Gp48=;
        b=l0nfxgjv9uw0KKZLbm4Z20tgz73geAJJpLx3eFNkPxngU3fURL3lduzqt/FSg381hP
         xnxCuMHl1W/s9CM1ZKqL2gZjNWlOgM5owTmMQXBL/d4TMeQbZ9T9yYVxqk25Klkcfww1
         WfmkE0PGc/wqLxbu6D/Xyn0lJLs+fyVHYlo9OEwgyjgoIjvDX2k9r0OuSrVPzQf6CuG/
         bgoGxeGwXsi7eLTYTT51o4kIh9wABGsQ4YxEHDVgUytyBI3EWwwOA1Tf+FbW55UeLZHO
         xgqOpIuuGmw2iv+DQT2bTpzZgBhy3diS3jv6HPG9Y70IF5DWach3GlDC22vLH5QdiUKM
         eQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+l5WaM/XLDKsSixonjdGaNfRI3ejaxla3T48dQ0Gp48=;
        b=OKnSuGEDbO4JfvLJo6sFhOVC22QObhVn8m+sRy7Gr4VFpccHZqYS8GOiuDBpI9ZnJN
         Sq5Z4CpYKzGIUqNA60edwAndexNZj+IwkBECL7go2AVgJ3a2/LTf4EBn3icUwrffnBtN
         H/Wz+Jngyg0OZl3F7z8PHXA+vD6DGXGqrKZtpmhUdGsDJ2ZU5W/FqFbAN3pG5YYMteF+
         eRl1GIWI5LmKkhMK/2YcZOVJNbJgn4VcczVkBoEgRzlQE5y7ZoCdOvr2p4n8I+qdXtGI
         FE0lZBZWr09OWtUP7csB2WwS5jS3ayuV25VnUYdpoJQI0z67QwkIRQ8BXM4t4z4ofUsr
         QcwQ==
X-Gm-Message-State: AOAM530uLRyFq8ee8cVrco3QwbWh9IkWJserflPdQXrXK5bgTtxYOPyZ
        zx49bknefquVSQZAgys6C2xjtA/Eer1vPw==
X-Google-Smtp-Source: ABdhPJwJzU5QHnSa+3MLtPi5+7ODMEAlELVQ9rbEJw6gCQShju/O+R8RjpTzeWJSYLgC2gat9bD/BA==
X-Received: by 2002:a17:906:608a:: with SMTP id t10mr18225787ejj.374.1620064439945;
        Mon, 03 May 2021 10:53:59 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 14/25] libselinux: setexecfilecon(): drop dead assignment
Date:   Mon,  3 May 2021 19:53:39 +0200
Message-Id: <20210503175350.55954-15-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The variable `rc` is always unconditionally assigned by the next call of
`setexeccon()` and never read in between.

Found by clang-analyzer.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/setexecfilecon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libselinux/src/setexecfilecon.c b/libselinux/src/setexecfilecon.c
index e72ba0d9..2c6505a9 100644
--- a/libselinux/src/setexecfilecon.c
+++ b/libselinux/src/setexecfilecon.c
@@ -37,7 +37,6 @@ int setexecfilecon(const char *filename, const char *fallback_type)
 		newcon = strdup(context_str(con));
 		if (!newcon)
 			goto out;
-		rc = 0;
 	}
 
 	rc = setexeccon(newcon);
-- 
2.31.1

