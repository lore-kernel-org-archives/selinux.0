Return-Path: <SRS0=G5zd=6D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4842C38A30
	for <selinux@archiver.kernel.org>; Sun, 19 Apr 2020 13:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC03212CC
	for <selinux@archiver.kernel.org>; Sun, 19 Apr 2020 13:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDSN7B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:59:01 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:33517 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSN7B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Apr 2020 09:59:01 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E493E5649CF
        for <selinux@vger.kernel.org>; Sun, 19 Apr 2020 15:58:58 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libselinux/utils: remove unneeded variable in Makefile
Date:   Sun, 19 Apr 2020 15:58:52 +0200
Message-Id: <20200419135852.85888-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr 19 15:58:59 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

LD_SONAME_FLAGS is not used when building libselinux utils.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/utils/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index a5632b7c38ec..b018a08acbe0 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -36,8 +36,6 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-overflow=5 \
           $(EXTRA_CFLAGS)
 
-LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
-
 ifeq ($(OS), Darwin)
 override CFLAGS += -I/opt/local/include -I../../libsepol/include
 override LDFLAGS += -L../../libsepol/src -undefined dynamic_lookup
-- 
2.26.0

