Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7CKRjSk017858
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 16:27:45 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5D388564728
 for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2018 22:26:01 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 12 Aug 2018 22:25:15 +0200
Message-Id: <20180812202522.3743-7-nicolas.iooss@m4x.org>
In-Reply-To: <20180812202522.3743-1-nicolas.iooss@m4x.org>
References: <20180812202522.3743-1-nicolas.iooss@m4x.org>
Subject: [PATCH v2 06/13] python/sepolgen: fix refpolicy parsing of
 "permissive"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

p_permissive() uses an undefined variable t, which is buggy. In order to
ignore permissive statements, the function only needs to "pass".

flake8 reported the following error:

    python/sepolgen/src/sepolgen/refparser.py:789:5: F821 undefined name 't'

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolgen/src/sepolgen/refparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index 2cef8e85c679..3415aff9b48f 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -786,7 +786,7 @@ def p_role_allow(p):
 
 def p_permissive(p):
     'permissive : PERMISSIVE names SEMI'
-    t.skip(1)
+    pass
 
 def p_avrule_def(p):
     '''avrule_def : ALLOW names names COLON names names SEMI
-- 
2.18.0
