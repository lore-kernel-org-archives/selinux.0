Return-Path: <SRS0=MvMz=PN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DE4C43387
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 15:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD002085A
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 15:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfAEPqW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Jan 2019 10:46:22 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:34514 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAEPqW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Jan 2019 10:46:22 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D1AA1561204
        for <selinux@vger.kernel.org>; Sat,  5 Jan 2019 16:46:19 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] python/semanage: explain why sepolicy is imported in a function
Date:   Sat,  5 Jan 2019 16:45:50 +0100
Message-Id: <20190105154551.18768-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  5 16:46:20 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Importing modules inside functions is quite uncommon in Python. This is
nevertheless required with sepolicy because it loads the current SELinux
policy when it is imported (and raises ValueError when this fails).

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/semanage/semanage | 1 +
 1 file changed, 1 insertion(+)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 1cb136831422..49add51ec24e 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -83,6 +83,7 @@ class CheckRole(argparse.Action):
         if not newval:
             newval = []
         try:
+            # sepolicy tries to load the SELinux policy and raises ValueError if it fails.
             import sepolicy
             roles = sepolicy.get_all_roles()
         except ValueError:
-- 
2.20.1

