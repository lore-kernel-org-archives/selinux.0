Subject: [patch] selinux-testsuite:  update README
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, ltp-list@lists.sourceforge.net,
        selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <1201116050.7025.303.camel@moss-spartans.epoch.ncsc.mil>
References: <1201116050.7025.303.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 23 Jan 2008 14:33:54 -0500
Message-Id: <1201116834.7025.311.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Update the selinux testsuite README file.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Index: testcases/kernel/security/selinux-testsuite/README
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/README,v
retrieving revision 1.4
diff -u -r1.4 README
--- testcases/kernel/security/selinux-testsuite/README	20 Dec 2007 09:32:55 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/README	23 Jan 2008 19:31:22 -0000
@@ -6,6 +6,13 @@
 such as getenforce are found. The test_selinux.sh script adds /usr/sbin
 to the PATH. 
 
+You must also have the line:
+	expand-check = 0
+in your /etc/selinux/semanage.conf file as the test policy will violate some 
+of the neverallow rules in the base policy.  This line may already be present
+depending on your distribution; if not, add it before running the test suite
+and remove it when done.
+
 There are two ways to run the SELinux testcases:
 	1. testsuite - all testcases
 	2. individual testcases
@@ -32,13 +39,13 @@
 to the testscripts directory and from the command line execute,
 	./test_selinux.sh
 
-This script builds the test policy in the selinux-testsuite/policy 
+This script builds the test policy in the selinux-testsuite/refpolicy 
 directory and runs the testsuite. After the testcases have completed, 
 the test policy will be removed and the original policy will be 
 restored. Thus, if the test_selinux.sh script is not allowed 
 to complete, you may manually have to restore your system's 
 original policy. This can be done by changing to the the 
-selinux-testsuite/policy directory and from the commandline, 
+selinux-testsuite/refpolicy directory and from the commandline, 
 issue a "make cleanup" to remove the test policy and restore the 
 original policy.
 
@@ -62,8 +69,8 @@
 Run Individual Testcases
 --------------------------
 First build the test policy manually. Do this by first changing 
-to the selinux-testsuite policy directory (cd to 
-$LTPROOT/testcases/kernel/security/selinux-testsuite/policy)
+to the selinux-testsuite refpolicy directory (cd to 
+$LTPROOT/testcases/kernel/security/selinux-testsuite/refpolicy)
 and build the policy by doing a, 
 	make load
 
@@ -88,7 +95,7 @@
 testcase directory of the testcase being debugged.	
 
 To remove the test policy and restore original policy,
-cd to selinux-testsuite/policy directory and execute,
+cd to selinux-testsuite/refpolicy directory and execute,
 	make cleanup
 
 Remember to remove test policy and restore original policy after

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
