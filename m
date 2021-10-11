Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBD2C433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FDE60E8B
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhJKQ2b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhJKQ2a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A25C061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d3so42460234edp.3
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=moXSJDzCpBBgzSNajQ08xJDyEqF1htrxYCt/Ai68WKI=;
        b=RjWVPnSe9Yo7DIlRrbyFw36uBiAUmmkIotIbz6/aQL4MdMmRyjk4iq26YR8G2UOzni
         DJnfREYq6RojZT03V9aD/1UZantKBi/j79a/M5WWMaXaiDjOJ7xC1dP9CWlu8YuO4Wqb
         O2jgyFF/o+eJW+uSxbi9j8Bwj582kDZLex7tk3JdZcvw0UaCdXcYGpbLGl8bUG9/YPzD
         0C5otNM6AQwObLgFXUHJKak8Jb75WPE/Is95MXrnkmN02vCLLM0o9Z9+6NmGZN/n1x3H
         vQfk7KbsF/vPl2JPQck+pO/74oTz4Nvt31CT9DHTYihmNZ4S+mARqnKaXCx/XAvx55j4
         9bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=moXSJDzCpBBgzSNajQ08xJDyEqF1htrxYCt/Ai68WKI=;
        b=mFNn0/jkX9EQ6/OKq+trOxOlI1k+Q1vDM1fxqbMDCfjO9tLe93uZxn0OxA7nuEn77b
         I/Yu2T/ZGw84oFTsHzzaIMyJBkDQtu2ZwfQ2b+L/LdgFsWDTaiuTJXZOivXyRZ17SyZr
         HaGpPJ36AIBUIZTLFPrswlun3JyFxLXAG16he9alxDQAnJ6qWUMQUabEI0fuaZGhqxnv
         JSd5nNB+Hr2ZPvw1c27CKiTZ/tdh1mtZbirZ7C4jR2TgApJlg2S2odJUumky9AYC2dC/
         OlcxAs7JHBGm6PVxFtqs9UGuzG2RpqjzVIVnFB2UAmeTvT8EuX1UfXXjrXQDQctizVsX
         Fsig==
X-Gm-Message-State: AOAM531rSUwz/mNc7cm2pdaMOcKDUNMu/6Eu0nhO++lIhcFQ9rXhrtMO
        h5w8iGaeZ/wyjfb+4WLcNKoZDeXA2u4=
X-Google-Smtp-Source: ABdhPJx6heHnKV9Eu+bQ0CSCX+pqCiKOBYEjDsff12nIFfQMxEpujU/7oQ9swO5KJ3K7rWfDiO8+GA==
X-Received: by 2002:a17:906:3510:: with SMTP id r16mr27273597eja.209.1633969588918;
        Mon, 11 Oct 2021 09:26:28 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:28 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 14/35] libsepol: reject invalid fsuse types
Date:   Mon, 11 Oct 2021 18:25:12 +0200
Message-Id: <20211011162533.53404-15-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Reject loading a policy with invalid fsuse declarations, except xattr,
trans and task, so that all following code, e.g. the different output
modes, do not need to handle unsupported ones.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 70b503e1..980af059 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -48,6 +48,7 @@
 #include <sepol/policydb/expand.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/avrule_block.h>
+#include <sepol/policydb/services.h>
 #include <sepol/policydb/util.h>
 
 #include "kernel_to_common.h"
@@ -3099,6 +3100,14 @@ static int ocontext_read_selinux(const struct policydb_compat_info *info,
 				if (rc < 0)
 					return -1;
 				c->v.behavior = le32_to_cpu(buf[0]);
+				switch (c->v.behavior) {
+				case SECURITY_FS_USE_XATTR:
+				case SECURITY_FS_USE_TRANS:
+				case SECURITY_FS_USE_TASK:
+					break;
+				default:
+					return -1;
+				}
 				len = le32_to_cpu(buf[1]);
 				if (zero_or_saturated(len))
 					return -1;
-- 
2.33.0

