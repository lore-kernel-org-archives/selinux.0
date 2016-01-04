Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u048YJnV031841
 for <selinux@tycho.nsa.gov>; Mon, 4 Jan 2016 03:34:20 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 12116C05E140
 for <selinux@tycho.nsa.gov>; Mon,  4 Jan 2016 08:34:10 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: semanage: list reserver_port_t
Date: Mon,  4 Jan 2016 09:34:04 +0100
Message-Id: <1451896444-29665-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

reserver_port_t was omitted in 'semanage port -l'. There seems to be no
reason for that nowadays therefore we can list it.

Resolves https://bugzilla.redhat.com/show_bug.cgi?id=1225806

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/semanage/seobject.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index c52be75..3b0b108 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -1216,8 +1216,6 @@ class portRecords(semanageRecords):
         for port in self.plist:
             con = semanage_port_get_con(port)
             ctype = semanage_context_get_type(con)
-            if ctype == "reserved_port_t":
-                continue
             level = semanage_context_get_mls(con)
             proto = semanage_port_get_proto(port)
             proto_str = semanage_port_get_proto_str(proto)
@@ -1238,8 +1236,6 @@ class portRecords(semanageRecords):
         for port in self.plist:
             con = semanage_port_get_con(port)
             ctype = semanage_context_get_type(con)
-            if ctype == "reserved_port_t":
-                continue
             proto = semanage_port_get_proto(port)
             proto_str = semanage_port_get_proto_str(proto)
             low = semanage_port_get_low(port)
-- 
2.6.4
