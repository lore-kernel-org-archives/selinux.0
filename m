Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6188EC54FCB
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424252078E
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSgxp5t5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgDTPqA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgDTPp7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:45:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847C7C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so5249081pgg.2
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iWBKLr767QxmWMyFc4HKl4BlgOIXWmOpWn/1VxJuI+0=;
        b=PSgxp5t57I0Wo5Ty6/uorB8Hvc3WzRMdS06yQpLC8RhT5dTgbQF7KSaGoGAwkdWjJD
         GOKUjqP9EWLBKYmw3XJZBImunJQWhsZucMzSpWyOXwo/4YSzrotLERc4xQedOCzWUUT7
         mC6a+AUmL/ShS29wGjBCfHGoIJ3VWantCvKcY9BbHstzISWz2hHv1pNDzQYkUoYny/k0
         xOg+ZMbvEALsoGOwTQUE75FJa+j7yrInXgtN8U8wbqbhzCTGUnoMPLMnS1pVcCclFH48
         k6a/3v+NU4vom+aS9rbNNrKc44LVaxLkhNZ6j6SDQCK3/fCQhnjUhj76GunwRQEZ9MTQ
         YjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iWBKLr767QxmWMyFc4HKl4BlgOIXWmOpWn/1VxJuI+0=;
        b=SQuRSrIxDrEDInzq1nH9dmIZ20jEnrKeOI6DaRIfI7R/zoYr2dnTN6jpnEAb2KxwhX
         yaUTwChiCn/IOtzGDZsJ6lViQkSTpagTdqWJS6zuvWVquwu0y7rfpTzfbbruC1Y+1VDW
         dd7hbVmPSO79Wz6uLy0dJ7Tv9p/vBNRAdMvV5Bgr6UYHM+kukO6WWZLtiD3gaaBAJDqo
         os0RLwg6C3Trfypqx4vc4jiq4G7XlUIHJimgojKYSgPkzhaD7q5RwJjBulnn+GRQ3Up8
         tDHz/Tl6ZlhaenHwDJX8oj/5QUCn7O+mVTYWU1o2XGGFQEvHJC9inOUah/yUsvYaPZfy
         PoFg==
X-Gm-Message-State: AGi0Pub/2+OjQ5HWVrwwN/ggtA+Hh+fl6QtpWznZ5WT5j7PsiD5VEgtI
        eWb2ZvBtHDR0Wq0rb4K4lNxmiVddNR8=
X-Google-Smtp-Source: APiQypIIld8KLdb/9UP1CySBdyCmtvGolpAQ2KiOjQbY+XGkeAbO/p1MacIA4uhYBFWp/p/UJM6KBA==
X-Received: by 2002:a63:4f23:: with SMTP id d35mr16307977pgb.197.1587397558978;
        Mon, 20 Apr 2020 08:45:58 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:45:58 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 07/19] sidput: annotate deprecated
Date:   Mon, 20 Apr 2020 10:45:25 -0500
Message-Id: <20200420154537.30879-8-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/avc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index 0589935651b4..c732824129cb 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -80,7 +80,11 @@ __attribute__ ((deprecated))
  * zero, the SID is invalid, and avc_context_to_sid() must
  * be called to obtain a new SID for the security context.
  */
-extern int sidput(security_id_t sid);
+extern int sidput(security_id_t sid)
+#ifdef __GNUC__
+__attribute__ ((deprecated))
+#endif
+;
 
 /**
  * avc_get_initial_sid - get SID for an initial kernel security identifier
-- 
2.17.1

