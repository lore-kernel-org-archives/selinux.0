Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1734C6FD1D
	for <selinux@archiver.kernel.org>; Sat,  1 Apr 2023 12:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjDAMtU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Apr 2023 08:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAMtU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 Apr 2023 08:49:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E374BBDD6
        for <selinux@vger.kernel.org>; Sat,  1 Apr 2023 05:49:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn12so100167917edb.4
        for <selinux@vger.kernel.org>; Sat, 01 Apr 2023 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680353356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xlqh7ugzslSndF0LaBgkgXIfX3GlBd4RBqjXmGlFUBg=;
        b=QwBtInG8iS+EJS9uCn8/ZUkj+Nx0ZvxKLLebvQRWEOC036To2od40Y1jISPOsEzPMn
         iTO511doUOU53d4mEd/Js3C3ZGQB9c64wSYOhGX364sjA2KAyZD4oXihIyYKUsc700Uc
         bcoKVUxFrimr9MbQ8Pe7RS1kexE1iX1SHWGd3wbNImGVMH4+6H3D6xMDY/5DCGTnkiBZ
         2FQtteeLVLYXTMGkrMwuSasGGu785WlmZVNrT2kiKT5hn64Pw1IJoG40S8srpCnc5BvV
         SOV628fe8VXbhS6PNbzu6k7w07J9dUgYdnULJFBgBvxE3QaQAAuF5mYX+wv1OgMPWYtl
         4drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680353356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xlqh7ugzslSndF0LaBgkgXIfX3GlBd4RBqjXmGlFUBg=;
        b=x5pOO9zyhnWeMoh5kJhPISieMUW2hspwzZtpzLdkZk8w85wOnMWtkZHxY8B++Z7XfF
         aTIOrLxjvBjhv6Z0+ww5xKFNQYnjESP0m3KoIoA4aJnOaJWZV06jBsoWJ0mQe0G0/N7e
         fgV6NBdbYGjbQpF5A/2KiNoBT2vDYJFH1P16c4acEEV8cPtEPG/Ye8jYtTERG/O2u8Ia
         MQoKBpj/Pf6rdLPcOgLpTud4FHpNAd91DgHXgno6U9zJ0a6Kg6ltiPahL/W7pwgYGEpm
         /s84YJn7IRlXzZhea7LKg1sb7UrpmKEoeSWxJTkmEUmAGm6K5UvIVzJ7Mq3p2iUsqH+1
         iBbQ==
X-Gm-Message-State: AAQBX9dW3bgblh7VCWckRG/tUCmQBQwoVzCtLfqlwCFMunCiHpJw3ozv
        sUISCrNRzOl2sNTMcPL0FWD2VB9aOlNDNGjC
X-Google-Smtp-Source: AKy350ZeSLhIFEMY1qtdtDXz+mePWf3wqXyR59cN3FpffofGjQA8KvhCu7ndTZFXLDWXLnDZnbtZWw==
X-Received: by 2002:a17:906:da1b:b0:932:b790:932c with SMTP id fi27-20020a170906da1b00b00932b790932cmr28035821ejb.44.1680353356153;
        Sat, 01 Apr 2023 05:49:16 -0700 (PDT)
Received: from dlaptop.localdomain (dynamic-077-000-142-208.77.0.pool.telefonica.de. [77.0.142.208])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709067c0d00b009353047c02dsm2023248ejo.167.2023.04.01.05.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 05:49:15 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsemanage: fix memory leak in semanage_user_roles
Date:   Sat,  1 Apr 2023 14:49:02 +0200
Message-Id: <20230401124902.76959-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The output parameter `role_arr` of semanage_user_get_roles() is an array
of non-owned role names.  Since the array is never used again, as its
contents have been copied into the return value `roles`, free it.

Example leak report from useradd(8):

    Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x5597624284a8 in __interceptor_calloc (./shadow/src/useradd+0xee4a8)
    #1 0x7f53aefcbbf9 in sepol_user_get_roles src/user_record.c:270:21
---
 libsemanage/src/seusers_local.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
index 6508ec05..795a33d6 100644
--- a/libsemanage/src/seusers_local.c
+++ b/libsemanage/src/seusers_local.c
@@ -47,6 +47,7 @@ static char *semanage_user_roles(semanage_handle_t * handle, const char *sename)
 						}
 					}
 				}
+				free(roles_arr);
 			}
 			semanage_user_free(user);
 		}
-- 
2.40.0

