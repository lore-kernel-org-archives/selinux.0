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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E1C352BE
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E9120732
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFQwGpZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437796AbgDPPo1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395459AbgDPPoW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB52AC061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r4so1820267pgg.4
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8dX+4yVeqg7kaZfVDMKnr/lDPx5yPCOAjwr6+7Pg0fk=;
        b=vFQwGpZZUXQ3Ib7JySu6nIDYDmIpfiGvTf6095N9F5vk1AIbIXFgMbMctNoG3q3kcC
         bSFviQv0VczLLvx2ZajMd4YJfh+05vBPdHeA6GYso9yXyiB3CMQ6rJtsYtIF0kiYZk7E
         BUdR1i99yLXQcvASpwVWuWJiKUyNOy6M0eoOw9nn/SXHGA570GINSFzaskZUTnn6lNwp
         awTRInVjTHdJY0n3Yh4YoQZToJ6F8TUXNYVNvnfs7RyiMcaObpdfdVKKSNsgk6zTE3gs
         17rUC8xIPRwH5W8/hpeUjaLfQc1glCdWcQo4djsgjtm/DuQfohk56Qid++BUqBhVS6O7
         R5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8dX+4yVeqg7kaZfVDMKnr/lDPx5yPCOAjwr6+7Pg0fk=;
        b=MpB8It+/eLD2Cc0ZJfQeZ9RbRPrJ6f7WuZ9wrAd445yJX4Ea7ok28JKYhY7vJ5NbdO
         nFFa095OWlocALKC/iAbqxV5zAPhsFRaTI33DvTfGdXu5JxXI1dORss7DB/Nu/d07vZK
         +R+1wnqm/tCdTC+Lf1jXY856iXmzm5fvHkH/QWJ+7p0HPv20GViLkteQZAgS0MyofuLw
         coWeApp87F9fv06bFzUzFR6sZ/rJSpv7VQ/HadBJ+vsXplWTDJiyEkBdJhgV5dxd2FSM
         V5e0weLk+R/ggCNqw9flTdDBELyWSuD+fmEQJELn2vuVTX/6yPHPstNwCgAFu4A3ospb
         /gKg==
X-Gm-Message-State: AGi0PuajAJNOv18N/Sj+qlhApLWRVjeNEwTyFyGGcUMvLm/OfzBXC3eu
        YBJBXS/H0y8KxC7rcMrokQvuaKkHGdE=
X-Google-Smtp-Source: APiQypKW8Je8KnCtONMiB6izB3p33b1y38Hmj6zokTp5ZN8PY8jnT5JeeYaUFxIGZFhi6t5PKDE3uQ==
X-Received: by 2002:a63:da47:: with SMTP id l7mr33683691pgj.315.1587051862178;
        Thu, 16 Apr 2020 08:44:22 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:21 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 09/18] matchpathcon_init: annotate deprecated
Date:   Thu, 16 Apr 2020 10:43:43 -0500
Message-Id: <20200416154352.21619-10-william.c.roberts@intel.com>
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
index 2767daff17e7..9e209d2ab75e 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -461,7 +461,8 @@ extern void set_matchpathcon_flags(unsigned int flags);
    function also checks for a 'path'.homedirs file and 
    a 'path'.local file and loads additional specifications 
    from them if present. */
-extern int matchpathcon_init(const char *path);
+extern int matchpathcon_init(const char *path)
+   __attribute__ ((deprecated("Use selabel_open with backend SELABEL_CTX_FILE")));
 
 /* Same as matchpathcon_init, but only load entries with
    regexes that have stems that are prefixes of 'prefix'. */
-- 
2.17.1

