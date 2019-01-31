Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2B1C282DA
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0125218AC
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfAaVIP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:08:15 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:40442 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfAaVIP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 16:08:15 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9380F5646AC
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 22:08:13 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] python/sepolicy: fix variable name
Date:   Thu, 31 Jan 2019 22:07:53 +0100
Message-Id: <20190131210753.11221-4-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131210753.11221-1-nicolas.iooss@m4x.org>
References: <20190131210753.11221-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 31 22:08:13 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

modify_button_clicked() used variable "type" in a comparison instead of
"ftype". This is a bug, which has been found with flake8 3.7.0. This
linter reported:

    python/sepolicy/sepolicy/gui.py:1548:20: F823 local variable 'type'
    {0} referenced before assignment

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/gui.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index fde233ad98b1..d4bf3b48e629 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -1545,7 +1545,7 @@ class SELinuxGui():
                 path = self.executable_files_liststore.get_value(iter, 0)
                 self.files_path_entry.set_text(path)
                 ftype = self.executable_files_liststore.get_value(iter, 1)
-                if type != None:
+                if ftype != None:
                     self.combo_set_active_text(self.files_type_combobox, ftype)
                 tclass = self.executable_files_liststore.get_value(iter, 2)
                 if tclass != None:
-- 
2.20.1

