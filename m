Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43GuLRb006845
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 12:56:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i43Gs7Zx026600
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 16:54:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i43Gs6Jv026597
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 16:54:06 GMT
Subject: [patch] Add devnull initial SID to policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Message-Id: <1083603367.7446.202.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 03 May 2004 12:56:07 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch for the policy adds a devnull initial SID and corresponding
context to support the SELinux module patch that I posted to re-open
descriptors closed on exec by SELinux to /dev/null.  This policy patch
can be applied without harming operation of existing kernels, but needs
to be applied prior to using a kernel that includes the updated SELinux
module that uses this initial SID.

Index: policy/initial_sid_contexts
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/initial_sid_contexts,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 initial_sid_contexts
--- policy/initial_sid_contexts	30 Apr 2003 18:42:48 -0000	1.1.1.1
+++ policy/initial_sid_contexts	30 Apr 2004 18:11:43 -0000
@@ -30,5 +30,6 @@
 sid kmod	system_u:system_r:kernel_t
 sid policy	system_u:object_r:policy_config_t
 sid scmp_packet	system_u:system_r:scmp_packet_t
+sid devnull	system_u:object_r:null_device_t
 
 # FLASK
Index: policy/flask/initial_sids
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/flask/initial_sids,v
retrieving revision 1.1
diff -u -r1.1 initial_sids
--- policy/flask/initial_sids	30 May 2003 14:30:14 -0000	1.1
+++ policy/flask/initial_sids	30 Apr 2004 17:47:13 -0000
@@ -30,5 +30,6 @@
 sid kmod
 sid policy
 sid scmp_packet
+sid devnull
 
 # FLASK

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
