Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBTIjFoI013539
 for <selinux@tycho.nsa.gov>; Thu, 29 Dec 2016 13:45:15 -0500
Message-ID: <1483037107.25804.5.camel@trentalancia.net>
Subject: [PATCH v2] libsemanage: special handling of the identity reserved
 to system objects
From: Guido Trentalancia <guido@trentalancia.net>
To: selinux <selinux@tycho.nsa.gov>
Date: Thu, 29 Dec 2016 19:45:07 +0100
In-Reply-To: <1482966318.30976.5.camel@trentalancia.net>
References: <1482966318.30976.5.camel@trentalancia.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The following patch makes sure that the SELinux identity
reserved for system processes and objects is skipped
when adding users.

A warning is produced when a Unix identity is found to be
equal to the SELinux user identity for system processes
and objects.

This patch also avoids creating an extra record for a user
if there is no prefix.

Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
---
 include/semanage/user_record.h |    2 ++
 src/genhomedircon.c            |   23 +++++++++++++++++++----
 src/user_extra_record.c        |   39 ++++++++++++++++++++++++++++++++-------
 src/user_record.c              |   40 +++++++++++++++++++++++++---------------
 4 files changed, 78 insertions(+), 26 deletions(-)

diff -pru a/include/semanage/user_record.h b/include/semanage/user_record.h
--- a/include/semanage/user_record.h	2016-10-14 17:31:26.000000000 +0200
+++ b/include/semanage/user_record.h	2016-12-28 23:22:50.848589870 +0100
@@ -6,6 +6,8 @@
 #include <stddef.h>
 #include <semanage/handle.h>
 
+#define SYS_OBJECTS_USERID	"system_u"
+
 struct semanage_user;
 typedef struct semanage_user semanage_user_t;
 
diff -pru a/src/genhomedircon.c b/src/genhomedircon.c
--- a/src/genhomedircon.c	2016-10-14 17:31:26.000000000 +0200
+++ b/src/genhomedircon.c	2016-12-29 17:50:10.781727455 +0100
@@ -181,6 +181,9 @@ static int ignore(const char *homedir) {
 static int prefix_is_homedir_role(const semanage_user_t *user,
 				  const char *prefix)
 {
+	if (!prefix)
+		return 0;
+
 	return strcmp(OBJECT_R, prefix) == 0 ||
 		semanage_user_has_role(user, prefix);
 }
@@ -998,14 +1001,26 @@ static int add_user(genhomedircon_settin
 		homedir_role = prefix;
 	}
 
+	/* There should be no Unix identity corresponding
+	 * to SELinux user reserved for system processes
+	 * and objects */
 	retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-	if (retval != 0 || pwent == NULL) {
-		if (retval != 0 && retval != ENOENT) {
+	if (strcmp(name, SYS_OBJECTS_USERID)) {
+		if (retval != 0 || pwent == NULL) {
+			if (retval != 0 && retval != ENOENT) {
+				goto cleanup;
+			}
+
+			WARN(s->h_semanage,
+			     "user %s not in password file", name);
+			retval = STATUS_SUCCESS;
 			goto cleanup;
 		}
+	} else {
+		if (retval)
+			WARN(s->h_semanage,
+			     "There should be no Unix identity \"%s\" !", SYS_OBJECTS_USERID);
 
-		WARN(s->h_semanage,
-		     "user %s not in password file", name);
 		retval = STATUS_SUCCESS;
 		goto cleanup;
 	}
diff -pru a/src/user_extra_record.c b/src/user_extra_record.c
--- a/src/user_extra_record.c	2016-10-14 17:31:26.000000000 +0200
+++ b/src/user_extra_record.c	2016-12-29 17:17:26.168737139 +0100
@@ -37,8 +37,9 @@ static int semanage_user_extra_key_extra
 					   semanage_user_key_t ** key_ptr)
 {
 
-	if (semanage_user_key_create(handle, user_extra->name, key_ptr) < 0)
-		goto err;
+	if (user_extra)
+		if (semanage_user_key_create(handle, user_extra->name, key_ptr) < 0)
+			goto err;
 
 	return STATUS_SUCCESS;
 
@@ -54,7 +55,10 @@ static int semanage_user_extra_compare(c
 	const char *name;
 	semanage_user_key_unpack(key, &name);
 
-	return strcmp(user_extra->name, name);
+	if (user_extra)
+		return strcmp(user_extra->name, name);
+	else
+		return 1;
 }
 
 static int semanage_user_extra_compare2(const semanage_user_extra_t *
@@ -63,7 +67,10 @@ static int semanage_user_extra_compare2(
 					user_extra2)
 {
 
-	return strcmp(user_extra->name, user_extra2->name);
+	if (user_extra && user_extra2)
+		return strcmp(user_extra->name, user_extra2->name);
+	else
+		return 1;
 }
 
 static int semanage_user_extra_compare2_qsort(const semanage_user_extra_t **
@@ -72,7 +79,10 @@ static int semanage_user_extra_compare2_
 					      user_extra2)
 {
 
-	return strcmp((*user_extra)->name, (*user_extra2)->name);
+	if (*user_extra && *user_extra2)
+		return strcmp((*user_extra)->name, (*user_extra2)->name);
+	else
+		return 1;
 }
 
 /* Name */
@@ -80,7 +90,10 @@ hidden const char *semanage_user_extra_g
 						user_extra)
 {
 
-	return user_extra->name;
+	if (user_extra)
+		return user_extra->name;
+	else
+		return NULL;
 }
 
 hidden int semanage_user_extra_set_name(semanage_handle_t * handle,
@@ -88,6 +101,9 @@ hidden int semanage_user_extra_set_name(
 					const char *name)
 {
 
+	if (!user_extra)
+		return STATUS_SUCCESS;
+
 	char *tmp_name = strdup(name);
 	if (!tmp_name) {
 		ERR(handle, "out of memory, could not set name %s "
@@ -104,7 +120,10 @@ hidden const char *semanage_user_extra_g
 						  user_extra)
 {
 
-	return user_extra->prefix;
+	if (user_extra)
+		return user_extra->prefix;
+	else
+		return NULL;
 }
 
 hidden int semanage_user_extra_set_prefix(semanage_handle_t * handle,
@@ -112,6 +131,9 @@ hidden int semanage_user_extra_set_prefi
 					  const char *prefix)
 {
 
+	if (!user_extra)
+		return STATUS_SUCCESS;
+
 	char *tmp_prefix = strdup(prefix);
 	if (!tmp_prefix) {
 		ERR(handle, "out of memory, could not set prefix %s "
@@ -162,6 +184,9 @@ hidden int semanage_user_extra_clone(sem
 				     semanage_user_extra_t ** user_extra_ptr)
 {
 
+	if (!user_extra)
+		return STATUS_SUCCESS;
+
 	semanage_user_extra_t *new_user_extra = NULL;
 
 	if (semanage_user_extra_create(handle, &new_user_extra) < 0)
diff -pru a/src/user_record.c b/src/user_record.c
--- a/src/user_record.c	2016-10-14 17:31:26.000000000 +0200
+++ b/src/user_record.c	2016-12-29 19:23:11.783720792 +0100
@@ -313,6 +313,7 @@ hidden int semanage_user_join(semanage_h
 {
 
 	const char *name;
+	const char *prefix = NULL;
 	semanage_user_t *tmp_user = calloc(1, sizeof(semanage_user_t));
 	if (!tmp_user)
 		goto omem;
@@ -324,6 +325,9 @@ hidden int semanage_user_join(semanage_h
 	else
 		name = semanage_user_base_get_name(record1);
 
+	if (record2)
+		prefix = semanage_user_extra_get_prefix(record2);
+
 	/* Join base record if it exists, create a blank one otherwise */
 	if (record1) {
 		if (semanage_user_base_clone(handle, record1, &tmp_user->base) <
@@ -337,21 +341,27 @@ hidden int semanage_user_join(semanage_h
 			goto err;
 	}
 
-	/* Join extra record if it exists, create a blank one otherwise */
-	if (record2) {
-		if (semanage_user_extra_clone(handle, record2, &tmp_user->extra)
-		    < 0)
-			goto err;
-	} else {
-		if (semanage_user_extra_create(handle, &tmp_user->extra) < 0)
-			goto err;
-		if (semanage_user_extra_set_name(handle, tmp_user->extra, name)
-		    < 0)
-			goto err;
-		if (semanage_user_extra_set_prefix
-		    (handle, tmp_user->extra, "user") < 0)
-			goto err;
-	}
+	/* SELinux identities without a prefix shall not have an extra record */
+	if (prefix) { 
+		/* Join extra record if it exists, create a blank one otherwise */
+		if (record2) {
+			if (&tmp_user->extra)
+				if (semanage_user_extra_clone(handle, record2, &tmp_user->extra)
+				    < 0)
+					goto err;
+		} else {
+			if (semanage_user_extra_create(handle, &tmp_user->extra) < 0)
+				goto err;
+			if (semanage_user_extra_set_name(handle, tmp_user->extra, name)
+			    < 0)
+				goto err;
+
+			if (semanage_user_extra_set_prefix
+			    (handle, tmp_user->extra, "user") < 0)
+				goto err;
+		}
+	} else
+		tmp_user->extra = NULL;
 
 	if (semanage_user_set_name(handle, tmp_user, name) < 0)
 		goto err;
