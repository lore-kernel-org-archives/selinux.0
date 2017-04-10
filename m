From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: cefrodrigues@gmail.com, jwcart2@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/2] libsepol: do not seg fault on sepol_*_key_free(NULL)
Date: Mon, 10 Apr 2017 11:11:47 -0400
Message-Id: <20170410151148.11958-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

sepol_*_key_free(NULL) should just be a no-op just like
free(NULL).  Fix several instances that did not handle this
correctly and would seg fault if called with NULL.

Test: setsebool -P zebra_write_config=1 while non-root

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/boolean_record.c | 2 ++
 libsepol/src/iface_record.c   | 2 ++
 libsepol/src/user_record.c    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/libsepol/src/boolean_record.c b/libsepol/src/boolean_record.c
index ebef7f1..a194704 100644
--- a/libsepol/src/boolean_record.c
+++ b/libsepol/src/boolean_record.c
@@ -67,6 +67,8 @@ int sepol_bool_key_extract(sepol_handle_t * handle,
 
 void sepol_bool_key_free(sepol_bool_key_t * key)
 {
+	if (!key)
+		return;
 	free(key->name);
 	free(key);
 }
diff --git a/libsepol/src/iface_record.c b/libsepol/src/iface_record.c
index c8b977c..6d56835 100644
--- a/libsepol/src/iface_record.c
+++ b/libsepol/src/iface_record.c
@@ -73,6 +73,8 @@ int sepol_iface_key_extract(sepol_handle_t * handle,
 
 void sepol_iface_key_free(sepol_iface_key_t * key)
 {
+	if (!key)
+		return;
 	free(key->name);
 	free(key);
 }
diff --git a/libsepol/src/user_record.c b/libsepol/src/user_record.c
index ed5b048..fa95f2d 100644
--- a/libsepol/src/user_record.c
+++ b/libsepol/src/user_record.c
@@ -76,6 +76,8 @@ int sepol_user_key_extract(sepol_handle_t * handle,
 
 void sepol_user_key_free(sepol_user_key_t * key)
 {
+	if (!key)
+		return;
 	free(key->name);
 	free(key);
 }
-- 
2.9.3
