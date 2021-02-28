Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D62DC433DB
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDB864D99
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 17:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhB1RFI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Feb 2021 12:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhB1RFH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Feb 2021 12:05:07 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72BBC061756;
        Sun, 28 Feb 2021 09:04:26 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id k13so23796505ejs.10;
        Sun, 28 Feb 2021 09:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CRBQ3jHUDLveOi1cHYKrTjafEL9eOBQAA47NGR6XM7Q=;
        b=dGUempTjXA5VIO5nANVB/AOn0x4Pqpzw1Gm/qVGUGDLQm+XdteIuomBnIpeim2iqq5
         jeEadEcMtLzbppYwAGJuOlrTFouXcg2/XikXjbFRxa2h521/UKD5oGlfzE29fZQRD6G2
         aAfRzHn1rbUDZZJmWd0dBVAug8ZJGS3Ee1/Kmp/9s/nEjiFJWTQ7K9P6pKbH1MVcbAY8
         l0ixlpgjVetHJM7fOZo6j0yGk26rmECs/HNzgWvYuhj1NNeCce3iRf/aijwSdCNYyB8v
         Kxr9KcDUp3iPhrLWxU1iK4evzvRdAf74QNF89Ny7e9B+3Zwt+9YVDHI7W9nOwrcYwF0J
         /cqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CRBQ3jHUDLveOi1cHYKrTjafEL9eOBQAA47NGR6XM7Q=;
        b=deAZfR9PYPHu+cKOZpq0WEh2deWoy/D35DtqBQoY5tQTSG82WqhaYwxyV8DPnISOaf
         kE4SNp97Hn+rKeFebyNUDE0S3nmTv3Kske6u9+nTqvsmJKeIrCPtPz5zMhybtUkm+YoM
         x9IQOsUrFp/pP2WX69giNYKdqg5iHImlX0/d9PyDYOF+KO40q5C/x2vUJbWwPVYhXL4R
         6J6yLIhYlzZeCdTDTndM275QS8dXBLN/dw9dqXbY2bjD7XkbU4QJ/JjnRbor0ITZZZQb
         CYEUkFLJgqZt0OSSL/Eh5pdABMsYUOXkqY9QI3oAS2g1FnjikkHQehr0X8Olu3xAdwck
         gP8w==
X-Gm-Message-State: AOAM530SG3Xnh2ofxVp79djph0ZAKSWUQWygKqyjT04lmlLlDdqqQAXX
        rpgYeYs4DLhlgNYufmam9g==
X-Google-Smtp-Source: ABdhPJz0uwxotaIZrHVAETI2JKePcm97l5KszY//oTLTnCGyKGODEmeiLYkRj0xZMqH3+ZDSqTqM2w==
X-Received: by 2002:a17:906:4f96:: with SMTP id o22mr12001318eju.511.1614531865649;
        Sun, 28 Feb 2021 09:04:25 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.223])
        by smtp.gmail.com with ESMTPSA id bx2sm9443432edb.80.2021.02.28.09.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 09:04:25 -0800 (PST)
Date:   Sun, 28 Feb 2021 20:04:23 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, selinux@vger.kernel.org
Subject: [PATCH 09/11] pragma once: convert
 scripts/selinux/genheaders/genheaders.c
Message-ID: <YDvNF+QVOv3vqDbm@localhost.localdomain>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From 097f2c8b2af7d9e88cff59376ea0ad51b95341cb Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 9 Feb 2021 00:39:23 +0300
Subject: [PATCH 09/11] pragma once: convert scripts/selinux/genheaders/genheaders.c

Generate security/selinux/flask.h and security/selinux/av_permissions.h
without include guards.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 scripts/selinux/genheaders/genheaders.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
index f355b3e0e968..e13ee4221993 100644
--- a/scripts/selinux/genheaders/genheaders.c
+++ b/scripts/selinux/genheaders/genheaders.c
@@ -74,8 +74,8 @@ int main(int argc, char *argv[])
 			initial_sid_to_string[i] = stoupperx(s);
 	}
 
+	fprintf(fout, "#pragma once\n");
 	fprintf(fout, "/* This file is automatically generated.  Do not edit. */\n");
-	fprintf(fout, "#ifndef _SELINUX_FLASK_H_\n#define _SELINUX_FLASK_H_\n\n");
 
 	for (i = 0; secclass_map[i].name; i++) {
 		struct security_class_mapping *map = &secclass_map[i];
@@ -109,7 +109,6 @@ int main(int argc, char *argv[])
 	fprintf(fout, "\treturn sock;\n");
 	fprintf(fout, "}\n");
 
-	fprintf(fout, "\n#endif\n");
 	fclose(fout);
 
 	fout = fopen(argv[2], "w");
@@ -119,8 +118,8 @@ int main(int argc, char *argv[])
 		exit(4);
 	}
 
+	fprintf(fout, "#pragma once\n");
 	fprintf(fout, "/* This file is automatically generated.  Do not edit. */\n");
-	fprintf(fout, "#ifndef _SELINUX_AV_PERMISSIONS_H_\n#define _SELINUX_AV_PERMISSIONS_H_\n\n");
 
 	for (i = 0; secclass_map[i].name; i++) {
 		struct security_class_mapping *map = &secclass_map[i];
@@ -136,7 +135,6 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	fprintf(fout, "\n#endif\n");
 	fclose(fout);
 	exit(0);
 }
-- 
2.29.2

