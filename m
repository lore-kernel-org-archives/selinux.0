Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1LI3dW1020703
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:03:39 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1LI4uMh023579
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 18:04:56 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l1LI4tBE031455
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:04:56 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l1LI4tME032106
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:04:55 -0500
Received: from [10.11.15.21] (vpn-15-21.rdu.redhat.com [10.11.15.21])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l1LI4tlK026953
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:04:55 -0500
Message-ID: <45DC89C5.2040909@mentalrootkit.com>
Date: Wed, 21 Feb 2007 13:04:53 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [PATCH] sepolgen: cleanup tests
Content-Type: multipart/mixed;
 boundary="------------010501070601060409020200"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010501070601060409020200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make run-tests.py in sepolgen use unittest.main(). This allows the use 
of standard unittest command line files and python unittest test tools.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

--------------010501070601060409020200
Content-Type: text/x-patch;
 name="sepolgen-test-cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sepolgen-test-cleanup.diff"

diff -r 99289257af66 sepolgen/tests/run-tests.py
--- a/sepolgen/tests/run-tests.py	Mon Feb 19 11:09:58 2007 -0500
+++ b/sepolgen/tests/run-tests.py	Mon Feb 19 11:10:15 2007 -0500
@@ -1,45 +1,16 @@ import unittest
 import unittest
 import sys
 
-def run_all_tests():
-    sys.path.insert(0, "../src/.")
-    tester = unittest.TextTestRunner(verbosity=2)
-    t = unittest.TestLoader()
-    
-    import test_access
-    suite = t.loadTestsFromModule(test_access)
-
-    import test_audit
-    suite.addTest(t.loadTestsFromModule(test_audit))
-
-    import test_refpolicy
-    suite.addTest(t.loadTestsFromModule(test_refpolicy))
-
-    import test_refparser
-    suite.addTest(t.loadTestsFromModule(test_refparser))
-
-    import test_policygen
-    suite.addTest(t.loadTestsFromModule(test_policygen))
-
-    import test_matching
-    suite.addTest(t.loadTestsFromModule(test_matching))
-
-    import test_interfaces
-    suite.addTest(t.loadTestsFromModule(test_interfaces))
-
-    import test_objectmodel
-    suite.addTest(t.loadTestsFromModule(test_objectmodel))
-    
-    import test_module
-    suite.addTest(t.loadTestsFromModule(test_module))
-
-    tester.run(suite)
-
+sys.path.insert(0, "../src/.")
+from test_access import *
+from test_audit import *
+from test_refpolicy import *
+from test_refparser import *
+from test_policygen import *
+from test_matching import *
+from test_interfaces import *
+from test_objectmodel import *
+from test_module import *
 
 if __name__ == "__main__":
-    print "==========================================="
-    print ""
-    print "RUNNING TESTS"
-    print ""
-    print "==========================================="
-    run_all_tests()
+    unittest.main()

--------------010501070601060409020200--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
