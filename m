Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798A19F41B
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334645; cv=none; b=Ro3qEQuJutvKOXuSDf/X7XPktHTDxKbt8PiYpZdAF2uh5Zclnja6lHh6BjT54sPCftlqLE3kdJxobER06GMHKTAdpaImIDJ8nj92WBLVw8k3C6ooGUiU3ZK3jeZKBFEO4oxj8Y/7ZGazBJ/I5XdczKW4TUKGoakpARyV5kH8A5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334645; c=relaxed/simple;
	bh=mIYzz/3frDMJqOCbgZ9H5V+XrzrCBwBCGAKhx6VP+z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAdI08j7oUc3sXgQSvWPRvLwbMWAJipoQHHxRYuYjANijZ48ykzlY1TsdDRrV1AuGuX6N4X23N/QR6GOW67rxRUOXHBmM+x+5oGYPZTEV7jg34zl1STr9eqOocthsFCfXpLql6RmTQt3g6aVHA77XyFewCMBrOelCBFgW13eq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=LZP6m+wp; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="LZP6m+wp"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334638;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEzBNfEpNfiPDgohy/Jb1uo9aHSZrzIEXLSExTZ60b8=;
	b=LZP6m+wpBzZ4MCsu5eKICK0haCzHUtUvUWYBExVBZHQylZrhltv/9Fj3WIveJ3bcFgzwnT
	N4UjttrclWGa7ldhcpKlokJJUWEgQ+nyz0GRmGF06TOXe3VDKKuYzEFhxidwosDzzUPDrs
	H/xL62JTl38naGGqpZOrobE/cpTdcmzYoBMcxR2+nl++MDT07VvgRH6HsaIe3jlrohFi3A
	kVceTlV//iDYBn5xa3fZhyH17mwWKoj/VD6HRc6GrwbC8w7N/JvnUH3YTfunI+2XhHAHrD
	0aQtW/lJjuiovvVpkyGGBDN6xNJhLVV9m+Eau8dBUh9Ee/+Z3cbniRmbL7nfeA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 29/47] libsemanage: constify read only parameters and variables
Date: Mon, 11 Nov 2024 15:16:48 +0100
Message-ID: <20241111141706.38039-29-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/include/semanage/handle.h |  4 ++--
 libsemanage/src/booleans_file.c       |  2 +-
 libsemanage/src/database.c            |  2 +-
 libsemanage/src/database_file.h       |  2 +-
 libsemanage/src/database_llist.h      |  4 ++--
 libsemanage/src/direct_api.c          |  8 ++++----
 libsemanage/src/fcontexts_file.c      |  2 +-
 libsemanage/src/genhomedircon.c       | 12 ++++++------
 libsemanage/src/handle.c              |  4 ++--
 libsemanage/src/ibendports_file.c     |  5 +++--
 libsemanage/src/ibpkeys_file.c        |  5 +++--
 libsemanage/src/interfaces_file.c     |  2 +-
 libsemanage/src/nodes_file.c          |  2 +-
 libsemanage/src/parse_utils.c         |  2 +-
 libsemanage/src/policy_components.c   |  4 ++--
 libsemanage/src/ports_file.c          |  2 +-
 libsemanage/src/semanage_store.c      | 16 ++++++++--------
 libsemanage/src/seusers_file.c        |  2 +-
 libsemanage/src/users_base_file.c     |  4 ++--
 libsemanage/src/users_extra_file.c    |  2 +-
 libsemanage/src/utilities.c           |  4 ++--
 21 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index 41db000f..a5ea31de 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -51,7 +51,7 @@ enum semanage_connect_type {
  * It must be called after semanage_handle_create but before
  * semanage_connect. The argument should be the full path to the store.
  */
-extern void semanage_select_store(semanage_handle_t * handle, char *path,
+extern void semanage_select_store(semanage_handle_t * handle, const char *path,
 				  enum semanage_connect_type storetype);
 
 /* Just reload the policy */
@@ -74,7 +74,7 @@ extern void semanage_set_check_ext_changes(semanage_handle_t * handle, int do_ch
 /* Fills *compiler_path with the location of the hll compiler sh->conf->compiler_directory_path
  * corresponding to lang_ext.
  * Upon success returns 0, -1 on error. */
-extern int semanage_get_hll_compiler_path(semanage_handle_t *sh, char *lang_ext, char **compiler_path);
+extern int semanage_get_hll_compiler_path(semanage_handle_t *sh, const char *lang_ext, char **compiler_path);
 
 /* create the store if it does not exist, this only has an effect on
  * direct connections and must be called before semanage_connect
diff --git a/libsemanage/src/booleans_file.c b/libsemanage/src/booleans_file.c
index 52628b63..9f2ad1f2 100644
--- a/libsemanage/src/booleans_file.c
+++ b/libsemanage/src/booleans_file.c
@@ -21,7 +21,7 @@ typedef struct dbase_file dbase_t;
 #include "debug.h"
 
 static int bool_print(semanage_handle_t * handle,
-		      semanage_bool_t * boolean, FILE * str)
+		      const semanage_bool_t * boolean, FILE * str)
 {
 
 	const char *name = semanage_bool_get_name(boolean);
diff --git a/libsemanage/src/database.c b/libsemanage/src/database.c
index fc4f7179..921a4052 100644
--- a/libsemanage/src/database.c
+++ b/libsemanage/src/database.c
@@ -6,7 +6,7 @@
 #include "database.h"
 #include "debug.h"
 
-static int assert_init(semanage_handle_t * handle, dbase_config_t * dconfig)
+static int assert_init(semanage_handle_t * handle, const dbase_config_t * dconfig)
 {
 
 	if (dconfig->dtable == NULL) {
diff --git a/libsemanage/src/database_file.h b/libsemanage/src/database_file.h
index c65a9f9a..f5d9d81b 100644
--- a/libsemanage/src/database_file.h
+++ b/libsemanage/src/database_file.h
@@ -22,7 +22,7 @@ typedef struct record_file_table {
 
 	/* Print record to stream */
 	int (*print) (semanage_handle_t * handle,
-		      record_t * record, FILE * str);
+		      const record_t * record, FILE * str);
 
 } record_file_table_t;
 
diff --git a/libsemanage/src/database_llist.h b/libsemanage/src/database_llist.h
index 639b784d..de843683 100644
--- a/libsemanage/src/database_llist.h
+++ b/libsemanage/src/database_llist.h
@@ -69,14 +69,14 @@ static inline void dbase_llist_set_modified(dbase_llist_t * dbase, int status)
 /* LLIST - cache/transactions */
 extern void dbase_llist_drop_cache(dbase_llist_t * dbase);
 
-static inline int dbase_llist_is_modified(dbase_llist_t * dbase)
+static inline int dbase_llist_is_modified(const dbase_llist_t * dbase)
 {
 
 	return dbase->modified;
 }
 
 /* LLIST - polymorphism */
-static inline const record_table_t *dbase_llist_get_rtable(dbase_llist_t * dbase)
+static inline const record_table_t *dbase_llist_get_rtable(const dbase_llist_t * dbase)
 {
 	return dbase->rtable;
 }
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index b71e8e81..3b2ab449 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -618,7 +618,7 @@ static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len, int
 	return 0;
 }
 
-static int semanage_pipe_data(semanage_handle_t *sh, char *path, char *in_data, size_t in_data_len, char **out_data, size_t *out_data_len, char **err_data, size_t *err_data_len)
+static int semanage_pipe_data(semanage_handle_t *sh, const char *path, const char *in_data, size_t in_data_len, char **out_data, size_t *out_data_len, char **err_data, size_t *err_data_len)
 {
 	int input_fd[2] = {-1, -1};
 	int output_fd[2] = {-1, -1};
@@ -1722,8 +1722,8 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 
 	int retval = -1;
 	char *path = NULL;
-	char *filename;
-	char *lang_ext = NULL;
+	const char *filename;
+	const char *lang_ext = NULL;
 	char *module_name = NULL;
 	char *separator;
 	char *version = NULL;
@@ -2215,7 +2215,7 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
 
 	semanage_module_info_t *modinfos = NULL;
 	int modinfos_len = 0;
-	semanage_module_info_t *highest = NULL;
+	const semanage_module_info_t *highest = NULL;
 
 	/* check module name */
 	ret = semanage_module_validate_name(modkey->name);
diff --git a/libsemanage/src/fcontexts_file.c b/libsemanage/src/fcontexts_file.c
index e4ef1672..c3c1fc4f 100644
--- a/libsemanage/src/fcontexts_file.c
+++ b/libsemanage/src/fcontexts_file.c
@@ -43,7 +43,7 @@ static const char *type_str(int type)
 }
 
 static int fcontext_print(semanage_handle_t * handle,
-			  semanage_fcontext_t * fcontext, FILE * str)
+			  const semanage_fcontext_t * fcontext, FILE * str)
 {
 
 	char *con_str = NULL;
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 5e7315d8..2fabbbd8 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -170,7 +170,7 @@ err:
 }
 
 static int ignore(const char *homedir) {
-	ignoredir_t *ptr = ignore_head;
+	const ignoredir_t *ptr = ignore_head;
 	while (ptr) {
 		if (strcmp(ptr->dir, homedir) == 0) {
 			return 1;
@@ -685,7 +685,7 @@ fail:
 static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
 				  semanage_list_t * tpl, const genhomedircon_user_entry_t *user)
 {
-	replacement_pair_t repl[] = {
+	const replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_HOME_DIR,.replace_with = user->home},
 		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
 		{NULL, NULL}
@@ -703,9 +703,9 @@ static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
 }
 
 static int write_home_root_context(genhomedircon_settings_t * s, FILE * out,
-				   semanage_list_t * tpl, char *homedir)
+				   semanage_list_t * tpl, const char *homedir)
 {
-	replacement_pair_t repl[] = {
+	const replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_HOME_ROOT,.replace_with = homedir},
 		{NULL, NULL}
 	};
@@ -717,7 +717,7 @@ static int write_username_context(genhomedircon_settings_t * s, FILE * out,
 				  semanage_list_t * tpl,
 				  const genhomedircon_user_entry_t *user)
 {
-	replacement_pair_t repl[] = {
+	const replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_USERNAME,.replace_with = user->name},
 		{.search_for = TEMPLATE_USERID,.replace_with = user->uid},
 		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
@@ -730,7 +730,7 @@ static int write_username_context(genhomedircon_settings_t * s, FILE * out,
 static int write_user_context(genhomedircon_settings_t * s, FILE * out,
 			      semanage_list_t * tpl, const genhomedircon_user_entry_t *user)
 {
-	replacement_pair_t repl[] = {
+	const replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_USER,.replace_with = user->name},
 		{.search_for = TEMPLATE_ROLE,.replace_with = user->prefix},
 		{NULL, NULL}
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 9bb84546..4577ac35 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -138,7 +138,7 @@ void semanage_set_check_ext_changes(semanage_handle_t * sh, int do_check)
 }
 
 int semanage_get_hll_compiler_path(semanage_handle_t *sh,
-				char *lang_ext,
+				const char *lang_ext,
 				char **compiler_path)
 {
 	assert(sh != NULL);
@@ -272,7 +272,7 @@ int semanage_is_connected(semanage_handle_t * sh)
 	return sh->is_connected;
 }
 
-void semanage_select_store(semanage_handle_t * sh, char *storename,
+void semanage_select_store(semanage_handle_t * sh, const char *storename,
 			   enum semanage_connect_type storetype)
 {
 
diff --git a/libsemanage/src/ibendports_file.c b/libsemanage/src/ibendports_file.c
index 2bebbdcf..b0f0aa96 100644
--- a/libsemanage/src/ibendports_file.c
+++ b/libsemanage/src/ibendports_file.c
@@ -20,9 +20,10 @@ typedef struct dbase_file dbase_t;
 #include "debug.h"
 
 static int ibendport_print(semanage_handle_t *handle,
-			   semanage_ibendport_t *ibendport,
+			   const semanage_ibendport_t *ibendport,
 			   FILE *str)
 {
+	const semanage_context_t *con;
 	char *con_str = NULL;
 	char *ibdev_name_str = NULL;
 	int port = semanage_ibendport_get_port(ibendport);
@@ -30,7 +31,7 @@ static int ibendport_print(semanage_handle_t *handle,
 	if (semanage_ibendport_get_ibdev_name(handle, ibendport, &ibdev_name_str) != 0)
 		goto err;
 
-	semanage_context_t *con = semanage_ibendport_get_con(ibendport);
+	con = semanage_ibendport_get_con(ibendport);
 
 	if (fprintf(str, "ibendportcon %s ", ibdev_name_str) < 0)
 		goto err;
diff --git a/libsemanage/src/ibpkeys_file.c b/libsemanage/src/ibpkeys_file.c
index 7a7c5772..8dad8d47 100644
--- a/libsemanage/src/ibpkeys_file.c
+++ b/libsemanage/src/ibpkeys_file.c
@@ -20,8 +20,9 @@ typedef struct dbase_file dbase_t;
 #include "debug.h"
 
 static int ibpkey_print(semanage_handle_t *handle,
-			semanage_ibpkey_t *ibpkey, FILE *str)
+			const semanage_ibpkey_t *ibpkey, FILE *str)
 {
+	const semanage_context_t *con;
 	char *con_str = NULL;
 	char *subnet_prefix_str = NULL;
 
@@ -31,7 +32,7 @@ static int ibpkey_print(semanage_handle_t *handle,
 	if (semanage_ibpkey_get_subnet_prefix(handle, ibpkey, &subnet_prefix_str) != 0)
 		goto err;
 
-	semanage_context_t *con = semanage_ibpkey_get_con(ibpkey);
+	con = semanage_ibpkey_get_con(ibpkey);
 
 	if (fprintf(str, "ibpkeycon %s ", subnet_prefix_str) < 0)
 		goto err;
diff --git a/libsemanage/src/interfaces_file.c b/libsemanage/src/interfaces_file.c
index d61010ee..9b49e30d 100644
--- a/libsemanage/src/interfaces_file.c
+++ b/libsemanage/src/interfaces_file.c
@@ -19,7 +19,7 @@ typedef struct dbase_file dbase_t;
 #include "debug.h"
 
 static int iface_print(semanage_handle_t * handle,
-		       semanage_iface_t * iface, FILE * str)
+		       const semanage_iface_t * iface, FILE * str)
 {
 
 	char *con_str = NULL;
diff --git a/libsemanage/src/nodes_file.c b/libsemanage/src/nodes_file.c
index 3ed34be1..781da0e7 100644
--- a/libsemanage/src/nodes_file.c
+++ b/libsemanage/src/nodes_file.c
@@ -20,7 +20,7 @@ typedef struct dbase_file dbase_t;
 #include "debug.h"
 
 static int node_print(semanage_handle_t * handle,
-		      semanage_node_t * node, FILE * str)
+		      const semanage_node_t * node, FILE * str)
 {
 
 	char *con_str = NULL;
diff --git a/libsemanage/src/parse_utils.c b/libsemanage/src/parse_utils.c
index d3bc148b..d57e59c9 100644
--- a/libsemanage/src/parse_utils.c
+++ b/libsemanage/src/parse_utils.c
@@ -270,7 +270,7 @@ int parse_fetch_string(semanage_handle_t * handle,
 		       parse_info_t * info, char **str, char delim, int allow_spaces)
 {
 
-	char *start = info->ptr;
+	const char *start = info->ptr;
 	int len = 0;
 	char *tmp_str = NULL;
 
diff --git a/libsemanage/src/policy_components.c b/libsemanage/src/policy_components.c
index bd3747b6..ca3fbd20 100644
--- a/libsemanage/src/policy_components.c
+++ b/libsemanage/src/policy_components.c
@@ -115,7 +115,7 @@ int semanage_base_merge_components(semanage_handle_t * handle)
 	/* Order is important here - change things carefully.
 	 * System components first, local next. Verify runs with
 	 * mutual dependencies are ran after everything is merged */
-	load_table_t components[] = {
+	const load_table_t components[] = {
 
 		{semanage_user_base_dbase_local(handle),
 		 semanage_user_base_dbase_policy(handle), MODE_MODIFY},
@@ -210,7 +210,7 @@ int semanage_commit_components(semanage_handle_t * handle)
 {
 
 	int i;
-	dbase_config_t *components[] = {
+	const dbase_config_t *components[] = {
 		semanage_iface_dbase_local(handle),
 		semanage_bool_dbase_local(handle),
 		semanage_user_base_dbase_local(handle),
diff --git a/libsemanage/src/ports_file.c b/libsemanage/src/ports_file.c
index 64f0c79d..e2b6b5d5 100644
--- a/libsemanage/src/ports_file.c
+++ b/libsemanage/src/ports_file.c
@@ -20,7 +20,7 @@ typedef struct dbase_file dbase_t;
 #include "debug.h"
 
 static int port_print(semanage_handle_t * handle,
-		      semanage_port_t * port, FILE * str)
+		      const semanage_port_t * port, FILE * str)
 {
 
 	char *con_str = NULL;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index c84ca43b..427952a1 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -78,13 +78,13 @@ static char *semanage_files[SEMANAGE_NUM_FILES] = { NULL };
 static int semanage_paths_initialized = 0;
 
 /* These are paths relative to the bottom of the module store */
-static const char *semanage_relative_files[SEMANAGE_NUM_FILES] = {
+static const char *const semanage_relative_files[SEMANAGE_NUM_FILES] = {
 	"",
 	"/semanage.trans.LOCK",
 	"/semanage.read.LOCK"
 };
 
-static const char *semanage_store_paths[SEMANAGE_NUM_STORES] = {
+static const char *const semanage_store_paths[SEMANAGE_NUM_STORES] = {
 	"/active",
 	"/previous",
 	"/tmp"
@@ -92,7 +92,7 @@ static const char *semanage_store_paths[SEMANAGE_NUM_STORES] = {
 
 /* relative path names to enum sandbox_paths for special files within
  * a sandbox */
-static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
+static const char *const semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"",
 	"/modules",
 	"/policy.linked",
@@ -1152,7 +1152,7 @@ int semanage_get_active_modules(semanage_handle_t * sh,
 	int j = 0;
 
 	semanage_list_t *list = NULL;
-	semanage_list_t *found = NULL;
+	const semanage_list_t *found = NULL;
 
 	semanage_module_info_t *all_modinfos = NULL;
 	int all_modinfos_len = 0;
@@ -2093,7 +2093,7 @@ int semanage_direct_get_serial(semanage_handle_t * sh)
 int semanage_load_files(semanage_handle_t * sh, cil_db_t *cildb, char **filenames, int numfiles)
 {
 	int i, retval;
-	char *filename;
+	const char *filename;
 	struct file_contents contents = {};
 
 	for (i = 0; i < numfiles; i++) {
@@ -2218,7 +2218,7 @@ int semanage_verify_modules(semanage_handle_t * sh,
 		return 0;
 	}
 	for (i = 0; i < num_modules; i++) {
-		char *module = module_filenames[i];
+		const char *module = module_filenames[i];
 		external_prog_t *e;
 		for (e = conf->mod_prog; e != NULL; e = e->next) {
 			if (semanage_exec_prog(sh, e, module, "$<") != 0) {
@@ -2331,8 +2331,8 @@ static void semanage_fc_bucket_list_destroy(semanage_file_context_bucket_t * x)
  * now.  A proper comparison would determine which (if either)
  * regular expression is a subset of the other.
  */
-static int semanage_fc_compare(semanage_file_context_node_t * a,
-			       semanage_file_context_node_t * b)
+static int semanage_fc_compare(const semanage_file_context_node_t * a,
+			       const semanage_file_context_node_t * b)
 {
 	int a_has_meta = (a->meta >= 0);
 	int b_has_meta = (b->meta >= 0);
diff --git a/libsemanage/src/seusers_file.c b/libsemanage/src/seusers_file.c
index ed3bcb31..9e463e35 100644
--- a/libsemanage/src/seusers_file.c
+++ b/libsemanage/src/seusers_file.c
@@ -20,7 +20,7 @@ typedef struct dbase_file dbase_t;
 #include "handle.h"
 
 static int seuser_print(semanage_handle_t * handle,
-			semanage_seuser_t * seuser, FILE * str)
+			const semanage_seuser_t * seuser, FILE * str)
 {
 
 	const char *name = semanage_seuser_get_name(seuser);
diff --git a/libsemanage/src/users_base_file.c b/libsemanage/src/users_base_file.c
index bbce4eed..b9998b37 100644
--- a/libsemanage/src/users_base_file.c
+++ b/libsemanage/src/users_base_file.c
@@ -21,7 +21,7 @@ typedef struct dbase_file dbase_t;
 #include "debug.h"
 
 static int user_base_print(semanage_handle_t * handle,
-			   semanage_user_base_t * user, FILE * str)
+			   const semanage_user_base_t * user, FILE * str)
 {
 
 	const char **roles = NULL;
@@ -68,7 +68,7 @@ static int user_base_parse(semanage_handle_t * handle,
 
 	int islist;
 	char *str = NULL;
-	char *start;
+	const char *start;
 	char *name_str = NULL;
 
 	if (parse_skip_space(handle, info) < 0)
diff --git a/libsemanage/src/users_extra_file.c b/libsemanage/src/users_extra_file.c
index 8f2f7139..d7b2df05 100644
--- a/libsemanage/src/users_extra_file.c
+++ b/libsemanage/src/users_extra_file.c
@@ -21,7 +21,7 @@ typedef struct dbase_file dbase_t;
 #include "handle.h"
 
 static int user_extra_print(semanage_handle_t * handle,
-			    semanage_user_extra_t * user_extra, FILE * str)
+			    const semanage_user_extra_t * user_extra, FILE * str)
 {
 
 	const char *name = semanage_user_extra_get_name(user_extra);
diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index 4beccb5b..ec578340 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -73,7 +73,7 @@ int semanage_is_prefix(const char *str, const char *prefix)
 char *semanage_split_on_space(const char *str)
 {
 	/* as per the man page, these are the isspace() chars */
-	const char *seps = "\f\n\r\t\v ";
+	const char *const seps = "\f\n\r\t\v ";
 	size_t off = 0;
 
 	if (!str)
@@ -88,7 +88,7 @@ char *semanage_split_on_space(const char *str)
 
 char *semanage_split(const char *str, const char *delim)
 {
-	char *retval;
+	const char *retval;
 
 	if (!str)
 		return NULL;
-- 
2.45.2

