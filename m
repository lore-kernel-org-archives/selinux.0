Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o26MoVVR006779
	for <selinux@tycho.nsa.gov>; Sat, 6 Mar 2010 17:50:31 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o26MouhB027641
	for <selinux@tycho.nsa.gov>; Sat, 6 Mar 2010 22:50:56 GMT
Message-ID: <4B92DC33.4010605@manicmethod.com>
Date: Sat, 06 Mar 2010 17:50:27 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Last attempt at upstreaming semodule_disable patch.
References: <4B858311.1010003@redhat.com>
In-Reply-To: <4B858311.1010003@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------050803030504060207090907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050803030504060207090907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel J Walsh wrote:
> This patch allows you to disable/Enable policy modules.
>
> It never seems to get upstreamed. :^(

Acked-By: Joshua Brindle <method@manicmethod.com>

Applied the attached patch on top of it, it fixes an implicit
declaration warning, makes the errors for disabling or enabling an
already disabled or enabled module nicer and fixes a comment.


--------------050803030504060207090907
Content-Type: text/plain;
 name="additional-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="additional-fixes.patch"

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 2acfeca..399d740 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1304,8 +1304,14 @@ static int semanage_direct_enable(semanage_handle_t * sh, char *module_name)
 			goto cleanup;
 		}
 		base++;
-		if (memcmp(module_name, base, name_len) == 0 &&
-		    strcmp(base + name_len + 3, DISABLESTR) == 0) {
+		if (memcmp(module_name, base, name_len) == 0) {
+
+			if(strcmp(base + name_len + 3, DISABLESTR) != 0) {
+				ERR(sh, "Module %s is already enabled.", module_name);
+				retval = -2;
+				goto cleanup;
+			}
+
 			int len = strlen(module_filenames[i]) - strlen(DISABLESTR);
 			char *enabled_name = calloc(1, len+1);
 			if (!enabled_name) {
@@ -1336,7 +1342,7 @@ static int semanage_direct_enable(semanage_handle_t * sh, char *module_name)
 	return retval;
 }
 
-/* Enables a module from the sandbox.  Returns 0 on success, -1 if out
+/* Disables a module from the sandbox.  Returns 0 on success, -1 if out
  * of memory, -2 if module not found or could not be enabled. */
 static int semanage_direct_disable(semanage_handle_t * sh, char *module_name)
 {
@@ -1356,23 +1362,28 @@ static int semanage_direct_disable(semanage_handle_t * sh, char *module_name)
 			goto cleanup;
 		}
 		base++;
-		if (memcmp(module_name, base, name_len) == 0 &&
-		    strcmp(base + name_len, ".pp") == 0) {
-			char disabled_name[PATH_MAX];
-			if (snprintf(disabled_name, PATH_MAX, "%s%s", 
-				     module_filenames[i], DISABLESTR) == PATH_MAX) {
-				ERR(sh, "Could not disable module file %s.",
-				    module_filenames[i]);
+		if (memcmp(module_name, base, name_len) == 0) {
+			if (strcmp(base + name_len + 3, DISABLESTR) == 0) {
+				ERR(sh, "Module %s is already disabled.", module_name);
 				retval = -2;
 				goto cleanup;
+			} else if (strcmp(base + name_len, ".pp") == 0) {
+				char disabled_name[PATH_MAX];
+				if (snprintf(disabled_name, PATH_MAX, "%s%s", 
+							module_filenames[i], DISABLESTR) == PATH_MAX) {
+					ERR(sh, "Could not disable module file %s.",
+							module_filenames[i]);
+					retval = -2;
+					goto cleanup;
+				}
+				if (rename(module_filenames[i], disabled_name) == -1) {
+					ERR(sh, "Could not disable module file %s.",
+							module_filenames[i]);
+					retval = -2;
+				}
+				retval = 0;
+				goto cleanup;
 			}
-			if (rename(module_filenames[i], disabled_name) == -1) {
-				ERR(sh, "Could not disable module file %s.",
-				    module_filenames[i]);
-				retval = -2;
-			}
-			retval = 0;
-			goto cleanup;
 		}
 	}
 	ERR(sh, "Module %s was not found.", module_name);
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index 9e8b1fd..6abb2ee 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -84,6 +84,7 @@ int semanage_make_sandbox(semanage_handle_t * sh);
 int semanage_get_modules_names(semanage_handle_t * sh,
 			       char ***filenames, int *len);
 
+int semanage_module_enabled(const char *file);
 /* lock file routines */
 int semanage_get_trans_lock(semanage_handle_t * sh);
 int semanage_get_active_lock(semanage_handle_t * sh);

--------------050803030504060207090907--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
