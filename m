Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0669C433ED
	for <selinux@archiver.kernel.org>; Thu, 22 Apr 2021 06:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8DD6144A
	for <selinux@archiver.kernel.org>; Thu, 22 Apr 2021 06:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhDVGon (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Apr 2021 02:44:43 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57901 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhDVGom (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Apr 2021 02:44:42 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 95118564673
        for <selinux@vger.kernel.org>; Thu, 22 Apr 2021 08:44:06 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: do not duplicate make target when going into subdirectory
Date:   Thu, 22 Apr 2021 08:43:56 +0200
Message-Id: <20210422064356.249361-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Apr 22 08:44:06 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When running "make install-pywrap", make displays:

    make[1]: Entering directory '/root/selinux/libselinux'
    make -C src install-pywrap install-pywrap
    make[2]: Entering directory '/root/selinux/libselinux/src'

The duplicated "install-pywrap" is not expected. Remove it from the
Makefile.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index ac16c15e8d0a..439bc6a9b7fd 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -50,24 +50,24 @@ all install relabel clean distclean indent:
 	done
 
 swigify: all
-	$(MAKE) -C src swigify $@
+	$(MAKE) -C src $@
 
 pywrap: 
-	$(MAKE) -C src pywrap $@
+	$(MAKE) -C src $@
 
 rubywrap: 
-	$(MAKE) -C src rubywrap $@
+	$(MAKE) -C src $@
 
 install-pywrap: 
-	$(MAKE) -C src install-pywrap $@
+	$(MAKE) -C src $@
 
 install-rubywrap: 
-	$(MAKE) -C src install-rubywrap $@
+	$(MAKE) -C src $@
 
 clean-pywrap:
-	$(MAKE) -C src clean-pywrap $@
+	$(MAKE) -C src $@
 
 clean-rubywrap:
-	$(MAKE) -C src clean-rubywrap $@
+	$(MAKE) -C src $@
 
 test:
-- 
2.31.0

