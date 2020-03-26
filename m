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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3450EC2D0EC
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E48020737
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apsTpayE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgCZPqw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:46:52 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:40227 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCZPqw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 11:46:52 -0400
Received: by mail-pj1-f54.google.com with SMTP id kx8so2561197pjb.5
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=379I/KUxSx4oNFrnAUGdjmHQN7B3tOrpWyok/DGd000=;
        b=apsTpayEXTPN8h8QXSJ925sh6Djl0z8w7Iy871P3ma8HV6U7fakeSwHG2q804jqSDB
         E2drn2bqbT88p9icmXFNfu+HnD5ARnTiv7tbyy4aEHcluKSPQgzWYeZDBiytxxBBB2dN
         jsaTf2rY+uzBreJ7aJa+gDEX1QxgGU2tqhD8kR0VC2xlccfVLEE97prwLJ+5XE5I/9TX
         1y4kjNBHbYHFHt7vNjFtAwE+oZGnFtH5+OWdcLPBG5tQKJX5i6Jd3I7HEbVD/FUBSrBN
         sXe4aU5xiE3VeeQRhkn4plIcvovDBvRDg1jWwN0uEgpBvOjvBcmva+DuPkclpsf/qs/T
         3/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=379I/KUxSx4oNFrnAUGdjmHQN7B3tOrpWyok/DGd000=;
        b=cf4aiX+4BR2BNxMYkNgp29sptpbZ3tT+Tn2jiggC0Uunm9a6eo99ibSIVM1rDe+uoz
         4fyuDU9yjrodkLIKlvXC9MM43VaQ3dEOLOq3p62mQt+vyVNgyRcU9ZcsEzzDFU9A83EU
         x0zsGkLs1Rs4jfsD0Wp2EP2AXQALRIEChgzEZ4ujhn0myxNNKMQ2qLgzP4KAoSl1EZ9C
         SLaXo88kGrtA3qpzBONMYakWPYDSp5IEqTh+tXZlJYNENSQgQzLFoQCv2YZEOivg6tKW
         ha+0VK3LFnthWXKFWPkOfe/Iar5wiZkLkL0ZEb+TwWwf3ZSney1YfMDPmiNASEsyPlI2
         OiJg==
X-Gm-Message-State: ANhLgQ1hLUFOcS8Z3589cSVF3TMVUAezHoFqFiTZ51S2JMs0LTgf9P15
        P5jZvY9V3QunLDHVR/M3ZVQ=
X-Google-Smtp-Source: ADFU+vsQ6Ide3bJBqoo1WzYEYvG7aLXCMqaTcJFAJdjwn5Jfyrj1BkROK53J3bPCX9xsMJ6pzrTHqg==
X-Received: by 2002:a17:902:ed03:: with SMTP id b3mr8290896pld.247.1585237611045;
        Thu, 26 Mar 2020 08:46:51 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id s62sm934359pgb.94.2020.03.26.08.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:46:50 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     joshua.brindle@crunchydata.com
Cc:     bill.c.roberts@gmail.com, omosnace@redhat.com,
        selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
        william.c.roberts@intel.com
Subject: [PATCH 1/2] cil: rm dead dso.h file
Date:   Thu, 26 Mar 2020 10:46:40 -0500
Message-Id: <20200326154641.7253-2-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326154641.7253-1-william.c.roberts@intel.com>
References: <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
 <20200326154641.7253-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/cil/src/dso.h | 27 ---------------------------
 1 file changed, 27 deletions(-)
 delete mode 100644 libsepol/cil/src/dso.h

diff --git a/libsepol/cil/src/dso.h b/libsepol/cil/src/dso.h
deleted file mode 100644
index 64a162cef86b..000000000000
--- a/libsepol/cil/src/dso.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef _SEPOL_DSO_H
-#define _SEPOL_DSO_H	1
-
-#if !defined(SHARED) || defined(ANDROID) || defined(__APPLE__)
-    #define DISABLE_SYMVER 1
-#endif
-
-#ifdef SHARED
-# define hidden __attribute__ ((visibility ("hidden")))
-# define hidden_proto(fct) __hidden_proto (fct, fct##_internal)
-# define __hidden_proto(fct, internal)	\
-     extern __typeof (fct) internal;	\
-     extern __typeof (fct) fct __asm (#internal) hidden;
-# if defined(__alpha__) || defined(__mips__)
-#  define hidden_def(fct) \
-     asm (".globl " #fct "\n" #fct " = " #fct "_internal");
-# else
-#  define hidden_def(fct) \
-     asm (".globl " #fct "\n.set " #fct ", " #fct "_internal");
-#endif
-#else
-# define hidden
-# define hidden_proto(fct)
-# define hidden_def(fct)
-#endif
-
-#endif
-- 
2.17.1

