Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74IYmrk011375
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 14:34:48 -0400
Received: by mail-pf0-f193.google.com with SMTP id y134so18686607pfg.3
 for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2016 11:34:46 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 09/12] policycoreutils: gettext compat for py2 and 3
Date: Fri,  5 Aug 2016 02:34:02 +0800
Message-Id: <1470335645-24224-10-git-send-email-jason@perfinion.com>
In-Reply-To: <1470335645-24224-1-git-send-email-jason@perfinion.com>
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Install gettext the same way everywhere and have fallbacks to use
str/unicode depending on python version.
---
 policycoreutils/gui/booleansPage.py            | 22 +++++++++++++---------
 policycoreutils/gui/domainsPage.py             | 21 +++++++++++++--------
 policycoreutils/gui/fcontextPage.py            | 22 +++++++++++++---------
 policycoreutils/gui/loginsPage.py              | 21 +++++++++++++--------
 policycoreutils/gui/mappingsPage.py            | 21 +++++++++++++--------
 policycoreutils/gui/modulesPage.py             | 21 +++++++++++++--------
 policycoreutils/gui/polgengui.py               | 22 +++++++++++++---------
 policycoreutils/gui/portsPage.py               | 25 +++++++++++++------------
 policycoreutils/gui/semanagePage.py            | 21 +++++++++++++--------
 policycoreutils/gui/statusPage.py              | 24 ++++++++++++++++--------
 policycoreutils/gui/system-config-selinux.py   | 22 +++++++++++++---------
 policycoreutils/gui/usersPage.py               | 22 +++++++++++++++-------
 policycoreutils/sandbox/sandbox                | 15 ++++++++-------
 policycoreutils/scripts/chcat                  | 13 ++++++++++---
 policycoreutils/semanage/semanage              |  4 ++--
 policycoreutils/semanage/seobject.py           | 23 ++++++++++++++++-------
 policycoreutils/sepolicy/sepolicy.py           | 21 +++++++++++++--------
 policycoreutils/sepolicy/sepolicy/__init__.py  | 23 ++++++++++++++---------
 policycoreutils/sepolicy/sepolicy/generate.py  | 22 +++++++++++++---------
 policycoreutils/sepolicy/sepolicy/gui.py       | 21 +++++++++++++--------
 policycoreutils/sepolicy/sepolicy/interface.py | 22 +++++++++++++---------
 21 files changed, 263 insertions(+), 165 deletions(-)

diff --git a/policycoreutils/gui/booleansPage.py b/policycoreutils/gui/booleansPage.py
index 507a79d..7057ff4 100644
--- a/policycoreutils/gui/booleansPage.py
+++ b/policycoreutils/gui/booleansPage.py
@@ -40,18 +40,22 @@ DISABLED = 2
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 from glob import fnmatch
 
diff --git a/policycoreutils/gui/domainsPage.py b/policycoreutils/gui/domainsPage.py
index 9992d00..8f113ce 100644
--- a/policycoreutils/gui/domainsPage.py
+++ b/policycoreutils/gui/domainsPage.py
@@ -32,17 +32,22 @@ from semanagePage import *
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 
 class domainsPage(semanagePage):
diff --git a/policycoreutils/gui/fcontextPage.py b/policycoreutils/gui/fcontextPage.py
index c8d6ba8..2b95099 100644
--- a/policycoreutils/gui/fcontextPage.py
+++ b/policycoreutils/gui/fcontextPage.py
@@ -47,18 +47,22 @@ class context:
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 
 class fcontextPage(semanagePage):
diff --git a/policycoreutils/gui/loginsPage.py b/policycoreutils/gui/loginsPage.py
index 982e252..8e0b7a2 100644
--- a/policycoreutils/gui/loginsPage.py
+++ b/policycoreutils/gui/loginsPage.py
@@ -30,17 +30,22 @@ from semanagePage import *
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 
 class loginsPage(semanagePage):
diff --git a/policycoreutils/gui/mappingsPage.py b/policycoreutils/gui/mappingsPage.py
index 1429bf7..3b4ceb6 100644
--- a/policycoreutils/gui/mappingsPage.py
+++ b/policycoreutils/gui/mappingsPage.py
@@ -28,17 +28,22 @@ import seobject
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 
 class loginsPage:
diff --git a/policycoreutils/gui/modulesPage.py b/policycoreutils/gui/modulesPage.py
index 3b83e45..c7c7848 100644
--- a/policycoreutils/gui/modulesPage.py
+++ b/policycoreutils/gui/modulesPage.py
@@ -32,17 +32,22 @@ from subprocess import Popen, PIPE
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 
 class modulesPage(semanagePage):
diff --git a/policycoreutils/gui/polgengui.py b/policycoreutils/gui/polgengui.py
index 1c349a7..1f97ada 100644
--- a/policycoreutils/gui/polgengui.py
+++ b/policycoreutils/gui/polgengui.py
@@ -58,18 +58,22 @@ def get_all_modules():
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 gnome.program_init("SELinux Policy Generation Tool", "5")
 
diff --git a/policycoreutils/gui/portsPage.py b/policycoreutils/gui/portsPage.py
index 8e74ac0..7e7a653 100644
--- a/policycoreutils/gui/portsPage.py
+++ b/policycoreutils/gui/portsPage.py
@@ -30,21 +30,22 @@ from semanagePage import *
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
-TYPE_COL = 0
-PROTOCOL_COL = 1
-MLS_COL = 2
-PORT_COL = 3
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 
 class portsPage(semanagePage):
diff --git a/policycoreutils/gui/semanagePage.py b/policycoreutils/gui/semanagePage.py
index 5d7f2cf..d07ce27 100644
--- a/policycoreutils/gui/semanagePage.py
+++ b/policycoreutils/gui/semanagePage.py
@@ -28,17 +28,22 @@ import seobject
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 
 def idle_func():
diff --git a/policycoreutils/gui/statusPage.py b/policycoreutils/gui/statusPage.py
index 991d8f3..de27752 100644
--- a/policycoreutils/gui/statusPage.py
+++ b/policycoreutils/gui/statusPage.py
@@ -23,6 +23,7 @@ import os
 import gobject
 import sys
 import tempfile
+import selinux
 
 INSTALLPATH = '/usr/share/system-config-selinux'
 sys.path.append(INSTALLPATH)
@@ -40,15 +41,22 @@ RELABELFILE = "/.autorelabel"
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
-import selinux
 try:
-    gettext.install(PROGNAME, localedir="/usr/share/locale", unicode=1)
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
+    gettext.install(PROGNAME,
+                    localedir="/usr/share/locale",
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 
 class statusPage:
diff --git a/policycoreutils/gui/system-config-selinux.py b/policycoreutils/gui/system-config-selinux.py
index 7d342d0..8d2be13 100644
--- a/policycoreutils/gui/system-config-selinux.py
+++ b/policycoreutils/gui/system-config-selinux.py
@@ -47,18 +47,22 @@ import selinux
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 gnome.program_init("SELinux Management Tool", "5")
 
diff --git a/policycoreutils/gui/usersPage.py b/policycoreutils/gui/usersPage.py
index abf8d3b..eb978ea 100644
--- a/policycoreutils/gui/usersPage.py
+++ b/policycoreutils/gui/usersPage.py
@@ -30,14 +30,22 @@ from semanagePage import *
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
-    gettext.install(PROGNAME, localedir="/usr/share/locale", unicode=1)
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
+    gettext.install(PROGNAME,
+                    localedir="/usr/share/locale",
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 
 class usersPage(semanagePage):
diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index 9e0024f..4f5128a 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -35,18 +35,19 @@ from tempfile import mkdtemp
 import pwd
 import sepolicy
 
-PROGNAME = "policycoreutils"
 SEUNSHARE = "/usr/sbin/seunshare"
 SANDBOXSH = "/usr/share/sandbox/sandboxX.sh"
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
-
+PROGNAME = "policycoreutils"
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8')
-except IOError:
+                    codeset='utf-8',
+                    **kwargs)
+except:
     try:
         import builtins
         builtins.__dict__['_'] = str
diff --git a/policycoreutils/scripts/chcat b/policycoreutils/scripts/chcat
index 267390e..2269ee0 100755
--- a/policycoreutils/scripts/chcat
+++ b/policycoreutils/scripts/chcat
@@ -30,11 +30,18 @@ import string
 import getopt
 import selinux
 import seobject
-import gettext
 
+PROGNAME = "policycoreutils"
 try:
-    gettext.install('policycoreutils')
-except IOError:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
+    gettext.install(PROGNAME,
+                    localedir="/usr/share/locale",
+                    codeset='utf-8',
+                    **kwargs)
+except:
     try:
         import builtins
         builtins.__dict__['_'] = str
diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index e6e3a49..d945243 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -27,9 +27,9 @@ import traceback
 import argparse
 import seobject
 import sys
-import gettext
 PROGNAME = "policycoreutils"
 try:
+    import gettext
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
@@ -37,7 +37,7 @@ try:
                     localedir="/usr/share/locale",
                     codeset='utf-8',
                     **kwargs)
-except IOError:
+except:
     try:
         import builtins
         builtins.__dict__['_'] = str
diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 2cc56d9..bd261df 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -34,13 +34,22 @@ import sepolicy
 sepolicy.gen_bool_dict()
 from IPy import IP
 
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
-
-import gettext
-translation = gettext.translation(PROGNAME, localedir="/usr/share/locale", fallback=True)
-_ = translation.ugettext
+try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
+    gettext.install(PROGNAME,
+                    localedir="/usr/share/locale",
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 import syslog
 
diff --git a/policycoreutils/sepolicy/sepolicy.py b/policycoreutils/sepolicy/sepolicy.py
index 7d57f6e..3e502a7 100755
--- a/policycoreutils/sepolicy/sepolicy.py
+++ b/policycoreutils/sepolicy/sepolicy.py
@@ -27,18 +27,23 @@ import selinux
 import sepolicy
 from sepolicy import get_os_version, get_conditionals, get_conditionals_format_text
 import argparse
-import gettext
 PROGNAME = "policycoreutils"
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 usage = "sepolicy generate [-h] [-n NAME] [-p PATH] ["
 usage_dict = {' --newtype': ('-t [TYPES [TYPES ...]]',), ' --customize': ('-d DOMAIN', '-a  ADMIN_DOMAIN', "[ -w WRITEPATHS ]",), ' --admin_user': ('[-r TRANSITION_ROLE ]', "[ -w WRITEPATHS ]",), ' --application': ('COMMAND', "[ -w WRITEPATHS ]",), ' --cgi': ('COMMAND', "[ -w WRITEPATHS ]",), ' --confined_admin': ('-a  ADMIN_DOMAIN', "[ -w WRITEPATHS ]",), ' --dbus': ('COMMAND', "[ -w WRITEPATHS ]",), ' --desktop_user': ('', "[ -w WRITEPATHS ]",), ' --inetd': ('COMMAND', "[ -w WRITEPATHS ]",), ' --init': ('COMMAND', "[ -w WRITEPATHS ]",), ' --sandbox': ("[ -w WRITEPATHS ]",), ' --term_user': ("[ -w WRITEPATHS ]",), ' --x_user': ("[ -w WRITEPATHS ]",)}
diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycoreutils/sepolicy/sepolicy/__init__.py
index 6aec4c0..c8d3b90 100644
--- a/policycoreutils/sepolicy/sepolicy/__init__.py
+++ b/policycoreutils/sepolicy/sepolicy/__init__.py
@@ -6,8 +6,6 @@
 from . import _policy
 import selinux
 import glob
-PROGNAME = "policycoreutils"
-import gettext
 import sepolgen.defaults as defaults
 import sepolgen.interfaces as interfaces
 import sys
@@ -15,16 +13,23 @@ import os
 import re
 import gzip
 
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
+PROGNAME = "policycoreutils"
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 TYPE = _policy.TYPE
 ROLE = _policy.ROLE
diff --git a/policycoreutils/sepolicy/sepolicy/generate.py b/policycoreutils/sepolicy/sepolicy/generate.py
index 2d83702..00361c6 100644
--- a/policycoreutils/sepolicy/sepolicy/generate.py
+++ b/policycoreutils/sepolicy/sepolicy/generate.py
@@ -53,18 +53,22 @@ import sepolgen.defaults as defaults
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 
 def get_rpm_nvr_from_header(hdr):
diff --git a/policycoreutils/sepolicy/sepolicy/gui.py b/policycoreutils/sepolicy/sepolicy/gui.py
index 0ffe9ee..7f1888c 100644
--- a/policycoreutils/sepolicy/sepolicy/gui.py
+++ b/policycoreutils/sepolicy/sepolicy/gui.py
@@ -39,20 +39,25 @@ import sepolicy.manpage
 import dbus
 import os
 import re
-import gettext
 import unicodedata
 
 PROGNAME = "policycoreutils"
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 reverse_file_type_str = {}
 for f in sepolicy.file_type_str:
diff --git a/policycoreutils/sepolicy/sepolicy/interface.py b/policycoreutils/sepolicy/sepolicy/interface.py
index 85f7351..c2cb971 100644
--- a/policycoreutils/sepolicy/sepolicy/interface.py
+++ b/policycoreutils/sepolicy/sepolicy/interface.py
@@ -33,18 +33,22 @@ __all__ = ['get_all_interfaces', 'get_interfaces_from_xml', 'get_admin', 'get_us
 ## I18N
 ##
 PROGNAME = "policycoreutils"
-
-import gettext
-gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
-gettext.textdomain(PROGNAME)
 try:
+    import gettext
+    kwargs = {}
+    if sys.version_info < (3,):
+        kwargs['unicode'] = True
     gettext.install(PROGNAME,
                     localedir="/usr/share/locale",
-                    unicode=False,
-                    codeset='utf-8')
-except IOError:
-    import __builtin__
-    __builtin__.__dict__['_'] = unicode
+                    codeset='utf-8',
+                    **kwargs)
+except:
+    try:
+        import builtins
+        builtins.__dict__['_'] = str
+    except ImportError:
+        import __builtin__
+        __builtin__.__dict__['_'] = unicode
 
 
 def get_interfaces_from_xml(path):
-- 
2.7.3
