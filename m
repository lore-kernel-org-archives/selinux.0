Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CA0C4CECC
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E63C2073C
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reJkklE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgD0UXe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726285AbgD0UXd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:33 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76491C0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s10so7429360plr.1
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iWBKLr767QxmWMyFc4HKl4BlgOIXWmOpWn/1VxJuI+0=;
        b=reJkklE57dgohwIFfVVjt3OlBIfUWZJ2y1G0HZV7gCcqSEc0Owt4EkUvpTwp93P3/I
         0sfyxfadzrD1kRyqI3/+06TqMzaNeehMEhUAg4uGM5ZNDJ/tsDTqInrDDZJiFYa4+ceA
         s/fB7Yjdmp9N9FYsn0J2vbar/UCUa0aWsKnhpDpegh5rXQx65skcl90yTgeLUoFUnzd0
         KShEBjq9hEzXKikjy0K7mll7oDSr2Rh4tm7H7l/fB9rDvU1WCK0s33TNuaQ1PjYFN5gc
         saB/6J7vT3Bm/UGfWhfcQeVR5qIYsAN1isfQ2mw6DgBjcQOfE1b7TgPRZrHwrOtYvW/x
         494g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iWBKLr767QxmWMyFc4HKl4BlgOIXWmOpWn/1VxJuI+0=;
        b=t3r+of1NTyOtO6jtvPcIBaiiwOwBYqUbdumSXxxk7H+PkmdZ9n6n4JxjqWp0SWTMNy
         o3AVvf27sjWqFW6mfPbmhY22aRBScAbaCjk1juXyCjcAKBEBglT5AOWgigV6hwZLH7Vw
         P9U+0nMK2HV5DkItw1PQLQKBzfuWgGuz3o1rkNxnsL/FZx2mqvRrv03C2txDdCvcxLIV
         Fyj/ShKn0CusG6bpkQSUQ1kXCMmc5/BEvVOAR5LD6wk+MA9dcDGrt0Ev2+ZSHdG3jCnL
         lFo+Bw818oQIR1KaqKV7kibtXDiQv18OML8ilH9u2QObxy0JFEwpM57fLW4PK9CvUfV1
         gsnQ==
X-Gm-Message-State: AGi0Pua/6/2+CeU8RdNCJWrWmkAwoOS/XHfo4P06+yjPszSzEQMB4hiN
        7UwjjhnQxWBamoi38/4zEDk=
X-Google-Smtp-Source: APiQypKy0joKhyZmKvTPPMKJLZ4gBQuIr0m1jG3w3YiFhM8FIFXcDcLIdGecVKBIaPvXCjhGhJv0dw==
X-Received: by 2002:a17:902:9f8a:: with SMTP id g10mr2046476plq.233.1588019012972;
        Mon, 27 Apr 2020 13:23:32 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:32 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 07/18] sidput: annotate deprecated
Date:   Mon, 27 Apr 2020 15:23:04 -0500
Message-Id: <20200427202315.4943-8-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200427202315.4943-1-william.c.roberts@intel.com>
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

