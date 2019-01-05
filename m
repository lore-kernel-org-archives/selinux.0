Return-Path: <SRS0=MvMz=PN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF278C43614
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 19:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC911222FE
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 19:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfAETiO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:38:14 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:44822 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfAETiO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Jan 2019 14:38:14 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3E26A5647F7
        for <selinux@vger.kernel.org>; Sat,  5 Jan 2019 20:38:12 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 5/5] python: run all the tests with "make test"
Date:   Sat,  5 Jan 2019 20:37:59 +0100
Message-Id: <20190105193759.3333-6-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105193759.3333-1-nicolas.iooss@m4x.org>
References: <20190105193759.3333-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  5 20:38:12 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/Makefile       | 4 +---
 python/chcat/Makefile | 2 ++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/python/Makefile b/python/Makefile
index 80bc124b6233..9b66d52fbd4d 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -1,8 +1,6 @@
 SUBDIRS = sepolicy audit2allow semanage sepolgen chcat
 
-all install relabel clean indent:
+all install relabel clean indent test:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
-
-test:
diff --git a/python/chcat/Makefile b/python/chcat/Makefile
index 290b9a6ec7dc..79620f60ca27 100644
--- a/python/chcat/Makefile
+++ b/python/chcat/Makefile
@@ -17,3 +17,5 @@ clean:
 indent:
 
 relabel:
+
+test:
-- 
2.20.1

