Subject: [PATCH] refpolicy: Kernel access key retention policy support
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 02 Jun 2006 14:19:16 -0400
Message-Id: <1149272357.3340.6.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm very sorry, somehow I selected the wrong patch to insert in the
last message.  Here's the proper patch.

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

diff -uprN refpolicy.orig/policy/flask/access_vectors refpolicy/policy/flask/access_vectors
--- refpolicy.orig/policy/flask/access_vectors	2006-05-19 13:46:37.000000000 -0400
+++ refpolicy/policy/flask/access_vectors	2006-06-01 10:39:12.000000000 -0400
@@ -617,3 +617,16 @@ class packet
 	recv
 	relabelto
 }
+
+class key
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
diff -uprN refpolicy.orig/policy/flask/security_classes refpolicy/policy/flask/security_classes
--- refpolicy.orig/policy/flask/security_classes	2006-05-19 13:46:37.000000000 -0400
+++ refpolicy/policy/flask/security_classes	2006-05-24 09:00:01.000000000 -0400
@@ -90,4 +90,7 @@ class appletalk_socket
 
 class packet
 
+# Kernel access key retention
+class key
+
 # FLASK



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
