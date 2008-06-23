Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5NIsNvl003670
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 14:54:23 -0400
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5NIsMGK022113
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 18:54:22 GMT
Received: by wx-out-0506.google.com with SMTP id i26so953509wxd.30
        for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 11:54:22 -0700 (PDT)
Message-ID: <485FF153.9060005@mentalrootkit.com>
Date: Mon, 23 Jun 2008 14:54:11 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [patch] sepolgen: fix role-type associations and role allow	rules
References: <485A7E7B.1080707@manicmethod.com> <1213896552.32066.299.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1213896552.32066.299.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------080409000803020802070002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080409000803020802070002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Thu, 2008-06-19 at 11:42 -0400, Joshua Brindle wrote:
>   
>> This was written by Karl but he is currently unable to send patches
>>     
>
> Also need to fix it to extract the right type (the new type from the
> transition, not the tcontext type) from the error message.
> Use audit2allow -r < avc with the attached avc to test.
>
> Correct output is:
> require {
> 	type updpwd_t;
> 	role unconfined_r;
> }
>
> role unconfined_r types updpwd_t;
>
>   
Updated patch attached.

Karl

--------------080409000803020802070002
Content-Type: text/plain;
 name="role_type.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="role_type.diff"

Index: policycoreutils/audit2allow/audit2allow
===================================================================
--- policycoreutils/audit2allow/audit2allow	(revision 2913)
+++ policycoreutils/audit2allow/audit2allow	(working copy)
@@ -152,12 +152,13 @@
 
     def __process_input(self):
         if self.__options.type:
-            avcfilter = audit.TypeFilter(self.__options.type)
+            avcfilter = audit.AVCTypeFilter(self.__options.type)
             self.__avs = self.__parser.to_access(avcfilter)
-            self.__selinux_errs = self.__parser.to_role(avcfilter)
+            csfilter = audit.ComputeSidTypeFilter(self.__options.type)
+            self.__role_types = self.__parser.to_role(csfilter)
         else:
             self.__avs = self.__parser.to_access()
-            self.__selinux_errs = self.__parser.to_role()
+            self.__role_types = self.__parser.to_role()
 
     def __load_interface_info(self):
         # Load interface info file
@@ -310,6 +311,7 @@
 
         # Generate the policy
         g.add_access(self.__avs)
+        g.add_role_types(self.__role_types)
 
         # Output
         writer = output.ModuleWriter()
@@ -328,12 +330,6 @@
                 fd = sys.stdout
             writer.write(g.get_module(), fd)
 
-            if len(self.__selinux_errs) > 0:
-                fd.write("\n=========== ROLES ===============\n")
-
-            for role in self.__selinux_errs:
-                fd.write(role.output())
-
     def main(self):
         try:
             self.__parse_options()
Index: sepolgen/src/sepolgen/policygen.py
===================================================================
--- sepolgen/src/sepolgen/policygen.py	(revision 2913)
+++ sepolgen/src/sepolgen/policygen.py	(working copy)
@@ -167,7 +167,14 @@
         if self.gen_requires:
             gen_requires(self.module)
 
+    def add_role_types(self, role_type_set):
+        for role_type in role_type_set:
+            self.module.children.append(role_type)
 
+        # Generate the requires
+        if self.gen_requires:
+            gen_requires(self.module)
+
 def explain_access(av, ml=None, verbosity=SHORT_EXPLANATION):
     """Explain why a policy statement was generated.
 
@@ -334,8 +341,12 @@
                 # can actually figure those out.
                 r.types.add(arg)
 
+        for role_type in node.role_types():
+            r.roles.add(role_type.role)
+            r.types.update(role_type.types)
+                
         r.types.discard("self")
-                
+
         node.children.insert(0, r)
 
     # FUTURE - this is untested on modules with any sort of
Index: sepolgen/src/sepolgen/refpolicy.py
===================================================================
--- sepolgen/src/sepolgen/refpolicy.py	(revision 2913)
+++ sepolgen/src/sepolgen/refpolicy.py	(working copy)
@@ -122,6 +122,12 @@
     def roles(self):
         return itertools.ifilter(lambda x: isinstance(x, Role), walktree(self))
 
+    def role_allows(self):
+        return itertools.ifilter(lambda x: isinstance(x, RoleAllow), walktree(self))
+
+    def role_types(self):
+        return itertools.ifilter(lambda x: isinstance(x, RoleType), walktree(self))
+
     def __str__(self):
         if self.comment:
             return str(self.comment) + "\n" + self.to_string()
@@ -494,6 +500,15 @@
         return "allow %s %s;" % (self.src_roles.to_comma_str(),
                                  self.tgt_roles.to_comma_str())
 
+class RoleType(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.role = ""
+        self.types = IdSet()
+
+    def to_string(self):
+        return "role %s types %s;" % (self.role, self.types.to_comma_str())
+
 class ModuleDeclaration(Leaf):
     def __init__(self, parent=None):
         Leaf.__init__(self, parent)
Index: sepolgen/src/sepolgen/output.py
===================================================================
--- sepolgen/src/sepolgen/output.py	(revision 2913)
+++ sepolgen/src/sepolgen/output.py	(working copy)
@@ -101,6 +101,8 @@
         else:
             return id_set_cmp(a.src_types, [b.args[0]])
                 
+def role_type_cmp(a, b):
+    return cmp(a.role, b.role)
 
 def sort_filter(module):
     """Sort and group the output for readability.
@@ -146,6 +148,18 @@
 
         c.extend(sep_rules)
 
+
+        ras = []
+        ras.extend(node.role_types())
+        ras.sort(role_type_cmp)
+        if len(ras):
+            comment = refpolicy.Comment()
+            comment.lines.append("============= ROLES ==============")
+            c.append(comment)
+        
+
+        c.extend(ras)
+
         # Everything else
         for child in node.children:
             if child not in c:
Index: sepolgen/src/sepolgen/access.py
===================================================================
--- sepolgen/src/sepolgen/access.py	(revision 2913)
+++ sepolgen/src/sepolgen/access.py	(working copy)
@@ -295,3 +295,32 @@
             perms[av.obj_class] = s
         s.update(av.perms)
     return perms
+
+class RoleTypeSet:
+    """A non-overlapping set of role type statements.
+
+    This clas allows the incremental addition of role type statements and
+    maintains a non-overlapping list of statements.
+    """
+    def __init__(self):
+        """Initialize an access vector set."""
+        self.role_types = {}
+
+    def __iter__(self):
+        """Iterate over all of the unique role allows statements in the set."""
+        for role_type in self.role_types.values():
+            yield role_type
+
+    def __len__(self):
+        """Return the unique number of role allow statements."""
+        return len(self.roles)
+
+    def add(self, role, type):
+        if self.role_types.has_key(role):
+            role_type = self.role_types[role]
+        else:
+            role_type = refpolicy.RoleType()
+            role_type.role = role
+            self.role_types[role] = role_type
+
+        role_type.types.add(type)
Index: sepolgen/src/sepolgen/audit.py
===================================================================
--- sepolgen/src/sepolgen/audit.py	(revision 2913)
+++ sepolgen/src/sepolgen/audit.py	(working copy)
@@ -235,20 +235,21 @@
     """
     def __init__(self, message):
         AuditMessage.__init__(self, message)
-        self.type = ""
-        self.role = ""
+        self.invalid_context = refpolicy.SecurityContext()
+        self.scontext = refpolicy.SecurityContext()
+        self.tcontext = refpolicy.SecurityContext()
+        self.tclass = ""
 
     def from_split_string(self, recs):
         AuditMessage.from_split_string(self, recs)
-        dict={}
-        for i in recs:
-            t = i.split('=')
-            if len(t) < 2:
-                continue
-            dict[t[0]]=t[1]
+        if len(recs) < 10:
+            raise ValueError("Split string does not represent a valid compute sid message")
+
         try:
-            self.role = refpolicy.SecurityContext(dict["scontext"]).role
-            self.type = refpolicy.SecurityContext(dict["tcontext"]).type
+            self.invalid_context = refpolicy.SecurityContext(recs[5])
+            self.scontext = refpolicy.SecurityContext(recs[7].split("=")[1])
+            self.tcontext = refpolicy.SecurityContext(recs[8].split("=")[1])
+            self.tclass = recs[9].split("=")[1]
         except:
             raise ValueError("Split string does not represent a valid compute sid message")
     def output(self):
@@ -405,7 +406,7 @@
         self.__post_process()
 
     def to_role(self, role_filter=None):
-        """Return list of SELINUX_ERR messages matching the specified filter
+        """Return RoleAllowSet statements matching the specified filter
 
         Filter out types that match the filer, or all roles
 
@@ -416,13 +417,12 @@
            Access vector set representing the denied access in the
            audit logs parsed by this object.
         """
-        roles = []
-        if role_filter:
-            for selinux_err in self.compute_sid_msgs:
-                if role_filter.filter(selinux_err):
-                    roles.append(selinux_err)
-            return roles
-        return self.compute_sid_msgs
+        role_types = access.RoleTypeSet()
+        for cs in self.compute_sid_msgs:
+            if not role_filter or role_filter.filter(cs):
+                role_types.add(cs.invalid_context.role, cs.invalid_context.type)
+        
+        return role_types
 
     def to_access(self, avc_filter=None, only_denials=True):
         """Convert the audit logs access into a an access vector set.
@@ -454,7 +454,7 @@
                            avc.accesses, avc)
         return av_set
 
-class TypeFilter:
+class AVCTypeFilter:
     def __init__(self, regex):
         self.regex = re.compile(regex)
 
@@ -465,4 +465,17 @@
             return True
         return False
 
+class ComputeSidTypeFilter:
+    def __init__(self, regex):
+        self.regex = re.compile(regex)
 
+    def filter(self, avc):
+        if self.regex.match(avc.invalid_context.type):
+            return True
+        if self.regex.match(avc.scontext.type):
+            return True
+        if self.regex.match(avc.tcontext.type):
+            return True
+        return False
+
+

--------------080409000803020802070002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
