Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sN009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:22 -0400
Received: by mail-wi0-f169.google.com with SMTP id cc10so1606190wib.0
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:29 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.27
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:28 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 12/20] libsemanage: constify name and ext_lang parameters of
 semanage_module_install_hll
Date: Sun, 14 Sep 2014 23:41:43 +0200
Message-Id: <1410730911-14512-13-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This fixes a warning from "gcc -Wwrite-strings", when
semanage_module_install_hll is called with "pp" as last parameter.
---
 libsemanage/src/direct_api.c | 4 ++--
 libsemanage/src/modules.c    | 2 +-
 libsemanage/src/modules.h    | 2 +-
 libsemanage/src/policy.h     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 4d2047b90059..c2ac938d525d 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -64,7 +64,7 @@ static int semanage_direct_disconnect(semanage_handle_t * sh);
 static int semanage_direct_begintrans(semanage_handle_t * sh);
 static int semanage_direct_commit(semanage_handle_t * sh);
 static int semanage_direct_install(semanage_handle_t * sh, char *data,
-				   size_t data_len, char *module_name, char *lang_ext);
+				   size_t data_len, const char *module_name, const char *lang_ext);
 static int semanage_direct_install_file(semanage_handle_t * sh, const char *module_name);
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name);
 static int semanage_direct_list(semanage_handle_t * sh,
@@ -1289,7 +1289,7 @@ cleanup:
  * writing file. */
 static int semanage_direct_install(semanage_handle_t * sh,
 				   char *data, size_t data_len,
-				   char *module_name, char *lang_ext)
+				   const char *module_name, const char *lang_ext)
 {
 	int status = 0;
 	int ret = 0;
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index d0297fe78d41..d29c3469d5eb 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -105,7 +105,7 @@ cleanup:
 }
 
 int semanage_module_install_hll(semanage_handle_t * sh,
-			    char *module_data, size_t data_len, char *name, char *ext_lang)
+			    char *module_data, size_t data_len, const char *name, const char *ext_lang)
 {
 	if (sh->funcs->install == NULL) {
 		ERR(sh,
diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
index 68e36b67a0e2..8a5c01f47e94 100644
--- a/libsemanage/src/modules.h
+++ b/libsemanage/src/modules.h
@@ -29,7 +29,7 @@
 int semanage_module_install_pp(semanage_handle_t * sh,
 			    char *module_data, size_t data_len);
 int semanage_module_install_hll(semanage_handle_t * sh,
-			    char *module_data, size_t data_len, char *name, char *ext_lang);
+			    char *module_data, size_t data_len, const char *name, const char *ext_lang);
 int semanage_module_upgrade(semanage_handle_t * sh,
 			    char *module_data, size_t data_len);
 int semanage_module_upgrade_file(semanage_handle_t * sh,
diff --git a/libsemanage/src/policy.h b/libsemanage/src/policy.h
index 91787ba8399c..c5aec386f6cd 100644
--- a/libsemanage/src/policy.h
+++ b/libsemanage/src/policy.h
@@ -47,7 +47,7 @@ struct semanage_policy_table {
 	int (*commit) (struct semanage_handle *);
 
 	/* Install a policy module */
-	int (*install) (struct semanage_handle *, char *, size_t, char *, char *);
+	int (*install) (struct semanage_handle *, char *, size_t, const char *, const char *);
 
 	/* Install a policy module */
 	int (*install_file) (struct semanage_handle *, const char *);
-- 
2.1.0
