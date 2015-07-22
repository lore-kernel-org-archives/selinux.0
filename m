From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: semanage: fix moduleRecords deleteall method
Date: Wed, 22 Jul 2015 10:05:49 -0400
Message-Id: <1437573949-7401-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

commit 2ff279e21e4715ac49e094b5fae8bc8e84b9e417 ("policycoreutils:
 semanage: update to new source policy infrastructure") introduced
new methods for enabling/disabling modules but failed to update
the deleteall method of class moduleRecords to use the new method.
The deleteall method was introduced by commit
3dafb1046d847783f1e761535925ea79d69d3305 ("Add deleteall customizations
field for modules.") as a way to re-enable all locally disabled modules.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policycoreutils/semanage/seobject.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 2edb050..4c81a7b 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -378,7 +378,7 @@ class moduleRecords(semanageRecords):
 	def deleteall(self):
                 l = map(lambda x: x[0], filter(lambda t: t[1] == 0, self.get_all()))
                 for m in l:
-                        self.enable(m)
+                        self.set_enabled(m, True)
 
 class dontauditClass(semanageRecords):
 	def __init__(self, store):
-- 
2.1.0
