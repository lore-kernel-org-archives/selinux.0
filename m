Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1ELHr7O022263
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 16:17:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 3zhXLR58zMz19Ytv
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 21:17:51 +0000 (UTC)
Received: from UPBD19PA13.eemsg.mil (unknown [192.168.18.15])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 3zhXLR4d6Gz19Ytl
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 801D0561258
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 22:16:49 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Wed, 14 Feb 2018 22:16:24 +0100
Message-Id: <20180214211625.531-2-nicolas.iooss@m4x.org>
In-Reply-To: <20180214211625.531-1-nicolas.iooss@m4x.org>
References: <20180214211625.531-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/3] python/sepolicy: Initialize policy.ports as a
 dict in generate.py
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

in class policy, ports is usually initialized with the result of
get_all_ports(), which is a dict. If this function failed, the error was
not fatal but ports was left initialized as a list, which would trigger
other errors when accessing it.

Initialize ports as an empty dict in order to fix this issue.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/generate.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index 35623a01acfe..f885425806f1 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -198,7 +198,7 @@ class policy:
 
     def __init__(self, name, type):
         self.rpms = []
-        self.ports = []
+        self.ports = {}
         self.all_roles = get_all_roles()
         self.types = []
 
-- 
2.16.0
