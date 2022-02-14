Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D26C4332F
	for <selinux@archiver.kernel.org>; Mon, 14 Feb 2022 16:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356764AbiBNQ6f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Feb 2022 11:58:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356766AbiBNQ6f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Feb 2022 11:58:35 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4965155
        for <selinux@vger.kernel.org>; Mon, 14 Feb 2022 08:58:27 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a8so38766860ejc.8
        for <selinux@vger.kernel.org>; Mon, 14 Feb 2022 08:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UxsAx2JsWtVA0zeo+d78eRtsJec2K6h4T7ZIMtJz98o=;
        b=q4HATIn2KXUWN3X75bA2Ppzs7TVdIx0bXafPWBSmpvJRuhInoVC3arO4Vvn1PMHPQh
         +2pCT3EQa+7LfMpUpYFvV/07WQ/D16ao92h8XoFu3nR3/E+KqIpgPkbamvGZiBoW61Pg
         dcX6lYJQhu6D0DURSIXT7i9p73QNDFleugHi7FgKpAXiFWPWom4KZj2IaC7JPx/tvDaw
         RMnBqjBi9NZj+oJcf2GmcPzDSer0Eh/g7sym2EQ8g+7nhjj6h2OM5cJ3ADvGZp1aylOB
         ejrE+2xkBKfcGdzEIt+d3ImocUG5F1QJk1vL6zgiUsam4HYLurLPchKl+joLN9OuKB2q
         iXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UxsAx2JsWtVA0zeo+d78eRtsJec2K6h4T7ZIMtJz98o=;
        b=MFyUaiYGBf8DhgioyvnYFutOTGckCE118BoevjL7lv8uf/55ECt8hJB+EYEJfbvaxd
         CsJiNHQfJx4x+dpYq0tIjJPW5Gf8IX+G+f6ZZfhHR6umf/+Jv/bJHjMIPCkXNUvhN41O
         hreFJzxveXerDUO1XAzTRxvkw0N9L+frzasEW4Aw5Fp+qtXFUiwgAocZB68s51eL90j1
         e65Pig05DqHWU1UCwfn6cfJIG/8aFFbIJdDfmXZ8saeZDK+1RltSMyiwk57+Y1xfd/Xr
         8uHDszL8pS+SSRiTF/S0vyaK9imSptuorx2x5ENYAOQJ6+jCNTx2bWcAGawRw/XkidGT
         HzTg==
X-Gm-Message-State: AOAM530/sKcvLMOwuVQlUN7S34+hP8z2z2yFd7x3xgVmS32H5aTYilu7
        EXrVupDAnr++BStRarzP5QbDXvb/FKM=
X-Google-Smtp-Source: ABdhPJx89nfZLNjssbB/kEoH6VSKFxwiI77RWPCn71tnFWxieiQY+jvFwdRXkXkldYVlydM9GwvSmw==
X-Received: by 2002:a17:906:549:: with SMTP id k9mr372075eja.649.1644857905705;
        Mon, 14 Feb 2022 08:58:25 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-192-083.77.3.pool.telefonica.de. [77.3.192.83])
        by smtp.gmail.com with ESMTPSA id v5sm15652251edb.15.2022.02.14.08.58.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:58:25 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/sepolgen: accept square brackets in FILENAME token
Date:   Mon, 14 Feb 2022 17:58:12 +0100
Message-Id: <20220214165812.9359-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When parsing Reference Policy style files accept square brackets in file
names.  The FILENAME token is used in the TYPE_TRANSITION grammar rule
for the optional name based argument.  This name can contain square
brackets, e.g. for anonymous inodes like "[io_uring]".
---
 python/sepolgen/src/sepolgen/refparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index e611637f..1bb90564 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -261,7 +261,7 @@ def t_IDENTIFIER(t):
     return t
 
 def t_FILENAME(t):
-    r'\"[a-zA-Z0-9_\-\+\.\$\*~ :]+\"'
+    r'\"[a-zA-Z0-9_\-\+\.\$\*~ :\[\]]+\"'
     # Handle any keywords
     t.type = reserved.get(t.value,'FILENAME')
     return t
-- 
2.34.1

