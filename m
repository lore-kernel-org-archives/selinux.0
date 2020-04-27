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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347E7C4CECC
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A28D2073C
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1KH+JGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD0UX0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbgD0UX0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:26 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7658DC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:26 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so8320324pfv.8
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5IskOwX5UcT748ON1fTtfkF0uP1N9WejQ0M281usXu4=;
        b=C1KH+JGfQgrGJ47OkLLu/6wZgHHanIXhPGU1vvcEGo1clBgJ9a+dMRzYOqa43KZW6e
         TcH0m+tyOt9GjZC/boMdPHvatrXYS6WvK8S0hd1B1Ze9Lwzb3kCgP3xv41PA1uuljIjN
         FYvrbYSFn0f2VmfjO2ycRPoRcCvieiihkexUE57jnso38T8HARXqM6dlFtKrnu4dJfVG
         fMs3p3zY1Rz1tbs3GH/6bpXbCwEafat88ewDI1fsnA/rWM9f8RRaN06UQ6+4qIZ0WMgY
         JlCkFZgjDki7ecNTxiJJEb0FTDMRg4qR4yjkvIq2YkVBHAk9Emf9lNz5sWw1Vtg7+txK
         XEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5IskOwX5UcT748ON1fTtfkF0uP1N9WejQ0M281usXu4=;
        b=FE/Hzesks2L4Nm2taXAjE7yR1Z/TRU1HihKJuKDZzX11yHzJodR3pckzWGEWmSGrgl
         2QiNEzDLSQ5A8xSBQR8R98kYiImVnxLUhd2aAMAuIDB19pk6XLFeusKOLzzar64kCOgj
         mMUHO58hPIxk//EUCSYgKwZa4941ZKi/PmBj7mzxw7bSOwo4tDdtkvu20meO/ehRRJpo
         OonB18R4FsQEcNX+Emwzu7tPSRfvYOlVPMtN6s5evJnl7UAyjl1rE7y/P11k2ZDt9hY2
         1spwExbWuk+eeYhUruP/XxBjOrqZqYE7p+wLJTQmjTnQJtTEws3DAhDL+1Hlyt3gt/8t
         fq3g==
X-Gm-Message-State: AGi0PuZzbFHBwfipjGGiR09NUPDLIg+/Z5I+X+iwaFXBtTOPaoIkzi/W
        qssc/BKMLOnvZUlKhjHIPjE=
X-Google-Smtp-Source: APiQypIByzUudcX68rAGDfoaEADFWqkufMlJwgf2NbH9CNcpzA1f82km4IBKleYPORMS++w70zlKLQ==
X-Received: by 2002:a63:e60a:: with SMTP id g10mr8218394pgh.51.1588019005902;
        Mon, 27 Apr 2020 13:23:25 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:25 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 03/18] selinux_booleans_path: annotate deprecated
Date:   Mon, 27 Apr 2020 15:23:00 -0500
Message-Id: <20200427202315.4943-4-william.c.roberts@intel.com>
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
 libselinux/include/selinux/selinux.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index ae70479511db..19b22c166651 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -579,7 +579,11 @@ extern const char *selinux_contexts_path(void);
 extern const char *selinux_securetty_types_path(void);
 extern const char *selinux_booleans_subs_path(void);
 /* Deprecated as local policy booleans no longer supported. */
-extern const char *selinux_booleans_path(void);
+extern const char *selinux_booleans_path(void)
+#ifdef __GNUC__
+__attribute__ ((deprecated))
+#endif
+;
 extern const char *selinux_customizable_types_path(void);
 /* Deprecated as policy ./users no longer supported. */
 extern const char *selinux_users_path(void);
-- 
2.17.1

