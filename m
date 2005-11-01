Message-ID: <4367044C.1000501@cornell.edu>
Date: Tue, 01 Nov 2005 00:59:40 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [ SEMANAGE ] Some seusers mapping validation
References: <4366EE1B.1060303@cornell.edu> <4366F160.2070005@cornell.edu>
In-Reply-To: <4366F160.2070005@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------050802010105080606070300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050802010105080606070300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>
> You can see why I want (2), and most of (3) skipped in the case of 
> seusers...need to add tracking of when the policy is modified.
Well... with the attached patch I need a policydb, regardless of whether 
modifications occured.. otoh if no modifications, then I don't have to 
call expand, which takes so long... can go through the policydb_cache 
function instead (not sure if that's any faster, however..)

Changes:
- add some basic validation for seusers - abort the commit if the sename 
is invalid (Selinux user does not exist). This will also prevent 
deletion of users without deleting/changing the corresponding mappings 
in the seusers file - it works out rather nicely.

We might also want to validate the MLS range, and the Unix name. I am 
not clear on how to validate the MLS range - what's happening with the 
old (local.users) MLS range? Is it deprecated? Are they supposed to 
match? How to handle this?





--------------050802010105080606070300
Content-Type: text/x-patch;
 name="libsemanage.seuser_validate.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.seuser_validate.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-10-31 21:52:14.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2005-11-01 00:37:31.000000000 -0500
@@ -2,6 +2,7 @@
 #include "handle.h"
 #include "database.h"
 #include "modules.h"
+#include "seusers.h"
 #include "debug.h"
 
 #define MODE_SET    1
@@ -125,6 +126,10 @@ int semanage_commit_components(
 		semanage_seuser_dbase(handle)
 	};
 
+	/* Validate seusers */
+	if (semanage_seuser_validate(handle) < 0)
+		goto err;
+
 	for (i = 0; i < CCOUNT; i++) {
 		/* Flush to disk */
 		if (components[i]->dtable->flush(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers.c new/libsemanage/src/seusers.c
--- old/libsemanage/src/seusers.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/seusers.c	2005-11-01 00:46:31.000000000 -0500
@@ -5,9 +5,12 @@ typedef semanage_seuser_t record_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
-#include <semanage/seusers.h>
+#include <semanage/user_record.h>
+#include <semanage/users_policy.h>
+#include "seusers.h"
 #include "handle.h"
 #include "database.h"
+#include "debug.h"
 
 int semanage_seuser_add(
 	semanage_handle_t* handle,
@@ -88,3 +91,59 @@ int semanage_seuser_list(
 	dbase_config_t* dconfig = semanage_seuser_dbase(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+
+struct validate_handler_arg {
+	semanage_handle_t* handle;
+};
+
+static int validate_handler(
+	semanage_seuser_t* seuser,
+	void* varg) {
+
+	struct validate_handler_arg* arg = 
+		(struct validate_handler_arg*) varg;
+
+	const char* name = semanage_seuser_get_name(seuser);
+	const char* sename = semanage_seuser_get_sename(seuser);
+	const char* mls_range = semanage_seuser_get_mlsrange(seuser);
+
+	semanage_user_key_t* key = NULL;
+	int exists;
+	if (semanage_user_key_create(arg->handle, sename, &key) < 0)
+		goto err;
+
+	if (semanage_user_exists(arg->handle, key, &exists) < 0)
+		goto err;
+
+	if (!exists) {
+		ERR(arg->handle, "selinux user %s does not exist", sename);
+		goto invalid;
+	}
+
+	/* FIXME: check unix user? */
+	/* FIXME: add MLS checks */
+
+	semanage_user_key_free(key);
+	return 0;
+
+	err:
+	ERR(arg->handle, "could not check if the seuser mapping "
+		"%s -> (%s, %s) is valid", name, sename, mls_range);
+	semanage_user_key_free(key);
+	return -1;
+
+	invalid:
+	ERR(arg->handle, "seuser mapping %s -> (%s, %s) is invalid",
+		name, sename, mls_range);
+	semanage_user_key_free(key);
+	return -1;
+}
+
+int semanage_seuser_validate(
+	semanage_handle_t* handle) {
+
+	struct validate_handler_arg arg;
+	arg.handle = handle;
+	return semanage_seuser_iterate(handle, validate_handler, &arg);
+}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers.h new/libsemanage/src/seusers.h
--- old/libsemanage/src/seusers.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/seusers.h	2005-11-01 00:37:02.000000000 -0500
@@ -0,0 +1,9 @@
+#ifndef _SEUSERS_INTERNAL_H_
+#define _SEUSERS_INTERNAL_H_
+
+#include <semanage/seusers.h>
+
+extern int semanage_seuser_validate(
+	semanage_handle_t* handle);
+
+#endif

--------------050802010105080606070300--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
