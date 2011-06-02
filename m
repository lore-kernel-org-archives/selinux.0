Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p52GQCm9029830
	for <selinux@tycho.nsa.gov>; Thu, 2 Jun 2011 12:26:12 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p52GQBbv013156
	for <selinux@tycho.nsa.gov>; Thu, 2 Jun 2011 16:26:11 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p52GQA5d017595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 2 Jun 2011 12:26:11 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p52GQAXW002998
	for <selinux@tycho.nsa.gov>; Thu, 2 Jun 2011 12:26:10 -0400
Message-ID: <4DE7B9A2.7050404@redhat.com>
Date: Thu, 02 Jun 2011 12:26:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: This is a patch to allow libsemanage to handle an alternate root.
Content-Type: multipart/mixed;
 boundary="------------010405070806060507010006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010405070806060507010006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

What I want to add is the ability to do

semodule -n -B -p /tmp/BUILDROOT/

And have semodule build policy in

/tmp/BUILDROOT/etc/selinux/...

Basically this patch adds a new interface

semanage_set_root(char *path)

semanage_set_root("/tmp/BUILDROOT")

Which sets the alternate root.

All selinux_* calls are then replaced with matching semanage_* calls
that will prepent the rootpath if it exists to the selinux_* values.

If the semanage_set_root() is never called, the selinux_* values will
continue to be used.

We will be using this functionality so that we can build an entire
install tree within our spec file and will no longer need to run
semodule ... on initial installs or "unmodified" machines.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3nuaIACgkQrlYvE4MpobMtFwCdFrKV1bSEBlM6j3RzAkOzTbPJ
HCwAoL+ZK8il8Ck7zeW7U/wP+jzaFeJ9
=wzzM
-----END PGP SIGNATURE-----

--------------010405070806060507010006
Content-Type: text/plain;
 name="libsemanage-alternate-root.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage-alternate-root.patch"

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index a482cdd..e303713 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -126,6 +126,9 @@ int semanage_is_connected(semanage_handle_t * sh);
 /* returns 1 if policy is MLS, 0 otherwise. */
 int semanage_mls_enabled(semanage_handle_t *sh);
 
+/* Change to alternate selinux root path */
+int semanage_set_root(const char *path);
+
 /* META NOTES
  *
  * For all functions a non-negative number indicates success. For some
diff --git a/libsemanage/man/man3/semanage_set_root.3 b/libsemanage/man/man3/semanage_set_root.3
new file mode 100644
index 0000000..c464d66
--- /dev/null
+++ b/libsemanage/man/man3/semanage_set_root.3
@@ -0,0 +1,22 @@
+.TH semanage_set_root 3 "1 June 2011" "dwalsh@redhat.com" "Libsemanage API documentation"
+
+.SH "NAME" 
+semanage_set_root \- SELinux Management API
+
+.SH "SYNOPSIS"
+Set the alternate root directory for SELinux configuration directory.
+
+.B	#include <semanage/handle.h>
+
+.B	extern const char *semanage_set_root(const char *path);
+
+.SH "DESCRIPTION"
+.TP
+This function sets an alternate root directory to for SELinux configuration paths to be used by the semanage library.
+
+.SH "RETURN VALUE"
+In case of failure, -1 is returned.
+Otherwise 0 is returned.
+
+.SH "SEE ALSO"
+.BR semanage_handle_create "(3), " semanage_connect "(3), "
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 9b261b9..77c00b2 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -21,6 +21,7 @@
 %{
 
 #include "semanage_conf.h"
+#include "handle.h"
 
 #include <sepol/policydb.h>
 #include <selinux/selinux.h>
@@ -260,7 +261,7 @@ external_opt:   PROG_PATH '=' ARG  { PASSIGN(new_external->path, $3); }
 static int semanage_conf_init(semanage_conf_t * conf)
 {
 	conf->store_type = SEMANAGE_CON_DIRECT;
-	conf->store_path = strdup(basename(selinux_policy_root()));
+	conf->store_path = strdup(basename(semanage_policy_root()));
 	conf->policyvers = sepol_policy_kern_vers_max();
 	conf->expand_check = 1;
 	conf->handle_unknown = -1;
@@ -390,7 +391,7 @@ static int parse_module_store(char *arg)
 	if (strcmp(arg, "direct") == 0) {
 		current_conf->store_type = SEMANAGE_CON_DIRECT;
 		current_conf->store_path =
-		    strdup(basename(selinux_policy_root()));
+		    strdup(basename(semanage_policy_root()));
 		current_conf->server_port = -1;
 		free(arg);
 	} else if (*arg == '/') {
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index bceb6a7..7416540 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -95,7 +95,7 @@ int semanage_direct_is_managed(semanage_handle_t * sh)
 {
 	char polpath[PATH_MAX];
 
-	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(),
+	snprintf(polpath, PATH_MAX, "%s%s", semanage_selinux_path(),
 		 sh->conf->store_path);
 
 	if (semanage_check_init(polpath))
@@ -118,7 +118,7 @@ int semanage_direct_connect(semanage_handle_t * sh)
 	char polpath[PATH_MAX];
 	const char *path;
 
-	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(),
+	snprintf(polpath, PATH_MAX, "%s%s", semanage_selinux_path(),
 		 sh->conf->store_path);
 
 	if (semanage_check_init(polpath))
@@ -1539,7 +1539,7 @@ int semanage_direct_access_check(semanage_handle_t * sh)
 {
 	char polpath[PATH_MAX];
 
-	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(),
+	snprintf(polpath, PATH_MAX, "%s%s", semanage_selinux_path(),
 		 sh->conf->store_path);
 
 	if (semanage_check_init(polpath))
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 76caefd..1eb08b9 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -38,6 +38,139 @@
 
 #define SEMANAGE_COMMIT_READ_WAIT 5
 
+#include <string.h>
+#include <selinux/selinux.h>
+static char *private_selinux_path = NULL;
+static char *private_file_context_path = NULL;
+static char *private_file_context_local_path = NULL;
+static char *private_file_context_homedir_path = NULL;
+static char *private_homedir_context_path = NULL;
+static char *private_binary_policy_path = NULL;
+static char *private_usersconf_path = NULL;
+static char *private_netfilter_context_path = NULL;
+static char *private_policy_root = NULL;
+
+void semanage_free_root() {
+	free(private_selinux_path); private_selinux_path = NULL;
+	free(private_file_context_path); private_file_context_path = NULL;
+	free(private_file_context_local_path); private_file_context_local_path = NULL;
+	free(private_file_context_homedir_path); private_file_context_homedir_path = NULL;
+	free(private_homedir_context_path); private_homedir_context_path = NULL;
+	free(private_binary_policy_path); private_binary_policy_path = NULL;
+	free(private_usersconf_path); private_usersconf_path = NULL;
+	free(private_netfilter_context_path); private_netfilter_context_path = NULL;
+	free(private_policy_root); private_policy_root = NULL;
+}
+
+int semanage_set_root(const char *path) {
+	semanage_free_root();
+	if ( asprintf(&private_selinux_path, "%s/%s", path, selinux_path()) < 0 ) { 
+		goto error;
+	}
+
+	if ( asprintf(&private_file_context_path, "%s/%s", path, selinux_file_context_path()) < 0 ) { 
+		goto error;
+	}
+
+	if ( asprintf(&private_file_context_local_path, "%s/%s", path, selinux_file_context_local_path()) < 0 ) { 
+		goto error;
+	}
+
+	if ( asprintf(&private_homedir_context_path, "%s/%s", path, selinux_homedir_context_path()) < 0 ) { 
+		goto error;
+	}
+
+	if ( asprintf(&private_file_context_homedir_path, "%s/%s", path, selinux_file_context_homedir_path()) < 0 ) { 
+		goto error;
+	}
+
+	if ( asprintf(&private_binary_policy_path, "%s/%s", path, selinux_binary_policy_path()) < 0 ) { 
+		goto error;
+	}
+
+	if ( asprintf(&private_usersconf_path, "%s/%s", path, selinux_usersconf_path()) < 0 ) { 
+		goto error;
+	}
+
+	if ( asprintf(&private_netfilter_context_path, "%s/%s", path, selinux_netfilter_context_path()) < 0 ) { 
+		goto error;
+	}
+
+	if ( asprintf(&private_policy_root, "%s/%s", path, selinux_policy_root()) < 0 ) { 
+		goto error;
+	}
+
+	return 0;
+error:
+	semanage_free_root();
+	return -1;
+}
+hidden_def(semanage_set_root)
+
+const char *semanage_file_context_path() {
+//	printf("private_file_context_path %s\n", private_file_context_path);
+	if (private_file_context_path)
+		return private_file_context_path;
+	return selinux_file_context_path();
+}
+
+const char *semanage_file_context_local_path() {
+//	printf("private_file_context_local_path %s\n", private_file_context_local_path);
+	if (private_file_context_local_path) 
+		return private_file_context_local_path;
+	return selinux_file_context_local_path();
+}
+
+const char *semanage_file_context_homedir_path() {
+//	printf("private_file_context_homedir_path %s\n", private_file_context_homedir_path);
+	if (private_file_context_homedir_path) 
+		return private_file_context_homedir_path;
+
+	return selinux_file_context_homedir_path();
+}
+
+const char *semanage_homedir_context_path() {
+//	printf("private_homedir_context_path %s\n", private_homedir_context_path);
+	if (private_homedir_context_path)
+		return private_homedir_context_path;
+	return selinux_homedir_context_path();
+}
+
+const char *semanage_binary_policy_path() {
+//	printf("private_binary_policy_path %s\n", private_binary_policy_path);
+	if (private_binary_policy_path)
+		return private_binary_policy_path;
+	return selinux_binary_policy_path();
+}
+
+const char *semanage_usersconf_path() {
+//	printf("private_usersconf_path %s\n", private_usersconf_path);
+	if (private_usersconf_path) 
+		return private_usersconf_path;
+	return selinux_usersconf_path();
+}
+
+const char *semanage_netfilter_context_path() {
+//	printf("private_netfilter_context_path %s\n", private_netfilter_context_path);
+	if (private_netfilter_context_path) 
+		return private_netfilter_context_path;
+	return selinux_netfilter_context_path();
+}
+
+const char *semanage_policy_root() {
+//	printf("private_policy_root %s\n", private_policy_root);
+	if (private_policy_root) 
+		return private_policy_root;
+	return selinux_policy_root();
+}
+
+const char *semanage_selinux_path(void) {
+//	printf("private_selinux_path %s\n", private_selinux_path);
+	if (private_selinux_path)
+		return private_selinux_path;
+	return selinux_path();
+}
+
 semanage_handle_t *semanage_handle_create(void)
 {
 	semanage_handle_t *sh = NULL;
diff --git a/libsemanage/src/handle_internal.h b/libsemanage/src/handle_internal.h
index 8493a39..2971600 100644
--- a/libsemanage/src/handle_internal.h
+++ b/libsemanage/src/handle_internal.h
@@ -5,7 +5,18 @@
 #include "dso.h"
 
 hidden_proto(semanage_begin_transaction)
-    hidden_proto(semanage_handle_destroy)
-    hidden_proto(semanage_reload_policy)
-    hidden_proto(semanage_access_check)
+hidden_proto(semanage_handle_destroy)
+hidden_proto(semanage_reload_policy)
+hidden_proto(semanage_access_check)
+hidden_proto(semanage_set_root)
+
+extern const char *semanage_selinux_path(void);
+extern const char *semanage_file_context_path();
+extern const char *semanage_file_context_local_path();
+extern const char *semanage_file_context_homedir_path();
+extern const char *semanage_homedir_context_path();
+extern const char *semanage_binary_policy_path();
+extern const char *semanage_usersconf_path();
+extern const char *semanage_netfilter_context_path();
+extern const char *semanage_policy_root();
 #endif
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 762e20e..3222e3d 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -14,6 +14,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_get_version; semanage_select_store;
 	  semanage_module_get_enabled;
 	  semanage_reload_policy; semanage_set_reload; semanage_set_rebuild;
+	  semanage_set_root;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_node_*;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 339bbd0..e970a8b 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -90,7 +90,7 @@ static const char *semanage_store_paths[SEMANAGE_NUM_STORES] = {
 	"/tmp"
 };
 
-/* this is the module store path relative to selinux_policy_root() */
+/* this is the module store path relative to semanage_policy_root() */
 #define SEMANAGE_MOD_DIR "/modules"
 /* relative path names to enum sandbox_paths for special files within
  * a sandbox */
@@ -170,11 +170,11 @@ static int semanage_init_paths(const char *root)
 			semanage_relative_files[i]);
 	}
 
-	len = strlen(selinux_path()) + strlen(SEMANAGE_CONF_FILE);
+	len = strlen(semanage_selinux_path()) + strlen(SEMANAGE_CONF_FILE);
 	semanage_conf = calloc(len + 1, sizeof(char));
 	if (!semanage_conf)
 		return -1;
-	snprintf(semanage_conf, len, "%s%s", selinux_path(),
+	snprintf(semanage_conf, len, "%s%s", semanage_selinux_path(),
 		 SEMANAGE_CONF_FILE);
 
 	return 0;
@@ -1071,14 +1071,14 @@ static int semanage_install_active(semanage_handle_t * sh)
 	const char *active_fc_hd =
 	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC_HOMEDIRS);
 
-	const char *running_fc = selinux_file_context_path();
-	const char *running_fc_loc = selinux_file_context_local_path();
-	const char *running_fc_hd = selinux_file_context_homedir_path();
-	const char *running_hd = selinux_homedir_context_path();
-	const char *running_policy = selinux_binary_policy_path();
-	const char *running_seusers = selinux_usersconf_path();
-	const char *running_nc = selinux_netfilter_context_path();
-	const char *really_active_store = selinux_policy_root();
+	const char *running_fc = semanage_file_context_path();
+	const char *running_fc_loc = semanage_file_context_local_path();
+	const char *running_fc_hd = semanage_file_context_homedir_path();
+	const char *running_hd = semanage_homedir_context_path();
+	const char *running_policy = semanage_binary_policy_path();
+	const char *running_seusers = semanage_usersconf_path();
+	const char *running_nc = semanage_netfilter_context_path();
+	const char *really_active_store = semanage_policy_root();
 
 	/* This is very unelegant, the right thing to do is export the path 
 	 * building code in libselinux so that you can get paths for a given 
@@ -1099,11 +1099,11 @@ static int semanage_install_active(semanage_handle_t * sh)
 	running_seusers += len;
 	running_nc += len;
 
-	len = strlen(selinux_path()) + strlen(sh->conf->store_path) + 1;
+	len = strlen(semanage_selinux_path()) + strlen(sh->conf->store_path) + 1;
 	storepath = (char *)malloc(len);
 	if (!storepath)
 		goto cleanup;
-	snprintf(storepath, PATH_MAX, "%s%s", selinux_path(),
+	snprintf(storepath, PATH_MAX, "%s%s", semanage_selinux_path(),
 		 sh->conf->store_path);
 
 	snprintf(store_pol, PATH_MAX, "%s%s.%d", storepath,
               strncpy(buff, methods[i].ml_doc, ldoc);
               buff += ldoc;
               strncpy(buff, "swig_ptr: ", 10);

--------------010405070806060507010006
Content-Type: application/pgp-signature;
 name="libsemanage-alternate-root.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libsemanage-alternate-root.patch.sig"

iEYEABECAAYFAk3nuaIACgkQrlYvE4MpobPKnQCfV3gNBVXLJ5vkIAMBWKTsT62r19MAoKm0
ou/tEm2dmOo+AmgKKXfw1n/t
--------------010405070806060507010006--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
