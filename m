Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v75GcQ1s007244
 for <selinux@tycho.nsa.gov>; Sat, 5 Aug 2017 12:38:26 -0400
Received: from localhost.localdomain (52.81.152.77.rev.sfr.net [77.152.81.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id C26DE56497B
 for <selinux@tycho.nsa.gov>; Sat,  5 Aug 2017 18:37:46 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  5 Aug 2017 18:37:45 +0200
Message-Id: <20170805163750.1920-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/6] sepolicy: fix Python3 syntax in manpage
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit c624c4abaaf3 ("sepolicy: Fix syntax errors in 'manpage -w'")
missed an occurence of print statement. While at it, fix self.os_version
test.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/manpage.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 4d846364cccf..035065afd292 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -192,7 +192,7 @@ class HTMLManPages:
         self.old_path = path + "/"
         self.new_path = self.old_path + self.os_version + "/"
 
-        if self.os_version in fedora_releases or rhel_releases:
+        if self.os_version in fedora_releases or self.os_version in rhel_releases:
             self.__gen_html_manpages()
         else:
             print("SELinux HTML man pages can not be generated for this %s" % os_version)
@@ -262,7 +262,7 @@ Fedora or Red Hat Enterprise Linux Man Pages.</h2>
 </pre>
 	""")
         fd.close()
-        print("%s has been created") % index
+        print("%s has been created" % index)
 
     def _gen_body(self):
         html = self.new_path + self.os_version + ".html"
-- 
2.13.3
