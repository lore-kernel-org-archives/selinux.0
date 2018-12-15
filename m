Return-Path: <SRS0=8Orh=OY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDF2C43387
	for <selinux@archiver.kernel.org>; Sat, 15 Dec 2018 18:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFA42080F
	for <selinux@archiver.kernel.org>; Sat, 15 Dec 2018 18:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeLOSRe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 15 Dec 2018 13:17:34 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:46305 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeLOSRe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 15 Dec 2018 13:17:34 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id F00F25647E6
        for <selinux@vger.kernel.org>; Sat, 15 Dec 2018 19:17:31 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] python/sepolgen: always indent with 4 spaces
Date:   Sat, 15 Dec 2018 19:17:24 +0100
Message-Id: <20181215181724.31808-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Dec 15 19:17:32 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

p_attribute_role_def() used tabs.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolgen/src/sepolgen/refparser.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index 97e2342c4693..9fb931828278 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -757,9 +757,9 @@ def p_attribute_def(p):
     p[0] = a
 
 def p_attribute_role_def(p):
-	'attribute_role_def : ATTRIBUTE_ROLE IDENTIFIER SEMI'
-	a = refpolicy.Attribute_Role(p[2])
-	p[0] = a
+    'attribute_role_def : ATTRIBUTE_ROLE IDENTIFIER SEMI'
+    a = refpolicy.Attribute_Role(p[2])
+    p[0] = a
 
 def p_typealias_def(p):
     'typealias_def : TYPEALIAS IDENTIFIER ALIAS names SEMI'
-- 
2.19.2

