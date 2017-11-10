Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAAGT0mk012883
 for <selinux@tycho.nsa.gov>; Fri, 10 Nov 2017 11:29:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 010ECC0273AE
 for <selinux@tycho.nsa.gov>; Fri, 10 Nov 2017 15:28:50 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com (unknown [10.43.12.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 795C35D757
 for <selinux@tycho.nsa.gov>; Fri, 10 Nov 2017 15:28:49 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 10 Nov 2017 16:28:44 +0100
Message-Id: <20171110152844.32037-1-vmojzis@redhat.com>
Subject: [PATCH] python/semanage: Fix export of ibendport entries
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Replace nonexistent switch "-x" by "-z" (entry name).
Fix invalid index (the dictionary key is a 2-tuple).
Add MLS/MCS range (present in all entries).

Fixes:
 #semanage ibendport -E
  File "/usr/sbin/semanage", line 1049, in <module>
    do_parser()
  File "/usr/sbin/semanage", line 1028, in do_parser
    args.func(args)
  File "/usr/sbin/semanage", line 605, in handleIbendport
    for i in OBJECT.customized():
  File "/usr/lib64/python2.7/site-packages/seobject/__init__.py", line 1806, in customized
    l.append("-a -t %s -x %s %s" % (ddict[k][0], k[2], k[0]))
  IndexError: tuple index out of range

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 228c8ae..380256b 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1788,7 +1788,7 @@ class ibendportRecords(semanageRecords):
         keys = ddict.keys()
         keys.sort()
         for k in keys:
-            l.append("-a -t %s -x %s %s" % (ddict[k][0], k[2], k[0]))
+            l.append("-a -t %s -r %s -z %s %s" % (ddict[k][0], ddict[k][1], k[1], k[0]))
         return l
 
     def list(self, heading=1, locallist=0):
-- 
2.9.4
