Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uACKKwxu027367
 for <selinux@tycho.nsa.gov>; Sat, 12 Nov 2016 15:20:58 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 320D71A1AF
 for <selinux@tycho.nsa.gov>; Sat, 12 Nov 2016 21:20:55 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id PmqjrpWFtwxS for <selinux@tycho.nsa.gov>;
 Sat, 12 Nov 2016 21:20:22 +0100 (CET)
Received: from fornost.bigon.be (unknown
 [IPv6:2a02:a03f:6c:e500:edf:2fd8:fc0a:f176])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 527561A1A8
 for <selinux@tycho.nsa.gov>; Sat, 12 Nov 2016 21:20:22 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] policycoreutils: Use GObject introspection binding
 instead of python-gobject in selinux_server.py
Date: Sat, 12 Nov 2016 21:20:21 +0100
Message-Id: <20161112202021.4469-2-bigon@debian.org>
In-Reply-To: <20161112202021.4469-1-bigon@debian.org>
References: <20161112202021.4469-1-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 policycoreutils/sepolicy/selinux_server.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sepolicy/selinux_server.py b/policycoreutils/sepolicy/selinux_server.py
index cdf4d16..8bd1fe5 100644
--- a/policycoreutils/sepolicy/selinux_server.py
+++ b/policycoreutils/sepolicy/selinux_server.py
@@ -3,7 +3,7 @@
 import dbus
 import dbus.service
 import dbus.mainloop.glib
-import gobject
+from gi.repository import GObject
 import slip.dbus.service
 from slip.dbus import polkit
 import os
@@ -128,7 +128,7 @@ class selinux_server(slip.dbus.service.Object):
         raise ValueError("%s does not exist" % path)
 
 if __name__ == "__main__":
-    mainloop = gobject.MainLoop()
+    mainloop = GObject.MainLoop()
     dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
     system_bus = dbus.SystemBus()
     name = dbus.service.BusName("org.selinux", system_bus)
-- 
2.10.2
