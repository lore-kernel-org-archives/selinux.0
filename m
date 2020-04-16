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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F4DC2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB8920732
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQwu1jqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410294AbgDPPo0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406241AbgDPPoY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CC1C061A10
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d1so1850146pfh.1
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0wJPvLBd1mr4QlWMA46+l3SN0G/g2cbCdq9C8VJcbe4=;
        b=WQwu1jqOGhhaSvcMUts1O1a26/8k75RevAV9bYJLum9bNy82vrN8BttCqNKXVD6z1a
         MMNLjf2O++8Vx36mKX6GVFM+74bzWbfUGOMftEqXSn1sVxUPtHnH1mZFs7pBAQ8c4QW4
         Wj8PWd7LfSOdejHu61LnrDZSwjZ3T+Mq+WCE23ICcUAHucl0Ci0BHXbQbg0GWsLUMjQL
         pAhH1NBN4rCAy/1fB9U6IGlwLLdhXHWaCtrresClsCrwCZCNvqjqlgf7LpfSDHxYUJfw
         XcXAsDi7kpHYsOThB5GHcxLj8NL9dz8pmZXLqDuqggxpGRev7tPiggqxmaRD4JoFozI1
         oRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0wJPvLBd1mr4QlWMA46+l3SN0G/g2cbCdq9C8VJcbe4=;
        b=HXT1eDbLtCGZZTB8zO31aqLY8Lmg8E7aw/0L8XIgnb44ON9tGplefKBqfTR/LBZlmm
         oq3e4KIvjSel40smKv06toYn8v2NjyQCn6EHCzckmIs96IIwEAm69NtI4AVC7luIteSv
         g8+N614jrv/nkiOpjYhjQZAEFugMKsARyI/KGn9Z8pmxqxEx3qyO5uXLEFt5Q6qSc/4g
         FFc6GaTFtcmV/XRP+Xtx2G708+09mgqy3SqZMGu2l1LozHQUi3BTGTVgsawtWl8fX524
         mMqf92Kbq7LzbsEgrGYUe0ZS6Zu9p8vb1HClPkdOVmhktYjJ4FDWdVMyRAwgx/elOSaI
         BklA==
X-Gm-Message-State: AGi0PubfdV77BIWNtPenQ0d5UU3v4mkXAKAfWaCrqjCKNevidFErIauh
        I1eyb+19khsdXP2/jc/6qaM=
X-Google-Smtp-Source: APiQypIDEY4ZeyJsOUcGvlTfxWEQKOutKFYstskjjhmhorbIeudzQ18VIYNuXy/8/C25WWrKArKshg==
X-Received: by 2002:a62:fc02:: with SMTP id e2mr6746225pfh.195.1587051863885;
        Thu, 16 Apr 2020 08:44:23 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:23 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 10/18] matchpathcon_fini: annotate deprecated
Date:   Thu, 16 Apr 2020 10:43:44 -0500
Message-Id: <20200416154352.21619-11-william.c.roberts@intel.com>
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
index 9e209d2ab75e..96a071a8dea4 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -469,7 +469,8 @@ extern int matchpathcon_init(const char *path)
 extern int matchpathcon_init_prefix(const char *path, const char *prefix);
 
 /* Free the memory allocated by matchpathcon_init. */
-extern void matchpathcon_fini(void);
+extern void matchpathcon_fini(void)
+   __attribute__ ((deprecated("Use selabel_close")));
 
 /* Resolve all of the symlinks and relative portions of a pathname, but NOT
  * the final component (same a realpath() unless the final component is a
-- 
2.17.1

