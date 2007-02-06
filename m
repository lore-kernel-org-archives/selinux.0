Date: Tue, 6 Feb 2007 11:28:39 -0500
From: Caleb Case <ccase@tresys.com>
Message-Id: <200702061628.l16GSdCU018039@localhost.localdomain>
To: ccase@tresys.com, sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com,
        jbrindle@tresys.com, selinux@tycho.nsa.gov
Subject: libsemanage/Makefile: test target
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The test target now invokes the Makefile in the tests dir.
---
 libsemanage/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: selinux-pms-support/libsemanage/Makefile
===================================================================
--- selinux-pms-support.orig/libsemanage/Makefile
+++ selinux-pms-support/libsemanage/Makefile
@@ -23,4 +23,5 @@ indent:
 	$(MAKE) -C src $@
 	$(MAKE) -C include $@
 
-test:
+test: all
+	$(MAKE) -C tests test

-- 
Caleb Case
Tresys Technology
410.290.1411 x144


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
