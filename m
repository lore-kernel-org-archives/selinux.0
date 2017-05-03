Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfV029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF4FE8046B
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:15 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 16/19] sepolicy: setools.*Query wants a list in ruletype
Date: Wed,  3 May 2017 12:30:33 +0200
Message-Id: <20170503103036.17514-17-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This fixes a problem introduced in 18410c86 where ruletype is specified
as a string not a list.

Fixes:
>>> sepolicy.get_all_role_allows()
Traceback (most recent call last):
  File "/usr/lib64/python3.6/site-packages/setools/policyrep/util.py", line 60, in lookup
    return cls(value)
  File "/usr/lib64/python3.6/enum.py", line 291, in __call__
    return cls.__new__(cls, value)
  File "/usr/lib64/python3.6/enum.py", line 533, in __new__
    return cls._missing_(value)
  File "/usr/lib64/python3.6/enum.py", line 546, in _missing_
    raise ValueError("%r is not a valid %s" % (value, cls.__name__))
ValueError: 'a' is not a valid RBACRuletype

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 074d20ef..d2e3fc46 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -747,7 +747,7 @@ def get_all_role_allows():
         return role_allows
     role_allows = {}
 
-    q = setools.RBACRuleQuery(_pol, ruletype='allow')
+    q = setools.RBACRuleQuery(_pol, ruletype=[ALLOW])
     for r in q.results():
         src = str(r.source)
         tgt = str(r.target)
-- 
2.12.2
