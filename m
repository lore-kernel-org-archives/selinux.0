Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1ELHL99022241
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 16:17:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 3zhXKv25TQz19Ytk
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 21:17:23 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 3zhXKv1ZHyz19Ytg
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 21:17:23 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5A753561257
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 22:16:48 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Wed, 14 Feb 2018 22:16:23 +0100
Message-Id: <20180214211625.531-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/3] python/sepolicy: Support non-MLS policy
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When using sepolgen GUI on a system with a non-MLS policy,
sepolicy.info(sepolicy.PORT) does not define "range" attributes (since
commit 908340e8e7a9 ("sepolicy: support non-MLS policy in manpage")).
Replace them with None in get_all_ports() result.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/generate.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index d68f96ef5ca5..35623a01acfe 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -105,7 +105,7 @@ def get_all_ports():
                 p['type'] == "port_t" or \
                 p['type'] == "hi_reserved_port_t":
             continue
-        dict[(p['low'], p['high'], p['protocol'])] = (p['type'], p['range'])
+        dict[(p['low'], p['high'], p['protocol'])] = (p['type'], p.get('range'))
     return dict
 
 
-- 
2.16.0
