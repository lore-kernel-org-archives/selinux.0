Return-Path: <SRS0=oqeB=XT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2270C432C1
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 19:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF442146E
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 19:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441892AbfIXTPb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:15:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441891AbfIXTPa (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 24 Sep 2019 15:15:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C91D310DCC9F
        for <selinux@vger.kernel.org>; Tue, 24 Sep 2019 19:15:30 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F6C710018FF;
        Tue, 24 Sep 2019 19:15:29 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] python/semanage: Do not use default s0 range in "semanage login -a"
Date:   Tue, 24 Sep 2019 21:15:23 +0200
Message-Id: <20190924191523.246357-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Tue, 24 Sep 2019 19:15:30 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Using the "s0" default means that new login mappings are always added with "s0"
range instead of the range of SELinux user.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/semanage | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 1934a561..f4266cef 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -237,7 +237,7 @@ def parser_add_level(parser, name):
 
 
 def parser_add_range(parser, name):
-    parser.add_argument('-r', '--range', default="s0",
+    parser.add_argument('-r', '--range', default='',
                         help=_('''
 MLS/MCS Security Range (MLS/MCS Systems only)
 SELinux Range  for SELinux login mapping
-- 
2.23.0

