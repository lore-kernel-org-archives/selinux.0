Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBn1j6021566
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:49:13 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id E1C082E6DC0
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:49:10 +0000 (UTC)
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 09/11] sepolgen: Apply fixes discovered by 2to3 where needed.
Date: Thu, 16 Jul 2015 13:48:19 +0200
Message-Id: <1437047301-17672-10-git-send-email-rkuska@redhat.com>
In-Reply-To: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Replace usage of print statement with print function.
Use `in` instead of `has_key` when checking for key in dict.
When using `raise` add text (if any) as parameter of exception function.
Add Python3 imports of moved modules.
Replace `map` with list comprehension.
Use reserved word `as` in try-except when catching exception.
Replace `ifilter` function with `filter`.

Signed-off-by: Robert Kuska <rkuska@redhat.com>
---
 sepolgen/src/sepolgen/access.py      |   6 +-
 sepolgen/src/sepolgen/audit.py       |   2 +-
 sepolgen/src/sepolgen/classperms.py  |   6 +-
 sepolgen/src/sepolgen/defaults.py    |   4 +-
 sepolgen/src/sepolgen/interfaces.py  |   2 +-
 sepolgen/src/sepolgen/lex.py         | 123 +++++++++++++++--------------
 sepolgen/src/sepolgen/module.py      |   8 +-
 sepolgen/src/sepolgen/objectmodel.py |   2 +-
 sepolgen/src/sepolgen/policygen.py   |   6 +-
 sepolgen/src/sepolgen/refparser.py   |  12 +--
 sepolgen/src/sepolgen/refpolicy.py   |  39 +++++----
 sepolgen/src/sepolgen/yacc.py        | 149 ++++++++++++++++++-----------------
 12 files changed, 182 insertions(+), 177 deletions(-)

diff --git a/sepolgen/src/sepolgen/access.py b/sepolgen/src/sepolgen/access.py
index 98bee98..1f89ecd 100644
--- a/sepolgen/src/sepolgen/access.py
+++ b/sepolgen/src/sepolgen/access.py
@@ -263,7 +263,7 @@ class AccessVectorSet:
         tgt = self.src.setdefault(src_type, { })
         cls = tgt.setdefault(tgt_type, { })
         
-        if cls.has_key((obj_class, avc_type)):
+        if (obj_class, avc_type) in cls:
             access = cls[obj_class, avc_type]
         else:
             access = AccessVector()
@@ -294,7 +294,7 @@ def avs_extract_types(avs):
 def avs_extract_obj_perms(avs):
     perms = { }
     for av in avs:
-        if perms.has_key(av.obj_class):
+        if av.obj_class in perms:
             s = perms[av.obj_class]
         else:
             s = refpolicy.IdSet()
@@ -322,7 +322,7 @@ class RoleTypeSet:
         return len(self.role_types.keys())
 
     def add(self, role, type):
-        if self.role_types.has_key(role):
+        if role in self.role_types:
             role_type = self.role_types[role]
         else:
             role_type = refpolicy.RoleType()
diff --git a/sepolgen/src/sepolgen/audit.py b/sepolgen/src/sepolgen/audit.py
index 12596e1..83efac3 100644
--- a/sepolgen/src/sepolgen/audit.py
+++ b/sepolgen/src/sepolgen/audit.py
@@ -430,7 +430,7 @@ class AuditParser:
 
         # Group by audit header
         if msg.header != "":
-            if self.by_header.has_key(msg.header):
+            if msg.header in self.by_header:
                 self.by_header[msg.header].append(msg)
             else:
                 self.by_header[msg.header] = [msg]
diff --git a/sepolgen/src/sepolgen/classperms.py b/sepolgen/src/sepolgen/classperms.py
index 40a7e8a..f4fd899 100644
--- a/sepolgen/src/sepolgen/classperms.py
+++ b/sepolgen/src/sepolgen/classperms.py
@@ -49,7 +49,7 @@ def t_NAME(t):
     return t
 
 def t_error(t):
-    print "Illegal character '%s'" % t.value[0]
+    print("Illegal character '%s'" % t.value[0])
     t.skip(1)
 
 from . import lex
@@ -90,7 +90,7 @@ def p_names(p):
         p[0] = [p[1]] + p[2]
 
 def p_error(p):
-    print "Syntax error on line %d %s [type=%s]" % (p.lineno, p.value, p.type)
+    print("Syntax error on line %d %s [type=%s]" % (p.lineno, p.value, p.type))
     
 from . import yacc
 yacc.yacc()
@@ -112,5 +112,5 @@ test2 = """define(`all_filesystem_perms',`{ mount remount unmount getattr relabe
 define(`all_security_perms',`{ compute_av compute_create compute_member check_context load_policy compute_relabel compute_user setenforce setbool setsecparam setcheckreqprot }')
 """
 result = yacc.parse(txt)
-print result
+print(result)
     
diff --git a/sepolgen/src/sepolgen/defaults.py b/sepolgen/src/sepolgen/defaults.py
index 218bc7c..9591063 100644
--- a/sepolgen/src/sepolgen/defaults.py
+++ b/sepolgen/src/sepolgen/defaults.py
@@ -36,14 +36,14 @@ class PathChoooser(object):
             if ignore.match(line): continue
             mo = consider.match(line)
             if not mo:
-                raise ValueError, "%s:%d: line is not in key = value format" % (pathname, lineno+1)
+                raise ValueError("%s:%d: line is not in key = value format" % (pathname, lineno+1))
             self.config[mo.group(1)] = mo.group(2)
 
     # We're only exporting one useful function, so why not be a function
     def __call__(self, testfilename, pathset="SELINUX_DEVEL_PATH"):
         paths = self.config.get(pathset, None)
         if paths is None:
-            raise ValueError, "%s was not in %s" % (pathset, self.config_pathname)
+            raise ValueError("%s was not in %s" % (pathset, self.config_pathname))
         paths = paths.split(":")
         for p in paths:
             target = os.path.join(p, testfilename)
diff --git a/sepolgen/src/sepolgen/interfaces.py b/sepolgen/src/sepolgen/interfaces.py
index 8d2a5f9..0b688bf 100644
--- a/sepolgen/src/sepolgen/interfaces.py
+++ b/sepolgen/src/sepolgen/interfaces.py
@@ -276,7 +276,7 @@ class InterfaceVector:
         if attributes:
             for typeattribute in interface.typeattributes():
                 for attr in typeattribute.attributes:
-                    if not attributes.attributes.has_key(attr):
+                    if attr not in attributes.attributes:
                         # print "missing attribute " + attr
                         continue
                     attr_vec = attributes.attributes[attr]
diff --git a/sepolgen/src/sepolgen/lex.py b/sepolgen/src/sepolgen/lex.py
index b9f3d9e..99560bc 100644
--- a/sepolgen/src/sepolgen/lex.py
+++ b/sepolgen/src/sepolgen/lex.py
@@ -27,6 +27,7 @@ __version__ = "2.2"
 import re, sys, types
 
 from . import util
+import collections
 
 
 # Regular expression used to match valid token names
@@ -174,7 +175,7 @@ class Lexer:
     # readtab() - Read lexer information from a tab file
     # ------------------------------------------------------------
     def readtab(self,tabfile,fdict):
-        exec "import %s as lextab" % tabfile
+        exec("import %s as lextab" % tabfile)
         self.lextokens      = lextab._lextokens
         self.lexreflags     = lextab._lexreflags
         self.lexliterals    = lextab._lexliterals
@@ -200,7 +201,7 @@ class Lexer:
     # ------------------------------------------------------------
     def input(self,s):
         if not (isinstance(s,util.bytes_type) or isinstance(s, util.string_type)):
-            raise ValueError, "Expected a string"
+            raise ValueError("Expected a string")
         self.lexdata = s
         self.lexpos = 0
         self.lexlen = len(s)
@@ -209,8 +210,8 @@ class Lexer:
     # begin() - Changes the lexing state
     # ------------------------------------------------------------
     def begin(self,state):
-        if not self.lexstatere.has_key(state):
-            raise ValueError, "Undefined state"
+        if state not in self.lexstatere:
+            raise ValueError("Undefined state")
         self.lexre = self.lexstatere[state]
         self.lexretext = self.lexstateretext[state]
         self.lexignore = self.lexstateignore.get(state,"")
@@ -288,7 +289,7 @@ class Lexer:
                    break
 
                 # if func not callable, it means it's an ignored token                
-                if not callable(func):
+                if not isinstance(func, collections.Callable):
                    break 
 
                 # If token is processed by a function, call it
@@ -301,8 +302,8 @@ class Lexer:
                 
                 # Verify type of the token.  If not in the token map, raise an error
                 if not self.lexoptimize:
-                    if not self.lextokens.has_key(newtok.type):
-                        raise LexError, ("%s:%d: Rule '%s' returned an unknown token type '%s'" % (
+                    if newtok.type not in self.lextokens:
+                        raise LexError("%s:%d: Rule '%s' returned an unknown token type '%s'" % (
                             func.__code__.co_filename, func.__code__.co_firstlineno,
                             func.__name__, newtok.type),lexdata[lexpos:])
 
@@ -331,17 +332,17 @@ class Lexer:
                     newtok = self.lexerrorf(tok)
                     if lexpos == self.lexpos:
                         # Error method didn't change text position at all. This is an error.
-                        raise LexError, ("Scanning error. Illegal character '%s'" % (lexdata[lexpos]), lexdata[lexpos:])
+                        raise LexError("Scanning error. Illegal character '%s'" % (lexdata[lexpos]), lexdata[lexpos:])
                     lexpos = self.lexpos
                     if not newtok: continue
                     return newtok
 
                 self.lexpos = lexpos
-                raise LexError, ("Illegal character '%s' at index %d" % (lexdata[lexpos],lexpos), lexdata[lexpos:])
+                raise LexError("Illegal character '%s' at index %d" % (lexdata[lexpos],lexpos), lexdata[lexpos:])
 
         self.lexpos = lexpos + 1
         if self.lexdata is None:
-             raise RuntimeError, "No input string given with input()"
+             raise RuntimeError("No input string given with input()")
         return None
         
 # -----------------------------------------------------------------------------
@@ -379,7 +380,7 @@ def _validate_file(filename):
             if not prev:
                 counthash[name] = linen
             else:
-                print "%s:%d: Rule %s redefined. Previously defined on line %d" % (filename,linen,name,prev)
+                print("%s:%d: Rule %s redefined. Previously defined on line %d" % (filename,linen,name,prev))
                 noerror = 0
         linen += 1
     return noerror
@@ -441,12 +442,12 @@ def _form_master_re(relist,reflags,ldict):
                 # callback function to carry out the action
                 if f.find("ignore_") > 0:
                     lexindexfunc[i] = (None,None)
-                    print "IGNORE", f
+                    print("IGNORE", f)
                 else:
                     lexindexfunc[i] = (None, f[2:])
          
         return [(lexre,lexindexfunc)],[regex]
-    except Exception,e:
+    except Exception as e:
         m = int(len(relist)/2)
         if m == 0: m = 1
         llist, lre = _form_master_re(relist[:m],reflags,ldict)
@@ -466,7 +467,7 @@ def _statetoken(s,names):
     nonstate = 1
     parts = s.split("_")
     for i in range(1,len(parts)):
-         if not names.has_key(parts[i]) and parts[i] != 'ANY': break
+         if parts[i] not in names and parts[i] != 'ANY': break
     if i > 1:
        states = tuple(parts[1:i])
     else:
@@ -509,7 +510,7 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
             for (i,v) in _items:
                 ldict[i] = v
         else:
-            raise ValueError,"Expected a module or instance"
+            raise ValueError("Expected a module or instance")
         lexobj.lexmodule = module
         
     else:
@@ -544,35 +545,35 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
         literals = ldict.get("literals","")
         
     if not tokens:
-        raise SyntaxError,"lex: module does not define 'tokens'"
+        raise SyntaxError("lex: module does not define 'tokens'")
     if not (isinstance(tokens,list) or isinstance(tokens,tuple)):
-        raise SyntaxError,"lex: tokens must be a list or tuple."
+        raise SyntaxError("lex: tokens must be a list or tuple.")
 
     # Build a dictionary of valid token names
     lexobj.lextokens = { }
     if not optimize:
         for n in tokens:
             if not _is_identifier.match(n):
-                print "lex: Bad token name '%s'" % n
+                print("lex: Bad token name '%s'" % n)
                 error = 1
-            if warn and lexobj.lextokens.has_key(n):
-                print "lex: Warning. Token '%s' multiply defined." % n
+            if warn and n in lexobj.lextokens:
+                print("lex: Warning. Token '%s' multiply defined." % n)
             lexobj.lextokens[n] = None
     else:
         for n in tokens: lexobj.lextokens[n] = None
 
     if debug:
-        print "lex: tokens = '%s'" % lexobj.lextokens.keys()
+        print("lex: tokens = '%s'" % list(lexobj.lextokens.keys()))
 
     try:
          for c in literals:
                if not (isinstance(c,util.bytes_type) or isinstance(c, util.string_type)) or len(c) > 1:
-                    print "lex: Invalid literal %s. Must be a single character" % repr(c)
+                    print("lex: Invalid literal %s. Must be a single character" % repr(c))
                     error = 1
                     continue
 
     except TypeError:
-         print "lex: Invalid literals specification. literals must be a sequence of characters."
+         print("lex: Invalid literals specification. literals must be a sequence of characters.")
          error = 1
 
     lexobj.lexliterals = literals
@@ -580,12 +581,12 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
     # Build statemap
     if states:
          if not (isinstance(states,tuple) or isinstance(states,list)):
-              print "lex: states must be defined as a tuple or list."
+              print("lex: states must be defined as a tuple or list.")
               error = 1
          else:
               for s in states:
                     if not isinstance(s,tuple) or len(s) != 2:
-                           print "lex: invalid state specifier %s. Must be a tuple (statename,'exclusive|inclusive')" % repr(s)
+                           print("lex: invalid state specifier %s. Must be a tuple (statename,'exclusive|inclusive')" % repr(s))
                            error = 1
                            continue
                     name, statetype = s
@@ -593,15 +594,15 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
                            original_name = name
                            name = util.encode_input(name)
                     if not isinstance(name,util.bytes_type) or len(original_name) != len(name):
-                           print "lex: state name %s must be a byte string" % repr(original_name)
+                           print("lex: state name %s must be a byte string" % repr(original_name))
                            error = 1
                            continue
                     if not (statetype == 'inclusive' or statetype == 'exclusive'):
-                           print "lex: state type for state %s must be 'inclusive' or 'exclusive'" % name
+                           print("lex: state type for state %s must be 'inclusive' or 'exclusive'" % name)
                            error = 1
                            continue
-                    if stateinfo.has_key(name):
-                           print "lex: state '%s' already defined." % name
+                    if name in stateinfo:
+                           print("lex: state '%s' already defined." % name)
                            error = 1
                            continue
                     stateinfo[name] = statetype
@@ -623,19 +624,19 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
     errorf   = { }        # Error functions by state
 
     if len(tsymbols) == 0:
-        raise SyntaxError,"lex: no rules of the form t_rulename are defined."
+        raise SyntaxError("lex: no rules of the form t_rulename are defined.")
 
     for f in tsymbols:
         t = ldict[f]
         states, tokname = _statetoken(f,stateinfo)
         toknames[f] = tokname
 
-        if callable(t):
+        if isinstance(t, collections.Callable):
             for s in states: funcsym[s].append((f,t))
         elif (isinstance(t, util.bytes_type) or isinstance(t,util.string_type)):
             for s in states: strsym[s].append((f,t))
         else:
-            print "lex: %s not defined as a function or string" % f
+            print("lex: %s not defined as a function or string" % f)
             error = 1
 
     # Sort the functions by line number
@@ -668,17 +669,17 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
                 else:
                     reqargs = 1
                 if nargs > reqargs:
-                    print "%s:%d: Rule '%s' has too many arguments." % (file,line,f.__name__)
+                    print("%s:%d: Rule '%s' has too many arguments." % (file,line,f.__name__))
                     error = 1
                     continue
 
                 if nargs < reqargs:
-                    print "%s:%d: Rule '%s' requires an argument." % (file,line,f.__name__)
+                    print("%s:%d: Rule '%s' requires an argument." % (file,line,f.__name__))
                     error = 1
                     continue
 
                 if tokname == 'ignore':
-                    print "%s:%d: Rule '%s' must be defined as a string." % (file,line,f.__name__)
+                    print("%s:%d: Rule '%s' must be defined as a string." % (file,line,f.__name__))
                     error = 1
                     continue
         
@@ -691,25 +692,25 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
                     try:
                         c = re.compile("(?P<%s>%s)" % (f.__name__,f.__doc__), re.VERBOSE | reflags)
                         if c.match(""):
-                             print "%s:%d: Regular expression for rule '%s' matches empty string." % (file,line,f.__name__)
+                             print("%s:%d: Regular expression for rule '%s' matches empty string." % (file,line,f.__name__))
                              error = 1
                              continue
-                    except re.error,e:
-                        print "%s:%d: Invalid regular expression for rule '%s'. %s" % (file,line,f.__name__,e)
+                    except re.error as e:
+                        print("%s:%d: Invalid regular expression for rule '%s'. %s" % (file,line,f.__name__,e))
                         if '#' in f.__doc__:
-                             print "%s:%d. Make sure '#' in rule '%s' is escaped with '\\#'." % (file,line, f.__name__)                 
+                             print("%s:%d. Make sure '#' in rule '%s' is escaped with '\\#'." % (file,line, f.__name__))                 
                         error = 1
                         continue
 
                     if debug:
-                        print "lex: Adding rule %s -> '%s' (state '%s')" % (f.__name__,f.__doc__, state)
+                        print("lex: Adding rule %s -> '%s' (state '%s')" % (f.__name__,f.__doc__, state))
 
                 # Okay. The regular expression seemed okay.  Let's append it to the master regular
                 # expression we're building
   
                 regex_list.append("(?P<%s>%s)" % (f.__name__,f.__doc__))
             else:
-                print "%s:%d: No regular expression defined for rule '%s'" % (file,line,f.__name__)
+                print("%s:%d: No regular expression defined for rule '%s'" % (file,line,f.__name__))
 
         # Now add all of the simple rules
         for name,r in strsym[state]:
@@ -721,34 +722,34 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
 
             if not optimize:
                 if tokname == 'error':
-                    raise SyntaxError,"lex: Rule '%s' must be defined as a function" % name
+                    raise SyntaxError("lex: Rule '%s' must be defined as a function" % name)
                     error = 1
                     continue
         
-                if not lexobj.lextokens.has_key(tokname) and tokname.find("ignore_") < 0:
-                    print "lex: Rule '%s' defined for an unspecified token %s." % (name,tokname)
+                if tokname not in lexobj.lextokens and tokname.find("ignore_") < 0:
+                    print("lex: Rule '%s' defined for an unspecified token %s." % (name,tokname))
                     error = 1
                     continue
                 try:
                     c = re.compile("(?P<%s>%s)" % (name,r),re.VERBOSE | reflags)
                     if (c.match("")):
-                         print "lex: Regular expression for rule '%s' matches empty string." % name
+                         print("lex: Regular expression for rule '%s' matches empty string." % name)
                          error = 1
                          continue
-                except re.error,e:
-                    print "lex: Invalid regular expression for rule '%s'. %s" % (name,e)
+                except re.error as e:
+                    print("lex: Invalid regular expression for rule '%s'. %s" % (name,e))
                     if '#' in r:
-                         print "lex: Make sure '#' in rule '%s' is escaped with '\\#'." % name
+                         print("lex: Make sure '#' in rule '%s' is escaped with '\\#'." % name)
 
                     error = 1
                     continue
                 if debug:
-                    print "lex: Adding rule %s -> '%s' (state '%s')" % (name,r,state)
+                    print("lex: Adding rule %s -> '%s' (state '%s')" % (name,r,state))
                 
             regex_list.append("(?P<%s>%s)" % (name,r))
 
         if not regex_list:
-             print "lex: No rules defined for state '%s'" % state
+             print("lex: No rules defined for state '%s'" % state)
              error = 1
 
         regexs[state] = regex_list
@@ -760,7 +761,7 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
                 error = 1
 
     if error:
-        raise SyntaxError,"lex: Unable to build lexer."
+        raise SyntaxError("lex: Unable to build lexer.")
 
     # From this point forward, we're reasonably confident that we can build the lexer.
     # No more errors will be generated, but there might be some warning messages.
@@ -773,7 +774,7 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
         lexobj.lexstateretext[state] = re_text
         if debug:
             for i in range(len(re_text)):
-                 print "lex: state '%s'. regex[%d] = '%s'" % (state, i, re_text[i])
+                 print("lex: state '%s'. regex[%d] = '%s'" % (state, i, re_text[i]))
 
     # For inclusive states, we need to add the INITIAL state
     for state,type in stateinfo.items():
@@ -793,19 +794,19 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
     lexobj.lexstateerrorf = errorf
     lexobj.lexerrorf = errorf.get("INITIAL",None)
     if warn and not lexobj.lexerrorf:
-        print "lex: Warning. no t_error rule is defined."
+        print("lex: Warning. no t_error rule is defined.")
 
     # Check state information for ignore and error rules
     for s,stype in stateinfo.items():
         if stype == 'exclusive':
-              if warn and not errorf.has_key(s):
-                   print "lex: Warning. no error rule is defined for exclusive state '%s'" % s
-              if warn and not ignore.has_key(s) and lexobj.lexignore:
-                   print "lex: Warning. no ignore rule is defined for exclusive state '%s'" % s
+              if warn and s not in errorf:
+                   print("lex: Warning. no error rule is defined for exclusive state '%s'" % s)
+              if warn and s not in ignore and lexobj.lexignore:
+                   print("lex: Warning. no ignore rule is defined for exclusive state '%s'" % s)
         elif stype == 'inclusive':
-              if not errorf.has_key(s):
+              if s not in errorf:
                    errorf[s] = errorf.get("INITIAL",None)
-              if not ignore.has_key(s):
+              if s not in ignore:
                    ignore[s] = ignore.get("INITIAL","")
    
 
@@ -834,7 +835,7 @@ def runmain(lexer=None,data=None):
             data = f.read()
             f.close()
         except IndexError:
-            print "Reading from standard input (type EOF to end):"
+            print("Reading from standard input (type EOF to end):")
             data = sys.stdin.read()
 
     if lexer:
@@ -850,7 +851,7 @@ def runmain(lexer=None,data=None):
     while 1:
         tok = _token()
         if not tok: break
-        print "(%s,%r,%d,%d)" % (tok.type, tok.value, tok.lineno,tok.lexpos)
+        print("(%s,%r,%d,%d)" % (tok.type, tok.value, tok.lineno,tok.lexpos))
         
 
 # -----------------------------------------------------------------------------
diff --git a/sepolgen/src/sepolgen/module.py b/sepolgen/src/sepolgen/module.py
index 86d637b..c09676a 100644
--- a/sepolgen/src/sepolgen/module.py
+++ b/sepolgen/src/sepolgen/module.py
@@ -24,10 +24,12 @@ of module tress.
 
 import re
 import tempfile
-import commands
+try:
+    from subprocess import getstatusoutput
+except ImportError:
+    from commands import getstatusoutput
 import os
 import os.path
-import subprocess
 import shutil
 
 import selinux
@@ -131,7 +133,7 @@ class ModuleCompiler:
 
     def run(self, command):
         self.o(command)
-        rc, output = commands.getstatusoutput(command)
+        rc, output = getstatusoutput(command)
         self.o(output)
         
         return rc
diff --git a/sepolgen/src/sepolgen/objectmodel.py b/sepolgen/src/sepolgen/objectmodel.py
index 88c8a1f..d05d721 100644
--- a/sepolgen/src/sepolgen/objectmodel.py
+++ b/sepolgen/src/sepolgen/objectmodel.py
@@ -118,7 +118,7 @@ class PermMappings:
                 continue
             if fields[0] == "class":
                 c = fields[1]
-                if self.classes.has_key(c):
+                if c in self.classes:
                     raise ValueError("duplicate class in perm map")
                 self.classes[c] = { }
                 cur = self.classes[c]
diff --git a/sepolgen/src/sepolgen/policygen.py b/sepolgen/src/sepolgen/policygen.py
index 0f4c419..9cacc35 100644
--- a/sepolgen/src/sepolgen/policygen.py
+++ b/sepolgen/src/sepolgen/policygen.py
@@ -170,7 +170,7 @@ class PolicyGenerator:
 
             if av.type == audit2why.BOOLEAN:
                 if len(av.data) > 1:
-                    rule.comment += "\n#!!!! This avc can be allowed using one of the these booleans:\n#     %s" % ", ".join(map(lambda x: x[0], av.data))
+                    rule.comment += "\n#!!!! This avc can be allowed using one of the these booleans:\n#     %s" % ", ".join([x[0] for x in av.data])
                 else:
                     rule.comment += "\n#!!!! This avc can be allowed using the boolean '%s'" % av.data[0][0]
 
@@ -189,7 +189,7 @@ class PolicyGenerator:
                         self.domains = seinfo(ATTRIBUTE, name="domain")[0]["types"]
                     types=[]
 
-                    for i in map(lambda x: x[TCONTEXT], sesearch([ALLOW], {SCONTEXT: av.src_type, CLASS: av.obj_class, PERMS: av.perms})):
+                    for i in [x[TCONTEXT] for x in sesearch([ALLOW], {SCONTEXT: av.src_type, CLASS: av.obj_class, PERMS: av.perms})]:
                         if i not in self.domains:
                             types.append(i)
                     if len(types) == 1:
@@ -299,7 +299,7 @@ def call_interface(interface, av):
         elif params[i].type == refpolicy.OBJ_CLASS:
             ifcall.args.append(av.obj_class)
         else:
-            print params[i].type
+            print(params[i].type)
             assert(0)
 
     assert(len(ifcall.args) > 0)
diff --git a/sepolgen/src/sepolgen/refparser.py b/sepolgen/src/sepolgen/refparser.py
index c2d60fa..b50112c 100644
--- a/sepolgen/src/sepolgen/refparser.py
+++ b/sepolgen/src/sepolgen/refparser.py
@@ -268,7 +268,7 @@ def t_comment(t):
     t.lexer.lineno += 1
 
 def t_error(t):
-    print "Illegal character '%s'" % t.value[0]
+    print("Illegal character '%s'" % t.value[0])
     t.skip(1)
 
 def t_newline(t):
@@ -970,7 +970,7 @@ def p_optional_semi(p):
 def p_error(tok):
     global error, parse_file, success, parser
     error = "%s: Syntax error on line %d %s [type=%s]" % (parse_file, tok.lineno, tok.value, tok.type)
-    print error
+    print(error)
     success = False
 
 def prep_spt(spt):
@@ -1007,7 +1007,7 @@ def parse(text, module=None, support=None, debug=False):
 
     try:
         parser.parse(text, debug=debug, lexer=lexer)
-    except Exception, e:
+    except Exception as e:
         parser = None
         lexer = None
         error = "internal parser error: %s" % str(e) + "\n" + traceback.format_exc()
@@ -1074,9 +1074,9 @@ def parse_headers(root, output=None, expand=True, debug=False):
             fd.close()
             parse_file = f
             parse(txt, module, spt, debug)
-        except IOError, e:
+        except IOError as e:
             return
-        except ValueError, e:
+        except ValueError as e:
             raise ValueError("error parsing file %s: %s" % (f, str(e)))
 
     spt = None
@@ -1112,7 +1112,7 @@ def parse_headers(root, output=None, expand=True, debug=False):
                 parse_file(x[1], m, spt)
             else:
                 parse_file(x[1], m)
-        except ValueError, e:
+        except ValueError as e:
             o(str(e) + "\n")
             failures.append(x[1])
             continue
diff --git a/sepolgen/src/sepolgen/refpolicy.py b/sepolgen/src/sepolgen/refpolicy.py
index b8ed5c1..737f956 100644
--- a/sepolgen/src/sepolgen/refpolicy.py
+++ b/sepolgen/src/sepolgen/refpolicy.py
@@ -18,7 +18,6 @@
 #
 
 import string
-import itertools
 import selinux
 
 # OVERVIEW
@@ -85,53 +84,53 @@ class Node(PolicyBase):
     # Top level nodes
 
     def nodes(self):
-        return itertools.ifilter(lambda x: isinstance(x, Node), walktree(self))
+        return filter(lambda x: isinstance(x, Node), walktree(self))
 
     def modules(self):
-        return itertools.ifilter(lambda x: isinstance(x, Module), walktree(self))
+        return filter(lambda x: isinstance(x, Module), walktree(self))
 
     def interfaces(self):
-        return itertools.ifilter(lambda x: isinstance(x, Interface), walktree(self))
+        return filter(lambda x: isinstance(x, Interface), walktree(self))
 
     def templates(self):
-        return itertools.ifilter(lambda x: isinstance(x, Template), walktree(self))
+        return filter(lambda x: isinstance(x, Template), walktree(self))
 
     def support_macros(self):
-        return itertools.ifilter(lambda x: isinstance(x, SupportMacros), walktree(self))
+        return filter(lambda x: isinstance(x, SupportMacros), walktree(self))
 
     # Common policy statements
 
     def module_declarations(self):
-        return itertools.ifilter(lambda x: isinstance(x, ModuleDeclaration), walktree(self))
+        return filter(lambda x: isinstance(x, ModuleDeclaration), walktree(self))
 
     def interface_calls(self):
-        return itertools.ifilter(lambda x: isinstance(x, InterfaceCall), walktree(self))
+        return filter(lambda x: isinstance(x, InterfaceCall), walktree(self))
 
     def avrules(self):
-        return itertools.ifilter(lambda x: isinstance(x, AVRule), walktree(self))
+        return filter(lambda x: isinstance(x, AVRule), walktree(self))
 
     def typerules(self):
-        return itertools.ifilter(lambda x: isinstance(x, TypeRule), walktree(self))
+        return filter(lambda x: isinstance(x, TypeRule), walktree(self))
 
     def typeattributes(self):
         """Iterate over all of the TypeAttribute children of this Interface."""
-        return itertools.ifilter(lambda x: isinstance(x, TypeAttribute), walktree(self))
+        return filter(lambda x: isinstance(x, TypeAttribute), walktree(self))
 
     def roleattributes(self):
         """Iterate over all of the RoleAttribute children of this Interface."""
-        return itertools.ifilter(lambda x: isinstance(x, RoleAttribute), walktree(self))
+        return filter(lambda x: isinstance(x, RoleAttribute), walktree(self))
 
     def requires(self):
-        return itertools.ifilter(lambda x: isinstance(x, Require), walktree(self))
+        return filter(lambda x: isinstance(x, Require), walktree(self))
 
     def roles(self):
-        return itertools.ifilter(lambda x: isinstance(x, Role), walktree(self))
+        return filter(lambda x: isinstance(x, Role), walktree(self))
 
     def role_allows(self):
-        return itertools.ifilter(lambda x: isinstance(x, RoleAllow), walktree(self))
+        return filter(lambda x: isinstance(x, RoleAllow), walktree(self))
 
     def role_types(self):
-        return itertools.ifilter(lambda x: isinstance(x, RoleType), walktree(self))
+        return filter(lambda x: isinstance(x, RoleType), walktree(self))
 
     def __str__(self):
         if self.comment:
@@ -291,7 +290,7 @@ class SecurityContext(Leaf):
         self.type = fields[2]
         if len(fields) > 3:
             # FUTURE - normalize level fields to allow more comparisons to succeed.
-            self.level = string.join(fields[3:], ':')
+            self.level = ':'.join(fields[3:])
         else:
             self.level = None
 
@@ -703,7 +702,7 @@ def print_tree(head):
         s = ""
         for i in range(depth):
             s = s + "\t"
-        print s + str(node)
+        print(s + str(node))
 
 
 class Headers(Node):
@@ -810,7 +809,7 @@ class SupportMacros(Node):
         # are ordered correctly so that no macro is used before
         # it is defined
         s = set()
-        if self.map.has_key(perm):
+        if perm in self.map:
             for p in self.by_name(perm):
                 s.update(self.__expand_perm(p))
         else:
@@ -833,7 +832,7 @@ class SupportMacros(Node):
     def has_key(self, name):
         if not self.map:
             self.__gen_map()
-        return self.map.has_key(name)
+        return name in self.map
 
 class Require(Leaf):
     def __init__(self, parent=None):
diff --git a/sepolgen/src/sepolgen/yacc.py b/sepolgen/src/sepolgen/yacc.py
index 8b9b3e2..b14fb45 100644
--- a/sepolgen/src/sepolgen/yacc.py
+++ b/sepolgen/src/sepolgen/yacc.py
@@ -67,7 +67,11 @@ default_lr  = 'LALR'           # Default LR table generation method
 
 error_count = 3                # Number of symbols that must be shifted to leave recovery mode
 
-import re, types, sys, cStringIO, hashlib, os.path
+import re, types, sys, hashlib, os.path
+try:
+    from cStringIO import StringIO
+except ImportError:
+    from io import StringIO
 
 from . import util
 
@@ -141,9 +145,9 @@ class YaccProduction:
 
     def pushback(self,n):
         if n <= 0:
-            raise ValueError, "Expected a positive value"
+            raise ValueError("Expected a positive value")
         if n > (len(self.slice)-1):
-            raise ValueError, "Can't push %d tokens. Only %d are available." % (n,len(self.slice)-1)
+            raise ValueError("Can't push %d tokens. Only %d are available." % (n,len(self.slice)-1))
         for i in range(0,n):
             self.pbstack.append(self.slice[-i-1])
 
@@ -159,7 +163,7 @@ class Parser:
         # object directly.
 
         if magic != "xyzzy":
-            raise YaccError, "Can't instantiate Parser. Use yacc() instead."
+            raise YaccError("Can't instantiate Parser. Use yacc() instead.")
 
         # Reset internal state
         self.productions = None          # List of productions
@@ -223,7 +227,7 @@ class Parser:
             # is already set, we just use that. Otherwise, we'll pull
             # the next token off of the lookaheadstack or from the lexer
             if debug > 1:
-                print 'state', statestack[-1]
+                print('state', statestack[-1])
             if not lookahead:
                 if not lookaheadstack:
                     lookahead = get_token()     # Get the next token
@@ -241,7 +245,7 @@ class Parser:
             t = actions.get((s,ltype),None)
 
             if debug > 1:
-                print 'action', t
+                print('action', t)
             if t is not None:
                 if t > 0:
                     # shift a symbol on the stack
@@ -398,7 +402,7 @@ class Parser:
                 continue
 
             # Call an error function here
-            raise RuntimeError, "yacc: internal parser error!!!\n"
+            raise RuntimeError("yacc: internal parser error!!!\n")
 
 # -----------------------------------------------------------------------------
 #                          === Parser Construction ===
@@ -464,7 +468,7 @@ def validate_dict(d):
                 doc = v.__doc__.split(" ")
                 if doc[1] == ':':
                     sys.stderr.write("%s:%d: Warning. Possible grammar rule '%s' defined without p_ prefix.\n" % (v.__code__.co_filename, v.__code__.co_firstlineno,n))
-            except StandardError:
+            except Exception:
                 pass
 
 # -----------------------------------------------------------------------------
@@ -516,8 +520,8 @@ def initialize_vars():
 
     # File objects used when creating the parser.out debugging file
     global _vf, _vfc
-    _vf           = cStringIO.StringIO()
-    _vfc          = cStringIO.StringIO()
+    _vf           = StringIO()
+    _vfc          = StringIO()
 
 # -----------------------------------------------------------------------------
 # class Production:
@@ -583,7 +587,7 @@ class Production:
         # Precompute list of productions immediately following
         try:
             p.lrafter = Prodnames[p.prod[n+1]]
-        except (IndexError,KeyError),e:
+        except (IndexError,KeyError) as e:
             p.lrafter = []
         try:
             p.lrbefore = p.prod[n-1]
@@ -617,7 +621,7 @@ _is_identifier = re.compile(r'^[a-zA-Z0-9_-~]+$')
 
 def add_production(f,file,line,prodname,syms):
     
-    if Terminals.has_key(prodname):
+    if prodname in Terminals:
         sys.stderr.write("%s:%d: Illegal rule name '%s'. Already defined as a token.\n" % (file,line,prodname))
         return -1
     if prodname == 'error':
@@ -636,7 +640,7 @@ def add_production(f,file,line,prodname,syms):
                  if (len(c) > 1):
                       sys.stderr.write("%s:%d: Literal token %s in rule '%s' may only be a single character\n" % (file,line,s, prodname)) 
                       return -1
-                 if not Terminals.has_key(c):
+                 if c not in Terminals:
                       Terminals[c] = []
                  syms[x] = c
                  continue
@@ -648,7 +652,7 @@ def add_production(f,file,line,prodname,syms):
 
     # See if the rule is already in the rulemap
     map = "%s -> %s" % (prodname,syms)
-    if Prodmap.has_key(map):
+    if map in Prodmap:
         m = Prodmap[map]
         sys.stderr.write("%s:%d: Duplicate rule %s.\n" % (file,line, m))
         sys.stderr.write("%s:%d: Previous definition at %s:%d\n" % (file,line, m.file, m.line))
@@ -665,7 +669,7 @@ def add_production(f,file,line,prodname,syms):
             
     Productions.append(p)
     Prodmap[map] = p
-    if not Nonterminals.has_key(prodname):
+    if prodname not in Nonterminals:
         Nonterminals[prodname] = [ ]
     
     # Add all terminals to Terminals
@@ -689,13 +693,13 @@ def add_production(f,file,line,prodname,syms):
             del p.prod[i]
             continue
 
-        if Terminals.has_key(t):
+        if t in Terminals:
             Terminals[t].append(p.number)
             # Is a terminal.  We'll assign a precedence to p based on this
             if not hasattr(p,"prec"):
                 p.prec = Precedence.get(t,('right',0))
         else:
-            if not Nonterminals.has_key(t):
+            if t not in Nonterminals:
                 Nonterminals[t] = [ ]
             Nonterminals[t].append(p.number)
         i += 1
@@ -778,7 +782,7 @@ def add_function(f):
                 error += e
 
                 
-            except StandardError:
+            except Exception:
                 sys.stderr.write("%s:%d: Syntax error in rule '%s'\n" % (file,dline,ps))
                 error -= 1
     else:
@@ -795,7 +799,7 @@ def compute_reachable():
     (Unused terminals have already had their warning.)
     '''
     Reachable = { }
-    for s in Terminals.keys() + Nonterminals.keys():
+    for s in list(Terminals.keys()) + list(Nonterminals.keys()):
         Reachable[s] = 0
 
     mark_reachable_from( Productions[0].prod[0], Reachable )
@@ -874,7 +878,7 @@ def compute_terminates():
     some_error = 0
     for (s,terminates) in Terminates.items():
         if not terminates:
-            if not Prodnames.has_key(s) and not Terminals.has_key(s) and s != 'error':
+            if s not in Prodnames and s not in Terminals and s != 'error':
                 # s is used-but-not-defined, and we've already warned of that,
                 # so it would be overkill to say that it's also non-terminating.
                 pass
@@ -895,7 +899,7 @@ def verify_productions(cycle_check=1):
         if not p: continue
 
         for s in p.prod:
-            if not Prodnames.has_key(s) and not Terminals.has_key(s) and s != 'error':
+            if s not in Prodnames and s not in Terminals and s != 'error':
                 sys.stderr.write("%s:%d: Symbol '%s' used, but not defined as a token or a rule.\n" % (p.file,p.line,s))
                 error = 1
                 continue
@@ -937,12 +941,12 @@ def verify_productions(cycle_check=1):
 
     if yaccdebug:
         _vf.write("\nTerminals, with rules where they appear\n\n")
-        ks = Terminals.keys()
+        ks = list(Terminals.keys())
         ks.sort()
         for k in ks:
             _vf.write("%-20s : %s\n" % (k, " ".join([str(s) for s in Terminals[k]])))
         _vf.write("\nNonterminals, with rules where they appear\n\n")
-        ks = Nonterminals.keys()
+        ks = list(Nonterminals.keys())
         ks.sort()
         for k in ks:
             _vf.write("%-20s : %s\n" % (k, " ".join([str(s) for s in Nonterminals[k]])))
@@ -1005,7 +1009,7 @@ def add_precedence(plist):
                 sys.stderr.write("yacc: Invalid precedence '%s'\n" % prec)
                 return -1
             for t in terms:
-                if Precedence.has_key(t):
+                if t in Precedence:
                     sys.stderr.write("yacc: Precedence already specified for terminal '%s'\n" % t)
                     error += 1
                     continue
@@ -1089,7 +1093,7 @@ def compute_follow(start=None):
             # Here is the production set
             for i in range(len(p.prod)):
                 B = p.prod[i]
-                if Nonterminals.has_key(B):
+                if B in Nonterminals:
                     # Okay. We got a non-terminal in a production
                     fst = first(p.prod[i+1:])
                     hasempty = 0
@@ -1261,7 +1265,7 @@ def lr0_items():
         for x in asyms.keys():
             g = lr0_goto(I,x)
             if not g:  continue
-            if _lr0_cidhash.has_key(id(g)): continue
+            if id(g) in _lr0_cidhash: continue
             _lr0_cidhash[id(g)] = len(C)            
             C.append(g)
             
@@ -1307,7 +1311,7 @@ def compute_nullable_nonterminals():
                 nullable[p.name] = 1
                 continue
            for t in p.prod:
-                if not nullable.has_key(t): break
+                if t not in nullable: break
            else:
                 nullable[p.name] = 1
        if len(nullable) == num_nullable: break
@@ -1331,7 +1335,7 @@ def find_nonterminal_transitions(C):
          for p in C[state]:
              if p.lr_index < p.len - 1:
                   t = (state,p.prod[p.lr_index+1])
-                  if Nonterminals.has_key(t[1]):
+                  if t[1] in Nonterminals:
                         if t not in trans: trans.append(t)
          state = state + 1
      return trans
@@ -1354,7 +1358,7 @@ def dr_relation(C,trans,nullable):
     for p in g:
        if p.lr_index < p.len - 1:
            a = p.prod[p.lr_index+1]
-           if Terminals.has_key(a):
+           if a in Terminals:
                if a not in terms: terms.append(a)
 
     # This extra bit is to handle the start state
@@ -1379,7 +1383,7 @@ def reads_relation(C, trans, empty):
     for p in g:
         if p.lr_index < p.len - 1:
              a = p.prod[p.lr_index + 1]
-             if empty.has_key(a):
+             if a in empty:
                   rel.append((j,a))
 
     return rel
@@ -1439,15 +1443,15 @@ def compute_lookback_includes(C,trans,nullable):
                  t = p.prod[lr_index]
 
                  # Check to see if this symbol and state are a non-terminal transition
-                 if dtrans.has_key((j,t)):
+                 if (j,t) in dtrans:
                        # Yes.  Okay, there is some chance that this is an includes relation
                        # the only way to know for certain is whether the rest of the 
                        # production derives empty
 
                        li = lr_index + 1
                        while li < p.len:
-                            if Terminals.has_key(p.prod[li]): break      # No forget it
-                            if not nullable.has_key(p.prod[li]): break
+                            if p.prod[li] in Terminals: break      # No forget it
+                            if p.prod[li] not in nullable: break
                             li = li + 1
                        else:
                             # Appears to be a relation between (j,t) and (state,N)
@@ -1468,7 +1472,7 @@ def compute_lookback_includes(C,trans,nullable):
                  else:
                       lookb.append((j,r))
         for i in includes:
-             if not includedict.has_key(i): includedict[i] = []
+             if i not in includedict: includedict[i] = []
              includedict[i].append((state,N))
         lookdict[(state,N)] = lookb
 
@@ -1515,11 +1519,11 @@ def traverse(x,N,stack,F,X,R,FP):
         for a in F.get(y,[]):
             if a not in F[x]: F[x].append(a)
     if N[x] == d:
-       N[stack[-1]] = sys.maxint
+       N[stack[-1]] = sys.maxsize
        F[stack[-1]] = F[x]
        element = stack.pop()
        while element != x:
-           N[stack[-1]] = sys.maxint
+           N[stack[-1]] = sys.maxsize
            F[stack[-1]] = F[x]
            element = stack.pop()
 
@@ -1579,7 +1583,7 @@ def add_lookaheads(lookbacks,followset):
     for trans,lb in lookbacks.items():
         # Loop over productions in lookback
         for state,p in lb:
-             if not p.lookaheads.has_key(state):
+             if state not in p.lookaheads:
                   p.lookaheads[state] = []
              f = followset.get(trans,[])
              for a in f:
@@ -1711,7 +1715,7 @@ def lr_parse_table(method):
                 else:
                     i = p.lr_index
                     a = p.prod[i+1]       # Get symbol right after the "."
-                    if Terminals.has_key(a):
+                    if a in Terminals:
                         g = lr0_goto(I,a)
                         j = _lr0_cidhash.get(id(g),-1)
                         if j >= 0:
@@ -1753,22 +1757,22 @@ def lr_parse_table(method):
                                 action[st,a] = j
                                 actionp[st,a] = p
                                 
-            except StandardError,e:
-                raise YaccError, "Hosed in lr_parse_table", e
+            except Exception as e:
+                raise YaccError("Hosed in lr_parse_table").with_traceback(e)
 
         # Print the actions associated with each terminal
         if yaccdebug:
           _actprint = { }
           for a,p,m in actlist:
-            if action.has_key((st,a)):
+            if (st,a) in action:
                 if p is actionp[st,a]:
                     _vf.write("    %-15s %s\n" % (a,m))
                     _actprint[(a,m)] = 1
           _vf.write("\n")
           for a,p,m in actlist:
-            if action.has_key((st,a)):
+            if (st,a) in action:
                 if p is not actionp[st,a]:
-                    if not _actprint.has_key((a,m)):
+                    if (a,m) not in _actprint:
                         _vf.write("  ! %-15s [ %s ]\n" % (a,m))
                         _actprint[(a,m)] = 1
             
@@ -1778,7 +1782,7 @@ def lr_parse_table(method):
         nkeys = { }
         for ii in I:
             for s in ii.usyms:
-                if Nonterminals.has_key(s):
+                if s in Nonterminals:
                     nkeys[s] = None
         for n in nkeys.keys():
             g = lr0_goto(I,n)
@@ -1916,15 +1920,14 @@ del _lr_goto_items
         
         f.close()
 
-    except IOError,e:
-        print "Unable to create '%s'" % filename
-        print e
-        return
+    except IOError as e:
+        print("Unable to create '%s'" % filename)
+        print(e)
 
 def lr_read_tables(module=tab_module,optimize=0):
     global _lr_action, _lr_goto, _lr_productions, _lr_method
     try:
-        exec "import %s as parsetab" % module
+        exec("import %s as parsetab" % module)
         
         if (optimize) or (Signature.digest() == parsetab._lr_signature):
             _lr_action = parsetab._lr_action
@@ -1979,7 +1982,7 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
             for i in _items:
                 ldict[i[0]] = i[1]
         else:
-            raise ValueError,"Expected a module"
+            raise ValueError("Expected a module")
         
     else:
         # No module given.  We might be able to get information from the caller.
@@ -2025,15 +2028,15 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
             tokens = ldict.get("tokens",None)
     
         if not tokens:
-            raise YaccError,"module does not define a list 'tokens'"
+            raise YaccError("module does not define a list 'tokens'")
         if not (isinstance(tokens,list) or isinstance(tokens,tuple)):
-            raise YaccError,"tokens must be a list or tuple."
+            raise YaccError("tokens must be a list or tuple.")
 
         # Check to see if a requires dictionary is defined.
         requires = ldict.get("require",None)
         if requires:
             if not (isinstance(requires,dict)):
-                raise YaccError,"require must be a dictionary."
+                raise YaccError("require must be a dictionary.")
 
             for r,v in requires.items():
                 try:
@@ -2041,8 +2044,8 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
                         raise TypeError
                     v1 = [x.split(".") for x in v]
                     Requires[r] = v1
-                except StandardError:
-                    print "Invalid specification for rule '%s' in require. Expected a list of strings" % r            
+                except Exception:
+                    print("Invalid specification for rule '%s' in require. Expected a list of strings" % r)            
 
         
         # Build the dictionary of terminals.  We a record a 0 in the
@@ -2050,12 +2053,12 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
         # used in the grammar
 
         if 'error' in tokens:
-            print "yacc: Illegal token 'error'.  Is a reserved word."
-            raise YaccError,"Illegal token name"
+            print("yacc: Illegal token 'error'.  Is a reserved word.")
+            raise YaccError("Illegal token name")
 
         for n in tokens:
-            if Terminals.has_key(n):
-                print "yacc: Warning. Token '%s' multiply defined." % n
+            if n in Terminals:
+                print("yacc: Warning. Token '%s' multiply defined." % n)
             Terminals[n] = [ ]
 
         Terminals['error'] = [ ]
@@ -2064,12 +2067,12 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
         prec = ldict.get("precedence",None)
         if prec:
             if not (isinstance(prec,list) or isinstance(prec,tuple)):
-                raise YaccError,"precedence must be a list or tuple."
+                raise YaccError("precedence must be a list or tuple.")
             add_precedence(prec)
             Signature.update(util.encode_input(repr(prec)))
 
         for n in tokens:
-            if not Precedence.has_key(n):
+            if n not in Precedence:
                 Precedence[n] = ('right',0)         # Default, right associative, 0 precedence
 
         # Look for error handler
@@ -2080,17 +2083,17 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
             elif isinstance(ef, types.MethodType):
                 ismethod = 1
             else:
-                raise YaccError,"'p_error' defined, but is not a function or method."                
+                raise YaccError("'p_error' defined, but is not a function or method.")                
             eline = ef.__code__.co_firstlineno
             efile = ef.__code__.co_filename
             files[efile] = None
 
             if (ef.__code__.co_argcount != 1+ismethod):
-                raise YaccError,"%s:%d: p_error() requires 1 argument." % (efile,eline)
+                raise YaccError("%s:%d: p_error() requires 1 argument." % (efile,eline))
             global Errorfunc
             Errorfunc = ef
         else:
-            print "yacc: Warning. no p_error() function is defined."
+            print("yacc: Warning. no p_error() function is defined.")
             
         # Get the list of built-in functions with p_ prefix
         symbols = [ldict[f] for f in ldict.keys()
@@ -2099,7 +2102,7 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
 
         # Check for non-empty symbols
         if len(symbols) == 0:
-            raise YaccError,"no rules of the form p_rulename are defined."
+            raise YaccError("no rules of the form p_rulename are defined.")
     
         # Sort the symbols by line number
         symbols.sort(key=lambda x: x.__code__.co_firstlineno)
@@ -2119,7 +2122,7 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
         lr_init_vars()
 
         if error:
-            raise YaccError,"Unable to construct parser."
+            raise YaccError("Unable to construct parser.")
 
         if not lr_read_tables(tabmodule):
 
@@ -2131,8 +2134,8 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
             # Validate dictionary
             validate_dict(ldict)
 
-            if start and not Prodnames.has_key(start):
-                raise YaccError,"Bad starting symbol '%s'" % start
+            if start and start not in Prodnames:
+                raise YaccError("Bad starting symbol '%s'" % start)
         
             augment_grammar(start)    
             error = verify_productions(cycle_check=check_recursion)
@@ -2140,7 +2143,7 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
                if (type(f) in (types.FunctionType,types.MethodType) and ldict[f].__name__[:2] != 'p_')]
 
             if error:
-                raise YaccError,"Unable to construct parser."
+                raise YaccError("Unable to construct parser.")
             
             build_lritems()
             compute_first1()
@@ -2149,7 +2152,7 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
             if method in ['SLR','LALR']:
                 lr_parse_table(method)
             else:
-                raise YaccError, "Unknown parsing method '%s'" % method
+                raise YaccError("Unknown parsing method '%s'" % method)
 
             if write_tables:
                 lr_write_tables(tabmodule,outputdir)        
@@ -2161,8 +2164,8 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
                     f.write("\n\n")
                     f.write(_vf.getvalue())
                     f.close()
-                except IOError,e:
-                    print "yacc: can't create '%s'" % debugfile,e
+                except IOError as e:
+                    print("yacc: can't create '%s'" % debugfile,e)
         
     # Made it here.   Create a parser object and set up its internal state.
     # Set global parse() method to bound method of parser object.
@@ -2207,5 +2210,5 @@ def yacc_cleanup():
     
 # Stub that raises an error if parsing is attempted without first calling yacc()
 def parse(*args,**kwargs):
-    raise YaccError, "yacc: No parser built with yacc()"
+    raise YaccError("yacc: No parser built with yacc()")
 
-- 
2.4.3
