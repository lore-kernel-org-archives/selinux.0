Return-Path: <SRS0=nwEP=W4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8A4C3A5A7
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C372190F
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 18:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfIASG6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Sep 2019 14:06:58 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47685 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbfIASG5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Sep 2019 14:06:57 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 219E4564880
        for <selinux@vger.kernel.org>; Sun,  1 Sep 2019 20:06:56 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 7/9] python/chcat: remove unnecessary assignment
Date:   Sun,  1 Sep 2019 20:06:34 +0200
Message-Id: <20190901180636.31586-8-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190901180636.31586-1-nicolas.iooss@m4x.org>
References: <20190901180636.31586-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Sep  1 20:06:56 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

chcat_add() defines variable cmd twice before calling
subprocess.check_call(cmd, ...). Remove the first definition.

This bug was found using lgtm.com analyzer:
https://lgtm.com/projects/g/SELinuxProject/selinux/snapshot/eac5e661ca7300800000496fe13985286af70c6d/files/python/chcat/chcat?sort=name&dir=ASC&mode=heatmap#L118

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/chcat/chcat | 1 -
 1 file changed, 1 deletion(-)

diff --git a/python/chcat/chcat b/python/chcat/chcat
index ba398684376d..fdd2e46ee3f9 100755
--- a/python/chcat/chcat
+++ b/python/chcat/chcat
@@ -115,7 +115,6 @@ def chcat_add(orig, newcat, objects, login_ind):
     errors = 0
     sensitivity = newcat[0]
     cat = newcat[1]
-    cmd = 'chcon -l %s' % sensitivity
     for f in objects:
         (rc, c) = selinux.getfilecon(f)
         con = c.split(":")[3:]
-- 
2.22.0

