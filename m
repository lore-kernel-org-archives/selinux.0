Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14481C4338F
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 16:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E5561038
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 16:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhG1Q7c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Jul 2021 12:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhG1Q7b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Jul 2021 12:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627491569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VGVM2XpUXUk2VxYNWsTZM2qEFJFdn7mRThLsqfm9pe4=;
        b=MM4JidnJg1LRouWVQW82OIXijfOjz+tGS0WkUsYtW+0ZzJz50Yub0Orb2hhkudjsewkvv0
        /EfCDM0VoHEKBIdh6P5RxxKrP1h+BlpS8okbcW++BzKZutq88DB7weTsCsXLNiYH2LwUxr
        frY9Xl1y4opQ6qXVI0XbxiWC8AORgUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552--IasMwgtNdqOetQJPaUQuw-1; Wed, 28 Jul 2021 12:59:27 -0400
X-MC-Unique: -IasMwgtNdqOetQJPaUQuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D6F01008061
        for <selinux@vger.kernel.org>; Wed, 28 Jul 2021 16:59:27 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABE0E1002F12;
        Wed, 28 Jul 2021 16:59:25 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] dbus: Use GLib.MainLoop()
Date:   Wed, 28 Jul 2021 18:59:22 +0200
Message-Id: <20210728165922.186631-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes:
    PyGIDeprecationWarning: GObject.MainLoop is deprecated; use GLib.MainLoop instead

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 dbus/selinux_server.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
index b7c9378bcb5d..a969f2268ceb 100644
--- a/dbus/selinux_server.py
+++ b/dbus/selinux_server.py
@@ -2,8 +2,9 @@
 
 import dbus
 import dbus.service
-import dbus.mainloop.glib
+from dbus.mainloop.glib import DBusGMainLoop
 from gi.repository import GObject
+from gi.repository import GLib
 import os
 import selinux
 from subprocess import Popen, PIPE, STDOUT
@@ -145,9 +146,10 @@ class selinux_server(dbus.service.Object):
         raise ValueError("%s does not exist" % path)
 
 if __name__ == "__main__":
-    mainloop = GObject.MainLoop()
-    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+    DBusGMainLoop(set_as_default=True)
+    mainloop = GLib.MainLoop()
+
     system_bus = dbus.SystemBus()
     name = dbus.service.BusName("org.selinux", system_bus)
-    object = selinux_server(system_bus, "/org/selinux/object")
+    server = selinux_server(system_bus, "/org/selinux/object")
     mainloop.run()
-- 
2.32.0

