Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E19C35E04
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7191521556
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He0azFbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbgBYUC7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:02:59 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55815 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBYUC6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:02:58 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so184348pjz.5
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pboIINyf0qMwR1Nmn2v0P1UjFRAZuR78s587QRDTXX0=;
        b=He0azFbK0xnZzdoalf/CcRQPHWaqLjpnGB2wunxlh766oC/gJQ0cTu+FadBgZSyvtk
         GILv/8J4oIJsjNoX5J1itOO3092owYHJAlmOzq966g3pgNlOK9MaxOEJRN0OeCyEfgk8
         uMverNmkHdM3v0MOavZvm4xZnVwmnAL59sZZUEKZTtzelMHyzyg3X+zvoY4zjkOPn/Pp
         bJgsEr5GmydoSWaoVW9Nz6OnyQDl7z89NZYVstqFsNYuYPnYpF0D0vxsJyAx+ke8ZyWA
         7cUxe1Mfmp7F1M5IhXtczw5spF61kmjZ6G62MCSs6Lx8h8mEO95Se97c900yiABDw71M
         2wcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pboIINyf0qMwR1Nmn2v0P1UjFRAZuR78s587QRDTXX0=;
        b=OjzCDxTAFpPKGly5M9kWPt1sP70+6HBjwqIXJ9/mjfraOtQCgFRC6XjaH5TVoIZyz1
         R5dWWi5PFt9rVzpa889uVoTeTCpU/VinjNHLEkEH2pVpWnEldCkDdGRu1E8+Bvk+1Iph
         c2qib7Q5xn5Jya/80GUAn8h2tJnZ85p11EpFFv4KhZ08J4ytk/hKxRLJbGm5qYvMFk3S
         7tlQmZBhc4wsn5hHKVTbe4zZfbfcbX9oHey7ip5Dcq6N5qNwrjRqNkhYNhjeag9Yz4xd
         Rkw4bnM2o+dABNFiHfKqyAEa8pXVFhJ07I7nsnh00MTiq45zueD4PyLytJx8+APQgwsC
         IVOw==
X-Gm-Message-State: APjAAAWgKNSEXb0HidZCrURZRyZg/19R8Pe53UI6f4j/4N0RJTfFTjXZ
        JHs3vC1vOPkAWNOmHmGaQmE=
X-Google-Smtp-Source: APXvYqybktiCYWE2zHHga9eN66kFVW+yXNthhSJjwiggIVPA2yViN2xl1bYRMplDWbToxtg1ewjAOw==
X-Received: by 2002:a17:902:426:: with SMTP id 35mr193285ple.302.1582660977975;
        Tue, 25 Feb 2020 12:02:57 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:02:57 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 11/17] matchpathcon: annotate deprecated
Date:   Tue, 25 Feb 2020 14:02:13 -0600
Message-Id: <20200225200219.6163-12-william.c.roberts@intel.com>
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
 libselinux/include/selinux/selinux.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 26f8432cd4c3..ed00367b14fe 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -480,7 +480,8 @@ extern int realpath_not_final(const char *name, char *resolved_path);
    If matchpathcon_init has not already been called, then this function
    will call it upon its first invocation with a NULL path. */
 extern int matchpathcon(const char *path,
-			mode_t mode, char ** con);
+			mode_t mode, char ** con)
+	__attribute__ ((deprecated("Use selabel_lookup instead")));
 
 /* Same as above, but return a specification index for 
    later use in a matchpathcon_filespec_add() call - see below. */
-- 
2.17.1

