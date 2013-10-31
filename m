From: Dan Walsh <dwalsh@redhat.com>
To: sds@tycho.nsa.gov, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>
Subject: [PATCH 01/10] Add back attributes flag to fix exception crash.
Date: Thu, 31 Oct 2013 10:01:36 -0400
Message-Id: <1383228096-4255-2-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1383228096-4255-1-git-send-email-dwalsh@redhat.com>
References: <1383228096-4255-1-git-send-email-dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 sepolgen/src/sepolgen/interfaces.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sepolgen/src/sepolgen/interfaces.py b/sepolgen/src/sepolgen/interfaces.py
index 3258684..88a6dc3 100644
--- a/sepolgen/src/sepolgen/interfaces.py
+++ b/sepolgen/src/sepolgen/interfaces.py
@@ -276,7 +276,7 @@ class InterfaceVector:
         if attributes:
             for typeattribute in interface.typeattributes():
                 for attr in typeattribute.attributes:
-                    if not attributes.has_key(attr):
+                    if not attributes.attributes.has_key(attr):
                         # print "missing attribute " + attr
                         continue
                     attr_vec = attributes.attributes[attr]
-- 
1.8.3.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
