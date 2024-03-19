Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5492B9D7
	for <selinux@vger.kernel.org>; Tue, 19 Mar 2024 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874756; cv=none; b=H7dI8dm9lJ8EAEaUNsK2vV/DmhgDBzluxwLfuEEXldZdwTw4HistTF6xt0cpwwb9mYD6LuYacLat8jagJAXYNUc8x2uOVJXlfATHVYgZvAYyXISSR7vfhAwoOKHerXbvLDJ7qdO6AM327dwaMKzQfMDYxkc+/t3ygazlZgtClWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874756; c=relaxed/simple;
	bh=7kHu2nlKbW8kge1V9O7LKRMVCqpaCTYkujvjrIyTzW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+2L8OrL1fdcYjcSxm73+1gm6Ii5OX+uo/by0cxFTLPPUQBIwpnjoeAhoFwJTcUB3BlPYz5D7dddhjj4/PhfkXbCi3JU3/p3PT/sbWqGR3yqhZh7vZC4dkseK6Ic/LpMNrmQDu9ghm+oIaeB3uHv1TnKI3A8g9ZiP19mCpbl0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPKu7qrL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPKu7qrL"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513da1c1f26so6936749e87.3
        for <selinux@vger.kernel.org>; Tue, 19 Mar 2024 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710874751; x=1711479551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REndtS1XU0LfnddRA49L4JlwJ0gh1owgxZzgieZwFQs=;
        b=MPKu7qrLsEvEOWH3Jm79miLPE70GrcyklxZpbL5Z+ripkEkOxYTBIxuwSfShq/sd5C
         +OjQHNs4i99RXcPvboudnr/DZpOr4hEbRwJnVJHJD5DYyO5aM6Ik6sBrqB5sBh/CjsOR
         ayXcdQPL0OHYtyTLePcLUb6bdfkjA/ihXiFxi5WzZukzOF5INXYhGyzrM8SvRsbVBRJX
         JkpY7mDnv+sOU3bk50wHtHXY7jJsEBVon8c6rsIQZky6wECFMxwHwz8SPoQrgm/28Tee
         Q5iEyQucnGMLInPkrKlKzwY8E23kbQ/6qp784yz6RK/psNcdDqjik/c9gUl9IJi/Mko9
         VBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710874751; x=1711479551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REndtS1XU0LfnddRA49L4JlwJ0gh1owgxZzgieZwFQs=;
        b=NZx1HdbjIfEg0PC0TZZQygnOiYFFG/6xXLKkqx6q5+996OT/QLmlG3Pc4I21byqPfr
         +cKxoRsVB82XOsNVsjmg0cPF4t3/zaga+rxt82xMlfeRWJbNfwL2JHZJ387wcFdtSpS0
         fpwKkeNLjXGRoK47C6uRe13DEj/Uz7vq/i1jZ2AYbXtSDuXTi6B2q/7AV5cQBeMV8cpe
         xouPIOFXcH1HcLYlbRWrvZpOUQUk/shAB8Uap1VyhWdBwFPxmfYl5JgoUH/Uuw7WQq3U
         D5EdVIQsV8LT1qEmtzjX/lt+fmELXAYYkQCcPos9SQrGa5bio2pDBoso9nXrNNJH25pW
         ljuQ==
X-Gm-Message-State: AOJu0Yw6BsqHldyU98VPF9he3xX5KMkccVHvGOo8X3FqCwuBQKRxtZQM
	gb3K3kOnh7rxDUVq1lW1Rr1LpqMt7OjFwxXHPHQ0qN1p72akeYr3rQxkfXXx
X-Google-Smtp-Source: AGHT+IESJ04ZJtl5mxi2Q8qS/WgMvBkKiGXsllKUVq7X2JWaSkH9vA1qpJD3QP6PjtPza8VW+TxA5A==
X-Received: by 2002:ac2:4652:0:b0:513:d8b4:90be with SMTP id s18-20020ac24652000000b00513d8b490bemr9915979lfo.24.1710874750281;
        Tue, 19 Mar 2024 11:59:10 -0700 (PDT)
Received: from localhost.localdomain (85-156-69-24.elisa-laajakaista.fi. [85.156.69.24])
        by smtp.gmail.com with ESMTPSA id h36-20020a0565123ca400b00514b53f66besm500005lfv.296.2024.03.19.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:59:09 -0700 (PDT)
From: Topi Miettinen <toiwoton@gmail.com>
To: selinux@vger.kernel.org
Cc: Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH PR#420 v4] audit2allow: CIL output mode
Date: Tue, 19 Mar 2024 20:53:22 +0200
Message-ID: <20240319185321.12794-2-toiwoton@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New flag -C for audit2allow sets output format to CIL instead of
Policy Language.

Example:
;============= mozilla_t ==============

;!!!! This avc is allowed in the current policy
(allow mozilla_t user_sudo_t (fd (use)))

;============= user_t ==============

;!!!! This avc can be allowed using the boolean 'allow_execmem'
(allow user_t self (process (execmem)))
(allow user_t chromium_t (process (noatsecure rlimitinh siginh)))

;!!!! This avc is a constraint violation.  You would need to modify the attributes of either the source or target types to allow this access.
;Constraint rule:
;       constrain dir { ioctl read write create getattr setattr lock relabelfrom relabelto append map unlink link rename execute quotaon mounton audit_access open execmod watch watch_mount watch_sb watch_with_perm watch_reads add_name remove_name reparent search rmdir } ((u1 == u2 -Fail-)  or (u1 == system_u -Fail-)  or (u1 == unconfined_u -Fail-)  or (u1 == sysadm_u -Fail-)  or (u2 == system_u -Fail-)  or (t1 != ubac_constrained_type -Fail-)  or (t2 != ubac_constrained_type -Fail-)  or (t1 == ubacfile -Fail-) ); Constraint DENIED

;       Possible cause is the source user (user_u) and target user (sysadm_u) are different.
(allow user_t user_home_dir_t (dir (getattr relabelto)))

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

---
v4: several fixes to issues found by James Carter
v3: fixed extended permissions syntax
v2: fix uninitialized variable detected by CI
---
 python/audit2allow/audit2allow            |  14 +-
 python/audit2allow/audit2allow.1          |   3 +
 python/sepolgen/src/sepolgen/output.py    |   5 +
 python/sepolgen/src/sepolgen/policygen.py |  32 ++-
 python/sepolgen/src/sepolgen/refpolicy.py | 334 +++++++++++++++++-----
 5 files changed, 298 insertions(+), 90 deletions(-)

diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2allow
index 35b0b151..b5927ec1 100644
--- a/python/audit2allow/audit2allow
+++ b/python/audit2allow/audit2allow
@@ -75,6 +75,7 @@ class AuditToPolicy:
                           help="generate policy with dontaudit rules")
         parser.add_option("-R", "--reference", action="store_true", dest="refpolicy",
                           default=True, help="generate refpolicy style output")
+        parser.add_option("-C", "--cil", action="store_true", dest="cil", help="generate CIL output")
 
         parser.add_option("-N", "--noreference", action="store_false", dest="refpolicy",
                           default=False, help="do not generate refpolicy style output")
@@ -114,7 +115,7 @@ class AuditToPolicy:
                 sys.stderr.write('error: module names must begin with a letter, optionally followed by letters, numbers, "-", "_", "."\n')
                 sys.exit(2)
 
-        # Make -M and -o conflict
+        # Make -M and -o or -C conflict
         if options.module_package:
             if options.output:
                 sys.stderr.write("error: --module-package conflicts with --output\n")
@@ -122,6 +123,9 @@ class AuditToPolicy:
             if options.module:
                 sys.stderr.write("error: --module-package conflicts with --module\n")
                 sys.exit(2)
+            if options.cil:
+                sys.stderr.write("error: --module-package conflicts with --cil\n")
+                sys.exit(2)
 
         self.__options = options
 
@@ -341,6 +345,10 @@ semodule -i {packagename}
         if self.__options.requires:
             g.set_gen_requires(True)
 
+        # CIL output
+        if self.__options.cil:
+            g.set_gen_cil(True)
+
         # Generate the policy
         g.add_access(self.__avs)
         g.add_role_types(self.__role_types)
@@ -348,6 +356,10 @@ semodule -i {packagename}
         # Output
         writer = output.ModuleWriter()
 
+        # CIL output
+        if self.__options.cil:
+            writer.set_gen_cil(True)
+
         # Module package
         if self.__options.module_package:
             self.__output_modulepackage(writer, g)
diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2allow.1
index c208b3b2..2834234d 100644
--- a/python/audit2allow/audit2allow.1
+++ b/python/audit2allow/audit2allow.1
@@ -74,6 +74,9 @@ Generate module/require output <modulename>
 .B "\-M <modulename>" 
 Generate loadable module package, conflicts with \-o
 .TP
+.B "\-C"
+Generate CIL output, conflicts with \-M
+.TP
 .B "\-p <policyfile>"  | "\-\-policy <policyfile>"
 Policy file to use for analysis
 .TP
diff --git a/python/sepolgen/src/sepolgen/output.py b/python/sepolgen/src/sepolgen/output.py
index aeeaafc8..57380cad 100644
--- a/python/sepolgen/src/sepolgen/output.py
+++ b/python/sepolgen/src/sepolgen/output.py
@@ -40,6 +40,7 @@ class ModuleWriter:
         self.module = None
         self.sort = True
         self.requires = True
+        self.gen_cil = False
 
     def write(self, module, fd):
         self.module = module
@@ -49,8 +50,12 @@ class ModuleWriter:
 
         # FIXME - make this handle nesting
         for node, depth in refpolicy.walktree(self.module, showdepth=True):
+            node.set_gen_cil(self.gen_cil)
             fd.write("%s\n" % str(node))
 
+    def set_gen_cil(self, gen_cil):
+        self.gen_cil = gen_cil
+
 # Helper functions for sort_filter - this is all done old school
 # C style rather than with polymorphic methods because this sorting
 # is specific to output. It is not necessarily the comparison you
diff --git a/python/sepolgen/src/sepolgen/policygen.py b/python/sepolgen/src/sepolgen/policygen.py
index 183b41a9..5d59dad7 100644
--- a/python/sepolgen/src/sepolgen/policygen.py
+++ b/python/sepolgen/src/sepolgen/policygen.py
@@ -86,6 +86,8 @@ class PolicyGenerator:
         self.xperms = False
 
         self.domains = None
+        self.gen_cil = False
+        self.comment_start = '#'
     def set_gen_refpol(self, if_set=None, perm_maps=None):
         """Set whether reference policy interfaces are generated.
 
@@ -128,6 +130,13 @@ class PolicyGenerator:
         """
         self.xperms = xperms
 
+    def set_gen_cil(self, gen_cil):
+        self.gen_cil = gen_cil
+        if gen_cil:
+            self.comment_start = ';'
+        else:
+            self.comment_start = '#'
+
     def __set_module_style(self):
         if self.ifgen:
             refpolicy = True
@@ -173,26 +182,27 @@ class PolicyGenerator:
             rule.comment = str(refpolicy.Comment(explain_access(av, verbosity=self.explain)))
 
         if av.type == audit2why.ALLOW:
-            rule.comment += "\n#!!!! This avc is allowed in the current policy"
+            rule.comment += "\n%s!!!! This avc is allowed in the current policy" % self.comment_start
 
             if av.xperms:
-                rule.comment += "\n#!!!! This av rule may have been overridden by an extended permission av rule"
+                rule.comment += "\n%s!!!! This av rule may have been overridden by an extended permission av rule" % self.comment_start
 
         if av.type == audit2why.DONTAUDIT:
-            rule.comment += "\n#!!!! This avc has a dontaudit rule in the current policy"
+            rule.comment += "\n%s!!!! This avc has a dontaudit rule in the current policy" % self.comment_start
 
         if av.type == audit2why.BOOLEAN:
             if len(av.data) > 1:
-                rule.comment += "\n#!!!! This avc can be allowed using one of the these booleans:\n#     %s" % ", ".join([x[0] for x in av.data])
+                rule.comment += "\n%s!!!! This avc can be allowed using one of the these booleans:\n%s     %s" % (self.comment_start, self.comment_start, ", ".join([x[0] for x in av.data]))
             else:
-                rule.comment += "\n#!!!! This avc can be allowed using the boolean '%s'" % av.data[0][0]
+                rule.comment += "\n%s!!!! This avc can be allowed using the boolean '%s'" % (self.comment_start, av.data[0][0])
 
         if av.type == audit2why.CONSTRAINT:
-            rule.comment += "\n#!!!! This avc is a constraint violation.  You would need to modify the attributes of either the source or target types to allow this access."
-            rule.comment += "\n#Constraint rule: "
-            rule.comment += "\n#\t" + av.data[0]
+            rule.comment += "\n%s!!!! This avc is a constraint violation.  You would need to modify the attributes of either the source or target types to allow this access." % self.comment_start
+            rule.comment += "\n%sConstraint rule: " % self.comment_start
+            rule.comment += "\n%s\t" % self.comment_start + av.data[0]
             for reason in av.data[1:]:
-                rule.comment += "\n#\tPossible cause is the source %s and target %s are different." % reason
+                rule.comment += "\n%s" % self.comment_start
+                rule.comment += "\tPossible cause is the source %s and target %s are different." % reason
 
         try:
             if ( av.type == audit2why.TERULE and
@@ -206,9 +216,9 @@ class PolicyGenerator:
                     if i not in self.domains:
                         types.append(i)
                 if len(types) == 1:
-                    rule.comment += "\n#!!!! The source type '%s' can write to a '%s' of the following type:\n# %s\n" % ( av.src_type, av.obj_class, ", ".join(types))
+                    rule.comment += "\n%s!!!! The source type '%s' can write to a '%s' of the following type:\n%s %s\n" % (self.comment_start, av.src_type, av.obj_class, self.comment_start, ", ".join(types))
                 elif len(types) >= 1:
-                    rule.comment += "\n#!!!! The source type '%s' can write to a '%s' of the following types:\n# %s\n" % ( av.src_type, av.obj_class, ", ".join(types))
+                    rule.comment += "\n%s!!!! The source type '%s' can write to a '%s' of the following types:\n%s %s\n" % (self.comment_start, av.src_type, av.obj_class, self.comment_start, ", ".join(types))
         except:
             pass
 
diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index 9cac1b95..ae5450d7 100644
--- a/python/sepolgen/src/sepolgen/refpolicy.py
+++ b/python/sepolgen/src/sepolgen/refpolicy.py
@@ -53,6 +53,7 @@ class PolicyBase:
     def __init__(self, parent=None):
         self.parent = None
         self.comment = None
+        self.gen_cil = False
 
 class Node(PolicyBase):
     """Base class objects produced from parsing the reference policy.
@@ -150,6 +151,8 @@ class Node(PolicyBase):
     def to_string(self):
         return ""
 
+    def set_gen_cil(self, gen_cil):
+        self.gen_cil = gen_cil
 
 class Leaf(PolicyBase):
     def __init__(self, parent=None):
@@ -167,6 +170,8 @@ class Leaf(PolicyBase):
     def to_string(self):
         return ""
 
+    def set_gen_cil(self, gen_cil):
+        self.gen_cil = gen_cil
 
 
 # Utility functions
@@ -413,6 +418,16 @@ class XpermSet():
 
         return "%s{ %s }" % (compl, " ".join(vals))
 
+    def to_string_cil(self):
+        if not self.ranges:
+            return ""
+
+        compl = ("not (", ")") if self.complement else ("", "")
+
+        vals = map(lambda x: hex(x[0]) if x[0] == x[1] else "(range %s %s)" % (hex(x[0]), hex(x[1]), ), self.ranges)
+
+        return "(%s%s%s)" % (compl[0], " ".join(vals), compl[1])
+
 # Basic statements
 
 class TypeAttribute(Leaf):
@@ -426,7 +441,14 @@ class TypeAttribute(Leaf):
         self.attributes = IdSet()
 
     def to_string(self):
-        return "typeattribute %s %s;" % (self.type, self.attributes.to_comma_str())
+        if self.gen_cil:
+            s = ""
+            for a in self.attributes:
+                s += "(typeattribute %s)\n" % a
+                s += "(typeattributeset %s %s)\n" % (a, self.type)
+            return s
+        else:
+            return "typeattribute %s %s;" % (self.type, self.attributes.to_comma_str())
 
 class RoleAttribute(Leaf):
     """SElinux roleattribute statement.
@@ -439,7 +461,14 @@ class RoleAttribute(Leaf):
         self.roleattributes = IdSet()
 
     def to_string(self):
-        return "roleattribute %s %s;" % (self.role, self.roleattributes.to_comma_str())
+        if self.gen_cil:
+            s = ""
+            for a in self.roleattributes:
+                s += "(roleattribute %s)\n" % a
+                s += "(roleattributeset %s %s)\n" % (a, self.type)
+            return s
+        else:
+            return "roleattribute %s %s;" % (self.role, self.roleattributes.to_comma_str())
 
 
 class Role(Leaf):
@@ -449,10 +478,16 @@ class Role(Leaf):
         self.types = IdSet()
 
     def to_string(self):
-        s = ""
-        for t in self.types:
-            s += "role %s types %s;\n" % (self.role, t)
-        return s
+        if self.gen_cil:
+            s = "(role %s)\n" % self.role
+            for t in self.types:
+                s += "(roletype %s %s)\n" % (self.role, t)
+            return s
+        else:
+            s = ""
+            for t in self.types:
+                s += "role %s types %s;\n" % (self.role, t)
+            return s
 
 class Type(Leaf):
     def __init__(self, name="", parent=None):
@@ -462,12 +497,20 @@ class Type(Leaf):
         self.aliases = IdSet()
 
     def to_string(self):
-        s = "type %s" % self.name
-        if len(self.aliases) > 0:
-            s = s + "alias %s" % self.aliases.to_space_str()
-        if len(self.attributes) > 0:
-            s = s + ", %s" % self.attributes.to_comma_str()
-        return s + ";"
+        if self.gen_cil:
+            s = "(type %s)\n" % self.name
+            for a in self.aliases:
+                s += "(typealiasactual %s %s)\n" % (a, self.name)
+            for a in self.attributes:
+                s += "(typeattributeset %s %s)\n" % (a, self.name)
+            return s
+        else:
+            s = "type %s" % self.name
+            if len(self.aliases) > 0:
+                s = s + "alias %s" % self.aliases.to_space_str()
+            if len(self.attributes) > 0:
+                s = s + ", %s" % self.attributes.to_comma_str()
+            return s + ";"
 
 class TypeAlias(Leaf):
     def __init__(self, parent=None):
@@ -476,7 +519,14 @@ class TypeAlias(Leaf):
         self.aliases = IdSet()
 
     def to_string(self):
-        return "typealias %s alias %s;" % (self.type, self.aliases.to_space_str())
+        if self.gen_cil:
+            s = ""
+            for a in self.aliases:
+                s += "(typealias %s)\n" % a
+                s += "(typealiasactual %s %s)\n" % (a, self.type)
+            return s
+        else:
+            return "typealias %s alias %s;" % (self.type, self.aliases.to_space_str())
 
 class Attribute(Leaf):
     def __init__(self, name="", parent=None):
@@ -484,7 +534,10 @@ class Attribute(Leaf):
         self.name = name
 
     def to_string(self):
-        return "attribute %s;" % self.name
+        if self.gen_cil:
+            return "attribute %s;" % self.name
+        else:
+            return "(typeattribute %s)" % self.name
 
 class Attribute_Role(Leaf):
     def __init__(self, name="", parent=None):
@@ -492,7 +545,10 @@ class Attribute_Role(Leaf):
         self.name = name
 
     def to_string(self):
-        return "attribute_role %s;" % self.name
+        if self.gen_cil:
+            return "(roleattribute %s)" % self.name
+        else:
+            return "attribute_role %s;" % self.name
 
 
 # Classes representing rules
@@ -555,11 +611,21 @@ class AVRule(Leaf):
         that is a valid policy language representation (assuming
         that the types, object class, etc. are valie).
         """
-        return "%s %s %s:%s %s;" % (self.__rule_type_str(),
-                                     self.src_types.to_space_str(),
-                                     self.tgt_types.to_space_str(),
-                                     self.obj_classes.to_space_str(),
-                                     self.perms.to_space_str())
+        if self.gen_cil:
+            s = ""
+            for src in self.src_types:
+                for tgt in self.tgt_types:
+                    for obj in self.obj_classes:
+                        s += "(%s %s %s (%s (%s)))" % (self.__rule_type_str(),
+                                                       src, tgt, obj,
+                                                       " ".join(self.perms))
+            return s
+        else:
+            return "%s %s %s:%s %s;" % (self.__rule_type_str(),
+                                        self.src_types.to_space_str(),
+                                        self.tgt_types.to_space_str(),
+                                        self.obj_classes.to_space_str(),
+                                        self.perms.to_space_str())
 
 class AVExtRule(Leaf):
     """Extended permission access vector rule.
@@ -597,6 +663,16 @@ class AVExtRule(Leaf):
         elif self.rule_type == self.NEVERALLOWXPERM:
             return "neverallowxperm"
 
+    def __rule_type_str_cil(self):
+        if self.rule_type == self.ALLOWXPERM:
+            return "allowx"
+        elif self.rule_type == self.DONTAUDITXPERM:
+            return "dontauditx"
+        elif self.rule_type == self.AUDITALLOWXPERM:
+            return "auditallowx"
+        elif self.rule_type == self.NEVERALLOWXPERM:
+            return "neverallowx"
+
     def from_av(self, av, op):
         self.src_types.add(av.src_type)
         if av.src_type == av.tgt_type:
@@ -612,12 +688,25 @@ class AVExtRule(Leaf):
         a valid policy language representation (assuming that
         the types, object class, etc. are valid).
         """
-        return "%s %s %s:%s %s %s;" % (self.__rule_type_str(),
-                                     self.src_types.to_space_str(),
-                                     self.tgt_types.to_space_str(),
-                                     self.obj_classes.to_space_str(),
-                                     self.operation,
-                                     self.xperms.to_string())
+        if self.gen_cil:
+            s = ""
+            for src in self.src_types:
+                for tgt in self.tgt_types:
+                    for obj in self.obj_classes:
+                        s += "(%s %s %s (%s %s %s))" % (self.__rule_type_str_cil(),
+                                                        src, tgt,
+                                                        self.operation,
+                                                        obj,
+                                                        self.xperms.to_string_cil())
+            return s
+        else:
+            return "%s %s %s:%s %s %s;" % (self.__rule_type_str(),
+                                           self.src_types.to_space_str(),
+                                           self.tgt_types.to_space_str(),
+                                           self.obj_classes.to_space_str(),
+                                           self.operation,
+                                           self.xperms.to_string())
+
 
 class TypeRule(Leaf):
     """SELinux type rules.
@@ -630,6 +719,7 @@ class TypeRule(Leaf):
     TYPE_CHANGE = 1
     TYPE_MEMBER = 2
 
+    # NB. Filename type transitions are not generated by audit2allow.
     def __init__(self, parent=None):
         Leaf.__init__(self, parent)
         self.src_types = IdSet()
@@ -646,12 +736,28 @@ class TypeRule(Leaf):
         else:
             return "type_member"
 
+    def __rule_type_str_cil(self):
+        if self.rule_type == self.TYPE_TRANSITION:
+            return "typetransition"
+        elif self.rule_type == self.TYPE_CHANGE:
+            return "typechange"
+        else:
+            return "typemember"
+
     def to_string(self):
-        return "%s %s %s:%s %s;" % (self.__rule_type_str(),
-                                     self.src_types.to_space_str(),
-                                     self.tgt_types.to_space_str(),
-                                     self.obj_classes.to_space_str(),
-                                     self.dest_type)
+        if self.gen_cil:
+            return "(%s %s %s %s %s)" % (self.__rule_type_str_cil(),
+                                         self.src_types.to_space_str(),
+                                         self.tgt_types.to_space_str(),
+                                         self.obj_classes.to_space_str(),
+                                         self.dest_type)
+        else:
+            return "%s %s %s:%s %s;" % (self.__rule_type_str(),
+                                        self.src_types.to_space_str(),
+                                        self.tgt_types.to_space_str(),
+                                        self.obj_classes.to_space_str(),
+                                        self.dest_type)
+
 class TypeBound(Leaf):
     """SElinux typebound statement.
 
@@ -663,8 +769,13 @@ class TypeBound(Leaf):
         self.tgt_types = IdSet()
 
     def to_string(self):
-        return "typebounds %s %s;" % (self.type, self.tgt_types.to_comma_str())
-
+        if self.gen_cil:
+            s = ""
+            for t in self.tgt_types:
+                s += "(typebounds %s %s)" % (self.type, t)
+            return s
+        else:
+            return "typebounds %s %s;" % (self.type, self.tgt_types.to_comma_str())
 
 class RoleAllow(Leaf):
     def __init__(self, parent=None):
@@ -673,8 +784,15 @@ class RoleAllow(Leaf):
         self.tgt_roles = IdSet()
 
     def to_string(self):
-        return "allow %s %s;" % (self.src_roles.to_comma_str(),
-                                 self.tgt_roles.to_comma_str())
+        if self.gen_cil:
+            s = ""
+            for src in self.src_roles:
+                for tgt in self.tgt_roles:
+                    s += "(roleallow %s %s)" % (src, tgt)
+            return s
+        else:
+            return "allow %s %s;" % (self.src_roles.to_comma_str(),
+                                     self.tgt_roles.to_comma_str())
 
 class RoleType(Leaf):
     def __init__(self, parent=None):
@@ -685,7 +803,10 @@ class RoleType(Leaf):
     def to_string(self):
         s = ""
         for t in self.types:
-            s += "role %s types %s;\n" % (self.role, t)
+            if self.gen_cil:
+                s += "(roletype %s %s)\n" % (self.role, t)
+            else:
+                s += "role %s types %s;\n" % (self.role, t)
         return s
 
 class ModuleDeclaration(Leaf):
@@ -696,10 +817,13 @@ class ModuleDeclaration(Leaf):
         self.refpolicy = False
 
     def to_string(self):
-        if self.refpolicy:
-            return "policy_module(%s, %s)" % (self.name, self.version)
+        if self.gen_cil:
+            return ""
         else:
-            return "module %s %s;" % (self.name, self.version)
+            if self.refpolicy:
+                return "policy_module(%s, %s)" % (self.name, self.version)
+            else:
+                return "module %s %s;" % (self.name, self.version)
 
 class Conditional(Node):
     def __init__(self, parent=None):
@@ -729,7 +853,10 @@ class InitialSid(Leaf):
         self.context = None
 
     def to_string(self):
-        return "sid %s %s" % (self.name, str(self.context))
+        if self.gen_cil:
+            return "(sid %s %s)" % (self.name, str(self.context))
+        else:
+            return "sid %s %s" % (self.name, str(self.context))
 
 class GenfsCon(Leaf):
     def __init__(self, parent=None):
@@ -739,7 +866,10 @@ class GenfsCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "genfscon %s %s %s" % (self.filesystem, self.path, str(self.context))
+        if self.gen_cil:
+            return "(genfscon %s %s %s)" % (self.filesystem, self.path, str(self.context))
+        else:
+            return "genfscon %s %s %s" % (self.filesystem, self.path, str(self.context))
 
 class FilesystemUse(Leaf):
     XATTR = 1
@@ -754,14 +884,24 @@ class FilesystemUse(Leaf):
 
     def to_string(self):
         s = ""
-        if self.type == self.XATTR:
-            s = "fs_use_xattr "
-        elif self.type == self.TRANS:
-            s = "fs_use_trans "
-        elif self.type == self.TASK:
-            s = "fs_use_task "
+        if self.gen_cil:
+            if self.type == self.XATTR:
+                s = "fsuse xattr "
+            elif self.type == self.TRANS:
+                s = "fsuse trans "
+            elif self.type == self.TASK:
+                s = "fsuse task "
+
+            return "(%s %s %s)" % (s, self.filesystem, str(self.context))
+        else:
+            if self.type == self.XATTR:
+                s = "fs_use_xattr "
+            elif self.type == self.TRANS:
+                s = "fs_use_trans "
+            elif self.type == self.TASK:
+                s = "fs_use_task "
 
-        return "%s %s %s;" % (s, self.filesystem, str(self.context))
+            return "%s %s %s;" % (s, self.filesystem, str(self.context))
 
 class PortCon(Leaf):
     def __init__(self, parent=None):
@@ -771,7 +911,10 @@ class PortCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "portcon %s %s %s" % (self.port_type, self.port_number, str(self.context))
+        if self.gen_cil:
+            return "(portcon %s %s %s)" % (self.port_type, self.port_number, str(self.context))
+        else:
+            return "portcon %s %s %s" % (self.port_type, self.port_number, str(self.context))
 
 class NodeCon(Leaf):
     def __init__(self, parent=None):
@@ -781,7 +924,10 @@ class NodeCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "nodecon %s %s %s" % (self.start, self.end, str(self.context))
+        if self.gen_cil:
+            return "(nodecon %s %s %s)" % (self.start, self.end, str(self.context))
+        else:
+            return "nodecon %s %s %s" % (self.start, self.end, str(self.context))
 
 class NetifCon(Leaf):
     def __init__(self, parent=None):
@@ -791,8 +937,13 @@ class NetifCon(Leaf):
         self.packet_context = None
 
     def to_string(self):
-        return "netifcon %s %s %s" % (self.interface, str(self.interface_context),
-                                   str(self.packet_context))
+        if self.gen_cil:
+            return "(netifcon %s %s %s)" % (self.interface, str(self.interface_context),
+                                            str(self.packet_context))
+        else:
+            return "netifcon %s %s %s" % (self.interface, str(self.interface_context),
+                                          str(self.packet_context))
+
 class PirqCon(Leaf):
     def __init__(self, parent=None):
         Leaf.__init__(self, parent)
@@ -800,7 +951,10 @@ class PirqCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "pirqcon %s %s" % (self.pirq_number, str(self.context))
+        if self.gen_cil:
+            return "(pirqcon %s %s)" % (self.pirq_number, str(self.context))
+        else:
+            return "pirqcon %s %s" % (self.pirq_number, str(self.context))
 
 class IomemCon(Leaf):
     def __init__(self, parent=None):
@@ -809,7 +963,10 @@ class IomemCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "iomemcon %s %s" % (self.device_mem, str(self.context))
+        if self.gen_cil:
+            return "(iomemcon %s %s)" % (self.device_mem, str(self.context))
+        else:
+            return "iomemcon %s %s" % (self.device_mem, str(self.context))
 
 class IoportCon(Leaf):
     def __init__(self, parent=None):
@@ -818,7 +975,10 @@ class IoportCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "ioportcon %s %s" % (self.ioport, str(self.context))
+        if self.gen_cil:
+            return "(ioportcon %s %s)" % (self.ioport, str(self.context))
+        else:
+            return "ioportcon %s %s" % (self.ioport, str(self.context))
 
 class PciDeviceCon(Leaf):
     def __init__(self, parent=None):
@@ -827,7 +987,10 @@ class PciDeviceCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "pcidevicecon %s %s" % (self.device, str(self.context))
+        if self.gen_cil:
+            return "(pcidevicecon %s %s)" % (self.device, str(self.context))
+        else:
+            return "pcidevicecon %s %s" % (self.device, str(self.context))
 
 class DeviceTreeCon(Leaf):
     def __init__(self, parent=None):
@@ -836,7 +999,10 @@ class DeviceTreeCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "devicetreecon %s %s" % (self.path, str(self.context))
+        if self.gen_cil:
+            return "(devicetreecon %s %s)" % (self.path, str(self.context))
+        else:
+            return "devicetreecon %s %s" % (self.path, str(self.context))
 
 # Reference policy specific types
 
@@ -993,25 +1159,33 @@ class Require(Leaf):
 
     def to_string(self):
         s = []
-        s.append("require {")
-        for type in self.types:
-            s.append("\ttype %s;" % type)
-        for obj_class, perms in self.obj_classes.items():
-            s.append("\tclass %s %s;" % (obj_class, perms.to_space_str()))
-        for role in self.roles:
-            s.append("\trole %s;" % role)
-        for bool in self.data:
-            s.append("\tbool %s;" % bool)
-        for user in self.users:
-            s.append("\tuser %s;" % user)
-        s.append("}")
-
-        # Handle empty requires
-        if len(s) == 2:
-            return ""
-
-        return "\n".join(s)
-
+        if self.gen_cil:
+            # Can't require classes, perms, booleans, users
+            for type in self.types:
+                s.append("(typeattributeset cil_gen_require %s)" % type)
+            for role in self.roles:
+                s.append("(roleattributeset cil_gen_require %s)" % role)
+
+            return "\n".join(s)
+        else:
+            s.append("require {")
+            for type in self.types:
+                s.append("\ttype %s;" % type)
+            for obj_class, perms in self.obj_classes.items():
+                s.append("\tclass %s %s;" % (obj_class, perms.to_space_str()))
+            for role in self.roles:
+                s.append("\trole %s;" % role)
+            for bool in self.data:
+                s.append("\tbool %s;" % bool)
+            for user in self.users:
+                s.append("\tuser %s;" % user)
+            s.append("}")
+
+            # Handle empty requires
+            if len(s) == 2:
+                return ""
+
+            return "\n".join(s)
 
 class ObjPermSet:
     def __init__(self, name):
@@ -1044,7 +1218,10 @@ class Comment:
         else:
             out = []
             for line in self.lines:
-                out.append("#" + line)
+                if self.gen_cil:
+                    out.append(";" + line)
+                else:
+                    out.append("#" + line)
             return "\n".join(out)
 
     def merge(self, other):
@@ -1056,4 +1233,5 @@ class Comment:
     def __str__(self):
         return self.to_string()
 
-
+    def set_gen_cil(self, gen_cil):
+        self.gen_cil = gen_cil

base-commit: 82195e77e317d322dd9b5fc31d402462d6845357
-- 
2.43.0

