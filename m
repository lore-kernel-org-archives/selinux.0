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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84B1C352BE
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839A620732
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwaeEWAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395495AbgDPPoc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439129AbgDPPo1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:27 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BF0C061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:27 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id z9so1531835pjd.2
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYDpnOO9HSE5if04ORcNe1FlF4m09kM1ja7Zo3O70HM=;
        b=cwaeEWAKArGMuxWNO6McrB6tOdXImAT+AxuipY5tlfkSTetEjRiIk9GlNAHa63MVwD
         HrZwHVkVWUEG2SG/vh2IZCuWteV6fp8XbDD9U18gTlkEdOnkFOzaNkqpQiE6onCMdJGa
         NtTH38GQRwteB+Mm0oRMsBh5CPG/D8HSw5F+iMJPeCDFvTvR4zSrF6doI8aNdgkVzB13
         qsM/v0vYerkflmu6SXWWRgygrcwyfRTuE4/V1rGEzeknJElsJS4kYwXgWtzAnIbhRqHE
         x+5qoKakiDV4Ay09dMIppweOXaSURZ5SGw4TCG6/HGze080hR3wK9qKKXtiEcpY1R6vZ
         fzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iYDpnOO9HSE5if04ORcNe1FlF4m09kM1ja7Zo3O70HM=;
        b=PRt+ajYVYaIrUcgeHXH2+fiUfa5NwGEVcw9+SfP5TiheGvTo9K2zkx/WQ0OyqfipRb
         uxJlMtyZwnzKUabp/G6idF1uIRSYFAMEiiXEUkJLncbPBSNHH5HVGzHFC/yselPvguqi
         o5baazz7lTD+N1usl57V5/gvQz4OWmCOsKwt6yHE2JhQW97BpVymhJ5lL6PvXFOGgqnQ
         mp2k1mb8uHmXIr1IHCkliN7wIdmHPGNS+7UIuee3vPJEuq5G+i0nZongfMIqlgF2kX61
         /A0thHi9+Z1ARTDXH2ogrJYVRchFOCfSgGfFMuk6X5elsuX4of+BR8Q3EMjQLYoMQ1Y5
         0eZQ==
X-Gm-Message-State: AGi0PuYxoe6ee6wobKKvPTNennAwfyLnnK/87CbI4qqnwr7rUEVz80sM
        Sqf4+ywugT/ccbVlmeZeQ5Q=
X-Google-Smtp-Source: APiQypJHzPOmB0dlEaUpgCBXWMFQ2ed3SH4aqE/woMLllIkc74+1udEDbHwQFmwYBIrhE0LW75VASQ==
X-Received: by 2002:a17:90a:d3d1:: with SMTP id d17mr5777045pjw.191.1587051867090;
        Thu, 16 Apr 2020 08:44:27 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:26 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 12/18] avc_init: annotate deprecated
Date:   Thu, 16 Apr 2020 10:43:46 -0500
Message-Id: <20200416154352.21619-13-william.c.roberts@intel.com>
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
 libselinux/include/selinux/avc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 472f6918ca83..7487b62f41c3 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -192,7 +192,8 @@ extern int avc_init(const char *msgprefix,
 		    const struct avc_memory_callback *mem_callbacks,
 		    const struct avc_log_callback *log_callbacks,
 		    const struct avc_thread_callback *thread_callbacks,
-		    const struct avc_lock_callback *lock_callbacks);
+		    const struct avc_lock_callback *lock_callbacks)
+	__attribute__ ((deprecated("Use avc_open and selinux_set_callback")));
 
 /**
  * avc_open - Initialize the AVC.
-- 
2.17.1

