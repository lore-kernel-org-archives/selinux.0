Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w76KV6ek025468
 for <selinux@tycho.nsa.gov>; Mon, 6 Aug 2018 16:31:06 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id F1E8656474A
 for <selinux@tycho.nsa.gov>; Mon,  6 Aug 2018 22:30:26 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Mon,  6 Aug 2018 22:29:55 +0200
Message-Id: <20180806202955.8638-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/1] python/sepolicy: add missing % in network tab help text
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/help/ports_inbound.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/help/ports_inbound.txt b/python/sepolicy/sepolicy/help/ports_inbound.txt
index 1325abfeef1b..be16034462b2 100644
--- a/python/sepolicy/sepolicy/help/ports_inbound.txt
+++ b/python/sepolicy/sepolicy/help/ports_inbound.txt
@@ -3,4 +3,4 @@ This screen shows the network ports that processes running with the '%(APP)s' ty
 
 SELinux controls the network ports that a application is allowed to bind to based on SELinux Port types.
 
-This screen allows you to modify the port number/port type definitions, which the '(APP)s' is currently allowed to bind.
+This screen allows you to modify the port number/port type definitions, which the '%(APP)s' is currently allowed to bind.
-- 
2.18.0
