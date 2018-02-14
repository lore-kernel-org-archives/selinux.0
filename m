Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1E9rqY8011953
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 04:53:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E0C97CBA5
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 09:53:49 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 14 Feb 2018 10:53:36 +0100
Message-Id: <20180214095337.1945-4-plautrba@redhat.com>
In-Reply-To: <20180214095337.1945-1-plautrba@redhat.com>
References: <20180214095337.1945-1-plautrba@redhat.com>
Subject: [PATCH 3/4] python/sepolicy: Use list instead of map
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

map() returns an iterator in python3, list in python2

Fixes:
File "/usr/lib/python3.6/site-packages/sepolicy/generate.py", line 114, in get_all_users
  users.remove("system_u")
AttributeError: 'map' object has no attribute 'remove'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/generate.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index d68f96ef..1b36eb6e 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -110,7 +110,7 @@ def get_all_ports():
 
 
 def get_all_users():
-    users = map(lambda x: x['name'], sepolicy.info(sepolicy.USER))
+    users = [x['name'] for x in sepolicy.info(sepolicy.USER)]
     users.remove("system_u")
     users.remove("root")
     users.sort()
-- 
2.16.1
