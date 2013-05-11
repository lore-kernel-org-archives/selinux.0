Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4D3I5pZ001080
	for <selinux@tycho.nsa.gov>; Sun, 12 May 2013 23:18:05 -0400
Received: by mail-wi0-f172.google.com with SMTP id ey16so429493wid.11
        for <selinux@tycho.nsa.gov>; Sun, 12 May 2013 20:18:04 -0700 (PDT)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id bs20sm5485695wib.0.2013.05.11.11.58.09
        for <selinux@tycho.nsa.gov>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 11 May 2013 11:58:10 -0700 (PDT)
Date: Sat, 11 May 2013 20:57:11 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH/RFC 2/2] Fix AttributeError: 'dict' object has no attribute
 'attributes'
Message-ID: <20130511185711.GC933@siphos.be>
References: <20130511185446.GA933@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130511185446.GA933@siphos.be>
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

Not sure about the fix here, I'm guessing those we have an "attributes" too
many.

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 sepolgen/src/sepolgen/interfaces.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sepolgen/src/sepolgen/interfaces.py b/sepolgen/src/sepolgen/interfaces.py
index ae1c9c5..23d2d11 100644
--- a/sepolgen/src/sepolgen/interfaces.py
+++ b/sepolgen/src/sepolgen/interfaces.py
@@ -276,7 +276,7 @@ class InterfaceVector:
         if attributes != None:
             for typeattribute in interface.typeattributes():
                 for attr in typeattribute.attributes:
-                    if not attributes.attributes.has_key(attr):
+                    if not attributes.has_key(attr):
                         # print "missing attribute " + attr
                         continue
                     attr_vec = attributes.attributes[attr]
-- 
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
