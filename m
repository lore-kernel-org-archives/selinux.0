From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: plautrba@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] python/semanage: print is a function in python3
Date: Fri, 26 May 2017 10:36:38 -0400
Message-Id: <20170526143638.3323-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 python/semanage/seobject.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index c97a9f0..70fd192 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -1557,13 +1557,13 @@ class ibpkeyRecords(semanageRecords):
         keys.sort()
 
         if heading:
-            print "%-30s %-18s %s\n" % (_("SELinux IB Pkey Type"), _("Subnet_Prefix"), _("Pkey Number"))
+            print("%-30s %-18s %s\n" % (_("SELinux IB Pkey Type"), _("Subnet_Prefix"), _("Pkey Number")))
         for i in keys:
             rec = "%-30s %-18s " % i
             rec += "%s" % ddict[i][0]
             for p in ddict[i][1:]:
                 rec += ", %s" % p
-            print rec
+            print(rec)
 
 class ibendportRecords(semanageRecords):
     try:
@@ -1796,13 +1796,13 @@ class ibendportRecords(semanageRecords):
         keys.sort()
 
         if heading:
-            print "%-30s %-18s %s\n" % (_("SELinux IB End Port Type"), _("IB Device Name"), _("Port Number"))
+            print("%-30s %-18s %s\n" % (_("SELinux IB End Port Type"), _("IB Device Name"), _("Port Number")))
         for i in keys:
             rec = "%-30s %-18s " % i
             rec += "%s" % ddict[i][0]
             for p in ddict[i][1:]:
                 rec += ", %s" % p
-            print rec
+            print(rec)
 
 class nodeRecords(semanageRecords):
     try:
-- 
2.9.4
