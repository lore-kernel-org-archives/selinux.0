Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1ADoOL9011363
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 08:50:24 -0500 (EST)
Subject: Re: How to install CVS wine
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Jim Carter <jwcart2@epoch.ncsc.mil>
In-Reply-To: <1107532387.8078.76.camel@moss-spartans.epoch.ncsc.mil>
References: <1107499460.29033.7.camel@cobra.ivg2.net>
	 <1107520773.8078.28.camel@moss-spartans.epoch.ncsc.mil>
	 <1107521277.8078.32.camel@moss-spartans.epoch.ncsc.mil>
	 <1107531407.31488.4.camel@cobra.ivg2.net>
	 <1107531236.8078.70.camel@moss-spartans.epoch.ncsc.mil>
	 <1107531978.31488.9.camel@cobra.ivg2.net>
	 <1107532387.8078.76.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1108042996.22172.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Feb 2005 08:43:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-04 at 10:53, Stephen Smalley wrote:
> On Fri, 2005-02-04 at 10:46, Ivan Gyurdiev wrote:
> > .. and why is it that when I change it nothing happens?
> > Is this the wrong file?
> > 
> > I'm editing /etc/selinux/strict/src/policy/local.users
> 
> I think Dan introduced it in preparation for creating infrastructure for
> updating users on the end system without the policy sources via
> genpolusers.  Looks like it is getting installed via make install, but
> not incorporated into a policy build from source.  See the earlier
> discussions on the list.

I think we want the below patch so that:
1) On a policy source build, any locally installed local.users file will
be included from /etc/selinux/$SELINUXTYPE/users/, and
2) The initial installed version of local.users will be readable (i.e.
no m4 processing with tunables and flags) and only contain a comment
header describing the format.

Note that even with this change, local.users in the policy source
directory is not used except for initial install of the file.  So you
would edit the installed one under /etc/selinux/$SELINUXTYPE/users, not
the one in the policy source directory.  Seem reasonable?

Index: policy/Makefile
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/Makefile,v
retrieving revision 1.54
retrieving revision 1.55
diff -u -r1.54 -r1.55
--- policy/Makefile	9 Feb 2005 18:25:16 -0000	1.54
+++ policy/Makefile	10 Feb 2005 13:41:17 -0000	1.55
@@ -52,6 +52,7 @@
 endif
 POLICYFILES += $(ALL_TUNABLES) $(TE_RBAC_FILES)
 POLICYFILES += $(USER_FILES)
+POLICYFILES += $(wildcard $(USERPATH)/local.users)
 POLICYFILES += constraints
 POLICYFILES += initial_sid_contexts fs_use genfs_contexts net_contexts
 CONTEXTFILES = initial_sid_contexts fs_use genfs_contexts net_contexts
@@ -89,8 +90,7 @@
 
 $(USERPATH)/local.users: local.users
 	@mkdir -p $(USERPATH)
-	m4 $(ALL_TUNABLES) tmp/program_used_flags.te local.users | sed 's/^user/#user/g' > tmp/local.users
-	install -m 644 tmp/local.users $@
+	install -m 644 $< $@
 
 $(CONTEXTPATH)/files/media: appconfig/media
 	mkdir -p $(CONTEXTPATH)/files/
Index: policy/local.users
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/local.users,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -r1.1 -r1.2
--- policy/local.users	20 Dec 2004 21:27:40 -0000	1.1
+++ policy/local.users	10 Feb 2005 13:41:18 -0000	1.2
@@ -3,19 +3,15 @@
 # User configuration.
 #
 # This file defines additional users recognized by the system security policy.
-# Only the user identities defined in this file and the users.system file
+# Only the user identities defined in this file and the system.users file
 # may be used as the user attribute in a security context.
 #
 # Each user has a set of roles that may be entered by processes
 # with the users identity.  The syntax of a user declaration is:
 #
-# 	user username roles role_set [ ranges MLS_range_set ];
+# 	user username roles role_set [ level default_level range allowed_range ];
 #
-# The MLS range set should only be specified if MLS was enabled
-# for the module and checkpolicy.
+# The MLS default level and allowed range should only be specified if 
+# MLS was enabled in the policy.
 
-# sample for administrative user
-user jadmin roles { staff_r sysadm_r ifdef(`direct_sysadm_daemon', `system_r') };
 
-# sample for regular user
-#user jdoe roles { user_r }; 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
