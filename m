Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfU029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FE52C059724
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:14 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 15/19] dbus: Use text streams in selinux_server.py
Date: Wed,  3 May 2017 12:30:32 +0200
Message-Id: <20170503103036.17514-16-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

subprocess.Popen called without universal_newlines=True opens stdin,
stout and stderr as binary stream which cause problems with Python 3.

Fixes:
Traceback (most recent call last):
  File "/usr/lib64/python3.4/site-packages/sepolicy/gui.py", line 2773, in unconfined_toggle
    self.dbus.semanage("module -e unconfined")
  File "<string>", line 2, in semanage
  File "/usr/lib/python3.4/site-packages/slip/dbus/polkit.py", line 121, in _enable_proxy
    return func(*p, **k)
  File "/usr/lib64/python3.4/site-packages/sepolicy/sedbus.py", line 14, in semanage
    ret = self.dbus_object.semanage(buf, dbus_interface = "org.selinux")
  File "/usr/lib64/python3.4/site-packages/dbus/proxies.py", line 145, in __call__
    **keywords)
  File "/usr/lib64/python3.4/site-packages/dbus/connection.py", line 651, in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Python.TypeError: TypeError: 'dbus.String' does not support the buffer interface

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 dbus/selinux_server.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
index aae8b5fa..6e380e58 100644
--- a/dbus/selinux_server.py
+++ b/dbus/selinux_server.py
@@ -24,7 +24,7 @@ class selinux_server(slip.dbus.service.Object):
     @slip.dbus.polkit.require_auth("org.selinux.semanage")
     @dbus.service.method("org.selinux", in_signature='s')
     def semanage(self, buf):
-        p = Popen(["/usr/sbin/semanage", "import"], stdout=PIPE, stderr=PIPE, stdin=PIPE)
+        p = Popen(["/usr/sbin/semanage", "import"], stdout=PIPE, stderr=PIPE, stdin=PIPE, universal_newlines=True)
         p.stdin.write(buf)
         output = p.communicate()
         if p.returncode and p.returncode != 0:
@@ -38,7 +38,7 @@ class selinux_server(slip.dbus.service.Object):
     @slip.dbus.polkit.require_auth("org.selinux.customized")
     @dbus.service.method("org.selinux", in_signature='', out_signature='s')
     def customized(self):
-        p = Popen(["/usr/sbin/semanage", "export"], stdout=PIPE, stderr=PIPE)
+        p = Popen(["/usr/sbin/semanage", "export"], stdout=PIPE, stderr=PIPE, universal_newlines=True)
         buf = p.stdout.read()
         output = p.communicate()
         if p.returncode and p.returncode != 0:
@@ -52,7 +52,7 @@ class selinux_server(slip.dbus.service.Object):
     @slip.dbus.polkit.require_auth("org.selinux.semodule_list")
     @dbus.service.method("org.selinux", in_signature='', out_signature='s')
     def semodule_list(self):
-        p = Popen(["/usr/sbin/semodule", "--list=full"], stdout=PIPE, stderr=PIPE)
+        p = Popen(["/usr/sbin/semodule", "--list=full"], stdout=PIPE, stderr=PIPE, universal_newlines=True)
         buf = p.stdout.read()
         output = p.communicate()
         if p.returncode and p.returncode != 0:
-- 
2.12.2
