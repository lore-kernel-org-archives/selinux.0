Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBn1j0021566
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:49:05 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 1168F2621
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:49:04 +0000 (UTC)
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 03/11] sepolgen: Replace func_code calls with __code__.
Date: Thu, 16 Jul 2015 13:48:13 +0200
Message-Id: <1437047301-17672-4-git-send-email-rkuska@redhat.com>
In-Reply-To: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In Python 3, special function attributes have been
renamed for consistency with other attributes.
__code__ attribute is also present in py2.7 and py2.6

Signed-off-by: Robert Kuska <rkuska@redhat.com>
---
 sepolgen/src/sepolgen/lex.py  | 10 +++++-----
 sepolgen/src/sepolgen/yacc.py | 22 +++++++++++-----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sepolgen/src/sepolgen/lex.py b/sepolgen/src/sepolgen/lex.py
index c149366..7f12e26 100644
--- a/sepolgen/src/sepolgen/lex.py
+++ b/sepolgen/src/sepolgen/lex.py
@@ -301,7 +301,7 @@ class Lexer:
                 if not self.lexoptimize:
                     if not self.lextokens.has_key(newtok.type):
                         raise LexError, ("%s:%d: Rule '%s' returned an unknown token type '%s'" % (
-                            func.func_code.co_filename, func.func_code.co_firstlineno,
+                            func.__code__.co_filename, func.__code__.co_firstlineno,
                             func.__name__, newtok.type),lexdata[lexpos:])
 
                 return newtok
@@ -635,7 +635,7 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
 
     # Sort the functions by line number
     for f in funcsym.values():
-        f.sort(lambda x,y: cmp(x[1].func_code.co_firstlineno,y[1].func_code.co_firstlineno))
+        f.sort(lambda x,y: cmp(x[1].__code__.co_firstlineno,y[1].__code__.co_firstlineno))
 
     # Sort the strings by regular expression length
     for s in strsym.values():
@@ -649,15 +649,15 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
 
         # Add rules defined by functions first
         for fname, f in funcsym[state]:
-            line = f.func_code.co_firstlineno
-            file = f.func_code.co_filename
+            line = f.__code__.co_firstlineno
+            file = f.__code__.co_filename
             files[file] = None
             tokname = toknames[fname]
 
             ismethod = isinstance(f, types.MethodType)
 
             if not optimize:
-                nargs = f.func_code.co_argcount
+                nargs = f.__code__.co_argcount
                 if ismethod:
                     reqargs = 2
                 else:
diff --git a/sepolgen/src/sepolgen/yacc.py b/sepolgen/src/sepolgen/yacc.py
index ad96c56..d821940 100644
--- a/sepolgen/src/sepolgen/yacc.py
+++ b/sepolgen/src/sepolgen/yacc.py
@@ -457,11 +457,11 @@ def validate_dict(d):
 
         if n[0:2] == 'p_':
             sys.stderr.write("yacc: Warning. '%s' not defined as a function\n" % n)
-        if 1 and isinstance(v,types.FunctionType) and v.func_code.co_argcount == 1:
+        if 1 and isinstance(v,types.FunctionType) and v.__code__.co_argcount == 1:
             try:
                 doc = v.__doc__.split(" ")
                 if doc[1] == ':':
-                    sys.stderr.write("%s:%d: Warning. Possible grammar rule '%s' defined without p_ prefix.\n" % (v.func_code.co_filename, v.func_code.co_firstlineno,n))
+                    sys.stderr.write("%s:%d: Warning. Possible grammar rule '%s' defined without p_ prefix.\n" % (v.__code__.co_filename, v.__code__.co_firstlineno,n))
             except StandardError:
                 pass
 
@@ -722,8 +722,8 @@ def add_production(f,file,line,prodname,syms):
 # and adds rules to the grammar
 
 def add_function(f):
-    line = f.func_code.co_firstlineno
-    file = f.func_code.co_filename
+    line = f.__code__.co_firstlineno
+    file = f.__code__.co_filename
     error = 0
 
     if isinstance(f,types.MethodType):
@@ -731,11 +731,11 @@ def add_function(f):
     else:
         reqdargs = 1
         
-    if f.func_code.co_argcount > reqdargs:
+    if f.__code__.co_argcount > reqdargs:
         sys.stderr.write("%s:%d: Rule '%s' has too many arguments.\n" % (file,line,f.__name__))
         return -1
 
-    if f.func_code.co_argcount < reqdargs:
+    if f.__code__.co_argcount < reqdargs:
         sys.stderr.write("%s:%d: Rule '%s' requires an argument.\n" % (file,line,f.__name__))
         return -1
           
@@ -2079,11 +2079,11 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
                 ismethod = 1
             else:
                 raise YaccError,"'p_error' defined, but is not a function or method."                
-            eline = ef.func_code.co_firstlineno
-            efile = ef.func_code.co_filename
+            eline = ef.__code__.co_firstlineno
+            efile = ef.__code__.co_filename
             files[efile] = None
 
-            if (ef.func_code.co_argcount != 1+ismethod):
+            if (ef.__code__.co_argcount != 1+ismethod):
                 raise YaccError,"%s:%d: p_error() requires 1 argument." % (efile,eline)
             global Errorfunc
             Errorfunc = ef
@@ -2100,14 +2100,14 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
             raise YaccError,"no rules of the form p_rulename are defined."
     
         # Sort the symbols by line number
-        symbols.sort(lambda x,y: cmp(x.func_code.co_firstlineno,y.func_code.co_firstlineno))
+        symbols.sort(lambda x,y: cmp(x.__code__.co_firstlineno,y.__code__.co_firstlineno))
 
         # Add all of the symbols to the grammar
         for f in symbols:
             if (add_function(f)) < 0:
                 error += 1
             else:
-                files[f.func_code.co_filename] = None
+                files[f.__code__.co_filename] = None
 
         # Make a signature of the docstrings
         for f in symbols:
-- 
2.4.3
