Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1LIDHFb021154
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:13:17 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1LIEXMh025892
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 18:14:34 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l1LIEXOt004738
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:14:33 -0500
Message-ID: <45DC8C04.5060909@mentalrootkit.com>
Date: Wed, 21 Feb 2007 13:14:28 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: [PATCH 2/2] sepolgen: handle the latest reference policy
Content-Type: multipart/mixed;
 boundary="------------020201010404040603060004"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020201010404040603060004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Update the sepolgen parser (refparser.py) to handle the latest reference 
policy. Includes some other parser cleanups.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

--------------020201010404040603060004
Content-Type: text/x-patch;
 name="sepolgen-refpol-updates.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sepolgen-refpol-updates.diff"

diff -r 744e42ad051c sepolgen/src/sepolgen/refparser.py
--- a/sepolgen/src/sepolgen/refparser.py	Wed Feb 21 12:37:45 2007 -0500
+++ b/sepolgen/src/sepolgen/refparser.py	Wed Feb 21 12:56:02 2007 -0500
@@ -31,9 +31,13 @@
 
 import sys
 import os
+import re
 
 import refpolicy
 import access
+
+import lex
+import yacc
 
 # :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 #
@@ -172,7 +176,7 @@ def t_m4comment(t):
     t.lineno += 1
 
 def t_IDENTIFIER(t):
-    r'[a-zA-Z_\$\-][a-zA-Z0-9_\.\$]*'
+    r'[a-zA-Z_\$\-][a-zA-Z0-9_\.\$\*]*'
     # Handle any keywords
     t.type = reserved.get(t.value,'IDENTIFIER')
     return t
@@ -189,10 +193,6 @@ def t_newline(t):
 def t_newline(t):
     r'\n+'
     t.lineno += len(t.value)
-
-# This actually creates the lexer - the information above is gathered through
-# the magic of introspection.
-import lex
 
 # :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 #
@@ -234,18 +234,21 @@ def expand(ids, s):
 
 # Top-level non-terminal
 def p_statements(p):
-    '''statements : interface
-                  | statements interface
-                  | template
-                  | statements template
-                  | obj_perm_set
-                  | statements obj_perm_set
+    '''statements : statement
+                  | statements statement
                   | empty
     '''
     if len(p) == 2:
         m.children.append(p[1])
     elif len(p) > 2:
         m.children.append(p[2])
+
+def p_statement(p):
+    '''statement : interface
+                 | template
+                 | obj_perm_set
+    '''
+    p[0] = p[1]
 
 # Basic terminals - identifiers and lists of identifiers. These must
 # be handled somewhat gracefully. Names returns an IdSet and care must
@@ -316,6 +319,11 @@ def p_comma_list(p):
         p[1] = p[1] + p[3]
     p[0] = p[1]
 
+def p_optional_semi(p):
+    '''optional_semi : SEMI
+                   | empty'''
+    pass
+
 def p_cond_expr(p):
     '''cond_expr : IDENTIFIER
                  | EXPL cond_expr
@@ -347,45 +355,22 @@ def p_interface(p):
     p[0] = x
 
 def p_template(p):
-    'template : TEMPLATE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN'
+    '''template : TEMPLATE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN
+                | DEFINE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN
+    '''
     x = refpolicy.Template(p[4])
     collect(p[8], x)
     p[0] = x
 
 def p_interface_stmts(p):
-    '''interface_stmts : gen_require
-                       | gen_require policy
-                       | policy
+    '''interface_stmts : policy
+                       | interface_stmts policy
                        | empty
     '''
     if len(p) == 2:
         p[0] = p[1]
     elif len(p) > 2:
-        p[0] = p[2]
-
-def p_gen_require(p):
-    'gen_require : GEN_REQ OPAREN TICK requires SQUOTE CPAREN'
-    # We ignore the require statements - they are redundant data from our point-of-view.
-    # Checkmodule will verify them later anyway so we just assume that they match what
-    # is in the rest of the interface.
-    pass
-
-def p_requires(p):
-    '''requires : require
-                | requires require
-                | ifdef
-                | requires ifdef
-    '''
-    pass
-
-def p_require(p):
-    '''require : TYPE comma_list SEMI
-               | ROLE comma_list SEMI
-               | ATTRIBUTE comma_list SEMI
-               | CLASS comma_list SEMI
-               | BOOL comma_list SEMI
-    '''
-    pass
+        p[0] = p[1] + p[2]
 
 def p_optional_policy(p):
     '''
@@ -407,9 +392,9 @@ def p_tunable_policy(p):
     p[0] = [x]
 
 def p_ifdef(p):
-    '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN
-             | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN
-             | IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN
+    '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
+             | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
+             | IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
     '''
     x = refpolicy.IfDef(p[4])
     if p[1] == 'ifdef':
@@ -417,7 +402,7 @@ def p_ifdef(p):
     else:
         v = False
     collect(p[8], x, val=v)
-    if len(p) > 11:
+    if len(p) > 12:
         collect(p[12], x, val=False)
     p[0] = [x]
 
@@ -452,33 +437,17 @@ def p_obj_perm_set(p):
 # Basic SELinux policy language
 
 def p_policy(p):
-    '''policy : policy_stmts
-              | policy policy_stmts
+    '''policy : policy_stmt
               | optional_policy
-              | policy optional_policy
               | tunable_policy
-              | policy tunable_policy
               | ifdef
-              | policy ifdef
               | conditional
-              | policy conditional
-    '''
-    if len(p) == 2:
-        p[0] = p[1]
-    else:
-        p[0] = p[1] + p[2]
-
-def p_policy_stmts(p):
-    '''policy_stmts : policy_stmt
-                    | policy_stmts policy_stmt
-    '''
-    if len(p) == 2:
-        p[0] = [p[1]]
-    else:
-        p[0] = p[1] + [p[2]]
+    '''
+    p[0] = p[1]
 
 def p_policy_stmt(p):
-    '''policy_stmt : avrule_def
+    '''policy_stmt : gen_require
+                   | avrule_def
                    | typerule_def
                    | typeattribute_def
                    | interface_call
@@ -490,7 +459,31 @@ def p_policy_stmt(p):
                    | attribute_def
                    | range_transition_def
     '''
-    p[0] = p[1]
+    p[0] = [p[1]]
+
+def p_gen_require(p):
+    'gen_require : GEN_REQ OPAREN TICK requires SQUOTE CPAREN'
+    # We ignore the require statements - they are redundant data from our point-of-view.
+    # Checkmodule will verify them later anyway so we just assume that they match what
+    # is in the rest of the interface.
+    pass
+
+def p_requires(p):
+    '''requires : require
+                | requires require
+                | ifdef
+                | requires ifdef
+    '''
+    pass
+
+def p_require(p):
+    '''require : TYPE comma_list SEMI
+               | ROLE comma_list SEMI
+               | ATTRIBUTE comma_list SEMI
+               | CLASS comma_list SEMI
+               | BOOL comma_list SEMI
+    '''
+    pass
 
 def p_type_def(p):
     '''type_def : TYPE IDENTIFIER COMMA comma_list SEMI
@@ -602,12 +595,10 @@ def p_range_transition_def(p):
     '''range_transition_def : RANGE_TRANSITION names names COLON names mls_range_def SEMI'''
     pass
 
-def p_error(p):
+def p_error(tok):
     global error
-    error = "Syntax error on line %d %s [type=%s]" % (p.lineno, p.value, p.type)
-
-import yacc
-
+    error = "Syntax error on line %d %s [type=%s]" % (tok.lineno, tok.value, tok.type)
+    print error
 
 def prep_spt(spt):
     if not spt:
@@ -616,49 +607,63 @@ def prep_spt(spt):
     for x in spt:
         map[x.name] = x
 
-p = None
-
-def parse(text, module=None, support=None):
-    global m
+
+
+parser = None
+lexer = None
+def create_globals(module, support):
+    global parser, lexer, m, spt
+    if not parser:
+        lexer = lex.lex()
+        parser = yacc.yacc(method="LALR", debug=0, write_tables=0)
+
     if module is not None:
         m = module
     else:
         m = refpolicy.Module()
 
-    global spt
     if not support:
         spt = refpolicy.SupportMacros()
     else:
         spt = support
 
-    lex.lex()
-    global p
-    if not p:
-        p = yacc.yacc(method="LALR", debug=0, write_tables=0)
-
-    p.parse(text, debug=0)
+def parse(text, module=None, support=None):
+    create_globals(module, support)
+    lexer.lexdata = []
+    lexer.lexpos = 0
+
+    try:
+        parser.parse(text, debug=0)
+    except Exception, e:
+        global error
+        error = "internal parser error: %s" % str(e)
 
     if error is not None:
         msg = 'could not parse text: "%s"' % error
+        print msg
         raise ValueError(msg)
     return m
 
 def list_headers(root):
     modules = []
     support_macros = None
+    blacklist = ["init.if", "inetd.if", "uml.if", "thunderbird.if"]
 
     for dirpath, dirnames, filenames in os.walk(root):
         for name in filenames:
             # FIXME: these make the parser barf in various unrecoverable ways, so we must skip
             # them.
-            if name == "inetd.if" or name == "init.if" or name == "uml.if" or name=="thunderbird.if":
+            if name in blacklist:
                 continue
+
             modname = os.path.splitext(name)
             filename = os.path.join(dirpath, name)
 
             if modname[1] == '.spt':
                 if name == "obj_perm_sets.spt":
                     support_macros = filename
+                elif len(re.findall("patterns", modname[0])):
+                         modules.append((modname[0], filename))
             elif modname[1] == '.if':
                 modules.append((modname[0], filename))
 

--------------020201010404040603060004--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
