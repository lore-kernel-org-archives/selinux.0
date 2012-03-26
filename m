Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QDWUPv030039
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 09:32:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id B14A61A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 15:32:32 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y2N2hKpINvTr for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 15:32:30 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 992191A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 15:32:30 +0200 (CEST)
Date: Mon, 26 Mar 2012 15:32:28 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] sepolgen -- fix detection of policy loads
Message-ID: <20120326153228.6d91e5e9@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

There the only patch debian is applying to sepolgen:


Description: fix detection of policy loads
 I am running into an issue with sepolgen. Debian ships more
 than one version of the refpolicy, a default one, and a MLS enabled
 one. So, the include files live in either
 /usr/share/selinux/{default,mls}/include sepolgen (in
 src/sepolgen/defaults.py) sets refpolicy_devel() to a single
 location -- and thus, only one version of the security policy may be
 supported. So, sepolgen-ifgen from policycoreutils can only work
 with one policy, which may not be the one installed on the target
 machine. Could this be made configurable, somehow? As far as I can
 see, sepolgen's python library does not offer any way to set the
 value. This change fixes that. Now you may set the path to look for
 development headers in /etc/selinux/sepolgen.conf, in the variable
 SELINUX_DEVEL_PATH. The builtin default will have it work on Debian
 and fedora machines out of the box.
Author: Manoj Srivastava <srivasta@debian.org>
Bug-Debian: http://bugs.debian.org/534305
Origin: vendor
Forwarded: no

--- sepolgen-1.1.5.orig/src/sepolgen/defaults.py
+++ sepolgen-1.1.5/src/sepolgen/defaults.py
@@ -1,6 +1,6 @@
 # Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
 #
-# Copyright (C) 2006 Red Hat 
+# Copyright (C) 2006 Red Hat
 # see file 'COPYING' for use and warranty information
 #
 # This program is free software; you can redistribute it and/or
@@ -17,6 +17,40 @@
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
 
+import os
+import re
+
+# Select the correct location for the development files based on a
+# path variable (optionally read from a configuration file)
+class PathChoooser(object):
+    def __init__(self, pathname):
+        self.config = dict()
+        if not os.path.exists(pathname):
+            self.config_pathname = "(defaults)"
+            self.config["SELINUX_DEVEL_PATH"] = "/usr/share/selinux/default:/usr/share/selinux/mls:/usr/share/selinux/devel"
+            return
+        self.config_pathname = pathname
+        ignore = re.compile(r"^\s*(?:#.+)?$")
+        consider = re.compile(r"^\s*(\w+)\s*=\s*(.+?)\s*$")
+        for lineno, line in enumerate(open(pathname)):
+            if ignore.match(line): continue
+            mo = consider.match(line)
+            if not mo:
+                raise ValueError, "%s:%d: line is not in key = value format" % (pathname, lineno+1)
+            self.config[mo.group(1)] = mo.group(2)
+
+    # We're only exporting one useful function, so why not be a function
+    def __call__(self, testfilename, pathset="SELINUX_DEVEL_PATH"):
+        paths = self.config.get(pathset, None)
+        if paths is None:
+            raise ValueError, "%s was not in %s" % (pathset, self.config_pathname)
+        paths = paths.split(":")
+        for p in paths:
+            target = os.path.join(p, testfilename)
+            if os.path.exists(target): return target
+        return os.path.join(paths[0], testfilename)
+
+
 """
 Various default settings, including file and directory locations.
 """
@@ -33,12 +67,11 @@ def interface_info():
 def attribute_info():
     return data_dir() + "/attribute_info"
 
-def refpolicy_devel():
-    return "/usr/share/selinux/devel"
-
 def refpolicy_makefile():
-    return refpolicy_devel() + "/Makefile"
+    chooser = PathChoooser("/etc/selinux/sepolgen.conf")
+    return chooser("Makefile")
 
 def headers():
-    return refpolicy_devel() + "/include"
-    
+    chooser = PathChoooser("/etc/selinux/sepolgen.conf")
+    return chooser("include")
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
