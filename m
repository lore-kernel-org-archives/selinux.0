Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBn1j4021566
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:49:09 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 3A8EB38886F
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:49:08 +0000 (UTC)
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 07/11] sepolgen: Replace usage of attributes of types module
Date: Thu, 16 Jul 2015 13:48:17 +0200
Message-Id: <1437047301-17672-8-git-send-email-rkuska@redhat.com>
In-Reply-To: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In Python3 all strings are by default Unicode and both Unicode and String
types are removed from types module. We introduce separate
variables `bytes_type` and `string_type` to reflect Python3 understanding
of strings, on Python2 `bytes_type` refers to <str> and `string_type` to
<unicode>, on Python3 `bytes_type` are <bytes> and `string_type` <str>.
As all strings are Unicodes by default on Python3 we encode them to
bytes when needed as late as possible.

Also other attributes were replaced with their equivalents from
builtins which are available for both Python3 and Python2.

Signed-off-by: Robert Kuska <rkuska@redhat.com>
---
 sepolgen/src/sepolgen/lex.py  | 31 ++++++++++++++++++-------------
 sepolgen/src/sepolgen/util.py |  9 +++++++++
 sepolgen/src/sepolgen/yacc.py | 16 ++++++++--------
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/sepolgen/src/sepolgen/lex.py b/sepolgen/src/sepolgen/lex.py
index 3f5904b..b9f3d9e 100644
--- a/sepolgen/src/sepolgen/lex.py
+++ b/sepolgen/src/sepolgen/lex.py
@@ -26,18 +26,20 @@ __version__ = "2.2"
 
 import re, sys, types
 
+from . import util
+
+
 # Regular expression used to match valid token names
 _is_identifier = re.compile(r'^[a-zA-Z0-9_]+$')
 
-# Available instance types.  This is used when lexers are defined by a class.
-# It's a little funky because I want to preserve backwards compatibility
-# with Python 2.0 where types.ObjectType is undefined.
+# Available instance types.  This is used when parsers are defined by a class.
+# In Python3 the InstanceType and ObjectType are no more, they've passed, ceased
+# to be, they are ex-classes along with old-style classes
 
 try:
    _INSTANCETYPE = (types.InstanceType, types.ObjectType)
 except AttributeError:
-   _INSTANCETYPE = types.InstanceType
-   class object: pass       # Note: needed if no new-style classes present
+   _INSTANCETYPE = object
 
 # Exception thrown when invalid token encountered and no default error
 # handler is defined.
@@ -197,7 +199,7 @@ class Lexer:
     # input() - Push a new string into the lexer
     # ------------------------------------------------------------
     def input(self,s):
-        if not (isinstance(s,types.StringType) or isinstance(s,types.UnicodeType)):
+        if not (isinstance(s,util.bytes_type) or isinstance(s, util.string_type)):
             raise ValueError, "Expected a string"
         self.lexdata = s
         self.lexpos = 0
@@ -543,7 +545,7 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
         
     if not tokens:
         raise SyntaxError,"lex: module does not define 'tokens'"
-    if not (isinstance(tokens,types.ListType) or isinstance(tokens,types.TupleType)):
+    if not (isinstance(tokens,list) or isinstance(tokens,tuple)):
         raise SyntaxError,"lex: tokens must be a list or tuple."
 
     # Build a dictionary of valid token names
@@ -564,7 +566,7 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
 
     try:
          for c in literals:
-               if not (isinstance(c,types.StringType) or isinstance(c,types.UnicodeType)) or len(c) > 1:
+               if not (isinstance(c,util.bytes_type) or isinstance(c, util.string_type)) or len(c) > 1:
                     print "lex: Invalid literal %s. Must be a single character" % repr(c)
                     error = 1
                     continue
@@ -577,18 +579,21 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
 
     # Build statemap
     if states:
-         if not (isinstance(states,types.TupleType) or isinstance(states,types.ListType)):
+         if not (isinstance(states,tuple) or isinstance(states,list)):
               print "lex: states must be defined as a tuple or list."
               error = 1
          else:
               for s in states:
-                    if not isinstance(s,types.TupleType) or len(s) != 2:
+                    if not isinstance(s,tuple) or len(s) != 2:
                            print "lex: invalid state specifier %s. Must be a tuple (statename,'exclusive|inclusive')" % repr(s)
                            error = 1
                            continue
                     name, statetype = s
-                    if not isinstance(name,types.StringType):
-                           print "lex: state name %s must be a string" % repr(name)
+                    if isinstance(name, util.string_type):
+                           original_name = name
+                           name = util.encode_input(name)
+                    if not isinstance(name,util.bytes_type) or len(original_name) != len(name):
+                           print "lex: state name %s must be a byte string" % repr(original_name)
                            error = 1
                            continue
                     if not (statetype == 'inclusive' or statetype == 'exclusive'):
@@ -627,7 +632,7 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
 
         if callable(t):
             for s in states: funcsym[s].append((f,t))
-        elif (isinstance(t, types.StringType) or isinstance(t,types.UnicodeType)):
+        elif (isinstance(t, util.bytes_type) or isinstance(t,util.string_type)):
             for s in states: strsym[s].append((f,t))
         else:
             print "lex: %s not defined as a function or string" % f
diff --git a/sepolgen/src/sepolgen/util.py b/sepolgen/src/sepolgen/util.py
index ec628e9..875357f 100644
--- a/sepolgen/src/sepolgen/util.py
+++ b/sepolgen/src/sepolgen/util.py
@@ -16,11 +16,20 @@
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
+import locale
 import sys
 
 
 PY3 = sys.version_info[0] == 3
 
+if PY3:
+    bytes_type=bytes
+    string_type=str
+else:
+    bytes_type=str
+    string_type=unicode
+
+
 class ConsoleProgressBar:
     def __init__(self, out, steps=100, indicator='#'):
         self.blocks = 0
diff --git a/sepolgen/src/sepolgen/yacc.py b/sepolgen/src/sepolgen/yacc.py
index b681785..8b9b3e2 100644
--- a/sepolgen/src/sepolgen/yacc.py
+++ b/sepolgen/src/sepolgen/yacc.py
@@ -111,7 +111,7 @@ class YaccProduction:
         self.stack = stack
 
     def __getitem__(self,n):
-        if type(n) == types.IntType:
+        if type(n) == int:
              if n >= 0: return self.slice[n].value
              else: return self.stack[n].value
         else:
@@ -1940,13 +1940,13 @@ def lr_read_tables(module=tab_module,optimize=0):
 
 
 # Available instance types.  This is used when parsers are defined by a class.
-# it's a little funky because I want to preserve backwards compatibility
-# with Python 2.0 where types.ObjectType is undefined.
+# In Python3 the InstanceType and ObjectType are no more, they've passed, ceased
+# to be, they are ex-classes along with old-style classes
 
 try:
    _INSTANCETYPE = (types.InstanceType, types.ObjectType)
 except AttributeError:
-   _INSTANCETYPE = types.InstanceType
+   _INSTANCETYPE = object
 
 # -----------------------------------------------------------------------------
 # yacc(module)
@@ -2026,18 +2026,18 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
     
         if not tokens:
             raise YaccError,"module does not define a list 'tokens'"
-        if not (isinstance(tokens,types.ListType) or isinstance(tokens,types.TupleType)):
+        if not (isinstance(tokens,list) or isinstance(tokens,tuple)):
             raise YaccError,"tokens must be a list or tuple."
 
         # Check to see if a requires dictionary is defined.
         requires = ldict.get("require",None)
         if requires:
-            if not (isinstance(requires,types.DictType)):
+            if not (isinstance(requires,dict)):
                 raise YaccError,"require must be a dictionary."
 
             for r,v in requires.items():
                 try:
-                    if not (isinstance(v,types.ListType)):
+                    if not (isinstance(v,list)):
                         raise TypeError
                     v1 = [x.split(".") for x in v]
                     Requires[r] = v1
@@ -2063,7 +2063,7 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
         # Get the precedence map (if any)
         prec = ldict.get("precedence",None)
         if prec:
-            if not (isinstance(prec,types.ListType) or isinstance(prec,types.TupleType)):
+            if not (isinstance(prec,list) or isinstance(prec,tuple)):
                 raise YaccError,"precedence must be a list or tuple."
             add_precedence(prec)
             Signature.update(util.encode_input(repr(prec)))
-- 
2.4.3
