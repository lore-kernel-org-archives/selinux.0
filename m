Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o28JX8VU007223
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2010 14:33:08 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o28JWmEc025502
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2010 19:32:49 GMT
Message-ID: <4B9550EF.5020208@redhat.com>
Date: Mon, 08 Mar 2010 14:33:03 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <karlwmacmillan@gmail.com>
CC: Joshua Brindle <method@manicmethod.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Audit2allow generating dontaudit rules.
References: <4B858A2A.8080302@redhat.com>	 <10143821003011129w6257e547ua14c2c98ec6ace77@mail.gmail.com>	 <4B8C277E.6020608@redhat.com> <4B8C35E7.2020300@redhat.com>	 <4B8FE8FB.6050607@manicmethod.com>	 <10143821003041346o6903d2bbw49863b44d05a2a8c@mail.gmail.com> <10143821003080811l32b1243frcb71d7289b74cd37@mail.gmail.com>
In-Reply-To: <10143821003080811l32b1243frcb71d7289b74cd37@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070904060201000405060208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070904060201000405060208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 03/08/2010 11:11 AM, Karl MacMillan wrote:
> Accidentally sent this straight to Josh.
>
> Karl
>
> On Thu, Mar 4, 2010 at 4:46 PM, Karl MacMillan<karlwmacmillan@gmail.com>  wrote:
>    
>> I meant this - I don't want to pass around a boolean flag when we have
>> a flag for rule type. This allows cleanly adding support for, say,
>> generating both allow rules and auditallow rules at the same time.
>>
>>      
<snip>

Ok this one only adds a flag to the policygenerator to tell it to 
generate dontaudit rules.

No passing of args.

--------------070904060201000405060208
Content-Type: text/plain;
 name="audit2allow_dontaudit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="audit2allow_dontaudit.patch"

diff --git a/policycoreutils/audit2allow/audit2allow b/policycoreutils/audit2allow/audit2allow
index 9186965..5ad9fdb 100644
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
 
@@ -295,6 +298,8 @@ class AuditToPolicy:
 
         g = policygen.PolicyGenerator()
 
+        g.set_gen_dontaudit(self.__options.dontaudit)
+
         if self.__options.module:
             g.set_module_name(self.__options.module)
 
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
index 55cffeb..0e6b502 100644
--- a/sepolgen/src/sepolgen/policygen.py
+++ b/sepolgen/src/sepolgen/policygen.py
@@ -75,6 +75,8 @@ class PolicyGenerator:
         else:
             self.module = refpolicy.Module()
 
+        self.dontaudit = False
+
     def set_gen_refpol(self, if_set=None, perm_maps=None):
         """Set whether reference policy interfaces are generated.
 
@@ -108,6 +110,9 @@ class PolicyGenerator:
         """
         self.explain = explain
 
+    def set_gen_dontaudit(self, dontaudit):
+        self.dontaudit = dontaudit
+
     def __set_module_style(self):
         if self.ifgen:
             refpolicy = True
@@ -144,6 +149,8 @@ class PolicyGenerator:
     def __add_allow_rules(self, avs):
         for av in avs:
             rule = refpolicy.AVRule(av)
+            if self.dontaudit:
+                rule.rule_type = rule.DONTAUDIT
             if self.explain:
                 rule.comment = refpolicy.Comment(explain_access(av, verbosity=self.explain))
             self.module.children.append(rule)

--------------070904060201000405060208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
