Date: Tue, 29 Jan 2008 16:57:01 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200801292157.m0TLv151022264@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: Re: genhomedircon is broken in libsemanage
Cc: dwalsh@redhat.com, jbrindle@tresys.com, sds@tycho.nsa.gov,
        tmiller@tresys.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Adding
> 
> mythtv:x:1004:1004::/var/lib/mythtv:/bin/bash
> 
> To /etc/passwd causes the labeling to get all screwed up.  This would
> report an error when we used the python version of genhomedircon and
> not foul up the labeling by checking if there was a label for /var/lib
> already in the file_context file. (Boy do I love python.  :^))
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=430195

The following patch should match the old behavior.  I didn't add the
warning message but I'm open to putting it in if people think that's
the thing to do.

 - todd

 genhomedircon.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 8 deletions(-)

Index: trunk/libsemanage/src/genhomedircon.c
===================================================================
--- trunk/libsemanage/src/genhomedircon.c	(revision 2771)
+++ trunk/libsemanage/src/genhomedircon.c	(working copy)
@@ -24,6 +24,8 @@
 #include <semanage/seusers_policy.h>
 #include <semanage/users_policy.h>
 #include <semanage/user_record.h>
+#include <semanage/fcontext_record.h>
+#include <semanage/fcontexts_policy.h>
 #include <sepol/context.h>
 #include <sepol/context_record.h>
 #include "semanage_store.h"
@@ -45,6 +47,7 @@
 #include <pwd.h>
 #include <errno.h>
 #include <unistd.h>
+#include <regex.h>
 
 /* paths used in get_home_dirs() */
 #define PATH_ETC_USERADD "/etc/default/useradd"
@@ -101,6 +104,11 @@
 	const char *replace_with;
 } replacement_pair_t;
 
+typedef struct {
+	const char *dir;
+	int matched;
+} fc_match_handle_t;
+
 static semanage_list_t *default_shell_list(void)
 {
 	semanage_list_t *list = NULL;
@@ -150,10 +158,70 @@
 	return list;
 }
 
+/* Helper function called via semanage_fcontext_iterate() */
+static int fcontext_matches(const semanage_fcontext_t *fcontext, void *varg)
+{
+	const char *oexpr = semanage_fcontext_get_expr(fcontext);
+	fc_match_handle_t *handp = varg;
+	struct Ustr *expr;
+	regex_t re;
+	size_t n;
+	int type, retval = -1;
+
+	/* Only match ALL or DIR */
+	type = semanage_fcontext_get_type(fcontext);
+	if (type != SEMANAGE_FCONTEXT_ALL && type != SEMANAGE_FCONTEXT_ALL)
+		return 0;
+
+	/* Convert oexpr into a Ustr and anchor it at the beginning */
+	expr = ustr_dup_cstr("^");
+	if (expr == USTR_NULL)
+		goto done;
+	ustr_ins_cstr(&expr, 1, oexpr);
+	if (expr == USTR_NULL)
+		goto done;
+	n = ustr_len(expr);
+
+	/* Strip off trailing ".+" or ".*" */
+	if (ustr_cmp_suffix_cstr_eq(expr, ".+") ||
+	    ustr_cmp_suffix_cstr_eq(expr, ".*")) {
+		if (!ustr_del_subustr(&expr, n - 1, 2))
+			goto done;
+		n -= 2;
+	}
+
+	/* Strip off trailing "(/.*)?" */
+	if (ustr_cmp_suffix_cstr_eq(expr, "(/.*)?")) {
+		if (!ustr_del_subustr(&expr, n - 5, 6))
+			goto done;
+		n -= 6;
+	}
+
+	/* Append pattern to eat up trailing slashes */
+	if (!ustr_ins_cstr(&expr, n, "/*$"))
+		goto done;
+
+	/* Check dir against expr */
+	if (regcomp(&re, ustr_cstr(expr), REG_EXTENDED) != 0)
+		goto done;
+	if (regexec(&re, handp->dir, 0, NULL, 0) == 0)
+		handp->matched = 1;
+	regfree(&re);
+
+	retval = 0;
+
+done:
+	if (expr)
+		ustr_free(expr);
+
+	return retval;
+}
+
 static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 {
 	semanage_list_t *homedir_list = NULL;
 	semanage_list_t *shells = NULL;
+	fc_match_handle_t hand;
 	char *rbuf = NULL;
 	char *path = NULL;
 	long rbuflen;
@@ -169,21 +237,18 @@
 
 	path = semanage_findval(PATH_ETC_USERADD, "HOME", "=");
 	if (path && *path) {
-		if (semanage_list_push(&homedir_list, path)) {
-			free(path);
+		if (semanage_list_push(&homedir_list, path))
 			goto fail;
-		}
 	}
 	free(path);
 
 	path = semanage_findval(PATH_ETC_LIBUSER, "LU_HOMEDIRECTORY", "=");
 	if (path && *path) {
-		if (semanage_list_push(&homedir_list, path)) {
-			free(path);
+		if (semanage_list_push(&homedir_list, path))
 			goto fail;
-		}
 	}
 	free(path);
+	path = NULL;
 
 	if (!homedir_list) {
 		if (semanage_list_push(&homedir_list, PATH_DEFAULT_HOME)) {
@@ -211,6 +276,7 @@
 		}
 	}
 	free(path);
+	path = NULL;
 
 	path = semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=");
 	if (path && *path) {
@@ -221,6 +287,7 @@
 		}
 	}
 	free(path);
+	path = NULL;
 
 	if (!minuid_set) {
 		minuid = 500;
@@ -248,13 +315,26 @@
 		}
 
 		semanage_rtrim(path, '/');
+
 		if (!semanage_list_find(homedir_list, path)) {
-			if (semanage_list_push(&homedir_list, path)) {
-				free(path);
+			/*
+			 * Now check for an existing file context that matches
+			 * so we don't label a non-homedir as a homedir.
+			 */
+			hand.dir = path;
+			hand.matched = 0;
+			if (semanage_fcontext_iterate(s->h_semanage,
+			    fcontext_matches, &hand) == STATUS_ERR)
 				goto fail;
+
+			/* NOTE: old genhomedircon printed a warning on match */
+			if (!hand.matched) {
+				if (semanage_list_push(&homedir_list, path))
+					goto fail;
 			}
 		}
 		free(path);
+		path = NULL;
 	}
 
 	if (retval && retval != ENOENT) {
@@ -272,6 +352,7 @@
       fail:
 	endpwent();
 	free(rbuf);
+	free(path);
 	semanage_list_destroy(&homedir_list);
 	semanage_list_destroy(&shells);
 	return NULL;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
