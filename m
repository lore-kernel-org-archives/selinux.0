Subject: Re: [patch 2/5] libsemanage: genhomedircon replacement
From: Stephen Smalley <sds@tycho.nsa.gov>
To: tmiller@tresys.com
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <20070821191045.857181383@tresys.com>
References: <20070821191042.482612921@tresys.com>
	 <20070821191045.857181383@tresys.com>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 09:39:21 -0400
Message-Id: <1187876361.1451.480.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-21 at 15:10 -0400, tmiller@tresys.com wrote:
> plain text document attachment (genhomedircon-replacement-initial)
> Remove python script genhomedircon from libsemanage and replace
> with C functionality.
> 
> Note: This code fixes a bug in the orignal genhomedircon python script; the
> following two lines are added to the file contexts whereas the old
> genhomedircon would not add them: 
> 
> /tmp/\.exchange-.*(/.*)?      user_u:object_r:user_evolution_exchange_tmp_t:s0
> /tmp/\.exchange-root(/.*)?    root:object_r:user_evolution_exchange_tmp_t:s0

Still wrong.  I still get extra blank lines and sds_home_t rather than
staff_home_t out of it.

> Index: selinux-unmodified-trunk/libselinux/src/file_path_suffixes.h
> ===================================================================
> --- selinux-unmodified-trunk.orig/libselinux/src/file_path_suffixes.h
> +++ selinux-unmodified-trunk/libselinux/src/file_path_suffixes.h
> @@ -16,6 +16,6 @@ S_(BINPOLICY, "/policy/policy")
>      S_(SEUSERS, "/seusers")
>      S_(TRANSLATIONS, "/setrans.conf")
>      S_(NETFILTER_CONTEXTS, "/contexts/netfilter_contexts")
> -    S_(FILE_CONTEXTS_HOMEDIR, "/contexts/files/file_contexts.homedir")
> +    S_(FILE_CONTEXTS_HOMEDIR, "/contexts/files/file_contexts.homedirs")
>      S_(FILE_CONTEXTS_LOCAL, "/contexts/files/file_contexts.local")
>      S_(X_CONTEXTS, "/contexts/x_contexts")
> Index: selinux-unmodified-trunk/libsemanage/src/semanage_store.c
> ===================================================================
> --- selinux-unmodified-trunk.orig/libsemanage/src/semanage_store.c
> +++ selinux-unmodified-trunk/libsemanage/src/semanage_store.c
> @@ -34,6 +34,7 @@ typedef struct dbase_policydb dbase_t;
>  #include "semanage_store.h"
>  #include "database_policydb.h"
>  #include "handle.h"
> +#include "genhomedircon.h"
>  
>  #include <selinux/selinux.h>
>  #include <sepol/policydb.h>
> @@ -60,6 +61,9 @@ typedef struct dbase_policydb dbase_t;
>  #define SEMANAGE_CONF_FILE "semanage.conf"
>  /* relative path names to enum semanage_paths to special files and
>   * directories for the module store */
> +
> +#define TRUE 1
> +
>  enum semanage_file_defs {
>  	SEMANAGE_ROOT,
>  	SEMANAGE_TRANS_LOCK,
> @@ -110,6 +114,7 @@ static const char *semanage_sandbox_path
>  	"/seusers.final",
>  	"/users_extra",
>  	"/netfilter_contexts",
> +	"/file_contexts.homedirs",
>  };
>  
>  /* A node used in a linked list of file contexts; used for sorting.
> @@ -1264,15 +1269,15 @@ int semanage_install_sandbox(semanage_ha
>  		goto cleanup;
>  	}
>  
> -	if ((commit_num = semanage_commit_sandbox(sh)) < 0) {
> -		retval = commit_num;
> +	if ((retval =
> +	     semanage_genhomedircon(sh, TRUE)) != 0) {
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
> Index: selinux-unmodified-trunk/libsemanage/src/semanage_store.h
> ===================================================================
> --- selinux-unmodified-trunk.orig/libsemanage/src/semanage_store.h
> +++ selinux-unmodified-trunk/libsemanage/src/semanage_store.h
> @@ -57,6 +57,7 @@ enum semanage_sandbox_defs {
>  	SEMANAGE_SEUSERS,
>  	SEMANAGE_USERS_EXTRA,
>  	SEMANAGE_NC,
> +	SEMANAGE_FC_HOMEDIRS,
>  	SEMANAGE_STORE_NUM_PATHS
>  };
>  
> Index: selinux-unmodified-trunk/libsemanage/src/genhomedircon.c
> ===================================================================
> --- /dev/null
> +++ selinux-unmodified-trunk/libsemanage/src/genhomedircon.c
> @@ -0,0 +1,717 @@
> +/* Author: Mark Goldman   <mgoldman@tresys.com>
> + * 			Paul Rosenfeld	<prosenfeld@tresys.com>
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
> +
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
> +#include <ustr.h>
> +
> +#include <assert.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <pwd.h>
> +#include <errno.h>
> +
> +/* paths used in get_home_dirs() */
> +#define PATH_ETC_USERADD "/etc/default/useradd"
> +#define PATH_ETC_LIBUSER "/etc/libuser.conf"
> +#define PATH_DEFAULT_HOME "/home"
> +#define PATH_EXPORT_HOME "/export/home"
> +#define PATH_ETC_LOGIN_DEFS "/etc/login.defs"
> +
> +/* other paths */
> +#define PATH_SHELLS_FILE "/etc/shells"
> +#define PATH_NOLOGIN_SHELL "/sbin/nologin"
> +
> +/* comments written to context file */
> +#define COMMENT_FILE_CONTEXT_HEADER "#\n#\n# " \
> +			"User-specific file contexts, generated via libsemanage\n" \
> +			"# use semanage command to manage system users to change" \
> +			" the file_context\n#\n#\n"
> +
> +#define COMMENT_USER_HOME_CONTEXT "\n\n#\n# Home Context for user %s" \
> +			"\n#\n\n"
> +
> +/* placeholders used in the template file
> +   which are searched for and replaced */
> +#define TEMPLATE_HOME_ROOT "HOME_ROOT"
> +#define TEMPLATE_HOME_DIR "HOME_DIR"
> +#define TEMPLATE_USER "USER"
> +#define TEMPLATE_ROLE "ROLE"
> +#define TEMPLATE_SEUSER "system_u"
> +
> +#define FALLBACK_USER "user_u"
> +#define FALLBACK_USER_PREFIX "user"
> +#define DEFAULT_LOGIN "__default__"
> +
> +typedef struct {
> +	const char *fcfilepath;
> +	int usepasswd;
> +	const char *homedir_template_path;
> +	semanage_handle_t *h_semanage;
> +} genhomedircon_settings_t;
> +
> +typedef struct user_entry {
> +	char *name;
> +	char *sename;
> +	char *prefix;
> +	char *home;
> +	struct user_entry *next;
> +} genhomedircon_user_entry_t;
> +
> +typedef struct {
> +	const char *search_for;
> +	const char *replace_with;
> +} replacement_pair_t;
> +
> +static semanage_list_t *default_shell_list(void)
> +{
> +	semanage_list_t *list = NULL;
> +
> +	if (semanage_list_push(&list, "/bin/csh")
> +	    || semanage_list_push(&list, "/bin/tcsh")
> +	    || semanage_list_push(&list, "/bin/ksh")
> +	    || semanage_list_push(&list, "/bin/bsh")
> +	    || semanage_list_push(&list, "/bin/ash")
> +	    || semanage_list_push(&list, "/usr/bin/ksh")
> +	    || semanage_list_push(&list, "/usr/bin/pdksh")
> +	    || semanage_list_push(&list, "/bin/zsh")
> +	    || semanage_list_push(&list, "/bin/sh")
> +	    || semanage_list_push(&list, "/bin/bash"))
> +		goto fail;
> +
> +	return list;
> +
> +      fail:
> +	semanage_list_destroy(&list);
> +	return NULL;
> +}
> +
> +static semanage_list_t *get_shell_list(void)
> +{
> +	FILE *shells;
> +	char *temp = NULL;
> +	semanage_list_t *list = NULL;
> +	size_t buff_len = 0;
> +
> +	shells = fopen(PATH_SHELLS_FILE, "r");
> +	if (!shells)
> +		return default_shell_list();
> +	while (getline(&temp, &buff_len, shells) >= 0) {
> +		if (strcmp(temp, PATH_NOLOGIN_SHELL)) {
> +			if (semanage_list_push(&list, temp)) {
> +				free(temp);
> +				semanage_list_destroy(&list);
> +				return default_shell_list();
> +			}
> +		}
> +	}
> +	free(temp);
> +
> +	return list;
> +}
> +
> +static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
> +{
> +	semanage_list_t *homedir_list = NULL;
> +	semanage_list_t *shells = NULL;
> +	char *path = NULL;
> +	size_t minuid = 0;
> +	size_t minuid_set = 0;
> +	size_t temp;
> +	struct passwd *pwbuf;
> +	struct stat buf;
> +
> +	shells = get_shell_list();
> +	assert(shells);
> +
> +	path = semanage_findval(PATH_ETC_USERADD, "HOME", "=");
> +	if (path && *path) {
> +		if (semanage_list_push(&homedir_list, path)) {
> +			free(path);
> +			goto fail;
> +		}
> +	}
> +	free(path);
> +
> +	path = semanage_findval(PATH_ETC_LIBUSER, "LU_HOMEDIRECTORY", "=");
> +	if (path && *path) {
> +		if (semanage_list_push(&homedir_list, path)) {
> +			free(path);
> +			goto fail;
> +		}
> +	}
> +	free(path);
> +
> +	if (!homedir_list) {
> +		if (semanage_list_push(&homedir_list, PATH_DEFAULT_HOME)) {
> +			goto fail;
> +		}
> +	}
> +
> +	if (!stat(PATH_EXPORT_HOME, &buf)) {
> +		if (S_ISDIR(buf.st_mode)) {
> +			if (semanage_list_push(&homedir_list, PATH_EXPORT_HOME)) {
> +				goto fail;
> +			}
> +		}
> +	}
> +
> +	if (!(s->usepasswd))
> +		return homedir_list;
> +
> +	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL);
> +	if (path && *path) {
> +		temp = atoi(path);
> +		if (!minuid_set || temp < minuid) {
> +			minuid = temp;
> +			minuid_set = 1;
> +		}
> +	}
> +	free(path);
> +
> +	path = semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=");
> +	if (path && *path) {
> +		temp = atoi(path);
> +		if (!minuid_set || temp < minuid) {
> +			minuid = temp;
> +			minuid_set = 1;
> +		}
> +	}
> +	free(path);
> +
> +	if (!minuid_set) {
> +		minuid = 500;
> +		minuid_set = 1;
> +	}
> +
> +	setpwent();
> +	for (errno = 0; (pwbuf = getpwent()); errno = 0) {
> +		if (pwbuf->pw_uid < minuid)
> +			continue;
> +		if (!semanage_list_find(shells, pwbuf->pw_shell))
> +			continue;
> +		if (strcmp(pwbuf->pw_dir, "/") == 0)
> +			continue;
> +		if (semanage_str_count(pwbuf->pw_dir, '/') <= 1)
> +			continue;
> +		if (!(path = strdup(pwbuf->pw_dir))) {
> +			break;
> +		}
> +
> +		semanage_rtrim(path, '/');
> +		if (!semanage_list_find(homedir_list, path)) {
> +			if (semanage_list_push(&homedir_list, path)) {
> +				free(path);
> +				goto fail;
> +			}
> +		}
> +		free(path);
> +	}
> +
> +	if (errno) {
> +		WARN(s->h_semanage, "Error while fetching users.  "
> +		     "Returning list so far.");
> +	}
> +	endpwent();
> +	semanage_list_destroy(&shells);
> +	if (semanage_list_sort(&homedir_list))
> +		goto fail;
> +
> +	return homedir_list;
> +
> +      fail:
> +	semanage_list_destroy(&homedir_list);
> +	semanage_list_destroy(&shells);
> +	return NULL;
> +}
> +
> +/**
> + * @param	s	settings structure, stores various paths etc. Must never be NULL
> + * @param	out	the FILE to put all the output in.
> + * @return	0 on success
> + */
> +static int write_file_context_header(genhomedircon_settings_t * s, FILE * out)
> +{
> +	if (fprintf(out, COMMENT_FILE_CONTEXT_HEADER) < 0) {
> +		return STATUS_ERR;
> +	}
> +
> +	return STATUS_SUCCESS;
> +}
> +
> +/* Predicates for use with semanage_slurp_file_filter() the homedir_template
> + * file currently contains lines that serve as the template for a user's
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
> +static int HOME_ROOT_PRED(const char *string)
> +{
> +	return semanage_is_prefix(string, TEMPLATE_HOME_ROOT);
> +}
> +
> +static int HOME_DIR_PRED(const char *string)
> +{
> +	return semanage_is_prefix(string, TEMPLATE_HOME_DIR);
> +}
> +
> +static int USER_CONTEXT_PRED(const char *string)
> +{
> +	return (int)(strstr(string, TEMPLATE_USER) != NULL);
> +}
> +
> +/* make_tempate
> + * @param	s	  the settings holding the paths to various files
> + * @param	pred	function pointer to function to use as filter for slurp
> + * 					file filter
> + * @return   a list of lines from the template file with inappropriate
> + *	    lines filtered out.
> + */
> +static semanage_list_t *make_template(genhomedircon_settings_t * s,
> +				      int (*pred) (const char *))
> +{
> +	FILE *template_file = NULL;
> +	semanage_list_t *template_data = NULL;
> +
> +	template_file = fopen(s->homedir_template_path, "r");
> +	if (!template_file)
> +		return NULL;
> +	template_data = semanage_slurp_file_filter(template_file, pred);
> +	fclose(template_file);
> +
> +	return template_data;
> +}
> +
> +static Ustr *replace_all(const char *str, const replacement_pair_t * repl)
> +{
> +	Ustr *retval = USTR_NULL;
> +	int i, num_replaced = 0;
> +
> +	if (!str || !repl)
> +		goto done;
> +	if (!(retval = ustr_dup_cstr(str)))
> +		goto done;
> +
> +	for (i = 0; repl[i].search_for; i++) {
> +		num_replaced += ustr_replace_cstr(&retval, repl[i].search_for,
> +						  repl[i].replace_with, 0);
> +	}
> +	if (!num_replaced)
> +		ustr_sc_free(&retval);
> +
> +      done:
> +	return retval;
> +}
> +
> +static int write_home_dir_context(FILE * out, semanage_list_t * tpl,
> +				  const char *user, const char *seuser,
> +				  const char *home, const char *role_prefix)
> +{
> +	replacement_pair_t repl[] = {
> +		{.search_for = TEMPLATE_SEUSER,.replace_with = seuser},
> +		{.search_for = TEMPLATE_HOME_DIR,.replace_with = home},
> +		{.search_for = TEMPLATE_ROLE,.replace_with = role_prefix},
> +		{NULL, NULL}
> +	};
> +	Ustr *line = USTR_NULL;
> +
> +	if (fprintf(out, COMMENT_USER_HOME_CONTEXT, user) < 0)
> +		return STATUS_ERR;
> +
> +	for (; tpl; tpl = tpl->next) {
> +		line = replace_all(tpl->data, repl);
> +		if (!line || !ustr_io_putfileline(&line, out))
> +			goto fail;
> +		ustr_sc_free(&line);
> +	}
> +	return STATUS_SUCCESS;
> +
> +      fail:
> +	ustr_sc_free(&line);
> +	return STATUS_ERR;
> +}
> +
> +static int write_home_root_context(FILE * out, semanage_list_t * tpl,
> +				   char *homedir)
> +{
> +	replacement_pair_t repl[] = {
> +		{.search_for = TEMPLATE_HOME_ROOT,.replace_with = homedir},
> +		{NULL, NULL}
> +	};
> +	Ustr *line = USTR_NULL;
> +
> +	for (; tpl; tpl = tpl->next) {
> +		line = replace_all(tpl->data, repl);
> +		if (!line || !ustr_io_putfileline(&line, out))
> +			goto fail;
> +		ustr_sc_free(&line);
> +	}
> +	return STATUS_SUCCESS;
> +
> +      fail:
> +	ustr_sc_free(&line);
> +	return STATUS_ERR;
> +}
> +
> +static int write_user_context(FILE * out, semanage_list_t * tpl, char *user,
> +			      char *seuser, char *role_prefix)
> +{
> +	replacement_pair_t repl[] = {
> +		{.search_for = TEMPLATE_USER,.replace_with = user},
> +		{.search_for = TEMPLATE_ROLE,.replace_with = role_prefix},
> +		{.search_for = TEMPLATE_SEUSER,.replace_with = seuser},
> +		{NULL, NULL}
> +	};
> +	Ustr *line = USTR_NULL;
> +
> +	for (; tpl; tpl = tpl->next) {
> +		line = replace_all(tpl->data, repl);
> +		if (!line || !ustr_io_putfileline(&line, out))
> +			goto fail;
> +		ustr_sc_free(&line);
> +	}
> +	return STATUS_SUCCESS;
> +
> +      fail:
> +	ustr_sc_free(&line);
> +	return STATUS_ERR;
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
> +	return strcmp(key, semanage_user_get_name(*val));
> +}
> +
> +static int push_user_entry(genhomedircon_user_entry_t ** list, const char *n,
> +			   const char *sen, const char *pre, const char *h)
> +{
> +	genhomedircon_user_entry_t *temp = NULL;
> +	char *name = NULL;
> +	char *sename = NULL;
> +	char *prefix = NULL;
> +	char *home = NULL;
> +
> +	temp = malloc(sizeof(genhomedircon_user_entry_t));
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
> +	return STATUS_SUCCESS;
> +
> +      cleanup:
> +	free(name);
> +	free(sename);
> +	free(prefix);
> +	free(home);
> +	free(temp);
> +	return STATUS_ERR;
> +}
> +
> +static void pop_user_entry(genhomedircon_user_entry_t ** list)
> +{
> +	genhomedircon_user_entry_t *temp;
> +
> +	if (!list || !(*list))
> +		return;
> +
> +	temp = *list;
> +	*list = temp->next;
> +	free(temp->name);
> +	free(temp->sename);
> +	free(temp->prefix);
> +	free(temp->home);
> +	free(temp);
> +}
> +
> +static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
> +					     int *errors)
> +{
> +	genhomedircon_user_entry_t *head = NULL;
> +	semanage_seuser_t **seuser_list = NULL;
> +	unsigned int nseusers = 0;
> +	semanage_user_t **user_list = NULL;
> +	unsigned int nusers = 0;
> +	semanage_user_t **u = NULL;
> +	const char *name = NULL;
> +	const char *seuname = NULL;
> +	const char *prefix = NULL;
> +	struct passwd *pwent = NULL;
> +	unsigned int i;
> +	int retval;
> +
> +	*errors = 0;
> +	retval = semanage_seuser_list(s->h_semanage, &seuser_list, &nseusers);
> +	if (retval < 0 || (nseusers < 1)) {
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
> +		if (strcmp(seuname, FALLBACK_USER) == 0)
> +			continue;
> +		if (strcmp(seuname, DEFAULT_LOGIN) == 0)
> +			continue;
> +		if (strcmp(seuname, TEMPLATE_SEUSER) == 0)
> +			continue;
> +
> +		/* find the user structure given the name */
> +		u = bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *),
> +			    (int (*)(const void *, const void *))
> +			    &name_user_cmp);
> +		if (u) {
> +			prefix = semanage_user_get_prefix(*u);
> +		} else {
> +			prefix = name;
> +		}
> +
> +		errno = 0;
> +		pwent = getpwnam(name);
> +		if (!pwent) {
> +			if (errno != 0) {
> +				*errors = STATUS_ERR;
> +				goto cleanup;
> +			}
> +			WARN(s->h_semanage,
> +			     "user %s not in password file", name);
> +			continue;
> +		}
> +
> +		if (strcmp(pwent->pw_dir, "/") == 0) {
> +			/* don't relabel / genhomdircon checked to see if root
> +			 * was the user and if so, set his home directory to
> +			 * /root */
> +			continue;
> +		}
> +		if (push_user_entry(&head, name, seuname,
> +				    prefix, pwent->pw_dir) != STATUS_SUCCESS) {
> +			*errors = STATUS_ERR;
> +			break;
> +		}
> +	}
> +
> +      cleanup:
> +	if (*errors) {
> +		for (; head; pop_user_entry(&head)) {
> +			/* the pop function takes care of all the cleanup
> +			   so the loop body is just empty */
> +		}
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
> +
> +	return head;
> +}
> +
> +static int write_gen_home_dir_context(FILE * out, genhomedircon_settings_t * s,
> +				      semanage_list_t * user_context_tpl,
> +				      semanage_list_t * homedir_context_tpl)
> +{
> +	genhomedircon_user_entry_t *users;
> +	int errors = 0;
> +
> +	users = get_users(s, &errors);
> +	if (!users && errors) {
> +		return STATUS_ERR;
> +	}
> +
> +	for (; users; pop_user_entry(&users)) {
> +		if (write_home_dir_context(out, homedir_context_tpl,
> +					   users->name,
> +					   users->sename, users->home,
> +					   users->prefix)) {
> +			return STATUS_ERR;
> +		}
> +		if (write_user_context(out, user_context_tpl, users->name,
> +				       users->sename, users->prefix)) {
> +			return STATUS_ERR;
> +		}
> +	}
> +
> +	return STATUS_SUCCESS;
> +}
> +
> +/**
> + * @param	s	settings structure, stores various paths etc. Must never be NULL
> + * @param	out	the FILE to put all the output in.
> + * @return	0 on success
> + */
> +static int write_context_file(genhomedircon_settings_t * s, FILE * out)
> +{
> +	semanage_list_t *homedirs = NULL;
> +	semanage_list_t *h = NULL;
> +	semanage_list_t *user_context_tpl = NULL;
> +	semanage_list_t *homedir_context_tpl = NULL;
> +	semanage_list_t *homeroot_context_tpl = NULL;
> +	int retval = STATUS_SUCCESS;
> +
> +	homedirs = get_home_dirs(s);
> +	if (!homedirs) {
> +		WARN(s->h_semanage,
> +		     "no home directories were available, exiting without writing");
> +		return STATUS_ERR;	/* No homedirs so no output */
> +	}
> +
> +	if (write_file_context_header(s, out) != STATUS_SUCCESS)
> +		return STATUS_ERR;
> +
> +	homedir_context_tpl = make_template(s, &HOME_DIR_PRED);
> +	homeroot_context_tpl = make_template(s, &HOME_ROOT_PRED);
> +	user_context_tpl = make_template(s, &USER_CONTEXT_PRED);
> +	if (!homedir_context_tpl || !homeroot_context_tpl || !user_context_tpl) {
> +		retval = STATUS_ERR;
> +		goto done;
> +	}
> +
> +	for (h = homedirs; h; h = h->next) {
> +		Ustr *temp = ustr_dup_cstr(h->data);
> +
> +		if (!temp || !ustr_add_cstr(&temp, "/[^/]*")) {
> +			ustr_sc_free(&temp);
> +			retval = STATUS_ERR;
> +			goto done;
> +		}
> +
> +		if (write_home_dir_context(out,
> +					   homedir_context_tpl, FALLBACK_USER,
> +					   FALLBACK_USER, ustr_cstr(temp),
> +					   FALLBACK_USER_PREFIX) !=
> +		    STATUS_SUCCESS) {
> +			ustr_sc_free(&temp);
> +			retval = STATUS_ERR;
> +			goto done;
> +		}
> +		if (write_home_root_context(out,
> +					    homeroot_context_tpl,
> +					    h->data) != STATUS_SUCCESS) {
> +			ustr_sc_free(&temp);
> +			retval = STATUS_ERR;
> +			goto done;
> +		}
> +
> +		ustr_sc_free(&temp);
> +	}
> +	if (write_user_context(out, user_context_tpl,
> +			       ".*", FALLBACK_USER,
> +			       FALLBACK_USER_PREFIX) != STATUS_SUCCESS) {
> +		retval = STATUS_ERR;
> +		goto done;
> +	}
> +	if (write_gen_home_dir_context(out, s, user_context_tpl,
> +				       homedir_context_tpl) != STATUS_SUCCESS) {
> +		retval = STATUS_ERR;
> +	}
> +
> +      done:
> +	/* Cleanup */
> +	semanage_list_destroy(&homedirs);
> +	semanage_list_destroy(&user_context_tpl);
> +	semanage_list_destroy(&homedir_context_tpl);
> +	semanage_list_destroy(&homeroot_context_tpl);
> +
> +	return retval;
> +}
> +
> +int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd)
> +{
> +	genhomedircon_settings_t s;
> +	FILE *out = NULL;
> +	int retval = 0;
> +
> +	assert(sh);
> +
> +	s.homedir_template_path =
> +	    semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL);
> +	s.fcfilepath = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_HOMEDIRS);
> +
> +	s.usepasswd = usepasswd;
> +	s.h_semanage = sh;
> +
> +	if (!(out = fopen(s.fcfilepath, "w"))) {
> +		/* couldn't open output file */
> +		ERR(sh, "Could not open the file_context file for writing");
> +		return STATUS_ERR;
> +	}
> +
> +	retval = write_context_file(&s, out);
> +
> +	fclose(out);
> +	return retval;
> +}
> Index: selinux-unmodified-trunk/libsemanage/src/genhomedircon.h
> ===================================================================
> --- /dev/null
> +++ selinux-unmodified-trunk/libsemanage/src/genhomedircon.h
> @@ -0,0 +1,27 @@
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
> +#ifndef _SEMANAGE_GENHOMEDIRCON_H_
> +#define _SEMANAGE_GENHOMEDIRCON_H_
> +
> +#include "utilities.h"
> +
> +int semanage_genhomedircon(semanage_handle_t * sh, int usepasswd);
> +
> +#endif
> Index: selinux-unmodified-trunk/libsemanage/src/utilities.c
> ===================================================================
> --- /dev/null
> +++ selinux-unmodified-trunk/libsemanage/src/utilities.c
> @@ -0,0 +1,312 @@
> +/* Author: Mark Goldman   <mgoldman@tresys.com>
> + *			Paul Rosenfeld	<prosenfeld@tresys.com>
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
> +#include "utilities.h"
> +
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <ctype.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <assert.h>
> +#include <ustr.h>
> +
> +#define TRUE 1
> +#define FALSE 0
> +
> +char *semanage_findval(char *file, char *var, char *delim)
> +{
> +	FILE *fd;
> +	char *buff = NULL;
> +	char *retval = NULL;
> +	size_t buff_len = 0;
> +
> +	assert(file);
> +	assert(var);
> +
> +	if ((fd = fopen(file, "r")) == NULL)
> +		return NULL;
> +
> +	while (getline(&buff, &buff_len, fd) > 0) {
> +		if (semanage_is_prefix(buff, var)) {
> +			retval = semanage_split(buff, delim);
> +			if (retval)
> +				semanage_rtrim(retval, '\n');
> +			break;
> +		}
> +	}
> +	free(buff);
> +	fclose(fd);
> +
> +	return retval;
> +}
> +
> +int semanage_is_prefix(const char *str, const char *prefix)
> +{
> +	int retval;
> +	Ustr *ustr = USTR_NULL;
> +
> +	if (!str) {
> +		return FALSE;
> +	}
> +	if (!prefix) {
> +		return TRUE;
> +	}
> +	if (!(ustr = ustr_dup_cstr(str))) {
> +		return FALSE;
> +	}
> +	retval = (ustr_srch_cstr_fwd(ustr, 0, prefix) == 1);
> +	ustr_sc_free(&ustr);
> +
> +	return retval;
> +}
> +
> +char *semanage_split_on_space(const char *str)
> +{
> +	/* as per the man page, these are the isspace() chars */
> +	const char *seps = "\f\n\r\t\v ";
> +	size_t slen = strlen(seps);
> +	size_t off = 0, rside_len = 0;
> +	char *retval = NULL;
> +	Ustr *ustr = USTR_NULL, *temp = USTR_NULL;
> +
> +	if (!str)
> +		goto done;
> +	if (!(ustr = ustr_dup_cstr(str)))
> +		goto done;
> +	temp =
> +	    ustr_split_spn_chrs(ustr, &off, seps, slen, USTR_NULL,
> +				USTR_FLAG_SPLIT_DEF);
> +	if (!temp)
> +		goto done;
> +	/* throw away the left hand side */
> +	ustr_sc_free(&temp);
> +
> +	rside_len = ustr_len(ustr) - off;
> +	temp = ustr_dup_subustr(ustr, off + 1, rside_len);
> +	if (!temp)
> +		goto done;
> +	retval = strdup(ustr_cstr(temp));
> +	ustr_sc_free(&temp);
> +
> +      done:
> +	ustr_sc_free(&ustr);
> +	return retval;
> +}
> +
> +char *semanage_split(const char *str, const char *delim)
> +{
> +	Ustr *ustr = USTR_NULL, *temp = USTR_NULL;
> +	size_t off = 0, rside_len = 0;
> +	char *retval = NULL;
> +
> +	if (!str)
> +		goto done;
> +	if (!delim || !(*delim))
> +		return semanage_split_on_space(str);
> +	ustr = ustr_dup_cstr(str);
> +	temp =
> +	    ustr_split_cstr(ustr, &off, delim, USTR_NULL, USTR_FLAG_SPLIT_DEF);
> +	if (!temp)
> +		goto done;
> +	/* throw away the left hand side */
> +	ustr_sc_free(&temp);
> +
> +	rside_len = ustr_len(ustr) - off;
> +
> +	temp = ustr_dup_subustr(ustr, off + 1, rside_len);
> +	if (!temp)
> +		goto done;
> +	retval = strdup(ustr_cstr(temp));
> +	ustr_sc_free(&temp);
> +
> +      done:
> +	ustr_sc_free(&ustr);
> +	return retval;
> +}
> +
> +int semanage_list_push(semanage_list_t ** list, char *data)
> +{
> +	semanage_list_t *temp = NULL;
> +
> +	if (!data)
> +		return EINVAL;
> +	if (!(temp = malloc(sizeof(semanage_list_t))))
> +		return ENOMEM;
> +
> +	if (!(temp->data = strdup(data))) {
> +		free(temp);
> +		return ENOMEM;
> +	}
> +	temp->next = *list;
> +	*list = temp;
> +
> +	return 0;
> +}
> +
> +char *semanage_list_pop(semanage_list_t ** list)
> +{
> +	semanage_list_t *node = NULL;
> +	char *data = NULL;
> +
> +	if (!list || !(*list))
> +		return NULL;
> +
> +	node = (*list);
> +	data = node->data;
> +
> +	(*list) = node->next;
> +	free(node);
> +
> +	return data;
> +}
> +
> +void semanage_list_destroy(semanage_list_t ** list)
> +{
> +	semanage_list_t *temp;
> +
> +	while ((temp = (*list))) {
> +		free(temp->data);
> +		(*list) = temp->next;
> +		free(temp);
> +	}
> +}
> +
> +semanage_list_t *semanage_list_find(semanage_list_t * l, char *data)
> +{
> +	if (!data)
> +		return NULL;
> +	while (l && strcmp(l->data, data))
> +		l = l->next;
> +
> +	return l;
> +}
> +
> +int semanage_list_sort(semanage_list_t ** l)
> +{
> +	semanage_list_t **array = NULL;
> +	semanage_list_t *temp = NULL;
> +	size_t count = 0;
> +	size_t i = 0;
> +
> +	if (!l)
> +		return 0;
> +
> +	for (temp = *l; temp; temp = temp->next)
> +		++count;
> +
> +	array = malloc(sizeof(semanage_list_t *) * count);
> +	if (!array)
> +		return ENOMEM;	/* couldn't allocate memory for sort */
> +	for (temp = *l; temp; temp = temp->next) {
> +		array[i++] = temp;
> +	}
> +
> +	qsort(array, count, sizeof(semanage_list_t *),
> +	      (int (*)(const void *, const void *))&semanage_cmp_plist_t);
> +	for (i = 0; i < (count - 1); ++i) {
> +		array[i]->next = array[i + 1];
> +	}
> +	array[i]->next = NULL;
> +	(*l) = array[0];
> +	free(array);
> +
> +	return 0;
> +}
> +
> +int semanage_cmp_plist_t(const semanage_list_t ** x, const semanage_list_t ** y)
> +{
> +	return strcmp((*x)->data, (*y)->data);
> +}
> +
> +int semanage_str_count(char *data, char what)
> +{
> +	int count = 0;
> +
> +	if (!data)
> +		return 0;
> +	while (*data) {
> +		if (*data == what)
> +			++count;
> +		++data;
> +	}
> +
> +	return count;
> +}
> +
> +void semanage_rtrim(char *str, char trim_to)
> +{
> +	int len = 0;
> +
> +	if (!str)
> +		return;
> +	len = strlen(str);
> +
> +	while (len > 0) {
> +		if (str[--len] == trim_to) {
> +			str[len] = '\0';
> +			return;
> +		}
> +	}
> +}
> +
> +/* list_addafter_controlmem does *NOT* duplicate the data argument
> + * use at your own risk, I am building a list out of malloc'd memory and
> + * it is only going to get stored into this list, thus when I destroy it
> + * later I won't free a ptr twice.
> + *
> + * returns the newly created node or NULL on error
> + */
> +semanage_list_t *list_addafter_controlmem(semanage_list_t * item, char *data)
> +{
> +	semanage_list_t *temp = malloc(sizeof(semanage_list_t));
> +
> +	if (!temp)
> +		return NULL;
> +	temp->data = data;
> +	temp->next = item->next;
> +	item->next = temp;
> +
> +	return temp;
> +}
> +
> +semanage_list_t *semanage_slurp_file_filter(FILE * file,
> +					    int (*pred) (const char *))
> +{
> +	semanage_list_t head;
> +	semanage_list_t *current = &head;
> +	char *line = NULL;
> +	size_t buff_len = 0;
> +
> +	head.next = NULL;	/* initialize head, we aren't going to use the data */
> +	while (getline(&line, &buff_len, file) >= 0) {
> +		if (pred(line)) {
> +			semanage_rtrim(line, '\n');
> +			current = list_addafter_controlmem(current, line);
> +			if (!current) 
> +				break;
> +			line = NULL;
> +			buff_len = 0;
> +		}
> +	}
> +	free(line);
> +
> +	return head.next;
> +}
> Index: selinux-unmodified-trunk/libsemanage/src/utilities.h
> ===================================================================
> --- /dev/null
> +++ selinux-unmodified-trunk/libsemanage/src/utilities.h
> @@ -0,0 +1,137 @@
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
> +/* This file contains helper functions that are loosely based off of what is
> + * available from the python script genhomedircon.  Also this file contains
> + * c implementations of a couple of python functions so that genhomedircon will
> + * look/act like the python script.
> + */
> +#ifndef _SEMANAGE_UTILITIES_H_
> +#define _SEMANAGE_UTILITIES_H_
> +
> +#include <stdio.h>
> +
> +#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
> +#define WARN_UNUSED \
> +	__attribute__ ((__warn_unused_result__))
> +#else
> +# define WARN_UNUSED		/* nothing */
> +#endif
> +
> +typedef struct list {
> +	char *data;
> +	struct list *next;
> +} semanage_list_t;
> +
> +/**
> + * @param file  the path to the file to look for a variable in
> + * @param var   the variable that you want the value of
> + * @param delim the value that separates the part you care about from the part
> + *	       that you don't.
> + * @return for the first instance of var in the file, returns everything after
> + *	   delim.
> + *	   returns "" if not found IE if(*(semanage_findval(f,v,d)) == '\0'){
> + *					  printf("%s not found in file", v);
> + *				       }
> + *
> + *	   NULL for error (out of memory, etc)
> + */
> +char *semanage_findval(char *file, char *var, char *delim) WARN_UNUSED;
> +
> +/**
> + * @param str   string to test
> + * @param	 val   prefix
> + * @return  1 if val is the prefix of str
> + *	    0 if val is not the prefix of str
> + *
> + * note: if str == NULL, returns false
> + *	 if val == NULL, returns true --nothing can always be the prefix of
> + *				        something
> + *	 if (*val) == "" returns true same as above.
> + */
> +int semanage_is_prefix(const char *str, const char *val) WARN_UNUSED;
> +
> +/**
> + * @param str   the string to semanage_split
> + * @return     malloc'd string after the first run of charachters that aren't whitespace
> + */
> +char *semanage_split_on_space(const char *str) WARN_UNUSED;
> +
> +/**
> + * @param	 str   the string to semanage_split
> + * @param	 delim the string delimiter.  NOT a set of charachters that can be
> + *	       a delimiter.
> + *	       if *delim == '\0' behaves as semanage_splitOnSpace()
> + * @return   a ptr to the first charachter past the delimiter.
> + *	    if delim doesn't appear in the string, returns a ptr to the
> + *	    trailing null in the string
> + */
> +char *semanage_split(const char *str, const char *delim) WARN_UNUSED;
> +
> +/* linked list string functions
> + * Functions allocate memory.  Must be free'd with
> + * either semanage_list_pop until list == NULL or semanage_list_destroy()
> + */
> +int semanage_list_push(semanage_list_t ** list, char *data) WARN_UNUSED;
> +char *semanage_list_pop(semanage_list_t ** list);
> +void semanage_list_destroy(semanage_list_t ** list);
> +semanage_list_t *semanage_list_find(semanage_list_t * l,
> +				    char *data) WARN_UNUSED;
> +int semanage_list_sort(semanage_list_t ** l) WARN_UNUSED;
> +/* function to compare 2 semanage_list_t nodes,
> + * returns strcmp(x->data, y->data)
> + * used internally by semanage_list_sort()
> + */
> +int semanage_cmp_plist_t(const semanage_list_t ** x,
> +			 const semanage_list_t ** y);
> +/**
> + * @param      data a target string
> + * @param      what  a charachter
> + * @returns    the number of times the char appears in the string
> + */
> +int semanage_str_count(char *data, char what);
> +/**
> + * @param      - a string
> + * @param            the charachter to trim to
> + * @return   - mangles the string, converting the first
> + *             occurrance of the charachter to a '\0' from
> + *             the end of the string.
> + */
> +void semanage_rtrim(char *str, char trim_to);
> +
> +/**
> + * @param data    some string
> + * @return  modifies the string such that the first whitespace char becomes
> + *	    '\0', ending the string.
> + */
> +void semanage_keep_until_space(char *data);
> +
> +/**
> + * @param    file    - an open FILE to read from
> + * @param    pred    - a function taking a string that
> + *                    returns 1 if the string should be
> + *                    kept and 0 otherwise
> + * @return  a list of lines from the file (empty lines become
> + *          empty strings) in the file order where pred(line)
> + *          returns > 0
> + */
> +semanage_list_t *semanage_slurp_file_filter(FILE * file,
> +					    int (*pred) (const char *))
> +    WARN_UNUSED;
> +#endif
> Index: selinux-unmodified-trunk/libsemanage/src/Makefile
> ===================================================================
> --- selinux-unmodified-trunk.orig/libsemanage/src/Makefile
> +++ selinux-unmodified-trunk/libsemanage/src/Makefile
> @@ -54,7 +54,7 @@ $(LIBA): $(OBJS)
>  	ranlib $@
>  
>  $(LIBSO): $(LOBJS)
> -	$(CC) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
> +	$(CC) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
>  	ln -sf $@ $(TARGET)
>  
>  conf-scan.c: conf-scan.l conf-parse.h
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
