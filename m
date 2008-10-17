Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9HFhnSR030252
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 11:43:49 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9HFhm9h004343
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2008 15:43:49 GMT
Subject: [patch] policy: add new permission setsuid to file class
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com
Content-Type: text/plain
Date: Fri, 17 Oct 2008 11:43:43 -0400
Message-Id: <1224258223.3189.29.camel@paris-laptop>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a new permission to the file class and a corresponding policy
capability.  This is checked any time chmod is called and the suid or
sgid bits are set or will be set on that file.  This does not enable the
permission in policy, only defines it.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

diff -Naupr serefpolicy-3.4.2/policy/flask/access_vectors serefpolicy-3.4.2.new/policy/flask/access_vectors
--- serefpolicy-3.4.2/policy/flask/access_vectors	2008-06-12 10:27:39.000000000 -0400
+++ serefpolicy-3.4.2.new/policy/flask/access_vectors	2008-10-16 15:34:02.161239655 -0400
@@ -135,6 +135,7 @@ inherits file
 	entrypoint
 	execmod
 	open
+	setsuid
 }
 
 class lnk_file
diff -Naupr serefpolicy-3.4.2/policy/policy_capabilities serefpolicy-3.4.2.new/policy/policy_capabilities
--- serefpolicy-3.4.2/policy/policy_capabilities	2008-06-12 10:27:52.000000000 -0400
+++ serefpolicy-3.4.2.new/policy/policy_capabilities	2008-10-16 15:43:49.145672322 -0400
@@ -31,3 +31,10 @@
 # blk_file: open
 #
 #policycap open_perms;
+
+# Enable additional acces controls for setting suid and sguid
+#
+# Checks enabled:
+# file: setsuid
+#
+#policycap setsuid_perms;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
