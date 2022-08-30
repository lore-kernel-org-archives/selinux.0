Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D1DECAAD1
	for <selinux@archiver.kernel.org>; Tue, 30 Aug 2022 17:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiH3R5W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 13:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiH3R5A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Aug 2022 13:57:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD39813F23
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 10:55:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b44so15212386edf.9
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 10:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=VBIReXHyzyLstwxGnNvLmENR7KbXOx8zuIFXJgpTAts=;
        b=UZ8/WeNp4EY5obi8MkbvCCL7KzLo31qGx7KkPY/DrKEiYBjevdO3+yvC4bWB5ygcrW
         MLgIkkmOddTkNZ1Q12ziG1+JUB6yQeQnfV4e8iXE6dFMJc9lRVAd5jtITLfrFKCiWGVi
         nzbTxRdEF/tLGXH26dpSiSPfZWlc3TYyTuyozLGL+uCqijwHO24ZMIkmnSfi4/QTXCIf
         sx4ngP0iSZwYobKLOYY5n5wyS9ozLSWIYHJK0tWnu1bDa2wLxNbeJg6uqUZpPgFjzx03
         zpERgqeN84LYJ0DOgCed0eJBFrwemrhDcdlFLHyShEzTNfD7VEG8831QoUa0FA8LcpMM
         MxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=VBIReXHyzyLstwxGnNvLmENR7KbXOx8zuIFXJgpTAts=;
        b=CbqOdfwCWnYtNdZ4RnvuUOStMruGDrc5rzHIBI4CmkiDBBAtRifuN0JcjVGDptFLtD
         C581FxZwO2N5p12o/7++WXtIKB92+tMLmVfDoHg0qVqyZrSOrG7SBMrqHV5p4BCbDFml
         sRtVJswANGaAUFfqqKXbPPDlSkkuWFsgy23f+KMWK2iPwNfAPWyGuy+FCX2z6FRZX43B
         8/uXQMmhG5mom7tJINjFKi4AvQ7IQWIEx+UeVJmCCPffyG9Dk+u1D+wsW7KdgA2Ac38D
         MwtUwEzQkrrsgkIg127/Q6ZCfifXIBYipGYjsGNhUUTmT9yqpC7v2XrtVNtwg0OBCciQ
         z4ZQ==
X-Gm-Message-State: ACgBeo0pk7QBdA4UjFLig6cbB4G3hZxtZm8MohB26a7Tp0Nf5ItpqOS3
        UJwnRIXDDEOtir7fEUr4giRkw9sYHgwB/A==
X-Google-Smtp-Source: AA6agR6gSF1jGXpMGLTebESruhDH+C0xjnocDLqtRdOModWlEzBdZfgPBB5dp2+1/jl9pKbPlHbuHQ==
X-Received: by 2002:a05:6402:34d2:b0:448:9fac:206e with SMTP id w18-20020a05640234d200b004489fac206emr6383444edc.171.1661882101395;
        Tue, 30 Aug 2022 10:55:01 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-163-172.95.116.pool.telefonica.de. [95.116.163.172])
        by smtp.gmail.com with ESMTPSA id q3-20020a056402032300b004478be33bddsm4965203edw.15.2022.08.30.10.55.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 10:55:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: support objname in compute_create
Date:   Tue, 30 Aug 2022 19:54:55 +0200
Message-Id: <20220830175455.40660-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Support passing an optional object name to compute_create for name
based type transitions.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/compute_create.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/libselinux/utils/compute_create.c b/libselinux/utils/compute_create.c
index c6481f4b..5401fe96 100644
--- a/libselinux/utils/compute_create.c
+++ b/libselinux/utils/compute_create.c
@@ -10,10 +10,11 @@ int main(int argc, char **argv)
 {
 	char *buf;
 	security_class_t tclass;
+	const char *objname;
 	int ret;
 
-	if (argc != 4) {
-		fprintf(stderr, "usage:  %s scontext tcontext tclass\n",
+	if (argc != 4 && argc != 5) {
+		fprintf(stderr, "usage:  %s scontext tcontext tclass [objname]\n",
 			argv[0]);
 		exit(1);
 	}
@@ -34,7 +35,9 @@ int main(int argc, char **argv)
 		exit(2);
 	}
 
-	ret = security_compute_create(argv[1], argv[2], tclass, &buf);
+	objname = (argc == 5) ? argv[4] : NULL;
+
+	ret = security_compute_create_name(argv[1], argv[2], tclass, objname, &buf);
 	if (ret < 0) {
 		fprintf(stderr, "%s:  security_compute_create failed:  %s\n",
 			argv[0], strerror(errno));
-- 
2.37.2

