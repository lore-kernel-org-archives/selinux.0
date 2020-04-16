Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC630C38A2B
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D1821927
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHn2+5Zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395447AbgDPPoV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406241AbgDPPoP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC86C061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id ay1so1498239plb.0
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bw9tlQSVaapo0Tpj45xIpZF0qK2BZ6nzqw95EBFXPX0=;
        b=MHn2+5Zdo2dnPm+gJ36/DYK90So4XLaFzj0Q7rv/MXDh0BEmi9v1BMa2+XcW/sU2Fy
         66mZ+t+vtBS2eqIIDJI+6ugxb2pYEhdwEiGG2vEh0IEecNG5A0H+FdiruK4KKrfy3hNm
         +67iBVReyye0gfpsj98Xq6+FiMOBw2VMyVu/mrX1l/rdTbHuaGwlWyhak9s8EhnHwWU+
         m1UcxLsMX7PZ2Z0/lHR6F5xSRMxVAsQIyUM1JIiHm4Tjwwf70MCPUuc5fl5/oDmRYcbv
         Hd0MxWl9wiMKjcXMeoK97EvJJZdL/jAy0JB6YDIg2OF3lA3GfbHDU3+QnYRF4DLOJfeb
         raCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bw9tlQSVaapo0Tpj45xIpZF0qK2BZ6nzqw95EBFXPX0=;
        b=TsRrZOvaQaYVUq7DTAM9k0WIdMBQdQbV3oMmakOToU9nK5rJJq5G/uhq2c02TFPyxI
         +j9+5rDt2AeQd8w5K0nf3/syvoi9c5DtfMhDcCF1Yrlab4ZkhTrPWNd4D1isWTO9UYW1
         kXgarifyAKnGdGDyHaLN5oOvvfyaavnvf2p6IcAZAVuI0Lvu3qoDCjIKCJec0TwdZ3zn
         xXp1wo/i8uoXfrxvaz43Clm4kcrVMEsaIvSCYb7AOLWDblg63p8kLseLRzELClZSQNbu
         sSW6k4ityThraeMt5ZZ9Vh53iaYy+s27Ci2Js2U6Omec77V5OOo69eaH68tdPTgyvGx/
         s/UQ==
X-Gm-Message-State: AGi0PuYUHTwT0r/MIRCxLeNyokavwFLZm6M2sq23PBpWWukx8bli1vFO
        GFO0RZy+6NZc2/K0e1NFggU=
X-Google-Smtp-Source: APiQypIJOcmcGmf71M+6V5GmyN/DLibDhRySrjtk44rKarJVW7F0mqEoCsrr9pIhEPTEuCYGug185g==
X-Received: by 2002:a17:90a:252f:: with SMTP id j44mr5823493pje.9.1587051855052;
        Thu, 16 Apr 2020 08:44:15 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:14 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 05/18] rpm_execcon: annotate deprecated
Date:   Thu, 16 Apr 2020 10:43:39 -0500
Message-Id: <20200416154352.21619-6-william.c.roberts@intel.com>
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
 libselinux/include/selinux/selinux.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index cf2b81ba3162..0b99850ad23d 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -633,7 +633,8 @@ extern int setexecfilecon(const char *filename, const char *fallback_type);
 /* Execute a helper for rpm in an appropriate security context. */
 extern int rpm_execcon(unsigned int verified,
 		       const char *filename,
-		       char *const argv[], char *const envp[]);
+		       char *const argv[], char *const envp[])
+	__attribute__((deprecated("Use setexecfilecon and execve")));
 #endif
 
 /* Returns whether a file context is customizable, and should not 
-- 
2.17.1

