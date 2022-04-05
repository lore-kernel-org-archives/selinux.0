Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2258AC4332F
	for <selinux@archiver.kernel.org>; Tue,  5 Apr 2022 21:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbiDEVlw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389251AbiDEPVM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Apr 2022 11:21:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB4CF4B4
        for <selinux@vger.kernel.org>; Tue,  5 Apr 2022 06:35:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bq8so26712198ejb.10
        for <selinux@vger.kernel.org>; Tue, 05 Apr 2022 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DnxeOC/iqC7rz9jn95qEhbz9uT2NqVWBAF5YEROBsUE=;
        b=d+E21rXsn2kvq3hdJd9vaJDnUKD2M5Ff/Jz4U9rLu6aFiYsUEDWChJpwAxCi0FM7kZ
         LqRCzO8eOpDVjP7s9Kd2hSrPExwkPw/10ekgJQec5H8anAmQTURG48Hax0T7Ys5GJ+iH
         4APbiOnRdH8FvHGF5v5OnHi1Vew3JpYNC1NFMqmVN5gddf8XSs/tNs5m93mJcI4BpKxi
         lZyg4bVRfNHxBvYkgzBh0pjhKCo2dBk9itrNBPSpQLCYJIDlPWsNgOOos2HyCFhm9HDi
         PYgSKXsD5LSewGNrDGq9U1Sm1HUmriXhW1RdHN2V/5CL812SHM9WsnpXi3AtRspIRBH/
         ICfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DnxeOC/iqC7rz9jn95qEhbz9uT2NqVWBAF5YEROBsUE=;
        b=JzNXG+YKIkr2BXmZwPkyk9kpHLOj9up/3a9/QoiBc/E9k92SfQ4bWefH6TVZXl4GM0
         Vasw0/9WUG39vbAAt10ssJiprUh30+84k+j8NpvBpylgAzFyncdY2FA0Z1GAk7LxQpUn
         tLnJ7PcUR0ufCYFqPrFjCfgv69am/7iNvg8jNZsc+Uo9mP6w2PFDse/JmWktkQujo88y
         cMIyU/E2BGFMuhKNjH2RVFSthBuyT7uaPFo5joE2/Vb886gmdouxWaXrTEGcJvrM3CgW
         GXpePQk7OwnwVS4ZUQqE2N3aO8IQSVIk4y9Qx53efcIg4n97bqBoSkzG9f9nm8Kcaok8
         y9qA==
X-Gm-Message-State: AOAM531zO+hlJaDPLtIOzxKDdnJbWsMwEijmc2BgsBOTVIWRaStcb4k9
        Hn/6RzWWEevqPBZPmnDNFmfV/tb5/N8=
X-Google-Smtp-Source: ABdhPJxv86L5dS+TAkHpFXDlp7DN6A9rvYAtrM8EFtkAiscSxSOwxHMKtFCFnbBSOv3DtzGU3+yD9w==
X-Received: by 2002:a17:907:6289:b0:6e0:eb0c:8ee7 with SMTP id nd9-20020a170907628900b006e0eb0c8ee7mr3440136ejc.245.1649165754990;
        Tue, 05 Apr 2022 06:35:54 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-134-094.77.8.pool.telefonica.de. [77.8.134.94])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709060e1900b006e7fe06664esm1620627eji.106.2022.04.05.06.35.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:35:54 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 3/6] libsepol/cil: post process pirqcon rules
Date:   Tue,  5 Apr 2022 15:35:45 +0200
Message-Id: <20220405133548.51598-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405133548.51598-1-cgzones@googlemail.com>
References: <20220331144752.31495-1-cgzones@googlemail.com>
 <20220405133548.51598-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_post.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 7f33cd9e..714ce227 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -2434,6 +2434,12 @@ static int cil_post_db(struct cil_db *db)
 		goto exit;
 	}
 
+	rc = __cil_post_process_context_rules(db->pirqcon, cil_post_pirqcon_compare, cil_post_pirqcon_context_compare, db, CIL_PIRQCON, CIL_KEY_IOMEMCON);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Problems processing pirqcon rules\n");
+		goto exit;
+	}
+
 	rc = __cil_post_process_context_rules(db->iomemcon, cil_post_iomemcon_compare, cil_post_iomemcon_context_compare, db, CIL_IOMEMCON, CIL_KEY_IOMEMCON);
 	if (rc != SEPOL_OK) {
 		cil_log(CIL_ERR, "Problems processing iomemcon rules\n");
-- 
2.35.1

