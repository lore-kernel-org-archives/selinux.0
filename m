Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6UEMhdA012344
 for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2015 10:22:43 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id A989883F6B
 for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2015 14:22:40 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] semanage_migrate_store: add -r <root> option for migrating
 inside chroots
Date: Thu, 30 Jul 2015 16:22:34 +0200
Message-Id: <1438266154-23219-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-r, --root
  Set an alternative root for the migration (default: /)

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

In Fedora, we used this option in early phase of adopting 2.4 userspace to
migrate SELinux modules in buildroots during build time. We don't use it anymore,
but it might be useful for some other deployments.

 libsemanage/utils/semanage_migrate_store | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
index 6443002..539f469 100755
--- a/libsemanage/utils/semanage_migrate_store
+++ b/libsemanage/utils/semanage_migrate_store
@@ -180,7 +180,7 @@ def rebuild_policy():
 
 
 def oldroot_path():
-	return "/etc/selinux"
+	return "%s/etc/selinux" % ROOT
 
 def oldstore_path(store):
 	return "%s/%s/modules/active" % (oldroot_path(), store)
@@ -192,7 +192,7 @@ def disabledmodules_path(store):
 	return "%s/disabled" % newmodules_path(store)
 
 def newroot_path():
-	return PATH
+	return "%s%s" % (ROOT, PATH)
 
 def newstore_path(store):
 	return "%s/%s/active" % (newroot_path(), store)
@@ -219,6 +219,8 @@ if __name__ == "__main__":
 			  help="Disable rebuilding policy after migration (default: no)")
 	parser.add_option("-P", "--path", dest="path",
 			  help="Set path for the policy store (default: /var/lib/selinux)")
+	parser.add_option("-r", "--root", dest="root",
+			  help="Set an alternative root for the migration (default: /)")
 
 	(options, args) = parser.parse_args()
 
@@ -231,6 +233,10 @@ if __name__ == "__main__":
 	if PATH is None:
 		PATH = "/var/lib/selinux"
 
+	ROOT = options.root
+	if ROOT is None:
+		ROOT = ""
+
 	# List of paths that go in the active 'root'
 	TOPPATHS = [
 		"commit_num",
-- 
2.4.6
