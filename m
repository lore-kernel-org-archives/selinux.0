Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7P8vNJA002301
 for <selinux@tycho.nsa.gov>; Tue, 25 Aug 2015 04:57:23 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id 54632FC0C6
 for <selinux@tycho.nsa.gov>; Tue, 25 Aug 2015 08:57:20 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: audit2* - ignore setlocale errors
Date: Tue, 25 Aug 2015 10:57:10 +0200
Message-Id: <1440493030-21469-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When a user has invalid locales set, audit2allow and audit2why fail with
a traceback. This could be safely ignored as it will stay with 'C'
locale.

Fixes:
Traceback (most recent call last):
  File "policycoreutils/audit2allow/audit2allow", line 35, in <module>
    locale.setlocale(locale.LC_ALL, '')
  File "/usr/lib64/python2.7/locale.py", line 579, in setlocale
    return _setlocale(category, locale)
locale.Error: unsupported locale setting

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/audit2allow/audit2allow | 5 ++++-
 policycoreutils/audit2allow/audit2why   | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/audit2allow/audit2allow b/policycoreutils/audit2allow/audit2allow
index 6bbab40..e23e418 100644
--- a/policycoreutils/audit2allow/audit2allow
+++ b/policycoreutils/audit2allow/audit2allow
@@ -32,7 +32,10 @@ import sepolgen.module as module
 from sepolgen.sepolgeni18n import _
 import selinux.audit2why as audit2why
 import locale
-locale.setlocale(locale.LC_ALL, '')
+try:
+    locale.setlocale(locale.LC_ALL, '')
+except:
+    pass
 
 
 class AuditToPolicy:
diff --git a/policycoreutils/audit2allow/audit2why b/policycoreutils/audit2allow/audit2why
index 3909b97..b1489ed 100644
--- a/policycoreutils/audit2allow/audit2why
+++ b/policycoreutils/audit2allow/audit2why
@@ -32,7 +32,10 @@ import sepolgen.module as module
 from sepolgen.sepolgeni18n import _
 import selinux.audit2why as audit2why
 import locale
-locale.setlocale(locale.LC_ALL, '')
+try:
+    locale.setlocale(locale.LC_ALL, '')
+except:
+    pass
 
 
 class AuditToPolicy:
-- 
2.5.0
