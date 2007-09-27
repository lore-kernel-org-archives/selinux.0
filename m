Message-Id: <20070927200752.771549660@tresys.com>
References: <20070927200712.950671948@tresys.com>
Date: Thu, 27 Sep 2007 16:07:15 -0400
From: "Todd C. Miller" <tmiller@tresys.com>
To: sds@tycho.nsa.gov, dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com, tmiller@tresys.com
Subject: [patch 3/4] libsemanage: update default user
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Patch from dwalsh to update the default user and prefix based on the
seusers file.  Previously it just assumed user_u and user.

---
 libsemanage/src/genhomedircon.c |   86 +++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 13 deletions(-)

Index: trunk/libsemanage/src/genhomedircon.c
===================================================================
--- trunk.orig/libsemanage/src/genhomedircon.c
+++ trunk/libsemanage/src/genhomedircon.c
@@ -82,6 +82,8 @@ typedef struct {
 	const char *fcfilepath;
 	int usepasswd;
 	const char *homedir_template_path;
+	char *fallback_user;
+	char *fallback_user_prefix;
 	semanage_handle_t *h_semanage;
 	sepol_policydb_t *policydb;
 } genhomedircon_settings_t;
@@ -554,6 +556,25 @@ static void pop_user_entry(genhomedircon
 	free(temp);
 }
 
+static int set_fallback_user(genhomedircon_settings_t *s,
+			     const char *user, const char *prefix)
+{
+	char *fallback_user = strdup(user);
+	char *fallback_user_prefix = strdup(prefix);
+
+	if (fallback_user == NULL || fallback_user_prefix == NULL) {
+		free(fallback_user);
+		free(fallback_user_prefix);
+		return STATUS_ERR;
+	}
+
+	free(s->fallback_user);
+	free(s->fallback_user_prefix);
+	s->fallback_user = fallback_user;
+	s->fallback_user_prefix = fallback_user_prefix;
+	return STATUS_SUCCESS;
+}
+
 static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 					     int *errors)
 {
@@ -596,13 +617,40 @@ static genhomedircon_user_entry_t *get_u
 
 	for (i = 0; i < nseusers; i++) {
 		name = semanage_seuser_get_name(seuser_list[i]);
+		if (strcmp(name, DEFAULT_LOGIN) == 0) {
+			seuname = semanage_seuser_get_sename(seuser_list[i]);
+
+			/* find the user structure given the name */
+			u = bsearch(seuname, user_list, nusers,
+				    sizeof(semanage_user_t *),
+				    (int (*)(const void *, const void *))
+				    &name_user_cmp);
+			if (u) {
+				prefix = semanage_user_get_prefix(*u);
+			} else {
+				prefix = name;
+			}
+
+			if (set_fallback_user(s, seuname, prefix) != 0) {
+				*errors = STATUS_ERR;
+				goto cleanup;
+			}
+			break;
+		}
+	}
+
+	for (i = 0; i < nseusers; i++) {
 		seuname = semanage_seuser_get_sename(seuser_list[i]);
 
-		if (strcmp(seuname, FALLBACK_USER) == 0)
+		if (strcmp(seuname, s->fallback_user) == 0)
 			continue;
-		if (strcmp(seuname, DEFAULT_LOGIN) == 0)
+
+		name = semanage_seuser_get_name(seuser_list[i]);
+
+		if (strcmp(name, DEFAULT_LOGIN) == 0)
 			continue;
-		if (strcmp(seuname, TEMPLATE_SEUSER) == 0)
+
+		if (strcmp(name, TEMPLATE_SEUSER) == 0)
 			continue;
 
 		/* find the user structure given the name */
@@ -721,6 +769,12 @@ static int write_context_file(genhomedir
 		goto done;
 	}
 
+	if (write_gen_home_dir_context(s, out, user_context_tpl,
+				       homedir_context_tpl) != STATUS_SUCCESS) {
+		retval = STATUS_ERR;
+		goto done;
+	}
+
 	for (h = homedirs; h; h = h->next) {
 		Ustr *temp = ustr_dup_cstr(h->data);
 
@@ -731,9 +785,10 @@ static int write_context_file(genhomedir
 		}
 
 		if (write_home_dir_context(s, out,
-					   homedir_context_tpl, FALLBACK_USER,
-					   FALLBACK_USER, ustr_cstr(temp),
-					   FALLBACK_USER_PREFIX) !=
+					   homedir_context_tpl,
+					   s->fallback_user, s->fallback_user,
+					   ustr_cstr(temp),
+					   s->fallback_user_prefix) !=
 		    STATUS_SUCCESS) {
 			ustr_sc_free(&temp);
 			retval = STATUS_ERR;
@@ -749,16 +804,12 @@ static int write_context_file(genhomedir
 
 		ustr_sc_free(&temp);
 	}
-	if (write_user_context(out, user_context_tpl,
-			       ".*", FALLBACK_USER,
-			       FALLBACK_USER_PREFIX) != STATUS_SUCCESS) {
+	if (write_user_context(s, out, user_context_tpl,
+			       ".*", s->fallback_user,
+			       s->fallback_user_prefix) != STATUS_SUCCESS) {
 		retval = STATUS_ERR;
 		goto done;
 	}
-	if (write_gen_home_dir_context(out, s, user_context_tpl,
-				       homedir_context_tpl) != STATUS_SUCCESS) {
-		retval = STATUS_ERR;
-	}
 
       done:
 	/* Cleanup */
@@ -784,6 +835,11 @@ int semanage_genhomedircon(semanage_hand
 	    semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL);
 	s.fcfilepath = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_HOMEDIRS);
 
+	s.fallback_user = strdup(FALLBACK_USER);
+	s.fallback_user_prefix = strdup(FALLBACK_USER_PREFIX);
+	if (s.fallback_user == NULL || s.fallback_user_prefix == NULL)
+		return STATUS_ERR;
+
 	s.usepasswd = usepasswd;
 	s.h_semanage = sh;
 	s.policydb = policydb;
@@ -797,5 +853,9 @@ int semanage_genhomedircon(semanage_hand
 	retval = write_context_file(&s, out);
 
 	fclose(out);
+
+	free(s.fallback_user);
+	free(s.fallback_user_prefix);
+
 	return retval;
 }

-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
