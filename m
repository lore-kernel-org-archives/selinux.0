From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, cpebenito@tresys.com
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] Files and dirs objects could retain user role.
Date: Fri, 11 Mar 2011 15:20:58 +0800
Message-Id: <1299828060-18411-2-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1299828060-18411-1-git-send-email-qingtao.cao@windriver.com>
References: <1299828060-18411-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Provide an interface to have the newly created files or dirs objects
have a chance to retain its creator's role.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 policy/modules/kernel/files.if      |   32 ++++++++++++++++++++++++++++++++
 policy/modules/system/userdomain.if |    4 ++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/policy/modules/kernel/files.if b/policy/modules/kernel/files.if
index ed203b2..dbec8d3 100644
--- a/policy/modules/kernel/files.if
+++ b/policy/modules/kernel/files.if
@@ -5844,3 +5844,35 @@ interface(`files_unconfined',`
 
 	typeattribute $1 files_unconfined_type;
 ')
+
+#######################################
+## <summary>
+##	Allow files and dirs with specified type
+##	retain its creator role.
+## </summary>
+## <desc>
+##	<p>
+##	Allow files and dirs with specified type
+##	retain its creator role.
+##	</p>
+## </desc>
+## <param name="role">
+##	<summary>
+##	The creator role
+##	</summary>
+## </param>
+## <param name="domain">
+##	<summary>
+##	The new object type
+##	</summary>
+## </param>
+## <rolebase/>
+#
+interface(`files_retain_creator_role',`
+	gen_require(`
+		attribute file_type;
+	')
+
+	role_transition $1 $2 $1;
+	role $1 types $2;
+')
diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
index 28b88de..dddc9e3 100644
--- a/policy/modules/system/userdomain.if
+++ b/policy/modules/system/userdomain.if
@@ -245,6 +245,10 @@ interface(`userdom_manage_home_role',`
 	# cjp: this should probably be removed:
 	allow $2 user_home_dir_t:dir { manage_dir_perms relabel_dir_perms };
 
+	# new files or dirs object created in user HOME directory
+	# retain the creator role.
+	files_retain_creator_role($1, user_home_t)	
+
 	tunable_policy(`use_nfs_home_dirs',`
 		fs_manage_nfs_dirs($2)
 		fs_manage_nfs_files($2)
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
