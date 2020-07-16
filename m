Return-Path: <SRS0=s7s9=A3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBABC433E6
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 20:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351F320787
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 20:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgGPUjW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:39:22 -0400
Received: from smtprelay0099.b.hostedemail.com ([64.98.42.99]:39958 "EHLO
        smtprelay.b.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgGPUjV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jul 2020 16:39:21 -0400
Received: from smtprelay.b.hostedemail.com (10.5.19.248.rfc1918.com [10.5.19.248])
        by smtpgrave02.b.hostedemail.com (Postfix) with ESMTP id D96871802937E
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 20:29:22 +0000 (UTC)
Received: from filter.hostedemail.com (10.5.19.248.rfc1918.com [10.5.19.248])
        by smtprelay04.b.hostedemail.com (Postfix) with ESMTP id 484F910053779
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 20:29:22 +0000 (UTC)
X-Session-Marker: 6D696B6540666C796E2E6F7267
X-HE-Tag: show42_150866826f05
X-Filterd-Recvd-Size: 1536
Received: from imp (pool-173-67-42-132.bltmmd.fios.verizon.net [173.67.42.132])
        (Authenticated sender: mike@flyn.org)
        by omf06.b.hostedemail.com (Postfix) with ESMTPA
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 20:29:22 +0000 (UTC)
Message-ID: <51d7bd5e067978ea5340ee408a7329e8b921b372.camel@flyn.org>
Subject: [PATCH] python/audit2allow: add #include <limits.h> to
 sepolgen-ifgen-attr-helper.c
From:   "W. Michael Petullo" <mike@flyn.org>
To:     selinux@vger.kernel.org
Date:   Thu, 16 Jul 2020 15:29:20 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I found that building on OpenWrt/musl failed with:

  sepolgen-ifgen-attr-helper.c:152:16: error: 'PATH_MAX' undeclared ...

Musl is less "generous" than glibc in recursively including header
files, and I suspect this is the reason for this error. Explicitly
including limits.h fixes the problem.

Signed-off-by: W. Michael Petullo <mike@flyn.org>
---
 python/audit2allow/sepolgen-ifgen-attr-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/python/audit2allow/sepolgen-ifgen-attr-helper.c
b/python/audit2allow/sepolgen-ifgen-attr-helper.c
index 53f20818..f010c958 100644
--- a/python/audit2allow/sepolgen-ifgen-attr-helper.c
+++ b/python/audit2allow/sepolgen-ifgen-attr-helper.c
@@ -28,6 +28,7 @@

 #include <selinux/selinux.h>

+#include <limits.h>
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-- 
2.26.2

