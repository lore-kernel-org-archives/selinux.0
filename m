Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l83GLOJv027998
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2007 12:21:24 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l83GLNtI020588
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2007 16:21:23 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l83GLM5B028293
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2007 12:21:22 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l83GLMRI028874
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2007 12:21:22 -0400
Received: from localhost.localdomain (vpn-14-119.rdu.redhat.com [10.11.14.119])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l83GLLOp001808
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2007 12:21:21 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] Expand sepolgen parser to parse all modules
Message-Id: <2a723e3216cbbb6be692.1188836471@localhost.localdomain>
Date: Mon, 03 Sep 2007 12:21:11 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Expand the sepolgen parser so that it is capable of parsing all of the current
reference policy modules in addition to the headers. The parser likely needs
some more cleanup (it is currently very ambigius, though this doesn't seem to
cause any harm in practice).

Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
---

diff -r c80a10119da1 -r 2a723e3216cb sepolgen/src/sepolgen/refparser.py
--- a/sepolgen/src/sepolgen/refparser.py	Mon Sep 03 12:16:26 2007 -0400
+++ b/sepolgen/src/sepolgen/refparser.py	Mon Sep 03 12:20:08 2007 -0400
@@ -1,6 +1,6 @@
 # Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
 #
-# Copyright (C) 2006 Red Hat
+# Copyright (C) 2006-2007 Red Hat
 # see file 'COPYING' for use and warranty information
 #
 # This program is free software; you can redistribute it and/or
@@ -32,6 +32,7 @@ import sys
 import sys
 import os
 import re
+import traceback
 
 import refpolicy
 import access
@@ -65,7 +66,23 @@ tokens = (
     'EXPL',
     'EQUAL',
     'IDENTIFIER',
+    'NUMBER',
+    'PATH',
+    'IPV6_ADDR',
     # reserved words
+    #   module
+    'MODULE',
+    'POLICY_MODULE',
+    'REQUIRE',
+    #   flask
+    'SID',
+    'GENFSCON',
+    'FS_USE_XATTR',
+    'FS_USE_TRANS',
+    'FS_USE_TASK',
+    'PORTCON',
+    'NODECON',
+    'NETIFCON',
     #   object classes
     'CLASS',
     #   types and attributes
@@ -76,6 +93,8 @@ tokens = (
     'TYPEALIAS',
     #   conditional policy
     'BOOL',
+    'TRUE',
+    'FALSE',
     'IF',
     'ELSE',
     #   users and roles
@@ -85,6 +104,7 @@ tokens = (
     'ALLOW',
     'DONTAUDIT',
     'AUDITALLOW',
+    'NEVERALLOW',
     'TYPE_TRANSITION',
     'TYPE_CHANGE',
     'TYPE_MEMBER',
@@ -96,6 +116,7 @@ tokens = (
     'TUNABLE_POLICY',
     'GEN_REQ',
     'TEMPLATE',
+    'GEN_CONTEXT',
     #   m4
     'IFDEF',
     'IFNDEF',
@@ -105,6 +126,19 @@ tokens = (
 # All reserved keywords - see t_IDENTIFIER for how these are matched in
 # the lexer.
 reserved = {
+    # module
+    'module' : 'MODULE',
+    'policy_module' : 'POLICY_MODULE',
+    'require' : 'REQUIRE',
+    # flask
+    'sid' : 'SID',
+    'genfscon' : 'GENFSCON',
+    'fs_use_xattr' : 'FS_USE_XATTR',
+    'fs_use_trans' : 'FS_USE_TRANS',
+    'fs_use_task' : 'FS_USE_TASK',
+    'portcon' : 'PORTCON',
+    'nodecon' : 'NODECON',
+    'netifcon' : 'NETIFCON',
     # object classes
     'class' : 'CLASS',
     # types and attributes
@@ -115,6 +149,8 @@ reserved = {
     'typealias' : 'TYPEALIAS',
     # conditional policy
     'bool' : 'BOOL',
+    'true' : 'TRUE',
+    'false' : 'FALSE',
     'if' : 'IF',
     'else' : 'ELSE',
     # users and roles
@@ -124,6 +160,7 @@ reserved = {
     'allow' : 'ALLOW',
     'dontaudit' : 'DONTAUDIT',
     'auditallow' : 'AUDITALLOW',
+    'neverallow' : 'NEVERALLOW',
     'type_transition' : 'TYPE_TRANSITION',
     'type_change' : 'TYPE_CHANGE',
     'type_member' : 'TYPE_MEMBER',
@@ -135,6 +172,7 @@ reserved = {
     'tunable_policy' : 'TUNABLE_POLICY',
     'gen_require' : 'GEN_REQ',
     'template' : 'TEMPLATE',
+    'gen_context' : 'GEN_CONTEXT',
     # M4
     'ifndef' : 'IFNDEF',
     'ifdef' : 'IFDEF',
@@ -162,26 +200,34 @@ t_BAR       = r'\|'
 t_BAR       = r'\|'
 t_EXPL      = r'\!'
 t_EQUAL     = r'\='
+t_NUMBER    = r'[0-9\.]+'
+t_PATH      = r'/[a-zA-Z0-9)_\.\*/]*'
+#t_IPV6_ADDR = r'[a-fA-F0-9]{0,4}:[a-fA-F0-9]{0,4}:([a-fA-F0-9]{0,4}:)*'
 
 # Ignore whitespace - this is a special token for ply that more efficiently
 # ignores uninteresting tokens.
 t_ignore    = " \t"
 
 # More complex tokens
+def t_IPV6_ADDR(t):
+    r'[a-fA-F0-9]{0,4}:[a-fA-F0-9]{0,4}:([a-fA-F0-9]|:)*'
+    # This is a function simply to force it sooner into
+    # the regex list
+    return t
 
 def t_m4comment(t):
     r'dnl.*\n'
     # Ignore all comments
-    t.lineno += 1
+    t.lexer.lineno += 1
 
 def t_refpolicywarn(t):
     r'refpolicywarn\(.*\n'
     # Ignore refpolicywarn statements - they sometimes
     # contain text that we can't parse.
-    t.lineno += 1
-    
+    t.lexer.lineno += 1
+
 def t_IDENTIFIER(t):
-    r'[a-zA-Z_\$][a-zA-Z0-9_\.\$\*]*'
+    r'[a-zA-Z_\$][a-zA-Z0-9_\-\.\$\*]*'
     # Handle any keywords
     t.type = reserved.get(t.value,'IDENTIFIER')
     return t
@@ -189,7 +235,7 @@ def t_comment(t):
 def t_comment(t):
     r'\#.*\n'
     # Ignore all comments
-    t.lineno += 1
+    t.lexer.lineno += 1
 
 def t_error(t):
     print "Illegal character '%s'" % t.value[0]
@@ -197,7 +243,7 @@ def t_error(t):
 
 def t_newline(t):
     r'\n+'
-    t.lineno += len(t.value)
+    t.lexer.lineno += len(t.value)
 
 # :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 #
@@ -243,136 +289,39 @@ def p_statements(p):
                   | statements statement
                   | empty
     '''
-    if len(p) == 2:
+    if len(p) == 2 and p[1]:
         m.children.append(p[1])
-    elif len(p) > 2:
+    elif len(p) > 2 and p[2]:
         m.children.append(p[2])
 
 def p_statement(p):
     '''statement : interface
                  | template
                  | obj_perm_set
+                 | policy
+                 | policy_module_stmt
+                 | module_stmt
     '''
     p[0] = p[1]
-
-# Basic terminals - identifiers and lists of identifiers. These must
-# be handled somewhat gracefully. Names returns an IdSet and care must
-# be taken that this is _assigned_ to an object to correctly update
-# all of the flags (as opposed to using update). The other terminals
-# return list - this is to preserve ordering if it is important for
-# parsing (for example, interface_call must retain the ordering). Other
-# times the list should be used to update an IdSet.
-
-def p_names(p):
-    '''names : identifier
-             | nested_id_set
-             | asterisk
-             | TILDE identifier
-             | TILDE nested_id_set
-             | IDENTIFIER MINUS IDENTIFIER
-    '''
-    s = refpolicy.IdSet()
-    if len(p) < 3:
-        expand(p[1], s)
-    elif len(p) == 3:
-        expand(p[2], s)
-        s.compliment = True
-    else:
-        expand([p[1]])
-        s.add("-" + p[3])
-    p[0] = s
-
-def p_identifier(p):
-    'identifier : IDENTIFIER'
-    p[0] = [p[1]]
-
-def p_asterisk(p):
-    'asterisk : ASTERISK'
-    p[0] = [p[1]]
-
-def p_nested_id_set(p):
-    '''nested_id_set : OBRACE nested_id_list CBRACE
-    '''
-    p[0] = p[2]
-
-def p_nested_id_list(p):
-    '''nested_id_list : nested_id_element
-                      | nested_id_list nested_id_element
-    '''
-    if len(p) == 2:
-        p[0] = p[1]
-    else:
-        p[0] = p[1] + p[2]
-
-def p_nested_id_element(p):
-    '''nested_id_element : identifier
-                         | MINUS IDENTIFIER
-                         | nested_id_set
-    '''
-    if len(p) == 2:
-        p[0] = p[1]
-    else:
-        # For now just leave the '-'
-        str = "-" + p[2]
-        p[0] = [str]
-
-def p_interface_call_param(p):
-    '''interface_call_param : IDENTIFIER
-                            | IDENTIFIER MINUS IDENTIFIER
-                            | nested_id_set
-    '''
-    # Intentionally let single identifiers pass through
-    # List means set, non-list identifier
-    if len(p) == 2:
-        p[0] = p[1]
-    else:
-        p[0] = [p[1], "-" + p[3]]
-
-def p_interface_call_param_list(p):
-    '''interface_call_param_list : interface_call_param
-                                 | interface_call_param_list COMMA interface_call_param
-    '''
-    if len(p) == 2:
-        p[0] = [p[1]]
-    else:
-        p[0] = p[1] + [p[3]]
-
-
-def p_comma_list(p):
-    '''comma_list : nested_id_list
-                  | comma_list COMMA nested_id_list
-    '''
-    if len(p) > 2:
-        p[1] = p[1] + p[3]
-    p[0] = p[1]
-
-def p_optional_semi(p):
-    '''optional_semi : SEMI
-                   | empty'''
-    pass
-
-def p_cond_expr(p):
-    '''cond_expr : IDENTIFIER
-                 | EXPL cond_expr
-                 | cond_expr AMP AMP cond_expr
-                 | cond_expr BAR BAR cond_expr
-                 | cond_expr EQUAL EQUAL cond_expr
-                 | cond_expr EXPL EQUAL cond_expr
-    '''
-    l = len(p)
-    if l == 2:
-        p[0] = [p[1]]
-    elif l == 3:
-        p[0] = [p[1]] + p[2]
-    else:
-        p[0] = p[1] + [p[2] + p[3]] + p[4]
-
 
 def p_empty(p):
     'empty :'
     pass
 
+#
 # Reference policy language constructs
+#
+
+# This is for the policy module statement (e.g., policy_module(foo,1.2.0)).
+# We have a separate terminal for either the basic language module statement
+# and interface calls to make it easier to identifier.
+def p_policy_module_stmt(p):
+    'policy_module_stmt : POLICY_MODULE OPAREN IDENTIFIER COMMA NUMBER CPAREN'
+    m = refpolicy.ModuleDeclaration()
+    m.name = p[3]
+    m.version = p[5]
+    m.refpolicy = True
+    p[0] = m
 
 def p_interface(p):
     '''interface : INTERFACE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN
@@ -388,23 +337,38 @@ def p_template(p):
     x = refpolicy.Template(p[4])
     collect(p[8], x)
     p[0] = x
+
+def p_define(p):
+    '''define : DEFINE OPAREN TICK IDENTIFIER SQUOTE CPAREN'''
+    # This is for defining single M4 values (to be used later in ifdef statements).
+    # Example: define(`sulogin_no_pam'). We don't currently do anything with these
+    # but we should in the future when we correctly resolve ifdef statements.
+    p[0] = None
 
 def p_interface_stmts(p):
     '''interface_stmts : policy
                        | interface_stmts policy
                        | empty
     '''
-    if len(p) == 2:
+    if len(p) == 2 and p[1]:
         p[0] = p[1]
     elif len(p) > 2:
-        p[0] = p[1] + p[2]
+        if not p[1]:
+            if p[2]:
+                p[0] = p[2]
+        elif not p[2]:
+            p[0] = p[1]
+        else:
+            p[0] = p[1] + p[2]
 
 def p_optional_policy(p):
-    '''
-    optional_policy : OPT_POLICY OPAREN TICK interface_stmts SQUOTE CPAREN
+    '''optional_policy : OPT_POLICY OPAREN TICK interface_stmts SQUOTE CPAREN
+                       | OPT_POLICY OPAREN TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN
     '''
     o = refpolicy.OptionalPolicy()
-    o.children = p[4]
+    collect(p[4], o, val=True)
+    if len(p) > 7:
+        collect(p[8], o, val=False)
     p[0] = [o]
 
 def p_tunable_policy(p):
@@ -434,19 +398,48 @@ def p_ifdef(p):
     p[0] = [x]
 
 def p_interface_call(p):
-    'interface_call : IDENTIFIER OPAREN interface_call_param_list CPAREN'
+    '''interface_call : IDENTIFIER OPAREN interface_call_param_list CPAREN
+                      | IDENTIFIER OPAREN CPAREN
+                      | IDENTIFIER OPAREN interface_call_param_list CPAREN SEMI'''
+    # Allow spurious semi-colons at the end of interface calls
     i = refpolicy.InterfaceCall(ifname=p[1])
-
-    i.args.extend(p[3])
+    if len(p) > 4:
+        i.args.extend(p[3])
     p[0] = i
+
+def p_interface_call_param(p):
+    '''interface_call_param : IDENTIFIER
+                            | IDENTIFIER MINUS IDENTIFIER
+                            | nested_id_set
+                            | TRUE
+                            | FALSE
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
 
 def p_obj_perm_set(p):
     'obj_perm_set : DEFINE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK names SQUOTE CPAREN'
     s = refpolicy.ObjPermSet(p[4])
     s.perms = p[8]
     p[0] = s
-
+    
+#
 # Basic SELinux policy language
+#
 
 def p_policy(p):
     '''policy : policy_stmt
@@ -470,11 +463,29 @@ def p_policy_stmt(p):
                    | attribute_def
                    | range_transition_def
                    | role_transition_def
-    '''
-    p[0] = [p[1]]
+                   | bool
+                   | define
+                   | initial_sid
+                   | genfscon
+                   | fs_use
+                   | portcon
+                   | nodecon
+                   | netifcon
+    '''
+    if p[1]:
+        p[0] = [p[1]]
+
+def p_module_stmt(p):
+    'module_stmt : MODULE IDENTIFIER NUMBER SEMI'
+    m = refpolicy.ModuleDeclaration()
+    m.name = p[2]
+    m.version = p[3]
+    m.refpolicy = False
+    p[0] = m
 
 def p_gen_require(p):
-    'gen_require : GEN_REQ OPAREN TICK requires SQUOTE CPAREN'
+    '''gen_require : GEN_REQ OPAREN TICK requires SQUOTE CPAREN
+                   | REQUIRE OBRACE requires CBRACE'''
     # We ignore the require statements - they are redundant data from our point-of-view.
     # Checkmodule will verify them later anyway so we just assume that they match what
     # is in the rest of the interface.
@@ -497,6 +508,121 @@ def p_require(p):
     '''
     pass
 
+def p_security_context(p):
+    '''security_context : IDENTIFIER COLON IDENTIFIER COLON IDENTIFIER
+                        | IDENTIFIER COLON IDENTIFIER COLON IDENTIFIER COLON mls_range_def'''
+    # This will likely need some updates to handle complex levels
+    s = refpolicy.SecurityContext()
+    s.user = p[1]
+    s.role = p[3]
+    s.type = p[5]
+    if len(p) > 6:
+        s.level = p[7]
+
+    p[0] = s
+
+def p_gen_context(p):
+    '''gen_context : GEN_CONTEXT OPAREN security_context COMMA mls_range_def CPAREN
+    '''
+    # We actually store gen_context statements in a SecurityContext
+    # object - it knows how to output either a bare context or a
+    # gen_context statement.
+    s = p[3]
+    s.level = p[5]
+    
+    p[0] = s
+
+def p_context(p):
+    '''context : security_context
+               | gen_context
+    '''
+    p[0] = p[1]
+
+def p_initial_sid(p):
+    '''initial_sid : SID IDENTIFIER context'''
+    s = refpolicy.InitialSid()
+    s.name = p[2]
+    s.context = p[3]
+    p[0] = s
+
+def p_genfscon(p):
+    '''genfscon : GENFSCON IDENTIFIER PATH context'''
+    
+    g = refpolicy.GenfsCon()
+    g.filesystem = p[2]
+    g.path = p[3]
+    g.context = p[4]
+
+    p[0] = g
+
+def p_fs_use(p):
+    '''fs_use : FS_USE_XATTR IDENTIFIER context SEMI
+              | FS_USE_TASK IDENTIFIER context SEMI
+              | FS_USE_TRANS IDENTIFIER context SEMI
+    '''
+    f = refpolicy.FilesystemUse()
+    if p[1] == "fs_use_xattr":
+        f.type = refpolicy.FilesystemUse.XATTR
+    elif p[1] == "fs_use_task":
+        f.type = refpolicy.FilesystemUse.TASK
+    elif p[1] == "fs_use_trans":
+        f.type = refpolicy.FilesystemUse.TRANS
+
+    f.filesystem = p[2]
+    f.context = p[3]
+
+    p[0] = f
+
+def p_portcon(p):
+    '''portcon : PORTCON IDENTIFIER NUMBER context
+               | PORTCON IDENTIFIER NUMBER MINUS NUMBER context'''
+    c = refpolicy.PortCon()
+    c.port_type = p[2]
+    if len(p) == 5:
+        c.port_number = p[3]
+        c.context = p[4]
+    else:
+        c.port_number = p[3] + "-" + p[4]
+        c.context = p[5]
+
+    p[0] = c
+
+def p_nodecon(p):
+    '''nodecon : NODECON NUMBER NUMBER context
+               | NODECON IPV6_ADDR IPV6_ADDR context
+    '''
+    n = refpolicy.NodeCon()
+    n.start = p[2]
+    n.end = p[3]
+    n.context = p[4]
+
+    p[0] = n
+
+def p_netifcon(p):
+    'netifcon : NETIFCON IDENTIFIER context context'
+    n = refpolicy.NetifCon()
+    n.interface = p[2]
+    n.interface_context = p[3]
+    n.packet_context = p[4]
+
+    p[0] = n
+
+def p_mls_range_def(p):
+    '''mls_range_def : mls_level_def MINUS mls_level_def
+                     | mls_level_def
+    '''
+    p[0] = p[1]
+    if len(p) > 2:
+        p[0] = p[0] + "-" + p[3]
+
+def p_mls_level_def(p):
+    '''mls_level_def : IDENTIFIER COLON comma_list
+                     | IDENTIFIER
+    '''
+    p[0] = p[1]
+    if len(p) > 2:
+        p[0] = p[0] + ":" + ",".join(p[3])
+    
 def p_type_def(p):
     '''type_def : TYPE IDENTIFIER COMMA comma_list SEMI
                 | TYPE IDENTIFIER SEMI
@@ -528,10 +654,12 @@ def p_typealias_def(p):
     p[0] = t
 
 def p_role_def(p):
-    'role_def : ROLE IDENTIFIER TYPES comma_list SEMI'
+    '''role_def : ROLE IDENTIFIER TYPES comma_list SEMI
+                | ROLE IDENTIFIER SEMI'''
     r = refpolicy.Role()
     r.role = p[2]
-    r.types.update(p[4])
+    if len(p) > 4:
+        r.types.update(p[4])
     p[0] = r
 
 def p_role_allow(p):
@@ -545,12 +673,15 @@ def p_avrule_def(p):
     '''avrule_def : ALLOW names names COLON names names SEMI
                   | DONTAUDIT names names COLON names names SEMI
                   | AUDITALLOW names names COLON names names SEMI
+                  | NEVERALLOW names names COLON names names SEMI
     '''
     a = refpolicy.AVRule()
     if p[1] == 'dontaudit':
         a.rule_type = refpolicy.AVRule.DONTAUDIT
     elif p[1] == 'auditallow':
         a.rule_type = refpolicy.AVRule.AUDITALLOW
+    elif p[1] == 'neverallow':
+        a.rule_type = refpolicy.AVRule.NEVERALLOW
     a.src_types = p[2]
     a.tgt_types = p[3]
     a.obj_classes = p[5]
@@ -573,6 +704,17 @@ def p_typerule_def(p):
     t.dest_type = p[6]
     p[0] = t
 
+def p_bool(p):
+    '''bool : BOOL IDENTIFIER TRUE SEMI
+            | BOOL IDENTIFIER FALSE SEMI'''
+    b = refpolicy.Bool()
+    b.name = p[2]
+    if p[3] == "true":
+        b.state = True
+    else:
+        b.state = False
+    p[0] = b
+
 def p_conditional(p):
     ''' conditional : IF OPAREN cond_expr CPAREN OBRACE interface_stmts CBRACE
                     | IF OPAREN cond_expr CPAREN OBRACE interface_stmts CBRACE ELSE OBRACE interface_stmts CBRACE
@@ -591,18 +733,6 @@ def p_typeattribute_def(p):
     t.attributes.update(p[3])
     p[0] = t
 
-def p_mls_level_def(p):
-    '''mls_level_def : IDENTIFIER COLON comma_list
-                     | IDENTIFIER'''
-    pass
-
-def p_mls_range_def(p):
-    '''mls_range_def : mls_level_def MINUS mls_level_def
-                     | mls_level_def
-    '''
-    pass
-
-
 def p_range_transition_def(p):
     '''range_transition_def : RANGE_TRANSITION names names COLON names mls_range_def SEMI
                             | RANGE_TRANSITION names names names SEMI'''
@@ -611,6 +741,106 @@ def p_role_transition_def(p):
 def p_role_transition_def(p):
     '''role_transition_def : ROLE_TRANSITION names names names SEMI'''
     pass
+
+def p_cond_expr(p):
+    '''cond_expr : IDENTIFIER
+                 | EXPL cond_expr
+                 | cond_expr AMP AMP cond_expr
+                 | cond_expr BAR BAR cond_expr
+                 | cond_expr EQUAL EQUAL cond_expr
+                 | cond_expr EXPL EQUAL cond_expr
+    '''
+    l = len(p)
+    if l == 2:
+        p[0] = [p[1]]
+    elif l == 3:
+        p[0] = [p[1]] + p[2]
+    else:
+        p[0] = p[1] + [p[2] + p[3]] + p[4]
+
+
+#
+# Basic terminals
+#
+
+# Identifiers and lists of identifiers. These must
+# be handled somewhat gracefully. Names returns an IdSet and care must
+# be taken that this is _assigned_ to an object to correctly update
+# all of the flags (as opposed to using update). The other terminals
+# return list - this is to preserve ordering if it is important for
+# parsing (for example, interface_call must retain the ordering). Other
+# times the list should be used to update an IdSet.
+
+def p_names(p):
+    '''names : identifier
+             | nested_id_set
+             | asterisk
+             | TILDE identifier
+             | TILDE nested_id_set
+             | IDENTIFIER MINUS IDENTIFIER
+    '''
+    s = refpolicy.IdSet()
+    if len(p) < 3:
+        expand(p[1], s)
+    elif len(p) == 3:
+        expand(p[2], s)
+        s.compliment = True
+    else:
+        expand([p[1]])
+        s.add("-" + p[3])
+    p[0] = s
+
+def p_identifier(p):
+    'identifier : IDENTIFIER'
+    p[0] = [p[1]]
+
+def p_asterisk(p):
+    'asterisk : ASTERISK'
+    p[0] = [p[1]]
+
+def p_nested_id_set(p):
+    '''nested_id_set : OBRACE nested_id_list CBRACE
+    '''
+    p[0] = p[2]
+
+def p_nested_id_list(p):
+    '''nested_id_list : nested_id_element
+                      | nested_id_list nested_id_element
+    '''
+    if len(p) == 2:
+        p[0] = p[1]
+    else:
+        p[0] = p[1] + p[2]
+
+def p_nested_id_element(p):
+    '''nested_id_element : identifier
+                         | MINUS IDENTIFIER
+                         | nested_id_set
+    '''
+    if len(p) == 2:
+        p[0] = p[1]
+    else:
+        # For now just leave the '-'
+        str = "-" + p[2]
+        p[0] = [str]
+
+def p_comma_list(p):
+    '''comma_list : nested_id_list
+                  | comma_list COMMA nested_id_list
+    '''
+    if len(p) > 2:
+        p[1] = p[1] + p[3]
+    p[0] = p[1]
+
+def p_optional_semi(p):
+    '''optional_semi : SEMI
+                   | empty'''
+    pass
+
+
+#
+# Interface to the parser
+#
 
 def p_error(tok):
     global error
@@ -623,8 +853,6 @@ def prep_spt(spt):
     map = {}
     for x in spt:
         map[x.name] = x
-
-
 
 parser = None
 lexer = None
@@ -648,12 +876,13 @@ def parse(text, module=None, support=Non
     create_globals(module, support, debug)
     lexer.lexdata = []
     lexer.lexpos = 0
+    lexer.lineno = 1
 
     try:
         parser.parse(text, debug=debug)
     except Exception, e:
         global error
-        error = "internal parser error: %s" % str(e)
+        error = "internal parser error: %s" % str(e) + "\n" + traceback.format_exc()
 
     if error is not None:
         msg = 'could not parse text: "%s"' % error
@@ -733,7 +962,7 @@ def parse_headers(root, output=None, exp
         headers.children.append(spt)
 
         # FIXME: Total hack - add in can_exec rather than parse the insanity
-        # of misc_macros. We are just going to preten that this is an interface
+        # of misc_macros. We are just going to pretend that this is an interface
         # to make the expansion work correctly.
         can_exec = refpolicy.Interface("can_exec")
         av = access.AccessVector(["$1","$2","file","execute_no_trans","read",
diff -r c80a10119da1 -r 2a723e3216cb sepolgen/src/sepolgen/refpolicy.py
--- a/sepolgen/src/sepolgen/refpolicy.py	Mon Sep 03 12:16:26 2007 -0400
+++ b/sepolgen/src/sepolgen/refpolicy.py	Mon Sep 03 12:20:08 2007 -0400
@@ -49,7 +49,12 @@ str_to_field = { "source" : SRC_TYPE, "t
 
 # Base Classes
 
-class Node:
+class PolicyBase:
+    def __init__(self, parent=None):
+        self.parent = None
+        self.comment = None
+
+class Node(PolicyBase):
     """Base class objects produced from parsing the reference policy.
 
     The Node class is used as the base class for any non-leaf
@@ -67,9 +72,8 @@ class Node:
     """
 
     def __init__(self, parent=None):
-        self.parent = parent
+        PolicyBase.__init__(self, parent)
         self.children = []
-        self.comment = None
 
     def __iter__(self):
         return iter(self.children)
@@ -131,9 +135,9 @@ class Node:
         return ""
 
 
-class Leaf:
-    def __init__(self):
-        self.comment = None
+class Leaf(PolicyBase):
+    def __init__(self, parent=None):
+        PolicyBase.__init__(self, parent)
 
     def __str__(self):
         if self.comment:
@@ -244,14 +248,14 @@ class IdSet(set):
 
 class SecurityContext(Leaf):
     """An SELinux security context with optional MCS / MLS fields."""
-    def __init__(self, context=None):
+    def __init__(self, context=None, parent=None):
         """Create a SecurityContext object, optionally from a string.
 
         Parameters:
            [context] - string representing a security context. Same format
               as a string passed to the from_string method.
         """
-        Leaf.__init__(self)
+        Leaf.__init__(self, parent)
         self.user = ""
         self.role = ""
         self.type = ""
@@ -314,7 +318,7 @@ class SecurityContext(Leaf):
             fields.append(self.level)
         return ":".join(fields)
 
-class ObjectClass:
+class ObjectClass(Leaf):
     """SELinux object class and permissions.
 
     This class is a basic representation of an SELinux object
@@ -322,7 +326,8 @@ class ObjectClass:
     just the union of the common and class specific permissions.
     It is meant to be convenient for policy generation.
     """
-    def __init__(self, name=""):
+    def __init__(self, name="", parent=None):
+        Leaf.__init__(self, parent)
         self.name = name
         self.perms = IdSet()
 
@@ -333,8 +338,8 @@ class TypeAttribute(Leaf):
 
     This class represents a typeattribute statement.
     """
-    def __init__(self):
-        Leaf.__init__(self)
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
         self.type = ""
         self.attributes = IdSet()
 
@@ -342,8 +347,8 @@ class TypeAttribute(Leaf):
         return "typeattribute %s %s;" % (self.type, self.attributes.to_comma_str())
 
 class Role(Leaf):
-    def __init__(self):
-        Leaf.__init__(self)
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
         self.role = ""
         self.types = IdSet()
 
@@ -351,8 +356,8 @@ class Role(Leaf):
         return "role %s types %s;" % (self.role, self.types.to_comma_str())
 
 class Type(Leaf):
-    def __init__(self, name=""):
-        Leaf.__init__(self)
+    def __init__(self, name="", parent=None):
+        Leaf.__init__(self, parent)
         self.name = name
         self.attributes = IdSet()
         self.aliases = IdSet()
@@ -366,8 +371,8 @@ class Type(Leaf):
         return s + ";"
 
 class TypeAlias(Leaf):
-    def __init__(self):
-        Leaf.__init__(self)
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
         self.type = ""
         self.aliases = IdSet()
 
@@ -375,8 +380,8 @@ class TypeAlias(Leaf):
         return "typealias %s alias %s;" % (self.type, self.aliases.to_space_str())
 
 class Attribute(Leaf):
-    def __init__(self, name=""):
-        Leaf.__init__(self)
+    def __init__(self, name="", parent=None):
+        Leaf.__init__(self, parent)
         self.name = name
 
     def to_string(self):
@@ -403,9 +408,10 @@ class AVRule(Leaf):
     ALLOW = 0
     DONTAUDIT = 1
     AUDITALLOW = 2
-
-    def __init__(self, av=None):
-        Leaf.__init__(self)
+    NEVERALLOW = 3
+
+    def __init__(self, av=None, parent=None):
+        Leaf.__init__(self, parent)
         self.src_types = IdSet()
         self.tgt_types = IdSet()
         self.obj_classes = IdSet()
@@ -455,8 +461,8 @@ class TypeRule(Leaf):
     TYPE_CHANGE = 1
     TYPE_MEMBER = 2
 
-    def __init__(self):
-        Leaf.__init__(self)
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
         self.src_types = IdSet()
         self.tgt_types = IdSet()
         self.obj_classes = IdSet()
@@ -479,8 +485,8 @@ class TypeRule(Leaf):
                                      self.dest_type)
 
 class RoleAllow(Leaf):
-    def __init__(self):
-        Leaf.__init__(self)
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
         self.src_roles = IdSet()
         self.tgt_roles = IdSet()
 
@@ -489,8 +495,8 @@ class RoleAllow(Leaf):
                                  self.tgt_roles.to_comma_str())
 
 class ModuleDeclaration(Leaf):
-    def __init__(self):
-        Leaf.__init__(self)
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
         self.name = ""
         self.version = ""
         self.refpolicy = False
@@ -501,7 +507,98 @@ class ModuleDeclaration(Leaf):
         else:
             return "module %s %s;" % (self.name, self.version)
 
-
+class Conditional(Node):
+    def __init__(self, parent=None):
+        Node.__init__(self, parent)
+        self.cond_expr = []
+
+    def to_string(self):
+        return "[If %s]" % list_to_space_str(self.cond_expr, cont=("", ""))
+
+class Bool(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.name = ""
+        self.state = False
+
+    def to_string(self):
+        s = "bool %s " % self.name
+        if s.state:
+            return s + "true"
+        else:
+            return s + "false"
+
+class InitialSid(Leaf):
+    def __init(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.name = ""
+        self.context = None
+
+    def to_string(self):
+        return "sid %s %s" % (self.name, str(self.context))
+
+class GenfsCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.filesystem = ""
+        self.path = ""
+        self.context = None
+
+    def to_string(self):
+        return "genfscon %s %s %s" % (self.filesystem, self.path, str(self.context))
+
+class FilesystemUse(Leaf):
+    XATTR = 1
+    TRANS = 2
+    TASK = 3
+    
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.type = self.XATTR
+        self.filesystem = ""
+        self.context = None
+
+    def to_string(self):
+        s = ""
+        if self.type == XATTR:
+            s = "fs_use_xattr "
+        elif self.type == TRANS:
+            s = "fs_use_trans "
+        elif self.type == TASK:
+            s = "fs_use_task "
+
+        return "%s %s %s;" % (s, self.filesystem, str(self.context))
+
+class PortCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.port_type = ""
+        self.port_number = ""
+        self.context = None
+
+    def to_string(self):
+        return "portcon %s %s %s" % (self.port_type, self.port_number, str(self.context))
+
+class NodeCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.start = ""
+        self.end = ""
+        self.context = None
+
+    def to_string(self):
+        return "nodecon %s %s %s" % (self.start, self.end, str(self.context))
+
+class NetifCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.interface = ""
+        self.interface_context = None
+        self.packet_context = None
+
+    def to_string(self):
+        return "netifcon %s %s %s" % (self.interface, str(self.interface_context),
+                                   str(self.packet_context))
 
 # Reference policy specific types
 
@@ -564,17 +661,9 @@ class IfDef(Node):
     def to_string(self):
         return "[Ifdef name: %s]" % self.name
 
-class Conditional(Node):
-    def __init__(self, parent=None):
-        Node.__init__(self, parent)
-        self.cond_expr = []
-
-    def to_string(self):
-        return "[If %s]" % list_to_space_str(self.cond_expr, cont=("", ""))
-
 class InterfaceCall(Leaf):
-    def __init__(self, ifname=""):
-        Leaf.__init__(self)
+    def __init__(self, ifname="", parent=None):
+        Leaf.__init__(self, parent)
         self.ifname = ifname
         self.args = []
         self.comments = []
@@ -651,8 +740,8 @@ class SupportMacros(Node):
         return self.map.has_key(name)
 
 class Require(Leaf):
-    def __init__(self):
-        Leaf.__init__(self)
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
         self.types = IdSet()
         self.obj_classes = { }
         self.roles = IdSet()

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
