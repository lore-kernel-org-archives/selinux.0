Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C0DC432C3
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 14:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1FF2073C
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 14:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TM9nS59T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfKOOyj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:54:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34949 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727496AbfKOOyj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Nov 2019 09:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573829678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NRDOTMcXr74c41Yw39XxFq04Lp6UslrXHeRwYhqGmVA=;
        b=TM9nS59TKv+NK0ag7NurxnicahR8L6BpYY63b/I4najftj012PGvfP9L3/ZKzq01f/VvT7
        irx72wjD2dh8cKdOQwNHy4UJXOUOmlULjw6TpdqBHhTp3/iVU1YEZC2ooIoZ/mO124ypWB
        HWqUTWFKoCHrft5Nz6/HqLm55w11LQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-PphsVbyoMkmtgVwuDuvGXg-1; Fri, 15 Nov 2019 09:54:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74D6D802B57
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2019 14:54:36 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.206.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADC4060BA9;
        Fri, 15 Nov 2019 14:54:35 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] dbus: Fix FileNotFoundError in org.selinux.relabel_on_boot
Date:   Fri, 15 Nov 2019 15:54:25 +0100
Message-Id: <20191115145425.1460016-1-plautrba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: PphsVbyoMkmtgVwuDuvGXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When org.selinux.relabel_on_boot(0) was called twice, it failed with
FileNotFoundError.

Fixes:
    $ dbus-send --system --print-reply --dest=3Dorg.selinux /org/selinux/ob=
ject org.selinux.relabel_on_boot int64:1
    method return sender=3D:1.53 -> dest=3D:1.54 reply_serial=3D2
    $ dbus-send --system --print-reply --dest=3Dorg.selinux /org/selinux/ob=
ject org.selinux.relabel_on_boot int64:0
    method return sender=3D:1.53 -> dest=3D:1.55 reply_serial=3D2
    $ dbus-send --system --print-reply --dest=3Dorg.selinux /org/selinux/ob=
ject org.selinux.relabel_on_boot int64:0
    Error org.freedesktop.DBus.Python.FileNotFoundError: FileNotFoundError:=
 [Errno 2] No such file or directory: '/.autorelabel'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

Note: This is python 3 only code and it fails in travis with PYVER=3Dpython=
2.7 RUBYLIBVER=3D2.6:

$ PATH=3D"$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8

Analyzing 187 Python scripts

./dbus/selinux_server.py:90:20: F821 undefined name 'FileNotFoundError'

./installdir/usr/share/system-config-selinux/selinux_server.py:90:20: F821 =
undefined name 'FileNotFoundError'

The command "PATH=3D"$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8" exited w=
ith 1.



 dbus/selinux_server.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
index b9debc071485..be4f4557a9fa 100644
--- a/dbus/selinux_server.py
+++ b/dbus/selinux_server.py
@@ -85,7 +85,10 @@ class selinux_server(slip.dbus.service.Object):
             fd =3D open("/.autorelabel", "w")
             fd.close()
         else:
-            os.unlink("/.autorelabel")
+            try:
+                os.unlink("/.autorelabel")
+            except FileNotFoundError:
+                pass
=20
     def write_selinux_config(self, enforcing=3DNone, policy=3DNone):
         path =3D selinux.selinux_path() + "config"
--=20
2.23.0

