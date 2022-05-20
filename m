Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F9C433EF
	for <selinux@archiver.kernel.org>; Fri, 20 May 2022 13:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiETNUD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 May 2022 09:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbiETNUB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 May 2022 09:20:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449955A167
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:20:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id jx22so2126943ejb.12
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUROwXI7qLAnF6FmcKxKjFR0hDOgddsSEuDP0tfpFO4=;
        b=l8uY8M9MurGcyqUC46+lXbKKFoJyI+stswJDn/IPOiFkyIhVmiJdtyamVziJKTFlbU
         4LdTABv7wJuf2HZOROgDEP9dM15moL1SdPAjsBj1sQSQ+aiv5lOGL6jqE4sgpDe+03xX
         vwDY6WEa8edhFG4gZm1h16wPjcFer3HyNG5PPRomkJdz5lstpogEuyRSuzuN3BK3hGcd
         KiHfPg5EROWaPELH9bIs7QXT5h5hYba0QyvxkGmwuhtvdm/lnanJOb8oDojtVqOXGgZN
         0YFtoxpT8ZESfahaJ4p+zXHNS6Y6JN/WtvCUsidu/t6SmIzMgb1K8Toxuz3buHURsWlc
         CW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUROwXI7qLAnF6FmcKxKjFR0hDOgddsSEuDP0tfpFO4=;
        b=RSuBiGNDBKxQ+UngcY5k/oS3OG5REIzO2axsuddjJUCYMZhMRC9v0qI/zn0VANZXp0
         xOBgvNd1hR5yQEwLr6bQ15kcuSuDq2xHkCkZrhXqJ5nF2dmsu4TJ9xHziyf5aK1u/2ZA
         DcE087V7inwX0X4Bojs4SZvKEOaxO44HaFOG2BY93lboVAFXuVeck4AxidkwQ2GESuoZ
         SzKLlFpOQLQrbD/72w1ALlIv/WVh1dDLzHQNDCR64cJuG4IhcXoaNdy7+XQBGaH8ysLi
         HCF9wW40HOpRMSw22/Ce9oSyTKAuMmCe8uU4m6P8wuPz0hiWqMLdXyDvHvorYuNHPSNe
         EIIA==
X-Gm-Message-State: AOAM531mNVYqnk6krqLTuAIvAjj5SkZIRjTLr8Sy4BJE7vgWSXCiFCRa
        ut4V6OF90WsVv3WOkytOBznDiwNaEjM=
X-Google-Smtp-Source: ABdhPJxqr7Oei39eoMQ/ZhfjfXLk2JOThP1dN6w6IynCCW8ouMHq/vYpe45Seo7lg/DTZ/XZSd0Flw==
X-Received: by 2002:a17:907:629c:b0:6e1:6ad:5dd8 with SMTP id nd28-20020a170907629c00b006e106ad5dd8mr8540112ejc.641.1653052798809;
        Fri, 20 May 2022 06:19:58 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-251-125.77.8.pool.telefonica.de. [77.8.251.125])
        by smtp.gmail.com with ESMTPSA id a12-20020aa7c80c000000b0042617ba637esm4320184edt.8.2022.05.20.06.19.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 06:19:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] semodule: avoid toctou on output module
Date:   Fri, 20 May 2022 15:19:52 +0200
Message-Id: <20220520131952.12286-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not check for file existence and open afterwards, open with the
exclusive flag (supported in Glibc and musl 0.9.6 and also standardized
in C11).

Found by GitHub CodeQL.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/semodule/semodule.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 1ed8e690..48bc28dd 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -550,15 +550,12 @@ int main(int argc, char *argv[])
 					goto cleanup_extract;
 				}
 
-				if (access(output_path, F_OK) == 0) {
-					fprintf(stderr, "%s: %s is already extracted with extension %s.\n", argv[0], mode_arg, lang_ext);
-					result = -1;
-					goto cleanup_extract;
-				}
-
-				output_fd = fopen(output_path, "w");
+				output_fd = fopen(output_path, "wx");
 				if (output_fd == NULL) {
-					fprintf(stderr, "%s: Unable to open %s\n", argv[0], output_path);
+					if (errno == EEXIST)
+						fprintf(stderr, "%s: %s is already extracted with extension %s.\n", argv[0], mode_arg, lang_ext);
+					else
+						fprintf(stderr, "%s: Unable to open %s:  %s\n", argv[0], output_path, strerror(errno));
 					result = -1;
 					goto cleanup_extract;
 				}
-- 
2.36.1

