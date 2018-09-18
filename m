Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8IDiIW7019005
 for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2018 09:44:18 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
 [10.5.11.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3B03307D85F
 for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2018 13:44:09 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 18 Sep 2018 15:44:01 +0200
Message-Id: <20180918134401.22956-1-plautrba@redhat.com>
MIME-Version: 1.0
Subject: [PATCH] python/sepolicy: search() for dontaudit rules as
 well
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

dontaudit rules were accidentally dropped during rewrite to SETools 4 API=
 in
97d5f6a2

Fixes:
>>> import sepolicy
>>> sepolicy.search(['dontaudit'])
[]

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepol=
icy/__init__.py
index 89346aba..c1a60798 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -334,6 +334,8 @@ def search(types, seinfo=3DNone):
         tertypes.append(NEVERALLOW)
     if AUDITALLOW in types:
         tertypes.append(AUDITALLOW)
+    if DONTAUDIT in types:
+        tertypes.append(DONTAUDIT)
=20
     if len(tertypes) > 0:
         q =3D setools.TERuleQuery(_pol,
--=20
2.19.0
