Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0OLDp1x025631
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 16:13:51 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0OLDnph019502
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 21:13:49 GMT
Subject: [patch 1/1] libsemanage: genhomedircon remove error on missing
	HOME_DIR or HOME_ROOT v2
From: Caleb Case <ccase@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 16:05:44 -0500
Message-Id: <1201208744.17236.10.camel@olympus.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Replacing failure condition in write_context_file when HOME_DIR or
HOME_ROOT are not found in the contexts. This condition is not needed
(the case where the lists are empty is handled correctly) and stops
otherwise valid operations:

On a fresh policy store, without any modules loaded:

# semodule -s refpolicy -b /usr/share/selinux/refpolicy/base.pp
libsemanage.semanage_install_sandbox: semanage_genhomedircon returned
error code -1. No such file or directory.
semodule:  Failed!

Failure is replaced with an early success return which happens when
HOME_DIR, HOME_ROOT, or USER are not found.

The list of homedirs is computed only if needed (HOME_DIR or HOME_ROOT
exist).

---
 src/genhomedircon.c |   72 +++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

Index: libsemanage/src/genhomedircon.c
===================================================================
--- libsemanage.orig/src/genhomedircon.c
+++ libsemanage/src/genhomedircon.c
@@ -779,21 +779,15 @@ static int write_context_file(genhomedir
 	semanage_list_t *homeroot_context_tpl = NULL;
 	int retval = STATUS_SUCCESS;
 
-	homedirs = get_home_dirs(s);
-	if (!homedirs) {
-		WARN(s->h_semanage,
-		     "no home directories were available, exiting without writing");
-		return STATUS_ERR;	/* No homedirs so no output */
-	}
-
-	if (write_file_context_header(s, out) != STATUS_SUCCESS)
-		return STATUS_ERR;
-
 	homedir_context_tpl = make_template(s, &HOME_DIR_PRED);
 	homeroot_context_tpl = make_template(s, &HOME_ROOT_PRED);
 	user_context_tpl = make_template(s, &USER_CONTEXT_PRED);
-	if (!homedir_context_tpl || !homeroot_context_tpl) {
-		retval = STATUS_ERR;
+
+	if (!homedir_context_tpl && !homeroot_context_tpl && !user_context_tpl)
+		goto done;
+
+	if (write_file_context_header(s, out) != STATUS_SUCCESS) {
+		return STATUS_ERR;
 		goto done;
 	}
 
@@ -801,34 +795,44 @@ static int write_context_file(genhomedir
 		retval = STATUS_ERR;
 		goto done;
 	}
-	for (h = homedirs; h; h = h->next) {
-		Ustr *temp = ustr_dup_cstr(h->data);
 
-		if (!temp || !ustr_add_cstr(&temp, "/[^/]*")) {
-			ustr_sc_free(&temp);
-			retval = STATUS_ERR;
+	if (homedir_context_tpl || homeroot_context_tpl) {
+		homedirs = get_home_dirs(s);
+		if (!homedirs) {
+			WARN(s->h_semanage,
+			     "no home directories were available, exiting without writing");
 			goto done;
 		}
 
-		if (write_home_dir_context(s, out,
-					   homedir_context_tpl,
-					   s->fallback_user, s->fallback_user,
-					   ustr_cstr(temp),
-					   s->fallback_user_prefix) !=
-		    STATUS_SUCCESS) {
-			ustr_sc_free(&temp);
-			retval = STATUS_ERR;
-			goto done;
-		}
-		if (write_home_root_context(s, out,
-					    homeroot_context_tpl,
-					    h->data) != STATUS_SUCCESS) {
+		for (h = homedirs; h; h = h->next) {
+			Ustr *temp = ustr_dup_cstr(h->data);
+
+			if (!temp || !ustr_add_cstr(&temp, "/[^/]*")) {
+				ustr_sc_free(&temp);
+				retval = STATUS_ERR;
+				goto done;
+			}
+
+			if (write_home_dir_context(s, out,
+						   homedir_context_tpl,
+						   s->fallback_user, s->fallback_user,
+						   ustr_cstr(temp),
+						   s->fallback_user_prefix) !=
+			    STATUS_SUCCESS) {
+				ustr_sc_free(&temp);
+				retval = STATUS_ERR;
+				goto done;
+			}
+			if (write_home_root_context(s, out,
+						    homeroot_context_tpl,
+						    h->data) != STATUS_SUCCESS) {
+				ustr_sc_free(&temp);
+				retval = STATUS_ERR;
+				goto done;
+			}
+
 			ustr_sc_free(&temp);
-			retval = STATUS_ERR;
-			goto done;
 		}
-
-		ustr_sc_free(&temp);
 	}
 	if (user_context_tpl) {
 		if (write_user_context(s, out, user_context_tpl,

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
