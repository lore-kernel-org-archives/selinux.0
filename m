Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BF2C282D9
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 19:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D722218AF
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 19:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfAaTmN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:42:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfAaTmM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 31 Jan 2019 14:42:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2F63C01A693
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 19:42:12 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.205.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3C5019C7D;
        Thu, 31 Jan 2019 19:42:11 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Dan Walsh <dwalsh@redhat.com>, Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] dbus: Fix name of polkit function
Date:   Thu, 31 Jan 2019 20:42:08 +0100
Message-Id: <20190131194208.3855-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 31 Jan 2019 19:42:12 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Dan Walsh <dwalsh@redhat.com>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 dbus/org.selinux.policy | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dbus/org.selinux.policy b/dbus/org.selinux.policy
index 01266102..9772127b 100644
--- a/dbus/org.selinux.policy
+++ b/dbus/org.selinux.policy
@@ -70,9 +70,9 @@
 	  <allow_active>auth_admin_keep</allow_active>
         </defaults>
     </action>
-    <action id="org.selinux.change_policy_type">
-        <description>SELinux write access</description>
-        <message>System policy prevents change_policy_type access to SELinux</message>
+    <action id="org.selinux.change_default_mode">
+        <description>Change SELinux default enforcing mode</description>
+        <message>System policy prevents change_default_policy access to SELinux</message>
         <defaults>
           <allow_any>no</allow_any>
           <allow_inactive>no</allow_inactive>
-- 
2.20.1

