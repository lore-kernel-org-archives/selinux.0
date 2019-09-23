Return-Path: <SRS0=61sA=XS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EEAC432C1
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 22:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6903A206C2
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 22:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EILu0exM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391233AbfIWWQI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:16:08 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:38192 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388785AbfIWWQH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Sep 2019 18:16:07 -0400
Received: by mail-qk1-f172.google.com with SMTP id u186so17187749qkc.5
        for <selinux@vger.kernel.org>; Mon, 23 Sep 2019 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=VCyyhXgwSak8shqpKiUPUHfDlITY5P/uHb52D264c7c=;
        b=EILu0exMnlgw5O4AaqEDuLiIDf2St2K/wq3alCjiuAvGKKA/h2atZ5NmLW1yyk1Vvt
         uxzcvwGdrKEMiFV5GtnE9MeFgVquhLmD6SFgiiUoFPY1jP8K0v4qNkG9YTGNMmuc4Oi7
         yCg4/DWnrvXlEjrJkaQ7nLkUWagQ7U1mZt3yeBf43HIX9QQvMNfajYk+vhOiKsmBdSdp
         IHh5IMQky84gRfYnM5DNJsaWOD1dakd84Bf8xYZ+K+2ofH1k4GMzTrwW75JYAZ8jTc2L
         YNQVWwV0+mcgeeTPGWEKqQEneNSNL4U4Dxk22X8wvpGgNzhSL5/VE9li0+pAR4MOACSK
         RImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VCyyhXgwSak8shqpKiUPUHfDlITY5P/uHb52D264c7c=;
        b=N3VBOwsRnvbQaNkc5bdgNC9mFZgnBCcn541UlTbSWCD0teBtXcS4/HDLnA/RwENVSU
         q2VEIBLJW3/qa3VGGM5qCi2uiPj2iJcvTBgk4s3THl9e9k0Rtvo2Oo4uekEjbUbTu1+X
         fmG1e5GKS2ZO6QZsUvvdE91pVHbWgXgR1FAJP1Y2jikXmCtFNkwlkbcgP1lEMJyYL1CS
         p7JRf+r9Xun3kcVjxmglFOafT8eBXy6mgbiyEucyCuaG3itBSsKMKFcitMCNnJGYEpm8
         340bc0LCOunEEFF+Hh78Y/ahmaBTAeqjo4tTJlO+AByS6ek7qiD4S2wNh44xv5F6OTN4
         V7tQ==
X-Gm-Message-State: APjAAAWy1S4v6ChskXrm2r/p3oaUS2OkFfmXOD0ybWCufxTOC17wHdzu
        Bq8Prw9VQUCInDfn/ZzNGBFLfx9jbQ==
X-Google-Smtp-Source: APXvYqwXGJZDs+FCqxkyPCICIu71I0kI6NQ/s2kKMLTaiBHuSMsD4NI1MBLzjwlhaPe8qzD8qetyPQ==
X-Received: by 2002:ae9:edc1:: with SMTP id c184mr203778qkg.336.1569276964771;
        Mon, 23 Sep 2019 15:16:04 -0700 (PDT)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id t64sm5479247qkc.70.2019.09.23.15.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 15:16:04 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
X-Google-Original-From: Paul Moore <pmoore2@cisco.com>
Subject: [PATCH 1/2] selinux-testsuite: use our own version of perltidy in the
 Travis CI tests
To:     selinux@vger.kernel.org
Date:   Mon, 23 Sep 2019 18:16:03 -0400
Message-ID: <156927696325.621177.10551869484430505777.stgit@chester>
In-Reply-To: <156927687193.621177.11371002337716273956.stgit@chester>
References: <156927687193.621177.11371002337716273956.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

Unfortunately the perltidy results differ between moden distros and the
current Travis CI environment.  This patch attempts to address this by
using the current upstream perltidy in the Travis CI tests.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 .travis.yml |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 61bb1f2..256e92c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -6,10 +6,17 @@ addons:
   apt:
     packages:
       - astyle
-      - perltidy
       - libselinux1-dev
       - libsctp-dev
 
+before_install:
+  - git clone https://github.com/perltidy/perltidy.git perltidy
+  - |
+    (cd perltidy;
+     perl Makefile.PL;
+     make;
+     sudo make install)
+
 script:
   - tools/check-syntax -f && git diff --exit-code
   - make

