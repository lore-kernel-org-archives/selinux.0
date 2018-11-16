Return-Path: <SRS0=w7Fl=N3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA609C43441
	for <selinux@archiver.kernel.org>; Fri, 16 Nov 2018 12:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6482087A
	for <selinux@archiver.kernel.org>; Fri, 16 Nov 2018 12:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6482087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeKPWiU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:38:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbeKPWiU (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 16 Nov 2018 17:38:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FCE9C04B2DD;
        Fri, 16 Nov 2018 12:26:11 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.43.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 218E1600C2;
        Fri, 16 Nov 2018 12:26:09 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Tom Gundersen <teg@jklm.no>, David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] dbus: remove deprecated at_console statement
Date:   Fri, 16 Nov 2018 13:25:59 +0100
Message-Id: <20181116122559.30868-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 16 Nov 2018 12:26:11 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Tom Gundersen <teg@jklm.no>

As described in [0], this likely did not have the intended effect, so
simply remove it. The change in behavior is that up until this patch
it would be possible for any non-system user to potentially gain access
to selinux' dbus interface. Now this is extended to also allow any
system user.

As the comment indicates, PolicyKit is used to enforce access, so this
should be perfectly harmless.

[0]: <https://www.spinics.net/lists/linux-bluetooth/msg75267.html>

Signed-off-by: Tom Gundersen <teg@jklm.no>
CC: David Herrmann <dh.herrmann@gmail.com>
---

This patch is from PR 113 - https://github.com/SELinuxProject/selinux/pull/113

 dbus/org.selinux.conf | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/dbus/org.selinux.conf b/dbus/org.selinux.conf
index a3509781..1ae079d2 100644
--- a/dbus/org.selinux.conf
+++ b/dbus/org.selinux.conf
@@ -12,12 +12,8 @@
 
   <!-- Allow anyone to invoke methods on the interfaces,
        authorization is performed by PolicyKit -->
-  <policy at_console="true">
-    <allow send_destination="org.selinux"/>
-  </policy>
   <policy context="default">
-    <allow send_destination="org.selinux"
-	   send_interface="org.freedesktop.DBus.Introspectable"/>
+    <allow send_destination="org.selinux"/>
   </policy>
 
 </busconfig>
-- 
2.19.1

