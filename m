Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q04FhHEQ003975
	for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2012 10:43:17 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q04FhFY2019127
	for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2012 15:43:16 GMT
Message-ID: <4F047391.202@redhat.com>
Date: Wed, 04 Jan 2012 10:43:13 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Xin Ouyang <xinpascal@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Use specified semanage.conf for cross compiling
References: <CANvtKVYZsPZwzmXjwTv672Usd7zQKiY_dfvht7mp3Rkcn7Gi2g@mail.gmail.com>
In-Reply-To: <CANvtKVYZsPZwzmXjwTv672Usd7zQKiY_dfvht7mp3Rkcn7Gi2g@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------020200060806070709070308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020200060806070709070308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/04/2012 03:57 AM, Xin Ouyang wrote:
> Hi all,
> 
> For some cross compiling cases, I need to use semodule to create
> the policy store at build time. It is, semodule -n -b base.pp -i
> some.pp .. -p $TARGET_ROOT
> 
> With this, semodule will use /etc/selinux/semanage.conf by calling 
> semanage_handle_create():
> 
> // libsemanage/src/handle.c semanage_handle_t
> *semanage_handle_create(void) { semanage_handle_t *sh = NULL; const
> char *conf_name = NULL;
> 
> /* Allocate handle */ if ((sh = calloc(1,
> sizeof(semanage_handle_t))) == NULL) goto err;
> 
> if ((conf_name = semanage_conf_path()) == NULL) goto err;
> 
> if ((sh->conf = semanage_conf_parse(conf_name)) == NULL) goto err;
> 
> While there may be some different options in  semanage.conf for
> the target, I am trying to specify a special semanage.conf path
> instead of /etc/selinux/semanage.conf in the build host.
> 
> Commit 9cd587f5533456e7b26601e27e65744272e2e783 introduced 
> semanage_set_root() as an alternate root for policy stores. So I
> make a patch to use the semanage.conf in the alternate root. After
> the patch, semodule -p /target will use 
> /target/etc/selinux/semanage.conf as the config file.
> 
> Anyone who has better solutions, please
> 
> 
> diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c 
> index 7adc1cc..ef36152 100644 --- a/libsemanage/src/handle.c +++
> b/libsemanage/src/handle.c @@ -41,6 +41,7 @@ #include <string.h> 
> #include <selinux/selinux.h> static char *private_selinux_path =
> NULL; +static char *private_semanage_conf_path = NULL; static char
> *private_file_context_path = NULL; static char
> *private_file_context_local_path = NULL; static char
> *private_file_context_homedir_path = NULL; @@ -52,6 +53,7 @@ static
> char *private_policy_root = NULL;
> 
> void semanage_free_root() { free(private_selinux_path);
> private_selinux_path = NULL; +
> free(private_semanage_conf_path); private_semanage_conf_path =
> NULL; free(private_file_context_path); private_file_context_path =
> NULL; free(private_file_context_local_path); 
> private_file_context_local_path = NULL; 
> free(private_file_context_homedir_path); 
> private_file_context_homedir_path = NULL; @@ -68,6 +70,10 @@ int
> semanage_set_root(const char *path) { goto error; }
> 
> +       if ( asprintf(&private_semanage_conf_path, "%s/%s", path, 
> semanage_conf_path()) < 0 ) { +               goto error; +
> } + if ( asprintf(&private_file_context_path, "%s/%s", path, 
> selinux_file_context_path()) < 0 ) { goto error; } @@ -171,6
> +177,13 @@ const char *semanage_selinux_path(void) { return
> selinux_path(); }
> 
> +const char *semanage_semanage_conf_path(void) { +       if
> (private_semanage_conf_path +               &&
> access(private_semanage_conf_path, R_OK) == 0) +
> return private_semanage_conf_path; +       return
> semanage_conf_path(); +} + semanage_handle_t
> *semanage_handle_create(void) { semanage_handle_t *sh = NULL; @@
> -180,7 +193,7 @@ semanage_handle_t *semanage_handle_create(void) if
> ((sh = calloc(1, sizeof(semanage_handle_t))) == NULL) goto err;
> 
> -       if ((conf_name = semanage_conf_path()) == NULL) +       if
> ((conf_name = semanage_semanage_conf_path()) == NULL) goto err;
> 
> if ((sh->conf = semanage_conf_parse(conf_name)) == NULL)


How about this patch instead.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8Ec5EACgkQrlYvE4MpobMGUgCfS4IXRl6CslxjlmM1HHpTlwbl
lMwAoNQBVA6F9mv7spdOE64IsxAx67dx
=BWGP
-----END PGP SIGNATURE-----

--------------020200060806070709070308
Content-Type: text/x-patch;
 name="libsemanage_conf_path.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage_conf_path.patch"

diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 7adc1cc..4b43ba7 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -37,10 +37,12 @@
 #include "semanage_store.h"
 
 #define SEMANAGE_COMMIT_READ_WAIT 5
+#define SEMANAGE_CONF_PATH "/etc/selinux/semanage.conf"
 
 #include <string.h>
 #include <selinux/selinux.h>
 static char *private_selinux_path = NULL;
+static char *private_semanage_conf_path = NULL;
 static char *private_file_context_path = NULL;
 static char *private_file_context_local_path = NULL;
 static char *private_file_context_homedir_path = NULL;
@@ -52,6 +54,7 @@ static char *private_policy_root = NULL;
 
 void semanage_free_root() {
 	free(private_selinux_path); private_selinux_path = NULL;
+	free(private_semanage_conf_path); private_semanage_conf_path = NULL;
 	free(private_file_context_path); private_file_context_path = NULL;
 	free(private_file_context_local_path); private_file_context_local_path = NULL;
 	free(private_file_context_homedir_path); private_file_context_homedir_path = NULL;
@@ -68,6 +71,10 @@ int semanage_set_root(const char *path) {
 		goto error;
 	}
 
+	if ( asprintf(&private_semanage_conf_path, "%s/%s", path, SEMANAGE_CONF_PATH) < 0 ) {
+		goto error;
+	}
+
 	if ( asprintf(&private_file_context_path, "%s/%s", path, selinux_file_context_path()) < 0 ) {
 		goto error;
 	}
@@ -171,6 +178,20 @@ const char *semanage_selinux_path(void) {
 	return selinux_path();
 }
 
+/* Return a fully-qualified path + filename to the semanage
+ * configuration file.  The caller must not alter the string returned
+ * (and hence why this function return type is const).
+ *
+ */
+
+const char *semanage_conf_path(void)
+{
+	if (private_semanage_conf_path)
+		return private_semanage_conf_path;
+
+	return SEMANAGE_CONF_PATH;
+}
+
 semanage_handle_t *semanage_handle_create(void)
 {
 	semanage_handle_t *sh = NULL;
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index 723d811..bb12594 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -105,6 +105,8 @@ struct semanage_handle {
 	dbase_config_t dbase[DBASE_COUNT];
 };
 
+const char *semanage_conf_path(void);
+
 /* === Local modifications === */
 static inline
     dbase_config_t * semanage_user_base_dbase_local(semanage_handle_t * handle)
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index a223aa7..0e7b71a 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -262,18 +262,6 @@ const char *semanage_path(enum semanage_store_defs store,
 	return semanage_paths[store][path_name];
 }
 
-/* Return a fully-qualified path + filename to the semanage
- * configuration file.  The caller must not alter the string returned
- * (and hence why this function return type is const).
- *
- * This is going to be hard coded to /etc/selinux/semanage.conf for
- * the time being. FIXME
- */
-const char *semanage_conf_path(void)
-{
-	return "/etc/selinux/semanage.conf";
-}
-
 /**************** functions that create module store ***************/
 
 /* Check that the semanage store exists.  If 'create' is non-zero then
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index b451308..98e011d 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -66,7 +66,6 @@ enum semanage_sandbox_defs {
 /* FIXME: this needs to be made a module store specific init and the
  * global configuration moved to another file.
  */
-const char *semanage_conf_path(void);
 int semanage_check_init(const char *root);
 
 extern const char *semanage_fname(enum semanage_sandbox_defs file_enum);

--------------020200060806070709070308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
