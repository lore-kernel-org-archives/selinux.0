Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i68DworT013128
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 09:58:50 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i68DwmEg001943
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 13:58:49 GMT
Subject: Re: userhelper_t vs sysadm_userhelper_t
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1089292697.6414.22.camel@moss-spartans.epoch.ncsc.mil>
References: <200407081905.08774.russell@coker.com.au>
	 <1089292697.6414.22.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1089295099.6414.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 08 Jul 2004 09:58:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-07-08 at 09:18, Stephen Smalley wrote:
> On Thu, 2004-07-08 at 05:05, Russell Coker wrote:
> > I think that as much as possible the policy should refer to the real 
> > domain/type names not aliases.  The attached patch fixes this for 
> > userhelper_t.
> 
> Perhaps this part of the constraint needs to be reconsidered.  What
> about the other *_userhelper_t domains?  Why is a special case
> constraint required at all (vs. using privrole and privuser) - is
> userhelper transitioning directly to program domains in some cases?

Ok, userhelper does sometimes perform direct transitions to program
domains, e.g. to rpm_t for up2date, based on the TYPE= entry in
/etc/security/console.apps/up2date.  Hence, the special case constraint
is required, and it is required for all userhelper domains, not just
sysadm_userhelper_t.  Patch below relative to your patch should fix.

Index: policy/attrib.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/attrib.te,v
retrieving revision 1.18
diff -u -r1.18 attrib.te
--- policy/attrib.te	8 Jul 2004 13:20:43 -0000	1.18
+++ policy/attrib.te	8 Jul 2004 13:54:44 -0000
@@ -188,6 +188,9 @@
 # The fs_domain identifies every domain that may directly access a fixed disk
 attribute fs_domain;
 
+# This attribute is for all domains for the userhelper program.
+attribute userhelperdomain;
+
 ############################
 # Attributes for file types:
 #
Index: policy/constraints
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/constraints,v
retrieving revision 1.9
diff -u -r1.9 constraints
--- policy/constraints	8 Jul 2004 13:20:43 -0000	1.9
+++ policy/constraints	8 Jul 2004 13:55:41 -0000
@@ -39,7 +39,7 @@
          or (t1 == crond_t and (t2 == user_crond_domain or u2 == system_u))
 ')
 ifdef(`userhelper.te', 
-	`or (t1 == sysadm_userhelper_t)')
+	`or (t1 == userhelperdomain)')
 	 or (t1 == priv_system_role and u2 == system_u )
         );
 
@@ -49,7 +49,7 @@
          or (t1 == crond_t and t2 == user_crond_domain)
 ')
 ifdef(`userhelper.te', 
-	`or (t1 == sysadm_userhelper_t)')
+	`or (t1 == userhelperdomain)')
 	 or (t1 == priv_system_role and r2 == system_r )
         );
 
Index: policy/macros/program/userhelper_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/program/userhelper_macros.te,v
retrieving revision 1.2
diff -u -r1.2 userhelper_macros.te
--- policy/macros/program/userhelper_macros.te	16 Jun 2004 17:07:57 -0000	1.2
+++ policy/macros/program/userhelper_macros.te	8 Jul 2004 13:53:47 -0000
@@ -17,7 +17,7 @@
 ifdef(`single_userdomain', `
 typealias $1_t alias $1_userhelper_t;
 ', `
-type $1_userhelper_t, domain, privlog, privrole, privowner, auth_chkpwd, privfd ifdef(`user_canbe_sysadm', `, privuser');
+type $1_userhelper_t, domain, userhelperdomain, privlog, privrole, privowner, auth_chkpwd, privfd ifdef(`user_canbe_sysadm', `, privuser');
 
 in_user_role($1_userhelper_t)
 role sysadm_r types $1_userhelper_t;

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
