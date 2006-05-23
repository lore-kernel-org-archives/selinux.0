MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH] serefpolicy: Flask support for kernel access key retention (retained_key)
Date: Tue, 23 May 2006 15:29:50 -0500
Message-ID: <9FD2C54661D3494AB6F269E0D4A74E83894571@DSBEXCLUSTER.ad.uiuc.edu>
From: "Michael D Lemay" <mdlemay2@cs.uiuc.edu>
To: <selinux@tycho.nsa.gov>
Cc: <pebenito@gentoo.org>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This policy patch accompanies the kernel patch I sent earlier.  It adds the retained_key security class, and defines the associated permissions.  It doesn't provide support for any applications that use the access key retention features of the kernel, although I can provide a module that supports the keyctl utility upon request.

---
diff -uprN refpolicy/policy/flask/access_vectors refpolicy.new/policy/flask/access_vectors
--- refpolicy/policy/flask/access_vectors	2006-05-19 13:46:37.000000000 -0400
+++ refpolicy.new/policy/flask/access_vectors	2006-05-23 12:57:21.000000000 -0400
@@ -617,3 +617,16 @@ class packet
 	recv
 	relabelto
 }
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
--- refpolicy/policy/flask/security_classes	2006-05-19 13:46:37.000000000 -0400
+++ refpolicy.new/policy/flask/security_classes	2006-05-23 12:56:00.000000000 -0400
@@ -90,4 +90,7 @@ class appletalk_socket
 
 class packet
 
+# Kernel key retention
+class retained_key
+
 # FLASK


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
