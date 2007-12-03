Message-ID: <4754599A.8060605@redhat.com>
Date: Mon, 03 Dec 2007 14:31:38 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: libsemanage patch
Content-Type: multipart/mixed;
 boundary="------------020905060509020607060706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020905060509020607060706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

genhomedircon includes the "\n" in /etc/shells so no shells in the
/etc/passwd match.

Rawhide Policy includes policy without a user_context_tpl

swig causes a doublefree if I don't allocate memory when specifying a
alternate store.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHVFmZrlYvE4MpobMRArfoAJ460UxLWEFjgmQx6CewOcTSGxivywCdGcGL
GDS/6bPpBJRQfiVlOwWPvBI=
=cvuG
-----END PGP SIGNATURE-----

--------------020905060509020607060706
Content-Type: text/x-patch;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/genhomedircon.c libsemanage-2.0.14/src/genhomedircon.c
--- nsalibsemanage/src/genhomedircon.c	2007-10-05 13:09:53.000000000 -0400
+++ libsemanage-2.0.14/src/genhomedircon.c	2007-12-03 14:20:34.000000000 -0500
@@ -135,6 +135,7 @@
 	if (!shells)
 		return default_shell_list();
 	while (getline(&temp, &buff_len, shells) >= 0) {
+		temp[strlen(temp)-1]=0;
 		if (strcmp(temp, PATH_NOLOGIN_SHELL)) {
 			if (semanage_list_push(&list, temp)) {
 				free(temp);
@@ -790,7 +791,7 @@
 	homedir_context_tpl = make_template(s, &HOME_DIR_PRED);
 	homeroot_context_tpl = make_template(s, &HOME_ROOT_PRED);
 	user_context_tpl = make_template(s, &USER_CONTEXT_PRED);
-	if (!homedir_context_tpl || !homeroot_context_tpl || !user_context_tpl) {
+	if (!homedir_context_tpl || !homeroot_context_tpl) {
 		retval = STATUS_ERR;
 		goto done;
 	}
@@ -828,16 +829,18 @@
 
 		ustr_sc_free(&temp);
 	}
-	if (write_user_context(s, out, user_context_tpl,
-			       ".*", s->fallback_user,
-			       s->fallback_user_prefix) != STATUS_SUCCESS) {
-		retval = STATUS_ERR;
-		goto done;
-	}
+	if (user_context_tpl) {
+		if (write_user_context(s, out, user_context_tpl,
+				       ".*", s->fallback_user,
+				       s->fallback_user_prefix) != STATUS_SUCCESS) {
+			retval = STATUS_ERR;
+			goto done;
+		}
 
-	if (write_gen_home_dir_context(s, out, user_context_tpl,
-				       homedir_context_tpl) != STATUS_SUCCESS) {
-		retval = STATUS_ERR;
+		if (write_gen_home_dir_context(s, out, user_context_tpl,
+					       homedir_context_tpl) != STATUS_SUCCESS) {
+			retval = STATUS_ERR;
+		}
 	}
 
       done:
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/handle.c libsemanage-2.0.14/src/handle.c
--- nsalibsemanage/src/handle.c	2007-08-20 19:15:37.000000000 -0400
+++ libsemanage-2.0.14/src/handle.c	2007-11-10 06:21:33.000000000 -0500
@@ -27,6 +27,7 @@
 #include <assert.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <string.h>
 #include <sys/time.h>
 
 #include "direct_api.h"
@@ -131,7 +132,7 @@
 
 	/* This just sets the storename to what the user requests, no 
 	   verification of existance will be done until connect */
-	sh->conf->store_path = storename;
+	sh->conf->store_path = strdup(storename);
 	sh->conf->store_type = storetype;
 
 	return;

--------------020905060509020607060706
Content-Type: application/octet-stream;
 name="libsemanage-rhat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libsemanage-rhat.patch.sig"

iD8DBQBHVFmZrlYvE4MpobMRAsZQAJwNtrEiWFrOMe9DpSL2hMYA6Ndz7ACfWX7Jf+WAP2zV
EXpNzTJUxSwU32c=
--------------020905060509020607060706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
