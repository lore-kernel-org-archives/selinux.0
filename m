Date: Thu, 22 Dec 2005 17:07:43 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: NSA SELinux Mailing-List <SELinux@tycho.nsa.gov>
Subject: [patch] sereference: add requires to ppp policy
Message-ID: <20051222230743.GB11462@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following allows ppp to compile as a module on my system, where I
also have postfix as a module.

This block also raises the question - is there intended to be a
difference between an ifdef block and a optional_policy block?  It seems
to me the intent is probably to use ifdef for actual defines (like
targeted_policy), and all checks for 'module.te' should be done using
optional_policy.  Is that the case?

(If so, then the below patch should also change the ifdef)

thanks,
-serge

Index: refpolicy/policy/modules/services/ppp.te
===================================================================
--- refpolicy.orig/policy/modules/services/ppp.te	2005-12-22 16:11:45.000000000 -0600
+++ refpolicy/policy/modules/services/ppp.te	2005-12-22 16:13:09.000000000 -0600
@@ -319,6 +319,7 @@ optional_policy(`udev',`
 ')
 
 ifdef(`postfix.te', `
+	require { type postfix_etc_t; type postfix_master_exec_t; }
 	allow pppd_t postfix_etc_t:dir search;
 	allow pppd_t postfix_etc_t:file r_file_perms;
 	allow pppd_t postfix_master_exec_t:file { getattr read };

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
