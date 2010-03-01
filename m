Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o21Kjofw018091
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 15:45:54 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o21KjZq1003130
	for <selinux@tycho.nsa.gov>; Mon, 1 Mar 2010 20:45:35 GMT
Message-ID: <4B8C277E.6020608@redhat.com>
Date: Mon, 01 Mar 2010 15:45:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <karlwmacmillan@gmail.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Audit2allow generating dontaudit rules.
References: <4B858A2A.8080302@redhat.com> <10143821003011129w6257e547ua14c2c98ec6ace77@mail.gmail.com>
In-Reply-To: <10143821003011129w6257e547ua14c2c98ec6ace77@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------010504040508060000000309"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010504040508060000000309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 03/01/2010 02:29 PM, Karl MacMillan wrote:
> I'd rather pass in the rule type to the AVRule init rather than a
> boolean about this being a dontaudit rule.
>
> Karl
>
> On Wed, Feb 24, 2010 at 3:20 PM, Daniel J Walsh<dwalsh@redhat.com>  wrote:
>    
>>
>>      
How about this patch.  Moves the dontaudit up the chain a little bit.  
Is this what you want.

--------------010504040508060000000309
Content-Type: text/plain;
 name="audit2allow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="audit2allow.patch"

diff --git a/policycoreutils/audit2allow/audit2allow b/policycoreutils/audit2allow/audit2allow
index 9186965..1c7d896 100644
--- a/policycoreutils/audit2allow/audit2allow
+++ b/policycoreutils/audit2allow/audit2allow
@@ -58,6 +58,9 @@ class AuditToPolicy:
                           help="generate a module package - conflicts with -o and -m")
         parser.add_option("-o", "--output", dest="output",
                           help="append output to <filename>, conflicts with -M")
+        parser.add_option("-D", "--dontaudit", action="store_true", 
+                          dest="dontaudit", default=False, 
+                          help="generate policy with dontaudit rules")
         parser.add_option("-R", "--reference", action="store_true", dest="refpolicy",
                           default=True, help="generate refpolicy style output")
 
@@ -153,11 +156,11 @@ class AuditToPolicy:
     def __process_input(self):
         if self.__options.type:
             avcfilter = audit.AVCTypeFilter(self.__options.type)
-            self.__avs = self.__parser.to_access(avcfilter)
+            self.__avs = self.__parser.to_access(avcfilter, dontaudit=self.__options.dontaudit)
             csfilter = audit.ComputeSidTypeFilter(self.__options.type)
             self.__role_types = self.__parser.to_role(csfilter)
         else:
-            self.__avs = self.__parser.to_access()
+            self.__avs = self.__parser.to_access(dontaudit=self.__options.dontaudit)
             self.__role_types = self.__parser.to_role()
 
     def __load_interface_info(self):
diff --git a/policycoreutils/audit2allow/audit2allow.1 b/policycoreutils/audit2allow/audit2allow.1
index c041f75..d9635c2 100644
--- a/policycoreutils/audit2allow/audit2allow.1
+++ b/policycoreutils/audit2allow/audit2allow.1
@@ -25,10 +25,10 @@
 .TH AUDIT2ALLOW "1" "January 2005" "Security Enhanced Linux" NSA
 .SH NAME
 .BR audit2allow
-	\- generate SELinux policy allow rules from logs of denied operations
+\- generate SELinux policy allow/dontaudit rules from logs of denied operations
 
 .BR audit2why  
-	\- translates SELinux audit messages into a description of why the access was denied (audit2allow -w)
+\- translates SELinux audit messages into a description of why the access was denied (audit2allow -w)
 
 .SH SYNOPSIS
 .B audit2allow
@@ -44,6 +44,9 @@ Read input from output of
 Note that all audit messages are not available via dmesg when
 auditd is running; use "ausearch -m avc | audit2allow"  or "-a" instead.
 .TP
+.B "\-D" | "\-\-dontaudit"
+Generate dontaudit rules (Default: allow)
+.TP
 .B "\-h" | "\-\-help"
 Print a short usage message
 .TP
diff --git a/sepolgen/src/sepolgen/access.py b/sepolgen/src/sepolgen/access.py
index 71121d7..88a6db5 100644
--- a/sepolgen/src/sepolgen/access.py
+++ b/sepolgen/src/sepolgen/access.py
@@ -85,6 +85,7 @@ class AccessVector:
             self.obj_class = None
             self.perms = refpolicy.IdSet()
             self.audit_msgs = []
+            self.dontaudit = False
 
         # The direction of the information flow represented by this
         # access vector - used for matching
@@ -253,7 +254,7 @@ class AccessVectorSet:
         for av in l:
             self.add_av(AccessVector(av))
 
-    def add(self, src_type, tgt_type, obj_class, perms, audit_msg=None):
+    def add(self, src_type, tgt_type, obj_class, perms, audit_msg=None, dontaudit=False):
         """Add an access vector to the set.
         """
         tgt = self.src.setdefault(src_type, { })
@@ -266,6 +267,7 @@ class AccessVectorSet:
             access.src_type = src_type
             access.tgt_type = tgt_type
             access.obj_class = obj_class
+            access.dontaudit = dontaudit
             cls[obj_class] = access
 
         access.perms.update(perms)
diff --git a/sepolgen/src/sepolgen/audit.py b/sepolgen/src/sepolgen/audit.py
index efcc40d..80371d0 100644
--- a/sepolgen/src/sepolgen/audit.py
+++ b/sepolgen/src/sepolgen/audit.py
@@ -424,7 +424,7 @@ class AuditParser:
         
         return role_types
 
-    def to_access(self, avc_filter=None, only_denials=True):
+    def to_access(self, avc_filter=None, only_denials=True, dontaudit=False):
         """Convert the audit logs access into a an access vector set.
 
         Convert the audit logs into an access vector set, optionally
@@ -448,10 +448,10 @@ class AuditParser:
             if avc_filter:
                 if avc_filter.filter(avc):
                     av_set.add(avc.scontext.type, avc.tcontext.type, avc.tclass,
-                               avc.accesses, avc)
+                               avc.accesses, avc, dontaudit=dontaudit)
             else:
                 av_set.add(avc.scontext.type, avc.tcontext.type, avc.tclass,
-                           avc.accesses, avc)
+                           avc.accesses, avc, dontaudit=dontaudit)
         return av_set
 
 class AVCTypeFilter:
@@ -477,5 +477,3 @@ class ComputeSidTypeFilter:
         if self.regex.match(avc.tcontext.type):
             return True
         return False
-
-
diff --git a/sepolgen/src/sepolgen/refpolicy.py b/sepolgen/src/sepolgen/refpolicy.py
index b138e3d..782ea3d 100644
--- a/sepolgen/src/sepolgen/refpolicy.py
+++ b/sepolgen/src/sepolgen/refpolicy.py
@@ -449,6 +449,8 @@ class AVRule(Leaf):
             self.tgt_types.add(av.tgt_type)
         self.obj_classes.add(av.obj_class)
         self.perms.update(av.perms)
+        if av.dontaudit:
+            self.rule_type = audit2why.DONTAUDIT
 
     def to_string(self):
         """Return a string representation of the rule

--------------010504040508060000000309--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
