Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6JKCQCX017278
	for <selinux@tycho.nsa.gov>; Fri, 19 Jul 2013 16:12:26 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so4446820wes.34
        for <selinux@tycho.nsa.gov>; Fri, 19 Jul 2013 13:12:23 -0700 (PDT)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id w4sm25179116wia.9.2013.07.19.13.12.21
        for <selinux@tycho.nsa.gov>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 13:12:22 -0700 (PDT)
Date: Fri, 19 Jul 2013 22:11:53 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] sepolgen: Fix AttributeError: 'dict' object has no
 attribute 'attributes'
Message-ID: <20130719201152.GB20879@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


While running the tests, the test_export one fails as follows:

======================================================================
ERROR: test_export (test_interfaces.TestInterfaceSet)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/var/portage/portage/dev-python/sepolgen-1.1.9-r1/work/sepolgen-1.1.9-2.7/tests/test_interfaces.py", line 263, in test_export
    i.add_headers(h)
  File "../src/./sepolgen/interfaces.py", line 412, in add_headers
    self.add(i, attributes)
  File "../src/./sepolgen/interfaces.py", line 407, in add
    ifv = InterfaceVector(interface, attributes)
  File "../src/./sepolgen/interfaces.py", line 257, in __init__
    self.from_interface(interface, attributes)
  File "../src/./sepolgen/interfaces.py", line 279, in from_interface
    if not attributes.attributes.has_key(attr):
AttributeError: 'dict' object has no attribute 'attributes'

The test does not declare the attributes parameter (it is optional) so it
becomes the empty dictionary object.

Changing "if attributes != None:" to "if attributes:" gets the tests to succeed
and the code still seems to function correctly (ran "sepolgen-ifgen" and
"sepolgen-ifgen -i /usr/share/selinux/strict/include" to trigger the code).

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 sepolgen/src/sepolgen/interfaces.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sepolgen/src/sepolgen/interfaces.py b/sepolgen/src/sepolgen/interfaces.py
index ae1c9c5..88a6dc3 100644
--- a/sepolgen/src/sepolgen/interfaces.py
+++ b/sepolgen/src/sepolgen/interfaces.py
@@ -273,7 +273,7 @@ class InterfaceVector:
                 self.add_av(av)
 
         # Add typeattribute access
-        if attributes != None:
+        if attributes:
             for typeattribute in interface.typeattributes():
                 for attr in typeattribute.attributes:
                     if not attributes.attributes.has_key(attr):
-- 
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
