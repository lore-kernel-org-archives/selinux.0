Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29704C4338F
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 16:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F272261038
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 16:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhG1Q6r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Jul 2021 12:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229515AbhG1Q6q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Jul 2021 12:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627491524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mlIO1Gw+OYgwgFs1ozS0Bi3nKA7RqRCbct3WZu+8B0A=;
        b=fA3HjNvtY06C8YfCrOXNZZmkU7R75E4lLcvc6ntlO7UnsAJcL7VQP3Nof12awaE4SL3Jlq
        JFf5qfC/xhKR9O3P7s+3rZ2XDHQ1V0OqEFH2bfNxfgFu1bdnbzWvkDKFYRv4jQ+sstr97J
        nv1K2LqYqNS2sR8wUnrPfVosKTJoQnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-WZfKuok_NnG68yJTf8F-4A-1; Wed, 28 Jul 2021 12:58:42 -0400
X-MC-Unique: WZfKuok_NnG68yJTf8F-4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E0F6180FCCD
        for <selinux@vger.kernel.org>; Wed, 28 Jul 2021 16:58:41 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8102960C05;
        Wed, 28 Jul 2021 16:58:39 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] Do not use Python slip
Date:   Wed, 28 Jul 2021 18:58:35 +0200
Message-Id: <20210728165835.186338-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Python slip is not actively maintained anymore and it was used just as
a polkit proxy. It looks like polkit dbus interface is quite simple to
be used directly via python dbus module.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 dbus/selinux_server.py             | 69 ++++++++++++++++++------------
 python/sepolicy/sepolicy/sedbus.py |  9 ----
 2 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
index be4f4557a9fa..b7c9378bcb5d 100644
--- a/dbus/selinux_server.py
+++ b/dbus/selinux_server.py
@@ -4,26 +4,33 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 from gi.repository import GObject
-import slip.dbus.service
-from slip.dbus import polkit
 import os
 import selinux
 from subprocess import Popen, PIPE, STDOUT
 
 
-class selinux_server(slip.dbus.service.Object):
+class selinux_server(dbus.service.Object):
     default_polkit_auth_required = "org.selinux.semanage"
 
     def __init__(self, *p, **k):
         super(selinux_server, self).__init__(*p, **k)
 
+    def is_authorized(self, sender, action_id):
+        bus = dbus.SystemBus()
+        proxy = bus.get_object('org.freedesktop.PolicyKit1', '/org/freedesktop/PolicyKit1/Authority')
+        authority = dbus.Interface(proxy, dbus_interface='org.freedesktop.PolicyKit1.Authority')
+        subject = ('system-bus-name', {'name': sender})
+        result = authority.CheckAuthorization(subject, action_id, {}, 1, '')
+        return result[0]
+
     #
     # The semanage method runs a transaction on a series of semanage commands,
     # these commands can take the output of customized
     #
-    @slip.dbus.polkit.require_auth("org.selinux.semanage")
-    @dbus.service.method("org.selinux", in_signature='s')
-    def semanage(self, buf):
+    @dbus.service.method("org.selinux", in_signature='s', sender_keyword="sender")
+    def semanage(self, buf, sender):
+        if not self.is_authorized(sender, "org.selinux.semanage"):
+            raise dbus.exceptions.DBusException("Not authorized")
         p = Popen(["/usr/sbin/semanage", "import"], stdout=PIPE, stderr=PIPE, stdin=PIPE, universal_newlines=True)
         p.stdin.write(buf)
         output = p.communicate()
@@ -35,9 +42,10 @@ class selinux_server(slip.dbus.service.Object):
     # on the server.  This output can be used with the semanage method on
     # another server to make the two systems have duplicate policy.
     #
-    @slip.dbus.polkit.require_auth("org.selinux.customized")
-    @dbus.service.method("org.selinux", in_signature='', out_signature='s')
-    def customized(self):
+    @dbus.service.method("org.selinux", in_signature='', out_signature='s', sender_keyword="sender")
+    def customized(self, sender):
+        if not self.is_authorized(sender, "org.selinux.customized"):
+            raise dbus.exceptions.DBusException("Not authorized")
         p = Popen(["/usr/sbin/semanage", "export"], stdout=PIPE, stderr=PIPE, universal_newlines=True)
         buf = p.stdout.read()
         output = p.communicate()
@@ -49,9 +57,10 @@ class selinux_server(slip.dbus.service.Object):
     # The semodule_list method will return the output of semodule --list=full, using the customized polkit,
     # since this is a readonly behaviour
     #
-    @slip.dbus.polkit.require_auth("org.selinux.semodule_list")
-    @dbus.service.method("org.selinux", in_signature='', out_signature='s')
-    def semodule_list(self):
+    @dbus.service.method("org.selinux", in_signature='', out_signature='s', sender_keyword="sender")
+    def semodule_list(self, sender):
+        if not self.is_authorized(sender, "org.selinux.semodule_list"):
+            raise dbus.exceptions.DBusException("Not authorized")
         p = Popen(["/usr/sbin/semodule", "--list=full"], stdout=PIPE, stderr=PIPE, universal_newlines=True)
         buf = p.stdout.read()
         output = p.communicate()
@@ -62,25 +71,28 @@ class selinux_server(slip.dbus.service.Object):
     #
     # The restorecon method modifies any file path to the default system label
     #
-    @slip.dbus.polkit.require_auth("org.selinux.restorecon")
-    @dbus.service.method("org.selinux", in_signature='s')
-    def restorecon(self, path):
+    @dbus.service.method("org.selinux", in_signature='s', sender_keyword="sender")
+    def restorecon(self, path, sender):
+        if not self.is_authorized(sender, "org.selinux.restorecon"):
+            raise dbus.exceptions.DBusException("Not authorized")
         selinux.restorecon(str(path), recursive=1)
 
     #
     # The setenforce method turns off the current enforcement of SELinux
     #
-    @slip.dbus.polkit.require_auth("org.selinux.setenforce")
-    @dbus.service.method("org.selinux", in_signature='i')
-    def setenforce(self, value):
+    @dbus.service.method("org.selinux", in_signature='i', sender_keyword="sender")
+    def setenforce(self, value, sender):
+        if not self.is_authorized(sender, "org.selinux.setenforce"):
+            raise dbus.exceptions.DBusException("Not authorized")
         selinux.security_setenforce(value)
 
     #
     # The setenforce method turns off the current enforcement of SELinux
     #
-    @slip.dbus.polkit.require_auth("org.selinux.relabel_on_boot")
-    @dbus.service.method("org.selinux", in_signature='i')
-    def relabel_on_boot(self, value):
+    @dbus.service.method("org.selinux", in_signature='i', sender_keyword="sender")
+    def relabel_on_boot(self, value, sender):
+        if not self.is_authorized(sender, "org.selinux.relabel_on_boot"):
+            raise dbus.exceptions.DBusException("Not authorized")
         if value == 1:
             fd = open("/.autorelabel", "w")
             fd.close()
@@ -111,9 +123,10 @@ class selinux_server(slip.dbus.service.Object):
     #
     # The change_default_enforcement modifies the current enforcement mode
     #
-    @slip.dbus.polkit.require_auth("org.selinux.change_default_mode")
-    @dbus.service.method("org.selinux", in_signature='s')
-    def change_default_mode(self, value):
+    @dbus.service.method("org.selinux", in_signature='s', sender_keyword="sender")
+    def change_default_mode(self, value, sender):
+        if not self.is_authorized(sender, "org.selinux.change_default_mode"):
+            raise dbus.exceptions.DBusException("Not authorized")
         values = ["enforcing", "permissive", "disabled"]
         if value not in values:
             raise ValueError("Enforcement mode must be %s" % ", ".join(values))
@@ -122,9 +135,10 @@ class selinux_server(slip.dbus.service.Object):
     #
     # The change_default_policy method modifies the policy type
     #
-    @slip.dbus.polkit.require_auth("org.selinux.change_default_policy")
-    @dbus.service.method("org.selinux", in_signature='s')
-    def change_default_policy(self, value):
+    @dbus.service.method("org.selinux", in_signature='s', sender_keyword="sender")
+    def change_default_policy(self, value, sender):
+        if not self.is_authorized(sender, "org.selinux.change_default_policy"):
+            raise dbus.exceptions.DBusException("Not authorized")
         path = selinux.selinux_path() + value
         if os.path.isdir(path):
             return self.write_selinux_config(policy=value)
@@ -136,5 +150,4 @@ if __name__ == "__main__":
     system_bus = dbus.SystemBus()
     name = dbus.service.BusName("org.selinux", system_bus)
     object = selinux_server(system_bus, "/org/selinux/object")
-    slip.dbus.service.set_mainloop(mainloop)
     mainloop.run()
diff --git a/python/sepolicy/sepolicy/sedbus.py b/python/sepolicy/sepolicy/sedbus.py
index 76b259ae27e8..39b53d47753a 100644
--- a/python/sepolicy/sepolicy/sedbus.py
+++ b/python/sepolicy/sepolicy/sedbus.py
@@ -2,7 +2,6 @@ import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
-from slip.dbus import polkit
 
 
 class SELinuxDBus (object):
@@ -11,42 +10,34 @@ class SELinuxDBus (object):
         self.bus = dbus.SystemBus()
         self.dbus_object = self.bus.get_object("org.selinux", "/org/selinux/object")
 
-    @polkit.enable_proxy
     def semanage(self, buf):
         ret = self.dbus_object.semanage(buf, dbus_interface="org.selinux")
         return ret
 
-    @polkit.enable_proxy
     def restorecon(self, path):
         ret = self.dbus_object.restorecon(path, dbus_interface="org.selinux")
         return ret
 
-    @polkit.enable_proxy
     def setenforce(self, value):
         ret = self.dbus_object.setenforce(value, dbus_interface="org.selinux")
         return ret
 
-    @polkit.enable_proxy
     def customized(self):
         ret = self.dbus_object.customized(dbus_interface="org.selinux")
         return ret
 
-    @polkit.enable_proxy
     def semodule_list(self):
         ret = self.dbus_object.semodule_list(dbus_interface="org.selinux")
         return ret
 
-    @polkit.enable_proxy
     def relabel_on_boot(self, value):
         ret = self.dbus_object.relabel_on_boot(value, dbus_interface="org.selinux")
         return ret
 
-    @polkit.enable_proxy
     def change_default_mode(self, value):
         ret = self.dbus_object.change_default_mode(value, dbus_interface="org.selinux")
         return ret
 
-    @polkit.enable_proxy
     def change_default_policy(self, value):
         ret = self.dbus_object.change_default_policy(value, dbus_interface="org.selinux")
         return ret
-- 
2.32.0

