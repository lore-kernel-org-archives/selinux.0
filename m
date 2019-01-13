Return-Path: <SRS0=s3OI=PV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA82C43387
	for <selinux@archiver.kernel.org>; Sun, 13 Jan 2019 17:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FE220675
	for <selinux@archiver.kernel.org>; Sun, 13 Jan 2019 17:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfAMRo5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 13 Jan 2019 12:44:57 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:42653 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfAMRo5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 13 Jan 2019 12:44:57 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B8A38561262
        for <selinux@vger.kernel.org>; Sun, 13 Jan 2019 18:44:54 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] python/sepolicy: initialize mislabeled_files in __init__()
Date:   Sun, 13 Jan 2019 18:44:25 +0100
Message-Id: <20190113174425.27403-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jan 13 18:44:55 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Using "sepolicy gui" sometimes leads to an exception when entering the
Files tab:

    Traceback (most recent call last):
      File "python/sepolicy/sepolicy/gui.py", line 1345, in tab_change
        self.show_mislabeled_files_only.set_visible(self.mislabeled_files)
    AttributeError: 'SELinuxGui' object has no attribute 'mislabeled_files'

Indeed, when application_selected() calls show_applications_page(), this
function calls tab_change(), which can use mislabeled_files in this
line:

    self.show_mislabeled_files_only.set_visible(self.mislabeled_files)

Make sure that mislabeled_files is initialized by defining it in
__init__(), in order to fix this error. Its value will be properly set
later, by calling several initializers, which is why the original
assignment to False is kept in:

    self.mislabeled_files = False
    self.executable_files_initialize(app)
    self.network_initialize(app)
    self.writable_files_initialize(app)
    self.transitions_into_initialize(app)
    self.transitions_from_initialize(app)
    self.application_files_initialize(app)
    self.transitions_files_initialize(app)

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/gui.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 9d413652f2ed..fde233ad98b1 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -149,6 +149,7 @@ class SELinuxGui():
         self.clear_entry = True
         self.files_add = False
         self.network_add = False
+        self.mislabeled_files = False
 
         self.all_domains = []
         self.installed_list = []
-- 
2.20.1

