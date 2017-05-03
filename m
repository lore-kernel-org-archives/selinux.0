Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AVJBo029812
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 118548046A
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:18 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 18/19] sepolicy: info() should provide attributes for a TYPE
Date: Wed,  3 May 2017 12:30:35 +0200
Message-Id: <20170503103036.17514-19-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

"attributes" used to be there when sepolicy.info() used setools3

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py | 1 +
 python/sepolicy/sepolicy/manpage.py  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index d2e3fc46..8fa2c2ae 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -171,6 +171,7 @@ def info(setype, name=None):
             'aliases': map(str, x.aliases()),
             'name': str(x),
             'permissive': bool(x.ispermissive),
+            'attributes': map(str, x.attributes())
         } for x in q.results())
 
     elif setype == ROLE:
diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index a4dc717a..4159bafb 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -494,7 +494,7 @@ class ManPage:
             self.desc = "%s user role" % self.domainname
 
         if self.domainname in self.all_users:
-            self.attributes = sepolicy.info(sepolicy.TYPE, (self.type))[0]["attributes"]
+            self.attributes = next(sepolicy.info(sepolicy.TYPE, (self.type)))["attributes"]
             self._user_header()
             self._user_attribute()
             self._can_sudo()
@@ -539,7 +539,7 @@ class ManPage:
                     self.man_page_path = man_page_path
             except KeyError:
                 continue;
-            self.attributes[domain_type] = sepolicy.info(sepolicy.TYPE, ("%s") % domain_type)[0]["attributes"]
+            self.attributes[domain_type] = next(sepolicy.info(sepolicy.TYPE, ("%s") % domain_type))["attributes"]
 
         self._header()
         self._entrypoints()
-- 
2.12.2
