Return-Path: <SRS0=+qLe=O6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8995AC43612
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9CE21906
	for <selinux@archiver.kernel.org>; Fri, 21 Dec 2018 20:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390482AbeLUUnv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:43:51 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:42741 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390465AbeLUUnv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Dec 2018 15:43:51 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3E0E6561205
        for <selinux@vger.kernel.org>; Fri, 21 Dec 2018 21:43:49 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/4] python/audit2allow/sepolgen-ifgen: show errors on stderr
Date:   Fri, 21 Dec 2018 21:43:32 +0100
Message-Id: <20181221204333.27445-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221204333.27445-1-nicolas.iooss@m4x.org>
References: <20181221204333.27445-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Dec 21 21:43:49 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This allows test_audit2allow.py to display the errors correctly.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/audit2allow/sepolgen-ifgen | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/python/audit2allow/sepolgen-ifgen b/python/audit2allow/sepolgen-ifgen
index aa1ae8dc21d2..e3f67d430647 100644
--- a/python/audit2allow/sepolgen-ifgen
+++ b/python/audit2allow/sepolgen-ifgen
@@ -135,8 +135,7 @@ def main():
     try:
         headers = refparser.parse_headers(options.headers, output=log, debug=options.debug)
     except ValueError as e:
-        print("error parsing headers")
-        print(str(e))
+        sys.stderr.write("error parsing headers: %s\n" % e)
         return 1
 
     if_set = interfaces.InterfaceSet(output=log)
-- 
2.19.1

