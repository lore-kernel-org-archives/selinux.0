Date: Fri, 28 Sep 2007 14:04:12 -0400
Message-Id: <200709281804.l8SI4Cuj031486@cadmus.columbia.tresys.com>
From: "Todd C. Miller" <tmiller@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [patch 0/4] libsemanage: genhomedircon regressions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Yes you are right.
>
> The problem is we need to find the failsafe account before writing the
> general account.
> 
> How about this patch.

There is some missing frees in there and I don't think we really
need to get the full users list.  I would write it like this.

 - todd

Index: libsemanage/src/genhomedircon.c
===================================================================
--- libsemanage/src/genhomedircon.c	(revision 2624)
+++ libsemanage/src/genhomedircon.c	(working copy)
@@ -575,6 +575,57 @@
 	return STATUS_SUCCESS;
 }
 
+static int setup_fallback_user(genhomedircon_settings_t * s)
+{
+	semanage_seuser_t **seuser_list = NULL;
+	unsigned int nseusers = 0;
+	semanage_user_key_t *key = NULL;
+	semanage_user_t *u = NULL;
+	const char *name = NULL;
+	const char *seuname = NULL;
+	const char *prefix = NULL;
+	unsigned int i;
+	int retval;
+	int errors = 0;
+
+	retval = semanage_seuser_list(s->h_semanage, &seuser_list, &nseusers);
+	if (retval < 0 || (nseusers < 1)) {
+		/* if there are no users, this function can't do any other work */
+		return errors;
+	}
+
+	for (i = 0; i < nseusers; i++) {
+		name = semanage_seuser_get_name(seuser_list[i]);
+		if (strcmp(name, DEFAULT_LOGIN) == 0) {
+			seuname = semanage_seuser_get_sename(seuser_list[i]);
+
+			/* find the user structure given the name */
+			if (semanage_user_key_create(s->h_semanage, seuname,
+						     &key) < 0) {
+				errors = STATUS_ERR;
+				break;
+			}
+			if (semanage_user_query(s->h_semanage, key, &u) < 0)
+				prefix = name;
+			else
+				prefix = semanage_user_get_prefix(u);
+
+			if (set_fallback_user(s, seuname, prefix) != 0)
+				errors = STATUS_ERR;
+			semanage_user_key_free(key);
+			if (u)
+				semanage_user_free(u);
+			break;
+		}
+	}
+
+	for (i = 0; i < nseusers; i++)
+		semanage_seuser_free(seuser_list[i]);
+	free(seuser_list);
+
+	return errors;
+}
+
 static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 					     int *errors)
 {
@@ -616,30 +667,6 @@
 		goto cleanup;
 
 	for (i = 0; i < nseusers; i++) {
-		name = semanage_seuser_get_name(seuser_list[i]);
-		if (strcmp(name, DEFAULT_LOGIN) == 0) {
-			seuname = semanage_seuser_get_sename(seuser_list[i]);
-
-			/* find the user structure given the name */
-			u = bsearch(seuname, user_list, nusers,
-				    sizeof(semanage_user_t *),
-				    (int (*)(const void *, const void *))
-				    &name_user_cmp);
-			if (u) {
-				prefix = semanage_user_get_prefix(*u);
-			} else {
-				prefix = name;
-			}
-
-			if (set_fallback_user(s, seuname, prefix) != 0) {
-				*errors = STATUS_ERR;
-				goto cleanup;
-			}
-			break;
-		}
-	}
-
-	for (i = 0; i < nseusers; i++) {
 		seuname = semanage_seuser_get_sename(seuser_list[i]);
 
 		if (strcmp(seuname, s->fallback_user) == 0)
@@ -769,12 +796,10 @@
 		goto done;
 	}
 
-	if (write_gen_home_dir_context(s, out, user_context_tpl,
-				       homedir_context_tpl) != STATUS_SUCCESS) {
+	if (setup_fallback_user(s) != 0) {
 		retval = STATUS_ERR;
 		goto done;
 	}
-
 	for (h = homedirs; h; h = h->next) {
 		Ustr *temp = ustr_dup_cstr(h->data);
 
@@ -811,6 +836,11 @@
 		goto done;
 	}
 
+	if (write_gen_home_dir_context(s, out, user_context_tpl,
+				       homedir_context_tpl) != STATUS_SUCCESS) {
+		retval = STATUS_ERR;
+	}
+
       done:
 	/* Cleanup */
 	semanage_list_destroy(&homedirs);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
