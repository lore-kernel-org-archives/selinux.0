Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2515EA2
	for <selinux@vger.kernel.org>; Sat,  2 Mar 2024 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709413007; cv=none; b=u4YhjzqfZ2QKKyFKY8O8rvPS27e5xEaAi1p50gdX+CkgyWBiWg9QiYYl6EiRqXrlYlOmq6OQs/PO9+mhHFTeBUic/TW/49V9N/V2hEL/DUNu+2ICWK1r97ybWnO+RDI9fHPZFLPRoG6D52c5y3WUoFMTnX5JhV9y1umcpNOX+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709413007; c=relaxed/simple;
	bh=W7zqsM0MjX7Jc9J/VV6YTnzt1LXaOe2C1w0iHU7bavo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fm7P90ILs0gMPY2QH+CNPdNaN9AOg+lQlI1MBFjl3xvX5AbhSPsrQoMwM0mv7d3TKPQ+fndDUAo7bVcc+pkBdXFgpCRxIThrLYBvDSI7tQwAd/SlJ3MCHtbihHIF18u/4kH2MyIJ6E0xFtaTeacFqF/Wvv+AG7HKDoyMY296izk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku6utxqu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku6utxqu"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d208be133bso40136451fa.2
        for <selinux@vger.kernel.org>; Sat, 02 Mar 2024 12:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709413002; x=1710017802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gbhs66wJzkxxbG7KxN8/nL6pqUETFyrSBrZcPspbSZM=;
        b=Ku6utxquvAdAfEdz9bUizTi6EZMzNhL1er9ant0XJMG4KUBPUlHrx8i6vEbOHljr8l
         +Sx91QdpqhA0KCWJTQN++273Q52HO2ASreHNR0VpTfyFRaOjNxQ01sC8N5IqDZwBMPgb
         yOdziYdsqe7Qzh+VhLUI9ylvVCPmVqSGUQufsSS076XHuaHXtqZ3S0qce8qPbmJLjvjc
         Zes8z6g+eExY1KpI9NlNDjRZ5dpDyDj2qLM065uTE4okFkSynN7trsh5BI7TFcaskzlS
         TTSE6mvmmiq7ZGpBH7IYs8bT3wvUnsBWJZGrvjPqJojyuAo6Go6izaUia23BRPM7jQca
         brng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709413002; x=1710017802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbhs66wJzkxxbG7KxN8/nL6pqUETFyrSBrZcPspbSZM=;
        b=jUo53IkHYhKzJzyldTHbl5AcJ1YRqj/5gwGmaJh3O7rv2lTJgodLXHlc1ESWqWG592
         /aK8fQJYr/YT5hWzRA/uQLRlBzQeGCZ6pmGA5DJtOPBPDkMJs0rarqcD21rlZAIMzSEM
         60msSTLymSrZ8tmNu73Q52t+mLajfX7o8JRi6oX9rBSfQw9Lzv4GY/XV9LMJRG1M0Hf1
         jE2iwAgEszPum1mpuHQRl7FW9Ej4gxr0o4rcRZltJPWYzBb6fxf3PNVbDIQpb4sJHY63
         URgH1dZKhUnd2KbU1VknEv+XkLrXu+MWNqxoXVYV/3vM5ajpfsYOUXL2KIJJOZsLhsim
         Q6PA==
X-Gm-Message-State: AOJu0Yzlm86PBJh1uEwWw/cNw8fXmWoqshgkD/kAAa3knVx+EjOa5xzQ
	2cGL5fhqmPRfAbJiDPEgCDbwPK+QAlLMhSjdk/txw83xSQDRx5QapBfr2twA
X-Google-Smtp-Source: AGHT+IH19dOvoCZ2gtjHoEqEziJ4i46u1sEg03el7c9NUq0KujiZ+7PiMyu6khrj2kZ7ainp2wxonw==
X-Received: by 2002:a05:6512:3089:b0:512:f679:665b with SMTP id z9-20020a056512308900b00512f679665bmr4067639lfd.42.1709413001734;
        Sat, 02 Mar 2024 12:56:41 -0800 (PST)
Received: from localhost.localdomain (85-156-69-24.elisa-laajakaista.fi. [85.156.69.24])
        by smtp.gmail.com with ESMTPSA id c2-20020ac24142000000b00513021f5b96sm1093339lfi.59.2024.03.02.12.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 12:56:41 -0800 (PST)
From: Topi Miettinen <toiwoton@gmail.com>
To: selinux@vger.kernel.org
Cc: Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH PR#420 v3] audit2allow: CIL output mode
Date: Sat,  2 Mar 2024 22:55:47 +0200
Message-ID: <20240302205546.5706-2-toiwoton@gmail.com>
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
v3: fixed extended permissions syntax
v2: fix uninitialized variable detected by CI
---
 python/audit2allow/audit2allow            |  14 +-
 python/audit2allow/audit2allow.1          |   3 +
 python/sepolgen/src/sepolgen/output.py    |   5 +
 python/sepolgen/src/sepolgen/policygen.py |  29 +-
 python/sepolgen/src/sepolgen/refpolicy.py | 314 +++++++++++++++++-----
 5 files changed, 279 insertions(+), 86 deletions(-)

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
index 183b41a9..93d02cf0 100644
--- a/python/sepolgen/src/sepolgen/policygen.py
+++ b/python/sepolgen/src/sepolgen/policygen.py
@@ -86,6 +86,8 @@ class PolicyGenerator:
         self.xperms = False
 
         self.domains = None
+        self.gen_cil = False
+        self.comment_start = '#'
     def set_gen_refpol(self, if_set=None, perm_maps=None):
         """Set whether reference policy interfaces are generated.
 
@@ -128,6 +130,10 @@ class PolicyGenerator:
         """
         self.xperms = xperms
 
+    def set_gen_cil(self, gen_cil):
+        self.gen_cil = gen_cil
+        self.comment_start = ';'
+
     def __set_module_style(self):
         if self.ifgen:
             refpolicy = True
@@ -173,26 +179,27 @@ class PolicyGenerator:
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
@@ -206,9 +213,9 @@ class PolicyGenerator:
                     if i not in self.domains:
                         types.append(i)
                 if len(types) == 1:
-                    rule.comment += "\n#!!!! The source type '%s' can write to a '%s' of the following type:\n# %s\n" % ( av.src_type, av.obj_class, ", ".join(types))
+                    rule.comment += "\n%s!!!! The source type '%s' can write to a '%s' of the following type:\n# %s\n" % (self.comment_start, av.src_type, av.obj_class, ", ".join(types))
                 elif len(types) >= 1:
-                    rule.comment += "\n#!!!! The source type '%s' can write to a '%s' of the following types:\n# %s\n" % ( av.src_type, av.obj_class, ", ".join(types))
+                    rule.comment += "\n%s!!!! The source type '%s' can write to a '%s' of the following types:\n# %s\n" % (self.comment_start, av.src_type, av.obj_class, ", ".join(types))
         except:
             pass
 
diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index 9cac1b95..e7fa5645 100644
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
@@ -426,7 +441,13 @@ class TypeAttribute(Leaf):
         self.attributes = IdSet()
 
     def to_string(self):
-        return "typeattribute %s %s;" % (self.type, self.attributes.to_comma_str())
+        if self.gen_cil:
+            s = ""
+            for a in self.attributes:
+                s += "(typeattribute %s %s)" % (self.type, a)
+            return s
+        else:
+            return "typeattribute %s %s;" % (self.type, self.attributes.to_comma_str())
 
 class RoleAttribute(Leaf):
     """SElinux roleattribute statement.
@@ -451,7 +472,10 @@ class Role(Leaf):
     def to_string(self):
         s = ""
         for t in self.types:
-            s += "role %s types %s;\n" % (self.role, t)
+            if self.gen_cil:
+                s += "(roletype %s %s)\n" % (self.role, t)
+            else:
+                s += "role %s types %s;\n" % (self.role, t)
         return s
 
 class Type(Leaf):
@@ -462,12 +486,20 @@ class Type(Leaf):
         self.aliases = IdSet()
 
     def to_string(self):
-        s = "type %s" % self.name
-        if len(self.aliases) > 0:
-            s = s + "alias %s" % self.aliases.to_space_str()
-        if len(self.attributes) > 0:
-            s = s + ", %s" % self.attributes.to_comma_str()
-        return s + ";"
+        if self.gen_cil:
+            s = "(type %s)" % self.name
+            for a in self.aliases:
+                s += "(typealiasactual %s %s)\n" % (self.name, a)
+            for a in self.attributes:
+                s += "(typeattributeset %s %s)\n" % (self.name, a)
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
@@ -476,7 +508,13 @@ class TypeAlias(Leaf):
         self.aliases = IdSet()
 
     def to_string(self):
-        return "typealias %s alias %s;" % (self.type, self.aliases.to_space_str())
+        if self.gen_cil:
+            s = ""
+            for a in self.aliases:
+                s += "(typealias %s %s)\n" % (self.type, a)
+            return s
+        else:
+            return "typealias %s alias %s;" % (self.type, self.aliases.to_space_str())
 
 class Attribute(Leaf):
     def __init__(self, name="", parent=None):
@@ -484,7 +522,10 @@ class Attribute(Leaf):
         self.name = name
 
     def to_string(self):
-        return "attribute %s;" % self.name
+        if self.gen_cil:
+            return "attribute %s;" % self.name
+        else:
+            return "(typeattribute %s)" % self.name
 
 class Attribute_Role(Leaf):
     def __init__(self, name="", parent=None):
@@ -492,7 +533,10 @@ class Attribute_Role(Leaf):
         self.name = name
 
     def to_string(self):
-        return "attribute_role %s;" % self.name
+        if self.gen_cil:
+            return "(roleattribute %s)" % self.name
+        else:
+            return "attribute_role %s;" % self.name
 
 
 # Classes representing rules
@@ -555,11 +599,21 @@ class AVRule(Leaf):
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
@@ -597,6 +651,16 @@ class AVExtRule(Leaf):
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
@@ -612,12 +676,25 @@ class AVExtRule(Leaf):
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
@@ -630,6 +707,7 @@ class TypeRule(Leaf):
     TYPE_CHANGE = 1
     TYPE_MEMBER = 2
 
+    # NB. Filename type transitions are not generated by audit2allow.
     def __init__(self, parent=None):
         Leaf.__init__(self, parent)
         self.src_types = IdSet()
@@ -646,12 +724,28 @@ class TypeRule(Leaf):
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
 
@@ -663,8 +757,13 @@ class TypeBound(Leaf):
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
@@ -673,8 +772,15 @@ class RoleAllow(Leaf):
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
@@ -685,7 +791,10 @@ class RoleType(Leaf):
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
@@ -696,10 +805,13 @@ class ModuleDeclaration(Leaf):
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
@@ -729,7 +841,10 @@ class InitialSid(Leaf):
         self.context = None
 
     def to_string(self):
-        return "sid %s %s" % (self.name, str(self.context))
+        if self.gen_cil:
+            return "(sid %s %s)" % (self.name, str(self.context))
+        else:
+            return "sid %s %s" % (self.name, str(self.context))
 
 class GenfsCon(Leaf):
     def __init__(self, parent=None):
@@ -739,7 +854,10 @@ class GenfsCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "genfscon %s %s %s" % (self.filesystem, self.path, str(self.context))
+        if self.gen_cil:
+            return "(genfscon %s %s %s)" % (self.filesystem, self.path, str(self.context))
+        else:
+            return "genfscon %s %s %s" % (self.filesystem, self.path, str(self.context))
 
 class FilesystemUse(Leaf):
     XATTR = 1
@@ -754,14 +872,24 @@ class FilesystemUse(Leaf):
 
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
@@ -771,7 +899,10 @@ class PortCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "portcon %s %s %s" % (self.port_type, self.port_number, str(self.context))
+        if self.gen_cil:
+            return "(portcon %s %s %s)" % (self.port_type, self.port_number, str(self.context))
+        else:
+            return "portcon %s %s %s" % (self.port_type, self.port_number, str(self.context))
 
 class NodeCon(Leaf):
     def __init__(self, parent=None):
@@ -781,7 +912,10 @@ class NodeCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "nodecon %s %s %s" % (self.start, self.end, str(self.context))
+        if self.gen_cil:
+            return "(nodecon %s %s %s)" % (self.start, self.end, str(self.context))
+        else:
+            return "nodecon %s %s %s" % (self.start, self.end, str(self.context))
 
 class NetifCon(Leaf):
     def __init__(self, parent=None):
@@ -791,8 +925,13 @@ class NetifCon(Leaf):
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
@@ -800,7 +939,10 @@ class PirqCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "pirqcon %s %s" % (self.pirq_number, str(self.context))
+        if self.gen_cil:
+            return "(pirqcon %s %s)" % (self.pirq_number, str(self.context))
+        else:
+            return "pirqcon %s %s" % (self.pirq_number, str(self.context))
 
 class IomemCon(Leaf):
     def __init__(self, parent=None):
@@ -809,7 +951,10 @@ class IomemCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "iomemcon %s %s" % (self.device_mem, str(self.context))
+        if self.gen_cil:
+            return "(iomemcon %s %s)" % (self.device_mem, str(self.context))
+        else:
+            return "iomemcon %s %s" % (self.device_mem, str(self.context))
 
 class IoportCon(Leaf):
     def __init__(self, parent=None):
@@ -818,7 +963,10 @@ class IoportCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "ioportcon %s %s" % (self.ioport, str(self.context))
+        if self.gen_cil:
+            return "(ioportcon %s %s)" % (self.ioport, str(self.context))
+        else:
+            return "ioportcon %s %s" % (self.ioport, str(self.context))
 
 class PciDeviceCon(Leaf):
     def __init__(self, parent=None):
@@ -827,7 +975,10 @@ class PciDeviceCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "pcidevicecon %s %s" % (self.device, str(self.context))
+        if self.gen_cil:
+            return "(pcidevicecon %s %s)" % (self.device, str(self.context))
+        else:
+            return "pcidevicecon %s %s" % (self.device, str(self.context))
 
 class DeviceTreeCon(Leaf):
     def __init__(self, parent=None):
@@ -836,7 +987,10 @@ class DeviceTreeCon(Leaf):
         self.context = None
 
     def to_string(self):
-        return "devicetreecon %s %s" % (self.path, str(self.context))
+        if self.gen_cil:
+            return "(devicetreecon %s %s)" % (self.path, str(self.context))
+        else:
+            return "devicetreecon %s %s" % (self.path, str(self.context))
 
 # Reference policy specific types
 
@@ -993,25 +1147,33 @@ class Require(Leaf):
 
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
@@ -1044,7 +1206,10 @@ class Comment:
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
@@ -1056,4 +1221,5 @@ class Comment:
     def __str__(self):
         return self.to_string()
 
-
+    def set_gen_cil(self, gen_cil):
+        self.gen_cil = gen_cil

base-commit: 82195e77e317d322dd9b5fc31d402462d6845357
-- 
2.43.0

