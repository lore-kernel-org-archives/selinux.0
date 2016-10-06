Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u96BA01s027130
 for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2016 07:10:00 -0400
Received: from workstation.fluency.net.uk ([185.34.9.224]) by mail.gmx.com
 (mrgmx103) with ESMTPSA (Nemesis) id 0LsD9n-1atWKg08ml-013tmT for
 <selinux@tycho.nsa.gov>; Thu, 06 Oct 2016 13:09:57 +0200
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 1/1] genhomedircon: use userprefix as the role for homedir
 content
Date: Thu,  6 Oct 2016 12:09:41 +0100
Message-Id: <638048b6d79a18861e58155ca14012706af5b445.1475590141.git.gary.tierney@gmx.com>
In-Reply-To: <cover.1475590141.git.gary.tierney@gmx.com>
References: <cover.1475590141.git.gary.tierney@gmx.com>
In-Reply-To: <cover.1475590141.git.gary.tierney@gmx.com>
References: <cover.1475590141.git.gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Treat a users prefix like a mapping to the role for file context
specifications in users homedirs.  This behavior is only applicable when
the users prefix is the identifier of a role which is valid for the
given user.  If the prefix is not a valid role, then genhomedircon will
write contexts out as normal.

Additionally, this commit enables configuring RBACSEP in policy:

(tunableif enable_rbacsep
    (true
        (userprefix user_u user_r)
    (false
        (userprefix user_u object_r))))

Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
---
 libsemanage/src/genhomedircon.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 3fc9e7a..0dd2b29 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -100,6 +100,7 @@ typedef struct user_entry {
 	char *home;
 	char *level;
 	char *login;
+	char *homedir_role;
 	struct user_entry *next;
 } genhomedircon_user_entry_t;
 
@@ -177,6 +178,13 @@ static int ignore(const char *homedir) {
 	return 0;
 }
 
+static int prefix_is_homedir_role(const semanage_user_t *user,
+				  const char *prefix)
+{
+	return strcmp(OBJECT_R, prefix) == 0 ||
+		semanage_user_has_role(user, prefix);
+}
+
 static semanage_list_t *default_shell_list(void)
 {
 	semanage_list_t *list = NULL;
@@ -638,6 +646,11 @@ static int write_contexts(genhomedircon_settings_t *s, FILE *out,
 			goto fail;
 		}
 
+		if (user->homedir_role &&
+		    sepol_context_set_role(sepolh, context, user->homedir_role) < 0) {
+			goto fail;
+		}
+
 		if (sepol_context_to_string(sepolh, context,
 					    &new_context_str) < 0) {
 			goto fail;
@@ -756,7 +769,7 @@ static int name_user_cmp(char *key, semanage_user_t ** val)
 static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 			   const char *u, const char *g, const char *sen,
 			   const char *pre, const char *h, const char *l,
-			   const char *ln)
+			   const char *ln, const char *hd_role)
 {
 	genhomedircon_user_entry_t *temp = NULL;
 	char *name = NULL;
@@ -767,6 +780,7 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 	char *home = NULL;
 	char *level = NULL;
 	char *lname = NULL;
+	char *homedir_role = NULL;
 
 	temp = malloc(sizeof(genhomedircon_user_entry_t));
 	if (!temp)
@@ -795,6 +809,11 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 	lname = strdup(ln);
 	if (!lname)
 		goto cleanup;
+	if (hd_role) {
+		homedir_role = strdup(hd_role);
+		if (!homedir_role)
+			goto cleanup;
+	}
 
 	temp->name = name;
 	temp->uid = uid;
@@ -804,6 +823,7 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 	temp->home = home;
 	temp->level = level;
 	temp->login = lname;
+	temp->homedir_role = homedir_role;
 	temp->next = (*list);
 	(*list) = temp;
 
@@ -818,6 +838,7 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 	free(home);
 	free(level);
 	free(lname);
+	free(homedir_role);
 	free(temp);
 	return STATUS_ERR;
 }
@@ -839,6 +860,7 @@ static void pop_user_entry(genhomedircon_user_entry_t ** list)
 	free(temp->home);
 	free(temp->level);
 	free(temp->login);
+	free(temp->homedir_role);
 	free(temp);
 }
 
@@ -852,6 +874,7 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
 	const char *seuname = NULL;
 	const char *prefix = NULL;
 	const char *level = NULL;
+	const char *homedir_role = NULL;
 	unsigned int i;
 	int retval;
 	int errors = 0;
@@ -886,10 +909,14 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
 					level = FALLBACK_LEVEL;
 			}
 
+			if (prefix_is_homedir_role(u, prefix)) {
+				homedir_role = prefix;
+			}
+
 			if (push_user_entry(&(s->fallback), FALLBACK_NAME,
 					    FALLBACK_UIDGID, FALLBACK_UIDGID,
 					    seuname, prefix, "", level,
-					    FALLBACK_NAME) != 0)
+					    FALLBACK_NAME, homedir_role) != 0)
 				errors = STATUS_ERR;
 			semanage_user_key_free(key);
 			if (u)
@@ -946,6 +973,7 @@ static int add_user(genhomedircon_settings_t * s,
 	struct passwd pwstorage, *pwent = NULL;
 	const char *prefix = NULL;
 	const char *level = NULL;
+	const char *homedir_role = NULL;
 	char uid[11];
 	char gid[11];
 
@@ -969,6 +997,10 @@ static int add_user(genhomedircon_settings_t * s,
 		level = FALLBACK_LEVEL;
 	}
 
+	if (prefix_is_homedir_role(user, prefix)) {
+		homedir_role = prefix;
+	}
+
 	retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
 	if (retval != 0 || pwent == NULL) {
 		if (retval != 0 && retval != ENOENT) {
@@ -1010,7 +1042,7 @@ static int add_user(genhomedircon_settings_t * s,
 	}
 
 	retval = push_user_entry(head, name, uid, gid, sename, prefix,
-				pwent->pw_dir, level, selogin);
+				pwent->pw_dir, level, selogin, homedir_role);
 cleanup:
 	free(rbuf);
 	return retval;
-- 
2.4.11
