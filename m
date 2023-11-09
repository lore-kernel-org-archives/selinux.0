Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ED6C4332F
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjKINxY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKINxX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:53:23 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC99272C
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:53:21 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9de7a43bd1aso141778666b.3
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699538000; x=1700142800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3uhkNhG9mnw3UfxlqxhiWF6b2P/LIFOZkukQVAxPEE=;
        b=YhJq5FAHCi1PDLHhBXysphWBfCBL5Z0/oROr1Ini1Ca3BtaEnbuy9JS72lFXf3b/Q5
         AGESmIf1gxDzkVdK24qa60DBMdb9brDGMV+4ZRk9qh8f7sxpoUUT7au2Xv8aq4rWz0pT
         DrYSyQdhKGIPhKdxRD1cvkoYUIkbxQdSfPpBq1uzJbh9sWCUINukPbxz+Tc+lBalTyzD
         pL4cO8elyBfj4Eus1qBRlar8aFvQX/v7SIEeP3nshlG1q9D5mKEy9sUWTjxC51r5qGDm
         oREc8BAbl4PjRGK99dbKhdkAwZ89dahuq8v38tMC6VXhftrFOnTtvyQlP1cpqpiGi861
         89rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699538000; x=1700142800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3uhkNhG9mnw3UfxlqxhiWF6b2P/LIFOZkukQVAxPEE=;
        b=MVNTGk/JTiYKl97eWAb7WvsfyVRgw33LtMGn2WATfcabisI7mvH+5wdkDW4DO/cndN
         TNrm+uVhbHHDOPnr3PFAi8W8JrOClNxdI5Ufo5ahT3trqif1NuQWv+AX0xzTZqDHIQIx
         LsKyoIoc536vYI6Pjit+HgRInBzfJSrKEXT9hFsoxJdSjSpX9lxUDB5m3xdMc8mM5FYb
         rq9rN0SXvAH8eUU/TcV978pu5wooa83xFiLkP6vkwJBb+04B9bUATGATdEhTFBKQstCV
         BGDnMljOy1+N3KV+wihaML60UU/ppYaBvTh7KARxJdTWE6ejsK6SykrzHgVK2SRoQQ3/
         3ktA==
X-Gm-Message-State: AOJu0Yz/qHlEqdyG3Qdc4N1sDWffXKSla2FORWfLCLHbvBTFYcv3ucYo
        hi/p3hK2HWQJKDvNrRdur+ep8v4z/AM=
X-Google-Smtp-Source: AGHT+IE2cZLi4jUC01dsJjeJhH94TZZx/EIg56kJEUstzhAxg1pkoZ6sbOUjMhq++mCBRDRv1FdAtA==
X-Received: by 2002:a17:906:4789:b0:9c6:287d:c59d with SMTP id cw9-20020a170906478900b009c6287dc59dmr4606533ejc.28.1699537999843;
        Thu, 09 Nov 2023 05:53:19 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id q8-20020a1709060e4800b009de61c89f6fsm2549900eji.1.2023.11.09.05.53.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:53:19 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/5] semodule_link: avoid NULL dereference on OOM
Date:   Thu,  9 Nov 2023 14:53:11 +0100
Message-ID: <20231109135315.44095-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In case the initial calloc(3) call fails the variable mods is still NULL
while its size hint num_mods is set.

Reported by Clang Analyzer:

    semodule_link.c:182:29: warning: Array access (from variable 'mods') results in a null pointer dereference [core.NullDereference]
      182 |                 sepol_module_package_free(mods[i]);
          |                                           ^~~~~~~

Fixes: 63e798a2034a ("semodule_link: update")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 semodule-utils/semodule_link/semodule_link.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/semodule-utils/semodule_link/semodule_link.c b/semodule-utils/semodule_link/semodule_link.c
index 0f157bd9..58fca34d 100644
--- a/semodule-utils/semodule_link/semodule_link.c
+++ b/semodule-utils/semodule_link/semodule_link.c
@@ -178,9 +178,11 @@ failure:
 	ret = EXIT_FAILURE;
 
 cleanup:
-	for (i = 0; i < num_mods; i++)
-		sepol_module_package_free(mods[i]);
-	free(mods);
+	if (mods) {
+		for (i = 0; i < num_mods; i++)
+			sepol_module_package_free(mods[i]);
+		free(mods);
+	}
 	sepol_module_package_free(base);
 
 	return ret;
-- 
2.42.0

