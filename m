Return-Path: <SRS0=nwEP=W4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C27C3A5A9
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154CD2190F
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfIASG6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Sep 2019 14:06:58 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:46151 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbfIASG6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Sep 2019 14:06:58 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C865B564884
        for <selinux@vger.kernel.org>; Sun,  1 Sep 2019 20:06:56 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 8/9] python/sepolicy: remove unnecessary pass statement
Date:   Sun,  1 Sep 2019 20:06:35 +0200
Message-Id: <20190901180636.31586-9-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190901180636.31586-1-nicolas.iooss@m4x.org>
References: <20190901180636.31586-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Sep  1 20:06:57 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This issue has been found using lgtm.com analyzer:
https://lgtm.com/projects/g/SELinuxProject/selinux/snapshot/eac5e661ca7300800000496fe13985286af70c6d/files/python/sepolicy/sepolicy/__init__.py?sort=name&dir=ASC&mode=heatmap#x9f8225117f52fb01:1

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/__init__.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 6aed31bddf1e..e4540977d042 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -539,7 +539,6 @@ def find_file(reg):
             path += "/"
     except IndexError:
         print("try failed got an IndexError")
-        pass
 
     try:
         pat = re.compile(r"%s$" % reg)
-- 
2.22.0

