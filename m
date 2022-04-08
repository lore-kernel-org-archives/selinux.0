Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBCBC4332F
	for <selinux@archiver.kernel.org>; Fri,  8 Apr 2022 13:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiDHNOO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbiDHNNs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Apr 2022 09:13:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34DE9
        for <selinux@vger.kernel.org>; Fri,  8 Apr 2022 06:10:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l7so11842424ejn.2
        for <selinux@vger.kernel.org>; Fri, 08 Apr 2022 06:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9F9dtmdOcSc2MlHmGjkjMt+e9PdjK30FhSjyMsFlJiM=;
        b=RrbWDNr+UvMgnnM8b4v8BYaxd4EqxqZylYOTzJqWgbvBspCwnyEuoFkuFGrjavBQXE
         getaXMg67iq7E3wils+JkRsg3BB+IqHGA59Gn8YNkp7xuSWKAmmuSVFnIxmgARSkVdHg
         hcwIMhgRh2tErXfVTn4+cTANErh0BHInZzAjD4Bik15KXgvE4Sp9GHxwCzhS+9FF/eRl
         Z2WioCLufShKpFKobvr71/JJN7ALbGdbQ+tZmtnWlrMGuyfIpEl6rZtNIiNwsKEF4FT2
         BffqNRVnoOjYZuL3sDRIeMovOxZkFV9INX17zBEWa4K07w5bSVtRhuF6PZ3CDuVAn6LH
         UrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9F9dtmdOcSc2MlHmGjkjMt+e9PdjK30FhSjyMsFlJiM=;
        b=3VjyipvV9CX01rvgfnzXKN3549iBuP8OmN+fnQbKsfzlar2exoE7ztSWJjUaKpvfH/
         UxMfaeoHwA+++b4gGxmehZjuZYljV5s6Y8cbUkBICmFVS9eg/OXAAXn5ZVZHl1Phppxr
         +b9RzcO41eISYXsgdAiyqE+lwc76jklZ12mFvdtgAvJlaSIiKeUFzsZIdRXYgGmLAf7H
         CGGmpKfHs59Ke+7UOtclQrsoZIBa32pJzi97nji7u8ULZT1SW6NbBxX01zVrDqMUcg8t
         4vnUK+ghAM6eB8MhO0u+ykAbCtaBiOWOxHLl+/wVzf7t2vgB7+IomQ72w45JJtjUBwjY
         uDQw==
X-Gm-Message-State: AOAM533ZL/RT7xrfH9Mv7RCUBHlfWZp+Vw9KPbQ7Q3sONZ3WQsv9hiOC
        991C0YCm/o6Oad8Tzi3eoVS4fwRGGj8=
X-Google-Smtp-Source: ABdhPJycq0/9FD7T3jcNLnFJ5TlOACeFqcKMjJ877i+h1bdvRs+v/hidAtbnMaDnLHf/9DusPPqxPw==
X-Received: by 2002:a17:906:16cc:b0:6ce:e607:ff02 with SMTP id t12-20020a17090616cc00b006cee607ff02mr18061583ejd.418.1649423458228;
        Fri, 08 Apr 2022 06:10:58 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-032-209.77.3.pool.telefonica.de. [77.3.32.209])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906111a00b006e778bd4fc8sm6398601eja.38.2022.04.08.06.10.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 06:10:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/5] libsepol/cil: declare file local function pointer static
Date:   Fri,  8 Apr 2022 15:10:50 +0200
Message-Id: <20220408131054.7957-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    ../cil/src/cil_log.c:45:8: warning: no previous extern declaration for non-static variable 'cil_log_handler' [-Wmissing-variable-declarations]
    void (*cil_log_handler)(int lvl, const char *msg) = &cil_default_log_handler;
           ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_log.c b/libsepol/cil/src/cil_log.c
index e45c58fc..f4c6e415 100644
--- a/libsepol/cil/src/cil_log.c
+++ b/libsepol/cil/src/cil_log.c
@@ -42,7 +42,7 @@ static void cil_default_log_handler(__attribute__((unused)) int lvl, const char
 	fprintf(stderr, "%s", msg);
 }
 
-void (*cil_log_handler)(int lvl, const char *msg) = &cil_default_log_handler;
+static void (*cil_log_handler)(int lvl, const char *msg) = &cil_default_log_handler;
 
 void cil_set_log_handler(void (*handler)(int lvl, const char *msg))
 {
-- 
2.35.1

