Return-Path: <SRS0=G5zd=6D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26B5C38A30
	for <selinux@archiver.kernel.org>; Sun, 19 Apr 2020 14:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5BF921973
	for <selinux@archiver.kernel.org>; Sun, 19 Apr 2020 14:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDSOBE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:01:04 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:35264 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSOBD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Apr 2020 10:01:03 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 776BC56125C
        for <selinux@vger.kernel.org>; Sun, 19 Apr 2020 16:01:01 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] python/semanage: check rc after getting it
Date:   Sun, 19 Apr 2020 16:00:55 +0200
Message-Id: <20200419140055.86159-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr 19 16:01:01 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This issue has been found using lgtm.com:
https://lgtm.com/projects/g/SELinuxProject/selinux/snapshot/4946f674a6da9cc368cc826f963aedd39b6a94cf/files/python/semanage/seobject.py?sort=name&dir=ASC&mode=heatmap#x5c052fffe98aee02:1

Fixes: 49706ad9f808 ("Revised Patch for local nodecon support in
semanage (was: Adding local nodecon's through semanage)")
Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/semanage/seobject.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 0e9ce2900892..f2a139c970bd 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1895,10 +1895,10 @@ class nodeRecords(semanageRecords):
         (rc, k) = semanage_node_key_create(self.sh, addr, mask, proto)
         if rc < 0:
             raise ValueError(_("Could not create key for %s") % addr)
-        if rc < 0:
-            raise ValueError(_("Could not check if addr %s is defined") % addr)
 
         (rc, exists) = semanage_node_exists(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not check if addr %s is defined") % addr)
         if exists:
             raise ValueError(_("Addr %s already defined") % addr)
 
-- 
2.26.0

