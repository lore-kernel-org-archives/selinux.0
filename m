Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: jbrindle@tresys.com
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <20070521095518.515998898@tresys.com>
References: <20070521095414.832619201@tresys.com>
	 <20070521095518.515998898@tresys.com>
Content-Type: text/plain
Date: Tue, 22 May 2007 17:08:39 -0400
Message-Id: <1179868119.9092.38.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-05-21 at 05:54 -0400, jbrindle@tresys.com wrote:
> plain text document attachment (genhomedircon-replacement-initial)
> Remove python script genhomedircon from libsemanage and replace
> with C functionality.
> 
> Index: ghdc/libsemanage/src/genhomedircon.c
> ===================================================================
> --- /dev/null
> +++ ghdc/libsemanage/src/genhomedircon.c
> @@ -0,0 +1,590 @@
> +/* Author: Mark Goldman   <mgoldman@tresys.com>
> + *
> + * Copyright (C) 2007 Tresys Technology, LLC
> + *
> + *  This library is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU Lesser General Public License as
> + *  published by the Free Software Foundation; either version 2.1 of the
> + *  License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + *  02110-1301  USA
> + */
> +#include <assert.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <pwd.h>
> +

I prefer system includes to be last - it helps prevent missing includes
in public headers. (but that's just my opinion - we don't enforce the
convention)

> +#include <semanage/handle.h>
> +#include <semanage/seusers_policy.h>
> +#include <semanage/users_policy.h>
> +#include <semanage/user_record.h>
> +#include "semanage_store.h"
> +#include "seuser_internal.h"
> +#include "debug.h"
> +
> +#include "utilities.h"
> +#include "genhomedircon.h"
> +
> +static int fwriteoutput(state_t * s, FILE * out);
> +

Please don't define static functions - simply order the .c file
correctly.


> +/* should default to usepasswd */

This comment seems to be meaningless.

> +int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd)
> +{
> +	state_t s;
> +
> +	char outfile[PATH_MAX];
> +	char hdt[PATH_MAX];
> +	char fcf[PATH_MAX];
> +
> +	FILE *out = NULL;
> +	int retval = 0;
> +
> +	assert(sh);
> +
> +	s.homedir_template_path = hdt;
> +	snprintf(s.homedir_template_path, PATH_MAX - 1, "%s",
> +		 semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
> +
> +	snprintf(outfile, PATH_MAX - 1, "%s",
> +		 semanage_path(SEMANAGE_TMP, SEMANAGE_FC_HOMEDIRS));
> +

strdup?

> +	s.fcfilepath = fcf;
> +
> +	snprintf(s.fcfilepath, PATH_MAX - 1, "%s",
> +		 semanage_path(SEMANAGE_TMP, SEMANAGE_FC_HOMEDIRS));
> +

ditto

> +	s.usepasswd = usepasswd;
> +	s.h_semanage = sh;
> +
> +	if (!(out = fopen(s.fcfilepath, "w"))) {
> +		/* couldn't open output file */
> +		ERR(sh, "Could not open the file_context file for writing");
> +		retval = STATUS_ERR;
> +		goto out;

This should just return, otherwise you are trying to close a file that
isn't open.

> +	}
> +
> +	fwriteoutput(&s, out);
> +

You should check the return value.

> +      out:

If you remove the previous goto this target can go.

> +	fclose(out);
> +	return retval;
> +}
> +
> +static list_t *default_shell_list(void)
> +{

What is this function for? Why not error out when /etc/shells is not
available?

> +	list_t *list = NULL;

Why are you adding another list type when we just merged one into
libsepol? If you want this merged into trunk before policyrep let's move
the list type over early.

> +	semanage_list_push(&list, "/bin/csh");
> +	semanage_list_push(&list, "/bin/tcsh");
> +	semanage_list_push(&list, "/bin/ksh");
> +	semanage_list_push(&list, "/bin/bsh");
> +	semanage_list_push(&list, "/bin/ash");
> +	semanage_list_push(&list, "/usr/bin/ksh");
> +	semanage_list_push(&list, "/usr/bin/pdksh");
> +	semanage_list_push(&list, "/bin/zsh");
> +	semanage_list_push(&list, "/bin/sh");
> +	semanage_list_push(&list, "/bin/bash");
> +	return list;
> +}
> +
> +static list_t *get_shell_list(void)
> +{
> +	FILE *shells;
> +	char *temp = NULL;
> +	list_t *list = NULL;
> +
> +	shells = fopen("/etc/shells", "r");
> +	if (!shells)
> +		return default_shell_list();

See above - when is this error possible and why not make it fatal.

> +	while ((temp = semanage_fgetline(shells))) {

You should use getline - we already depend on GNU extensions.

> +		if (!strcmp(temp, "/sbin/nologin")) {
> +			free(temp);
> +			continue;
> +		}
> +		semanage_list_push(&list, temp);
> +		free(temp);
> +	}
> +	return list;
> +}
> +
> +static list_t *get_home_dirs(state_t * s)
> +{
> +	list_t *l = NULL;
> +	list_t *shells = NULL;
> +	char *path;
> +	size_t minuid = 2000000;	/* sentinal value, UIDs can't be
> +					 * above ~64k */
> +	size_t temp;
> +	struct passwd *pwbuf;
> +	struct stat buf;
> +
> +	path = semanage_findval("/etc/default/useradd", "HOME", "=");
> +	if (path && *path) {
> +		semanage_list_push(&l, path);
> +	}
> +	free(path);
> +
> +	path = semanage_findval("/etc/libuser.conf", "LU_HOMEDIRECTORY", "=");
> +	if (path && *path) {
> +		semanage_list_push(&l, path);
> +	}
> +	free(path);
> +
> +	if (!l)
> +		semanage_list_push(&l, strdup("/home"));
> +
> +	if (!stat("/export/home", &buf)) {
> +		if (buf.st_mode | S_IFDIR)
> +			semanage_list_push(&l, strdup("/export/home"));
> +	}
> +
> +	if (!(s->usepasswd))
> +		return l;
> +
> +	path = semanage_findval("/etc/login.defs", "UID_MIN", NULL);
> +	if (path && *path) {
> +		temp = atoi(path);
> +		if (temp < minuid)
> +			minuid = temp;
> +	}
> +	free(path);
> +
> +	path = semanage_findval("/etc/libuser.conf", "LU_UIDNUMBER", "=");
> +	if (path && *path) {
> +		temp = atoi(path);
> +		if (temp < minuid)
> +			minuid = temp;
> +	}
> +	free(path);
> +
> +	if (minuid == 2000000)
> +		minuid = 500;

Please use a boolean value to indicate whether minuid is set.

> +
> +	shells = get_shell_list();
> +

Error checking.

> +	setpwent();
> +	while ((pwbuf = getpwent())) {

You need to check errno to see if there was an error.

It is not clear from the python docs, but getpwent will definitely pull
user entries from LDAP, NIS, etc. Is that what we want or should we
limit to /etc/passwd only?

> +		if (pwbuf->pw_uid < minuid)
> +			continue;
> +		if (!semanage_list_find(shells, pwbuf->pw_shell))
> +			continue;
> +		if (strcmp(pwbuf->pw_dir, "/") == 0)
> +			continue;
> +		if (semanage_str_count(pwbuf->pw_dir, '/') <= 1)
> +			continue;
> +		path = strdup(pwbuf->pw_dir);
> +		semanage_rtrim(path, '/');
> +		if (!semanage_list_find(l, path)) {
> +			semanage_list_push(&l, path);	
> +		}
> +		free(path);
> +	}
> +
> +	/* clean up: I'm returning l so I don't need to do anything with it.
> +	 *           I free the memory pointed to by path as soon as I'm done.
> +	 *           That leaves the shells list which I destoy here.
> +	 */
> +	endpwent();
> +	semanage_list_destroy(&shells);
> +
> +	semanage_list_sort(&l);
> +	return l;
> +}
> +
> +/**
> + * @param	s	state structure, stores various paths etc. Must never be NULL
> + * @param	out	the FILE to put all the output in.
> + * @return	0 on success
> + */
> +static int fwriteheader(state_t * s, FILE * out)
> +{

Needs a better function name.

> +
> +	fprintf(out,
> +		"#\n#\n# User-specific file contexts, generated via libsemanage\n");
> +	fprintf(out,
> +		"# use semanage command to manage system users to change the"
> +		" file_context\n#\n#\n");
> +	return 0;
> +}
> +
> +/* Predicates for use with semanage_slurp_file_filter() the homedir_template file
> + * currently contains lines that serve as the template for a user's
> + * homedir.
> + *
> + * It also contains lines that are the template for the parent of a
> + * user's home directory.
> + *
> + * Currently, the only lines that apply to the the root of a user's home
> + * directory are all prefixed with the string "HOME_ROOT".  All other
> + * lines apply to a user's home directory.  If this changes the
> + * following predicates need to change to reflect that.
> + */
> +static int HOME_ROOT_PRED(char *string)
> +{
> +	return semanage_prefix_of(string, "HOME_ROOT");
> +}
> +
> +static int HOME_DIR_PRED(char *string)
> +{
> +	return semanage_prefix_of(string, "HOME_DIR");
> +}
> +
> +static int USER_CONTEXT_PRED(char *string)
> +{
> +	return (int)(strstr(string, "USER") != NULL);
> +}
> +
> +/* make_home_dir_tempate
> + * make_home_root_template
> + * @param	s	  the state holding the paths to various files
> + * @return   a list of lines from the template file with inappropriate
> + *	    lines filtered out.
> + */
> +static list_t *make_home_dir_template(state_t * s)
> +{
> +	FILE *template_file = NULL;
> +	list_t *template_data = NULL;
> +
> +	template_file = fopen(s->homedir_template_path, "r");
> +	if (!template_file)
> +		return NULL;
> +	template_data = semanage_slurp_file_filter(template_file, &HOME_DIR_PRED);
> +	fclose(template_file);
> +	return template_data;
> +}
> +
> +static list_t *make_home_root_template(state_t * s)
> +{
> +	FILE *template_file = NULL;
> +	list_t *template_data = NULL;
> +
> +	template_file = fopen(s->homedir_template_path, "r");
> +	if (!template_file)
> +		return NULL;
> +	template_data = semanage_slurp_file_filter(template_file, &HOME_ROOT_PRED);
> +	fclose(template_file);
> +	return template_data;
> +}
> +
> +static list_t *make_user_context_template(state_t * s)
> +{
> +	FILE *template_file = NULL;
> +	list_t *template_data = NULL;
> +
> +	template_file = fopen(s->homedir_template_path, "r");
> +	if (!template_file)
> +		return NULL;
> +	template_data = semanage_slurp_file_filter(template_file, &USER_CONTEXT_PRED);
> +	fclose(template_file);
> +	return template_data;
> +}
> +
> +static int write_home_dir_context(FILE * out, list_t * tpl, char *user,
> +				  char *seuser, char *home, char *prefix)
> +{
> +	char *temp;
> +	char *line;
> +
> +	fprintf(out, "\n\n#\n# Home Context for user %s\n#\n\n", user);
> +	for (; tpl; tpl = tpl->next) {
> +		temp = semanage_sed(tpl->data, "HOME_DIR", home);

Wow - I understand that this string handling in C is painful, but is
this really the best alternative? Perhaps parsing the input to make the
substitution easier would be better? Perhaps we should look for some
library code to do this?

> +		if (!temp)
> +			return -1;
> +		line = temp;
> +		temp = semanage_sed(line, "ROLE", prefix);
> +		free(line);
> +		if (!temp)
> +			return -1;
> +		line = temp;
> +		temp = semanage_sed(line, "system_u", seuser);
> +		free(line);
> +		if (!temp)
> +			return -1;
> +		line = temp;
> +		fputs(line, out);
> +		fputs("\n", out);
> +		free(line);
> +	}
> +	return 0;
> +}
> +
> +static int write_home_root_context(FILE * out, list_t * tpl, char *homedir)
> +{
> +	char *temp;
> +
> +	for (; tpl; tpl = tpl->next) {
> +		temp = semanage_sed(tpl->data, "HOME_ROOT", homedir);
> +		if (!temp)
> +			return -1;
> +		fputs(temp, out);
> +		fputs("\n", out);
> +		free(temp);
> +	}
> +	return 0;
> +}
> +
> +static int write_user_context(FILE * out, list_t * tpl, char *user,
> +			      char *seuser, char *prefix)
> +{
> +	char *temp;
> +	char *line;
> +
> +	for (; tpl; tpl = tpl->next) {
> +		temp = semanage_sed(tpl->data, "USER", user);
> +		if (!temp)
> +			return -1;
> +		line = temp;
> +		temp = semanage_sed(line, "ROLE", prefix);
> +		free(line);
> +		if (!temp)
> +			return -1;
> +		line = temp;
> +		temp = semanage_sed(line, "system_u", seuser);
> +		free(line);
> +		if (!temp)
> +			return -1;
> +		line = temp;
> +		fputs(line, out);
> +		fputs("\n", out);
> +		free(line);
> +	}
> +	return 0;
> +}
> +
> +static int user_sort_func(semanage_user_t ** arg1, semanage_user_t ** arg2)
> +{
> +	return strcmp(semanage_user_get_name(*arg1),
> +		      semanage_user_get_name(*arg2));
> +}
> +
> +static int name_user_cmp(char *key, semanage_user_t ** val)
> +{
> +	int ret = strcmp(key, semanage_user_get_name(*val));
> +	return ret;
> +}
> +
> +static int push_user_entry(user_entry_t ** list, const char *n, const char *sen,
> +			   const char *pre, const char *h)
> +{
> +	user_entry_t *temp = NULL;
> +	char *name = NULL;
> +	char *sename = NULL;
> +	char *prefix = NULL;
> +	char *home = NULL;
> +
> +	temp = malloc(sizeof(user_entry_t));
> +	if (!temp)
> +		goto cleanup;
> +	name = strdup(n);
> +	if (!name)
> +		goto cleanup;
> +	sename = strdup(sen);
> +	if (!sename)
> +		goto cleanup;
> +	prefix = strdup(pre);
> +	if (!prefix)
> +		goto cleanup;
> +	home = strdup(h);
> +	if (!home)
> +		goto cleanup;
> +
> +	temp->name = name;
> +	temp->sename = sename;
> +	temp->prefix = prefix;
> +	temp->home = home;
> +	temp->next = (*list);
> +	(*list) = temp;
> +
> +	return 0;
> +
> +      cleanup:
> +	free(name);
> +	free(sename);
> +	free(prefix);
> +	free(home);
> +	free(temp);
> +	return -1;
> +}
> +
> +static void pop_user_entry(user_entry_t ** list)
> +{
> +	user_entry_t *temp;
> +
> +	if (!list || !(*list))
> +		return;
> +	temp = *list;
> +	*list = temp->next;
> +	free(temp->name);
> +	free(temp->sename);
> +	free(temp->prefix);
> +	free(temp->home);
> +	free(temp);
> +	return;
> +}
> +
> +static user_entry_t *get_users(state_t * s)
> +{
> +	user_entry_t *head = NULL;
> +
> +	semanage_seuser_t **seuser_list = NULL;
> +	unsigned int nseusers = 0;
> +
> +	semanage_user_t **user_list = NULL;
> +	unsigned int nusers = 0;
> +
> +	semanage_user_t **u = NULL;
> +	const char *name = NULL;
> +	const char *seuname = NULL;
> +	const char *prefix = NULL;
> +
> +	struct passwd *pwent = NULL;
> +
> +	unsigned int i;
> +	int retval;
> +
> +	if ((retval =
> +	     semanage_seuser_list(s->h_semanage, &seuser_list, &nseusers) < 0)
> +	    || (nseusers < 1)) {
> +		/* if there are no users, this function can't do any other work */
> +		return NULL;
> +	}
> +
> +	if (semanage_user_list(s->h_semanage, &user_list, &nusers) < 0) {
> +		nusers = 0;
> +	}
> +
> +	qsort(user_list, nusers, sizeof(semanage_user_t *),
> +	      (int (*)(const void *, const void *))&user_sort_func);
> +
> +	for (i = 0; i < nseusers; i++) {
> +		name = semanage_seuser_get_name(seuser_list[i]);
> +		seuname = semanage_seuser_get_sename(seuser_list[i]);
> +
> +		if (strcmp(seuname, "user_u") == 0)
> +			continue;
> +		if (strcmp(seuname, "__default__") == 0)
> +			continue;
> +		if (strcmp(seuname, "system_u") == 0)
> +			continue;
> +
> +		/* find the user structure givent the name */
> +		u = bsearch(name, user_list, nusers, sizeof(semanage_user_t *),
> +			    (int (*)(const void *, const void *))
> +			    &name_user_cmp);
> +		if (u) {
> +			prefix = semanage_user_get_prefix(*u);
> +		} else {
> +			prefix = name;
> +		}
> +
> +		pwent = getpwnam(name);
> +		if (!pwent) {
> +			/* user not in passwd file, genhomedircon
> +			 * printed a message here */
> +			continue;
> +		}
> +
> +		if (strcmp(pwent->pw_dir, "/") == 0) {
> +			/* don't relabel / genhomdircon checked to see if root
> +			 * was the user and if so, set his home directory to
> +			 * /root */
> +			continue;
> +		}
> +
> +		push_user_entry(&head, name, seuname, prefix, pwent->pw_dir);
> +	}
> +	for (i = 0; i < nseusers; i++) {
> +		semanage_seuser_free(seuser_list[i]);
> +	}
> +	free(seuser_list);
> +
> +	for (i = 0; i < nusers; i++) {
> +		semanage_user_free(user_list[i]);
> +	}
> +	free(user_list);
> +	return head;
> +}
> +
> +static int write_gen_home_dir_context(FILE * out, state_t * s,
> +				      list_t * user_context_tpl,
> +				      list_t * homedir_context_tpl)
> +{
> +	user_entry_t *users;
> +
> +	for (users = get_users(s); users; pop_user_entry(&users)) {
> +		write_home_dir_context(out, homedir_context_tpl,
> +				       users->name,
> +				       users->sename, users->home,
> +				       users->prefix);
> +		write_user_context(out, user_context_tpl, users->name,
> +				   users->sename, users->prefix);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * @param	s	state structure, stores various paths etc. Must never be NULL
> + * @param	out	the FILE to put all the output in.
> + * @return	0 on success
> + */
> +static int fwriteoutput(state_t * s, FILE * out)
> +{

This function name should be more descriptive.

> +	list_t *homedirs = NULL;
> +	list_t *h = NULL;
> +	list_t *user_context_tpl = NULL;
> +	list_t *homedir_context_tpl = NULL;
> +	list_t *homeroot_context_tpl = NULL;
> +
> +	char *temp;
> +	int s1len;
> +
> +	homedirs = get_home_dirs(s);
> +	if (!homedirs) {
> +		WARN(s->h_semanage,
> +		     "no home directories were available, exiting without writing");
> +		return -1;	/* No homedirs so no output */
> +	}
> +
> +	fwriteheader(s, out);
> +
> +	homedir_context_tpl = make_home_dir_template(s);
> +	homeroot_context_tpl = make_home_root_template(s);
> +	user_context_tpl = make_user_context_template(s);
> +
> +	for (h = homedirs; h; h = h->next) {
> +		s1len = strlen(h->data);
> +		temp = malloc(s1len + sizeof("/[^/]*"));
> +		strcpy(temp, h->data);
> +		strcpy(temp + s1len, "/[^/]*");

strdup

> +
> +		write_home_dir_context(out,
> +				       homedir_context_tpl, "user_u", "user_u",
> +				       temp, "user");
> +		write_home_root_context(out, homeroot_context_tpl, h->data);
> +
> +		free(temp);
> +	}
> +	write_user_context(out, user_context_tpl, ".*", "user_u", "user");
> +	write_gen_home_dir_context(out, s, user_context_tpl,
> +				   homedir_context_tpl);
> +
> +	/* Cleanup */
> +	semanage_list_destroy(&homedirs);
> +	semanage_list_destroy(&user_context_tpl);
> +	semanage_list_destroy(&homedir_context_tpl);
> +	semanage_list_destroy(&homeroot_context_tpl);
> +
> +	return 0;
> +}
> Index: ghdc/libsemanage/src/genhomedircon.h
> ===================================================================
> --- /dev/null
> +++ ghdc/libsemanage/src/genhomedircon.h
> @@ -0,0 +1,42 @@
> +/* Author: Mark Goldman   <mgoldman@tresys.com>
> + *
> + * Copyright (C) 2007 Tresys Technology, LLC
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#ifndef selinux_genhomedircon
> +#define selinux_genhomedircon
> +

These header guards don't match the rest of the library - should be
_SEMANAGE_GENHOMEDIRCON_H_.

> +#include "utilities.h"
> +
> +typedef struct {
> +	char *fcfilepath;
> +	int usepasswd;
> +	char *homedir_template_path;
> +	semanage_handle_t *h_semanage;
> +} state_t;
> +

This needs to be namespaced and have a better name. Also - does it need
to be exported?

> +typedef struct user_entry {
> +	char *name;
> +	char *sename;
> +	char *prefix;
> +	char *home;
> +	struct user_entry *next;
> +} user_entry_t;
> +

ditto

> +int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd);
> +
> +#endif
> Index: ghdc/libsemanage/src/semanage_store.c
> ===================================================================
> --- ghdc.orig/libsemanage/src/semanage_store.c
> +++ ghdc/libsemanage/src/semanage_store.c
> @@ -34,6 +34,7 @@ typedef struct dbase_policydb dbase_t;
>  #include "semanage_store.h"
>  #include "database_policydb.h"
>  #include "handle.h"
> +#include "genhomedircon.h"
>  
>  #include <selinux/selinux.h>
>  #include <sepol/policydb.h>
> @@ -110,6 +111,7 @@ static const char *semanage_sandbox_path
>  	"/seusers.final",
>  	"/users_extra",
>  	"/netfilter_contexts",
> +	"/file_contexts.homedirs",
>  };
>  
>  /* A node used in a linked list of file contexts; used for sorting.
> @@ -1008,14 +1010,15 @@ static int semanage_install_active(seman
>  	const char *active_fc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC);
>  	const char *active_fc_loc =
>  	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC_LOCAL);
> -	const char *active_hd =
> -	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_HOMEDIR_TMPL);
>  	const char *active_seusers =
>  	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_SEUSERS);
>  	const char *active_nc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_NC);
> +	const char *active_fc_hd =
> +	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC_HOMEDIRS);
>  
>  	const char *running_fc = selinux_file_context_path();
>  	const char *running_fc_loc = selinux_file_context_local_path();
> +	const char *running_fc_hd = selinux_file_context_homedir_path();
>  	const char *running_hd = selinux_homedir_context_path();
>  	const char *running_policy = selinux_binary_policy_path();
>  	const char *running_seusers = selinux_usersconf_path();
> @@ -1027,14 +1030,15 @@ static int semanage_install_active(seman
>  	 * POLICYTYPE and should probably be done in the future. */
>  	char store_fc[PATH_MAX];
>  	char store_fc_loc[PATH_MAX];
> -	char store_hd[PATH_MAX];
>  	char store_pol[PATH_MAX];
>  	char store_seusers[PATH_MAX];
>  	char store_nc[PATH_MAX];
> +	char store_fc_hd[PATH_MAX];
>  
>  	len = strlen(really_active_store);
>  	running_fc += len;
>  	running_fc_loc += len;
> +	running_fc_hd += len;
>  	running_hd += len;
>  	running_policy += len;
>  	running_seusers += len;
> @@ -1055,9 +1059,10 @@ static int semanage_install_active(seman
>  		goto cleanup;
>  	}
>  
> -	snprintf(store_hd, PATH_MAX, "%s%s", storepath, running_hd);
> -	if (semanage_copy_file(active_hd, store_hd, sh->conf->file_mode) == -1) {
> -		ERR(sh, "Could not copy %s to %s.", active_hd, store_hd);
> +	snprintf(store_fc_hd, PATH_MAX, "%s%s", storepath, running_fc_hd);
> +	if (semanage_copy_file(active_fc_hd, store_fc_hd, sh->conf->file_mode)
> +	    == -1) {
> +		ERR(sh, "Could not copy %s to %s.", active_fc_hd, store_fc_hd);
>  		goto cleanup;
>  	}
>  
> @@ -1197,6 +1202,10 @@ static int semanage_commit_sandbox(seman
>  		retval = -1;
>  		goto cleanup;
>  	}
> +
> +	/* clean up some files from the sandbox before install */
> +	/* remove homedir_template from sandbox */
> +
>  	if (rename(sandbox, active) == -1) {
>  		ERR(sh, "Error while renaming %s to %s.", sandbox, active);
>  		/* note that if an error occurs during the next
> @@ -1227,7 +1236,8 @@ static int semanage_commit_sandbox(seman
>  	if (!sh->conf->save_previous) {
>  		retval = semanage_remove_directory(backup);
>  		if (retval < 0) {
> -			ERR(sh, "Could not delete previous directory %s.", backup);
> +			ERR(sh, "Could not delete previous directory %s.",
> +			    backup);
>  			goto cleanup;
>  		}
>  	}
> @@ -1257,15 +1267,15 @@ int semanage_install_sandbox(semanage_ha
>  		goto cleanup;
>  	}
>  
> -	if ((commit_num = semanage_commit_sandbox(sh)) < 0) {
> -		retval = commit_num;
> +	if ((retval =
> +	     semanage_genhomedircon(sh, 1)) != 0) {
> +		ERR(sh, "semanage_genhomedircon returned error code %d.",
> +		    retval);
>  		goto cleanup;
>  	}
>  
> -	if ((retval =
> -	     semanage_exec_prog(sh, sh->conf->genhomedircon,
> -				sh->conf->store_path, "")) != 0) {
> -		ERR(sh, "genhomedircon returned error code %d.", retval);
> +	if ((commit_num = semanage_commit_sandbox(sh)) < 0) {
> +		retval = commit_num;
>  		goto cleanup;
>  	}
>  
> Index: ghdc/libsemanage/src/utilities.c
> ===================================================================
> --- /dev/null
> +++ ghdc/libsemanage/src/utilities.c
> @@ -0,0 +1,359 @@
> +/* Author: Mark Goldman   <mgoldman@tresys.com>
> + *
> + * Copyright (C) 2007 Tresys Technology, LLC
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <ctype.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <regex.h>
> +
> +#include "utilities.h"
> +
> +char *semanage_findval(char *file, char *var, char *delim)
> +{
> +	FILE *fd;
> +
> +	char *buff;
> +	char *temp = NULL;
> +
> +	if (!file || !var || !delim)
> +		return NULL;

assert?

> +
> +	if ((fd = fopen(file, "r")) == NULL)
> +		return NULL;
> +
> +	while (!feof(fd)) {
> +		if (!(buff = semanage_fgetline(fd))){
> +			goto err;
> +		}
> +		if (semanage_prefix_of(buff, var)) {
> +			/* Found it */
> +			temp = semanage_split(buff, delim);
> +			/* if semanage_split succedes dup the token */
> +			if (temp != NULL)
> +				temp = strdup(temp);
> +			free(buff);	/* free the buffer */
> +			goto out;
> +		}
> +		free(buff);	/* free the buffer for next time through the loop */
> +	}
> +
> +err:
> +	temp = NULL;
> +out:
> +	fclose(fd);
> +	return temp;
> +
> +}
> +
> +int semanage_prefix_of(char *str, char *val)
> +{

We commonly use is to denote boolean return - i.e.
semanage_str_is_prefix(char *str, char *prefix).

> +	if (!str)
> +		return 0;
> +	if (!val)
> +		return 1;
> +
> +	while ((*str) && (*val) && (*str == *val)) {
> +		++str;
> +		++val;
> +	}
> +
> +	return !(*val);
> +}
> +
> +char *semanage_split_on_space(char *str)
> +{
> +	if (!str)
> +		return NULL;
> +
> +	while ((*str != '\0') && !(isspace(*str)))
> +		str++;
> +	while ((*str != '\0') && (isspace(*str)))
> +		str++;
> +
> +	return str;
> +}
> +
> +char *semanage_split(char *str, char *delim)
> +{
> +	char *temp = str;
> +
> +	if (!str)
> +		return NULL;
> +	if (!delim || (*delim == '\0'))
> +		return semanage_split_on_space(str);

Having NULL mean space seems odd.

> +
> +	strsep(&temp, delim);	/* temp gets updated to the char past delim */
> +
> +	return temp;
> +}
> +
> +char *semanage_fgetline(FILE * f)
> +{

Replace with getline.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
