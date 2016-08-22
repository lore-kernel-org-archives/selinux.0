Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7MKQiam013026
 for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2016 16:26:45 -0400
Received: from home ([79.71.36.116]) by mail.gmx.com (mrgmx003) with ESMTPA
 (Nemesis) id 0MCtut-1bSKxZ3aZn-009gGo for <selinux@tycho.nsa.gov>; Mon, 22
 Aug 2016 22:23:11 +0200
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] genhomedircon: add support for %group syntax
Date: Mon, 22 Aug 2016 21:23:01 +0100
Message-Id: <1471897381-21216-3-git-send-email-gary.tierney@gmx.com>
In-Reply-To: <1471897381-21216-1-git-send-email-gary.tierney@gmx.com>
References: <1471897381-21216-1-git-send-email-gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Gary Tierney <selinux@tycho.nsa.gov>

semanage-login supports login mappings using the %group syntax, but
genhomedircon does not expand groups to the users belonging to them.

This commit adds support for generating home directory contexts for login
mappings using the group syntax and adds error reporting for handling cases
where there is ambiguity due to a user belonging to multiple groups mapped by
semanage-login. If a login mapping is added for the user which belongs to
multiple groups it will take precedence and resolve the ambiguity issue.

Signed-off-by: Gary Tierney <selinux@tycho.nsa.gov>
---
 libsemanage/src/genhomedircon.c | 311 +++++++++++++++++++++++++++++++---------
 1 file changed, 243 insertions(+), 68 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 698b907..cce3884 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -48,6 +48,8 @@
 #include <errno.h>
 #include <unistd.h>
 #include <regex.h>
+#include <grp.h>
+#include <search.h>
 
 /* paths used in get_home_dirs() */
 #define PATH_ETC_USERADD "/etc/default/useradd"
@@ -98,6 +100,7 @@ typedef struct user_entry {
 	char *prefix;
 	char *home;
 	char *level;
+	char *login;
 	struct user_entry *next;
 } genhomedircon_user_entry_t;
 
@@ -486,6 +489,11 @@ static int USER_CONTEXT_PRED(const char *string)
 	return (int)(strstr(string, TEMPLATE_USER) != NULL);
 }
 
+static int STR_COMPARATOR(const void *a, const void *b)
+{
+	return strcmp((const char *) a, (const char *) b);
+}
+
 /* make_tempate
  * @param	s	  the settings holding the paths to various files
  * @param	pred	function pointer to function to use as filter for slurp
@@ -652,6 +660,24 @@ static int write_user_context(genhomedircon_settings_t * s, FILE * out,
 	return write_replacements(s, out, tpl, repl);
 }
 
+static int seuser_sort_func(const void *arg1, const void *arg2)
+{
+	const semanage_seuser_t **u1 = (const semanage_seuser_t **) arg1;
+	const semanage_seuser_t **u2 = (const semanage_seuser_t **) arg2;;
+	const char *name1 = semanage_seuser_get_name(*u1);
+	const char *name2 = semanage_seuser_get_name(*u2);
+
+	if (name1[0] == '%' && name2[0] == '%') {
+		return 0;
+	} else if (name1[0] == '%') {
+		return 1;
+	} else if (name2[0] == '%') {
+		return -1;
+	}
+
+	return strcmp(name1, name2);
+}
+
 static int user_sort_func(semanage_user_t ** arg1, semanage_user_t ** arg2)
 {
 	return strcmp(semanage_user_get_name(*arg1),
@@ -665,7 +691,8 @@ static int name_user_cmp(char *key, semanage_user_t ** val)
 
 static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 			   const char *u, const char *g, const char *sen,
-			   const char *pre, const char *h, const char *l)
+			   const char *pre, const char *h, const char *l,
+			   const char *ln)
 {
 	genhomedircon_user_entry_t *temp = NULL;
 	char *name = NULL;
@@ -675,6 +702,7 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 	char *prefix = NULL;
 	char *home = NULL;
 	char *level = NULL;
+	char *lname = NULL;
 
 	temp = malloc(sizeof(genhomedircon_user_entry_t));
 	if (!temp)
@@ -700,6 +728,9 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 	level = strdup(l);
 	if (!level)
 		goto cleanup;
+	lname = strdup(ln);
+	if (!lname)
+		goto cleanup;
 
 	temp->name = name;
 	temp->uid = uid;
@@ -708,6 +739,7 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 	temp->prefix = prefix;
 	temp->home = home;
 	temp->level = level;
+	temp->login = lname;
 	temp->next = (*list);
 	(*list) = temp;
 
@@ -721,6 +753,7 @@ static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
 	free(prefix);
 	free(home);
 	free(level);
+	free(lname);
 	free(temp);
 	return STATUS_ERR;
 }
@@ -741,6 +774,7 @@ static void pop_user_entry(genhomedircon_user_entry_t ** list)
 	free(temp->prefix);
 	free(temp->home);
 	free(temp->level);
+	free(temp->login);
 	free(temp);
 }
 
@@ -790,7 +824,8 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
 
 			if (push_user_entry(&(s->fallback), FALLBACK_NAME,
 					    FALLBACK_UIDGID, FALLBACK_UIDGID,
-					    seuname, prefix, "", level) != 0)
+					    seuname, prefix, "", level,
+					    FALLBACK_NAME) != 0)
 				errors = STATUS_ERR;
 			semanage_user_key_free(key);
 			if (u)
@@ -806,6 +841,202 @@ static int setup_fallback_user(genhomedircon_settings_t * s)
 	return errors;
 }
 
+static genhomedircon_user_entry_t *find_user(genhomedircon_user_entry_t *head,
+					     const char *name)
+{
+	for(; head; head = head->next) {
+		if (strcmp(head->name, name) == 0) {
+			return head;
+		}
+	}
+
+	return NULL;
+}
+
+static int add_user(genhomedircon_settings_t * s,
+		    genhomedircon_user_entry_t **head,
+		    semanage_user_t *user,
+		    const char *name,
+		    const char *sename,
+		    const char *selogin)
+{
+	if (selogin[0] == '%') {
+		genhomedircon_user_entry_t *orig = find_user(*head, name);
+		if (orig != NULL && orig->login[0] == '%') {
+			ERR(s->h_semanage, "User %s is already mapped to"
+			    " group %s, but also belongs to group %s. Add an"
+			    " explicit mapping for this user to"
+			    " override group mappings.",
+			    name, orig->login + 1, selogin + 1);
+			return STATUS_ERR;
+		} else if (orig != NULL) {
+			// user mappings take precedence
+			return STATUS_SUCCESS;
+		}
+	}
+
+	int retval = STATUS_ERR;
+
+	char *rbuf = NULL;
+	long rbuflen;
+	struct passwd pwstorage, *pwent = NULL;
+	const char *prefix = NULL;
+	const char *level = NULL;
+	char uid[11];
+	char gid[11];
+
+	/* Allocate space for the getpwnam_r buffer */
+	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (rbuflen <= 0)
+		goto cleanup;
+	rbuf = malloc(rbuflen);
+	if (rbuf == NULL)
+		goto cleanup;
+
+	if (user) {
+		prefix = semanage_user_get_prefix(user);
+		level = semanage_user_get_mlslevel(user);
+
+		if (!level) {
+			level = FALLBACK_LEVEL;
+		}
+	} else {
+		prefix = name;
+		level = FALLBACK_LEVEL;
+	}
+
+	retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
+	if (retval != 0 || pwent == NULL) {
+		if (retval != 0 && retval != ENOENT) {
+			goto cleanup;
+		}
+
+		WARN(s->h_semanage,
+		     "user %s not in password file", name);
+		retval = STATUS_SUCCESS;
+		goto cleanup;
+	}
+
+	int len = strlen(pwent->pw_dir) -1;
+	for(; len > 0 && pwent->pw_dir[len] == '/'; len--) {
+		pwent->pw_dir[len] = '\0';
+	}
+
+	if (strcmp(pwent->pw_dir, "/") == 0) {
+		/* don't relabel / genhomdircon checked to see if root
+		 * was the user and if so, set his home directory to
+		 * /root */
+		retval = STATUS_SUCCESS;
+		goto cleanup;
+	}
+
+	if (ignore(pwent->pw_dir)) {
+		retval = STATUS_SUCCESS;
+		goto cleanup;
+	}
+
+	len = snprintf(uid, sizeof(uid), "%u", pwent->pw_uid);
+	if (len < 0 || len >= (int)sizeof(uid)) {
+		goto cleanup;
+	}
+
+	len = snprintf(gid, sizeof(gid), "%u", pwent->pw_gid);
+	if (len < 0 || len >= (int)sizeof(gid)) {
+		goto cleanup;
+	}
+
+	retval = push_user_entry(head, name, uid, gid, sename, prefix,
+				pwent->pw_dir, level, selogin);
+cleanup:
+	free(rbuf);
+	return retval;
+}
+
+static int get_group_users(genhomedircon_settings_t * s,
+			  genhomedircon_user_entry_t **head,
+			  semanage_user_t *user,
+			  const char *sename,
+			  const char *selogin)
+{
+	int retval = STATUS_ERR;
+	unsigned int i;
+
+	long grbuflen;
+	char *grbuf = NULL;
+	struct group grstorage, *group = NULL;
+
+	long prbuflen;
+	char *pwbuf = NULL;
+	struct passwd pwstorage, *pw = NULL;
+
+	grbuflen = sysconf(_SC_GETGR_R_SIZE_MAX);
+	if (grbuflen <= 0)
+		goto cleanup;
+	grbuf = malloc(grbuflen);
+	if (grbuf == NULL)
+		goto cleanup;
+
+	const char *grname = selogin + 1;
+
+	if (getgrnam_r(grname, &grstorage, grbuf,
+			(size_t) grbuflen, &group) != 0) {
+		goto cleanup;
+	}
+
+	if (group == NULL) {
+		ERR(s->h_semanage, "Can't find group named %s\n", grname);
+		goto cleanup;
+	}
+
+	size_t nmembers = 0;
+	char **members = group->gr_mem;
+
+	while (*members != NULL) {
+		nmembers++;
+		members++;
+	}
+
+	for (i = 0; i < nmembers; i++) {
+		const char *uname = group->gr_mem[i];
+
+		if (add_user(s, head, user, uname, sename, selogin) < 0) {
+			goto cleanup;
+		}
+	}
+
+	prbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (prbuflen <= 0)
+		goto cleanup;
+	pwbuf = malloc(prbuflen);
+	if (pwbuf == NULL)
+		goto cleanup;
+
+	setpwent();
+	while ((retval = getpwent_r(&pwstorage, pwbuf, prbuflen, &pw)) == 0) {
+		// skip users who also have this group as their
+		// primary group
+		if (lfind(pw->pw_name, group->gr_mem, &nmembers,
+			  sizeof(char *), &STR_COMPARATOR)) {
+			continue;
+		}
+
+		if (group->gr_gid == pw->pw_gid) {
+			if (add_user(s, head, user, pw->pw_name,
+				     sename, selogin) < 0) {
+				goto cleanup;
+			}
+		}
+	}
+
+	retval = STATUS_SUCCESS;
+cleanup:
+	endpwent();
+	free(pwbuf);
+	free(grbuf);
+
+	return retval;
+}
+
 static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 					     int *errors)
 {
@@ -817,14 +1048,7 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 	semanage_user_t **u = NULL;
 	const char *name = NULL;
 	const char *seuname = NULL;
-	const char *prefix = NULL;
-	const char *level = NULL;
-	char uid[11];
-	char gid[11];
-	struct passwd pwstorage, *pwent = NULL;
 	unsigned int i;
-	long rbuflen;
-	char *rbuf = NULL;
 	int retval;
 
 	*errors = 0;
@@ -838,17 +1062,11 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 		nusers = 0;
 	}
 
+	qsort(seuser_list, nseusers, sizeof(semanage_seuser_t *),
+	      &seuser_sort_func);
 	qsort(user_list, nusers, sizeof(semanage_user_t *),
 	      (int (*)(const void *, const void *))&user_sort_func);
 
-	/* Allocate space for the getpwnam_r buffer */
-	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
-	if (rbuflen <= 0)
-		goto cleanup;
-	rbuf = malloc(rbuflen);
-	if (rbuf == NULL)
-		goto cleanup;
-
 	for (i = 0; i < nseusers; i++) {
 		seuname = semanage_seuser_get_sename(seuser_list[i]);
 		name = semanage_seuser_get_name(seuser_list[i]);
@@ -859,70 +1077,27 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 		if (strcmp(name, TEMPLATE_SEUSER) == 0)
 			continue;
 
-		/* %groupname syntax */
-		if (name[0] == '%')
-			continue;
-
 		/* find the user structure given the name */
 		u = bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *),
 			    (int (*)(const void *, const void *))
 			    &name_user_cmp);
-		if (u) {
-			prefix = semanage_user_get_prefix(*u);
-			level = semanage_user_get_mlslevel(*u);
-			if (!level)
-				level = FALLBACK_LEVEL;
-		} else {
-			prefix = name;
-			level = FALLBACK_LEVEL;
-		}
-
-		retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-		if (retval != 0 || pwent == NULL) {
-			if (retval != 0 && retval != ENOENT) {
-				*errors = STATUS_ERR;
-				goto cleanup;
-			}
-
-			WARN(s->h_semanage,
-			     "user %s not in password file", name);
-			continue;
-		}
 
-		int len = strlen(pwent->pw_dir) -1;
-		for(; len > 0 && pwent->pw_dir[len] == '/'; len--) {
-			pwent->pw_dir[len] = '\0';
+		/* %groupname syntax */
+		if (name[0] == '%') {
+			retval = get_group_users(s, &head, *u, seuname,
+						name);
+		} else {
+			retval = add_user(s, &head, *u, name,
+					  seuname, name);
 		}
 
-		if (strcmp(pwent->pw_dir, "/") == 0) {
-			/* don't relabel / genhomdircon checked to see if root
-			 * was the user and if so, set his home directory to
-			 * /root */
-			continue;
-		}
-		if (ignore(pwent->pw_dir))
-			continue;
-
-		len = snprintf(uid, sizeof(uid), "%u", pwent->pw_uid);
-		if (len < 0 || len >= (int)sizeof(uid)) {
+		if (retval != 0) {
 			*errors = STATUS_ERR;
 			goto cleanup;
 		}
-		len = snprintf(gid, sizeof(gid), "%u", pwent->pw_gid);
-		if (len < 0 || len >= (int)sizeof(gid)) {
-			*errors = STATUS_ERR;
-			goto cleanup;
-		}
-
-		if (push_user_entry(&head, name, uid, gid, seuname,
-				    prefix, pwent->pw_dir, level) != STATUS_SUCCESS) {
-			*errors = STATUS_ERR;
-			break;
-		}
 	}
 
       cleanup:
-	free(rbuf);
 	if (*errors) {
 		for (; head; pop_user_entry(&head)) {
 			/* the pop function takes care of all the cleanup
-- 
2.7.4
