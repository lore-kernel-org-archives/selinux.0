Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7PE5dga022333
 for <selinux@tycho.nsa.gov>; Tue, 25 Aug 2015 10:05:40 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id EA2F48E3E4
 for <selinux@tycho.nsa.gov>; Tue, 25 Aug 2015 14:05:37 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: create new keys with copy of 'name' variable
Date: Tue, 25 Aug 2015 16:05:29 +0200
Message-Id: <1440511529-30944-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

sepol_*_key_create functions, which create keys based only on name, copy only
a pointer to a new key. This pointer doesn't need to be valid during the new key
lifetime therefore it's necessary to create a copy of it.

E.g. Python 3 SWIG bindings temporarily allocate memory needed for
PyUnicodeObject->char * conversion. This memory is deallocated shortly
after underlying C function returns.

Patch-by: Michal Srb <msrb@redhat.com>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsepol/src/boolean_record.c | 7 +++++--
 libsepol/src/iface_record.c   | 7 +++++--
 libsepol/src/user_record.c    | 7 +++++--
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/boolean_record.c b/libsepol/src/boolean_record.c
index 8b64413..0d139ac 100644
--- a/libsepol/src/boolean_record.c
+++ b/libsepol/src/boolean_record.c
@@ -25,12 +25,14 @@ int sepol_bool_key_create(sepol_handle_t * handle,
 	sepol_bool_key_t *tmp_key =
 	    (sepol_bool_key_t *) malloc(sizeof(struct sepol_bool_key));
 
-	if (!tmp_key) {
+	char *tmp_name = strdup(name);
+
+	if (!tmp_key || !tmp_name) {
 		ERR(handle, "out of memory, " "could not create boolean key");
 		return STATUS_ERR;
 	}
 
-	tmp_key->name = name;
+	tmp_key->name = tmp_name;
 
 	*key_ptr = tmp_key;
 	return STATUS_SUCCESS;
@@ -62,6 +64,7 @@ int sepol_bool_key_extract(sepol_handle_t * handle,
 
 void sepol_bool_key_free(sepol_bool_key_t * key)
 {
+	free(key->name);
 	free(key);
 }
 
diff --git a/libsepol/src/iface_record.c b/libsepol/src/iface_record.c
index 09adeb7..4315238 100644
--- a/libsepol/src/iface_record.c
+++ b/libsepol/src/iface_record.c
@@ -31,12 +31,14 @@ int sepol_iface_key_create(sepol_handle_t * handle,
 	sepol_iface_key_t *tmp_key =
 	    (sepol_iface_key_t *) malloc(sizeof(sepol_iface_key_t));
 
-	if (!tmp_key) {
+	char *tmp_name = strdup(name);
+
+	if (!tmp_key || !tmp_name) {
 		ERR(handle, "out of memory, could not create interface key");
 		return STATUS_ERR;
 	}
 
-	tmp_key->name = name;
+	tmp_key->name = tmp_name;
 
 	*key_ptr = tmp_key;
 	return STATUS_SUCCESS;
@@ -68,6 +70,7 @@ int sepol_iface_key_extract(sepol_handle_t * handle,
 
 void sepol_iface_key_free(sepol_iface_key_t * key)
 {
+	free(key->name);
 	free(key);
 }
 
diff --git a/libsepol/src/user_record.c b/libsepol/src/user_record.c
index c59c54b..dfc66e5 100644
--- a/libsepol/src/user_record.c
+++ b/libsepol/src/user_record.c
@@ -34,13 +34,15 @@ int sepol_user_key_create(sepol_handle_t * handle,
 	sepol_user_key_t *tmp_key =
 	    (sepol_user_key_t *) malloc(sizeof(sepol_user_key_t));
 
-	if (!tmp_key) {
+	char *tmp_name = strdup(name);
+
+	if (!tmp_key || !tmp_name) {
 		ERR(handle, "out of memory, "
 		    "could not create selinux user key");
 		return STATUS_ERR;
 	}
 
-	tmp_key->name = name;
+	tmp_key->name = tmp_name;
 
 	*key_ptr = tmp_key;
 	return STATUS_SUCCESS;
@@ -71,6 +73,7 @@ int sepol_user_key_extract(sepol_handle_t * handle,
 
 void sepol_user_key_free(sepol_user_key_t * key)
 {
+	free(key->name);
 	free(key);
 }
 
-- 
2.5.0
