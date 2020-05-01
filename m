Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E2DC4724C
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 09:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C767B2070B
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 09:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgEAJXh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 05:23:37 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:39258 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgEAJXg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 05:23:36 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A4C8C5649B5
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 11:23:34 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/tests: drop ncurses dependency
Date:   Fri,  1 May 2020 11:23:30 +0200
Message-Id: <20200501092330.1129016-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri May  1 11:23:34 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

ncurses library is not used anywhere.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml             | 1 -
 libsepol/tests/Makefile | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 918958acfc80..4361d26cbb83 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -53,7 +53,6 @@ addons:
     - libcap-ng-dev # This package is not whitelisted for the container infrastructure (https://github.com/travis-ci/apt-package-whitelist/issues/1096)
     - libcunit1-dev
     - libdbus-glib-1-dev
-    - libncurses5-dev
     - libpcre3-dev
     - patch
     - python3-dev
diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
index e7e305e8150b..fc9bd1a303be 100644
--- a/libsepol/tests/Makefile
+++ b/libsepol/tests/Makefile
@@ -32,7 +32,7 @@ all: $(EXE) $(policies)
 policies: $(policies)
 
 $(EXE): $(objs) $(parserobjs) $(LIBSEPOL)
-	$(CC) $(LDFLAGS) $(objs) $(parserobjs) -lcunit -lcurses $(LIBSEPOL) -o $@
+	$(CC) $(LDFLAGS) $(objs) $(parserobjs) -lcunit $(LIBSEPOL) -o $@
 
 %.conf.std: $(m4support) %.conf
 	$(M4) $(M4PARAMS) $^ > $@
-- 
2.26.2

