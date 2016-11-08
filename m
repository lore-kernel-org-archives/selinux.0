From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: nicolas.iooss@m4x.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol: sepol_{bool|iface|user}_key_create: copy name
Date: Tue,  8 Nov 2016 10:53:12 -0500
Message-Id: <1478620392-16248-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The sepol_{bool|iface|user}_key_create() functions were not
copying the name.  This produces a use-after-free in the
swig-generated code for python3 bindings.  Copy the name
in these functions, and free it upon sepol_{bool|iface|user}_key_free().

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/boolean_record.c | 10 ++++++++--
 libsepol/src/iface_record.c   | 10 ++++++++--
 libsepol/src/user_record.c    | 10 ++++++++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/boolean_record.c b/libsepol/src/boolean_record.c
index 8b64413..ebef7f1 100644
--- a/libsepol/src/boolean_record.c
+++ b/libsepol/src/boolean_record.c
@@ -15,7 +15,7 @@ struct sepol_bool {
 
 struct sepol_bool_key {
 	/* This boolean's name */
-	const char *name;
+	char *name;
 };
 
 int sepol_bool_key_create(sepol_handle_t * handle,
@@ -30,7 +30,12 @@ int sepol_bool_key_create(sepol_handle_t * handle,
 		return STATUS_ERR;
 	}
 
-	tmp_key->name = name;
+	tmp_key->name = strdup(name);
+	if (!tmp_key->name) {
+		ERR(handle, "out of memory, " "could not create boolean key");
+		free(tmp_key);
+		return STATUS_ERR;
+	}
 
 	*key_ptr = tmp_key;
 	return STATUS_SUCCESS;
@@ -62,6 +67,7 @@ int sepol_bool_key_extract(sepol_handle_t * handle,
 
 void sepol_bool_key_free(sepol_bool_key_t * key)
 {
+	free(key->name);
 	free(key);
 }
 
diff --git a/libsepol/src/iface_record.c b/libsepol/src/iface_record.c
index 09adeb7..c8b977c 100644
--- a/libsepol/src/iface_record.c
+++ b/libsepol/src/iface_record.c
@@ -20,7 +20,7 @@ struct sepol_iface {
 struct sepol_iface_key {
 
 	/* Interface name */
-	const char *name;
+	char *name;
 };
 
 /* Key */
@@ -36,7 +36,12 @@ int sepol_iface_key_create(sepol_handle_t * handle,
 		return STATUS_ERR;
 	}
 
-	tmp_key->name = name;
+	tmp_key->name = strdup(name);
+	if (!tmp_key->name) {
+		ERR(handle, "out of memory, could not create interface key");
+		free(tmp_key);
+		return STATUS_ERR;
+	}
 
 	*key_ptr = tmp_key;
 	return STATUS_SUCCESS;
@@ -68,6 +73,7 @@ int sepol_iface_key_extract(sepol_handle_t * handle,
 
 void sepol_iface_key_free(sepol_iface_key_t * key)
 {
+	free(key->name);
 	free(key);
 }
 
diff --git a/libsepol/src/user_record.c b/libsepol/src/user_record.c
index c59c54b..e7e2fc2 100644
--- a/libsepol/src/user_record.c
+++ b/libsepol/src/user_record.c
@@ -24,7 +24,7 @@ struct sepol_user {
 
 struct sepol_user_key {
 	/* This user's name */
-	const char *name;
+	char *name;
 };
 
 int sepol_user_key_create(sepol_handle_t * handle,
@@ -40,7 +40,12 @@ int sepol_user_key_create(sepol_handle_t * handle,
 		return STATUS_ERR;
 	}
 
-	tmp_key->name = name;
+	tmp_key->name = strdup(name);
+	if (!tmp_key->name) {
+		ERR(handle, "out of memory, could not create selinux user key");
+		free(tmp_key);
+		return STATUS_ERR;
+	}
 
 	*key_ptr = tmp_key;
 	return STATUS_SUCCESS;
@@ -71,6 +76,7 @@ int sepol_user_key_extract(sepol_handle_t * handle,
 
 void sepol_user_key_free(sepol_user_key_t * key)
 {
+	free(key->name);
 	free(key);
 }
 
-- 
2.7.4
