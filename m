Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB6Ewr6x014998
 for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2016 09:58:53 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24E2EC05093D
 for <selinux@tycho.nsa.gov>; Tue,  6 Dec 2016 14:58:50 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] python/sepolicy/sepolicy/gui: Reflect sepolicy changes into
 gui
Date: Tue,  6 Dec 2016 15:58:33 +0100
Message-Id: <1481036313-11915-2-git-send-email-vmojzis@redhat.com>
In-Reply-To: <1481036313-11915-1-git-send-email-vmojzis@redhat.com>
References: <15202ae0-3133-0a2e-950c-1d4bf59c4eb9@redhat.com>
 <1481036313-11915-1-git-send-email-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

sepolicy.get_init_entrypoint() now returns list of Type objects
instead of single string, which caused sepolicy gui to crash.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/sepolicy/sepolicy/gui.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 3c5a9d2..6ccd02a 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -512,8 +512,8 @@ class SELinuxGui():
             self.progress_bar.set_pulse_step(self.percentage)
             self.idle_func()
 
-            entrypoint = sepolicy.get_init_entrypoint(domain)
-            if entrypoint:
+            entrypoints = [str(x) for x in sepolicy.get_init_entrypoint(domain)]
+            for entrypoint in entrypoints:
                 path = sepolicy.find_entrypoint_path(entrypoint)
                 if path:
                     self.combo_box_initialize(path, None)
-- 
2.7.4
