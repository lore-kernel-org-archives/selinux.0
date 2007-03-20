Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2KKhgJb003874
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 16:43:42 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2KKheuG026324
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 20:43:40 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2KKhTp9009716
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 16:43:29 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2KKhTfp020030
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 16:43:29 -0400
Received: from [10.11.14.119] (vpn-14-119.rdu.redhat.com [10.11.14.119])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2KKhSDC000667
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 16:43:28 -0400
Subject: [PATCH] sepolgen fix tests and refpolicy formatting
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 20 Mar 2007 16:42:21 -0400
Message-Id: <1174423342.31342.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The changes I made to match sepolgen policy output with the refpolicy
missed type transition rules and broke the unit tests. This patch fixes
those two problems.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

diff -r c1ec2b56423b sepolgen/src/sepolgen/refpolicy.py
--- a/sepolgen/src/sepolgen/refpolicy.py	Fri Mar 02 11:31:05 2007 -0500
+++ b/sepolgen/src/sepolgen/refpolicy.py	Thu Mar 15 15:56:32 2007 -0400
@@ -472,7 +472,7 @@ class TypeRule(Leaf):
             return "type_member"
 
     def to_string(self):
-        return "%s %s %s : %s %s;" % (self.__rule_type_str(),
+        return "%s %s %s:%s %s;" % (self.__rule_type_str(),
                                      self.src_types.to_space_str(),
                                      self.tgt_types.to_space_str(),
                                      self.obj_classes.to_space_str(),
diff -r c1ec2b56423b sepolgen/tests/test_refpolicy.py
--- a/sepolgen/tests/test_refpolicy.py	Fri Mar 02 11:31:05 2007 -0500
+++ b/sepolgen/tests/test_refpolicy.py	Thu Mar 15 15:56:59 2007 -0400
@@ -88,7 +88,7 @@ class TestAVRule(unittest.TestCase):
         a.tgt_types.add("bar_t")
         a.obj_classes.add("file")
         a.perms.add("read")
-        self.assertEquals(a.to_string(), "allow foo_t bar_t : file read;")
+        self.assertEquals(a.to_string(), "allow foo_t bar_t:file read;")
 
         a.rule_type = a.DONTAUDIT
         a.src_types.add("user_t")
@@ -97,7 +97,7 @@ class TestAVRule(unittest.TestCase):
         a.perms.add("write")
         # This test might need to go because set ordering is not guaranteed
         self.assertEquals(a.to_string(),
-                          "dontaudit { foo_t user_t } { user_home_t bar_t } : { lnk_file file } { read write };")
+                          "dontaudit { foo_t user_t } { user_home_t bar_t }:{ lnk_file file } { read write };")
 
 class TestTypeRule(unittest.TestCase):
     def test_init(self):
@@ -114,7 +114,7 @@ class TestTypeRule(unittest.TestCase):
         a.tgt_types.add("bar_exec_t")
         a.obj_classes.add("process")
         a.dest_type = "bar_t"
-        self.assertEquals(a.to_string(), "type_transition foo_t bar_exec_t : process bar_t;")
+        self.assertEquals(a.to_string(), "type_transition foo_t bar_exec_t:process bar_t;")
 
 
 class TestParseNode(unittest.TestCase):



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
