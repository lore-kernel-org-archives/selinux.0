Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067A7C43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D241A2076A
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK4tYDed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgCZPqy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:46:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38157 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCZPqy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 11:46:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id x7so3065765pgh.5
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V4R+2m0SslUGosRISq6fCCA+ryxQy4LzW0+qTno59YM=;
        b=EK4tYDed7I7TmVsHNQj1MaFauow+Ghv6fqyuMS07YEsVKzuvpmYC8aNlsGECyYuLFc
         Tqmd1RbLPbMEjkSljyDU/I121wxz7FHXOMz6oCV6Lg0xAGaKIniaqBwRco183AcyOHkA
         iL7/oCx5yHI/0h7QntTbvKYzVn5/jXWy2TQjlgUcnsnUY6v4bahw3YtqsyBVK/27NsVC
         +HFAxjW41nOrvOsqf7nZE76a6+3FA+NkvG4prvGf0bbm7FuXe4LGkbllti+CTvJ9HCNE
         NUDOK0yaKMVitrbwgDuwbJ/F3becam2bYplT/VyOEHCFamaEg3GZQWdFK6ZSnrCnW3fJ
         va3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V4R+2m0SslUGosRISq6fCCA+ryxQy4LzW0+qTno59YM=;
        b=kncLefPWDlpc0DUMun8jTMi8Zoh8z3Jzmr86hsMz6zJtWRRsz9GLBZILgdYj/wVZFh
         AeZK6hibteOkH3zPqYDsRUfnOnE5GmtzbGy1deK1ilI+B5W/cYPLu9VirzNpmkJhuB86
         Fh5q223kgeSU4CVcCrl9dTh/D+4gnN6M6ZZr5P4ZJBRLg27oUiwem+GhstPqYy+hgDr5
         adpANfaglJRPavW1pEaeoeIBi4MReuwADXqJt15/1wDpQ7SFEex+yogXvJf6FkP7apbz
         rIQNB5CetDxI7knQYsLPAv0PW9dLS5pjQkzOWS7SsKdVurUrfbnJyjKMmFiCBzLJlIGt
         zoIg==
X-Gm-Message-State: ANhLgQ02fczXDcYxAnU034dazJB95XPgVhuM9/drpPi+HmvjA5SnS2ha
        FOLGRVFKhiYCDnH3R3wkmY66WwN8aSE=
X-Google-Smtp-Source: ADFU+vtO1JNXl/bpTpred2fBL/irZ8mZitbgWHMcAxcAmQNgFVWGYocTs/mFWspPQDhSvA+/S7c+0A==
X-Received: by 2002:a63:257:: with SMTP id 84mr8877052pgc.304.1585237613000;
        Thu, 26 Mar 2020 08:46:53 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id s62sm934359pgb.94.2020.03.26.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:46:52 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     joshua.brindle@crunchydata.com
Cc:     bill.c.roberts@gmail.com, omosnace@redhat.com,
        selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
        william.c.roberts@intel.com
Subject: [PATCH 2/2] cil: re-enable DISABLE_SYMVER define
Date:   Thu, 26 Mar 2020 10:46:41 -0500
Message-Id: <20200326154641.7253-3-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326154641.7253-1-william.c.roberts@intel.com>
References: <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
 <20200326154641.7253-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Fix issues like:
<inline asm>:1:1: error: unknown directive
.symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0

Which was caused by the DISABLE_SYMVER define not being defined
for static, Mac or Android builds.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/cil/src/cil.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 12cc28eff389..c8e27c04c954 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -51,6 +51,10 @@
 #include "cil_policy.h"
 #include "cil_strpool.h"
 
+#if !defined(SHARED) || defined(ANDROID) || defined(__APPLE__)
+    #define DISABLE_SYMVER 1
+#endif
+
 #ifndef DISABLE_SYMVER
 asm(".symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0");
 asm(".symver cil_build_policydb_create_pdb, cil_build_policydb@@LIBSEPOL_1.1");
-- 
2.17.1

