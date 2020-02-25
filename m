Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F4FC35E01
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5505121556
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4jfSlXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgBYUDG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:03:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33596 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBYUDF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:03:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so131862pfn.0
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=crs6SVimy4Jek7MEn4C+0oC2hWg9PvZMOqLc5C+Mf8g=;
        b=o4jfSlXtKdlN1Uoq+crxB8vRL0U8mHHxrMp89+qLerzaxpmb7FzEQnDONxDdvH5GG/
         ocee2pmkaWCbx+olPz6VTLr5baqYXgVCi30SMrUQS3KQ0VinsiwjK7voRVWkvnZpX4kk
         T14LnQG6HX8z9p3T2T0xT96OmwQrs2JTyOBGdrhdSd5dE3RYpVvS+W7lBJZgf8fnPaEo
         MB2PxvcalKETtmQjLncbXkGNBfzTlDOMYqSBx965BbSKj1IaoSs0OUZ6ruNUlqe/L2xP
         JPA/4rT+bZIsW3vwZjAmd8/+Dw8ELwEAC1oDZZJytajjvdMRlKe67ueiioH0Qv2bDz11
         8ttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=crs6SVimy4Jek7MEn4C+0oC2hWg9PvZMOqLc5C+Mf8g=;
        b=LeKMKuq+t6ifnQjEj0E8aAf/FgrO1aCsJnRpG4K9CKgX/um8VwG0BBD85JmU8+ywjY
         z6yByayCWrrjPmx1n5xY1Wym7U/Dtg1zIF/Np8ZqeTk+CU2TKqPCX5JKPtVkjX5U0g0A
         ofPu0Jiio185PnFle2kPyqBOQJc5XplKjHRugPTZMJGOHGhH/kBsbhOp+0UJHaYyzvON
         qUPeSMQZ3KiOZ7J29q/59rFV85+VyV2iA+Rvs7RwJtOMbfxJ9b/hd4nsKHTPjGX8LfiR
         Q5B+tslYEyBHr0G4bWP7WrRNCitwz36CfKU3DuJ0D3mYTkCJZ5r3FCHhKRy3XXC3MQHN
         YgWg==
X-Gm-Message-State: APjAAAUsFuG9WJYS2SOstyyvRsYhn8/rXWQSH5w9jsoQHHW90XY7b+2m
        sP0H+uh6A5Ifav3Ifa0u5r0=
X-Google-Smtp-Source: APXvYqzX5XOJ4ChY1YVxUYIeEHwW4rqRvVe8FZC9NXvA/N4I5B8YGzAI+JsLkqEc0AxnCtKRbf1Eog==
X-Received: by 2002:a62:5343:: with SMTP id h64mr350008pfb.171.1582660984552;
        Tue, 25 Feb 2020 12:03:04 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:03:04 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 15/17] avc_open: mark allowed use of avc_init
Date:   Tue, 25 Feb 2020 14:02:17 -0600
Message-Id: <20200225200219.6163-16-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

avc_init is deprecated, however avc_open internally uses it.
Mark this deprecated use as OK. Another approach could be to
define an avc_init2 as a hidden, internal symbol and call that, but this
was seemed simpler and clear.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/avc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 5230efd2323a..7d30f0052f7c 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -156,8 +156,10 @@ int avc_open(struct selinux_opt *opts, unsigned nopts)
 			avc_enforcing = !!opts[nopts].value;
 			break;
 		}
-
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 	return avc_init("avc", NULL, NULL, NULL, NULL);
+#pragma GCC diagnostic pop
 }
 
 int avc_init(const char *prefix,
-- 
2.17.1

