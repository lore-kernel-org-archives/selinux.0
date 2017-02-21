Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1LEfXMH027858
 for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2017 09:41:33 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
 [10.5.11.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42E2061B84
 for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2017 14:41:32 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com (unknown [10.40.3.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8C0615AA8
 for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2017 14:41:31 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] sepolgen: strip non-printable characters when parsing audit
 messages
Date: Tue, 21 Feb 2017 15:41:23 +0100
Message-Id: <20170221144123.22532-1-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Strip the following characters
\x1c	File Separator
\x1d	Group Separator
\x1e	Record Separator
\x85	Next Line (C1 Control Code)
from audit message fields to make sure they are not evaluated
as part of some identifier (eg. ausearch used insert \x1d into
--raw output resulting in "unrecognized class" error messages).

This is done as part of str.split() in python3.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1406328
---
 python/sepolgen/src/sepolgen/audit.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/audit.py b/python/sepolgen/src/sepolgen/audit.py
index 724d3ea..26ce6c9 100644
--- a/python/sepolgen/src/sepolgen/audit.py
+++ b/python/sepolgen/src/sepolgen/audit.py
@@ -376,7 +376,9 @@ class AuditParser:
     #   AuditMessage (or subclass) - object representing a parsed
     #      and valid audit message.
     def __parse_line(self, line):
-        rec = line.split()
+        # strip("\x1c\x1d\x1e\x85") is only needed for python2
+        # since str.split() in python3 already does this
+        rec = [x.strip("\x1c\x1d\x1e\x85") for x in line.split()]
         for i in rec:
             found = False
             if i == "avc:" or i == "message=avc:" or i == "msg='avc:":
-- 
2.9.3
