Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7EH1Yh2032110
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 13:01:34 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7EH13nC021043
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 17:01:03 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n7EGupmH007920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 11:56:52 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n7EGosiE004275
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 11:50:55 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: policycoreutils, sepolgen (sepolgen-ifgen) issues on Debian
References: <87d46y1lwd.fsf@anzu.internal.golden-gryphon.com>
Date: Fri, 14 Aug 2009 11:50:54 -0500
In-Reply-To: <87d46y1lwd.fsf@anzu.internal.golden-gryphon.com> (Manoj
	Srivastava's message of "Fri, 14 Aug 2009 09:59:46 -0500")
Message-ID: <878whm1gr5.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Fri, Aug 14 2009, Manoj Srivastava wrote:

>         I am running into an issue with sepolgen on Debian. Debian ships
>  more than one  version of the refpolicy, a default one, and a
>  MLS enabled one. So, the include files live in either
>  /usr/share/selinux/{default,mls}/include
>
>         sepolgen (in src/sepolgen/defaults.py) sets refpolicy_devel() to
>  a single location -- and thus, only one version of the security policy
>  may be supported. So, sepolgen-ifgen from policycoreutils can only work
>  with one policy, which may not be the one installed on the target
>  machine. Could this be made configurable, somehow? As far as I can
>  see, sepolgen's python library does not offer any way to set the value.
>
>         It would be nice if the location of the include directory could
>  be looked for from a PATH like variable setting, to make it easier for
>  distributions to ship more than one policy, or for end users to
>  experiment with other policies without have to overwrite the single
>  default. 

        Well, here is a kind of proof-of-concept patch (python is not my
 strong suit), and I have only tested in that it allows the package to
 compile, and the following code works:
--8<---------------cut here---------------start------------->8---
import defaults

# The following looks for /etc/selinux/sepolgen.conf that 
# does not exist
print defaults.refpolicy_makefile()
print defaults.headers()

# Create a configuration file
testfd = open("/tmp/pathchooser.conf", "w")
print >>testfd, "# This is a comment"
print >>testfd, "  # An empty line will follow"
print >>testfd, ""
print >>testfd, "SELINUX_DEVEL_PATH = /:/etc:/usr/share/selinux/default:/usr/share/selinux/mls:/usr/share/selinux/devel"
print >>testfd, "FOO= bar:baz"
testfd.close()

# Specify a non default config file, that has /etc in it
chooser = defaults.PathChoooser("/tmp/pathchooser.conf")
print chooser("passwd")
--8<---------------cut here---------------end--------------->8---

        manoj

Signed-off-by: Enrico Zini <enrico@debian.org>
Signed-off-by: Manoj Srivastava <srivasta@debian.org>
---
 src/sepolgen/defaults.py |   47 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/src/sepolgen/defaults.py b/src/sepolgen/defaults.py
index 45ce61a..906c058 100644
--- a/src/sepolgen/defaults.py
+++ b/src/sepolgen/defaults.py
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
@@ -30,12 +64,11 @@ def perm_map():
 def interface_info():
     return data_dir() + "/interface_info"
 
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
1.6.3.3


-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
