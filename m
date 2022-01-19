Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAE3C433EF
	for <selinux@archiver.kernel.org>; Wed, 19 Jan 2022 14:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355183AbiASOjd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jan 2022 09:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355175AbiASOjc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jan 2022 09:39:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891EFC061574
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 06:39:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 30so13150372edv.3
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 06:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OEGSQawDMDB+Nh4Dg27ov0HT4FGkNgVzx/P0Hri17YQ=;
        b=ShvFq0h2ICTtW+OuvI/kq5naUtuPr63V11J0ZJBk+rdYDnqrdwG+e9MMj1fF6GxEMj
         yMMEVxY/P4YmaG8fKaImvYyZqvWGQnghB4XCQVf7divcjJLY0pdzXiiCuc3PkSKeVcB+
         eZeHviBS0+/pyD89jcnn6Zdg9ju/Ud7sdnyXTxg2LW92Ht1k4ojdjnyJW8SRYkaZQDsV
         xRfqSSaKUK1+QCmiKG9TvMQ4TFZljKKODUyZWznhyW1KrJ26/zxDTSwj1OC51vjHgRZv
         uz+qShiL5KMoOm1RZ+O5z3pCfVr1OC7OhIGTyaZs3uZyHUpuM2O0rA1ask0jAyjwM8F/
         2NfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OEGSQawDMDB+Nh4Dg27ov0HT4FGkNgVzx/P0Hri17YQ=;
        b=ECdr967GLQTsGMbogr9vx4KdnHnHYpcKJAORZSCpjdPNAQyswCpN6RWqw8rvsI6f0X
         ntMLN7ypBdR6BmYZwwpA9lR9xkQ6KJ34BZVDVEsICXM1k1IA5W7R7VSZOUE3mweMwFBk
         OhZT/YMBWCw3gnx9l0Ho2is7MN9bFxe3U7+m0uVlRcUDIwD2ryo9SVUZd8i3MRTF8+ur
         N54PYk3o0PU956nAIkiJvmYsLd3/COwuoiFOMFkw5Ayy47L5EmST+iK68QFO89DKd354
         HdE3nJbYoWDDvMamHAncXv/3JZHLiDiwVifZBkhW6KE96UQD3kVMOIS8RD5qd2OLBaIF
         gIkA==
X-Gm-Message-State: AOAM532f7IO2VCCJR6EKQRpqXodTCBNrP0yKmYD2l1yNMryj1ZWII8V1
        ZfcljA1PfldnI5A+J+YhlcB0oe4s5yk=
X-Google-Smtp-Source: ABdhPJwx85tVS1QZMX/dP4IVkyex0WMzcgRnLSndoYuDqSxlMVc/MHj6JZDudY3q+TcAqi0R+5BPPw==
X-Received: by 2002:a05:6000:156d:: with SMTP id 13mr14943454wrz.553.1642603171134;
        Wed, 19 Jan 2022 06:39:31 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-001-173-022.77.1.pool.telefonica.de. [77.1.173.22])
        by smtp.gmail.com with ESMTPSA id a3sm11885wri.89.2022.01.19.06.39.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:39:30 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: return failure on saturated class name length
Date:   Wed, 19 Jan 2022 15:39:26 +0100
Message-Id: <20220119143926.5464-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not return success if the class name length is saturated (or too big
in the fuzzer build).

Fixes: c3d52a6a ("libsepol: check for saturated class name length")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 562e044e..fc71463e 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3937,7 +3937,9 @@ static int scope_index_read(scope_index_t * scope_index,
 	if (rc < 0)
 		return -1;
 	scope_index->class_perms_len = le32_to_cpu(buf[0]);
-	if (zero_or_saturated(scope_index->class_perms_len)) {
+	if (is_saturated(scope_index->class_perms_len))
+		return -1;
+	if (scope_index->class_perms_len == 0) {
 		scope_index->class_perms_map = NULL;
 		return 0;
 	}
-- 
2.34.1

