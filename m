Subject: [PATCH] refpolicy: Kernel access key retention policy support
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 02 Jun 2006 14:08:21 -0400
Message-Id: <1149271701.3340.3.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Now that the kernel patch for access key retention support has been
finalized, the following patch should be applied to refpolicy.

---<snip>---
From: Michael LeMay <mdlemay@epoch.ncsc.mil>

Add a "key" security class.  Add appropriate permissions
to match those supported in the kernel.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

---

 policy/flask/access_vectors   |   13 +++++++++++++
 policy/flask/security_classes |    3 +++
 2 files changed, 16 insertions(+)

diff -uprN refpolicy/policy/flask/access_vectors refpolicy.new/policy/flask/access_vectors
--- refpolicy/policy/flask/access_vectors	2006-01-06 11:00:25.000000000 -0500
+++ refpolicy.new/policy/flask/access_vectors	2006-05-22 09:05:34.000000000 -0400
@@ -607,3 +607,16 @@ class association
 # Updated Netlink class for KOBJECT_UEVENT family.
 class netlink_kobject_uevent_socket
 inherits socket
+
+class retained_key
+{
+	# These permissions are defined in include/linux/key-ui.h
+	# Their order matters!
+
+	view
+	read
+	write
+	search
+	link
+	setattr
+}
diff -uprN refpolicy/policy/flask/security_classes refpolicy.new/policy/flask/security_classes
--- refpolicy/policy/flask/security_classes	2005-12-12 10:49:41.000000000 -0500
+++ refpolicy.new/policy/flask/security_classes	2006-05-22 09:05:43.000000000 -0400
@@ -86,4 +86,7 @@ class association
 # Updated Netlink class for KOBJECT_UEVENT family.
 class netlink_kobject_uevent_socket
 
+# Kernel key retention
+class retained_key
+
 # FLASK



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
