Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFD5C433F5
	for <selinux@archiver.kernel.org>; Fri, 11 Mar 2022 12:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiCKMok (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Mar 2022 07:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiCKMoj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Mar 2022 07:44:39 -0500
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 04:43:33 PST
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FC11B50E6
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 04:43:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 2C472E5C8400E
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 15:36:18 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id I6eg6QVJNGlb; Fri, 11 Mar 2022 15:36:17 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 8637BE5C89FA8;
        Fri, 11 Mar 2022 15:36:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 8637BE5C89FA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1647002177;
        bh=pJyICAYOFzRKWbDabo7pL0wUxeDQseoFU23J+OsGNOM=;
        h=Message-ID:Date:MIME-Version:From:To;
        b=TuRU/5ZtBXtEEG+FbAILm+5mik9h8oQXe+Ev1nkJZlfbb1kV0+4b6zzIEnN+ykKPP
         UV8qXpjqD3NIlHMQYVt6y7+B0qb2Hl/pWIrXu2t5PAoyQJieoet59grLI64SPAcToV
         pNVjYlQ/tldcqXpK457pZ+2seH1NdMSzDjXIf7ZSjnzXeSwJyiFclT7mV4Z8pGfQxA
         48H0r8+iDqliWqKhtSSFf6I0LGIyD/vjxC6joplpvGN+g6Ky1I/yYfV/Bqz0JBx0qN
         O6tQc89WjCscnF5gqPSkPO38P6l218BgDwz5lGlYuOaaY6/knsVVbYyKgK7q/oNtzq
         kbDBopoBz7tHg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8SG42ZSfBjux; Fri, 11 Mar 2022 15:36:17 +0300 (MSK)
Received: from [192.168.1.248] (unknown [89.250.9.56])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id 56ACAE5C70376;
        Fri, 11 Mar 2022 15:36:17 +0300 (MSK)
Message-ID: <5b0956dd-ad07-6209-7b68-d0574874876c@rosalinux.ru>
Date:   Fri, 11 Mar 2022 15:36:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Subject: [PATCH] gui: do not recreate /etc/selinux/config
References: <>
Content-Language: en-US
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
In-Reply-To: <>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


/etc/selinux/config.bck was created and then replaced /etc/selinux/config.
/etc/selinux/config is often read by libselinux from non-root,
it must have mode 0644, but, when umask is 077, it became not world-readable
after running system-config-gui.

Overwrite the existing file instead of creating a new one.

Unfortunately, we may get a corrupted file if the GUI is closed when writing it,
but writing takes only a bit of time, plus we save a backup for manual restoring in such case.

At Github: https://github.com/SELinuxProject/selinux/pull/345

Signed-off-by: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
---
 gui/statusPage.py | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/gui/statusPage.py b/gui/statusPage.py
index 766854b1..ded3929d 100644
--- a/gui/statusPage.py
+++ b/gui/statusPage.py
@@ -18,6 +18,7 @@
 ## Author: Dan Walsh
 import os
 import sys
+import tempfile
 from gi.repository import Gtk
 import selinux
 
@@ -162,12 +163,20 @@ class statusPage:
         self.enabled = enabled
 
     def write_selinux_config(self, enforcing, type):
-        path = selinux.selinux_path() + "config"
-        backup_path = path + ".bck"
-        fd = open(path)
-        lines = fd.readlines()
-        fd.close()
-        fd = open(backup_path, "w")
+        selinux_path = selinux.selinux_path()
+        path = selinux_path + "config"
+        # Make a backup /etc/selinux/config.*.bck
+        backup_path = tempfile.mkstemp(prefix="config.", dir=selinux_path, suffix=".bck")[1]
+        fd1 = open(path, "r")
+        lines = fd1.readlines()
+        fd1.close()
+        fd2 = open(backup_path, "a")
+        for l in lines:
+            fd2.write(l)
+        fd2.close()
+        # Write to path, not backup_path, to guarantee that file metadata
+        # (permissions, xattrs, including SELinux labels etc.) is not lost.
+        fd = open(path, "w")
         for l in lines:
             if l.startswith("SELINUX="):
                 fd.write("SELINUX=%s\n" % enforcing)
@@ -177,7 +186,9 @@ class statusPage:
                 continue
             fd.write(l)
         fd.close()
-        os.rename(backup_path, path)
+        # Here we are sure that we are deleting our backup,
+        # not another file or directory
+        os.unlink(backup_path)
 
     def read_selinux_config(self):
         self.initialtype = selinux.selinux_getpolicytype()[1]
-- 
2.31.1

