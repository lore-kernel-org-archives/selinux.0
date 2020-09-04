Return-Path: <SRS0=VTMH=CN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D0AC43461
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 16:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05C7B20772
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 16:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TdNTv2uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgIDQSs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgIDQSn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Sep 2020 12:18:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8750BC061244
        for <selinux@vger.kernel.org>; Fri,  4 Sep 2020 09:18:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l17so6637191edq.12
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2020 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vELyK0tbjO4llMA2eYgsfdf9DC/NDw0cYkO8D9w+x64=;
        b=TdNTv2uZo3qTK1N8MhdEtK1Xe2OzkJuXGwqtc2Z47a4CpVu+Kl6AIgEgPWaChzTzfo
         S8+7OnfbXd58+YuCxh2hA2iDp1r9ly1DjVDk+dqkrBh8Mv80MWxBnDHnFn2FpDoqQX+6
         Y+NqAeY3ULfsUVSHZfkKE5OhvaRXO6jCBHoqKTNcNfE/lSBozq4d4iq368zNtWbkVkk/
         jB9dcH0xzqCXRX5+c/XkxfHROzkj+0Eb+blND7YRTHIfXVYHRUeIBsTMmxcOuVCNMF3y
         rcX0MWpCmlY8JWu07niuvRiVDMrtOU0LyxwGLxz2ikPp2aLVz8gbTEIxtSomhU7e+VaD
         TVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vELyK0tbjO4llMA2eYgsfdf9DC/NDw0cYkO8D9w+x64=;
        b=WDkgu1PFz78yWWB7C2RkQL+/JxV/wlwKWrzKh/KCftYDBQ0Eyj20HU+hRY62wkQYTK
         jG4rPu0+8c2y353EIp6PTDX7nye2luwtfHj4EjSBjkCT24a1U0c4kNx9SXhvq0Wm8OqS
         SeTufiq0JktXpDGMmwV1wbEAuuydIJI0+Zqbhfov36zeWgLrFYub4qxKGLHIUgV+F4pB
         OZXsD8D17ujF6+DCfU/Onq1FeL/Zm47sfsKKiVuuand57GvLhBjHeXEPX1cmgGD+NXvA
         vzveChbaJKhrNGruWr0LCRRIcThVFC++D8zla2Ygg46zFtScXmBVqkzi1VHgqKmfWrTd
         b5sA==
X-Gm-Message-State: AOAM533A2KNoMHESeK+966FRMsWMqG9XYQQSpquo2jhU1RDbaFetJvt0
        OggFNRp4UbW+cX94DGF9m0vlqSEbZDZlBg==
X-Google-Smtp-Source: ABdhPJx1aBYO6xt3LsmGmsh4hWC58rkfKkWr3UYKzeLylj09QbYLu+If4ivI4gTqsKyIKBBi/BySqw==
X-Received: by 2002:aa7:d558:: with SMTP id u24mr9447957edr.336.1599236321827;
        Fri, 04 Sep 2020 09:18:41 -0700 (PDT)
Received: from debianHome.localdomain (x5f700e02.dyn.telefonica.de. [95.112.14.2])
        by smtp.gmail.com with ESMTPSA id f21sm6412200edw.83.2020.09.04.09.18.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:18:40 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH] xperm_rules: add two notes
Date:   Fri,  4 Sep 2020 18:18:34 +0200
Message-Id: <20200904161834.7677-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
I *hope* the note number 4 is actually correct!?

 src/xperm_rules.md | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/xperm_rules.md b/src/xperm_rules.md
index 7f8744b..1e1dfff 100644
--- a/src/xperm_rules.md
+++ b/src/xperm_rules.md
@@ -1,6 +1,6 @@
 # Extended Access Vector Rules
 
-There are three extended AV rules implemented from Policy version 30
+There are four extended AV rules implemented from Policy version 30
 with the target platform 'selinux' that expand the permission sets from
 a fixed 32 bits to permission sets in 256 bit increments: *allowxperm*,
 *dontauditxperm*, *auditallowxperm* and *neverallowxperm*.
@@ -127,6 +127,12 @@ Notes:
     class/permission is required.
 3.  To deny all ioctl requests for a specific source/target/class the
     *xperm_set* should be set to *0* or *0x0*.
+4.  From the 32-bit ioctl request parameter value only the least significant
+    16 bits are used. Thus *0x8927*, *0x00008927* and *0xabcd8927*
+    are the same extended permission.
+5.  To decode a numeric ioctl request parameter into the corresponding
+    textual identifier see
+    <https://www.kernel.org/doc/html/latest/userspace-api/ioctl/ioctl-decoding.html>
 
 <!-- %CUTHERE% -->
 
-- 
2.28.0

