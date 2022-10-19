Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA03C433FE
	for <selinux@archiver.kernel.org>; Wed, 19 Oct 2022 19:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJSTEL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Oct 2022 15:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJSTEK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Oct 2022 15:04:10 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A8219E92D
        for <selinux@vger.kernel.org>; Wed, 19 Oct 2022 12:04:09 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id o8so448447qvw.5
        for <selinux@vger.kernel.org>; Wed, 19 Oct 2022 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ycScr7W2Ldxm/Wk2qEnNF4b125miogeCBwBuCF30fsQ=;
        b=hpe1+HKbXNO7++4pu9N8P9v+Cq1yAU+Er2MwZAsc8YscFual3LHn6DlExtKurqUFPt
         XSwzlfi23cwFFonNgVYE8EFz5qOq86fdf6Yb82LmhVM/1pb/VCAalsP+QmvmbTEsafnF
         04KYyHRBsTVIPbDkzFrGEYlOXPr6vnqSBVwUizOGV7B9zZOSUJ82GZ2D9l/uCNtlizRv
         U79qt4a2mKnGR0gvX+B17ItOGSHCWDAfeBP7rmRSitJJbt2aiyTCyapIqcRS/cw2Tx+v
         m+GhVA5n3d9Rub7Na77JBG+I21YmNmFDbrLrP4oB94WcJtscsPRyG+Z9F1BhKGAHaa14
         PwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ycScr7W2Ldxm/Wk2qEnNF4b125miogeCBwBuCF30fsQ=;
        b=EvPOwTPBs7KPhSCjKYy2orP9FSY19o9f/ag0rQT/4RCkGu0ePNvWc7X5VHPxdojJZu
         wTz0XvoCSI4vJ/dPMyU5o7pCeWCML0lmSIoonNWeicUaakKUobBpAxxSiIsOQNg5GwZx
         vsdx2UGAryO4cx6aUwNLHQ/26O7H0Uxy/IkDwY8LGFT6VVvR2p2iq0URXXwTgv54UXir
         GixHzmL6FfdfeQI2DnP5//KauEhdWPWNtmEmSn9Xupmhe4x2wO4NUV0fKlKPpcitYijD
         gBmHqwPFp3GjNeTxndm5pwmKgTrWar4bwZ+ab5BAL3zUxK+Qdydm90zD5cwOqe1LFfQr
         8gsg==
X-Gm-Message-State: ACrzQf3WMXxmw0rq/DnB5vYPiK9mPnGXNkIf3ayJXX4X4jaTmTpbsPxn
        3PB1O9/KLFgZ4vnsKbocr45PYI0BDpQ=
X-Google-Smtp-Source: AMsMyM6bgq+kWkHBjo6Yad1sQ5cUAcChPLiGtUMM6qOcBisvWxRzwyrUR0sac1wedQR/JEsHbhlWVQ==
X-Received: by 2002:a05:6214:ca8:b0:4b1:85c1:4de6 with SMTP id s8-20020a0562140ca800b004b185c14de6mr8060480qvs.13.1666206248287;
        Wed, 19 Oct 2022 12:04:08 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id g3-20020a05620a40c300b006ee8874f5fasm5748766qko.53.2022.10.19.12.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:04:07 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     vmojzis@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH] python: Do not query the local database if the fcontext is non-local
Date:   Wed, 19 Oct 2022 15:03:56 -0400
Message-Id: <20221019190356.3092073-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Vit Mojzis reports that an error message is produced when modifying
a non-local fcontext.

He gives the following example:
  # semanage fcontext -f f -m -t passwd_file_t /etc/security/opasswd
  libsemanage.dbase_llist_query: could not query record value (No such file or directory).

When modifying an fcontext, the non-local database is checked for the
key and then, if it is not found there, the local database is checked.
If the key doesn't exist, then an error is raised. If the key exists
then the local database is queried first and, if that fails, the non-
local database is queried.

The error is from querying the local database when the fcontext is in
the non-local database.

Instead, if the fcontext is in the non-local database, just query
the non-local database. Only query the local database if the
fcontext was found in it.

Reported-by: Vit Mojzis <vmojzis@redhat.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 python/semanage/seobject.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 0782c082..d82da494 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -2504,16 +2504,19 @@ class fcontextRecords(semanageRecords):
         (rc, exists) = semanage_fcontext_exists(self.sh, k)
         if rc < 0:
             raise ValueError(_("Could not check if file context for %s is defined") % target)
-        if not exists:
+        if exists:
+            try:
+                (rc, fcontext) = semanage_fcontext_query(self.sh, k)
+            except OSError:
+                raise ValueError(_("Could not query file context for %s") % target)
+        else:
             (rc, exists) = semanage_fcontext_exists_local(self.sh, k)
+            if rc < 0:
+                raise ValueError(_("Could not check if file context for %s is defined") % target)
             if not exists:
                 raise ValueError(_("File context for %s is not defined") % target)
-
-        try:
-            (rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
-        except OSError:
             try:
-                (rc, fcontext) = semanage_fcontext_query(self.sh, k)
+                (rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
             except OSError:
                 raise ValueError(_("Could not query file context for %s") % target)
 
-- 
2.37.3

