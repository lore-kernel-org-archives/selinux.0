Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF5C43444
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 22:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E284220874
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 22:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeLSWOL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:14:11 -0500
Received: from mx3.polytechnique.org ([91.121.62.107]:38868 "EHLO
        mx3.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSWOL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Dec 2018 17:14:11 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 96DBC1E4D24
        for <selinux@vger.kernel.org>; Wed, 19 Dec 2018 23:14:09 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] semanage_migrate_store: remove unused loading of libsepol.so
Date:   Wed, 19 Dec 2018 23:13:19 +0100
Message-Id: <20181219221320.8594-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181219221320.8594-1-nicolas.iooss@m4x.org>
References: <20181219221320.8594-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at mx3.polytechnique.org (Wed Dec 19 23:14:09 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

semanage_migrate_store loads libsepol.so using ctypes but never uses it.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/utils/semanage_migrate_store | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
index 7b5bee819e24..360f143e9fca 100755
--- a/libsemanage/utils/semanage_migrate_store
+++ b/libsemanage/utils/semanage_migrate_store
@@ -8,9 +8,6 @@ import shutil
 import sys
 from optparse import OptionParser
 
-import ctypes
-
-sepol = ctypes.cdll.LoadLibrary('libsepol.so.1')
 
 try:
 	import selinux
-- 
2.19.1

