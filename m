Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1OKL0BK027968
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 15:21:00 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1OKLIo9010105
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 20:21:18 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o1OKKwTl024426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 15:20:59 -0500
Received: from localhost.localdomain (vpn-11-226.rdu.redhat.com [10.11.11.226])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o1OKKwlG000981
	for <selinux@tycho.nsa.gov>; Wed, 24 Feb 2010 15:20:58 -0500
Message-ID: <4B858A2A.8080302@redhat.com>
Date: Wed, 24 Feb 2010 15:20:58 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Audit2allow generating dontaudit rules.
Content-Type: multipart/mixed;
 boundary="------------020202040707030300050604"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020202040707030300050604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------020202040707030300050604
Content-Type: text/plain;
 name="aut2allow_dontaudit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="aut2allow_dontaudit.patch"

diff --git a/policycoreutils/audit2allow/audit2allow b/policycoreutils/audit2allow/audit2allow
index 9186965..0b95071 100644
--- a/policycoreutils/audit2allow/audit2allow
+++ b/policycoreutils/audit2allow/audit2allow
@@ -46,6 +46,9 @@ class AuditToPolicy:
                           help="read input from audit log - conflicts with -i")
         parser.add_option("-d", "--dmesg", action="store_true", dest="dmesg", default=False,
                           help="read input from dmesg - conflicts with --all and --input")
+        parser.add_option("-D", "--dontaudit", action="store_true", 
+                          dest="dontaudit", default=False, 
+                          help="generate dontaudit rules")
         parser.add_option("-i", "--input", dest="input",
                           help="read input from <input> - conflicts with -a")
         parser.add_option("-l", "--lastreload", action="store_true", dest="lastreload", default=False,
@@ -314,7 +317,7 @@ class AuditToPolicy:
             g.set_gen_requires(True)
 
         # Generate the policy
-        g.add_access(self.__avs)
+        g.add_access(self.__avs, self.__options.dontaudit)
         g.add_role_types(self.__role_types)
 
         # Output
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
diff --git a/sepolgen/src/sepolgen/policygen.py b/sepolgen/src/sepolgen/policygen.py
index 55cffeb..52ca4b4 100644
--- a/sepolgen/src/sepolgen/policygen.py
+++ b/sepolgen/src/sepolgen/policygen.py
@@ -141,15 +141,15 @@ class PolicyGenerator:
         """Return the generated module"""
         return self.module
 
-    def __add_allow_rules(self, avs):
+    def __add_allow_rules(self, avs, dontaudit):
         for av in avs:
-            rule = refpolicy.AVRule(av)
+            rule = refpolicy.AVRule(av, dontaudit=dontaudit)
             if self.explain:
                 rule.comment = refpolicy.Comment(explain_access(av, verbosity=self.explain))
             self.module.children.append(rule)
 
 
-    def add_access(self, av_set):
+    def add_access(self, av_set, dontaudit=False):
         """Add the access from the access vector set to this
         module.
         """
@@ -165,7 +165,7 @@ class PolicyGenerator:
             raw_allow = av_set
 
         # Generate the raw allow rules from the filtered list
-        self.__add_allow_rules(raw_allow)
+        self.__add_allow_rules(raw_allow, dontaudit)
 
     def add_role_types(self, role_type_set):
         for role_type in role_type_set:
diff --git a/sepolgen/src/sepolgen/refpolicy.py b/sepolgen/src/sepolgen/refpolicy.py
index b138e3d..f2cf057 100644
--- a/sepolgen/src/sepolgen/refpolicy.py
+++ b/sepolgen/src/sepolgen/refpolicy.py
@@ -420,13 +420,16 @@ class AVRule(Leaf):
     AUDITALLOW = 2
     NEVERALLOW = 3
 
-    def __init__(self, av=None, parent=None):
+    def __init__(self, av=None, parent=None, dontaudit=False):
         Leaf.__init__(self, parent)
         self.src_types = IdSet()
         self.tgt_types = IdSet()
         self.obj_classes = IdSet()
         self.perms = IdSet()
-        self.rule_type = self.ALLOW
+        if dontaudit:
+            self.rule_type = self.DONTAUDIT
+        else:
+            self.rule_type = self.ALLOW
         if av:
             self.from_av(av)
 

--------------020202040707030300050604--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
