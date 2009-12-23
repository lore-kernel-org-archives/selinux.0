From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 05/13] libsemanage: update unit tests for move to /var/lib/selinux
Date: Wed, 23 Dec 2009 18:25:52 -0500
Message-Id: <1261610760-4724-6-git-send-email-ccase@tresys.com>
In-Reply-To: <1261610760-4724-5-git-send-email-ccase@tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
 <1261610760-4724-2-git-send-email-ccase@tresys.com>
 <1261610760-4724-3-git-send-email-ccase@tresys.com>
 <1261610760-4724-4-git-send-email-ccase@tresys.com>
 <1261610760-4724-5-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This updates the unit tests to accommodate the change in layout (no top
level 'modules' directory).
---
 libsemanage/tests/test_semanage_store.c |   34 +++++++++++++++---------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/libsemanage/tests/test_semanage_store.c b/libsemanage/tests/test_semanage_store.c
index e6814e8..2fa94b4 100644
--- a/libsemanage/tests/test_semanage_store.c
+++ b/libsemanage/tests/test_semanage_store.c
@@ -44,12 +44,12 @@
 #include <CUnit/Basic.h>
 
 semanage_handle_t *sh = NULL;
-const char *polpath = "./test-policy";
-const char *lockpath = "./test-policy/modules";
-const char *readlockpath = "./test-policy/modules/semanage.read.LOCK";
-const char *translockpath = "./test-policy/modules/semanage.trans.LOCK";
-const char *actpath = "./test-policy/modules/active";
-const char *modpath = "./test-policy/modules/active/modules";
+const char *rootpath = "./test-policy";
+const char *polpath = "./test-policy/store/";
+const char *readlockpath = "./test-policy/store/semanage.read.LOCK";
+const char *translockpath = "./test-policy/store/semanage.trans.LOCK";
+const char *actpath = "./test-policy/store/active";
+const char *modpath = "./test-policy/store/active/modules";
 
 /* The suite initialization function.
  * Returns zero on success, non-zero otherwise.
@@ -59,11 +59,11 @@ int semanage_store_test_init(void)
 	int err;
 
 	/* create directories */
-	err = mkdir(polpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	err = mkdir(rootpath, S_IRUSR | S_IWUSR | S_IXUSR);
 	if (err != 0)
 		return -1;
 
-	err = mkdir(lockpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	err = mkdir(polpath, S_IRUSR | S_IWUSR | S_IXUSR);
 	if (err != 0)
 		return -1;
 
@@ -83,8 +83,12 @@ int semanage_store_test_init(void)
 	/* hide error messages */
 	sh->msg_callback = test_msg_handler;
 
+	/* use our own policy store */
+	free(sh->conf->store_path);
+	sh->conf->store_path = strdup("store");
+
 	/* initialize paths */
-	err = semanage_check_init(polpath);
+	err = semanage_check_init(sh, rootpath);
 	if (err != 0)
 		return -1;
 
@@ -107,11 +111,11 @@ int semanage_store_test_cleanup(void)
 	if (err != 0)
 		return -1;
 
-	err = rmdir(lockpath);
+	err = rmdir(polpath);
 	if (err != 0)
 		return -1;
 
-	err = rmdir(polpath);
+	err = rmdir(rootpath);
 	if (err != 0)
 		return -1;
 
@@ -217,8 +221,6 @@ void test_semanage_store_access_check(void)
 	/* check with no lock file and 000 */
 	err = chmod(modpath, 0);
 	CU_ASSERT(err == 0);
-	err = chmod(lockpath, 0);
-	CU_ASSERT(err == 0);
 	err = chmod(polpath, 0);
 	CU_ASSERT(err == 0);
 
@@ -228,16 +230,14 @@ void test_semanage_store_access_check(void)
 	/* check with no lock file and 500 */
 	err = chmod(polpath, S_IRUSR | S_IXUSR);
 	CU_ASSERT(err == 0);
-	err = chmod(lockpath, S_IRUSR | S_IXUSR);
-	CU_ASSERT(err == 0);
 	err = chmod(modpath, S_IRUSR | S_IXUSR);
 	CU_ASSERT(err == 0);
 
 	err = semanage_store_access_check(sh);
 	CU_ASSERT(err == 0);
 
-	/* check with no lock file but write in lockpath */
-	err = chmod(lockpath, S_IRUSR | S_IWUSR | S_IXUSR);
+	/* check with no lock file but write in polpath */
+	err = chmod(polpath, S_IRUSR | S_IWUSR | S_IXUSR);
 	CU_ASSERT(err == 0);
 
 	err = semanage_store_access_check(sh);
-- 
1.6.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
