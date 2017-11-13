Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAD8uaAu016564
 for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2017 03:56:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1DCC66A7C8
 for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2017 08:56:33 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com (unknown [10.43.12.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93CBD703A7
 for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2017 08:56:32 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 13 Nov 2017 09:56:26 +0100
Message-Id: <20171113085626.5636-1-vmojzis@redhat.com>
In-Reply-To: <20171110152844.32037-1-vmojzis@redhat.com>
References: <20171110152844.32037-1-vmojzis@redhat.com>
Subject: [PATCH] python/semanage: Update Infiniband code to work on
 python3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Update Infiniband "port" and "key" listing and export to work on
python3.
{}.keys() does not support .sort() operation on Py3.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 380256b..770745e 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1543,9 +1543,8 @@ class ibpkeyRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
-        keys.sort()
-        for k in keys:
+
+        for k in sorted(ddict.keys()):
             if k[0] == k[1]:
                 l.append("-a -t %s -x %s %s" % (ddict[k][0], k[2], k[0]))
             else:
@@ -1557,11 +1556,10 @@ class ibpkeyRecords(semanageRecords):
         keys = ddict.keys()
         if len(keys) == 0:
             return
-        keys.sort()
 
         if heading:
             print("%-30s %-18s %s\n" % (_("SELinux IB Pkey Type"), _("Subnet_Prefix"), _("Pkey Number")))
-        for i in keys:
+        for i in sorted(keys):
             rec = "%-30s %-18s " % i
             rec += "%s" % ddict[i][0]
             for p in ddict[i][1:]:
@@ -1785,9 +1783,8 @@ class ibendportRecords(semanageRecords):
     def customized(self):
         l = []
         ddict = self.get_all(True)
-        keys = ddict.keys()
-        keys.sort()
-        for k in keys:
+
+        for k in sorted(ddict.keys()):
             l.append("-a -t %s -r %s -z %s %s" % (ddict[k][0], ddict[k][1], k[1], k[0]))
         return l
 
@@ -1796,11 +1793,10 @@ class ibendportRecords(semanageRecords):
         keys = ddict.keys()
         if len(keys) == 0:
             return
-        keys.sort()
 
         if heading:
             print("%-30s %-18s %s\n" % (_("SELinux IB End Port Type"), _("IB Device Name"), _("Port Number")))
-        for i in keys:
+        for i in sorted(keys):
             rec = "%-30s %-18s " % i
             rec += "%s" % ddict[i][0]
             for p in ddict[i][1:]:
-- 
2.9.4
