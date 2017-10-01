Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v91GGIlw017904
 for <selinux@tycho.nsa.gov>; Sun, 1 Oct 2017 12:16:18 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id C4A93561238
 for <selinux@tycho.nsa.gov>; Sun,  1 Oct 2017 18:15:41 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  1 Oct 2017 18:15:17 +0200
Message-Id: <20171001161517.16407-4-nicolas.iooss@m4x.org>
In-Reply-To: <20171001161517.16407-1-nicolas.iooss@m4x.org>
References: <20171001161517.16407-1-nicolas.iooss@m4x.org>
Subject: [PATCH 4/4] gui: remove mappingsPage
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This page is not used anywhere and seems to be an incomplete version of
loginsPage.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 gui/Makefile        |  1 -
 gui/mappingsPage.py | 60 -----------------------------------------------------
 2 files changed, 61 deletions(-)
 delete mode 100644 gui/mappingsPage.py

diff --git a/gui/Makefile b/gui/Makefile
index ac844b6b9198..cfe47405e83f 100644
--- a/gui/Makefile
+++ b/gui/Makefile
@@ -11,7 +11,6 @@ domainsPage.py \
 fcontextPage.py \
 html_util.py \
 loginsPage.py \
-mappingsPage.py \
 modulesPage.py \
 polgen.glade \
 portsPage.py \
diff --git a/gui/mappingsPage.py b/gui/mappingsPage.py
deleted file mode 100644
index acf0bb5bfec7..000000000000
--- a/gui/mappingsPage.py
+++ /dev/null
@@ -1,60 +0,0 @@
-## mappingsPage.py - show selinux mappings
-## Copyright (C) 2006 Red Hat, Inc.
-
-## This program is free software; you can redistribute it and/or modify
-## it under the terms of the GNU General Public License as published by
-## the Free Software Foundation; either version 2 of the License, or
-## (at your option) any later version.
-
-## This program is distributed in the hope that it will be useful,
-## but WITHOUT ANY WARRANTY; without even the implied warranty of
-## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-## GNU General Public License for more details.
-
-## You should have received a copy of the GNU General Public License
-## along with this program; if not, write to the Free Software
-## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-## Author: Dan Walsh
-import string
-import gtk
-import gtk.glade
-import os
-import gobject
-import sys
-import seobject
-
-##
-## I18N
-##
-PROGNAME = "policycoreutils"
-try:
-    import gettext
-    kwargs = {}
-    if sys.version_info < (3,):
-        kwargs['unicode'] = True
-    gettext.install(PROGNAME,
-                    localedir="/usr/share/locale",
-                    codeset='utf-8',
-                    **kwargs)
-except:
-    try:
-        import builtins
-        builtins.__dict__['_'] = str
-    except ImportError:
-        import __builtin__
-        __builtin__.__dict__['_'] = unicode
-
-
-class loginsPage:
-
-    def __init__(self, xml):
-        self.xml = xml
-        self.view = xml.get_widget("mappingsView")
-        self.store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_STRING)
-        self.store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-        self.view.set_model(self.store)
-        self.login = loginRecords()
-        dict = self.login.get_all(0)
-        for k in sorted(dict.keys()):
-            print("%-25s %-25s %-25s" % (k, dict[k][0], translate(dict[k][1])))
-- 
2.14.2
