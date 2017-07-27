Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6RDWcMf009684
 for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2017 09:32:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1CA781058B8
 for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2017 13:11:09 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 27 Jul 2017 15:10:51 +0200
Message-Id: <20170727131053.7962-2-plautrba@redhat.com>
In-Reply-To: <20170727131053.7962-1-plautrba@redhat.com>
References: <20170727131053.7962-1-plautrba@redhat.com>
Subject: [PATCH 2/4] sepolicy: Fix syntax errors in 'manpage -w'
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes:
  File "python/sepolicy/sepolicy/manpage.py", line 373, in _gen_css
    print("%s has been created") % style_css
TypeError: unsupported operand type(s) for %: 'NoneType' and 'str'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/manpage.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index a5e36cf3..7f17ba29 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -333,7 +333,7 @@ Fedora or Red Hat Enterprise Linux Man Pages.</h2>
 """ % domainname_body)
 
         fd.close()
-        print("%s has been created") % html
+        print("%s has been created" % html)
 
     def _gen_css(self):
         style_css = self.old_path + "style.css"
@@ -396,7 +396,7 @@ pre.code {
 """)
 
         fd.close()
-        print("%s has been created") % style_css
+        print("%s has been created" % style_css)
 
 
 class ManPage:
-- 
2.13.3
