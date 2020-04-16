Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A6EC38A2C
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F15220732
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f285e8BZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404061AbgDPPoW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2409096AbgDPPoT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B839C061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p8so1814535pgi.5
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPfhyaVGjlncBwrhSSr7GTZqxFHYwwKsyDxbfAgBSBg=;
        b=f285e8BZoW63OSmdI0Tz18BafGLHF+WrLZpr4ZtJBZ82kE/t46Sq1MxMFyhx/msHfV
         7mOwR3ccDPGW8K0aj62da+9o0BfsKcwXTE8OihtSIF35kQiiwYzpdzK2h6iNO/6m+i6l
         HP+K0hCyPe06LP0cNfg1K9XJ9WJ/gsO69MJBor6Ye7l2KPJnVSAfXG5HZ3XecRGDFJFq
         glGTO39Y18GFFrtA6XPvcSZECnlPO1HdbTupLmI7rEVn3Juw1q2l9zniNLDFDqZtpsLh
         zcFZfh3EDvDjGDlo7E8+V5MwgDfgHevjL5oVg8CM+l0x6sKYkXTHkQGGmMmFBru2iyZu
         AL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JPfhyaVGjlncBwrhSSr7GTZqxFHYwwKsyDxbfAgBSBg=;
        b=gcY/rwoy7KJO1aSE6taa04pylBZLFvcGLLG0fenHzmx1+RDOmbkULA7a6H7dpGNA3r
         ZnUydFTvBNfekZY9tPTNRDX3ktV9aFioTT3TaRvnyo3szE/OkcZOI3Fm9tf5ikeTIyIB
         rSZsxboIFj94VP1bBWsvYFRwRISCPkn37AWSNrZkoER05+FGzhM1a83TIRtkrjbU2X2p
         30qv4z54tewiB7F58e6/Tq/AisZ5xbS5uMjc6fZwoGpEdM28cgtz1Lln7Is7L2peX+gB
         vAyObz0y8nqnhaNKqgVGfNpPQ6Tqk4WlaTqKt/000+xAOaxQ1xP8WY51cPRVVdxJGQSF
         Er/Q==
X-Gm-Message-State: AGi0PuaoQCuk1rtmlsNwfoWBMRX5pKVKMYtQrsbXpHAq1PA2BDkPzgqt
        4kO5dIewAButpA+wvs/z5EM=
X-Google-Smtp-Source: APiQypLwdM8m0aqoOGos51FXsjIXyiGyscgEPUXSJK7E+SsWrQScdB6cmlvE7lQW6PXvmfRvTtrPFQ==
X-Received: by 2002:a63:e749:: with SMTP id j9mr31412493pgk.319.1587051858817;
        Thu, 16 Apr 2020 08:44:18 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:18 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 07/18] sidput: annotate deprecated
Date:   Thu, 16 Apr 2020 10:43:41 -0500
Message-Id: <20200416154352.21619-8-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416154352.21619-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200416154352.21619-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/avc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index c5c842a34470..472f6918ca83 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -76,7 +76,7 @@ extern int sidget(security_id_t sid) __attribute__ ((deprecated));
  * zero, the SID is invalid, and avc_context_to_sid() must
  * be called to obtain a new SID for the security context.
  */
-extern int sidput(security_id_t sid);
+extern int sidput(security_id_t sid) __attribute__ ((deprecated));
 
 /**
  * avc_get_initial_sid - get SID for an initial kernel security identifier
-- 
2.17.1

