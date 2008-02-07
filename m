Subject: [patch] refpolicy: add capability2 class
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 11:29:06 -0500
Message-Id: <1202401746.27371.265.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add the capability2 class to policy for capabilities 32-63.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 refpolicy/policy/flask/access_vectors   |    6 ++++++
 refpolicy/policy/flask/security_classes |    3 +++
 2 files changed, 9 insertions(+)


Index: refpolicy/policy/flask/security_classes
===================================================================
--- refpolicy/policy/flask/security_classes	(revision 2594)
+++ refpolicy/policy/flask/security_classes	(working copy)
@@ -109,4 +109,7 @@
 # network peer labels
 class peer
 
+# Capabilities >= 32
+class capability2
+
 # FLASK
Index: refpolicy/policy/flask/access_vectors
===================================================================
--- refpolicy/policy/flask/access_vectors	(revision 2594)
+++ refpolicy/policy/flask/access_vectors	(working copy)
@@ -347,6 +347,7 @@
 class capability
 {
 	# The capabilities are defined in include/linux/capability.h
+	# Capabilities >= 32 are defined in the capability2 class.
 	# Care should be taken to ensure that these are consistent with
 	# those definitions. (Order matters)
 
@@ -384,6 +385,11 @@
 	setfcap
 }
 
+class capability2 
+{
+	mac_override	# unused by SELinux
+	mac_admin	# unused by SELinux
+}
 
 #
 # Define the access vector interpretation for controlling

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
