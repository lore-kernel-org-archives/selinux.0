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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC55C35E0F
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4B62176D
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB2p+acB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbgBYUCk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:02:40 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39275 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730961AbgBYUCk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:02:40 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so183985pjr.4
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WWiCjevwx9oSwa3spOQKQxkLTwNuVsw2YwnfJ5bbW80=;
        b=nB2p+acBTZOoOhKEqADex/+4gkNLsfoCs3Bss+jKWwt8+WSZPBLZysyrutHHG1DAhH
         xr335wcoPrmvqxlCNNMm4UmFXhw3mU7krXlqVUDv4biD4zicazJLl+wlZkdJruJfJkLp
         gimv1qH91acEC2qKkVVJjfYdhFDIZOMg+acmQLB/ruJRBW3lhyX5aYMAd7RypS5b6bnQ
         51jyRSfzpgrTT5dlbJUChwkmwNHCb7IMvh6groWKZ/juUl8GTFhA6AXfFY4VV5mJpPxW
         oRMVUWGvqc95ZHsOgLlZk9RfMi3U+h3Xfh8fgLBcX7v5AAgAmK42GTM+giEEAzjm73S4
         wL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WWiCjevwx9oSwa3spOQKQxkLTwNuVsw2YwnfJ5bbW80=;
        b=sQjzPHn1pMKgQlEnlKO/+yifmWIw04EDzRlnJwZ0FVO8JkcYirF1FQR6RwVLFbiqvJ
         cqYxh+ndmasEe88WyyipsYy5+E7yjH7QZULwvhqnGJBXXAKJv5XJvEIV3l+gk8D6YzwV
         sJoYx4zDcSMals4qSVrw7HIcHQbNQZhwo8CSm0L2Iqa+iQ0fXiu18ONV/H+lBJBUrrpL
         SWC/xUzUk73sH/beB7zn4ayyBaQ1BV08i9VHcTFzIus7rMYOt3HXrGKfDQJtoPMFYa5C
         CDczWnInRReOWiMYUK0ljQaqUgBQEspuq2iJ3yiwomGuLm9cV4cmeNQorBZ5gZNm1vzf
         O9Hg==
X-Gm-Message-State: APjAAAWPVwwZKEDJGEXI1p/mMHm0DeHosBtSPu4zt0pXvnvN8Xao3Ajh
        H4+g//0WwhHPN8Tyr0061TU=
X-Google-Smtp-Source: APXvYqwQU20IvbNIZFk6sRMiWMjEq5rUHsA0bZUBBOumQjvbj7OsleubhRSoZNoKv901G+tAkxaRzA==
X-Received: by 2002:a17:90a:3841:: with SMTP id l1mr803017pjf.108.1582660959218;
        Tue, 25 Feb 2020 12:02:39 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:02:38 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 01/17] security_load_booleans: update return comment
Date:   Tue, 25 Feb 2020 14:02:03 -0600
Message-Id: <20200225200219.6163-2-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

The code returns -1 not 0, correct it.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 883d8b85742c..ee808dd954ad 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -319,7 +319,7 @@ extern int security_set_boolean_list(size_t boolcnt,
 				     SELboolean * boollist, int permanent);
 
 /* Load policy boolean settings. Deprecated as local policy booleans no
- * longer supported. Will always return 0.
+ * longer supported. Will always return -1.
  */
 extern int security_load_booleans(char *path);
 
-- 
2.17.1

