Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7J3jWYT022466
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 23:45:33 -0400
Received: by mail-pf0-f196.google.com with SMTP id h186so747862pfg.2
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 20:45:30 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] audit2allow: fix audit2why import from seobject.
Date: Fri, 19 Aug 2016 11:45:16 +0800
Message-Id: <1471578317-22785-2-git-send-email-jason@perfinion.com>
In-Reply-To: <1471578317-22785-1-git-send-email-jason@perfinion.com>
References: <1471578317-22785-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit b43991f9135e5422fd1058ecbd427ae6c9283eab broke audit2why because
boolean_desc was imported indirectly via seobject. Use it directly from
sepolicy instead.

$ cd policycoreutils/audit2allow
$ make test
test_audit2why (__main__.Audit2allowTests)
Verify audit2why works ... Traceback (most recent call last):
  File "/bin/audit2why", line 365, in <module>
    app.main()
  File "/bin/audit2why", line 353, in main
    self.__output()
  File "/bin/audit2why", line 295, in __output
    return self.__output_audit2why()
  File "/bin/audit2why", line 263, in __output_audit2why
    print("\tDescription:\n\t%s\n" % seobject.boolean_desc(b[0]))
AttributeError: 'module' object has no attribute 'boolean_desc'
FAIL

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/audit2allow/audit2allow | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/audit2allow/audit2allow b/policycoreutils/audit2allow/audit2allow
index e23e418..4b50c5b 100644
--- a/policycoreutils/audit2allow/audit2allow
+++ b/policycoreutils/audit2allow/audit2allow
@@ -240,7 +240,7 @@ class AuditToPolicy:
 
     def __output_audit2why(self):
         import selinux
-        import seobject
+        import sepolicy
         for i in self.__parser.avc_msgs:
             rc = i.type
             data = i.data
@@ -260,11 +260,11 @@ class AuditToPolicy:
                 if len(data) > 1:
                     print("\tOne of the following booleans was set incorrectly.")
                     for b in data:
-                        print("\tDescription:\n\t%s\n" % seobject.boolean_desc(b[0]))
+                        print("\tDescription:\n\t%s\n" % sepolicy.boolean_desc(b[0]))
                         print("\tAllow access by executing:\n\t# setsebool -P %s %d" % (b[0], b[1]))
                 else:
                     print("\tThe boolean %s was set incorrectly. " % (data[0][0]))
-                    print("\tDescription:\n\t%s\n" % seobject.boolean_desc(data[0][0]))
+                    print("\tDescription:\n\t%s\n" % sepolicy.boolean_desc(data[0][0]))
                     print("\tAllow access by executing:\n\t# setsebool -P %s %d" % (data[0][0], data[0][1]))
                 continue
 
-- 
2.7.3
