Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p813TrSk031915
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 23:30:04 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p813U206012576
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 03:30:03 GMT
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p813U2ag007229
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 20:30:02 -0700 (PDT)
From: Harry Ciao <qingtao.cao@windriver.com>
To: <selinux@tycho.nsa.gov>
Subject: [v2 PATCH 7/8] Create a new preserve_tunables flag in sepol_handle_t.
Date: Thu, 1 Sep 2011 11:29:46 +0800
Message-ID: <1314847787-4055-8-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
References: <1314847787-4055-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

By default only the effective branch of a tunable conditional would be
expanded and written to raw policy, while all needless unused branches
would be discarded.

Add a new option '-P' or "--preserve_tunables" to the semodule program.
By default it is 0, if set to 1 then the above preserve_tunables flag
in the sepol_handle_t would be set to 1 accordingly.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsemanage/include/semanage/handle.h |    6 ++++++
 libsemanage/src/direct_api.c          |   29 ++++++++++++++++++++++++++++-
 libsemanage/src/handle.c              |   13 +++++++++++++
 libsemanage/src/libsemanage.map       |    1 +
 libsemanage/src/semanage_store.c      |    1 +
 libsemanage/src/semanage_store.h      |    1 +
 libsepol/include/sepol/handle.h       |    7 +++++++
 libsepol/src/handle.c                 |   15 +++++++++++++++
 libsepol/src/handle.h                 |    2 +-
 libsepol/src/libsepol.map             |    1 +
 policycoreutils/semodule/semodule.c   |   10 +++++++++-
 11 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index e303713..c746930 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -129,6 +129,12 @@ int semanage_mls_enabled(semanage_handle_t *sh);
 /* Change to alternate selinux root path */
 int semanage_set_root(const char *path);
 
+/* Get whether or not needless unused branch of tunables would be preserved */
+int semanage_get_preserve_tunables(semanage_handle_t * handle);
+
+/* Set whether or not to preserve the needless unused branch of tunables */
+void semanage_set_preserve_tunables(semanage_handle_t * handle, int preserve_tunables);
+
 /* META NOTES
  *
  * For all functions a non-negative number indicates success. For some
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index aac1974..4eba5dc 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -695,7 +695,8 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	/* Declare some variables */
 	int modified = 0, fcontexts_modified, ports_modified,
-	    seusers_modified, users_extra_modified, dontaudit_modified;
+	    seusers_modified, users_extra_modified, dontaudit_modified,
+	    preserve_tunables_modified;
 	dbase_config_t *users = semanage_user_dbase_local(sh);
 	dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
 	dbase_config_t *pusers_base = semanage_user_base_dbase_policy(sh);
@@ -737,6 +738,31 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		}
 	}
 
+	/* Create or remove the preserve_tunables flag file. */
+	path = semanage_path(SEMANAGE_TMP, SEMANAGE_PRESERVE_TUNABLES);
+	if (access(path, F_OK) == 0)
+		preserve_tunables_modified = !(sepol_get_preserve_tunables(sh->sepolh) == 1);
+	else
+		preserve_tunables_modified = (sepol_get_preserve_tunables(sh->sepolh) == 1);
+	if (sepol_get_preserve_tunables(sh->sepolh) == 1) {
+		FILE *touch;
+		touch = fopen(path, "w");
+		if (touch != NULL) {
+			if (fclose(touch) != 0) {
+				ERR(sh, "Error attempting to create preserve_tunable flag.");
+				goto cleanup;
+			}
+		} else {
+			ERR(sh, "Error attempting to create preserve_tunable flag.");
+			goto cleanup;
+		}
+	} else {
+		if (remove(path) == -1 && errno != ENOENT) {
+			ERR(sh, "Error removing the preserve_tunables flag.");
+			goto cleanup;
+		}
+	}
+
 	/* Before we do anything else, flush the join to its component parts.
 	 * This *does not* flush to disk automatically */
 	if (users->dtable->is_modified(users->dbase)) {
@@ -759,6 +785,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	modified |= ifaces->dtable->is_modified(ifaces->dbase);
 	modified |= nodes->dtable->is_modified(nodes->dbase);
 	modified |= dontaudit_modified;
+	modified |= preserve_tunables_modified;
 
 	/* If there were policy changes, or explicitly requested, rebuild the policy */
 	if (sh->do_rebuild || modified) {
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 647f0ee..7adc1cc 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -261,6 +261,19 @@ void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudi
 	return;
 }
 
+int semanage_get_preserve_tunables(semanage_handle_t * sh)
+{
+	assert(sh != NULL);
+	return sepol_get_preserve_tunables(sh->sepolh);
+}
+
+void semanage_set_preserve_tunables(semanage_handle_t * sh,
+				    int preserve_tunables)
+{
+	assert(sh != NULL);
+	sepol_set_preserve_tunables(sh->sepolh, preserve_tunables);
+}
+
 void semanage_set_check_contexts(semanage_handle_t * sh, int do_check_contexts)
 {
 
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 3222e3d..2827abe 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -22,5 +22,6 @@ LIBSEMANAGE_1.0 {
 	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
 	  semanage_mls_enabled;
 	  semanage_set_check_contexts;
+	  semanage_get_preserve_tunables; semanage_set_preserve_tunables;
   local: *;
 };
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 8d6ff1c..e5f8234 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -117,6 +117,7 @@ static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"/netfilter_contexts",
 	"/file_contexts.homedirs",
 	"/disable_dontaudit",
+	"/preserve_tunables",
 };
 
 /* A node used in a linked list of file contexts; used for sorting.
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index a0b2dd8..eaae05e 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -59,6 +59,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_NC,
 	SEMANAGE_FC_HOMEDIRS,
 	SEMANAGE_DISABLE_DONTAUDIT,
+	SEMANAGE_PRESERVE_TUNABLES,
 	SEMANAGE_STORE_NUM_PATHS
 };
 
diff --git a/libsepol/include/sepol/handle.h b/libsepol/include/sepol/handle.h
index 19be326..115bda1 100644
--- a/libsepol/include/sepol/handle.h
+++ b/libsepol/include/sepol/handle.h
@@ -24,4 +24,11 @@ void sepol_set_expand_consume_base(sepol_handle_t * sh, int consume_base);
 /* Destroy a sepol handle. */
 void sepol_handle_destroy(sepol_handle_t *);
 
+/* Get whether or not needless unused branch of tunables would be preserved */
+int sepol_get_preserve_tunables(sepol_handle_t * sh);
+
+/* Set whether or not to preserve the needless unused branch of tunables,
+ * 0 is default and discard such branch, 1 preserves them */
+void sepol_set_preserve_tunables(sepol_handle_t * sh, int preserve_tunables);
+
 #endif
diff --git a/libsepol/src/handle.c b/libsepol/src/handle.c
index 191ac57..2e9a4ad 100644
--- a/libsepol/src/handle.c
+++ b/libsepol/src/handle.c
@@ -18,9 +18,24 @@ sepol_handle_t *sepol_handle_create(void)
 	sh->disable_dontaudit = 0;
 	sh->expand_consume_base = 0;
 
+	/* by default needless unused branch of tunables would be discarded  */
+	sh->preserve_tunables = 0;
+
 	return sh;
 }
 
+int sepol_get_preserve_tunables(sepol_handle_t *sh)
+{
+	assert(sh != NULL);
+	return sh->preserve_tunables;
+}
+
+void sepol_set_preserve_tunables(sepol_handle_t * sh, int preserve_tunables)
+{
+	assert(sh !=NULL);
+	sh->preserve_tunables = preserve_tunables;
+}
+
 int sepol_get_disable_dontaudit(sepol_handle_t *sh)
 {
 	assert(sh !=NULL);
diff --git a/libsepol/src/handle.h b/libsepol/src/handle.h
index 254fbd8..7728d04 100644
--- a/libsepol/src/handle.h
+++ b/libsepol/src/handle.h
@@ -17,7 +17,7 @@ struct sepol_handle {
 
 	int disable_dontaudit;
 	int expand_consume_base;
-
+	int preserve_tunables;
 };
 
 #endif
diff --git a/libsepol/src/libsepol.map b/libsepol/src/libsepol.map
index 719e5b7..81e0d48 100644
--- a/libsepol/src/libsepol.map
+++ b/libsepol/src/libsepol.map
@@ -15,5 +15,6 @@
 	sepol_get_disable_dontaudit;
 	sepol_set_disable_dontaudit;
 	sepol_set_expand_consume_base;
+	sepol_get_preserve_tunables; sepol_set_preserve_tunables;
   local: *;
 };
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 81d6a3c..5d662e7 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -45,6 +45,7 @@ static int no_reload;
 static int create_store;
 static int build;
 static int disable_dontaudit;
+static int preserve_tunables;
 
 static semanage_handle_t *sh = NULL;
 static char *store;
@@ -117,6 +118,7 @@ static void usage(char *progname)
 	printf("  -h,--help        print this message and quit\n");
 	printf("  -v,--verbose     be verbose\n");
 	printf("  -D,--disable_dontaudit	Remove dontaudits from policy\n");
+	printf("  -P,--preserve_tunables	Preserve tunables in policy\n");
 }
 
 /* Sets the global mode variable to new_mode, but only if no other
@@ -162,6 +164,7 @@ static void parse_command_line(int argc, char **argv)
 		{"noreload", 0, NULL, 'n'},
 		{"build", 0, NULL, 'B'},
 		{"disable_dontaudit", 0, NULL, 'D'},
+		{"preserve_tunables", 0, NULL, 'P'},
 		{"path", required_argument, NULL, 'p'},
 		{NULL, 0, NULL, 0}
 	};
@@ -171,7 +174,7 @@ static void parse_command_line(int argc, char **argv)
 	no_reload = 0;
 	create_store = 0;
 	while ((i =
-		getopt_long(argc, argv, "p:s:b:hi:lvqe:d:r:u:RnBD", opts,
+		getopt_long(argc, argv, "p:s:b:hi:lvqe:d:r:u:RnBDP", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -220,6 +223,9 @@ static void parse_command_line(int argc, char **argv)
 		case 'D':
 			disable_dontaudit = 1;
 			break;
+		case 'P':
+			preserve_tunables = 1;
+			break;
 		case '?':
 		default:{
 				usage(argv[0]);
@@ -466,6 +472,8 @@ int main(int argc, char *argv[])
 			semanage_set_disable_dontaudit(sh, 1);
 		else if (build)
 			semanage_set_disable_dontaudit(sh, 0);
+		if (preserve_tunables)
+			semanage_set_preserve_tunables(sh, 1);
 
 		result = semanage_commit(sh);
 	}
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
