Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uACKKwxv027367
 for <selinux@tycho.nsa.gov>; Sat, 12 Nov 2016 15:21:02 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 8EF671A1A8
 for <selinux@tycho.nsa.gov>; Sat, 12 Nov 2016 21:20:56 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id onEu8gVfUCaI for <selinux@tycho.nsa.gov>;
 Sat, 12 Nov 2016 21:20:22 +0100 (CET)
Received: from fornost.bigon.be (unknown
 [IPv6:2a02:a03f:6c:e500:edf:2fd8:fc0a:f176])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 562FD1A1AE
 for <selinux@tycho.nsa.gov>; Sat, 12 Nov 2016 21:20:22 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] policycoreutils: Force GTK3.0 for sepolicy gui
Date: Sat, 12 Nov 2016 21:20:20 +0100
Message-Id: <20161112202021.4469-1-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

This removes the following warning when running sepolicy gui command:

/usr/lib/python3/dist-packages/sepolicy/gui.py:29: PyGIWarning: Gtk was imported without specifying a version first. Use gi.require_version('Gtk', '3.0') before import to ensure that the right version gets loaded.

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 policycoreutils/sepolicy/sepolicy/gui.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policycoreutils/sepolicy/sepolicy/gui.py b/policycoreutils/sepolicy/sepolicy/gui.py
index 7f1888c..ee78e0c 100644
--- a/policycoreutils/sepolicy/sepolicy/gui.py
+++ b/policycoreutils/sepolicy/sepolicy/gui.py
@@ -26,6 +26,8 @@
 #
 #
 
+import gi
+gi.require_version('Gtk', '3.0')
 from gi.repository import Gtk
 from gi.repository import Gdk
 from gi.repository import GLib
-- 
2.10.2
