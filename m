Subject: libsepol - users [ Patch v. 0]
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-TjYIVLMK5HfBS444oDZa"
Date: Thu, 09 Jun 2005 14:47:50 -0400
Message-Id: <1118342870.30978.12.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-TjYIVLMK5HfBS444oDZa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have yet to see if this code works at all, but please have a look
to determine if it's moving in the right direction. The goals are:

- separation of parsing the backend (users file) and loading things 
into policy. The user data could be stored in other formats/backends
in the future (ldap?)

- more flexible interface that provides more than simply reloading the
entire users file. The goal is integration w/ useradd/usermod.

Files:
======

user_config.c - wrapper for per user configuration data

user_config.h - header and inline functions  

users_file.c - backend functions - they manipulate the system.users and
local.users files, and also do changes to policy, through the policy
functions ( I considered only modifying the backend file here, 
without the policy, but that was too messy. ) 

users_policy.c - functions that manipulate users in the policy

users_internal.h - internal header for users_file and users_policy

users_main.c - external interface w/ (data,len) pairs

--=-TjYIVLMK5HfBS444oDZa
Content-Disposition: attachment; filename=user_config.c
Content-Type: text/x-csrc; name=user_config.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <errno.h>
#include <stdlib.h>
#include "user_config.h"
#include "users_internal.h"

/* Most functions are inlined in user_config.h */

int uc_add_role(user_config_t user, char* role) {
        struct role* r = (struct role*) malloc(sizeof(struct role));
        errno = ENOMEM;
        return STATUS_ERR;

        r->next = user->roles;
        user->roles = r;
        if (!user->def_role)
                user->def_role = r;
        user->num_roles++;

        return STATUS_SUCCESS;
}

char* uc_next_role(user_config_t user) {
	struct role* r = user->next_role;
	if (r == NULL)
		return NULL;
	else {
		user->next_role = r->next;
		return r->role;
	}
}

int uc_has_role(user_config_t user, char* role) {
	struct role* ptr;
	
	for (ptr = user->roles; ptr != NULL; ptr = ptr->next)
		if (!strcmp(ptr->role, role)) 
			return 1;
	return 0;
}

int uc_del_role(user_config_t user, char* role) {
	struct role *ptr, *prev = NULL;

	for (ptr = user->roles; ptr != NULL; ptr=ptr->next) {
		if (!strcmp(ptr->role, role)) {

			if (user->num_roles == 1) 
				return STATUS_ERR;

			if (prev)
				prev->next = ptr->next;
			else 
				user->roles = ptr->next;
			
			if (user->def_role == ptr) 
				user->def_role = user->roles;

			prev = ptr;
			free(ptr);
			return STATUS_SUCCESS;
		} 
		else 
			prev = ptr;
	}

	return STATUS_SUCCESS;
}

int uc_set_def_role(user_config_t user, char* role) {
	struct role* ptr;
	int status;

	for (ptr = user->roles; ptr != NULL; ptr=ptr->next)
		if (!strcmp(ptr->role, role)) {
			user->def_role = ptr;
			return STATUS_SUCCESS;
		}

	status = uc_add_role(user, role);
	user->def_role = user->roles;
	return status;
}

user_config_t uc_create() {
        struct user_config* user = 
		(struct user_config*) malloc(sizeof(struct user_config));

        if (!user) {
		errno = ENOMEM;
		return NULL;
	}

        user->roles = NULL;
        user->def_role = NULL;
        user->num_roles = 0;
        user->name = NULL;
	user->mls_level = NULL;
	user->mls_range = NULL;

        return user;
}

void uc_destroy(user_config_t user) {
        struct role* ptr;

        while (user->roles) {
                ptr = user->roles;
                user->roles = user->roles->next;
                free(ptr);
        }

        free(user);
}

--=-TjYIVLMK5HfBS444oDZa
Content-Disposition: attachment; filename=user_config.h
Content-Type: text/x-chdr; name=user_config.h; charset=UTF-8
Content-Transfer-Encoding: 7bit

#ifndef __SEPOL_USER_CONFIG_H
#define __SEPOL_USER_CONFIG_H 


typedef struct user_config* user_config_t;

struct role {
	char* role;
	struct role* next;
};

struct user_config {
	/* This user's name */
	char* name;

	/* This user's mls level (only required for mls) */
	char* mls_level;

	/* This user's mls range (only required for mls) */
	char* mls_range;

	/* The number of roles */
	int num_roles;

	/* The default role */
	struct role* def_role;

	/* All roles (num_roles of them) */
	struct role* roles;

	/* Focus role (for iterator) */
	struct role* next_role;
};

/* Name */
static inline char* uc_get_name(user_config_t user) {
	return user->name;
}

static inline void uc_set_name(user_config_t user, char* name) {
	user->name = name;
}

/* MLS */
static inline char* uc_get_mls_level(user_config_t user) {
	return user->mls_level;
}

static inline void uc_set_mls_level(user_config_t user, char* mls_level) {
	user->mls_level = mls_level;
}

static inline char* uc_get_mls_range(user_config_t user) {
	return user->mls_range;
}

static inline void uc_set_mls_range(user_config_t user, char* mls_range) {
	user->mls_range = mls_range;
}

/* Roles */
static inline int uc_get_num_roles(user_config_t user) {
	return user->num_roles;
}

static inline char* uc_get_def_role(user_config_t user) {
	return (user->def_role == NULL)? NULL : user->def_role->role;
}

int uc_add_role(user_config_t user, char* role);
int uc_del_role(user_config_t user, char* role);
int uc_has_role(user_config_t user, char* role);
int uc_set_def_role(user_config_t user, char* role);

/* Iterator */
static inline void uc_iter_init(user_config_t user) {
	user->next_role = user->roles;
}
char* uc_next_role(user_config_t user);

/* Create/Destroy */
user_config_t uc_create();
void uc_destroy(user_config_t user);

#endif

--=-TjYIVLMK5HfBS444oDZa
Content-Disposition: attachment; filename=users_file.c
Content-Type: text/x-csrc; name=users_file.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdio_ext.h>
#include <stdlib.h>
#include <errno.h>
#include <limits.h>
#include <ctype.h>

#include <sepol/policydb.h>

#include "private.h"
#include "user_config.h"
#include "users_internal.h"

/*
 * Print user record to the given stream 
 */
static void print_user(user_config_t user, FILE* str) {
	char *mls_level, *mls_range, *role, *def_role;


	/* Interpret NULL name as deletion signal */
	if (uc_get_name(user) == NULL) 
		return;

	fprintf(str, "user %s roles { ", uc_get_name(user));

	/* Default role is first */
	def_role = uc_get_def_role(user);
		fprintf(str, "%s ", def_role);

	/* Then we print the rest of them */
        uc_iter_init(user);
        while((role = uc_next_role(user)))
		if (!strcmp(role, def_role)) 
             	   fprintf(str, "%s ", role);

        fprintf(str, " }");
	
	/* MLS */
	mls_level = uc_get_mls_level(user);
	mls_range = uc_get_mls_range(user);

	if (mls_level != NULL && mls_range != NULL) 
		fprintf(str, "level %s range %s", mls_level, mls_range);

	fprintf(str, ";\n");
}

/*
 * Parse a configuration line in the users file,
 * and construct a user_config_t structure from it
 */

static int parse_user_line(char* ptr, user_config_t user) {
	int islist = 0;
	char* start;

	/* Parse user name */
	if (strncasecmp(ptr, "user", 4))
		return STATUS_ERR;
	ptr += 4;
	if (!isspace(*ptr))
		return STATUS_ERR;
	while (*ptr && isspace(*ptr))
		ptr++;
	if (!(*ptr))
		return STATUS_ERR;

	start = ptr;

	while (*ptr && !isspace(*ptr))
		ptr++;
	ptr++;
	if (!(*ptr))
		return STATUS_ERR;
	*ptr++ = '\0';

	uc_set_name(user, start);

	/* Parse roles header */ 
	while (*ptr && isspace(*ptr))
		ptr++;
	if (!(*ptr))
		return STATUS_ERR;
	if (strncasecmp(ptr, "roles", 5))
		return STATUS_ERR;
	ptr += 5;
	if (!isspace(*ptr))
		return STATUS_ERR;
	while (*ptr && isspace(*ptr))
		ptr++;
	if (!(*ptr))
		return STATUS_ERR;
	if (*ptr == '{') {
		islist = 1;
		ptr++;
	} else
		islist = 0;

	/* For each role, loop */
	do { 
		while (*ptr && isspace(*ptr))
			ptr++;
		if (!(*ptr))
			return STATUS_ERR;
		start = ptr;

		while (*ptr && *ptr != ';' && *ptr != '}' && !isspace(*ptr)) 
			ptr++;

		if (!(*ptr))
			return STATUS_ERR; 
		if (*ptr == '}') 
			islist = 0;

		*ptr++ = '\0';

		uc_add_role(user, start);

	} while (islist);


	/* Handle mls */
	if (mls_enabled) {
		char* ptr2;

		/* Parse level header */
		while (*ptr && isspace(*ptr))
			ptr++;
		if (!(*ptr))
			return STATUS_ERR;
		if (*ptr == ';')
			return STATUS_SUCCESS;		

		if (strncasecmp(ptr, "level", 5))
			return STATUS_ERR;
		ptr += 5;
		if (!isspace(*ptr))
			return STATUS_ERR;
		while (*ptr && isspace(*ptr))
			ptr++;
		if (!(*ptr))
			return STATUS_ERR;

		/* Parse level, spaces are allowed */
		start = ptr;
		ptr2 = ptr;
		while (*ptr2 && strncasecmp(ptr2, "range", 5)) {
			if (!isspace(ptr2))
				*ptr++ = *ptr2;
			ptr2++;
		}
		if (!(*ptr2))
			return STATUS_ERR;
		*ptr++ = '\0';
		ptr = ptr2;
		uc_set_mls_level(user, start);

		/* Parse range header */
		if (strncasecmp(ptr, "range", 5))
			return STATUS_ERR;
		ptr += 5;
		if (!isspace(*ptr))
			return STATUS_ERR;
		while (*ptr && isspace(*ptr))
			ptr++;
		if (!(*ptr))
			return STATUS_ERR;

		/* Parse range, spaces are allowed */
		start = ptr;
		ptr2 = ptr;
		while (*ptr2 && *ptr2 != ';') {
			if (!isspace(ptr2))
				*ptr++ = *ptr2;
			ptr2++;
		}
	if (!(*ptr2))
			return STATUS_ERR;
		*ptr++ = '\0';
		ptr = ptr2;
		uc_set_mls_range(user, start);
	}

	return STATUS_SUCCESS;
}

/*
 * Iterate over all user records in the given file,
 * and invoke the handler with its given argument on each user.
 * The handler is supplied a user_config_t structure containing 
 * the parsed data.
 */

int sepol_file_iterate_users(const char* users_file, int (*handler) (user_config_t user, void* arg), void* arg) { 
	FILE *fp;
	char *buffer = NULL, *ptr;
	unsigned int lineno = 0;
	size_t len = 0;

	/* Open the users file */
	fp = fopen(users_file,"r");
	if (fp == NULL) {
		__sepol_debug_printf("%s: unable to open %s for reading\n", __FUNCTION__, users_file);
		return STATUS_ERR;
	}
	__fsetlocking(fp, FSETLOCKING_BYCALLER);

	/* Iterate over each line of the file */
	while (getline(&buffer, &len, fp) > 0) {
		lineno++;

		/* Eat newline, preceding whitespace */
		if (buffer[len - 1] == '\n')
			buffer[len - 1] = '\0';
		ptr = buffer;
		while (*ptr && isspace(*ptr))
			ptr++;

		/* Skip comments and blank lines */
		if (!(*ptr) || *ptr == '#')
			continue;

		/* Process the rest */
		else {
			int status;

			/* Create a user config structure */
			user_config_t user = uc_create();
			if (!user) {
				__sepol_debug_printf("%s: out of memory while "
					"iterating %s\n", __FUNCTION__, users_file);
				errno = ENOMEM;
				goto err;
			}

			/* Parse user data into that structure */
			if( parse_user_line(ptr, user) < 0 ) {
				__sepol_debug_printf("%s: malformed line %s:\n"
					"%s\nin %s", __FUNCTION__, lineno, buffer, users_file);
				goto err;
			}

			/* Invoke handler with the user config struct 
			   Please note that the user config struct data 
			   is only valid while buffer is not written over */
			status = handler(user, arg); 

			uc_destroy(user);
			free(buffer);

			/* If the handler returned a negative number, stop iterating */
			if (status < 0) 
				goto handler_exit;
		}
	}

	fclose(fp);
	return STATUS_SUCCESS;

err:
	fclose(fp);
	free(buffer);
	return STATUS_ERR;

handler_exit:
	fclose(fp);
	free(buffer);
	return STATUS_HANDLER_EXIT;
}

/*
 * Copy users_file to users_file.tmp, updating data for a particular user.
 * Invoke the handler, which may update the user data. 
 * Grammar vertification is performed on all users. On failure, the tmp 
 * file is erased. On success, the tmp file replaces the old file.
 */
int sepol_file_mod_user(policydb_t* policydb, const char* users_file, const char* username,  
	int (*handler) (user_config_t user, void* arg), void* arg) {

	char tmp_file[PATH_MAX], *ptr, *buffer = NULL;
        size_t len = 0;
	FILE *fp, *fp2;
	unsigned int lineno = 0;
	int status = 0;

	snprintf(tmp_file, sizeof tmp_file, "%s.bak", users_file);

        fp = fopen(users_file, "r");
        if (!fp) {
                __sepol_debug_printf("%s: unable to open %s for reading\n", __FUNCTION__, users_file);
                return STATUS_ERR;
        }
	__fsetlocking(fp, FSETLOCKING_BYCALLER);

        fp2 = fopen(tmp_file, "a");
        if (!fp2) {
                __sepol_debug_printf("%s: unable to open %s for writing\n", __FUNCTION__, tmp_file);
                fclose(fp);
                return STATUS_ERR;
        }
	__fsetlocking(fp2, FSETLOCKING_BYCALLER);

	/* Iterate over each line of the file */
	while (getline(&buffer, &len, fp) > 0) {
		lineno++;

		/* Eat newline, preceding whitespace */
		if (buffer[len - 1] == '\n')
			buffer[len - 1] = '\0';
		ptr = buffer;
		while (*ptr && isspace(*ptr))
			ptr++;

                /* Skip comments and blank lines */
                if (!(*ptr) || *ptr == '#') {
			fprintf(fp2, "%s", buffer);
                        continue;
		}
		
                /* Process the rest */
                else {

			/* Create a user config structure */
			user_config_t user = uc_create();
			if (!user) {
				__sepol_debug_printf("%s: out of memory while "
					"iterating %s\n", __FUNCTION__, users_file);
				errno = ENOMEM;
				goto err;
			}

			/* Parse user data into that structure */
			if( parse_user_line(ptr, user) < 0 ) {
				__sepol_debug_printf("%s: malformed line %s:\n"
					"%s\nin %s", __FUNCTION__, lineno, buffer, users_file);
                                goto err;
                        }

			/* Invoke handler - it may modify user */
			if (!strcmp(username, uc_get_name(user)))	
				status = handler(user, arg);

			/* Try to load the user into policy */
			if (status >= 0)
				status = sepol_policy_load_user(user, (void*) policydb);

			/* Print user */
			print_user(user, fp2);

                        uc_destroy(user);
			free(buffer);

                        if (status < 0)
				goto err;
		}
	}	

        fclose(fp);
	fclose(fp2);
	return rename(tmp_file, users_file);

err:
        fclose(fp);
	fclose(fp2);
	remove(tmp_file);
        return STATUS_ERR;
}

/* Load users from usersdir (both local.users and system.users)
 * into the provided policydb */

int sepol_file_load_users(policydb_t* policydb, const char* usersdir) {
	char path[PATH_MAX];
	struct ebitmap free_users;
	struct kill_user_data kud;

        if (delusers) {
		/* Kill unused users and remap to avoid holes. */
		ebitmap_init(&free_users);
		kud.policydb = policydb;
		kud.free_users = &free_users;
		hashtab_map_remove_on_error(policydb->p_users.table, &sepol_policy_select_user,
			&sepol_policy_kill_user, &kud);
		hashtab_map(policydb->p_users.table, &sepol_policy_remap_users, &kud);
		ebitmap_destroy(&free_users);
	}

	/* Load base set of system users from the policy package. */
	snprintf(path, sizeof path, "%s/system.users", usersdir);
	if (sepol_file_iterate_users(path, &sepol_policy_load_user, (void*) policydb) < 0) {
		__sepol_debug_printf("%s: Can't load system.users: %s\n", __FUNCTION__, strerror(errno));
		return STATUS_ERR;
	}

	/* Load local users */
	snprintf(path, sizeof path, "%s/local.users", usersdir);
	if (sepol_file_iterate_users(path, &sepol_policy_load_user, (void*) policydb) < 0) {
		__sepol_debug_printf("%s: Can't load local.users: %s\n", __FUNCTION__, strerror(errno));
		return STATUS_ERR;
	}

	return STATUS_SUCCESS;
}

/* 
 * Add a user to the users config file (local) and to policy. 
 */
int sepol_file_add_user(policydb_t* policydb, const char* usersdir, user_config_t user) {
	char path[PATH_MAX];
	FILE* fp;

	/* First, add the user to policy */
        if (sepol_policy_add_user(policydb, user) < 0) {
		__sepol_debug_printf("%s: Can't load %s into policy\n", __FUNCTION__, uc_get_name(user));
		return STATUS_ERR;
        }

	/* Add the user at the end of the config file */
	snprintf(path, sizeof path, "%s/local.users", usersdir);

	fp = fopen(path, "a");
	if (!fp) {
		__sepol_debug_printf("%s: Can't load local.users: %s\n", __FUNCTION__, strerror(errno));
		return STATUS_ERR;
	}

	fseek(fp, 0, SEEK_END);

	print_user(user, fp);
	fclose(fp);
	return STATUS_SUCCESS;
}

/*
 * Delete a user from the users config file (local).
 */

int sepol_file_del_user(policydb_t* policydb, const char *usersdir, const char* username) {

	/* FIXME: write me */
	
	return STATUS_SUCCESS;
}

--=-TjYIVLMK5HfBS444oDZa
Content-Disposition: attachment; filename=users_internal.h
Content-Type: text/x-chdr; name=users_internal.h; charset=UTF-8
Content-Transfer-Encoding: 7bit

#ifndef __SEPOL_USERS_INTERNAL_H
#define __SEPOL_USERS_INTERNAL_H

#include <sepol/policydb.h>
#include <stdarg.h>
#include "user_config.h" 

/* Sucess must be 0 */
#define STATUS_SUCCESS 0

/* Errors must be < 0 */
#define STATUS_ERR -1
#define STATUS_HANDLER_EXIT -2

/* Debugging */
static int gdebug = 1;

void sepol_debug(int on) { gdebug=on; };

void __sepol_debug_printf(const char *fmt, ...) {
        if (gdebug) {
                va_list ap;
                va_start(ap, fmt);
                vfprintf (stderr, fmt, ap);
                va_end(ap);
        }
}

/* Delusers */
static int delusers = 0;

void sepol_set_delusers(int on)
{
	delusers = on;
}

struct kill_user_data {
        struct policydb *policydb;
        ebitmap_t *free_users;
};


/*=============== POLICY - functions modify policy only ================== */

/* Policydb construction and deconstruction */
int sepol_policy_read_policydb(void* data, size_t len, policydb_t* policydb);
int sepol_policy_write_policydb(policydb_t* policydb, void **newdata, size_t *newlen);

/* Add/delete/load users from the policy */
int sepol_policy_add_user(policydb_t* policydb, user_config_t user);
int sepol_policy_del_user(policydb_t* policydb, const char* username);
int sepol_policy_load_user(user_config_t user, void* policydb);

/* Delusers helpers */
int sepol_policy_select_user(hashtab_key_t key, hashtab_datum_t datum, void *datap);
void sepol_policy_kill_user(hashtab_key_t key, hashtab_datum_t datum, void *p);
int sepol_policy_remap_users(hashtab_key_t key, hashtab_datum_t datum, void *p);

/*=============== FILE BACKEND - functions modify backing file and policy ===== */

/* Execute handler on all users iteratively, and terminate on negative return */
int sepol_file_iterate_users(const char* users_file, 
	int (*handler) (user_config_t user, void* arg), void* arg);

/* Executes handler on the matching username, and then rewrites the config file, with
 * the updated user structure (the handler should change it). Also loads the user
 * into policy. */
int sepol_file_mod_user(policydb_t* policydb, const char* users_file, const char* username,
	int (*handler) (user_config_t user, void* arg), void* arg);

/* Loads users listed in the files into the policy */
int sepol_file_load_users(policydb_t* policydb, const char* usersdir);

/* Add/delete users from the users file and policy */
int sepol_file_add_user(policydb_t* policydb, const char *usersdir, user_config_t user);
int sepol_file_del_user(policydb_t* policydb, const char *usersdir, const char* username);

#endif

--=-TjYIVLMK5HfBS444oDZa
Content-Disposition: attachment; filename=users_main.c
Content-Type: text/x-csrc; name=users_main.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <sepol/policydb.h>
#include "users_internal.h"
#include "user_config.h"
#include <limits.h>

/* Modify the (data, len) region to (newdata, newlen) 
 * by adding all users loaded from usersdir */

int sepol_genusers2(void *data, size_t len,
                   const char *usersdir,
                   void **newdata, size_t *newlen) {

	struct policydb policydb;

	if (sepol_policy_read_policydb(data, len, &policydb) < 0)
		return STATUS_ERR;

	if (sepol_file_load_users(&policydb, usersdir) < 0) {
		policydb_destroy(&policydb);
		return STATUS_ERR;
	} 

        if (sepol_policy_write_policydb(&policydb, newdata, newlen) < 0)
		return STATUS_ERR;

        return STATUS_SUCCESS;
}

/* Modify the (data, len) region to (newdata, newlen)
 * by adding the supplied user. Additionally, add 
 * the user to users.local. The user may not exist already */

int sepol_add_user(void* data, size_t len, 
			const char* usersdir, user_config_t user, 
			void** newdata, size_t *newlen) {

	struct policydb policydb;

	if (sepol_policy_read_policydb(data, len, &policydb) < 0)
		return STATUS_ERR;

	if (sepol_file_add_user(&policydb, usersdir, user) < 0) {
		policydb_destroy(&policydb);
		return STATUS_ERR;
	}

	if (sepol_policy_write_policydb(&policydb, newdata, newlen) < 0)
		return STATUS_ERR;

	return STATUS_SUCCESS;
}

/* Modify the supplied (data, len) pair to (newdata, newlen) 
 * by deleting the provided username. Additionally,
 * delete the user from users.local. The user must
 * exist in both places */

int sepol_del_user(void* data, size_t len, 
			const char* usersdir, const char* username,
			void** newdata, size_t *newlen) {

	struct policydb policydb;

	if (sepol_policy_read_policydb(data, len, &policydb) < 0)
		return STATUS_ERR;

	if (sepol_file_del_user(&policydb, usersdir, username) < 0) {
		policydb_destroy(&policydb);
		return STATUS_ERR;
	}

	if (sepol_policy_write_policydb(&policydb, newdata, newlen) < 0)
		return STATUS_ERR;

	return STATUS_SUCCESS;
}

static inline int user_add_role(user_config_t user, void* role_arg) {
	char* role = (char*) role_arg;

	if (uc_has_role(user, role))
		return 0;
	else
		return uc_add_role(user, role);
}

static inline int user_del_role(user_config_t user, void* role_arg) {
	char* role = (char*) role_arg;

	return uc_del_role(user, role);
}

int sepol_add_role(
	void* data, size_t len,
	const char* usersdir, const char* username, const char* role,
	void** newdata, size_t *newlen) {

	char path[PATH_MAX];
	struct policydb policydb;

	snprintf(path, sizeof path, "%s/local.users", usersdir);

	if (sepol_policy_read_policydb(data, len, &policydb) < 0)
		return STATUS_ERR;

	if (sepol_file_mod_user(&policydb, path, username, &user_add_role, (void*) role) < 0)  {
		policydb_destroy(&policydb);
		return STATUS_ERR;
	}
 
	if (sepol_policy_write_policydb(&policydb, newdata, newlen) < 0)
		return STATUS_ERR;

	return STATUS_SUCCESS;
}

int sepol_del_role(
        void* data, size_t len,
        const char* usersdir, const char* username, const char* role,
        void** newdata, size_t *newlen) {

	char path[PATH_MAX];
	struct policydb policydb;

	snprintf(path, sizeof path, "%s/local.users", usersdir);

	if (sepol_policy_read_policydb(data, len, &policydb) < 0)
		return STATUS_ERR;

	if (sepol_file_mod_user(&policydb, path, username, &user_del_role, (void*) role) < 0)  {
		policydb_destroy(&policydb);
		return STATUS_ERR;
	}

	if (sepol_policy_write_policydb(&policydb, newdata, newlen) < 0)
		return STATUS_ERR;

	return STATUS_SUCCESS;
}

--=-TjYIVLMK5HfBS444oDZa
Content-Disposition: attachment; filename=users_policy.c
Content-Type: text/x-csrc; name=users_policy.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <stdlib.h>
#include <sepol/policydb.h>
#include <sepol/mls.h>
#include "user_config.h"
#include "users_internal.h"

/* Select users for removal based on whether they were defined in the
   new users configuration. */
int sepol_policy_select_user(hashtab_key_t key, hashtab_datum_t datum, void *datap)
{
	user_datum_t *usrdatum = datum;

	if (!usrdatum->defined)
		return 1;
	return 0;
}

/* Fold user values down to avoid holes generated by removal.
   As the SID table is remapped by the kernel upon a policy reload,
   this is safe for existing SIDs.  But it could be a problem for
   constraints if they refer to the particular user.  */
int sepol_policy_remap_users(hashtab_key_t key, hashtab_datum_t datum, void *p)
{
	user_datum_t *usrdatum = datum;
	struct kill_user_data *kud = p;
	struct policydb *pol = kud->policydb;
	ebitmap_t *free_users = kud->free_users;
	int i;

	if (usrdatum->value > pol->p_users.nprim) {
		for (i = ebitmap_startbit(free_users); i < ebitmap_length(free_users); i++) {
			if (ebitmap_get_bit(free_users, i)) {
				usrdatum->value = i+1;
				ebitmap_set_bit(free_users, i, 0);
				return 0;
			}
		}
	}
	return 0;
}

/* Kill the user entries selected by select_user, and
   record that their slots are free. */
void sepol_policy_kill_user(hashtab_key_t key, hashtab_datum_t datum, void *p)
{
	user_datum_t *usrdatum;
	struct kill_user_data *kud = p;
	struct policydb *pol = kud->policydb;
	ebitmap_t *free_users = kud->free_users;

	if (key)
		free(key);
	
	usrdatum = (user_datum_t *) datum;
	
	if (free_users != NULL) 
		ebitmap_set_bit(free_users, usrdatum->value - 1, 1);

	ebitmap_destroy(&usrdatum->roles);
	free(datum);
	pol->p_users.nprim--;
}

/* Construct a policydb from the supplied (data, len) pair */

int sepol_policy_read_policydb(void* data, size_t len, policydb_t* policydb) {

	struct policy_file pf;	

	pf.type = PF_USE_MEMORY;
	pf.data = data;
	pf.len = len;

	if (policydb_read(policydb, &pf, 0)) {
		__sepol_debug_printf("%s: binary policy image is invalid\n", __FUNCTION__);
		errno = EINVAL;
		return STATUS_ERR;
	}

	return STATUS_SUCCESS;
}

/* Write a policydb to a memory region, and return the (data, len) pair.
 * This *will* destroy the policydb even in the case of failure */

int sepol_policy_write_policydb(policydb_t* policydb, void **newdata, size_t *newlen) {

	struct policy_file pf;

	/* Set the policy version for the new binary policy image we are
	   about to generate so that it stays the same as the original,
	   even if we support a newer one. */
	sepol_set_policyvers(policydb->policyvers);

	/* Compute the length for the new binary policy image. */
	pf.type = PF_LEN;
	pf.data = NULL;
	pf.len = 0;
		
        if (policydb_write(policydb, &pf)) {
		 __sepol_debug_printf("%s: Can't compute length of binary policy\n", __FUNCTION__);
                errno = EINVAL;
		goto err;
        }

	/* Allocate the new binary policy image. */
        pf.type = PF_USE_MEMORY;
        pf.data = malloc(pf.len);
	if (!pf.data) {
		__sepol_debug_printf("%s:  out of memory\n", __FUNCTION__);
		errno = ENOMEM;
		goto err;
	}

	/* Need to save len and data prior to modification by policydb_write. */
	*newlen = pf.len;
	*newdata = pf.data;

	/* Write out the new binary policy image. */
        if (policydb_write(policydb, &pf)) {
		__sepol_debug_printf("%s:  Can't write binary policy\n", __FUNCTION__);
		free(pf.data);
		errno = EINVAL;
		goto err;
	}
	policydb_destroy(policydb);

	/* Verify the new binary policy image. */
	pf.type = PF_USE_MEMORY;
        pf.data = *newdata;
        pf.len = *newlen;
	if (policydb_read(policydb,&pf, 0)) {
		__sepol_debug_printf("%s:  new binary policy image is invalid\n", __FUNCTION__);
		errno = EINVAL;
		return STATUS_ERR;
	}

	policydb_destroy(policydb);
	return STATUS_SUCCESS;

err:
	policydb_destroy(policydb);
	return STATUS_ERR;
}

/* Add a user to the given policydb. The user may not exist already */

int sepol_policy_add_user(policydb_t* policydb, user_config_t user) {
	char* name;
	user_datum_t* usrdatum;

	/* See if a user exists */
	name = uc_get_name(user);
        usrdatum = hashtab_search(policydb->p_users.table, name);

	/* If it does, fail */
	if (usrdatum) {
		__sepol_debug_printf("%s:  %s is already in the policy\n", __FUNCTION__, name);
		return STATUS_ERR;	
	}
	
	else
		return sepol_policy_load_user(user, policydb);
}

/* Delete a user from the given policydb. This function will
 * fail if the user does not exist. */

int sepol_policy_del_user(policydb_t* policydb, const char* username) {
	user_datum_t* usrdatum;
	struct kill_user_data kud;

	/* FIXME: is there a reason why this isn't const */
	char* username_nconst = strdup(username);
	if (!username_nconst) {
		__sepol_debug_printf("%s: out of memory\n", __FUNCTION__);
		return STATUS_ERR;
	}
	
	/* See if such a user exists */
	usrdatum = hashtab_search(policydb->p_users.table, username_nconst);

	/* If not, fail */
	if (usrdatum == NULL) {
		__sepol_debug_printf("%s: %s does not exist in the policy\n", 
			__FUNCTION__, username_nconst);
		goto err;
	}
	else {
		kud.policydb = policydb;
		kud.free_users = NULL; /* FIXME? */

		hashtab_remove(policydb->p_users.table, username_nconst, 
			&sepol_policy_kill_user, &kud);

	}

	return STATUS_SUCCESS;

err:

	free(username_nconst);
	return STATUS_ERR;
}

/* Load a user into policydb. The user may exist already, in
 * which case the supplied data replaces the existing data. Alternatively,
 * the user could be new. */

int sepol_policy_load_user(user_config_t user, void* policydb_arg) {
	policydb_t* policydb = (policydb_t*) policydb_arg;

	/* For user data */
	char *name, *role, *mls_level, *mls_range;
	user_datum_t* usrdatum;
	role_datum_t* roldatum;
	context_struct_t context;
	unsigned bit;

	/* See if a user exists */
	name = uc_get_name(user);
	usrdatum = hashtab_search(policydb->p_users.table, name);

	/* If it does, we will modify it */
	if (usrdatum) {
		ebitmap_init(&usrdatum->roles);
		usrdatum->defined = 1;

	/* Otherwise, create a new one */
	} else {
		char *id = strdup(name);
		usrdatum = (user_datum_t *) malloc(sizeof(user_datum_t));

		if (!id || !usrdatum) {
			__sepol_debug_printf("%s:  out of memory for %s\n", __FUNCTION__, name);
			errno = ENOMEM;
			return STATUS_ERR;
		}
		memset(usrdatum, 0, sizeof(user_datum_t));
		usrdatum->value = ++policydb->p_users.nprim;
		ebitmap_init(&usrdatum->roles);
		usrdatum->defined = 1;
		if (hashtab_insert(policydb->p_users.table, id, (hashtab_datum_t) usrdatum)) {
			__sepol_debug_printf("%s:  out of memory for %s\n", __FUNCTION__, name);
			errno = ENOMEM;
			return STATUS_ERR;
		}
	}

	uc_iter_init(user);

	/* For every role */
	while ((role = uc_next_role(user))) {
		
		/* Search for the role */
		roldatum = hashtab_search(policydb->p_roles.table, role);
		if (!roldatum) {
			__sepol_debug_printf("sepol_add_user(): undefined role %s for user %s\n", role, name);
			continue;
		}

		/* Set the role and every role it dominates */
		for (bit = ebitmap_startbit(&roldatum->dominates); bit < ebitmap_length(&roldatum->dominates); bit++) {
			if (ebitmap_get_bit(&roldatum->dominates, bit)) {
				if (ebitmap_set_bit(&usrdatum->roles, bit, 1)) {
					__sepol_debug_printf("sepol_add_user():  out of memory for %s\n", name);
					errno = ENOMEM;
					return STATUS_ERR;
				}
			}
		}
	}

	/* MLS level */
	context_init(&context);
	mls_level = uc_get_mls_level(user);
	if (mls_level == NULL) 
		__sepol_debug_printf("%s: no mls level for user %s\n", __FUNCTION__, name);

	if (mls_context_to_sid(policydb, '$', &mls_level, &context)) {
		__sepol_debug_printf("%s:  invalid level %s for user %s\n", __FUNCTION__, mls_level, name);
		return STATUS_ERR;
	}
	memcpy(&usrdatum->dfltlevel, &context.range.level[0], sizeof(usrdatum->dfltlevel));
	
	/* MLS range */
	context_init(&context);
	mls_range = uc_get_mls_range(user);
	if (mls_range == NULL)
		__sepol_debug_printf("%s: no mls range for user %s\n", __FUNCTION__, name);

	if (mls_context_to_sid(policydb, '$', &mls_range, &context)) {
		__sepol_debug_printf("%s: invalid range %s for user %s\n", __FUNCTION__, mls_range, name);
		return STATUS_ERR;
	}
	memcpy(&usrdatum->range, &context.range, sizeof(usrdatum->range));

	return STATUS_SUCCESS;
}

--=-TjYIVLMK5HfBS444oDZa--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
