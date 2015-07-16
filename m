Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBn1ix021566
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:49:04 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id C17342DC3C2
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:49:02 +0000 (UTC)
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 02/11] sepolgen: Use relative imports for modules within
 sepolgen.
Date: Thu, 16 Jul 2015 13:48:12 +0200
Message-Id: <1437047301-17672-3-git-send-email-rkuska@redhat.com>
In-Reply-To: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Python 3 changes the syntax for imports from within a package,
requiring you to use the relative import syntax,
saying from . import mymodule instead of the just import mymodule.

Signed-off-by: Robert Kuska <rkuska@redhat.com>
---
 sepolgen/src/sepolgen/access.py     |  3 ++-
 sepolgen/src/sepolgen/audit.py      |  4 ++--
 sepolgen/src/sepolgen/classperms.py |  4 ++--
 sepolgen/src/sepolgen/interfaces.py | 12 ++++++------
 sepolgen/src/sepolgen/matching.py   |  6 ++++--
 sepolgen/src/sepolgen/module.py     |  9 +++++----
 sepolgen/src/sepolgen/output.py     |  4 ++--
 sepolgen/src/sepolgen/policygen.py  | 10 +++++-----
 sepolgen/src/sepolgen/refparser.py  | 13 ++++++-------
 sepolgen/src/sepolgen/yacc.py       |  2 +-
 10 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/sepolgen/src/sepolgen/access.py b/sepolgen/src/sepolgen/access.py
index cf13210..46d4dba 100644
--- a/sepolgen/src/sepolgen/access.py
+++ b/sepolgen/src/sepolgen/access.py
@@ -31,7 +31,8 @@ and sets of that access (AccessVectorSet). These objects are used in Madison
 in a variety of ways, but they are the fundamental representation of access.
 """
 
-import refpolicy
+from . import refpolicy
+
 from selinux import audit2why
 
 def is_idparam(id):
diff --git a/sepolgen/src/sepolgen/audit.py b/sepolgen/src/sepolgen/audit.py
index 56919be..12596e1 100644
--- a/sepolgen/src/sepolgen/audit.py
+++ b/sepolgen/src/sepolgen/audit.py
@@ -17,11 +17,11 @@
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
 
-import refpolicy
-import access
 import re
 import sys
 
+from . import refpolicy
+from . import access
 # Convenience functions
 
 def get_audit_boot_msgs():
diff --git a/sepolgen/src/sepolgen/classperms.py b/sepolgen/src/sepolgen/classperms.py
index c925dee..40a7e8a 100644
--- a/sepolgen/src/sepolgen/classperms.py
+++ b/sepolgen/src/sepolgen/classperms.py
@@ -52,7 +52,7 @@ def t_error(t):
     print "Illegal character '%s'" % t.value[0]
     t.skip(1)
 
-import lex
+from . import lex
 lex.lex()
 
 def p_statements(p):
@@ -92,7 +92,7 @@ def p_names(p):
 def p_error(p):
     print "Syntax error on line %d %s [type=%s]" % (p.lineno, p.value, p.type)
     
-import yacc
+from . import yacc
 yacc.yacc()
 
 
diff --git a/sepolgen/src/sepolgen/interfaces.py b/sepolgen/src/sepolgen/interfaces.py
index 88a6dc3..8d2a5f9 100644
--- a/sepolgen/src/sepolgen/interfaces.py
+++ b/sepolgen/src/sepolgen/interfaces.py
@@ -21,15 +21,15 @@
 Classes for representing and manipulating interfaces.
 """
 
-import access
-import refpolicy
+import copy
 import itertools
-import objectmodel
-import matching
 
-from sepolgeni18n import _
+from . import access
+from . import refpolicy
+from . import objectmodel
+from . import matching
+from .sepolgeni18n import _
 
-import copy
 
 class Param:
     """
diff --git a/sepolgen/src/sepolgen/matching.py b/sepolgen/src/sepolgen/matching.py
index d56dd92..47531ff 100644
--- a/sepolgen/src/sepolgen/matching.py
+++ b/sepolgen/src/sepolgen/matching.py
@@ -21,10 +21,12 @@
 Classes and algorithms for matching requested access to access vectors.
 """
 
-import access
-import objectmodel
 import itertools
 
+from . import access
+from . import objectmodel
+
+
 class Match:
     def __init__(self, interface=None, dist=0):
         self.interface = interface
diff --git a/sepolgen/src/sepolgen/module.py b/sepolgen/src/sepolgen/module.py
index 7fc9443..86d637b 100644
--- a/sepolgen/src/sepolgen/module.py
+++ b/sepolgen/src/sepolgen/module.py
@@ -22,10 +22,6 @@ Utilities for dealing with the compilation of modules and creation
 of module tress.
 """
 
-import defaults
-
-import selinux
-
 import re
 import tempfile
 import commands
@@ -34,6 +30,11 @@ import os.path
 import subprocess
 import shutil
 
+import selinux
+
+from . import defaults
+
+
 def is_valid_name(modname):
     """Check that a module name is valid.
     """
diff --git a/sepolgen/src/sepolgen/output.py b/sepolgen/src/sepolgen/output.py
index 739452d..4244a74 100644
--- a/sepolgen/src/sepolgen/output.py
+++ b/sepolgen/src/sepolgen/output.py
@@ -27,8 +27,8 @@ generating policy. This keeps the semantic / syntactic issues
 cleanly separated from the formatting issues.
 """
 
-import refpolicy
-import util
+from . import refpolicy
+from . import util
 
 class ModuleWriter:
     def __init__(self):
diff --git a/sepolgen/src/sepolgen/policygen.py b/sepolgen/src/sepolgen/policygen.py
index 5f38577..221b78e 100644
--- a/sepolgen/src/sepolgen/policygen.py
+++ b/sepolgen/src/sepolgen/policygen.py
@@ -24,17 +24,17 @@ classes and algorithms for the generation of SELinux policy.
 import itertools
 import textwrap
 
-import refpolicy
-import objectmodel
-import access
-import interfaces
-import matching
 import selinux.audit2why as audit2why
 try:
     from setools import *
 except:
     pass
 
+from . import refpolicy
+from . import objectmodel
+from . import access
+from . import interfaces
+from . import matching
 # Constants for the level of explanation from the generation
 # routines
 NO_EXPLANATION    = 0
diff --git a/sepolgen/src/sepolgen/refparser.py b/sepolgen/src/sepolgen/refparser.py
index 83542d3..c2d60fa 100644
--- a/sepolgen/src/sepolgen/refparser.py
+++ b/sepolgen/src/sepolgen/refparser.py
@@ -34,12 +34,11 @@ import os
 import re
 import traceback
 
-import refpolicy
-import access
-import defaults
-
-import lex
-import yacc
+from . import access
+from . import defaults
+from . import lex
+from . import refpolicy
+from . import yacc
 
 # :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 #
@@ -1041,7 +1040,7 @@ def list_headers(root):
 
 
 def parse_headers(root, output=None, expand=True, debug=False):
-    import util
+    from . import util
 
     headers = refpolicy.Headers()
 
diff --git a/sepolgen/src/sepolgen/yacc.py b/sepolgen/src/sepolgen/yacc.py
index bc4536d..ad96c56 100644
--- a/sepolgen/src/sepolgen/yacc.py
+++ b/sepolgen/src/sepolgen/yacc.py
@@ -190,7 +190,7 @@ class Parser:
 
         # If no lexer was given, we will try to use the lex module
         if not lexer:
-            import lex
+            from . import lex
             lexer = lex.lexer
 
         pslice.lexer = lexer
-- 
2.4.3
