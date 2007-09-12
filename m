Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8CFoK88004510
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 11:50:20 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8CFoGsM013553
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 15:50:16 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8CFoDtf015973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 11:50:13 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8CFoB0b011996
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 11:50:11 -0400
Received: from [10.11.14.174] (vpn-14-174.rdu.redhat.com [10.11.14.174])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8CFo97o017207
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 11:50:11 -0400
Subject: Type / attribute require ambiguity
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-rGnBFKBZuV7um9IkgvXs"
Date: Wed, 12 Sep 2007 11:50:04 -0400
Message-Id: <1189612204.4270.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-rGnBFKBZuV7um9IkgvXs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm almost done with patches to allow sepolgen to update require blocks
in module policy (see attached patch). In the process of testing this as
part of the refpolicy build process I ran into a problem.

It is often unclear whether an identifier is referencing a type or
attribute. Take the following example:

typeattribute foo bar;
allow domain bar : file write;
allow foo baz : file read;

Here it can be determined that foo must be a type and bar must be an
attribute, but there is not enough information to determine which domain
or baz is. Unfortunately, simply requiring domain as a type yields the
following at link time:

libsepol.type_copy_callback: foo: Expected domain to be a type, but it
was already declared as an attribute.
libsemanage.semanage_link_sandbox: Link packages failed
/usr/sbin/semodule:  Failed!

Any thoughts on making the linker 'upgrade' types to attributes so that
ambiguous identifiers can always be required as types? Otherwise
automatically generating requires will never work.

Karl

--=-rGnBFKBZuV7um9IkgvXs
Content-Disposition: attachment; filename=update-tool.patch
Content-Type: text/x-patch; name=update-tool.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r d0c7526b7795 sepolgen/src/Makefile
--- a/sepolgen/src/Makefile	Mon Sep 10 10:30:35 2007 -0400
+++ b/sepolgen/src/Makefile	Mon Sep 10 10:30:36 2007 -0400
@@ -2,12 +2,14 @@ all: ;
 
 install:
 	$(MAKE) -C sepolgen $@
+	$(MAKE) -C tools $@
 	$(MAKE) -C share $@
 
 relabel: ;
 
 clean:
 	$(MAKE) -C sepolgen $@
+	$(MAKE) -C tools $@
 	$(MAKE) -C share $@
 	rm -f *~ *.pyc
 	rm -f parser.out parsetab.py
diff -r d0c7526b7795 sepolgen/src/sepolgen/defaults.py
--- a/sepolgen/src/sepolgen/defaults.py	Mon Sep 10 10:30:35 2007 -0400
+++ b/sepolgen/src/sepolgen/defaults.py	Mon Sep 10 10:30:36 2007 -0400
@@ -24,6 +24,9 @@ def data_dir():
 def data_dir():
     return "/var/lib/sepolgen"
 
+def tools():
+    return data_dir() + "/tools"
+
 def perm_map():
     return data_dir() + "/perm_map"
 
diff -r d0c7526b7795 sepolgen/src/sepolgen/output.py
--- a/sepolgen/src/sepolgen/output.py	Mon Sep 10 10:30:35 2007 -0400
+++ b/sepolgen/src/sepolgen/output.py	Mon Sep 10 10:30:36 2007 -0400
@@ -43,9 +43,7 @@ class ModuleWriter:
         if self.sort:
             sort_filter(self.module)
 
-        # FIXME - make this handle nesting
-        for node, depth in refpolicy.walktree(self.module, showdepth=True):
-            fd.write("%s\n" % str(node))
+        refpolicy.write_tree(module, fd)
 
 # Helper functions for sort_filter - this is all done old school
 # C style rather than with polymorphic methods because this sorting
@@ -110,8 +108,9 @@ def sort_filter(module):
 
         # Module statement
         mod = node.module_declaration()
-        c.append(mod)
-        c.append(refpolicy.Comment())
+        if mod:
+            c.append(mod)
+            c.append(refpolicy.Comment())
 
         # Requires
         for require in refpolicy.requires(node):
@@ -153,7 +152,7 @@ def sort_filter(module):
 
         node.children = c
 
-    for node in refpolicy.nodes(module):
+    for node in refpolicy.walktree(module, type=refpolicy.Node):
         sort_node(node)
 
 
diff -r d0c7526b7795 sepolgen/src/sepolgen/policygen.py
--- a/sepolgen/src/sepolgen/policygen.py	Mon Sep 10 10:30:35 2007 -0400
+++ b/sepolgen/src/sepolgen/policygen.py	Wed Sep 12 11:02:04 2007 -0400
@@ -149,7 +149,7 @@ class PolicyGenerator:
     def optimize_module(self):
         for node in nodes(walktree(self.module)):
             #reduce_ifcalls(node)
-            reduce_rules(node)
+            #reduce_rules(node)
             update_requires(node)
         
 
@@ -340,63 +340,83 @@ class InterfaceGenerator:
 
         return raw_av
 
-
-def set_single_requires(node):
-    first = True
+def merge_require_blocks(requires):
+    assert(len(requires) > 1)
+
+    r = requires[0]
+
+    for i in range(1, len(requires)):
+        r.types.update(requires[i].types)
+        r.obj_classes.update(requires[i].obj_classes)
+        r.roles.update(requires[i].roles)
+        r.bools.update(requires[i].bools)
+        r.users.update(requires[i].users)
+
+    return r
+
+def set_single_require_block(node):
     children = []
-    r = None
+    requires = []
     for x in node.children:
-        if not isinstance(x, Require):
+        if isinstance(x, Require):
+            requires.append(x)
+        else:
             children.append(x)
-        if first:
-            r = x
-            first = False
-
-    if not r:
+
+
+    if len(requires) == 0:
         r = Require()
-        children.insert(0, r)
+    elif len(requires) == 1:
+        r = requires[0]
+    else:
+        r = merge_require_blocks(requires)
+        
+    children.insert(0, r)
     node.children = children
+    
     return r
     
 
-def update_requires(node, single_requires=False):
+def update_requires(node):
     """Add require statements for a module.
     """
-    # Get a require block
-    if not single_requires:
-        r = first(requires(node))
-        if not r:
-            r = Require()
-            node.children.insert(0, r)
-    else:
-        r = set_single_requires(node)
-
-    # Find declared types, attributes, roles
-    types = declared_types(node)
-    attrs = declared_attributes(node)
-
-    # Update
-    for avrule in avrules(node):
-        r.types.update(avrule.src_types)
-        r.types.update(avrule.tgt_types)
-        for obj in avrule.obj_classes:
-            r.add_obj_class(obj, avrule.perms)
-            
-    for ifcall in interface_calls(node):
-        for arg in ifcall.args:
-            # FIXME - handle non-type arguments when we
-            # can actually figure those out.
-            r.types.add(arg)
-
-    for typerule in typerules(node):
-        r.types.update(typerule.src_types)
-        r.types.update(typerule.tgt_types)
-        r.types.add(typerule.dest_type)
-        for obj in typerule.obj_classes:
-            r.add_obj_class(obj)
-
-    node.children.insert(0, r)
-
+    r = set_single_require_block(node)
+    declared = Require()
+
+    for s in walknode(node):
+        # Collect the referenced identifiers
+        r.types.update(s.referenced_types())
+        r.attributes.update(s.referenced_attributes())
+        for obj, perms in s.referenced_obj_classes().iteritems():
+            r.add_obj_class(obj, perms)
+        r.roles.update(s.referenced_roles())
+        r.booleans.update(s.referenced_booleans())
+        r.users.update(s.referenced_users())
+        r.sensitivities.update(s.referenced_sensitivities())
+        r.categories.update(s.referenced_categories())
+
+        # Collect the declared identifiers
+        declared.types.update(s.declared_types())
+        declared.attributes.update(s.declared_attributes())
+        for obj, perms in s.declared_obj_classes().iteritems():
+            declared.add_obj_class(obj, perms)
+        declared.roles.update(s.declared_roles())
+        declared.booleans.update(s.declared_booleans())
+        declared.users.update(s.declared_users())
+        declared.sensitivities.update(s.declared_sensitivities())
+        declared.categories.update(s.declared_categories())
+
+    # Store the difference
+    r.types = r.types.difference(declared.types)
+    r.attributes = r.attributes.difference(declared.attributes)
+    r.obj_classes = idset_dict_difference(r.obj_classes, declared.obj_classes)
+    r.roles = r.roles.difference(declared.roles)
+    r.booleans = r.booleans.difference(declared.booleans)
+    r.users = r.users.difference(declared.users)
+    r.sensitivities = r.sensitivities.difference(declared.sensitivities)
+    r.categories = r.categories.difference(declared.categories)
+
+    
 def reduce_ifcalls(self, ifcalls):
     out_ifcalls = []
     for ifcall, match_list in ifcalls:
diff -r d0c7526b7795 sepolgen/src/sepolgen/refparser.py
--- a/sepolgen/src/sepolgen/refparser.py	Mon Sep 10 10:30:35 2007 -0400
+++ b/sepolgen/src/sepolgen/refparser.py	Wed Sep 12 11:04:02 2007 -0400
@@ -86,6 +86,9 @@ tokens = (
     'NETIFCON',
     #   object classes
     'CLASS',
+    #   MLS
+    'SENSITIVITY',
+    'CATEGORY',
     #   types and attributes
     'TYPEATTRIBUTE',
     'TYPE',
@@ -143,6 +146,9 @@ reserved = {
     'netifcon' : 'NETIFCON',
     # object classes
     'class' : 'CLASS',
+    # mls
+    'sensitivity' : 'SENSITIVITY',
+    'category' : 'CATEGORY',
     # types and attributes
     'typeattribute' : 'TYPEATTRIBUTE',
     'type' : 'TYPE',
@@ -353,34 +359,40 @@ def p_interface_stmts(p):
                        | empty
     '''
     if len(p) == 2 and p[1]:
-        p[0] = p[1]
+        p[0] = [p[1]]
     elif len(p) > 2:
         if not p[1]:
-            if p[2]:
-                p[0] = p[2]
-        elif not p[2]:
-            p[0] = p[1]
+            p[0] = [p[2]]
         else:
-            p[0] = p[1] + p[2]
+            p[0] = p[1] + [p[2]]
 
 def p_optional_policy(p):
     '''optional_policy : OPT_POLICY OPAREN TICK interface_stmts SQUOTE CPAREN
                        | OPT_POLICY OPAREN TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN
     '''
     o = refpolicy.OptionalPolicy()
-    collect(p[4], o, val=True)
+    b = refpolicy.OptionalPolicyBlock()
+    collect(p[4], b)
+    o.children.append(b)
     if len(p) > 7:
-        collect(p[8], o, val=False)
-    p[0] = [o]
+        b = refpolicy.OptionalPolicyBlock()
+        collect(p[8], b)
+        o.children.append(b)
+    p[0] = o
 
 def p_optional(p):
     '''optional : OPTIONAL OBRACE interface_stmts CBRACE
                 | OPTIONAL OBRACE interface_stmts CBRACE ELSE OBRACE interface_stmts CBRACE
     '''
-    o = refpolicy.OptionalPolicy()
-    collect(p[3], o, val=True)
+    o = refpolicy.Optional()
+    b = refpolicy.OptionalBlock()
+    collect(p[3], b)
+    o.children.append(b)
     if len(p) > 5:
-        collect(p[7], o, val=False)
+        b = refpolicy.OptionalBlock()
+        b.is_else = True
+        collect(p[7], b)
+        o.children.append(b)
     p[0] = o
 
 def p_tunable_policy(p):
@@ -388,26 +400,37 @@ def p_tunable_policy(p):
                       | TUNABLE_POLICY OPAREN TICK cond_expr SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN
     '''
     x = refpolicy.TunablePolicy()
-    x.cond_expr = p[4]
-    collect(p[8], x, val=True)
+    b = refpolicy.TunableBlock()
+    b.cond_expr = p[4]
+    collect(p[8], b)
+    x.children.append(b)
     if len(p) > 11:
-        collect(p[12], x, val=False)
-    p[0] = [x]
+        b = refpolicy.TunableBlock()
+        b.is_else = True
+        collect(p[12], b)
+        x.children.append(b)
+    p[0] = x
 
 def p_ifdef(p):
     '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
              | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
              | IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
     '''
-    x = refpolicy.IfDef(p[4])
+    x = refpolicy.IfDef()
+    b = refpolicy.IfDefBlock()
+    b.name = p[4]
     if p[1] == 'ifdef':
-        v = True
-    else:
-        v = False
-    collect(p[8], x, val=v)
+        b.ifdef = True
+    else:
+        b.ifdef = False
+    collect(p[8], b)
+    x.children.append(b)
     if len(p) > 12:
-        collect(p[12], x, val=False)
-    p[0] = [x]
+        b = refpolicy.IfDefBlock()
+        b.is_else = True
+        collect(p[12], b)
+        x.children.append(b)
+    p[0] = x
 
 def p_interface_call(p):
     '''interface_call : IDENTIFIER OPAREN interface_call_param_list CPAREN
@@ -486,7 +509,7 @@ def p_policy_stmt(p):
                    | netifcon
     '''
     if p[1]:
-        p[0] = [p[1]]
+        p[0] = p[1]
 
 def p_module_stmt(p):
     'module_stmt : MODULE IDENTIFIER NUMBER SEMI'
@@ -518,6 +541,8 @@ def p_require(p):
                | ATTRIBUTE comma_list SEMI
                | CLASS comma_list SEMI
                | BOOL comma_list SEMI
+               | SENSITIVITY comma_list SEMI
+               | CATEGORY comma_list SEMI
     '''
     pass
 
@@ -733,12 +758,17 @@ def p_conditional(p):
                     | IF OPAREN cond_expr CPAREN OBRACE interface_stmts CBRACE ELSE OBRACE interface_stmts CBRACE
     '''
     c = refpolicy.Conditional()
-    c.cond_expr = p[3]
-    collect(p[6], c, val=True)
+    b = refpolicy.ConditionalBlock()
+    b.cond_expr = p[3]
+    collect(p[6], b)
+    c.children.append(b)
     if len(p) > 8:
-        collect(p[10], c, val=False)
-    p[0] = [c]
-
+        b = refpolicy.ConditionalBlock()
+        b.is_else = True
+        collect(p[10], b)
+        c.children.append(b)
+    p[0] = c
+    
 def p_typeattribute_def(p):
     '''typeattribute_def : TYPEATTRIBUTE IDENTIFIER comma_list SEMI'''
     t = refpolicy.TypeAttribute()
@@ -752,8 +782,12 @@ def p_range_transition_def(p):
     pass
 
 def p_role_transition_def(p):
-    '''role_transition_def : ROLE_TRANSITION names names names SEMI'''
-    pass
+    '''role_transition_def : ROLE_TRANSITION names names IDENTIFIER SEMI'''
+    r = refpolicy.RoleTransition()
+    r.src_roles = p[2]
+    r.tgt_roles = p[3]
+    r.tgt_types = p[4]
+    p[0] = r
 
 def p_cond_expr(p):
     '''cond_expr : IDENTIFIER
diff -r d0c7526b7795 sepolgen/src/sepolgen/refpolicy.py
--- a/sepolgen/src/sepolgen/refpolicy.py	Mon Sep 10 10:30:35 2007 -0400
+++ b/sepolgen/src/sepolgen/refpolicy.py	Wed Sep 12 11:05:54 2007 -0400
@@ -19,6 +19,7 @@
 
 import string
 import itertools
+import sys
 
 # OVERVIEW
 #
@@ -54,6 +55,70 @@ class PolicyBase:
         self.parent = None
         self.comment = None
 
+    def __str__(self):
+        if self.comment:
+            return str(self.comment) + "\n" + self.to_string()
+        else:
+            return self.to_string()
+
+    def __repr__(self):
+        return "<%s(%s)>" % (self.__class__.__name__, self.to_string())
+
+    def to_string(self):
+        return ""
+
+    def declared_types(self):
+        return IdSet()
+
+    def declared_attributes(self):
+        return IdSet()
+
+    def declared_roles(self):
+        return IdSet()
+
+    def declared_users(self):
+        return IdSet()
+
+    def declared_sensitivities(self):
+        return IdSet()
+
+    def declared_categories(self):
+        return IdSet()
+
+    def declared_obj_classes(self):
+        return { }
+
+    def declared_booleans(self):
+        return IdSet()
+
+    def declared_sids(self):
+        return IdSet()
+
+    def referenced_types(self):
+        return IdSet()
+
+    def referenced_attributes(self):
+        return IdSet()
+
+    def referenced_roles(self):
+        return IdSet()
+
+    def referenced_users(self):
+        return IdSet()
+
+    def referenced_sensitivities(self):
+        return IdSet()
+
+    def referenced_categories(self):
+        return IdSet()
+
+    def referenced_obj_classes(self):
+        return { }
+
+    def referenced_booleans(self):
+        return IdSet()
+
+
 class Node(PolicyBase):
     """Base class objects produced from parsing the reference policy.
 
@@ -74,6 +139,8 @@ class Node(PolicyBase):
     def __init__(self, parent=None):
         PolicyBase.__init__(self, parent)
         self.children = []
+        self.has_close = False
+        self.is_invisible = False
 
     def __iter__(self):
         return iter(self.children)
@@ -90,36 +157,80 @@ class Node(PolicyBase):
                 return x
         return None
 
-
-    def __str__(self):
-        if self.comment:
-            return str(self.comment) + "\n" + self.to_string()
-        else:
-            return self.to_string()
-
-    def __repr__(self):
-        return "<%s(%s)>" % (self.__class__.__name__, self.to_string())
-
-    def to_string(self):
+    def to_string_close(self):
         return ""
 
-
 class Leaf(PolicyBase):
     def __init__(self, parent=None):
         PolicyBase.__init__(self, parent)
 
-    def __str__(self):
-        if self.comment:
-            return str(self.comment) + "\n" + self.to_string()
-        else:
-            return self.to_string()
-
-    def __repr__(self):
-        return "<%s(%s)>" % (self.__class__.__name__, self.to_string())
-
-    def to_string(self):
-        return ""
-
+class IdSet(set):
+    def __init__(self, list=None):
+        if list:
+            set.__init__(self, list)
+        else:
+            set.__init__(self)
+        self.compliment = False
+
+    def to_space_str(self):
+        return list_to_space_str(self)
+
+    def to_comma_str(self):
+        return list_to_comma_str(self)
+
+def idset_dict_difference(a, b):
+    """Take the difference of a dict of IdSets.
+
+    Dicts of IdSets can be used to, for example, represent
+    object classes and permissions. Consider these object
+    classes:
+       file { read write };
+       socket { send receive };
+    These could be represented like:
+       { 'file' : IdSet(['read', 'write']),
+         'socket' : IdSet(['send', 'receive']) }
+
+    This representation is convenient but it makes performing
+    set operations, like difference, difficult. Given another
+    dict of IdSets, say containing this object class:
+       file { write };
+    This function would return:
+       { 'file' : IdSet(['read']),
+         'socket' : IdSet(['send', 'receive']) }
+
+    However, given:
+       file { read write };
+       link { read };
+    The function would return:
+       { 'socket' : IdSet(['send', 'receive'])
+         'link' : IdSet(['read']) }
+       
+    In other words, if the difference of the IdSet is empty then the
+    mapping will be removed, otherwise it will be retained with the
+    difference set.
+    """
+
+    out = { }
+
+    a_keyset = IdSet(a.iterkeys())
+    b_keyset = IdSet(b.iterkeys())
+
+    # Anything unique to a or b is copied over directly
+    for key in b_keyset.difference(a_keyset):
+        out[key] = b[key].copy()
+    for key in a_keyset.difference(b_keyset):
+        out[key] = a[key].copy()
+
+    # Handle the intersecting keys
+    for key in a_keyset.intersection(b_keyset):
+        diff = a[key].difference(b[key])
+        # If there is a difference place that in the output
+        # otherwise do not set this key in the output
+        if len(diff):
+            out[key] = diff
+
+    return out
+    
 # Utility functions
 
 def nodes(iter):
@@ -162,75 +273,17 @@ def roles(iter):
 def roles(iter):
     return itertools.ifilter(lambda x: isinstance(x, Role), iter)
 
+def roleallows(iter):
+    return itertools.ifilter(lambda x: isinstance(x, RoleAllow))
+
+def roletransitions(iter):
+    return itertools.ifilter(lambda x: isinstance(x, RoleTransition))
+
 def requires(iter):
-        return itertools.ifilter(lambda x: isinstance(x, Require), iter)
-
-def declared_types(iter):
-    """Find type declarations in a sequence of policy components.
-    This function takes an iterator over a policy tree or part
-    of a policy tree and returns a set containing all of the
-    declared types. This includes all type declarations and
-    aliases.
-
-    This function only returns new identifiers declared in the scope
-    represented by the passed in iterator. That means, for example,
-    that a typealias declaration will only add add aliases not a
-    type. For example:
-
-    typealias foo alias bar;
-
-    Would add the identifier bar but not the identifier foo. The
-    added identifiers come from:
-      * type declarations (the type or aliases)
-      * type aliases (only the aliases)
-
-    Paramaters:
-       iter: iterator over a policy tree.
-
-    Returns:
-       set: set with all of the declared type names and aliases.
-    """
-    x = IdSet()
-    for type in types(iter):
-        x.add(type.name)
-        x.update(x.aliases)
-
-    for alias in typealias(iter):
-       x.update(alias.aliases)
-
-    return x
-
-def declared_attributes(iter):
-    """Find attribute declarations in a sequence of policy components.
-    This function takes an iterator over a policy tree or part
-    of a policy tree and returns a set containing all of the
-    declared attributes.
-
-    This function only returns new identifiers declared in the scope
-    represented by the passed in iterator. That means, for example,
-    that a typeattribute statement will not add an attribute.
-
-    Paramaters:
-       iter: iterator over a policy tree.
-
-    Returns:
-       set: set with all of the declared type names and aliases.
-    """
-    x = IdSet()
-
-    for attr in attributes(iters):
-        x.add(attr.name)
-
-    return x
-
-def first(iter):
-    """
-    Return the first element from a sequence. This is useful with the
-    iter filters above for returning the first element in a list
-    or tree of refpolicy objects.
-    """
-    for x in iter:
-        return x
+    return itertools.ifilter(lambda x: isinstance(x, Require), iter)
+
+def obj_classes(iter):
+    return  itertools.ifilter(lambda x: isinstance(x, ObjClass), iter)
 
 def walktree(node, depthfirst=True, showdepth=False, type=None):
     """Iterate over a Node and its Children.
@@ -269,6 +322,54 @@ def walktree(node, depthfirst=True, show
                 i -= 1
 
             stack.extend(items)
+
+def __walktree_hybrid(node):
+    # Special walktree for printing (see print_tree below)
+    stack = [(node, 0, False)]
+
+    while len(stack) > 0:
+        cur, depth, seen = stack.pop(-1)
+        yield cur, depth, seen
+
+        if isinstance(cur, Node):
+            if seen is False:
+                stack.append((cur, depth, True))
+            else:
+                continue
+            
+            items = []
+            if cur.is_invisible:
+                new_depth = depth
+            else:
+                new_depth = depth + 1
+            i = len(cur.children) - 1
+            while i >= 0:
+                items.append((cur.children[i], new_depth, False))
+                i -= 1
+
+            stack.extend(items)
+
+def print_tree(head, debug=False):
+    write_tree(head, sys.stdout, debug)
+    
+def write_tree(head, fd, debug=False):
+    for node, depth, seen in __walktree_hybrid(head):
+        if isinstance(node, Node):
+            if node.is_invisible:
+                continue
+        s = ""
+
+        if not seen:
+            # this is a hack - handle multi-line string
+            # indentiation
+            ns = str(node).split("\n")
+            for x in ns:
+                s = s + ("\t" * depth) + x + "\n"
+        elif node.has_close:
+            s = s + ("\t" * depth) + node.to_string_close() + "\n"
+        if debug:
+            s = s + " [%s]" % node.__class__
+        fd.write(s)
 
 def walknode(node, type=None):
     """Iterate over the direct children of a Node.
@@ -309,19 +410,49 @@ def list_to_comma_str(s):
 
 # Basic SELinux types
 
-class IdSet(set):
-    def __init__(self, list=None):
-        if list:
-            set.__init__(self, list)
-        else:
-            set.__init__(self)
-        self.compliment = False
-
-    def to_space_str(self):
-        return list_to_space_str(self)
-
-    def to_comma_str(self):
-        return list_to_comma_str(self)
+def level_to_sens(level):
+    """Return the sensitivity referenced in a level.
+
+    Given a string representing a level separate out the
+    sensitivity and return that string. For example, the
+    level:
+
+       secret:c0-c5,c7
+    
+    would return "secret".
+    """
+    return level.split(":")[0]
+
+def level_to_categories(level):
+    """Return the categories refrenced in a level.
+
+    Given a string representing a level separate out
+    the categories and return a list of strings with
+    each list item representing a categories. For example,
+    the level:
+
+       secret:c0-c5,c7
+    
+    would return ["c0", "c5", "c7"].
+
+    WARNING: this function is purely syntactic, so category
+    ranges are not properly expanded (that would require
+    knowing all of the declared categories and their ordering).
+    This function simply returns every category directly referenced.
+
+    Since not all levels have categories, it is possible for this
+    function to return an empty list.
+    """
+    s = level.split(":")
+    if len(s) > 1:
+        sens = s[1].split(",")
+        out = IdSet()
+        for sen in sens:
+            # Handle ranges
+            out.update(sen.split("-"))
+        return out
+    else:
+        return IdSet()
 
 class SecurityContext(Leaf):
     """An SELinux security context with optional MCS / MLS fields."""
@@ -395,6 +526,21 @@ class SecurityContext(Leaf):
             fields.append(self.level)
         return ":".join(fields)
 
+    def referenced_types(self):
+        return IdSet([self.type])
+
+    def referenced_roles(self):
+        return IdSet([self.role])
+
+    def referenced_users(self):
+        return IdSet([self.user])
+
+    def referenced_sens(self):
+        return IdSet([level_to_sens(self.level)])
+
+    def referenced_categories(self):
+        return level_to_categories(self.level)
+
 class ObjectClass(Leaf):
     """SELinux object class and permissions.
 
@@ -408,6 +554,9 @@ class ObjectClass(Leaf):
         self.name = name
         self.perms = IdSet()
 
+    def declared_obj_classes(self):
+        return { self.name : self.perms.copy() }
+
 
 class Role(Leaf):
     def __init__(self, parent=None):
@@ -417,6 +566,12 @@ class Role(Leaf):
 
     def to_string(self):
         return "role %s types %s;" % (self.role, self.types.to_comma_str())
+
+    def declared_roles(self):
+        return IdSet([self.role])
+
+    def referenced_types(self):
+        return self.types.copy()
 
 class Type(Leaf):
     def __init__(self, name="", parent=None):
@@ -433,6 +588,14 @@ class Type(Leaf):
             s = s + ", %s" % self.attributes.to_comma_str()
         return s + ";"
 
+    def declared_types(self):
+        x = self.aliases.copy()
+        x.add(self.name)
+        return x
+
+    def referenced_attributes(self):
+        return self.attributes.copy()
+
 # Basic statements
 
 class TypeAttribute(Leaf):
@@ -448,6 +611,12 @@ class TypeAttribute(Leaf):
     def to_string(self):
         return "typeattribute %s %s;" % (self.type, self.attributes.to_comma_str())
 
+    def referenced_types(self):
+        return IdSet([self.type])
+
+    def referenced_attributes(self):
+        return self.attributes.copy()
+
 class TypeAlias(Leaf):
     def __init__(self, parent=None):
         Leaf.__init__(self, parent)
@@ -457,6 +626,12 @@ class TypeAlias(Leaf):
     def to_string(self):
         return "typealias %s alias %s;" % (self.type, self.aliases.to_space_str())
 
+    def referenced_types(self):
+        return IdSet([self.type])
+
+    def declared_types(self):
+        return self.aliases.copy()
+
 class Attribute(Leaf):
     def __init__(self, name="", parent=None):
         Leaf.__init__(self, parent)
@@ -464,6 +639,9 @@ class Attribute(Leaf):
 
     def to_string(self):
         return "attribute %s;" % self.name
+
+    def declared_attributes(self):
+        return IdSet([self.name])
 
 # Classes representing rules
 
@@ -528,6 +706,19 @@ class AVRule(Leaf):
                                      self.tgt_types.to_space_str(),
                                      self.obj_classes.to_space_str(),
                                      self.perms.to_space_str())
+
+    def referenced_types(self):
+        x = self.src_types.copy()
+        x.update(self.tgt_types)
+        return x
+
+    def referenced_obj_classes(self):
+        x = {}
+        for obj in self.obj_classes:
+            x[obj] = self.perms.copy()
+
+        return x
+        
 class TypeRule(Leaf):
     """SELinux type rules.
 
@@ -562,6 +753,20 @@ class TypeRule(Leaf):
                                      self.obj_classes.to_space_str(),
                                      self.dest_type)
 
+    def referenced_types(self):
+        x = self.src_types.copy()
+        x.update(self.tgt_types)
+        x.add(self.dest_type)
+        return x
+
+    def referenced_obj_classes(self):
+        x = {}
+        for obj in self.obj_classes:
+            x[obj] = IdSet()
+
+        return x
+        
+
 class RoleAllow(Leaf):
     def __init__(self, parent=None):
         Leaf.__init__(self, parent)
@@ -571,6 +776,31 @@ class RoleAllow(Leaf):
     def to_string(self):
         return "allow %s %s;" % (self.src_roles.to_comma_str(),
                                  self.tgt_roles.to_comma_str())
+
+    def referenced_roles(self):
+        x = self.src_roles.copy()
+        x.update(self.tgt_roles)
+        return x
+
+class RoleTransition(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.src_roles = IdSet()
+        self.tgt_roles = IdSet()
+        self.tgt_type = ""
+
+    def to_string(self):
+        return "role_transition %s %s %s;" % (self.src_roles.to_comma_str(),
+                                              self.tgt_roles.to_comma_str(),
+                                              self.tgt_types)
+
+    def referenced_types(self):
+        return IdSet([self.tgt_type])
+
+    def referenced_roles(self):
+        x = self.src_roles.copy()
+        x.update(self.tgt_roles)
+        return x
 
 class ModuleDeclaration(Leaf):
     def __init__(self, parent=None):
@@ -585,13 +815,37 @@ class ModuleDeclaration(Leaf):
         else:
             return "module %s %s;" % (self.name, self.version)
 
+BOOLEAN_OPERATORS = ["!", "&&", "||", "==", "!="]
+
+class ConditionalBlock(Node):
+    def __init__(self):
+        Node.__init__(self)
+        self.is_else = False
+        self.cond_expr = []
+        self.has_close = True
+
+    def to_string(self):
+        if self.is_else:
+            return "else {"
+        else:
+            return "if (%s) {" % list_to_space_str(self.cond_expr, cont=("", ""))
+
+    def to_string_close(self):
+        return "}"
+
+    def referenced_booleans(self):
+        x = IdSet()
+        for y in self.cond_expr:
+            if y in BOOLEAN_OPERATORS:
+                continue
+            x.update(y)
+            
+        return x
+
 class Conditional(Node):
     def __init__(self, parent=None):
         Node.__init__(self, parent)
-        self.cond_expr = []
-
-    def to_string(self):
-        return "[If %s]" % list_to_space_str(self.cond_expr, cont=("", ""))
+        self.is_invisible = True
 
 class Bool(Leaf):
     def __init__(self, parent=None):
@@ -606,6 +860,9 @@ class Bool(Leaf):
         else:
             return s + "false"
 
+    def declared_booleans(self):
+        return IdSet([self.name])
+
 class InitialSid(Leaf):
     def __init(self, parent=None):
         Leaf.__init__(self, parent)
@@ -614,6 +871,25 @@ class InitialSid(Leaf):
 
     def to_string(self):
         return "sid %s %s" % (self.name, str(self.context))
+
+    def declared_sids(self):
+        return IdSet([self.name])
+
+    def referenced_types(self):
+        return IdSet([self.context.type])
+
+    def referenced_roles(self):
+        return IdSet([self.context.role])
+
+    def referenced_users(self):
+        return IdSet([self.context.user])
+
+    def referenced_sens(self):
+        return IdSet([level_to_sens(self.context.level)])
+
+    def referenced_categories(self):
+        return level_to_categories(self.context.level)
+
 
 class GenfsCon(Leaf):
     def __init__(self, parent=None):
@@ -624,6 +900,21 @@ class GenfsCon(Leaf):
 
     def to_string(self):
         return "genfscon %s %s %s" % (self.filesystem, self.path, str(self.context))
+
+    def referenced_types(self):
+        return IdSet([self.context.type])
+
+    def referenced_roles(self):
+        return IdSet([self.context.role])
+
+    def referenced_users(self):
+        return IdSet([self.context.user])
+
+    def referenced_sens(self):
+        return IdSet([level_to_sens(self.context.level)])
+
+    def referenced_categories(self):
+        return level_to_categories(self.context.level)
 
 class FilesystemUse(Leaf):
     XATTR = 1
@@ -647,6 +938,21 @@ class FilesystemUse(Leaf):
 
         return "%s %s %s;" % (s, self.filesystem, str(self.context))
 
+    def referenced_types(self):
+        return IdSet([self.context.type])
+
+    def referenced_roles(self):
+        return IdSet([self.context.role])
+
+    def referenced_users(self):
+        return IdSet([self.context.user])
+
+    def referenced_sens(self):
+        return IdSet([level_to_sens(self.context.level)])
+
+    def referenced_categories(self):
+        return level_to_categories(self.context.level)
+
 class PortCon(Leaf):
     def __init__(self, parent=None):
         Leaf.__init__(self, parent)
@@ -657,6 +963,21 @@ class PortCon(Leaf):
     def to_string(self):
         return "portcon %s %s %s" % (self.port_type, self.port_number, str(self.context))
 
+    def referenced_types(self):
+        return IdSet([self.context.type])
+
+    def referenced_roles(self):
+        return IdSet([self.context.role])
+
+    def referenced_users(self):
+        return IdSet([self.context.user])
+
+    def referenced_sens(self):
+        return IdSet([level_to_sens(self.context.level)])
+
+    def referenced_categories(self):
+        return level_to_categories(self.context.level)
+
 class NodeCon(Leaf):
     def __init__(self, parent=None):
         Leaf.__init__(self, parent)
@@ -667,6 +988,21 @@ class NodeCon(Leaf):
     def to_string(self):
         return "nodecon %s %s %s" % (self.start, self.end, str(self.context))
 
+    def referenced_types(self):
+        return IdSet([self.context.type])
+
+    def referenced_roles(self):
+        return IdSet([self.context.role])
+
+    def referenced_users(self):
+        return IdSet([self.context.user])
+
+    def referenced_sens(self):
+        return IdSet([level_to_sens(self.context.level)])
+
+    def referenced_categories(self):
+        return level_to_categories(self.context.level)
+
 class NetifCon(Leaf):
     def __init__(self, parent=None):
         Leaf.__init__(self, parent)
@@ -677,31 +1013,36 @@ class NetifCon(Leaf):
     def to_string(self):
         return "netifcon %s %s %s" % (self.interface, str(self.interface_context),
                                    str(self.packet_context))
+    def referenced_types(self):
+        return IdSet([self.interface_context.type, self.packet_context.type])
+
+    def referenced_roles(self):
+        return IdSet([self.interface_context.role, self.packet_context.role])
+
+    def referenced_users(self):
+        return IdSet([self.interface_context.user, self.packet_context.user])
+
+    def referenced_sens(self):
+        return IdSet([level_to_sens(self.interface_context.level),
+                      level_to_sens(self.packet_context.level)])
+
+    def referenced_categories(self):
+        x = level_to_categories(self.interface_context.level)
+        x.update(level_to_categories(self.packet_context.level))
+        return x
 
 # Reference policy specific types
 
-def print_tree(head):
-    for node, depth in walktree(head, showdepth=True):
-        s = ""
-        for i in range(depth):
-            s = s + "\t"
-        print s + str(node)
-
-
 class Headers(Node):
     def __init__(self, parent=None):
         Node.__init__(self, parent)
-
-    def to_string(self):
-        return "[Headers]"
+        self.is_invisible = True
 
 
 class Module(Node):
     def __init__(self, parent=None):
         Node.__init__(self, parent)
-
-    def to_string(self):
-        return ""
+        self.is_invisible = True
 
 class Interface(Node):
     """A reference policy interface definition.
@@ -711,33 +1052,68 @@ class Interface(Node):
     def __init__(self, name="", parent=None):
         Node.__init__(self, parent)
         self.name = name
-
-    def to_string(self):
-        return "[Interface name: %s]" % self.name
+        self.has_close = True
+
+    def to_string(self):
+        return "interface(`%s',`" % self.name
+
+    def to_string_close(self):
+        return "')"
+
+class TunableBlock(Node):
+    def __init__(self):
+        Node.__init__(self)
+        self.is_else = False
+        self.cond_expr = []
+        self.has_close = True
+
+    def to_string(self):
+        if self.is_else:
+            return "',`"
+        else:
+            return "tunable_policy(`%s',`" % list_to_space_str(self.cond_expr, cont=("", ""))
+
+    def to_string_close(self):
+        return "')"
 
 class TunablePolicy(Node):
     def __init__(self, parent=None):
         Node.__init__(self, parent)
-        self.cond_expr = []
-
-    def to_string(self):
-        return "[Tunable Policy %s]" % list_to_space_str(self.cond_expr, cont=("", ""))
+        self.is_invisible = True
 
 class Template(Node):
     def __init__(self, name="", parent=None):
         Node.__init__(self, parent)
         self.name = name
-
-    def to_string(self):
-        return "[Template name: %s]" % self.name
+        self.has_close = True
+
+    def to_string(self):
+        return "template(`%s',`" % self.name
+
+    def to_string_close(self):
+        return "')"
+
+class IfDefBlock(Node):
+    def __init__(self):
+        Node.__init__(self)
+        self.ifdef = True
+        self.is_else = False
+        self.has_close = True
+        self.name = ""
+
+    def to_string(self):
+        if self.is_else:
+            return "',`"
+        else:
+            return "ifdef(`%s',`" % self.name
+
+    def to_string_close(self):
+        return "')"
 
 class IfDef(Node):
-    def __init__(self, name="", parent=None):
+    def __init__(self, parent=None):
         Node.__init__(self, parent)
-        self.name = name
-
-    def to_string(self):
-        return "[Ifdef name: %s]" % self.name
+        self.is_invisible = True
 
 class InterfaceCall(Leaf):
     def __init__(self, ifname="", parent=None):
@@ -772,12 +1148,55 @@ class InterfaceCall(Leaf):
             i += 1
         return s + ")"
 
+    def referenced_types(self):
+        return IdSet(self.args)
+
+class OptionalBlock(Node):
+    def __init__(self):
+        Node.__init__(self)
+        self.is_else = False
+        self.has_close = True
+
+    def to_string(self):
+        if self.is_else:
+            return "else {"
+        else:
+            return "optional {"
+
+    def to_string_close(self):
+        return "}"
+
+class Optional(Node):
+    def __init__(self, parent=None):
+        Node.__init__(self, parent)
+        self.is_invisible = True
+
+    def to_string(self):
+        return ""
+
+
+class OptionalPolicyBlock(Node):
+    def __init__(self):
+        Node.__init__(self)
+        self.is_else = False
+        self.has_close = True
+
+    def to_string(self):
+        if self.is_else:
+            return "',`"
+        else:
+            return "optional_policy{`"
+
+    def to_string_close(self):
+        return "')"
+
 class OptionalPolicy(Node):
     def __init__(self, parent=None):
         Node.__init__(self, parent)
-
-    def to_string(self):
-        return "[Optional Policy]"
+        self.is_invisible = True
+
+    def to_string(self):
+        return ""
 
 class SupportMacros(Node):
     def __init__(self, parent=None):
@@ -821,10 +1240,13 @@ class Require(Leaf):
     def __init__(self, parent=None):
         Leaf.__init__(self, parent)
         self.types = IdSet()
+        self.attributes = IdSet()
         self.obj_classes = { }
         self.roles = IdSet()
-        self.bools = IdSet()
+        self.booleans = IdSet()
         self.users = IdSet()
+        self.sensitivities = IdSet()
+        self.categories = IdSet()
 
     def add_obj_class(self, obj_class, perms=None):
         p = self.obj_classes.setdefault(obj_class, IdSet())
@@ -837,14 +1259,20 @@ class Require(Leaf):
         s.append("require {")
         for type in self.types:
             s.append("\ttype %s;" % type)
+        for attr in self.attributes:
+            s.append("\tattribute %s;" % attr)
         for obj_class, perms in self.obj_classes.items():
             s.append("\tclass %s %s;" % (obj_class, perms.to_space_str()))
         for role in self.roles:
             s.append("\trole %s;" % role)
-        for bool in self.bools:
+        for bool in self.booleans:
             s.append("\tbool %s;" % bool)
         for user in self.users:
             s.append("\tuser %s;" % user)
+        for sens in self.sensitivities:
+            s.append("\tsensitivity %s;" % sens)
+        for cat in self.categories:
+            s.append("\tcategory %s;" % cat)
         s.append("}")
 
         # Handle empty requires
diff -r d0c7526b7795 sepolgen/src/sepolgen/tools.py
--- a/sepolgen/src/sepolgen/tools.py	Mon Sep 10 10:30:35 2007 -0400
+++ b/sepolgen/src/sepolgen/tools.py	Mon Sep 10 10:30:36 2007 -0400
@@ -0,0 +1,67 @@
+# Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
+#
+# Copyright (C) 2007  Red Hat
+# see file 'COPYING' for use and warranty information
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; version 2 only
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#
+
+import os, imp
+
+import defaults
+
+PREFIX="sepolgen-"
+
+class Tool:
+    def __init__(self, filename):
+        # filename should be relative
+        self.filename = filename
+        self.abspath = defaults.tools() + "/" + self.filename
+        assert(len(filename) > len(PREFIX))
+        self.toolname = self.filename[len(PREFIX):-3]
+        self.module = None
+
+    def load(self):
+        if self.module:
+            return
+        f = open(self.abspath, "r")
+        self.module = imp.load_module(self.toolname, f, self.abspath,
+                                      ("", "", imp.PY_SOURCE))
+
+    def short_description(self):
+        self.load()
+        return " %s\t\t%s" % (self.toolname, self.module.SHORT_DESCRIPTION)
+        
+
+    def usage(self):
+        self.load()
+        return format_usage(self.module.USAGE, self.module.DESCRIPTION,
+                            self.module.OPTIONS)
+
+def find_tools():
+    tools = []
+    for filename in os.listdir(defaults.tools()):
+        if filename.startswith(PREFIX) and filename.endswith(".py"):
+            t = Tool(filename)
+            tools.append(t)
+
+    return tools
+
+def format_usage(tool_usage, tool_description, tool_options):
+      a = "usage: sepolgen %s\n" % tool_usage
+      a = a + tool_description + "\noptions:\n"
+      for opt in tool_options:
+          a = a + "  -%s --%s\t%s\n" % (opt[0], opt[1], opt[2])
+
+      return a
diff -r d0c7526b7795 sepolgen/src/tools/Makefile
--- a/sepolgen/src/tools/Makefile	Mon Sep 10 10:30:35 2007 -0400
+++ b/sepolgen/src/tools/Makefile	Mon Sep 10 10:30:36 2007 -0400
@@ -0,0 +1,13 @@
+LIBDIR=$(DESTDIR)/var/lib/sepolgen
+TOOLDIR=$(LIBDIR)/tools
+BINDIR=$(DESTDIR)/usr/bin
+
+all:
+
+install:
+	install -m 755 sepolgen $(BINDIR)
+	-mkdir -p $(TOOLDIR)
+	install -m 755 sepolgen-*.py $(TOOLDIR)
+
+clean:
+	rm -f *~ *.pyc
\ No newline at end of file
diff -r d0c7526b7795 sepolgen/src/tools/sepolgen
--- a/sepolgen/src/tools/sepolgen	Mon Sep 10 10:30:35 2007 -0400
+++ b/sepolgen/src/tools/sepolgen	Mon Sep 10 10:30:36 2007 -0400
@@ -0,0 +1,68 @@
+#! /usr/bin/python -E
+# Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
+#
+# Copyright (C) 2007  Red Hat
+# see file 'COPYING' for use and warranty information
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; version 2 only
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#
+
+import sys
+
+from sepolgen import tools
+
+HELP_PREFIX="Sepolgen SELinux policy tool"
+
+def help(tools):
+    print HELP_PREFIX
+    print ""
+    print 'basic commands (use "sepolgen help" for details)'
+    print ""
+    
+    for tool in tools:
+        print tool.short_description()
+
+def detailed_help(tools):
+    if len(sys.argv) < 3:
+        print "usage: sepolgen help COMMAND\n"
+        help(tools)
+        return
+    
+    toolname = sys.argv[2]
+    for tool in tools:
+        if tool.toolname == toolname:
+            print tool.usage()
+
+def main():
+    t = tools.find_tools()
+
+    if len(sys.argv) < 2:
+        help(t)
+        sys.exit(1)
+
+    if sys.argv[1] == "help":
+        detailed_help(t)
+
+    toolname = sys.argv[1]
+    for tool in t:
+        if tool.toolname == toolname:
+            tool.load()
+            tool.module.run(sys.argv[1:])
+
+main()
+    
+
+
+            
+    
diff -r d0c7526b7795 sepolgen/src/tools/sepolgen-update.py
--- a/sepolgen/src/tools/sepolgen-update.py	Mon Sep 10 10:30:35 2007 -0400
+++ b/sepolgen/src/tools/sepolgen-update.py	Mon Sep 10 10:30:36 2007 -0400
@@ -0,0 +1,89 @@
+# Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
+#
+# Copyright (C) 2007  Red Hat
+# see file 'COPYING' for use and warranty information
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; version 2 only
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#
+
+import sys
+from optparse import OptionParser
+
+from sepolgen import tools, refparser, policygen, output, refpolicy
+
+VERSION="%prog .1"
+
+USAGE="[-i] module.te"
+
+OPTIONS=[("i", "convert", "convert allow rules into interface calls"),
+         ("o", "output", "output filename - default is to update the input file")]
+
+SHORT_DESCRIPTION="update a policy module"
+
+DESCRIPTION="""Update a policy module including:
+  * require all symbols (types, attributes, classes, etc.)
+  * merge and remove duplicate allow statements and interface calls
+  * convert allow rules into appropriate interface calls (optional)"""
+
+def run(args):
+    in_filename, options = parse_args(args)
+    module = read_policy(in_filename)
+
+    refpolicy.print_tree(module)
+    
+    new_module = update(options.convert_ifs, module)
+
+    out_filename = in_filename
+    if options.out_filename:
+        out_filename = options.out_filename
+        
+    write_policy(out_filename, new_module)
+
+
+def usage():
+    print tools.format_usage(USAGE, DESCRIPTION, OPTIONS)
+    sys.exit(1)
+
+def parse_args(args):
+    parser = OptionParser(version=VERSION)
+    parser.add_option("-i", "--convert", action="store_true", dest="convert_ifs",
+                      default=False)
+    parser.add_option("-o", "--output", dest="out_filename")
+
+    options, out_args = parser.parse_args(args)
+
+    if len(out_args) != 2:
+        usage()
+
+    return (out_args[1], options)
+
+def read_policy(filename):
+    f = open(filename)
+    buffer = f.read()
+    f.close()
+
+    module = refparser.parse(buffer)
+
+    return module
+
+def update(convert_ifs, module):
+    p = policygen.PolicyGenerator(module)
+    p.optimize_module()
+    return p.get_module()
+
+def write_policy(filename, module):
+    writer = output.ModuleWriter()
+    fd = open(filename, "w")
+    writer.write(module, fd)
+

--=-rGnBFKBZuV7um9IkgvXs--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
