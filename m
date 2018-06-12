Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5C97Hed014150
 for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2018 05:07:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 93A9C401EF22
 for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2018 09:07:10 +0000 (UTC)
From: Jan Zarsky <jzarsky@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 12 Jun 2018 11:06:59 +0200
Message-Id: <20180612090659.5429-1-jzarsky@redhat.com>
In-Reply-To: <CAJfZ7==4xn3ypPJGFzLOPMsD9HRmRUWFZWsUnqeiRHpjndkoDA@mail.gmail.com>
References: <CAJfZ7==4xn3ypPJGFzLOPMsD9HRmRUWFZWsUnqeiRHpjndkoDA@mail.gmail.com>
Subject: [PATCH V2 3/3] python: add xperms support to audit2allow
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add support for extended permissions to audit2allow. Extend AuditParser
to parse the 'ioctlcmd' field in AVC message. Extend PolicyGenerator to
generate allowxperm rules. Add the '-x'/'--xperms' option to audit2allow
to turn on generating of extended permission AV rules.

AVCMessage parses the ioctlcmd field in AVC messages. AuditParser
converts the ioctlcmd values into generic representation of extended
permissions that is stored in access vectors.

Extended permissions are represented by operations (currently only
'ioctl') and values associated to the operations. Values (for example
'~{ 0x42 1234 23-34 }') are stored in the XpermSet class.

PolicyGenerator contains new method to turn on generating of xperms.
When turned on, for each access vector, standard AV rule and possibly
several xperm AV rules are generated. Xperm AV rules are represented by
the AVExtRule class.

With xperm generating turned off, PolicyGenerator provides comments
about extended permissions in certain situations. When the AVC message
contains the ioctlcmd field and the access would be allowed according to
the policy, PolicyGenerator warns about xperm rules being the possible
cause of the denial.

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---

V2 fixes two whitespace issues, in audit.py uses 'except ValueError'
instead of bare except, and fixes typo in error message in policygen.py

 python/audit2allow/audit2allow            |   6 ++
 python/audit2allow/audit2allow.1          |   3 +
 python/audit2allow/test.log               |   1 +
 python/audit2allow/test_audit2allow.py    |   9 ++
 python/sepolgen/src/sepolgen/access.py    |  47 ++++++----
 python/sepolgen/src/sepolgen/audit.py     |  28 ++++--
 python/sepolgen/src/sepolgen/policygen.py | 125 ++++++++++++++++-----------
 python/sepolgen/src/sepolgen/refpolicy.py | 121 ++++++++++++++++++++++++++
 python/sepolgen/tests/test_access.py      | 128 +++++++++++++++++++++++++++
 python/sepolgen/tests/test_audit.py       |  50 +++++++++++
 python/sepolgen/tests/test_policygen.py   | 112 +++++++++++++++++++++++-
 python/sepolgen/tests/test_refpolicy.py   | 139 ++++++++++++++++++++++++++++++
 12 files changed, 692 insertions(+), 77 deletions(-)

diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2allow
index 37ab23af..195f151c 100644
--- a/python/audit2allow/audit2allow
+++ b/python/audit2allow/audit2allow
@@ -86,6 +86,8 @@ class AuditToPolicy:
                           dest="type")
         parser.add_option("--perm-map", dest="perm_map", help="file name of perm map")
         parser.add_option("--interface-info", dest="interface_info", help="file name of interface information")
+        parser.add_option("-x", "--xperms", action="store_true", dest="xperms",
+                          default=False, help="generate extended permission rules")
         parser.add_option("--debug", dest="debug", action="store_true", default=False,
                           help="leave generated modules for -M")
         parser.add_option("-w", "--why", dest="audit2why", action="store_true", default=(os.path.basename(sys.argv[0]) == "audit2why"),
@@ -314,6 +316,10 @@ class AuditToPolicy:
             ifs, perm_maps = self.__load_interface_info()
             g.set_gen_refpol(ifs, perm_maps)
 
+        # Extended permissions
+        if self.__options.xperms:
+            g.set_gen_xperms(True)
+
         # Explanation
         if self.__options.verbose:
             g.set_gen_explain(policygen.SHORT_EXPLANATION)
diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2allow.1
index 21d286b1..c61067b3 100644
--- a/python/audit2allow/audit2allow.1
+++ b/python/audit2allow/audit2allow.1
@@ -85,6 +85,9 @@ This is the default behavior.
 Generate reference policy using installed macros.
 This attempts to match denials against interfaces and may be inaccurate.
 .TP
+.B "\-x" | "\-\-xperms"
+Generate extended permission access vector rules
+.TP
 .B "\-w" | "\-\-why"
 Translates SELinux audit messages into a description of why the access was denied
 
diff --git a/python/audit2allow/test.log b/python/audit2allow/test.log
index 05249dce..718aca7d 100644
--- a/python/audit2allow/test.log
+++ b/python/audit2allow/test.log
@@ -34,3 +34,4 @@ node=mary.example.com type=AVC msg=audit(1166023021.373:910): avc:  denied  { re
 node=lilly.example.com type=AVC_PATH msg=audit(1164783469.561:109):  path="/linuxtest/LVT/lvt/log.current"
 node=lilly.example.com type=SYSCALL msg=audit(1164783469.561:109): arch=14 syscall=11 success=yes exit=0 a0=10120520 a1=10120a78 a2=10120970 a3=118 items=0 ppid=8310 pid=8311 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) comm="smbd" exe="/usr/sbin/smbd" subj=root:system_r:smbd_t:s0 key=(null)
 node=lilly.example.com type=AVC msg=audit(1164783469.561:109): avc:  denied  { append } for  pid=8311 comm="smbd" name="log.current" dev=dm-0 ino=130930 scontext=root:system_r:smbd_t:s0 tcontext=root:object_r:default_t:s0 tclass=dir
+node=lilly.example.com type=AVC msg=audit(1164783469.561:109): avc:  denied  { ioctl } for  pid=8311 comm="smbd" name="log.current" ioctlcmd=0x2a scontext=root:system_r:smbd_t:s0 tcontext=root:object_r:default_t:s0 tclass=tcp_socket
diff --git a/python/audit2allow/test_audit2allow.py b/python/audit2allow/test_audit2allow.py
index a826a9f8..4427dea7 100644
--- a/python/audit2allow/test_audit2allow.py
+++ b/python/audit2allow/test_audit2allow.py
@@ -47,5 +47,14 @@ class Audit2allowTests(unittest.TestCase):
             print(out, err)
         self.assertSuccess("audit2why", p.returncode, err)
 
+    def test_xperms(self):
+        "Verify that xperms generation works"
+        p = Popen(['python', './audit2allow', "-x", "-i", "test.log"], stdout=PIPE)
+        out, err = p.communicate()
+        if err:
+            print(out, err)
+        self.assertTrue(b"allowxperm" in out)
+        self.assertSuccess("xperms", p.returncode, err)
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/python/sepolgen/src/sepolgen/access.py b/python/sepolgen/src/sepolgen/access.py
index 21613eb8..ba80f939 100644
--- a/python/sepolgen/src/sepolgen/access.py
+++ b/python/sepolgen/src/sepolgen/access.py
@@ -78,6 +78,7 @@ class AccessVector(util.Comparison):
      .obj_class - The object class to which access is allowed. [String or None]
      .perms - The permissions allowed to the object class. [IdSet]
      .audit_msgs - The audit messages that generated this access vector [List of strings]
+     .xperms - Extended permissions attached to the AV. [Dictionary {operation: xperm set}]
     """
     def __init__(self, init_list=None):
         if init_list:
@@ -91,6 +92,7 @@ class AccessVector(util.Comparison):
         self.audit_msgs = []
         self.type = audit2why.TERULE
         self.data = []
+        self.xperms = {}
         # when implementing __eq__ also __hash__ is needed on py2
         # if object is muttable __hash__ should be None
         self.__hash__ = None
@@ -132,6 +134,15 @@ class AccessVector(util.Comparison):
         l.extend(sorted(self.perms))
         return l
 
+    def merge(self, av):
+        """Add permissions and extended permissions from AV"""
+        self.perms.update(av.perms)
+
+        for op in av.xperms:
+            if op not in self.xperms:
+                self.xperms[op] = refpolicy.XpermSet()
+            self.xperms[op].extend(av.xperms[op])
+
     def __str__(self):
         return self.to_string()
 
@@ -261,28 +272,28 @@ class AccessVectorSet:
     def add(self, src_type, tgt_type, obj_class, perms, audit_msg=None, avc_type=audit2why.TERULE, data=[]):
         """Add an access vector to the set.
         """
-        tgt = self.src.setdefault(src_type, { })
-        cls = tgt.setdefault(tgt_type, { })
-        
-        if (obj_class, avc_type) in cls:
-            access = cls[obj_class, avc_type]
-        else:
-            access = AccessVector()
-            access.src_type = src_type
-            access.tgt_type = tgt_type
-            access.obj_class = obj_class
-            access.data = data
-            access.type = avc_type
-            cls[obj_class, avc_type] = access
-
-        access.perms.update(perms)
-        if audit_msg:
-            access.audit_msgs.append(audit_msg)
+        av = AccessVector()
+        av.src_type = src_type
+        av.tgt_type = tgt_type
+        av.obj_class = obj_class
+        av.perms = perms
+        av.data = data
+        av.type = avc_type
+
+        self.add_av(av, audit_msg)
 
     def add_av(self, av, audit_msg=None):
         """Add an access vector to the set."""
-        self.add(av.src_type, av.tgt_type, av.obj_class, av.perms)
+        tgt = self.src.setdefault(av.src_type, { })
+        cls = tgt.setdefault(av.tgt_type, { })
+
+        if (av.obj_class, av.type) in cls:
+            cls[av.obj_class, av.type].merge(av)
+        else:
+            cls[av.obj_class, av.type] = av
 
+        if audit_msg:
+            cls[av.obj_class, av.type].audit_msgs.append(audit_msg)
 
 def avs_extract_types(avs):
     types = refpolicy.IdSet()
diff --git a/python/sepolgen/src/sepolgen/audit.py b/python/sepolgen/src/sepolgen/audit.py
index 26ce6c92..daed58ce 100644
--- a/python/sepolgen/src/sepolgen/audit.py
+++ b/python/sepolgen/src/sepolgen/audit.py
@@ -152,6 +152,7 @@ class AVCMessage(AuditMessage):
        access - list of accesses that were allowed or denied
        denial - boolean indicating whether this was a denial (True) or granted
           (False) message.
+       ioctlcmd - ioctl 'request' parameter
 
     An example audit message generated from the audit daemon looks like (line breaks
     added):
@@ -178,6 +179,7 @@ class AVCMessage(AuditMessage):
         self.name = ""
         self.accesses = []
         self.denial = True
+        self.ioctlcmd = None
         self.type = audit2why.TERULE
 
     def __parse_access(self, recs, start):
@@ -237,6 +239,11 @@ class AVCMessage(AuditMessage):
                 self.exe = fields[1][1:-1]
             elif fields[0] == "name":
                 self.name = fields[1][1:-1]
+            elif fields[0] == "ioctlcmd":
+                try:
+                    self.ioctlcmd = int(fields[1], 16)
+                except ValueError:
+                    pass
 
         if not found_src or not found_tgt or not found_class or not found_access:
             raise ValueError("AVC message in invalid format [%s]\n" % self.message)
@@ -522,13 +529,20 @@ class AuditParser:
         for avc in self.avc_msgs:
             if avc.denial != True and only_denials:
                 continue
-            if avc_filter:
-                if avc_filter.filter(avc):
-                    av_set.add(avc.scontext.type, avc.tcontext.type, avc.tclass,
-                               avc.accesses, avc, avc_type=avc.type, data=avc.data)
-            else:
-                av_set.add(avc.scontext.type, avc.tcontext.type, avc.tclass,
-                           avc.accesses, avc, avc_type=avc.type, data=avc.data)
+
+            if not avc_filter or avc_filter.filter(avc):
+                av = access.AccessVector([avc.scontext.type, avc.tcontext.type,
+                                         avc.tclass] + avc.accesses)
+                av.data = avc.data
+                av.type = avc.type
+
+                if avc.ioctlcmd:
+                    xperm_set = refpolicy.XpermSet()
+                    xperm_set.add(avc.ioctlcmd)
+                    av.xperms["ioctl"] = xperm_set
+
+                av_set.add_av(av, audit_msg=avc)
+
         return av_set
 
 class AVCTypeFilter:
diff --git a/python/sepolgen/src/sepolgen/policygen.py b/python/sepolgen/src/sepolgen/policygen.py
index ee664fb7..319da151 100644
--- a/python/sepolgen/src/sepolgen/policygen.py
+++ b/python/sepolgen/src/sepolgen/policygen.py
@@ -50,10 +50,11 @@ class PolicyGenerator:
     in the form of access vectors.
 
     It generates allow rules and optionally module require
-    statements and reference policy interfaces. By default
-    only allow rules are generated. The methods .set_gen_refpol
-    and .set_gen_requires turns on interface generation and
-    requires generation respectively.
+    statements, reference policy interfaces, and extended
+    permission access vector rules. By default only allow rules
+    are generated. The methods .set_gen_refpol, .set_gen_requires
+    and .set_gen_xperms turns on interface generation,
+    requires generation, and xperms rules genration respectively.
 
     PolicyGenerator can also optionally add comments explaining
     why a particular access was allowed based on the audit
@@ -82,6 +83,7 @@ class PolicyGenerator:
             self.module = refpolicy.Module()
 
         self.dontaudit = False
+        self.xperms = False
 
         self.domains = None
     def set_gen_refpol(self, if_set=None, perm_maps=None):
@@ -120,6 +122,12 @@ class PolicyGenerator:
     def set_gen_dontaudit(self, dontaudit):
         self.dontaudit = dontaudit
 
+    def set_gen_xperms(self, xperms):
+        """Set whether extended permission access vector rules
+        are generated.
+        """
+        self.xperms = xperms
+
     def __set_module_style(self):
         if self.ifgen:
             refpolicy = True
@@ -153,51 +161,69 @@ class PolicyGenerator:
         """Return the generated module"""
         return self.module
 
-    def __add_allow_rules(self, avs):
-        for av in avs:
-            rule = refpolicy.AVRule(av)
+    def __add_av_rule(self, av):
+        """Add access vector rule.
+        """
+        rule = refpolicy.AVRule(av)
+
+        if self.dontaudit:
+            rule.rule_type = rule.DONTAUDIT
+        rule.comment = ""
+        if self.explain:
+            rule.comment = str(refpolicy.Comment(explain_access(av, verbosity=self.explain)))
+
+        if av.type == audit2why.ALLOW:
+            rule.comment += "\n#!!!! This avc is allowed in the current policy"
+
+            if av.xperms:
+                rule.comment += "\n#!!!! This av rule may have been overridden by an extended permission av rule"
+
+        if av.type == audit2why.DONTAUDIT:
+            rule.comment += "\n#!!!! This avc has a dontaudit rule in the current policy"
+
+        if av.type == audit2why.BOOLEAN:
+            if len(av.data) > 1:
+                rule.comment += "\n#!!!! This avc can be allowed using one of the these booleans:\n#     %s" % ", ".join([x[0] for x in av.data])
+            else:
+                rule.comment += "\n#!!!! This avc can be allowed using the boolean '%s'" % av.data[0][0]
+
+        if av.type == audit2why.CONSTRAINT:
+            rule.comment += "\n#!!!! This avc is a constraint violation.  You would need to modify the attributes of either the source or target types to allow this access."
+            rule.comment += "\n#Constraint rule: "
+            rule.comment += "\n#\t" + av.data[0]
+            for reason in av.data[1:]:
+                rule.comment += "\n#\tPossible cause is the source %s and target %s are different." % reason
+
+        try:
+            if ( av.type == audit2why.TERULE and
+                 "write" in av.perms and
+                 ( "dir" in av.obj_class or "open" in av.perms )):
+                if not self.domains:
+                    self.domains = seinfo(ATTRIBUTE, name="domain")[0]["types"]
+                types=[]
+
+                for i in [x[TCONTEXT] for x in sesearch([ALLOW], {SCONTEXT: av.src_type, CLASS: av.obj_class, PERMS: av.perms})]:
+                    if i not in self.domains:
+                        types.append(i)
+                if len(types) == 1:
+                    rule.comment += "\n#!!!! The source type '%s' can write to a '%s' of the following type:\n# %s\n" % ( av.src_type, av.obj_class, ", ".join(types))
+                elif len(types) >= 1:
+                    rule.comment += "\n#!!!! The source type '%s' can write to a '%s' of the following types:\n# %s\n" % ( av.src_type, av.obj_class, ", ".join(types))
+        except:
+            pass
+
+        self.module.children.append(rule)
+
+    def __add_ext_av_rules(self, av):
+        """Add extended permission access vector rules.
+        """
+        for op in av.xperms.keys():
+            extrule = refpolicy.AVExtRule(av, op)
+
             if self.dontaudit:
-                rule.rule_type = rule.DONTAUDIT
-            rule.comment = ""
-            if self.explain:
-                rule.comment = str(refpolicy.Comment(explain_access(av, verbosity=self.explain)))
-            if av.type == audit2why.ALLOW:
-                rule.comment += "\n#!!!! This avc is allowed in the current policy"
-            if av.type == audit2why.DONTAUDIT:
-                rule.comment += "\n#!!!! This avc has a dontaudit rule in the current policy"
-
-            if av.type == audit2why.BOOLEAN:
-                if len(av.data) > 1:
-                    rule.comment += "\n#!!!! This avc can be allowed using one of the these booleans:\n#     %s" % ", ".join([x[0] for x in av.data])
-                else:
-                    rule.comment += "\n#!!!! This avc can be allowed using the boolean '%s'" % av.data[0][0]
-
-            if av.type == audit2why.CONSTRAINT:
-                rule.comment += "\n#!!!! This avc is a constraint violation.  You would need to modify the attributes of either the source or target types to allow this access."
-                rule.comment += "\n#Constraint rule: "
-                rule.comment += "\n#\t" + av.data[0]
-                for reason in av.data[1:]:
-                    rule.comment += "\n#\tPossible cause is the source %s and target %s are different." % reason
-
-            try:
-                if ( av.type == audit2why.TERULE and
-                     "write" in av.perms and
-                     ( "dir" in av.obj_class or "open" in av.perms )):
-                    if not self.domains:
-                        self.domains = seinfo(ATTRIBUTE, name="domain")[0]["types"]
-                    types=[]
-
-                    for i in [x[TCONTEXT] for x in sesearch([ALLOW], {SCONTEXT: av.src_type, CLASS: av.obj_class, PERMS: av.perms})]:
-                        if i not in self.domains:
-                            types.append(i)
-                    if len(types) == 1:
-                        rule.comment += "\n#!!!! The source type '%s' can write to a '%s' of the following type:\n# %s\n" % ( av.src_type, av.obj_class, ", ".join(types))
-                    elif len(types) >= 1:
-                        rule.comment += "\n#!!!! The source type '%s' can write to a '%s' of the following types:\n# %s\n" % ( av.src_type, av.obj_class, ", ".join(types))
-            except:
-                pass
-            self.module.children.append(rule)
+                extrule.rule_type = extrule.DONTAUDITXPERM
 
+            self.module.children.append(extrule)
 
     def add_access(self, av_set):
         """Add the access from the access vector set to this
@@ -215,7 +241,10 @@ class PolicyGenerator:
             raw_allow = av_set
 
         # Generate the raw allow rules from the filtered list
-        self.__add_allow_rules(raw_allow)
+        for av in raw_allow:
+            self.__add_av_rule(av)
+            if self.xperms and av.xperms:
+                self.__add_ext_av_rules(av)
 
     def add_role_types(self, role_type_set):
         for role_type in role_type_set:
diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index a262e1c5..c30a8c70 100644
--- a/python/sepolgen/src/sepolgen/refpolicy.py
+++ b/python/sepolgen/src/sepolgen/refpolicy.py
@@ -109,6 +109,9 @@ class Node(PolicyBase):
     def avrules(self):
         return filter(lambda x: isinstance(x, AVRule), walktree(self))
 
+    def avextrules(self):
+        return filter(lambda x: isinstance(x, AVExtRule), walktree(self))
+
     def typerules(self):
         return filter(lambda x: isinstance(x, TypeRule), walktree(self))
 
@@ -352,6 +355,65 @@ class ObjectClass(Leaf):
         self.name = name
         self.perms = IdSet()
 
+class XpermSet():
+    """Extended permission set.
+
+    This class represents one or more extended permissions
+    represented by numeric values or ranges of values. The
+    .complement attribute is used to specify all permission
+    except those specified.
+
+    Two xperm set can be merged using the .extend() method.
+    """
+    def __init__(self, complement=False):
+        self.complement = complement
+        self.ranges = []
+
+    def __normalize_ranges(self):
+        """Ensure that ranges are not overlapping.
+        """
+        self.ranges.sort()
+
+        i = 0
+        while i < len(self.ranges):
+            while i + 1 < len(self.ranges):
+                if self.ranges[i + 1][0] <= self.ranges[i][1] + 1:
+                    self.ranges[i] = (self.ranges[i][0], max(self.ranges[i][1],
+                                                             self.ranges[i + 1][1]))
+                    del self.ranges[i + 1]
+                else:
+                    break
+            i += 1
+
+    def extend(self, s):
+        """Add ranges from an xperm set
+        """
+        self.ranges.extend(s.ranges)
+        self.__normalize_ranges()
+
+    def add(self, minimum, maximum=None):
+        """Add value of range of values to the xperm set.
+        """
+        if maximum is None:
+            maximum = minimum
+        self.ranges.append((minimum, maximum))
+        self.__normalize_ranges()
+
+    def to_string(self):
+        if not self.ranges:
+            return ""
+
+        compl = "~ " if self.complement else ""
+
+        # print single value without braces
+        if len(self.ranges) == 1 and self.ranges[0][0] == self.ranges[0][1]:
+            return compl + str(self.ranges[0][0])
+
+        vals = map(lambda x: str(x[0]) if x[0] == x[1] else "%s-%s" % x,
+                   self.ranges)
+
+        return "%s{ %s }" % (compl, " ".join(vals))
+
 # Basic statements
 
 class TypeAttribute(Leaf):
@@ -499,6 +561,65 @@ class AVRule(Leaf):
                                      self.tgt_types.to_space_str(),
                                      self.obj_classes.to_space_str(),
                                      self.perms.to_space_str())
+
+class AVExtRule(Leaf):
+    """Extended permission access vector rule.
+
+    The AVExtRule class represents allowxperm, dontauditxperm,
+    auditallowxperm, and neverallowxperm rules.
+
+    The source and target types, and object classes are represented
+    by sets containing strings. The operation is a single string,
+    e.g. 'ioctl'. Extended permissions are represented by an XpermSet.
+    """
+    ALLOWXPERM = 0
+    DONTAUDITXPERM = 1
+    AUDITALLOWXPERM = 2
+    NEVERALLOWXPERM = 3
+
+    def __init__(self, av=None, op=None, parent=None):
+        Leaf.__init__(self, parent)
+        self.src_types = IdSet()
+        self.tgt_types = IdSet()
+        self.obj_classes = IdSet()
+        self.rule_type = self.ALLOWXPERM
+        self.xperms = XpermSet()
+        self.operation = op
+        if av:
+            self.from_av(av, op)
+
+    def __rule_type_str(self):
+        if self.rule_type == self.ALLOWXPERM:
+            return "allowxperm"
+        elif self.rule_type == self.DONTAUDITXPERM:
+            return "dontauditxperm"
+        elif self.rule_type == self.AUDITALLOWXPERM:
+            return "auditallowxperm"
+        elif self.rule_type == self.NEVERALLOWXPERM:
+            return "neverallowxperm"
+
+    def from_av(self, av, op):
+        self.src_types.add(av.src_type)
+        if av.src_type == av.tgt_type:
+            self.tgt_types.add("self")
+        else:
+            self.tgt_types.add(av.tgt_type)
+        self.obj_classes.add(av.obj_class)
+        self.operation = op
+        self.xperms = av.xperms[op]
+
+    def to_string(self):
+        """Return a string representation of the rule that is
+        a valid policy language representation (assuming that
+        the types, object class, etc. are valid).
+        """
+        return "%s %s %s:%s %s %s;" % (self.__rule_type_str(),
+                                     self.src_types.to_space_str(),
+                                     self.tgt_types.to_space_str(),
+                                     self.obj_classes.to_space_str(),
+                                     self.operation,
+                                     self.xperms.to_string())
+
 class TypeRule(Leaf):
     """SELinux type rules.
 
diff --git a/python/sepolgen/tests/test_access.py b/python/sepolgen/tests/test_access.py
index d45a823e..73a5407d 100644
--- a/python/sepolgen/tests/test_access.py
+++ b/python/sepolgen/tests/test_access.py
@@ -32,6 +32,7 @@ class TestAccessVector(unittest.TestCase):
         self.assertEqual(a.obj_class, None)
         self.assertTrue(isinstance(a.perms, refpolicy.IdSet))
         self.assertTrue(isinstance(a.audit_msgs, type([])))
+        self.assertTrue(isinstance(a.xperms, type({})))
         self.assertEqual(len(a.audit_msgs), 0)
 
         # Construction from a list
@@ -61,6 +62,10 @@ class TestAccessVector(unittest.TestCase):
         self.assertEqual(a.obj_class, l.obj_class)
         self.assertEqual(a.perms, l.perms)
 
+        l2 = access.AccessVector()
+        with self.assertRaises(ValueError):
+            l2.from_list(['foo', 'bar', 'file'])
+
     def test_to_list(self):
         a = access.AccessVector()
         a.src_type = "foo"
@@ -145,7 +150,80 @@ class TestAccessVector(unittest.TestCase):
 
         b.perms = refpolicy.IdSet(["read", "append"])
         self.assertNotEqual(a, b)
+
+    def test_merge_noxperm(self):
+        """Test merging two AVs without xperms"""
+        a = access.AccessVector(["foo", "bar", "file", "read", "write"])
+        b = access.AccessVector(["foo", "bar", "file", "append"])
+
+        a.merge(b)
+        self.assertEqual(sorted(list(a.perms)), ["append", "read", "write"])
+
+    def text_merge_xperm1(self):
+        """Test merging AV that contains xperms with AV that does not"""
+        a = access.AccessVector(["foo", "bar", "file", "read"])
+        b = access.AccessVector(["foo", "bar", "file", "read"])
+        xp = refpolicy.XpermSet()
+        xp.add(42)
+        xp.add(12345)
+        b.xperms = {"ioctl": xp}
+
+        a.merge(b)
+        self.assertEqual(sorted(list(a.perms)), ["append", "read", "write"])
+        self.assertEqual(list(a.xperms.keys()), ["ioctl"])
+        self.assertEqual(a.xperms["ioctl"].to_string(), "{ 42 12345 }")
+
+    def text_merge_xperm2(self):
+        """Test merging AV that does not contain xperms with AV that does"""
+        a = access.AccessVector(["foo", "bar", "file", "read"])
+        xp = refpolicy.XpermSet()
+        xp.add(42)
+        xp.add(12345)
+        a.xperms = {"ioctl": xp}
+        b = access.AccessVector(["foo", "bar", "file", "read"])
+
+        a.merge(b)
+        self.assertEqual(sorted(list(a.perms)), ["append", "read", "write"])
+        self.assertEqual(list(a.xperms.keys()), ["ioctl"])
+        self.assertEqual(a.xperms["ioctl"].to_string(), "{ 42 12345 }")
+
+    def test_merge_xperm_diff_op(self):
+        """Test merging two AVs that contain xperms with different operation"""
+        a = access.AccessVector(["foo", "bar", "file", "read"])
+        xp1 = refpolicy.XpermSet()
+        xp1.add(23)
+        a.xperms = {"asdf": xp1}
+
+        b = access.AccessVector(["foo", "bar", "file", "read"])
+        xp2 = refpolicy.XpermSet()
+        xp2.add(42)
+        xp2.add(12345)
+        b.xperms = {"ioctl": xp2}
+
+        a.merge(b)
+        self.assertEqual(list(a.perms), ["read"])
+        self.assertEqual(sorted(list(a.xperms.keys())), ["asdf", "ioctl"])
+        self.assertEqual(a.xperms["asdf"].to_string(), "23")
+        self.assertEqual(a.xperms["ioctl"].to_string(), "{ 42 12345 }")
                          
+    def test_merge_xperm_same_op(self):
+        """Test merging two AVs that contain xperms with same operation"""
+        a = access.AccessVector(["foo", "bar", "file", "read"])
+        xp1 = refpolicy.XpermSet()
+        xp1.add(23)
+        a.xperms = {"ioctl": xp1}
+
+        b = access.AccessVector(["foo", "bar", "file", "read"])
+        xp2 = refpolicy.XpermSet()
+        xp2.add(42)
+        xp2.add(12345)
+        b.xperms = {"ioctl": xp2}
+
+        a.merge(b)
+        self.assertEqual(list(a.perms), ["read"])
+        self.assertEqual(list(a.xperms.keys()), ["ioctl"])
+        self.assertEqual(a.xperms["ioctl"].to_string(), "{ 23 42 12345 }")
+
 class TestUtilFunctions(unittest.TestCase):
     def test_is_idparam(self):
         self.assertTrue(access.is_idparam("$1"))
@@ -260,3 +338,53 @@ class TestAccessVectorSet(unittest.TestCase):
         b = access.AccessVectorSet()
         b.from_list(avl)
         self.assertEqual(len(b), 3)
+
+    def test_add_av_first(self):
+        """Test adding first AV to the AV set"""
+        avs = access.AccessVectorSet()
+        av = access.AccessVector(['foo', 'bar', 'file', 'read'])
+
+        avs.add_av(av)
+
+        self.assertEqual(avs.to_list(), [['foo', 'bar', 'file', 'read']])
+
+    def test_add_av_second(self):
+        """Test adding second AV to the AV set with same source and target
+        context and class"""
+        avs = access.AccessVectorSet()
+        av1 = access.AccessVector(['foo', 'bar', 'file', 'read'])
+        av2 = access.AccessVector(['foo', 'bar', 'file', 'write'])
+
+        avs.add_av(av1)
+        avs.add_av(av2)
+
+        self.assertEqual(avs.to_list(), [['foo', 'bar', 'file', 'read',
+                         'write']])
+
+    def test_add_av_with_msg(self):
+        """Test adding audit message"""
+        avs = access.AccessVectorSet()
+        av = access.AccessVector(['foo', 'bar', 'file', 'read'])
+
+        avs.add_av(av, 'test message')
+
+        self.assertEqual(avs.src['foo']['bar']['file', av.type].audit_msgs,
+                         ['test message'])
+
+    def test_add(self):
+        """Test adding AV to the set"""
+        s = access.AccessVectorSet()
+
+        def test_add_av(av, audit_msg=None):
+            self.assertEqual(av.src_type, 'foo')
+            self.assertEqual(av.tgt_type, 'bar')
+            self.assertEqual(av.obj_class, 'file')
+            self.assertEqual(list(av.perms), ['read'])
+            self.assertEqual(av.data, 'test data')
+            self.assertEqual(av.type, 42)
+            self.assertEqual(audit_msg, 'test message')
+
+        s.add_av = test_add_av
+
+        s.add("foo", "bar", "file", refpolicy.IdSet(["read"]),
+              audit_msg='test message', avc_type=42, data='test data')
diff --git a/python/sepolgen/tests/test_audit.py b/python/sepolgen/tests/test_audit.py
index 6379954f..dbe6be2a 100644
--- a/python/sepolgen/tests/test_audit.py
+++ b/python/sepolgen/tests/test_audit.py
@@ -56,6 +56,18 @@ type=SYSCALL msg=audit(1162852201.019:1225): arch=40000003 syscall=11 success=ye
 type=AVC msg=audit(1162852201.019:1225): avc:  denied  { execute_no_trans } for  pid=6974 comm="sh" name="sa1" dev=dm-0 ino=13061698 scontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tcontext=system_u:object_r:lib_t:s0 tclass=file
 type=AVC msg=audit(1162852201.019:1225): avc:  denied  { execute } for  pid=6974 comm="sh" name="sa1" dev=dm-0 ino=13061698 scontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tcontext=system_u:object_r:lib_t:s0 tclass=file"""
 
+xperms1 = """type=AVC msg=audit(1516626657.910:4461): avc:  denied  { ioctl } for  pid=4310 comm="test" path="/root/test" ino=8619937 ioctlcmd=0x42 scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_file_t:s0 tclass=file permissive=0
+"""
+xperms2 = """type=AVC msg=audit(1516626657.910:4461): avc:  denied  { ioctl } for  pid=4310 comm="test" path="/root/test" ino=8619937 ioctlcmd=0x42 scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_file_t:s0 tclass=file permissive=0
+type=AVC msg=audit(1516626657.910:4461): avc:  denied  { ioctl } for  pid=4310 comm="test" path="/root/test" ino=8619937 ioctlcmd=0x1234 scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_file_t:s0 tclass=file permissive=0
+type=AVC msg=audit(1516626657.910:4461): avc:  denied  { ioctl } for  pid=4310 comm="test" path="/root/test" ino=8619937 ioctlcmd=0xdead scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_file_t:s0 tclass=file permissive=0
+type=AVC msg=audit(1516626657.910:4461): avc:  denied  { getattr } for  pid=4310 comm="test" path="/root/test" ino=8619937 scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_file_t:s0 tclass=dir permissive=0
+"""
+xperms_invalid = """type=AVC msg=audit(1516626657.910:4461): avc:  denied  { ioctl } for  pid=4310 comm="test" path="/root/test" ino=8619937 ioctlcmd=asdf scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_file_t:s0 tclass=file permissive=0
+"""
+xperms_without = """type=AVC msg=audit(1516626657.910:4461): avc:  denied  { ioctl } for  pid=4310 comm="test" path="/root/test" ino=8619937 scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_file_t:s0 tclass=file permissive=0
+"""
+
 class TestAVCMessage(unittest.TestCase):
     def test_defs(self):
         avc = sepolgen.audit.AVCMessage(audit1)
@@ -64,6 +76,7 @@ class TestAVCMessage(unittest.TestCase):
         self.assertEqual(avc.tcontext, sc)
         self.assertEqual(avc.tclass, "")
         self.assertEqual(avc.accesses, [])
+        self.assertEqual(avc.ioctlcmd, None)
 
     def test_granted(self):
         avc = sepolgen.audit.AVCMessage(granted1)
@@ -84,6 +97,29 @@ class TestAVCMessage(unittest.TestCase):
 
         self.assertEqual(avc.denial, False)
 
+    def test_xperms(self):
+        """Test that the ioctlcmd field is parsed"""
+        avc = sepolgen.audit.AVCMessage(xperms1)
+        recs = xperms1.split()
+        avc.from_split_string(recs)
+
+        self.assertEqual(avc.ioctlcmd, 66)
+
+    def test_xperms_invalid(self):
+        """Test message with invalid value in the ioctlcmd field"""
+        avc = sepolgen.audit.AVCMessage(xperms_invalid)
+        recs = xperms_invalid.split()
+        avc.from_split_string(recs)
+
+        self.assertIsNone(avc.ioctlcmd)
+
+    def test_xperms_without(self):
+        """Test message without the ioctlcmd field"""
+        avc = sepolgen.audit.AVCMessage(xperms_without)
+        recs = xperms_without.split()
+        avc.from_split_string(recs)
+
+        self.assertIsNone(avc.ioctlcmd)
 
     def test_from_split_string(self):
         # syslog message
@@ -172,6 +208,20 @@ class TestAuditParser(unittest.TestCase):
         self.assertEqual(len(a.invalid_msgs), 0)
         self.assertEqual(len(a.policy_load_msgs), 0)
 
+    def test_parse_xperms(self):
+        """ Test that correct access vectors are generated from a set of AVC
+            denial messages. """
+        a = sepolgen.audit.AuditParser()
+        a.parse_string(xperms2)
+        av_set = a.to_access()
+
+        self.assertEqual(len(av_set), 2)
+        av_list = list(sorted(av_set))
+        self.assertEqual(av_list[0].xperms, {})
+        self.assertEqual(list(av_list[1].xperms), ["ioctl"])
+        self.assertEqual(av_list[1].xperms["ioctl"].ranges, [(66,66),
+            (4660,4660), (57005,57005)])
+
 class TestGeneration(unittest.TestCase):
     def test_generation(self):
         parser = sepolgen.audit.AuditParser()
diff --git a/python/sepolgen/tests/test_policygen.py b/python/sepolgen/tests/test_policygen.py
index 58d1adf3..59496e87 100644
--- a/python/sepolgen/tests/test_policygen.py
+++ b/python/sepolgen/tests/test_policygen.py
@@ -19,13 +19,117 @@
 
 import unittest
 import sepolgen.policygen as policygen
+import sepolgen.access as access
+import sepolgen.refpolicy as refpolicy
 
-class PolicyGenerator(unittest.TestCase):
-    def __init__(self):
-        g = policygen.PolicyGenerator()
-        
+class TestPolicyGenerator(unittest.TestCase):
+    def setUp(self):
+        self.g = policygen.PolicyGenerator()
 
+    def test_init(self):
+        """ Test that extended permission AV rules are not generated by
+            default. """
+        self.assertFalse(self.g.xperms)
 
+    def test_set_gen_xperms(self):
+        """ Test turning on and off generating of extended permission
+            AV rules. """
+        self.g.set_gen_xperms(True)
+        self.assertTrue(self.g.xperms)
+        self.g.set_gen_xperms(False)
+        self.assertFalse(self.g.xperms)
 
+    def test_av_rules(self):
+        """ Test generating of AV rules from access vectors. """
+        av1 = access.AccessVector(["test_src_t", "test_tgt_t", "file", "ioctl"])
+        av2 = access.AccessVector(["test_src_t", "test_tgt_t", "file", "open"])
+        av3 = access.AccessVector(["test_src_t", "test_tgt_t", "file", "read"])
 
+        avs = access.AccessVectorSet()
+        avs.add_av(av1)
+        avs.add_av(av2)
+        avs.add_av(av3)
+
+        self.g.add_access(avs)
+
+        self.assertEqual(len(self.g.module.children), 1)
+        r = self.g.module.children[0]
+        self.assertIsInstance(r, refpolicy.AVRule)
+        self.assertEqual(r.to_string(),
+            "allow test_src_t test_tgt_t:file { ioctl open read };")
+
+    def test_ext_av_rules(self):
+        """ Test generating of extended permission AV rules from access
+            vectors. """
+        self.g.set_gen_xperms(True)
+
+        av1 = access.AccessVector(["test_src_t", "test_tgt_t", "file", "ioctl"])
+        av1.xperms['ioctl'] = refpolicy.XpermSet()
+        av1.xperms['ioctl'].add(42)
+        av2 = access.AccessVector(["test_src_t", "test_tgt_t", "file", "ioctl"])
+        av2.xperms['ioctl'] = refpolicy.XpermSet()
+        av2.xperms['ioctl'].add(1234)
+        av3 = access.AccessVector(["test_src_t", "test_tgt_t", "dir", "ioctl"])
+        av3.xperms['ioctl'] = refpolicy.XpermSet()
+        av3.xperms['ioctl'].add(2345)
+
+        avs = access.AccessVectorSet()
+        avs.add_av(av1)
+        avs.add_av(av2)
+        avs.add_av(av3)
+
+        self.g.add_access(avs)
+
+        self.assertEqual(len(self.g.module.children), 4)
+
+        # we cannot sort the rules, so find all rules manually
+        av_rule1 = av_rule2 = av_ext_rule1 = av_ext_rule2 = None
+
+        for r in self.g.module.children:
+            if isinstance(r, refpolicy.AVRule):
+                if 'file' in r.obj_classes:
+                    av_rule1 = r
+                else:
+                    av_rule2 = r
+            elif isinstance(r, refpolicy.AVExtRule):
+                if 'file' in r.obj_classes:
+                    av_ext_rule1 = r
+                else:
+                    av_ext_rule2 = r
+            else:
+                self.fail("Unexpected rule type '%s'" % type(r))
+
+        # check that all rules are present
+        self.assertNotIn(None, (av_rule1, av_rule2, av_ext_rule1, av_ext_rule2))
+
+        self.assertEqual(av_rule1.rule_type, av_rule1.ALLOW)
+        self.assertEqual(av_rule1.src_types, {"test_src_t"})
+        self.assertEqual(av_rule1.tgt_types, {"test_tgt_t"})
+        self.assertEqual(av_rule1.obj_classes, {"file"})
+        self.assertEqual(av_rule1.perms, {"ioctl"})
+
+        self.assertEqual(av_ext_rule1.rule_type, av_ext_rule1.ALLOWXPERM)
+        self.assertEqual(av_ext_rule1.src_types, {"test_src_t"})
+        self.assertEqual(av_ext_rule1.tgt_types, {"test_tgt_t"})
+        self.assertEqual(av_ext_rule1.obj_classes, {"file"})
+        self.assertEqual(av_ext_rule1.operation, "ioctl")
+        xp1 = refpolicy.XpermSet()
+        xp1.add(42)
+        xp1.add(1234)
+        self.assertEqual(av_ext_rule1.xperms.ranges, xp1.ranges)
+
+        self.assertEqual(av_rule2.rule_type, av_rule2.ALLOW)
+        self.assertEqual(av_rule2.src_types, {"test_src_t"})
+        self.assertEqual(av_rule2.tgt_types, {"test_tgt_t"})
+        self.assertEqual(av_rule2.obj_classes, {"dir"})
+        self.assertEqual(av_rule2.perms, {"ioctl"})
+
+        self.assertEqual(av_ext_rule2.rule_type, av_ext_rule2.ALLOWXPERM)
+        self.assertEqual(av_ext_rule2.src_types, {"test_src_t"})
+        self.assertEqual(av_ext_rule2.tgt_types, {"test_tgt_t"})
+        self.assertEqual(av_ext_rule2.obj_classes, {"dir"})
+        self.assertEqual(av_ext_rule2.operation, "ioctl")
+        xp2 = refpolicy.XpermSet()
+        xp2.add(2345)
+        self.assertEqual(av_ext_rule2.xperms.ranges, xp2.ranges)
 
diff --git a/python/sepolgen/tests/test_refpolicy.py b/python/sepolgen/tests/test_refpolicy.py
index 16e66806..64c48dfd 100644
--- a/python/sepolgen/tests/test_refpolicy.py
+++ b/python/sepolgen/tests/test_refpolicy.py
@@ -19,6 +19,7 @@
 
 import unittest
 import sepolgen.refpolicy as refpolicy
+import sepolgen.access as access
 import selinux
 
 class TestIdSet(unittest.TestCase):
@@ -33,6 +34,74 @@ class TestIdSet(unittest.TestCase):
         s.add("read")
         self.assertEqual(s.to_space_str(), "read")
 
+class TestXpermSet(unittest.TestCase):
+    def test_init(self):
+        """ Test that all atttributes are correctly initialized. """
+        s1 = refpolicy.XpermSet()
+        self.assertEqual(s1.complement, False)
+        self.assertEqual(s1.ranges, [])
+
+        s2 = refpolicy.XpermSet(True)
+        self.assertEqual(s2.complement, True)
+        self.assertEqual(s2.ranges, [])
+
+    def test_normalize_ranges(self):
+        """ Test that ranges that are overlapping or neighboring are correctly
+            merged into one range. """
+        s = refpolicy.XpermSet()
+        s.ranges = [(1, 7), (5, 10), (100, 110), (102, 107), (200, 205),
+            (205, 210), (300, 305), (306, 310), (400, 405), (407, 410),
+            (500, 502), (504, 508), (500, 510)]
+        s._XpermSet__normalize_ranges()
+
+        i = 0
+        r = list(sorted(s.ranges))
+        while i < len(r) - 1:
+            # check that range low bound is less than equal than the upper bound
+            self.assertLessEqual(r[i][0], r[i][1])
+            # check that two ranges are not overlapping or neighboring
+            self.assertGreater(r[i + 1][0] - r[i][1], 1)
+            i += 1
+
+    def test_add(self):
+        """ Test adding new values or ranges to the set. """
+        s = refpolicy.XpermSet()
+        s.add(1, 7)
+        s.add(5, 10)
+        s.add(42)
+        self.assertEqual(s.ranges, [(1,10), (42,42)])
+
+    def test_extend(self):
+        """ Test adding ranges from another XpermSet object. """
+        a = refpolicy.XpermSet()
+        a.add(1, 7)
+
+        b = refpolicy.XpermSet()
+        b.add(5, 10)
+
+        a.extend(b)
+        self.assertEqual(a.ranges, [(1,10)])
+
+    def test_to_string(self):
+        """ Test printing the values to a string. """
+        a = refpolicy.XpermSet()
+        a.complement = False
+        self.assertEqual(a.to_string(), "")
+        a.complement = True
+        self.assertEqual(a.to_string(), "")
+        a.add(1234)
+        self.assertEqual(a.to_string(), "~ 1234")
+        a.complement = False
+        self.assertEqual(a.to_string(), "1234")
+        a.add(2345)
+        self.assertEqual(a.to_string(), "{ 1234 2345 }")
+        a.complement = True
+        self.assertEqual(a.to_string(), "~ { 1234 2345 }")
+        a.add(42,64)
+        self.assertEqual(a.to_string(), "~ { 42-64 1234 2345 }")
+        a.complement = False
+        self.assertEqual(a.to_string(), "{ 42-64 1234 2345 }")
+
 class TestSecurityContext(unittest.TestCase):
     def test_init(self):
         sc = refpolicy.SecurityContext()
@@ -110,6 +179,76 @@ class TestAVRule(unittest.TestCase):
         b.sort()
         self.assertEqual(a, b)
 
+class TestAVExtRule(unittest.TestCase):
+    def test_init(self):
+        """ Test initialization of attributes """
+        a = refpolicy.AVExtRule()
+        self.assertEqual(a.rule_type, a.ALLOWXPERM)
+        self.assertIsInstance(a.src_types, set)
+        self.assertIsInstance(a.tgt_types, set)
+        self.assertIsInstance(a.obj_classes, set)
+        self.assertIsNone(a.operation)
+        self.assertIsInstance(a.xperms, refpolicy.XpermSet)
+
+    def test_rule_type_str(self):
+        """ Test strings returned by __rule_type_str() """
+        a = refpolicy.AVExtRule()
+        self.assertEqual(a._AVExtRule__rule_type_str(), "allowxperm")
+        a.rule_type = a.ALLOWXPERM
+        self.assertEqual(a._AVExtRule__rule_type_str(), "allowxperm")
+        a.rule_type = a.DONTAUDITXPERM
+        self.assertEqual(a._AVExtRule__rule_type_str(), "dontauditxperm")
+        a.rule_type = a.NEVERALLOWXPERM
+        self.assertEqual(a._AVExtRule__rule_type_str(), "neverallowxperm")
+        a.rule_type = a.AUDITALLOWXPERM
+        self.assertEqual(a._AVExtRule__rule_type_str(), "auditallowxperm")
+        a.rule_type = 42
+        self.assertIsNone(a._AVExtRule__rule_type_str())
+
+    def test_from_av(self):
+        """ Test creating the rule from an access vector. """
+        av = access.AccessVector(["foo", "bar", "file", "ioctl"])
+        xp = refpolicy.XpermSet()
+        av.xperms = { "ioctl": xp }
+
+        a = refpolicy.AVExtRule()
+
+        a.from_av(av, "ioctl")
+        self.assertEqual(a.src_types, {"foo"})
+        self.assertEqual(a.tgt_types, {"bar"})
+        self.assertEqual(a.obj_classes, {"file"})
+        self.assertEqual(a.operation, "ioctl")
+        self.assertIs(a.xperms, xp)
+
+    def test_from_av_self(self):
+        """ Test creating the rule from an access vector that has same
+            source and target context. """
+        av = access.AccessVector(["foo", "foo", "file", "ioctl"])
+        xp = refpolicy.XpermSet()
+        av.xperms = { "ioctl": xp }
+
+        a = refpolicy.AVExtRule()
+
+        a.from_av(av, "ioctl")
+        self.assertEqual(a.src_types, {"foo"})
+        self.assertEqual(a.tgt_types, {"self"})
+        self.assertEqual(a.obj_classes, {"file"})
+        self.assertEqual(a.operation, "ioctl")
+        self.assertIs(a.xperms, xp)
+
+    def test_to_string(self):
+        """ Test printing the rule to a string. """
+        a = refpolicy.AVExtRule()
+        a._AVExtRule__rule_type_str = lambda: "first"
+        a.src_types.to_space_str = lambda: "second"
+        a.tgt_types.to_space_str = lambda: "third"
+        a.obj_classes.to_space_str = lambda: "fourth"
+        a.operation = "fifth"
+        a.xperms.to_string = lambda: "seventh"
+
+        self.assertEqual(a.to_string(),
+                         "first second third:fourth fifth seventh;")
+
 class TestTypeRule(unittest.TestCase):
     def test_init(self):
         a = refpolicy.TypeRule()
-- 
2.14.4
