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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F705C2BB85
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EC8214AF
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rgr9Hp/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438976AbgDPPoW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408887AbgDPPoR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:17 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B81C061A10
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z6so1481550plk.10
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l+nIMu7MVaQt819iJF4TNdRJ3FE4M38+ER7rHwSq2KQ=;
        b=Rgr9Hp/OA+rK7FH/EbnjYtA/Q9vKdEKEw/5ct65Eqqjh2qZq/eX+8v2ZxtpGI5pnKq
         lDS2NtK0SfDZ1dFmXXc8cp7rLG9CvOojXxPzQq+CU95uLPym0J6nCnviPp91XvJCkQCN
         xIlWpS+cHripCsrd9dk6VYaLa/BzF3Oub2tMTLTIXesS0YDokRmuJuIyL+IATWoRqeyl
         SqMF66pzCbJe7DPulCho8cbeSSBu1OS5DRcKVt/0b97mgNKMP9/xi6TGOvIHqJSvUwQU
         0DankxyTGizKpMCu4i/OfyKPaass8XiNWaIQ3NvquZTYC1oXkdC0JrUMWNwesnGSR4T9
         /Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l+nIMu7MVaQt819iJF4TNdRJ3FE4M38+ER7rHwSq2KQ=;
        b=tkG9WgYGJH/tVrXMMfSnm91L9HXDaKsqY8+W6GumPrTAmlO8ts2sZ2hbEdhLGmcJH2
         AYzy+khHTCIhh4DIvCZhazJuWSYsdUW/4ngsqPzIrTal2jdnYTHiBi54kzH8wjUCy34w
         273+DyvWdaO9QfEPEwV9bVvx5w9R6BII/Ant30rgFFdSqa1JifQb+szaOq1Zmw6or6UB
         E00yvbHO23n2aS+NVlDKk6EWo39fDT9/BeCCaK1n1SwxrBXc5JkU8WwkBmIk2D0EX33N
         mO8BQTf3M9dFFWC4B9ZiTC7/3s/AphIRK58XH0hzoSi8K/xL0iOdVAOGLKj8pZDbIj9y
         XWLA==
X-Gm-Message-State: AGi0PuZpFCWRbJBkeOJV/I5zT5yC5V5ajhmIms2wPvwaGlp6Oh74PQdx
        ifh9f3ODrH48wJ50LXyvZ9k=
X-Google-Smtp-Source: APiQypLOrcJJ8edYGd6GWITSSZhgEvMsrHNq461SLbckg9R0/7ic+T0sM3Icr6TSMblr4l6ZvhA5nA==
X-Received: by 2002:a17:90a:4a4:: with SMTP id g33mr5723434pjg.81.1587051857045;
        Thu, 16 Apr 2020 08:44:17 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:16 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 06/18] sidget: annotate deprecated
Date:   Thu, 16 Apr 2020 10:43:40 -0500
Message-Id: <20200416154352.21619-7-william.c.roberts@intel.com>
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
index 46c51419f588..c5c842a34470 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -64,7 +64,7 @@ extern int avc_context_to_sid_raw(const char * ctx, security_id_t * sid);
  * reference count).  Note that avc_context_to_sid() also
  * increments reference counts.
  */
-extern int sidget(security_id_t sid);
+extern int sidget(security_id_t sid) __attribute__ ((deprecated));
 
 /**
  * sidput - decrement SID reference counter.
-- 
2.17.1

