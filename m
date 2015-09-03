Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t83FITv3025245
 for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2015 11:18:30 -0400
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage: save homedir_template in the policy store for
 genhomedircon
Date: Thu, 3 Sep 2015 11:18:01 -0400
Message-ID: <1441293481-13903-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We don't currently store homedir_template in the policy store, which
means genhomedircon only has a template file to use if the
homedir_template was generated from the file contexts in the same
transaction.  But homedir_template isn't always generated, as in the
case with setsebool -P. In this and other cases, genhomedircon will not
have a template file resulting in an empty file_contexts.homedir file.

This commit changes this so that homedir_template is always stored in
the policy store so it can be used by genhomedircon regardless of how
policy was built. Also add the homedir_template file to the migration
script.

Signed-off by: Steve Lawrence <slawrence@tresys.com>
---
 libsemanage/src/direct_api.c             | 1 -
 libsemanage/utils/semanage_migrate_store | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 90a7b22..6e49cae 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1415,7 +1415,6 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	/* remove files that are automatically generated and no longer needed */
 	unlink(semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL));
-	unlink(semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
 	unlink(semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA));
 
 	if (sh->do_rebuild || modified || bools_modified || fcontexts_modified) {
diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
index 539f469..297c71b 100755
--- a/libsemanage/utils/semanage_migrate_store
+++ b/libsemanage/utils/semanage_migrate_store
@@ -251,7 +251,8 @@ if __name__ == "__main__":
 		"disable_dontaudit",
 		"preserve_tunables",
 		"policy.kern",
-		"file_contexts"]
+		"file_contexts",
+		"homedir_template"]
 
 
 	create_dir(newroot_path(), 0o755)
-- 
2.4.3
