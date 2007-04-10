Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3AGTSqu008921
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 12:29:28 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3AGTOsu021049
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 16:29:25 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3AGTLrh009338
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 12:29:21 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3AGTFQx017222
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 12:29:15 -0400
Received: from [10.11.14.144] (vpn-14-144.rdu.redhat.com [10.11.14.144])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3AGTFjj026986
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 12:29:15 -0400
Subject: [PATCH] sepolgen updates
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 12:26:45 -0400
Message-Id: <1176222405.6137.57.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Updates to the sepolgen parser and tools:
* Adding debugging option to sepolgen-ifgen
* Corrected handling of interface calls with list paramaters (e.g., 
  foo_interface(a_t, { b_t c_t }).
* Added support for role transition rules in the parser
* Updated range transition rule handling to accept more statements
* Moved ignoring refpolicywarn statements to the lexer to better handle
  arbitrary text in the warnings.
* Fixed parsing of single files by sepolgen-ifgen (useful for testing)
* Loosened the matching slightly (higher distance interfaces returned
  by default).

 policycoreutils/audit2allow/sepolgen-ifgen |    6 +-
 sepolgen/src/sepolgen/interfaces.py        |   37 ++++++++-------
 sepolgen/src/sepolgen/matching.py          |    2 
 sepolgen/src/sepolgen/refparser.py         |   69 ++++++++++++++++++-----------
 sepolgen/src/sepolgen/refpolicy.py         |   12 ++---
 5 files changed, 76 insertions(+), 50 deletions(-)

diff -r 2ee7ee69adbf policycoreutils/audit2allow/sepolgen-ifgen
--- a/policycoreutils/audit2allow/sepolgen-ifgen	Mon Apr 09 13:56:43 2007 -0400
+++ b/policycoreutils/audit2allow/sepolgen-ifgen	Tue Apr 10 12:19:56 2007 -0400
@@ -45,7 +45,9 @@ def parse_options():
     parser.add_option("-i", "--interfaces", dest="headers", default=defaults.headers(),
                       help="location of the interface header files")
     parser.add_option("-v", "--verbose", action="store_true", default=False,
-                      help="print debuging output")                      
+                      help="print debuging output")
+    parser.add_option("-d", "--debug", action="store_true", default=False,
+                     help="extra debugging output")
     options, args = parser.parse_args()
     
     return options
@@ -67,7 +69,7 @@ def main():
         log = None
 
     try:
-        headers = refparser.parse_headers(options.headers, output=log)
+        headers = refparser.parse_headers(options.headers, output=log, debug=options.debug)
     except ValueError, e:
         print "error parsing headers"
         print str(e)
diff -r 2ee7ee69adbf sepolgen/src/sepolgen/interfaces.py
--- a/sepolgen/src/sepolgen/interfaces.py	Mon Apr 09 13:56:43 2007 -0400
+++ b/sepolgen/src/sepolgen/interfaces.py	Tue Apr 10 12:19:56 2007 -0400
@@ -365,21 +365,25 @@ class InterfaceSet:
                 # been generated from an optional param.
                 return None
             else:
-                return ifcall.args[num - 1]
+                arg = ifcall.args[num - 1]
+                if isinstance(arg, list):
+                    return arg
+                else:
+                    return [arg]
         else:
-            return id
+            return [id]
 
     def map_add_av(self, ifv, av, ifcall):
-        src_type = self.map_param(av.src_type, ifcall)
-        if src_type is None:
-            return
-
-        tgt_type = self.map_param(av.tgt_type, ifcall)
-        if tgt_type is None:
-            return
-
-        obj_class = self.map_param(av.obj_class, ifcall)
-        if obj_class is None:
+        src_types = self.map_param(av.src_type, ifcall)
+        if src_types is None:
+            return
+
+        tgt_types = self.map_param(av.tgt_type, ifcall)
+        if tgt_types is None:
+            return
+
+        obj_classes = self.map_param(av.obj_class, ifcall)
+        if obj_classes is None:
             return
 
         new_perms = refpolicy.IdSet()
@@ -388,13 +392,14 @@ class InterfaceSet:
             if p is None:
                 continue
             else:
-                new_perms.add(p)
+                new_perms.update(p)
         if len(new_perms) == 0:
             return
 
-        ifv.access.add(src_type, tgt_type, obj_class, new_perms)
-
-
+        for src_type in src_types:
+            for tgt_type in tgt_types:
+                for obj_class in obj_classes:
+                    ifv.access.add(src_type, tgt_type, obj_class, new_perms)
 
     def do_expand_ifcalls(self, interface, if_by_name):
         # Descend an interface call tree adding the access
diff -r 2ee7ee69adbf sepolgen/src/sepolgen/matching.py
--- a/sepolgen/src/sepolgen/matching.py	Mon Apr 09 13:56:43 2007 -0400
+++ b/sepolgen/src/sepolgen/matching.py	Tue Apr 10 12:19:56 2007 -0400
@@ -50,7 +50,7 @@ class Match:
                 return 1
 
 class MatchList:
-    DEFAULT_THRESHOLD = 100
+    DEFAULT_THRESHOLD = 120
     def __init__(self):
         # Match objects that pass the threshold
         self.children = []
diff -r 2ee7ee69adbf sepolgen/src/sepolgen/refparser.py
--- a/sepolgen/src/sepolgen/refparser.py	Mon Apr 09 13:56:43 2007 -0400
+++ b/sepolgen/src/sepolgen/refparser.py	Tue Apr 10 12:19:56 2007 -0400
@@ -35,6 +35,7 @@ import re
 
 import refpolicy
 import access
+import defaults
 
 import lex
 import yacc
@@ -59,7 +60,6 @@ tokens = (
     'MINUS',
     'TILDE',
     'ASTERISK',
-    'PERIOD',
     'AMP',
     'BAR',
     'EXPL',
@@ -89,13 +89,13 @@ tokens = (
     'TYPE_CHANGE',
     'TYPE_MEMBER',
     'RANGE_TRANSITION',
+    'ROLE_TRANSITION',
     #   refpolicy keywords
     'OPT_POLICY',
     'INTERFACE',
     'TUNABLE_POLICY',
     'GEN_REQ',
     'TEMPLATE',
-    'REFPOLICYWARN',
     #   m4
     'IFDEF',
     'IFNDEF',
@@ -128,13 +128,13 @@ reserved = {
     'type_change' : 'TYPE_CHANGE',
     'type_member' : 'TYPE_MEMBER',
     'range_transition' : 'RANGE_TRANSITION',
+    'role_transition' : 'ROLE_TRANSITION',
     # refpolicy keywords
     'optional_policy' : 'OPT_POLICY',
     'interface' : 'INTERFACE',
     'tunable_policy' : 'TUNABLE_POLICY',
     'gen_require' : 'GEN_REQ',
     'template' : 'TEMPLATE',
-    'refpolicywarn' : 'REFPOLICYWARN',
     # M4
     'ifndef' : 'IFNDEF',
     'ifdef' : 'IFDEF',
@@ -158,7 +158,6 @@ t_MINUS     = r'\-'
 t_MINUS     = r'\-'
 t_TILDE     = r'\~'
 t_ASTERISK  = r'\*'
-t_PERIOD    = r'\.'
 t_AMP       = r'\&'
 t_BAR       = r'\|'
 t_EXPL      = r'\!'
@@ -175,8 +174,14 @@ def t_m4comment(t):
     # Ignore all comments
     t.lineno += 1
 
+def t_refpolicywarn(t):
+    r'refpolicywarn\(.*\n'
+    # Ignore refpolicywarn statements - they sometimes
+    # contain text that we can't parse.
+    t.lineno += 1
+    
 def t_IDENTIFIER(t):
-    r'[a-zA-Z_\$\-][a-zA-Z0-9_\.\$\*]*'
+    r'[a-zA-Z_\$][a-zA-Z0-9_\.\$\*]*'
     # Handle any keywords
     t.type = reserved.get(t.value,'IDENTIFIER')
     return t
@@ -311,6 +316,28 @@ def p_nested_id_element(p):
         str = "-" + p[2]
         p[0] = [str]
 
+def p_interface_call_param(p):
+    '''interface_call_param : IDENTIFIER
+                            | IDENTIFIER MINUS IDENTIFIER
+                            | nested_id_set
+    '''
+    # Intentionally let single identifiers pass through
+    # List means set, non-list identifier
+    if len(p) == 2:
+        p[0] = p[1]
+    else:
+        p[0] = [p[1], "-" + p[3]]
+
+def p_interface_call_param_list(p):
+    '''interface_call_param_list : interface_call_param
+                                 | interface_call_param_list COMMA interface_call_param
+    '''
+    if len(p) == 2:
+        p[0] = [p[1]]
+    else:
+        p[0] = p[1] + [p[3]]
+
+
 def p_comma_list(p):
     '''comma_list : nested_id_list
                   | comma_list COMMA nested_id_list
@@ -406,23 +433,8 @@ def p_ifdef(p):
         collect(p[12], x, val=False)
     p[0] = [x]
 
-def p_refpolicywarn_stmts(p):
-    '''refpolicywarn_stmts : names
-                           | refpolicywarn_stmts names
-                           | OPAREN
-                           | refpolicywarn_stmts OPAREN
-                           | CPAREN
-                           | refpolicywarn_stmts CPAREN
-                           | PERIOD
-                           | refpolicywarn_stmts PERIOD
-    '''
-
-def p_refpolicywarn(p):
-    '''refpolicywarn : REFPOLICYWARN OPAREN TICK refpolicywarn_stmts SQUOTE CPAREN'''
-    pass
-
 def p_interface_call(p):
-    'interface_call : IDENTIFIER OPAREN comma_list CPAREN'
+    'interface_call : IDENTIFIER OPAREN interface_call_param_list CPAREN'
     i = refpolicy.InterfaceCall(ifname=p[1])
 
     i.args.extend(p[3])
@@ -455,9 +467,9 @@ def p_policy_stmt(p):
                    | role_allow
                    | type_def
                    | typealias_def
-                   | refpolicywarn
                    | attribute_def
                    | range_transition_def
+                   | role_transition_def
     '''
     p[0] = [p[1]]
 
@@ -592,7 +604,12 @@ def p_mls_range_def(p):
 
 
 def p_range_transition_def(p):
-    '''range_transition_def : RANGE_TRANSITION names names COLON names mls_range_def SEMI'''
+    '''range_transition_def : RANGE_TRANSITION names names COLON names mls_range_def SEMI
+                            | RANGE_TRANSITION names names names SEMI'''
+    pass
+
+def p_role_transition_def(p):
+    '''role_transition_def : ROLE_TRANSITION names names names SEMI'''
     pass
 
 def p_error(tok):
@@ -640,7 +657,6 @@ def parse(text, module=None, support=Non
 
     if error is not None:
         msg = 'could not parse text: "%s"' % error
-        print msg
         raise ValueError(msg)
     return m
 
@@ -684,7 +700,7 @@ def parse_headers(root, output=None, exp
             raise ValueError("Invalid file name %s" % root)
         modname = os.path.splitext(name)
         modules.append((modname[0], root))
-        all_modules, support_macros = list_headers(DEFAULT_HEADERS_ROOT)
+        all_modules, support_macros = list_headers(defaults.headers())
     else:
         modules, support_macros = list_headers(root)
 
@@ -741,7 +757,8 @@ def parse_headers(root, output=None, exp
                 parse_file(x[1], m, spt)
             else:
                 parse_file(x[1], m)
-        except ValueError:
+        except ValueError, e:
+            o(str(e) + "\n")
             failures.append(x[1])
             continue
 
diff -r 2ee7ee69adbf sepolgen/src/sepolgen/refpolicy.py
--- a/sepolgen/src/sepolgen/refpolicy.py	Mon Apr 09 13:56:43 2007 -0400
+++ b/sepolgen/src/sepolgen/refpolicy.py	Tue Apr 10 12:19:56 2007 -0400
@@ -579,9 +579,6 @@ class InterfaceCall(Leaf):
         self.args = []
         self.comments = []
 
-    def to_string(self):
-        return self.to_string()
-
     def matches(self, other):
         if self.ifname != other.ifname:
             return False
@@ -596,10 +593,15 @@ class InterfaceCall(Leaf):
         s = "%s(" % self.ifname
         i = 0
         for a in self.args:
+            if isinstance(a, list):
+                str = list_to_space_str(a)
+            else:
+                str = a
+                
             if i != 0:
-                s = s + ", %s" % a
+                s = s + ", %s" % str
             else:
-                s = s + a
+                s = s + str
             i += 1
         return s + ")"
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
