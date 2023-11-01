Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2144DC4167B
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 16:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjKAQjG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 12:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjKAQjF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 12:39:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D3211B
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 09:38:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9936b3d0286so876066b.0
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1698856736; x=1699461536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dgfR2AgFc1I2SFVe3n9IAyyMKOOlzGhJSrJjcJdyxUE=;
        b=MJTVCzw6HEVwad9GmkasO7LI945jvNJkMMe59vfwfJnlQdmqzqv3PgXMbDZMefx+k3
         iCaqpGiBbNCT4f0+e5wkeU5SNKRUNJP2AoqBgXFGpCExJ56qO3qIGyPsdBUtg9IsrWdJ
         hpi6p1wNDPK2N+gV9yTlNMWXW+dOIPfvkPBw0Cl/bLssUsTWINvd0sjourFM2NllmTUX
         47CJEuSPzoG5LP8E4hEMy7EqzSY3hcXIaqjbhyzPPl2bDqCGuQaJv4ebQhvIZjSp5mhC
         zXsZEhWalPDh1AbMHyEK1Cf5ystgVrs/XtqBhumMChnJMsY48ZV3kN7QpF7uE1CcIeVd
         Mpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856736; x=1699461536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgfR2AgFc1I2SFVe3n9IAyyMKOOlzGhJSrJjcJdyxUE=;
        b=g3EYSHgu51mqOdjqx6Ytq/R6FMnJluHLnh/SbhwtQcjsoVHVMl48HONHvwbJSM5jDh
         G8POvLM+wl4btpMi4ue/ORzBHzUQlC2Ay/FL+ZHiXyKBjdPe9MUt8RLcZtMdU7bl9LF6
         lpOeBBNyEQyjh6f8oF2WXyz3unIvWh8cG1ku7Ee3Z9lfsk5LSZ1L9vE5dhTCCFdobmpF
         vD5b7AauOk9LZwrbkRKucZh5RM1rQQJ8eAr1vDiubswhpKQZo+KH/ci8YzhuZJ00+84y
         2zJpNU1H5G9JKCVsNErtUkZAKB4exYoZdqL7zVTk4pEinPp5HNwrx7vLkQAEvmpA/sfG
         z3qg==
X-Gm-Message-State: AOJu0YzQy4DA/iwdZWyds2pjcJ+dEfKRMa6Zoky6qzgRqOtBd1VO2kCP
        JnsapyYIfVOpmEaU3usag4stwAwbaxI=
X-Google-Smtp-Source: AGHT+IFfr/WHRFc0XTXOc/VRYsj2lhlqafbP9ea8QEuz4XkUaSVCWW29P4R+wtiI8ua3p9pImQfXVQ==
X-Received: by 2002:a17:907:36ca:b0:9d2:e2f6:45b2 with SMTP id bj10-20020a17090736ca00b009d2e2f645b2mr2136916ejc.71.1698856735921;
        Wed, 01 Nov 2023 09:38:55 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-163-023.95.116.pool.telefonica.de. [95.116.163.23])
        by smtp.gmail.com with ESMTPSA id f27-20020a170906049b00b009adc77fe165sm115818eja.118.2023.11.01.09.38.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:38:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: ignore writing invalid polcaps in fuzzer
Date:   Wed,  1 Nov 2023 17:38:52 +0100
Message-ID: <20231101163852.177983-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Kernel policies with unsupported policy capabilities enabled can
currently be parsed, since they result just in a bit set inside an
ebitmap.  Writing such a loaded policy into the traditional language or
CIL will fail however, since unsupported policy capabilities can not
be converted into names.

This currently affects the fuzzer, since it generates such policies and
then fails to write them.

Ignore writing invalid policy capabilities only for the fuzzer.  Thus
users can still use old libsepol versions to analyze (but not write)
policies with new policy capabilities, since capabilities can be
introduced without a new policy version.

Reported-by: oss-fuzz (issue 60573)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c  | 4 ++++
 libsepol/src/kernel_to_conf.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 8fcc385d..f94d67f5 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1198,9 +1198,13 @@ static int write_polcap_rules_to_cil(FILE *out, struct policydb *pdb)
 	ebitmap_for_each_positive_bit(&pdb->policycaps, node, i) {
 		name = sepol_polcap_getname(i);
 		if (name == NULL) {
+#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+			continue;
+#else
 			ERR(NULL, "Unknown policy capability id: %i", i);
 			rc = -1;
 			goto exit;
+#endif
 		}
 
 		rc = strs_create_and_add(strs, "(policycap %s)", 1, name);
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index b0ae16d9..a752667c 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1181,9 +1181,13 @@ static int write_polcap_rules_to_conf(FILE *out, struct policydb *pdb)
 	ebitmap_for_each_positive_bit(&pdb->policycaps, node, i) {
 		name = sepol_polcap_getname(i);
 		if (name == NULL) {
+#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+			continue;
+#else
 			ERR(NULL, "Unknown policy capability id: %i", i);
 			rc = -1;
 			goto exit;
+#endif
 		}
 
 		rc = strs_create_and_add(strs, "policycap %s;", 1, name);
-- 
2.42.0

