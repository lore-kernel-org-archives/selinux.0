Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA36C3815B
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB085214AF
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2KFw7d4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410264AbgDPPoU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406131AbgDPPoO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED9C061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id np9so1557186pjb.4
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J/XRHfKAVF4HBNq1KhwctA1RFZEdtPwZFyUbWWSe0Nc=;
        b=c2KFw7d4SQ7XHrArheOlVoGhiDnUBdae3T4A2ka8EeTu08RP5axYr+8nBOJ2fUL7g4
         hfhFNVfCHjSheUE2B6OpudRxMQqdZb3+mCyir+ca1AbzWcr9A2Ckj2/AA4VenXES/Yqy
         IF4KRDbErI7n7FMHKqXJV7++GAEKt1xZUZs8sBwevPRvdgU2CI8rSYkIaH0iISqm4+Jm
         phDa/z+ic251PlMpuyyvddBgALNVXz+bZtwlhMHjqIcfCXidW1XCqfUlQMiOFuR0jYbx
         vuc7+Ir1wnWywmtGD8jrLCPcVkADWMGhIWC6Crwf7M5g9v1ZHI0h8gxSz1cTp4I5d/QO
         9QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J/XRHfKAVF4HBNq1KhwctA1RFZEdtPwZFyUbWWSe0Nc=;
        b=bitRFmen6oHpzdHA7ZkBLTJnZ37z3VxXwv9xd6UNnyQBSmRVxu9zvGcnFYhd31Vxvd
         oEK5JWqpKyvCjJw7W3KfUj7IExFhoXK+2XKOEhs35yd3xSdtlrIkszLPTwZGQzLEwwqz
         fxxDiWvlcslUeo6UhaSCRzs0CoqUOLQBm9K8DOu+V8OM+96X2YwOvFzXdzc6cV5B0Z78
         ifwV13WOJtGX/APUnlwASeDpvrTj4CN+PllXBDONPUt4Rsyqgm/vV3MIgk4TnTm+8MxB
         l+8q0UDoN2M6KnNeIF9oPsuEw8GuDFTJ9KDlqVs+bY2Djj3DjxSi2dM/qfVZDECjRs2F
         UGmw==
X-Gm-Message-State: AGi0PuYR4+LhjpxN7nofrkDeo916NslsBj5AAEL1Qzlnc+30hpC21FAN
        GTqatD2K0BUmvCjsL2WbkXo=
X-Google-Smtp-Source: APiQypI71xMc+fwoJ1dZYnP/O+f7ZKSjMKEsLKG0UMOHTd9LqNQwmdQU93SRh941jGLpO+TCHCXFDQ==
X-Received: by 2002:a17:90a:d98e:: with SMTP id d14mr5710738pjv.178.1587051853431;
        Thu, 16 Apr 2020 08:44:13 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:13 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 04/18] selinux_users_path: annotate deprecated
Date:   Thu, 16 Apr 2020 10:43:38 -0500
Message-Id: <20200416154352.21619-5-william.c.roberts@intel.com>
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
 libselinux/include/selinux/selinux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 454d3772ec38..cf2b81ba3162 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -578,7 +578,7 @@ extern const char *selinux_booleans_subs_path(void);
 extern const char *selinux_booleans_path(void) __attribute__ ((deprecated));
 extern const char *selinux_customizable_types_path(void);
 /* Deprecated as policy ./users no longer supported. */
-extern const char *selinux_users_path(void);
+extern const char *selinux_users_path(void) __attribute__ ((deprecated));
 extern const char *selinux_usersconf_path(void);
 extern const char *selinux_translations_path(void);
 extern const char *selinux_colors_path(void);
-- 
2.17.1

