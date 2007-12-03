Message-ID: <47546BE8.4010201@redhat.com>
Date: Mon, 03 Dec 2007 15:49:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Todd Miller <Tmiller@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libsemanage patch
References: <4754599A.8060605@redhat.com>	 <6FE441CD9F0C0C479F2D88F959B0158801455C46@exchange.columbia.tresys.com> <1196711592.27820.133.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1196711592.27820.133.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------030206010006080900010208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030206010006080900010208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Mon, 2007-12-03 at 14:51 -0500, Todd Miller wrote:
>> Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> genhomedircon includes the "\n" in /etc/shells so no shells in the
>>> /etc/passwd match.
>> Isn't this going to cause problems if the last line in /etc/shells has
>> no newline?
>>
>> Instead of:
>>     temp[strlen(temp)-1]=0;
>>
>> I would use:
>>     temp[strcspn(temp, "\n")] = '\0';
>>
>> That will overwrite the first newline with a NUL or, if there is no
>> newline, the terminating NUL will be overwritten with another NUL, which
>> is harmless.  It is a useful idiom...
> 
> Given that getline() returns the length read (not to be confused with
> the buffer length), why not just:
> 	while ((len = getline(&temp, &buff_len, shells)) > 0) {
> 		if (temp[len-1] == '\n') temp[len-1] = 0;
> 
Second try.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHVGvnrlYvE4MpobMRAhxfAJ4vuvC1uijEUDqFdj8Ju+cTJQIqoQCeMVqP
086ZRyvnHu9fsF7V8hLeEyI=
=jyGo
-----END PGP SIGNATURE-----

--------------030206010006080900010208
Content-Type: text/x-patch;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/genhomedircon.c libsemanage-2.0.14/src/genhomedircon.c
--- nsalibsemanage/src/genhomedircon.c	2007-10-05 13:09:53.000000000 -0400
+++ libsemanage-2.0.14/src/genhomedircon.c	2007-12-03 15:47:19.000000000 -0500
@@ -130,11 +130,13 @@
 	char *temp = NULL;
 	semanage_list_t *list = NULL;
 	size_t buff_len = 0;
+	int len;
 
 	shells = fopen(PATH_SHELLS_FILE, "r");
 	if (!shells)
 		return default_shell_list();
-	while (getline(&temp, &buff_len, shells) >= 0) {
+	while ((len = getline(&temp, &buff_len, shells)) > 0) {
+		if (temp[len-1] == '\n') temp[len-1] = 0;
 		if (strcmp(temp, PATH_NOLOGIN_SHELL)) {
 			if (semanage_list_push(&list, temp)) {
 				free(temp);
@@ -790,7 +792,7 @@
 	homedir_context_tpl = make_template(s, &HOME_DIR_PRED);
 	homeroot_context_tpl = make_template(s, &HOME_ROOT_PRED);
 	user_context_tpl = make_template(s, &USER_CONTEXT_PRED);
-	if (!homedir_context_tpl || !homeroot_context_tpl || !user_context_tpl) {
+	if (!homedir_context_tpl || !homeroot_context_tpl) {
 		retval = STATUS_ERR;
 		goto done;
 	}
@@ -828,16 +830,18 @@
 
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

--------------030206010006080900010208
Content-Type: application/octet-stream;
 name="libsemanage-rhat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libsemanage-rhat.patch.sig"

iD8DBQBHVGvnrlYvE4MpobMRAmQCAJ9dxmVoB8fAttERA8arHInVYjbgWQCg0C+XwyvbtdcE
aftfp1mD2PuRanw=
--------------030206010006080900010208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
