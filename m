Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o66MNM2e024366
	for <selinux@tycho.nsa.gov>; Tue, 6 Jul 2010 18:23:29 -0400
Received: from mail-px0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o66MPJYt021151
	for <selinux@tycho.nsa.gov>; Tue, 6 Jul 2010 22:25:20 GMT
Received: by pxi19 with SMTP id 19so1316102pxi.12
        for <selinux@tycho.nsa.gov>; Tue, 06 Jul 2010 15:23:27 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Cc: refpolicy@oss1.tresys.com, "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 1/3]libsemanage Fix  warning: parameter 'key' set but not used(and others)
Date: Tue,  6 Jul 2010 15:23:30 -0700
Message-Id: <1278455010-23244-4-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1278455010-23244-1-git-send-email-justinmattock@gmail.com>
References: <1278455010-23244-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

libsemanage produced no errors with the warnings, Im just noticing
big hunks of sections with warning messages:

database_llist.c: In function 'dbase_llist_add':
database_llist.c:150:28: warning: parameter 'key' set but not used
database_llist.c: In function 'dbase_llist_count':
database_llist.c:221:50: warning: parameter 'handle' set but not used
database_llist.c: In function 'dbase_llist_del':
database_llist.c:278:41: warning: parameter 'handle' set but not used
(and so on...)
so add the GCC attribute to quiet these warnings since most go to
NULL;

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 libsemanage/src/database_llist.c    |    7 ++++---
 libsemanage/src/database_policydb.c |   18 ++++++++++++------
 libsemanage/src/debug.c             |    2 +-
 libsemanage/src/direct_api.c        |    3 ++-
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/libsemanage/src/database_llist.c b/libsemanage/src/database_llist.c
index 1cb7454..5f0c147 100644
--- a/libsemanage/src/database_llist.c
+++ b/libsemanage/src/database_llist.c
@@ -147,7 +147,8 @@ int dbase_llist_exists(semanage_handle_t * handle,
 
 int dbase_llist_add(semanage_handle_t * handle,
 		    dbase_llist_t * dbase,
-		    const record_key_t * key, const record_t * data)
+		    const record_key_t * key __attribute__ ((unused)),
+			 const record_t * data)
 {
 
 	if (dbase_llist_cache_prepend(handle, dbase, data) < 0)
@@ -218,7 +219,7 @@ int dbase_llist_modify(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-hidden int dbase_llist_count(semanage_handle_t * handle,
+hidden int dbase_llist_count(semanage_handle_t * handle __attribute__ ((unused)),
 			     dbase_llist_t * dbase, unsigned int *response)
 {
 
@@ -275,7 +276,7 @@ int dbase_llist_iterate(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-int dbase_llist_del(semanage_handle_t * handle,
+int dbase_llist_del(semanage_handle_t * handle __attribute__ ((unused)),
 		    dbase_llist_t * dbase, const record_key_t * key)
 {
 
diff --git a/libsemanage/src/database_policydb.c b/libsemanage/src/database_policydb.c
index 839dcbe..94850b7 100644
--- a/libsemanage/src/database_policydb.c
+++ b/libsemanage/src/database_policydb.c
@@ -177,7 +177,8 @@ static int dbase_policydb_cache(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_flush(semanage_handle_t * handle,
+static int dbase_policydb_flush(semanage_handle_t * handle
+				__attribute__ ((unused)),
 				dbase_policydb_t * dbase)
 {
 
@@ -309,9 +310,12 @@ static int dbase_policydb_modify(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_del(semanage_handle_t * handle,
-			      dbase_policydb_t * dbase,
-			      const record_key_t * key)
+static int dbase_policydb_del(semanage_handle_t * handle
+				__attribute__ ((unused)),
+			      dbase_policydb_t * dbase
+				__attribute__ ((unused)),
+			      const record_key_t * key
+				__attribute__ ((unused)))
 {
 
 	/* Stub */
@@ -321,8 +325,10 @@ static int dbase_policydb_del(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-static int dbase_policydb_clear(semanage_handle_t * handle,
-				dbase_policydb_t * dbase)
+static int dbase_policydb_clear(semanage_handle_t * handle
+				__attribute__ ((unused)),
+				dbase_policydb_t * dbase
+				__attribute__ ((unused)))
 {
 
 	/* Stub */
diff --git a/libsemanage/src/debug.c b/libsemanage/src/debug.c
index 4b96c30..90d4b4e 100644
--- a/libsemanage/src/debug.c
+++ b/libsemanage/src/debug.c
@@ -51,7 +51,7 @@ hidden_def(semanage_msg_get_fname)
 #ifdef __GNUC__
     __attribute__ ((format(printf, 3, 4)))
 #endif
-void hidden semanage_msg_default_handler(void *varg,
+void hidden semanage_msg_default_handler(void *varg __attribute__ ((unused)),
 					 semanage_handle_t * handle,
 					 const char *fmt, ...)
 {
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 399d740..bceb6a7 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -243,7 +243,8 @@ int semanage_direct_connect(semanage_handle_t * sh)
 	return STATUS_ERR;
 }
 
-static void semanage_direct_destroy(semanage_handle_t * sh)
+static void semanage_direct_destroy(semanage_handle_t * sh
+					__attribute__ ((unused)))
 {
 	/* do nothing */
 	sh = NULL;
-- 
1.7.1.rc1.21.gf3bd6


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
