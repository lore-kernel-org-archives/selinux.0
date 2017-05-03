Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfQ029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5BCF8C04B320
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:08 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 11/19] sepolicy: Don't return filter(),
 use [ ] notation instead
Date: Wed,  3 May 2017 12:30:28 +0200
Message-Id: <20170503103036.17514-12-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

filter() changed it's behavior among python 2 and python 3

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 22c72b2f..074d20ef 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -383,7 +383,12 @@ def get_conditionals(src, dest, tclass, perm):
 
 
 def get_conditionals_format_text(cond):
-    enabled = len(filter(lambda x: x['boolean'][0][1], cond)) > 0
+
+    enabled = False
+    for x in cond:
+        if x['boolean'][0][1]:
+            enabled = True
+            break
     return _("-- Allowed %s [ %s ]") % (enabled, " || ".join(set(map(lambda x: "%s=%d" % (x['boolean'][0][0], x['boolean'][0][1]), cond))))
 
 
@@ -465,7 +470,7 @@ def find_file(reg):
 
     try:
         pat = re.compile(r"%s$" % reg)
-        return filter(pat.match, map(lambda x: path + x, os.listdir(path)))
+        return [x for x in map(lambda x: path + x, os.listdir(path)) if pat.match(x)]
     except:
         return []
 
@@ -589,7 +594,7 @@ def get_fcdict(fc_path=selinux.selinux_file_context_path()):
 
 def get_transitions_into(setype):
     try:
-        return filter(lambda x: x["transtype"] == setype, search([TRANSITION], {'class': 'process'}))
+        return [x for x in search([TRANSITION], {'class': 'process'}) if x["transtype"] == setype]
     except (TypeError, AttributeError):
         pass
     return None
@@ -605,7 +610,7 @@ def get_transitions(setype):
 
 def get_file_transitions(setype):
     try:
-        return filter(lambda x: x['class'] != "process", search([TRANSITION], {'source': setype}))
+        return [x for x in search([TRANSITION], {'source': setype}) if x['class'] != "process"]
     except (TypeError, AttributeError):
         pass
     return None
-- 
2.12.2
