Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAJKmPlf013030
	for <selinux@tycho.nsa.gov>; Thu, 19 Nov 2009 15:48:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nAJKlL3x004704
	for <selinux@tycho.nsa.gov>; Thu, 19 Nov 2009 20:47:21 GMT
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Cc: Chad Sellers <csellers@tresys.com>
Subject: [PATCH] semanage node -a bug
Date: Thu, 19 Nov 2009 15:48:23 -0500
Message-Id: <1258663703-5513-1-git-send-email-csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a bug that causes semanage node -a to not work
(failing with a python traceback). You can test the bug with any
semanage node -a command, such as:

semanage node -a -t node_t -p ipv4 -M 255.255.255.0 192.168.1.0

Signed-off-by: Chad Sellers <csellers@tresys.com>
---
 policycoreutils/semanage/seobject.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 7c94da0..3c9b09f 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -1038,7 +1038,7 @@ class nodeRecords(semanageRecords):
 
        def add(self, addr, mask, proto, serange, ctype):
                 self.begin()
-                self.__add(self, addr, mask, proto, serange, ctype)
+                self.__add(addr, mask, proto, serange, ctype)
                 self.commit()
 
        def __modify(self, addr, mask, proto, serange, setype):
-- 
1.6.2.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
