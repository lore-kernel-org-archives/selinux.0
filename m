Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sB2IjqBv028072
 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2014 13:45:53 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage: ensure migrated files have the correct types
Date: Tue, 2 Dec 2014 13:45:35 -0500
Message-ID: <1417545935-27827-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

All files in /var/lib/selinux/ are now labeled the same as those in
/etc/selinux/<store>/modules/active, which in refpolicy is semanage_store_t.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
Reviewed-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 libsemanage/utils/semanage_migrate_store | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
index 0371e49..03b492e 100755
--- a/libsemanage/utils/semanage_migrate_store
+++ b/libsemanage/utils/semanage_migrate_store
@@ -138,8 +138,8 @@ def migrate_store(store):
 	print("Migrating from %s to %s" % (oldstore, newstore))
 
 	# Build up new directory structure
-	create_dir_from(selinux.selinux_policy_root(), "%s/%s" % (newroot_path(), store), 0o755)
-	create_dir_from(oldmodules, newstore, 0o700)
+	create_dir_from(oldstore, "%s/%s" % (newroot_path(), store), 0o755)
+	create_dir_from(oldstore, newstore, 0o700)
 	create_dir_from(oldstore, newmodules, 0o700)
 	create_dir_from(oldstore, bottomdir, 0o700)
 	create_dir_from(oldstore, disabledmodules, 0o700)
-- 
1.9.3
