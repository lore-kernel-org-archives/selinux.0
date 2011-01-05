Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p058UZvD015726
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2011 03:30:35 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p058UXmN012295
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2011 08:30:34 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E56241800D
	for <selinux@tycho.nsa.gov>; Wed,  5 Jan 2011 19:30:17 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: libsemanage patch for MCS/MLS in user files
Date: Wed, 5 Jan 2011 19:30:25 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iwCJNbwVzfMXE8j"
Message-Id: <201101051930.26082.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_iwCJNbwVzfMXE8j
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

The attached patch makes the 
/etc/selinux/default/contexts/files/file_contexts.homedirs generation process 
include the MCS/MLS level.

This means that if you have a user with a MCS/MLS level that isn't SystemLow 
then their home directory will be labeled such that they can have read/write 
access to it by default.

Unless anyone has any better ideas for how to solve this problem I will upload 
this to Debian shortly.

What do the MLS users do in this situation?  Just relabel home directories 
manually?


Finally it seems that when you run "semanage user -m" the 
file_contexts.homedirs doesn't get updated, it's only when you run
"semanage login -m" that it takes affect.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--Boundary-00=_iwCJNbwVzfMXE8j
Content-Type: text/x-patch;
  charset="UTF-8";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru libsemanage-2.0.46.old/src/genhomedircon.c libsemanage-2.0.46/src/genhomedircon.c
--- libsemanage-2.0.46.old/src/genhomedircon.c	2011-01-05 19:08:30.502502240 +1100
+++ libsemanage-2.0.46/src/genhomedircon.c	2011-01-05 19:11:15.390455592 +1100
@@ -76,9 +76,11 @@
 #define TEMPLATE_USER "USER"
 #define TEMPLATE_ROLE "ROLE"
 #define TEMPLATE_SEUSER "system_u"
+#define TEMPLATE_LEVEL "s0"
 
 #define FALLBACK_USER "user_u"
 #define FALLBACK_USER_PREFIX "user"
+#define FALLBACK_USER_LEVEL "s0"
 #define DEFAULT_LOGIN "__default__"
 
 typedef struct {
@@ -87,6 +89,7 @@
 	const char *homedir_template_path;
 	char *fallback_user;
 	char *fallback_user_prefix;
+	char *fallback_user_level;
 	semanage_handle_t *h_semanage;
 	sepol_policydb_t *policydb;
 } genhomedircon_settings_t;
@@ -96,6 +99,7 @@
 	char *sename;
 	char *prefix;
 	char *home;
+	char *level;
 	struct user_entry *next;
 } genhomedircon_user_entry_t;
 
@@ -502,12 +506,13 @@
 static int write_home_dir_context(genhomedircon_settings_t * s, FILE * out,
 				  semanage_list_t * tpl, const char *user,
 				  const char *seuser, const char *home,
-				  const char *role_prefix)
+				  const char *role_prefix, const char *level)
 {
 	replacement_pair_t repl[] = {
 		{.search_for = TEMPLATE_SEUSER,.replace_with = seuser},
 		{.search_for = TEMPLATE_HOME_DIR,.replace_with = home},
 		{.search_for = TEMPLATE_ROLE,.replace_with = role_prefix},
+		{.search_for = TEMPLATE_LEVEL,.replace_with = level},
 		{NULL, NULL}
 	};
 	Ustr *line = USTR_NULL;
@@ -599,13 +604,15 @@
 }
 
 static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
-			   const char *sen, const char *pre, const char *h)
+			   const char *sen, const char *pre, const char *h,
+			   const char *l)
 {
 	genhomedircon_user_entry_t *temp = NULL;
 	char *name = NULL;
 	char *sename = NULL;
 	char *prefix = NULL;
 	char *home = NULL;
+	char *level = NULL;
 
 	temp = malloc(sizeof(genhomedircon_user_entry_t));
 	if (!temp)
@@ -622,11 +629,15 @@
 	home = strdup(h);
 	if (!home)
 		goto cleanup;
+	level = strdup(l);
+	if (!level)
+		goto cleanup;
 
 	temp->name = name;
 	temp->sename = sename;
 	temp->prefix = prefix;
 	temp->home = home;
+	temp->level = level;
 	temp->next = (*list);
 	(*list) = temp;
 
@@ -637,6 +648,7 @@
 	free(sename);
 	free(prefix);
 	free(home);
+	free(level);
 	free(temp);
 	return STATUS_ERR;
 }
@@ -654,25 +666,30 @@
 	free(temp->sename);
 	free(temp->prefix);
 	free(temp->home);
+	free(temp->level);
 	free(temp);
 }
 
-static int set_fallback_user(genhomedircon_settings_t *s,
-			     const char *user, const char *prefix)
+static int set_fallback_user(genhomedircon_settings_t *s, const char *user,
+			     const char *prefix, const char *level)
 {
 	char *fallback_user = strdup(user);
 	char *fallback_user_prefix = strdup(prefix);
+	char *fallback_user_level = strdup(level);
 
-	if (fallback_user == NULL || fallback_user_prefix == NULL) {
+	if (fallback_user == NULL || fallback_user_prefix == NULL || fallback_user_level == NULL) {
 		free(fallback_user);
 		free(fallback_user_prefix);
+		free(fallback_user_level);
 		return STATUS_ERR;
 	}
 
 	free(s->fallback_user);
 	free(s->fallback_user_prefix);
+	free(s->fallback_user_level);
 	s->fallback_user = fallback_user;
 	s->fallback_user_prefix = fallback_user_prefix;
+	s->fallback_user_level = fallback_user_level;
 	return STATUS_SUCCESS;
 }
 
@@ -681,10 +698,11 @@
 	semanage_seuser_t **seuser_list = NULL;
 	unsigned int nseusers = 0;
 	semanage_user_key_t *key = NULL;
-	semanage_user_t *u = NULL;
+	semanage_user_t *the_user = NULL;
 	const char *name = NULL;
 	const char *seuname = NULL;
 	const char *prefix = NULL;
+	const char *level = NULL;
 	unsigned int i;
 	int retval;
 	int errors = 0;
@@ -706,16 +724,22 @@
 				errors = STATUS_ERR;
 				break;
 			}
-			if (semanage_user_query(s->h_semanage, key, &u) < 0)
+			if (semanage_user_query(s->h_semanage, key, &the_user) < 0)
+			{
 				prefix = name;
+				level = "s0";
+			}
 			else
-				prefix = semanage_user_get_prefix(u);
+			{
+				prefix = semanage_user_get_prefix(the_user);
+				level = semanage_user_get_mlslevel(the_user);
+			}
 
-			if (set_fallback_user(s, seuname, prefix) != 0)
+			if (set_fallback_user(s, seuname, prefix, level) != 0)
 				errors = STATUS_ERR;
 			semanage_user_key_free(key);
-			if (u)
-				semanage_user_free(u);
+			if (the_user)
+				semanage_user_free(the_user);
 			break;
 		}
 	}
@@ -739,6 +763,7 @@
 	const char *name = NULL;
 	const char *seuname = NULL;
 	const char *prefix = NULL;
+	const char *level = NULL;
 	struct passwd pwstorage, *pwent = NULL;
 	unsigned int i;
 	long rbuflen;
@@ -790,8 +815,10 @@
 			    &name_user_cmp);
 		if (u) {
 			prefix = semanage_user_get_prefix(*u);
+			level = semanage_user_get_mlslevel(*u);
 		} else {
 			prefix = name;
+			level = "s0";
 		}
 
 		retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
@@ -818,7 +845,7 @@
 			continue;
 		}
 		if (push_user_entry(&head, name, seuname,
-				    prefix, pwent->pw_dir) != STATUS_SUCCESS) {
+				    prefix, pwent->pw_dir, level) != STATUS_SUCCESS) {
 			*errors = STATUS_ERR;
 			break;
 		}
@@ -861,7 +888,7 @@
 		if (write_home_dir_context(s, out, homedir_context_tpl,
 					   users->name,
 					   users->sename, users->home,
-					   users->prefix)) {
+					   users->prefix, users->level)) {
 			return STATUS_ERR;
 		}
 		if (write_user_context(s, out, user_context_tpl, users->name,
@@ -925,7 +952,7 @@
 						   homedir_context_tpl,
 						   s->fallback_user, s->fallback_user,
 						   ustr_cstr(temp),
-						   s->fallback_user_prefix) !=
+						   s->fallback_user_prefix, s->fallback_user_level) !=
 			    STATUS_SUCCESS) {
 				ustr_sc_free(&temp);
 				retval = STATUS_ERR;
@@ -982,7 +1009,8 @@
 
 	s.fallback_user = strdup(FALLBACK_USER);
 	s.fallback_user_prefix = strdup(FALLBACK_USER_PREFIX);
-	if (s.fallback_user == NULL || s.fallback_user_prefix == NULL)
+	s.fallback_user_level = strdup(FALLBACK_USER_LEVEL);
+	if (s.fallback_user == NULL || s.fallback_user_prefix == NULL || s.fallback_user_level == NULL)
 		return STATUS_ERR;
 
 	s.usepasswd = usepasswd;

--Boundary-00=_iwCJNbwVzfMXE8j--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
