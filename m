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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565BDC35E11
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2036121744
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2GHT3rD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbgBYUCu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:02:50 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40634 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731698AbgBYUCt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:02:49 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so181305pjb.5
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l+nIMu7MVaQt819iJF4TNdRJ3FE4M38+ER7rHwSq2KQ=;
        b=S2GHT3rDP0M+/5bJPn0wnSUyOFxKjbzjNVNO4RQFcxLoZ0I6VmpTw4SeC6nEGOTVyW
         XpTi5C/Y1WbTyD/jBB/2Dm57xPtz9sNrybIy1J/0Lo9gshKURtvtlFQV0SOpeBgWLoM3
         VIYF57osJIvnBU19o8vlq2ITXLuBSmSFXCHeKbP60KRdr85hgfx1J7Tquc9OU3JXTNkm
         a9zoP9oSol0KGAxT7/J8D3aBk5wJ9B9e3nxHoMDjjAYIth9iqTkg9Qoetd+Kc0j/TNIj
         S2bLiG+i483cPSKavRh5sapgVcX88/mVc7c/jaKHO3RUayVlMWGlSlU054C4oPRQReQ6
         rC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l+nIMu7MVaQt819iJF4TNdRJ3FE4M38+ER7rHwSq2KQ=;
        b=YcUBB6bQ+W6WRwFsg+MO7R5/q20Rd8ftLdYvtsaDrbVh++In4WKaN5HYao+O8e73Ii
         MqX9ucOr9Px+NvGJGROEmjWXyjoRk0WYOm/6U6Mvzy4BERS26EoJ6hIUKVlNceKVqOhG
         97w5VhY7p+J82JCaFxbu0emmpUe6+wmcpU2Vn8G2yotCxQOgFYMMDmKkXivYNvf5Af4M
         V/x924oBPjEt4hGMg3WrL81n9EKfr7Qi879QEO4AytwIe+J6W9lQqA19vYSi7KizpP/v
         6drXVAOXa9A/u6VZ8TadbYkeW93bxSxbcOe5gsmX/qBecM9X/nQmYv1tYFWZFHFb5v+H
         ZrSg==
X-Gm-Message-State: APjAAAV1JzxuF4kqokh9HTqSR6M9h2cYR4Auk6mz47+/JQgf8nnUra+L
        ZWLlePx9J/w4N2CRhGmZyeM=
X-Google-Smtp-Source: APXvYqyRbg5ioS44BrERF8v5cV+U8TpqZEIeQnRSaMCHkYErZe1GBpejXtfIMErM+FzIcospH4aF8w==
X-Received: by 2002:a17:90a:3aaf:: with SMTP id b44mr793872pjc.9.1582660968684;
        Tue, 25 Feb 2020 12:02:48 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:02:48 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 06/17] sidget: annotate deprecated
Date:   Tue, 25 Feb 2020 14:02:08 -0600
Message-Id: <20200225200219.6163-7-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
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

