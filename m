Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F8DC43334
	for <selinux@archiver.kernel.org>; Fri, 10 Jun 2022 15:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbiFJPGp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jun 2022 11:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiFJPGo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jun 2022 11:06:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4264A22A628
        for <selinux@vger.kernel.org>; Fri, 10 Jun 2022 08:06:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n28so35684877edb.9
        for <selinux@vger.kernel.org>; Fri, 10 Jun 2022 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WeeG9ptY77+n/BKo/tmcItSWHWLzdrkvKuObO2MdiPU=;
        b=aS5qtJjFR6FBanx+ZTcn+lLM9UObvoYcYDpjFcvDtLmcQ7k+roOAwHnD6YInLfTxiN
         Za5yX1F6598L9IX6ZVJYSVSTjxiSdjwwWlvB4CKvWBYojjL54fRyWy1hjPgRXYUnpQuK
         5xKi0/lUieQI4R/qvDVDmpNhnAHjAkotBLC2viHbCYtjQ+bG/AwUmtl1j3NhflwAfeJx
         aDrzMXjENebIjiRriJmogkRXQyWRFjddo7MHUtWAZj3vPJ1IvoWvu97gmWkQzZ53UP8i
         Ae9edN/BjnDxIqrYR007FcMadwXbduzm5NtLho7kadFx9Py/S8pRgVjO7/rOS3H5hdrP
         W6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WeeG9ptY77+n/BKo/tmcItSWHWLzdrkvKuObO2MdiPU=;
        b=Nlucc/2Fmbje1f74UwMYypW5AjWfggX4vy47tZW0Tyt19TCvxGxvIA3CppJYpeAJni
         6UgOjP3r9T2t84pUQR+ipTP45gTmIB5UUpRuRPZeRUQnNaoTOlL5IaVMCABftSJsIXNR
         hFCiYAI8sK5ymeSKn7JEnTxfkS2deUQSGveNa14e0XT9JSrTBGTLVX5Iw6tHzvFNZpY3
         OxLcEZN52LdXBroBSxkxa8QGUd8ZVKVjTHeNuLplpg6NOe05XINO9rBudXaQLB6sy9h+
         vB2YXQMKO4Eza7mF1Z98uwh8FDw6bw1qC5Tfyv1agioyhZrIgZEN/CGXsfkB8gagJEx4
         dMbw==
X-Gm-Message-State: AOAM532R0rNU9Ep//PZkX3Zo2/MHdbmDojyTp5DF8bTOk6O3zpGmcFya
        6EG6j1csZBZdmTyd8P/Z6XCNn1Ig8jY=
X-Google-Smtp-Source: ABdhPJxZclVtZWOmRHS4JLlrGWINXslXRE6nMVXjDDMoPq6sIextSa9JaGJD2kkDLRoUyAYtuPMMow==
X-Received: by 2002:aa7:d295:0:b0:42d:e371:ded2 with SMTP id w21-20020aa7d295000000b0042de371ded2mr52282863edq.336.1654873601724;
        Fri, 10 Jun 2022 08:06:41 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-083-029.95.116.pool.telefonica.de. [95.116.83.29])
        by smtp.gmail.com with ESMTPSA id h14-20020aa7c94e000000b0042e03eed448sm15203440edt.20.2022.06.10.08.06.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 08:06:40 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] checkpolicy: error out if required permission would exceed limit
Date:   Fri, 10 Jun 2022 17:06:37 +0200
Message-Id: <20220610150637.21133-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A require statement for a class permission adds that permission to the
class representation for the current module.  In case the resulting
class would have more than the supported amount of 32 permissions
assigned the resulting binary module will fail to load at link-time
without an informative error message (since [1]).

Bail out if adding a permission would result in a class having more then
the supported amount of 32 permissions assigned.

[1]: https://github.com/SELinuxProject/selinux/commit/97af65f69644a3233d073ae93980a0d2e51f42e1

Closes: https://github.com/SELinuxProject/selinux/issues/356
Reported-by: Julie Pichon
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/module_compiler.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 129650fa..3188af89 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -851,6 +851,14 @@ int require_class(int pass)
 				free(perm_id);
 				return -1;
 			}
+			if (datum->permissions.nprim >= PERM_SYMTAB_SIZE) {
+				yyerror2("Class %s would have too many permissions "
+					 "to fit in an access vector with permission %s",
+					 policydbp->p_class_val_to_name[datum->s.value - 1],
+					 perm_id);
+				free(perm_id);
+				return -1;
+			}
 			allocated = 1;
 			if ((perm = malloc(sizeof(*perm))) == NULL) {
 				yyerror("Out of memory!");
-- 
2.36.1

