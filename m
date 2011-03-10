From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, cpebenito@tresys.com
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] file_type objects retain user role.
Date: Thu, 10 Mar 2011 14:51:51 +0800
Message-Id: <1299739911-19352-4-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1299739911-19352-1-git-send-email-qingtao.cao@windriver.com>
References: <1299739911-19352-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

All newly created objects within the file_type attribute would
retain the user's role.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 policy/modules/kernel/files.if      |   34 ++++++++++++++++++++++++++++++++++
 policy/modules/system/userdomain.if |    4 ++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/policy/modules/kernel/files.if b/policy/modules/kernel/files.if
index ed203b2..3814e56 100644
--- a/policy/modules/kernel/files.if
+++ b/policy/modules/kernel/files.if
@@ -5844,3 +5844,37 @@ interface(`files_unconfined',`
 
 	typeattribute $1 files_unconfined_type;
 ')
+
+#######################################
+## <summary>
+##	Allow files and dirs created by user
+##	retain user role.
+## </summary>
+## <desc>
+##	<p>
+##	Allow files and dirs created by user
+##	retain user role.
+##	</p>
+## </desc>
+## <param name="role">
+##	<summary>
+##	The user role
+##	</summary>
+## </param>
+## <param name="userdomain">
+##	<summary>
+##	The user domain
+##	</summary>
+## </param>
+## <rolebase/>
+#
+interface(`files_retain_user_role',`
+	gen_require(`
+		role object_r;
+		attribute file_type;
+	')
+
+	role_transition object_r $2 $1;
+	role $1 types file_type;
+')
+
diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
index 28b88de..a087cb1 100644
--- a/policy/modules/system/userdomain.if
+++ b/policy/modules/system/userdomain.if
@@ -534,6 +534,10 @@ template(`userdom_common_user_template',`
 	# Stat lost+found.
 	files_getattr_lost_found_dirs($1_t)
 
+	# All types of file_type attribute retain the user role
+	# rather than the default object_r.
+	files_retain_user_role($1_r, $1_t)
+
 	fs_rw_cgroup_files($1_t)
 
 	# cjp: some of this probably can be removed
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
