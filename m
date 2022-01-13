Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AC1C433EF
	for <selinux@archiver.kernel.org>; Thu, 13 Jan 2022 16:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbiAMQEk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jan 2022 11:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbiAMQEk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jan 2022 11:04:40 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1351AC061574
        for <selinux@vger.kernel.org>; Thu, 13 Jan 2022 08:04:40 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id y10so7359107qtw.1
        for <selinux@vger.kernel.org>; Thu, 13 Jan 2022 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isgZ83pbo4BVHifZOzEVXOnCWu/8vUUkOPjN16BSv6E=;
        b=WlBm3rR6RWhBqrOgvbN6i7AOakXnQps4DTr8orET8eEUzDJfA6aPxor9cBBmSVXNEu
         fed35e5fpX1iB/8hczVYNU0CKHwxD/cUJztB9ua/aHmbdV3cbkuOWCCS36YMGSRCfnCO
         W7wf7nBq0jg9CqDl4bNq05zK7OvaXRKXTYfMGI4H4txwruTVDDPY0b40nvDOSVSzATTg
         xgAqZLMdY1c6e50e9ZnD5yq+XR+eWVWIgm8KR/vXb8WRDuxyPgGxReATjyWhU4nyBsSc
         fh34WqI8ifK9AzmZD37gF4mBd54UU4SlbqZTjbQE2GmIo1q3FRpk+Lh3wn8AxDZtuwij
         heyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isgZ83pbo4BVHifZOzEVXOnCWu/8vUUkOPjN16BSv6E=;
        b=mTcEHaM1sLg3ThdXkacuYdSbMU3DarNVc8V2Sox/FN8Tdfu/uOPwCsaVVOMtIMCQSX
         Cn41YnKGfCew7L9RwQk2nEcNjUz3I/ZrM6oZ4FHYpE9NF74SWZOsp0PBZX4vKMlTvW2C
         uNTBrwHUeug+74ee4+P8cJyl5j6KHdb3JFbtVVsjiBRi1dWgi+RDsFNRnJnW90plQkdP
         /p1lzHFi6OzmfxZYvLegHd9Ns24or1oXNyPntvMxwJD08ANrv6Bu42HN0gs9Kf3hbdrS
         qOP0euIZnyoedvb2fGiGLedfBJlq8iLveuhqEWiGItNY4Lq/LtEM07I4xzGtyHv8lx7q
         kQlg==
X-Gm-Message-State: AOAM5319QKiQXM2YXZoXfUVNLczzGvbO+amWD5itvP1Dsc90jOAcb1+B
        hqn7Q2y67HzWt9vvdu2dH9OEVuXXkM0=
X-Google-Smtp-Source: ABdhPJzZECJizpZuNtMSqJNe+NC+KZ2at1dbWUpRSrHmATz0c823yH3n1CJecOENewtNOR+eSaUUow==
X-Received: by 2002:ac8:53c9:: with SMTP id c9mr4156924qtq.348.1642089879160;
        Thu, 13 Jan 2022 08:04:39 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id bj26sm2142318qkb.58.2022.01.13.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:04:38 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Ensure that the class in a classcommon is a kernel class
Date:   Thu, 13 Jan 2022 11:04:22 -0500
Message-Id: <20220113160422.675541-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Map classes use the same struct as kernel classes, but only the kernel
class uses the pointer to a common class. When resolving a classcommon,
make sure that the class that is found is a kernel class and not a
map class. If not, then return an error.

Found by oss-fuzz (#43209)

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index e97a9f46..d359eca0 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -754,6 +754,11 @@ int cil_resolve_classcommon(struct cil_tree_node *current, void *extra_args)
 	if (rc != SEPOL_OK) {
 		goto exit;
 	}
+	if (NODE(class_datum)->flavor != CIL_CLASS) {
+		cil_log(CIL_ERR, "Class %s is not a kernel class and cannot be associated with common %s\n", clscom->class_str, clscom->common_str);
+		rc = SEPOL_ERR;
+		goto exit;
+	}
 
 	rc = cil_resolve_name(current, clscom->common_str, CIL_SYM_COMMONS, extra_args, &common_datum);
 	if (rc != SEPOL_OK) {
-- 
2.31.1

