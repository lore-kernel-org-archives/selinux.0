Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EBBC433F5
	for <selinux@archiver.kernel.org>; Wed, 11 May 2022 18:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbiEKSmh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 May 2022 14:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346306AbiEKSmg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 May 2022 14:42:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A82E61610
        for <selinux@vger.kernel.org>; Wed, 11 May 2022 11:42:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kq17so5830929ejb.4
        for <selinux@vger.kernel.org>; Wed, 11 May 2022 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=axs+U/EnzeJxnHAR3Qi80oI1rvQT9yMbtS5LcaW3670=;
        b=AxANPBGUq8IxUiKjE4MgnIIgZWJ6dVKyCD1BxlAP7I/OIIVSkn9/UBiZiopuuXm8jE
         OUpKkmFxxaL89hL7kAjsAHGOB3da9Xcyzj0sP2vDzKxjN4P8tm8ONNNyFtRrFxm4ytPl
         +QG2Wg0UiZKDPPf2lzER+Yi61k0NyapEJE31fyDrqcNMB6e0JLIajHO0S4QruTnYOy7o
         vCn5TmxaNorgTXh2l0e8BhIFf5k7+1HeasOjwRyEb5SvftmvyZXdv5spuQ+XEK4z5g7E
         bgSrchrYE6xjASEXcFQtkO/rrD0Yvc2yqcXB3o+QZaBzWqHAHrJ0O2fgoEAXwUims+o3
         ar4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axs+U/EnzeJxnHAR3Qi80oI1rvQT9yMbtS5LcaW3670=;
        b=10rZHRXoF2ES6cQy6R3m3Gw6qkMgi8EHPZhwgCjxyvYjXjrSJbTWTeLWgHwXQP1Sb3
         VWO1ftVfCa9cltxTdcPPZsrTcV3TAlN/2wfIaziAZ5ZtmkqjPv6ziof77NuybVz97ox4
         4xuvPvBrC/HBDlbnZ1yvtad0GpHRjyYR8VJjohWMbzufWWg1mG2ziz/fxCF2qZySFXJm
         rihqKJN4ruQp1EPUWt5EQZmTGIlFuLJu2PPtlgk8he9vaeIwkuD8KuJqER2bs2HW9Jil
         SG9O52EwV6NRs959KPtCsreZMKKueQ4CmBW8vRL6Az4MwkP7CU180tw+qzoOf/aVfyDa
         skJg==
X-Gm-Message-State: AOAM532838+Sb/E87Nl92wwzFHfxwiRWEYxXOifE/GksHGWgEDdapU/a
        YUX4QS0UmVrm91Piq1nw1cNMTO9cJZo=
X-Google-Smtp-Source: ABdhPJwZSKEoj1CLktsli31KgJlESegDeDZ9z0Wj6LXP3fubLc7rip7OAdsj4D05QMHlAVvvs1EzjA==
X-Received: by 2002:a17:907:969f:b0:6f3:dede:f2d2 with SMTP id hd31-20020a170907969f00b006f3dedef2d2mr25223632ejc.511.1652294553635;
        Wed, 11 May 2022 11:42:33 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-140-049.95.112.pool.telefonica.de. [95.112.140.49])
        by smtp.gmail.com with ESMTPSA id y25-20020aa7ca19000000b0042617ba639dsm1535788eds.39.2022.05.11.11.42.33
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 11:42:33 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 3/4] libselinux: restorecon: forward error if not ENOENT
Date:   Wed, 11 May 2022 20:42:24 +0200
Message-Id: <20220511184225.218062-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511184225.218062-1-cgzones@googlemail.com>
References: <20220505174420.24537-1-cgzones@googlemail.com>
 <20220511184225.218062-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selabel_lookup_raw(3) can fail for other reasons than no corresponding
context found, e.g. ENOMEM or EINVAL for invalid key or type.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index c158ead8..42ef30cb 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -651,12 +651,16 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 						    sb->st_mode);
 
 	if (rc < 0) {
-		if (errno == ENOENT && flags->warnonnomatch && first)
-			selinux_log(SELINUX_INFO,
-				    "Warning no default label for %s\n",
-				    lookup_path);
+		if (errno == ENOENT) {
+			if (flags->warnonnomatch && first)
+				selinux_log(SELINUX_INFO,
+					    "Warning no default label for %s\n",
+					    lookup_path);
 
-		return 0; /* no match, but not an error */
+			return 0; /* no match, but not an error */
+		}
+
+		return -1;
 	}
 
 	if (flags->progress) {
-- 
2.36.1

