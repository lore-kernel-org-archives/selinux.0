From: "Daniel P. Berrange" <berrange@redhat.com>
To: SELinux@tycho.nsa.gov
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH libselinux 03/11] Fix old style function definitions
Date: Mon, 23 Jan 2012 15:41:13 +0000
Message-Id: <1327333281-4223-4-git-send-email-berrange@redhat.com>
In-Reply-To: <1327333281-4223-1-git-send-email-berrange@redhat.com>
References: <1327333281-4223-1-git-send-email-berrange@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: "Daniel P. Berrange" <berrange@redhat.com>

Add 'void' parameter to all functions which take no arguments

* selinux_config.c: s/()/(void)/
---
 libselinux/src/selinux_config.c |   52 +++++++++++++++++++-------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index f4c33df..f42cb7c 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -246,172 +246,172 @@ static const char *get_path(int idx)
 	return file_paths[idx];
 }
 
-const char *selinux_default_type_path()
+const char *selinux_default_type_path(void)
 {
 	return get_path(DEFAULT_TYPE);
 }
 
 hidden_def(selinux_default_type_path)
 
-const char *selinux_policy_root()
+const char *selinux_policy_root(void)
 {
 	__selinux_once(once, init_selinux_config);
 	return selinux_policyroot;
 }
 
-const char *selinux_path()
+const char *selinux_path(void)
 {
 	return selinux_rootpath;
 }
 
 hidden_def(selinux_path)
 
-const char *selinux_default_context_path()
+const char *selinux_default_context_path(void)
 {
 	return get_path(DEFAULT_CONTEXTS);
 }
 
 hidden_def(selinux_default_context_path)
 
-const char *selinux_securetty_types_path()
+const char *selinux_securetty_types_path(void)
 {
 	return get_path(SECURETTY_TYPES);
 }
 
 hidden_def(selinux_securetty_types_path)
 
-const char *selinux_failsafe_context_path()
+const char *selinux_failsafe_context_path(void)
 {
 	return get_path(FAILSAFE_CONTEXT);
 }
 
 hidden_def(selinux_failsafe_context_path)
 
-const char *selinux_removable_context_path()
+const char *selinux_removable_context_path(void)
 {
 	return get_path(REMOVABLE_CONTEXT);
 }
 
 hidden_def(selinux_removable_context_path)
 
-const char *selinux_binary_policy_path()
+const char *selinux_binary_policy_path(void)
 {
 	return get_path(BINPOLICY);
 }
 
 hidden_def(selinux_binary_policy_path)
 
-const char *selinux_file_context_path()
+const char *selinux_file_context_path(void)
 {
 	return get_path(FILE_CONTEXTS);
 }
 
 hidden_def(selinux_file_context_path)
 
-const char *selinux_homedir_context_path()
+const char *selinux_homedir_context_path(void)
 {
 	return get_path(HOMEDIR_CONTEXTS);
 }
 
 hidden_def(selinux_homedir_context_path)
 
-const char *selinux_media_context_path()
+const char *selinux_media_context_path(void)
 {
 	return get_path(MEDIA_CONTEXTS);
 }
 
 hidden_def(selinux_media_context_path)
 
-const char *selinux_customizable_types_path()
+const char *selinux_customizable_types_path(void)
 {
 	return get_path(CUSTOMIZABLE_TYPES);
 }
 
 hidden_def(selinux_customizable_types_path)
 
-const char *selinux_contexts_path()
+const char *selinux_contexts_path(void)
 {
 	return get_path(CONTEXTS_DIR);
 }
 
-const char *selinux_user_contexts_path()
+const char *selinux_user_contexts_path(void)
 {
 	return get_path(USER_CONTEXTS);
 }
 
 hidden_def(selinux_user_contexts_path)
 
-const char *selinux_booleans_path()
+const char *selinux_booleans_path(void)
 {
 	return get_path(BOOLEANS);
 }
 
 hidden_def(selinux_booleans_path)
 
-const char *selinux_users_path()
+const char *selinux_users_path(void)
 {
 	return get_path(USERS_DIR);
 }
 
 hidden_def(selinux_users_path)
 
-const char *selinux_usersconf_path()
+const char *selinux_usersconf_path(void)
 {
 	return get_path(SEUSERS);
 }
 
 hidden_def(selinux_usersconf_path)
 
-const char *selinux_translations_path()
+const char *selinux_translations_path(void)
 {
 	return get_path(TRANSLATIONS);
 }
 
 hidden_def(selinux_translations_path)
 
-const char *selinux_colors_path()
+const char *selinux_colors_path(void)
 {
 	return get_path(COLORS);
 }
 
 hidden_def(selinux_colors_path)
 
-const char *selinux_netfilter_context_path()
+const char *selinux_netfilter_context_path(void)
 {
 	return get_path(NETFILTER_CONTEXTS);
 }
 
 hidden_def(selinux_netfilter_context_path)
 
-const char *selinux_file_context_homedir_path()
+const char *selinux_file_context_homedir_path(void)
 {
 	return get_path(FILE_CONTEXTS_HOMEDIR);
 }
 
 hidden_def(selinux_file_context_homedir_path)
 
-const char *selinux_file_context_local_path()
+const char *selinux_file_context_local_path(void)
 {
 	return get_path(FILE_CONTEXTS_LOCAL);
 }
 
 hidden_def(selinux_file_context_local_path)
 
-const char *selinux_x_context_path()
+const char *selinux_x_context_path(void)
 {
 	return get_path(X_CONTEXTS);
 }
 
 hidden_def(selinux_x_context_path)
 
-const char *selinux_virtual_domain_context_path()
+const char *selinux_virtual_domain_context_path(void)
 {
 	return get_path(VIRTUAL_DOMAIN);
 }
 
 hidden_def(selinux_virtual_domain_context_path)
 
-const char *selinux_virtual_image_context_path()
+const char *selinux_virtual_image_context_path(void)
 {
 	return get_path(VIRTUAL_IMAGE);
 }
@@ -430,7 +430,7 @@ const char * selinux_file_context_subs_dist_path(void) {
 
 hidden_def(selinux_file_context_subs_dist_path)
 
-const char *selinux_sepgsql_context_path()
+const char *selinux_sepgsql_context_path(void)
 {
 	return get_path(SEPGSQL_CONTEXTS);
 }
-- 
1.7.7.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
