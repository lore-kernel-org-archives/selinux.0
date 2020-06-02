Return-Path: <SRS0=4SPy=7P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ABCC433E0
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 18:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F2E2065C
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 18:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdhNtYO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgFBSzQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBSzQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Jun 2020 14:55:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE601C08C5C0
        for <selinux@vger.kernel.org>; Tue,  2 Jun 2020 11:55:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w20so5511762pga.6
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2020 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/1XW2hakziPKWJwrswQ7kGYMr6zCxyPWGSeh+jj6XJs=;
        b=XdhNtYO/vpp73v7iAFbam5HdL5RkxkbxYrOw0dCtPgz2MyCG4Bfk3K8pHAvdy7dlqH
         NOMVVvJlMpnoBZXCh5gwLL881dklzrTLmFN8PtWd8B6GH4DvJdARQZ3ngQkT2KxzEDNO
         rFhxLWyepx8LfaZfWC6MtdRHX5BCKg1dwV3QrFKrExSIRAgnyBjX4XIdq9mDQINwHh8s
         6d0mEVTTk3eb1oRe6L632mH4z+7ZYuCGE2lFiWDNdImEPyIAANyBFhNql9DLIB/LIF77
         aA0o/oUvxeEX8LCIxVhELNOiLTFydeRvDsgZmkOFXeeQomeqitZfhgq5bCjpL8PHyDq5
         JbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/1XW2hakziPKWJwrswQ7kGYMr6zCxyPWGSeh+jj6XJs=;
        b=mCD9191DXTKjIwbigPXFCVgMGOpRMBsXq9qYcqcjNWltXE/7Ml8bf8McMpnDyi+Wpb
         CgUaX0hPDTmzBYVnJ9aD6I6jmVzQ/WRK62I7LvlA3Yku/1NM3+XY+7D9oyj+ak8UBCJE
         jdBDe7c7EzkXQ+7JuPIY0nB+IRgfz4oaykSWP1G5HNr2m2kkX6E/2AXzzHs1rfKnaWd5
         aNip9vaqr2+MPREkBACGAtiAbHWMiyaEZRn9JTDygMdU2XFRL+LGw7ILZJTxUL3C4mn1
         WvX9HG/yjCD+BjGppNn+/di0Jym2xcNPmxc8CDtmezaZmoahAPY/HUjW56JOm+eYQPJz
         +b8A==
X-Gm-Message-State: AOAM533e80BQ22obTozDbZgUObNSbScsnZLfhda9zVX88tKBcI+x2TCR
        jwlOyV6Qcw176jBXrE6Vfwg=
X-Google-Smtp-Source: ABdhPJxcfAPqn9wjRngou18g0eHgJe9Ic+T6hm3hvMqjqFhGyl9kdgMDFvlvLX/AHQS5vPrqT5ckQQ==
X-Received: by 2002:a63:5f83:: with SMTP id t125mr25741735pgb.104.1591124115380;
        Tue, 02 Jun 2020 11:55:15 -0700 (PDT)
Received: from localhost.localdomain (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id q18sm2762842pgn.34.2020.06.02.11.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:55:14 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     plautrba@redhat.com
Cc:     bigon@debian.org, bill.c.roberts@gmail.com,
        selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] README: start a section for documenting CFLAGS
Date:   Tue,  2 Jun 2020 13:55:07 -0500
Message-Id: <20200602185507.3784-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601093453.GB30453@workstation>
References: <20200601093453.GB30453@workstation>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Start a section in the README for documenting that custom CFLAGS yeilds
CUSTOM results and that your mileage may vary. The first CFLAG to
document that you likely want to include is -fsemantic-interposition.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 README.md | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/README.md b/README.md
index 9d64f0b5cf90..f37a9f91f51e 100644
--- a/README.md
+++ b/README.md
@@ -120,6 +120,17 @@ lacks library functions or other dependencies relied upon by your
 distribution.  If it breaks, you get to keep both pieces.
 
 
+## Setting CFLAGS
+
+Setting CFLAGS during the make process will cause the omission of many default CFLAGS. While the project strives
+to provide a sane set of default CFLAGS, custom CFLAGS could break the build, or have other undesired changes
+on the build output. Thus, be very careful when setting CFLAGS. CFLAGS that we encourage to be set when
+overriding CFLAGS are:
+
+- -fsemantic-interposition for gcc or compilers that do not do this. clang does this by default. clang-10 and up
+   will support passing this flag, but ignore it. Previous clang versions fail.
+
+
 macOS
 -----
 
-- 
2.17.1

