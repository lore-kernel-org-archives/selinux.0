Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7MKvIEr018478
 for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2016 16:57:18 -0400
Received: from home ([79.71.36.116]) by mail.gmx.com (mrgmx002) with ESMTPSA
 (Nemesis) id 0MNYxW-1bUoTY1YAk-007FAl for <selinux@tycho.nsa.gov>; Mon, 22
 Aug 2016 22:57:14 +0200
Date: Mon, 22 Aug 2016 21:57:08 +0100
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] genhomedircon: add support for %group syntax
Message-ID: <20160822205707.GA21683@home>
References: <1471897381-21216-1-git-send-email-gary.tierney@gmx.com>
 <1471897381-21216-3-git-send-email-gary.tierney@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
In-Reply-To: <1471897381-21216-3-git-send-email-gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2016 at 09:23:01PM +0100, Gary Tierney wrote:
>From: Gary Tierney <selinux@tycho.nsa.gov>
>
>semanage-login supports login mappings using the %group syntax, but
>genhomedircon does not expand groups to the users belonging to them.
>
>This commit adds support for generating home directory contexts for login
>mappings using the group syntax and adds error reporting for handling cases
>where there is ambiguity due to a user belonging to multiple groups mapped=
 by
>semanage-login. If a login mapping is added for the user which belongs to
>multiple groups it will take precedence and resolve the ambiguity issue.
>
>Signed-off-by: Gary Tierney <selinux@tycho.nsa.gov>
>---
> libsemanage/src/genhomedircon.c | 311 +++++++++++++++++++++++++++++++----=
-----
> 1 file changed, 243 insertions(+), 68 deletions(-)
>
>diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedirc=
on.c
>index 698b907..cce3884 100644
>--- a/libsemanage/src/genhomedircon.c
>+++ b/libsemanage/src/genhomedircon.c
>@@ -48,6 +48,8 @@
> #include <errno.h>
> #include <unistd.h>
> #include <regex.h>
>+#include <grp.h>
>+#include <search.h>
>
> /* paths used in get_home_dirs() */
> #define PATH_ETC_USERADD "/etc/default/useradd"
>@@ -98,6 +100,7 @@ typedef struct user_entry {
> 	char *prefix;
> 	char *home;
> 	char *level;
>+	char *login;
> 	struct user_entry *next;
> } genhomedircon_user_entry_t;
>
>@@ -486,6 +489,11 @@ static int USER_CONTEXT_PRED(const char *string)
> 	return (int)(strstr(string, TEMPLATE_USER) !=3D NULL);
> }
>
>+static int STR_COMPARATOR(const void *a, const void *b)
>+{
>+	return strcmp((const char *) a, (const char *) b);
>+}
>+
> /* make_tempate
>  * @param	s	  the settings holding the paths to various files
>  * @param	pred	function pointer to function to use as filter for slurp
>@@ -652,6 +660,24 @@ static int write_user_context(genhomedircon_settings_=
t * s, FILE * out,
> 	return write_replacements(s, out, tpl, repl);
> }
>
>+static int seuser_sort_func(const void *arg1, const void *arg2)
>+{
>+	const semanage_seuser_t **u1 =3D (const semanage_seuser_t **) arg1;
>+	const semanage_seuser_t **u2 =3D (const semanage_seuser_t **) arg2;;
>+	const char *name1 =3D semanage_seuser_get_name(*u1);
>+	const char *name2 =3D semanage_seuser_get_name(*u2);
>+
>+	if (name1[0] =3D=3D '%' && name2[0] =3D=3D '%') {
>+		return 0;
>+	} else if (name1[0] =3D=3D '%') {
>+		return 1;
>+	} else if (name2[0] =3D=3D '%') {
>+		return -1;
>+	}
>+
>+	return strcmp(name1, name2);
>+}
>+
> static int user_sort_func(semanage_user_t ** arg1, semanage_user_t ** arg=
2)
> {
> 	return strcmp(semanage_user_get_name(*arg1),
>@@ -665,7 +691,8 @@ static int name_user_cmp(char *key, semanage_user_t **=
 val)
>
> static int push_user_entry(genhomedircon_user_entry_t ** list, const char=
 *n,
> 			   const char *u, const char *g, const char *sen,
>-			   const char *pre, const char *h, const char *l)
>+			   const char *pre, const char *h, const char *l,
>+			   const char *ln)
> {
> 	genhomedircon_user_entry_t *temp =3D NULL;
> 	char *name =3D NULL;
>@@ -675,6 +702,7 @@ static int push_user_entry(genhomedircon_user_entry_t =
** list, const char *n,
> 	char *prefix =3D NULL;
> 	char *home =3D NULL;
> 	char *level =3D NULL;
>+	char *lname =3D NULL;
>
> 	temp =3D malloc(sizeof(genhomedircon_user_entry_t));
> 	if (!temp)
>@@ -700,6 +728,9 @@ static int push_user_entry(genhomedircon_user_entry_t =
** list, const char *n,
> 	level =3D strdup(l);
> 	if (!level)
> 		goto cleanup;
>+	lname =3D strdup(ln);
>+	if (!lname)
>+		goto cleanup;
>
> 	temp->name =3D name;
> 	temp->uid =3D uid;
>@@ -708,6 +739,7 @@ static int push_user_entry(genhomedircon_user_entry_t =
** list, const char *n,
> 	temp->prefix =3D prefix;
> 	temp->home =3D home;
> 	temp->level =3D level;
>+	temp->login =3D lname;
> 	temp->next =3D (*list);
> 	(*list) =3D temp;
>
>@@ -721,6 +753,7 @@ static int push_user_entry(genhomedircon_user_entry_t =
** list, const char *n,
> 	free(prefix);
> 	free(home);
> 	free(level);
>+	free(lname);
> 	free(temp);
> 	return STATUS_ERR;
> }
>@@ -741,6 +774,7 @@ static void pop_user_entry(genhomedircon_user_entry_t =
** list)
> 	free(temp->prefix);
> 	free(temp->home);
> 	free(temp->level);
>+	free(temp->login);
> 	free(temp);
> }
>
>@@ -790,7 +824,8 @@ static int setup_fallback_user(genhomedircon_settings_=
t * s)
>
> 			if (push_user_entry(&(s->fallback), FALLBACK_NAME,
> 					    FALLBACK_UIDGID, FALLBACK_UIDGID,
>-					    seuname, prefix, "", level) !=3D 0)
>+					    seuname, prefix, "", level,
>+					    FALLBACK_NAME) !=3D 0)
> 				errors =3D STATUS_ERR;
> 			semanage_user_key_free(key);
> 			if (u)
>@@ -806,6 +841,202 @@ static int setup_fallback_user(genhomedircon_setting=
s_t * s)
> 	return errors;
> }
>
>+static genhomedircon_user_entry_t *find_user(genhomedircon_user_entry_t *=
head,
>+					     const char *name)
>+{
>+	for(; head; head =3D head->next) {
>+		if (strcmp(head->name, name) =3D=3D 0) {
>+			return head;
>+		}
>+	}
>+
>+	return NULL;
>+}
>+
>+static int add_user(genhomedircon_settings_t * s,
>+		    genhomedircon_user_entry_t **head,
>+		    semanage_user_t *user,
>+		    const char *name,
>+		    const char *sename,
>+		    const char *selogin)
>+{
>+	if (selogin[0] =3D=3D '%') {
>+		genhomedircon_user_entry_t *orig =3D find_user(*head, name);
>+		if (orig !=3D NULL && orig->login[0] =3D=3D '%') {
>+			ERR(s->h_semanage, "User %s is already mapped to"
>+			    " group %s, but also belongs to group %s. Add an"
>+			    " explicit mapping for this user to"
>+			    " override group mappings.",
>+			    name, orig->login + 1, selogin + 1);
>+			return STATUS_ERR;
>+		} else if (orig !=3D NULL) {
>+			// user mappings take precedence
>+			return STATUS_SUCCESS;
>+		}
>+	}
>+
>+	int retval =3D STATUS_ERR;
>+
>+	char *rbuf =3D NULL;
>+	long rbuflen;
>+	struct passwd pwstorage, *pwent =3D NULL;
>+	const char *prefix =3D NULL;
>+	const char *level =3D NULL;
>+	char uid[11];
>+	char gid[11];
>+
>+	/* Allocate space for the getpwnam_r buffer */
>+	rbuflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
>+	if (rbuflen <=3D 0)
>+		goto cleanup;
>+	rbuf =3D malloc(rbuflen);
>+	if (rbuf =3D=3D NULL)
>+		goto cleanup;
>+
>+	if (user) {
>+		prefix =3D semanage_user_get_prefix(user);
>+		level =3D semanage_user_get_mlslevel(user);
>+
>+		if (!level) {
>+			level =3D FALLBACK_LEVEL;
>+		}
>+	} else {
>+		prefix =3D name;
>+		level =3D FALLBACK_LEVEL;
>+	}
>+
>+	retval =3D getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
>+	if (retval !=3D 0 || pwent =3D=3D NULL) {
>+		if (retval !=3D 0 && retval !=3D ENOENT) {
>+			goto cleanup;
>+		}
>+
>+		WARN(s->h_semanage,
>+		     "user %s not in password file", name);
>+		retval =3D STATUS_SUCCESS;
>+		goto cleanup;
>+	}
>+
>+	int len =3D strlen(pwent->pw_dir) -1;
>+	for(; len > 0 && pwent->pw_dir[len] =3D=3D '/'; len--) {
>+		pwent->pw_dir[len] =3D '\0';
>+	}
>+
>+	if (strcmp(pwent->pw_dir, "/") =3D=3D 0) {
>+		/* don't relabel / genhomdircon checked to see if root
>+		 * was the user and if so, set his home directory to
>+		 * /root */
>+		retval =3D STATUS_SUCCESS;
>+		goto cleanup;
>+	}
>+
>+	if (ignore(pwent->pw_dir)) {
>+		retval =3D STATUS_SUCCESS;
>+		goto cleanup;
>+	}
>+
>+	len =3D snprintf(uid, sizeof(uid), "%u", pwent->pw_uid);
>+	if (len < 0 || len >=3D (int)sizeof(uid)) {
>+		goto cleanup;
>+	}
>+
>+	len =3D snprintf(gid, sizeof(gid), "%u", pwent->pw_gid);
>+	if (len < 0 || len >=3D (int)sizeof(gid)) {
>+		goto cleanup;
>+	}
>+
>+	retval =3D push_user_entry(head, name, uid, gid, sename, prefix,
>+				pwent->pw_dir, level, selogin);
>+cleanup:
>+	free(rbuf);
>+	return retval;
>+}
>+
>+static int get_group_users(genhomedircon_settings_t * s,
>+			  genhomedircon_user_entry_t **head,
>+			  semanage_user_t *user,
>+			  const char *sename,
>+			  const char *selogin)
>+{
>+	int retval =3D STATUS_ERR;
>+	unsigned int i;
>+
>+	long grbuflen;
>+	char *grbuf =3D NULL;
>+	struct group grstorage, *group =3D NULL;
>+
>+	long prbuflen;
>+	char *pwbuf =3D NULL;
>+	struct passwd pwstorage, *pw =3D NULL;
>+
>+	grbuflen =3D sysconf(_SC_GETGR_R_SIZE_MAX);
>+	if (grbuflen <=3D 0)
>+		goto cleanup;
>+	grbuf =3D malloc(grbuflen);
>+	if (grbuf =3D=3D NULL)
>+		goto cleanup;
>+
>+	const char *grname =3D selogin + 1;
>+
>+	if (getgrnam_r(grname, &grstorage, grbuf,
>+			(size_t) grbuflen, &group) !=3D 0) {
>+		goto cleanup;
>+	}
>+
>+	if (group =3D=3D NULL) {
>+		ERR(s->h_semanage, "Can't find group named %s\n", grname);
>+		goto cleanup;
>+	}
>+
>+	size_t nmembers =3D 0;
>+	char **members =3D group->gr_mem;
>+
>+	while (*members !=3D NULL) {
>+		nmembers++;
>+		members++;
>+	}
>+
>+	for (i =3D 0; i < nmembers; i++) {
>+		const char *uname =3D group->gr_mem[i];
>+
>+		if (add_user(s, head, user, uname, sename, selogin) < 0) {
>+			goto cleanup;
>+		}
>+	}
>+
>+	prbuflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
>+	if (prbuflen <=3D 0)
>+		goto cleanup;
>+	pwbuf =3D malloc(prbuflen);
>+	if (pwbuf =3D=3D NULL)
>+		goto cleanup;
>+
>+	setpwent();
>+	while ((retval =3D getpwent_r(&pwstorage, pwbuf, prbuflen, &pw)) =3D=3D =
0) {
>+		// skip users who also have this group as their
>+		// primary group
>+		if (lfind(pw->pw_name, group->gr_mem, &nmembers,
>+			  sizeof(char *), &STR_COMPARATOR)) {
>+			continue;
>+		}
>+
>+		if (group->gr_gid =3D=3D pw->pw_gid) {
>+			if (add_user(s, head, user, pw->pw_name,
>+				     sename, selogin) < 0) {
>+				goto cleanup;
>+			}
>+		}
>+	}
>+
>+	retval =3D STATUS_SUCCESS;
>+cleanup:
>+	endpwent();
>+	free(pwbuf);
>+	free(grbuf);
>+
>+	return retval;
>+}
>+
> static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
> 					     int *errors)
> {
>@@ -817,14 +1048,7 @@ static genhomedircon_user_entry_t *get_users(genhome=
dircon_settings_t * s,
> 	semanage_user_t **u =3D NULL;
> 	const char *name =3D NULL;
> 	const char *seuname =3D NULL;
>-	const char *prefix =3D NULL;
>-	const char *level =3D NULL;
>-	char uid[11];
>-	char gid[11];
>-	struct passwd pwstorage, *pwent =3D NULL;
> 	unsigned int i;
>-	long rbuflen;
>-	char *rbuf =3D NULL;
> 	int retval;
>
> 	*errors =3D 0;
>@@ -838,17 +1062,11 @@ static genhomedircon_user_entry_t *get_users(genhom=
edircon_settings_t * s,
> 		nusers =3D 0;
> 	}
>
>+	qsort(seuser_list, nseusers, sizeof(semanage_seuser_t *),
>+	      &seuser_sort_func);
> 	qsort(user_list, nusers, sizeof(semanage_user_t *),
> 	      (int (*)(const void *, const void *))&user_sort_func);
>
>-	/* Allocate space for the getpwnam_r buffer */
>-	rbuflen =3D sysconf(_SC_GETPW_R_SIZE_MAX);
>-	if (rbuflen <=3D 0)
>-		goto cleanup;
>-	rbuf =3D malloc(rbuflen);
>-	if (rbuf =3D=3D NULL)
>-		goto cleanup;
>-
> 	for (i =3D 0; i < nseusers; i++) {
> 		seuname =3D semanage_seuser_get_sename(seuser_list[i]);
> 		name =3D semanage_seuser_get_name(seuser_list[i]);
>@@ -859,70 +1077,27 @@ static genhomedircon_user_entry_t *get_users(genhom=
edircon_settings_t * s,
> 		if (strcmp(name, TEMPLATE_SEUSER) =3D=3D 0)
> 			continue;
>
>-		/* %groupname syntax */
>-		if (name[0] =3D=3D '%')
>-			continue;
>-
> 		/* find the user structure given the name */
> 		u =3D bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *),
> 			    (int (*)(const void *, const void *))
> 			    &name_user_cmp);
>-		if (u) {
>-			prefix =3D semanage_user_get_prefix(*u);
>-			level =3D semanage_user_get_mlslevel(*u);
>-			if (!level)
>-				level =3D FALLBACK_LEVEL;
>-		} else {
>-			prefix =3D name;
>-			level =3D FALLBACK_LEVEL;
>-		}
>-
>-		retval =3D getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
>-		if (retval !=3D 0 || pwent =3D=3D NULL) {
>-			if (retval !=3D 0 && retval !=3D ENOENT) {
>-				*errors =3D STATUS_ERR;
>-				goto cleanup;
>-			}
>-
>-			WARN(s->h_semanage,
>-			     "user %s not in password file", name);
>-			continue;
>-		}
>
>-		int len =3D strlen(pwent->pw_dir) -1;
>-		for(; len > 0 && pwent->pw_dir[len] =3D=3D '/'; len--) {
>-			pwent->pw_dir[len] =3D '\0';
>+		/* %groupname syntax */
>+		if (name[0] =3D=3D '%') {
>+			retval =3D get_group_users(s, &head, *u, seuname,
>+						name);
>+		} else {
>+			retval =3D add_user(s, &head, *u, name,
>+					  seuname, name);
> 		}
>
>-		if (strcmp(pwent->pw_dir, "/") =3D=3D 0) {
>-			/* don't relabel / genhomdircon checked to see if root
>-			 * was the user and if so, set his home directory to
>-			 * /root */
>-			continue;
>-		}
>-		if (ignore(pwent->pw_dir))
>-			continue;
>-
>-		len =3D snprintf(uid, sizeof(uid), "%u", pwent->pw_uid);
>-		if (len < 0 || len >=3D (int)sizeof(uid)) {
>+		if (retval !=3D 0) {
> 			*errors =3D STATUS_ERR;
> 			goto cleanup;
> 		}
>-		len =3D snprintf(gid, sizeof(gid), "%u", pwent->pw_gid);
>-		if (len < 0 || len >=3D (int)sizeof(gid)) {
>-			*errors =3D STATUS_ERR;
>-			goto cleanup;
>-		}
>-
>-		if (push_user_entry(&head, name, uid, gid, seuname,
>-				    prefix, pwent->pw_dir, level) !=3D STATUS_SUCCESS) {
>-			*errors =3D STATUS_ERR;
>-			break;
>-		}
> 	}
>
>       cleanup:
>-	free(rbuf);
> 	if (*errors) {
> 		for (; head; pop_user_entry(&head)) {
> 			/* the pop function takes care of all the cleanup
>--=20
>2.7.4
>
>_______________________________________________
>Selinux mailing list
>Selinux@tycho.nsa.gov
>To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>To get help, send an email containing "help" to Selinux-request@tycho.nsa.=
gov.

Sorry, please disregard this series. Having some issues with my mail=20
client!



--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXu2ceAAoJEHBu12WFqnnYpK4H/2oQCbms+a1/6Qf4/0M5CTFx
9RWDbaOwYUGkiIpxQgjloPMpPf7MTcTkeCQgmelmvrOfBMmdyJoqNs1scJBQCCmq
ipK3DbI3qzM1DfyzslA+siuQxMjlPYqjtvy9CgsozQv4RdT+CUb0D+Yav41lYYZQ
+UOaDJtafAN7mrjDlGLHts/2SzlJp2zxWKSMPS1QX+0vDjXPsop5rBKDDZpVdQfd
6VXOn3wjS+6MyDJc74vOFMSn7Fo3U6hpADR+IWeVtkqMQy+U/wfWnqnOCe+XqTZd
6r90hHuemPL3+s1g/o8PsM5L406CAUIzzqDHIfkW82ujN/rLsoiDYdI205uwLZQ=
=9mOJ
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
