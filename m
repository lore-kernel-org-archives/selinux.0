Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v239r3OO024411
 for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2017 04:53:03 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
 [10.5.11.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0CCF84E04A
 for <selinux@tycho.nsa.gov>; Fri,  3 Mar 2017 09:53:02 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com (unknown [10.40.3.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 820212D655
 for <selinux@tycho.nsa.gov>; Fri,  3 Mar 2017 09:53:01 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] python/sepolicy: fix obtaining domain name in HTMLManPages
Date: Fri,  3 Mar 2017 10:52:56 +0100
Message-Id: <20170303095256.11584-1-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

HTMLManPages got domain name by splitting name of selinux manpage
on "_selinux" which doesn't work properly when domain name contains
"_selinux".

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/sepolicy/sepolicy/manpage.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 773a9ab..1af4295 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -205,12 +205,12 @@ class HTMLManPages:
         for domain in self.manpage_domains.values():
             if len(domain):
                 for d in domain:
-                    convert_manpage_to_html((self.new_path + d.split("_selinux")[0] + ".html"), self.old_path + d)
+                    convert_manpage_to_html((self.new_path + d.rsplit("_selinux", 1)[0] + ".html"), self.old_path + d)
 
         for role in self.manpage_roles.values():
             if len(role):
                 for r in role:
-                    convert_manpage_to_html((self.new_path + r.split("_selinux")[0] + ".html"), self.old_path + r)
+                    convert_manpage_to_html((self.new_path + r.rsplit("_selinux", 1)[0] + ".html"), self.old_path + r)
 
     def _gen_index(self):
         index = self.old_path + "index.html"
@@ -290,7 +290,7 @@ Fedora or Red Hat Enterprise Linux Man Pages.</h2>
             if len(self.manpage_roles[letter]):
                 rolename_body += "<p>"
                 for r in self.manpage_roles[letter]:
-                    rolename = r.split("_selinux")[0]
+                    rolename = r.rsplit("_selinux", 1)[0]
                     rolename_body += "<a name=%s_role></a><a href=%s.html>%s_selinux(8)</a> - Security Enhanced Linux Policy for the %s SELinux user\n" % (letter, rolename, rolename, rolename)
 
         fd.write("""%s
@@ -317,7 +317,7 @@ Fedora or Red Hat Enterprise Linux Man Pages.</h2>
             if len(self.manpage_domains[letter]):
                 domainname_body += "<p>"
                 for r in self.manpage_domains[letter]:
-                    domainname = r.split("_selinux")[0]
+                    domainname = r.rsplit("_selinux", 1)[0]
                     domainname_body += "<a name=%s_domain></a><a href=%s.html>%s_selinux(8)</a> - Security Enhanced Linux Policy for the %s SELinux processes\n" % (letter, domainname, domainname, domainname)
 
         fd.write("""%s
-- 
2.9.3
