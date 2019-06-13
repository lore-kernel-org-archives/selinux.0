Return-Path: <SRS0=L/M1=UM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1816C31E45
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 20:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744512147A
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 20:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="wfODYOXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfFMUSx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:18:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42208 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfFMUSx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jun 2019 16:18:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id b18so225243qkc.9
        for <selinux@vger.kernel.org>; Thu, 13 Jun 2019 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1ATBrGbBodn7IdZDaxe/DJze4pBLx7T/hPCKqLjnAY=;
        b=wfODYOXadeaNFkTXWmPGmsq2OA9hz36+XbaEvTE/gjtZ9pDP8Xroaolj7HQ0eJC36f
         cjjpJjAytd1l73ma1tZrLgoilGAMaanfob1PCc2TsgrSYVqxgemxOB0vpiURVNa3XFr3
         ydpDfJJLW1tFuqULKEgqZj4y/a5ABxlN8pFeKzyeElB0qJo+H+8VcuNiuuFjCBUR17dw
         hZ1aokf5QuDGu0wLLJuFDITjrw8pEIuJwQS07uPcXpzqP36cECFQD7TyKu5G1f+DpBR9
         yfcfWaa/CYrgsPpgHVylaAEl1PMQPiO+s/DkpF9tZxdfgg5tJFnzDiT05D8hVZu0c8MW
         hL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1ATBrGbBodn7IdZDaxe/DJze4pBLx7T/hPCKqLjnAY=;
        b=TBiy9D/hJ7Av6QU0wufTLMkBtvcLUtS3juOlzZRou3GLQmyq8gHm3OHYy4PEG3qkVg
         ZoohHqkHv7dkwQc3GMZT2KViplaSpf2qqXfHPYTwy9lx0LlYf+W8u//C25vrzqMVSb76
         eCGZGICwcZY/af3sUawpt1xtNicKHecf+D6T7Z2EhjiNvHOngB421JiqDry6O4MHcwK6
         JvVHqbasnH50xmnz/MXAVxI9afBSI+j6uOo8eQCJ234V4x7KqOweIp6efbWCbrJ/3uXu
         nEscV5wE65s2ez32nTAOM/Tt7Q99cIgXmPtreMv/HldfbbHWIgMI2xCWwjQiSSBNcbrT
         S/Kg==
X-Gm-Message-State: APjAAAUxTpVbhHhfDuqFpNfoZUX4h+5ii4aS5oW9E0ERZLrB0bqRehv5
        TcbRm4ZcTz2842n0xnPTR2fwOFBTXDvkFQ==
X-Google-Smtp-Source: APXvYqytQ2fVWo2FfZgbtSsZIlq8A8lsSx9n8GyblY54TS6r7tslWJyfIqQA7IH+n5qYGH2qFdW83w==
X-Received: by 2002:a37:5f82:: with SMTP id t124mr5713029qkb.180.1560457131978;
        Thu, 13 Jun 2019 13:18:51 -0700 (PDT)
Received: from mls-centos.localdomain (pool-71-244-250-129.bltmmd.fios.verizon.net. [71.244.250.129])
        by smtp.gmail.com with ESMTPSA id h40sm592418qth.4.2019.06.13.13.18.51
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 13:18:51 -0700 (PDT)
From:   Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
X-Google-Original-From: Yuli Khodorkovskiy <yuli@crunchydata.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: error in CIL if a permission cannot be resolved
Date:   Thu, 13 Jun 2019 16:18:27 -0400
Message-Id: <20190613201827.8616-1-yuli@crunchydata.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In the following example, "relabeltoo" is not a valid permission
in the loaded policy nor in the new module. Before, CIL would not
complain about the invalid permission and proceed to install the module:

	$ cat test.cil

	(mlsconstrain (db_procedure (create relabeltoo)) (eq l2 h2))

With this patch, an error is now prompted to a user:

	$ sudo semodule -i foo.cil

	Failed to resolve permission relabeltoo
	Failed to resolve mlsconstrain statement at /etc/selinux/mls/tmp/modules/400/test/cil:1
	semodule:  Failed!

Signed-off-by: Yuli Khodorkovskiy <yuli@crunchydata.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index ea08087d..22d37f05 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -135,8 +135,11 @@ static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab,
 				if (class_flavor == CIL_MAP_CLASS) {
 					cil_log(CIL_ERR, "Failed to resolve permission %s for map class\n", (char*)curr->data);
 					goto exit;
+				} else if (class_flavor == CIL_CLASS) {
+					cil_log(CIL_ERR, "Failed to resolve permission %s\n", (char*)curr->data);
+					goto exit;
 				}
-				cil_log(CIL_WARN, "Failed to resolve permission %s\n", (char*)curr->data);
+
 				/* Use an empty list to represent unknown perm */
 				cil_list_init(&empty_list, perm_strs->flavor);
 				cil_list_append(*perm_datums, CIL_LIST, empty_list);
-- 
2.19.0

