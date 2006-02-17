Message-ID: <43F56179.3080008@cornell.edu>
Date: Fri, 17 Feb 2006 00:39:05 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Genhomedircon - C or Python?
Content-Type: multipart/mixed;
 boundary="------------020602090404030508010303"
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020602090404030508010303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ok, Dan pointed out that a C genhomedircon is less flexible, and harder 
to work with than one written in python.
That is correct. However, I still argue that it should be written in C, 
because that's the language libsemanage is written in, and genhomedircon 
should be integrated into libsemanage. Please suggest alternative 
solutions to the problems below - I don't want to write genhomedircon in 
C either, but it just seems necessary.

To make discussion more substantiated, attached is a patch which 
implements the basic genhomedircon functionality, minus  things like 
reading the min_uid from other programs' config files, whitelisting 
shells, or HOME_ROOT expansion (don't have that working yet). On the 
other hand, it supports an additional variable (SELINUX_USER), and is 
capable of operating on top of any dbase (with any backend, whether it's 
a file, LDAP, or anything..). Comments appreciated, I'm sure parts of 
this file are ugly, and might need to be replaced. Execution starts at 
the bottom function.

============================

1) Genhomedircon output is not verified. Either invalid policy, or 
broken genhomedircon can generate invalid contexts, breaking the 
integrity of the system, which is unnecessary. Genhomedircon checking 
its context would amount to replicating code that is already in libsemanage.

        It was suggested that genhomedircon use libsemanage to validate 
its output. However, writing a checking API for contexts seems like a 
bad idea, because it has a single user - genhomedircon. It was also 
suggested that genhomedircon use libsemanage to add contexts as a 
"local" modification". This won't work, because genhomedircon cannot 
call semanange_commit(), because semanage_commit() calls genhomedircon back.

2) Genhomedircon is ran after the system sandbox is commited. This means 
between the time the sandbox is commited, and genhomedircon is ran, the 
file_contexts.homedirs installed are inconsistent with policy. This may 
or may not be a problem, depending on what kind of consistency 
requirements we have. However, a genhomedircon in libsemanage, executed 
before commit does not suffer from this problem.

3) Genhomedircon uses standard output to display errors - it does not 
hook into the ERR macros of libsemanage. If called remotely, 
genhomedircon output will not be seen by the client.

4) Genhomedircon is a standalone python program. For better integration 
with C clients that might want to invoke it (like useradd, libuser), it 
should be in a shared library.

5) Genhomedircon processes a split-out template. In the future we may 
want to process incoming requests to libsemanage (via the fcontext API) 
by genhomedircon helpers, in order to allow expansion of local 
modifications.

6) Genhomedircon currently understands the file_contexts format. 
Integration into libsemanage will reduce the things that need to 
understand that format to (1) libsemanage (in 
fcontext_file.c:print()/parse()), and (2) matchpathcon.

7) Integration of genhomedircon into libsemanage would allow the (local 
+ policy), and any future policy-only database to show all contexts, 
including the ones created by genhomedircon, which are currently not 
displayed.


--------------020602090404030508010303
Content-Type: text/x-csrc;
 name="genhomedircon.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="genhomedircon.c"

/* Copyright (C) 2005 Red Hat, Inc. */

struct semanage_fcontext;
struct semanage_fcontext_key;
typedef struct semanage_fcontext_key record_key_t;
typedef struct semanage_fcontext record_t;
#define DBASE_RECORD_DEFINED

#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <pwd.h>
#include "user_internal.h"
#include "seuser_internal.h"
#include "fcontext_internal.h"
#include "context_internal.h"
#include "debug.h"
#include "handle.h"
#include "database.h"

typedef struct seuser_entry {

	/* From Linux passwd dbase */
	char* name;
	char* homedir;

	/* From Libsemanage seusers dbase */
	char* selinux_name;

	/* From Libsemanage users dbase */
	char* prefix;

	struct seuser_entry* next;
} seuser_entry_t;

/* Destroys an entries list */
static void entries_destroy(
	seuser_entry_t* entries) {

	seuser_entry_t *next, *current = entries;
	while (current) {
		next = current->next;
		free(current->name);
		free(current->homedir);
		free(current->selinux_name);
		free(current->prefix);
		free(current);
		current = next;
	}
}

/* Constructs the entry list, and fills the
 * name and homedirs fields */

#define BUFLEN 4096
#define START_UID 500 /* FIXME - shouldn't be hardcoded */ 
static int fetch_homedirs( 
	semanage_handle_t* handle,
	seuser_entry_t** entries) {	

	seuser_entry_t *tmp, *entry = NULL;

	while (1) {
		char buf[BUFLEN];
		struct passwd pw, *pwp;
		
		int rc = getpwent_r(&pw, buf, BUFLEN, &pwp);
		if (rc != 0 &&  rc != ENOENT) {
			ERR(handle, "could not read next password "
				"entry: %s", strerror(errno));
			goto err;
		}

		/* ENOENT */
		else if (rc != 0)
			break;

		if (pw.pw_uid < START_UID) 
			continue;

		tmp = entry;
		entry = calloc(1, sizeof(seuser_entry_t));
		if (!entry)
			goto omem;
	
		entry->name = strdup(pw.pw_name);
		entry->homedir = strdup(pw.pw_dir);
		entry->next = tmp;
	
		if (!entry->name || !entry->homedir)
			goto omem;
	}		
		
	*entries = entry;
	return STATUS_SUCCESS;

	omem:
	ERR(handle, "out of memory");

	err:
	ERR(handle, "could not collect passwd information for context expansion"); 
	entries_destroy(entry);
	return STATUS_ERR;
}

/* For each entry, fills the selinux_name field */
static int fetch_seusers( 
	semanage_handle_t* handle,
	seuser_entry_t* entries) {

	seuser_entry_t* entry;
	semanage_seuser_t** seusers = NULL;
	unsigned int nseusers = 0;
	semanage_seuser_key_t* key = NULL;
	semanage_seuser_key_t* def_key = NULL;
	semanage_seuser_t** def_seuser;
	unsigned int i;

	if (semanage_seuser_list(handle, &seusers, &nseusers) < 0)
		goto err;

	qsort(seusers, nseusers, sizeof(semanage_user_t*),
		(int (*) (const void*, const void*)) &semanage_seuser_compare2_qsort);

	/* Fetch default user */
	if (semanage_seuser_key_create(handle, "__default__", &def_key) < 0)
		goto err;

	def_seuser = bsearch(def_key, seusers, nseusers, sizeof(semanage_seuser_t*), 
			(int (*) (const void*, const void*)) &semanage_seuser_compare_qsort);

	semanage_seuser_key_free(def_key);

	if (!def_seuser) {
		ERR(handle, "could not find default seuser");
		goto err;
	}		

	for (entry = entries; entry; entry = entry->next) {

		semanage_seuser_t** match;

		if (semanage_seuser_key_create(handle, entry->name, &key) < 0)
			goto err;

		match = bsearch(key, seusers, nseusers, sizeof(semanage_seuser_t*),
			(int (*) (const void*, const void*)) &semanage_seuser_compare_qsort);
		
		if (!match)
			match = def_seuser;
	
		entry->selinux_name = strdup(semanage_seuser_get_sename(*match));
		if (!entry->selinux_name)
			goto omem;

		semanage_seuser_key_free(key);
	}

	for (i = 0; i < nseusers; i++)
		semanage_seuser_free(seusers[i]);
	free(seusers);
	return STATUS_SUCCESS;

	omem:
	ERR(handle, "out of memory");

	err:
	ERR(handle, "could not collect seuser information for context expansion");
	for (i = 0; i < nseusers; i++)
		semanage_seuser_free(seusers[i]);
	free(seusers);
	semanage_seuser_key_free(key);
	return STATUS_ERR;
}


/* For each entry, fills the prefix field */
static int fetch_users( 
	semanage_handle_t* handle,
	seuser_entry_t* entries) {

	seuser_entry_t* entry;
	semanage_user_t** users = NULL;
	unsigned int nusers = 0;
	semanage_user_key_t* key = NULL;
	unsigned int i;

	if (semanage_user_list(handle, &users, &nusers) < 0)
		goto err;

	qsort(users, nusers, sizeof(semanage_user_t*),
		(int (*) (const void*, const void*)) &semanage_user_compare2_qsort);

	for (entry = entries; entry; entry = entry->next) {

		semanage_user_t** match;

		if (semanage_user_key_create(handle, entry->selinux_name, &key) < 0)
			goto err;

		match = bsearch(key, users, nusers, sizeof(semanage_user_t*),
			(int (*) (const void*, const void*)) &semanage_user_compare_qsort);

		/* Should never happen */
		if (!match) {
			ERR(handle, "could not find selinux user %s for user %s, "
				"internal error", entry->selinux_name, entry->name);
			goto err;
		}
	
		entry->prefix = strdup(semanage_user_get_prefix(*match));
		if (!entry->prefix)
			goto omem;	

		semanage_user_key_free(key);
	}

	for (i = 0; i < nusers; i ++)
		semanage_user_free(users[i]);
	free(users);
	return STATUS_SUCCESS;
	
	omem:
	ERR(handle, "out of memory");

	err:
	ERR(handle, "could not collect user information for context expansion");
	semanage_user_key_free(key);
	for (i = 0; i < nusers; i ++)
		semanage_user_free(users[i]);
	return STATUS_ERR;
}

/* Check if the given symbol contains templates
 * for expansion */
static int contains_templates(
	const char* symbol) {

	if (!symbol)
		return 0;

	return strstr(symbol, "USER") ||
	       strstr(symbol, "SELINUX_USER") ||
	       strstr(symbol, "ROLE") ||
	       strstr(symbol, "HOME_DIR") ||
	       strstr(symbol, "HOME_ROOT");
}

/* Delete the given templated fcon specification 
 * from the target database */
static int delete_fcon(
	semanage_handle_t* handle,
	dbase_config_t* target,
	semanage_fcontext_t* fcon) {

	dbase_t* dbase = target->dbase;
	dbase_table_t* dtable = target->dtable;
	record_table_t* rtable = dtable->get_rtable(dbase);
	semanage_fcontext_key_t* key = NULL;

	/* Before using any dtable functions, cache() must be called */
	if (dtable->cache(handle, dbase) < 0)
		goto err;

	if (rtable->key_extract(handle, fcon, &key) < 0)
		goto err;

	if (dtable->del(handle, dbase, key) < 0)
		goto err;

	rtable->key_free(key);
	return STATUS_SUCCESS;
	
	err:
	ERR(handle, "could not delete templated context for %s [%s]",
		semanage_fcontext_get_expr(fcon),
		semanage_fcontext_get_type_str(
			semanage_fcontext_get_type(fcon)));
	rtable->key_free(key);
	return STATUS_ERR;
}

static int expand_symbol(
	semanage_handle_t* handle,
	const char* symbol,
	const seuser_entry_t* entry,
	char** new_symbol) {	

	/* First, allocate a buffer, 
	 * set sz (its size), and len (its current length) */

	int sz = strlen(symbol) * 2;
	int len = 0;
	char* buffer = malloc(sz);
	char* buffer_ptr = buffer;

	/* Define expansions */
	struct {
		const char* exp_name;
		const char* exp_data;

	} expansions[] = {

		{ "USER", entry->name },
		{ "SELINUX_USER", entry->selinux_name },
		{ "ROLE", entry->prefix },
		{ "HOME_DIR", entry->homedir },
		{ "HOME_ROOT", "" }
	};
	const unsigned int ECOUNT = sizeof(expansions)/sizeof(expansions[0]);

	while (*symbol != '\0') {
		unsigned int i;
		const char* target;
		unsigned int target_len;

		/* Try each expansion */
		int match = 0;
		for (i = 0 ; i < ECOUNT; i++) {
			const char* exp_name = expansions[i].exp_name;
			const char* exp_data = expansions[i].exp_data;
			int exp_name_len = strlen(exp_name);
			int exp_data_len = strlen(exp_data);

			if (!strncmp(symbol, exp_name, exp_name_len)) {
				symbol += exp_name_len;
				target = exp_data;
				target_len = exp_data_len;
				match = 1;
				break;
			}
		}

		/* None work, move on */
		if (!match) {
			target = symbol;
			target_len = 1;
			symbol ++;
		}

		/* Resize the buffer aggressively, so we don't have to do
	 	 * it again anytime soon */
		if ((sz - len) < (target_len + 1)) {

			/* Okay, this seems large enough */
			sz = (sz + target_len + 1) * 2;

			char* buffer_realloc = realloc(buffer, sz);
			if (!buffer_realloc)
				goto omem;

			buffer = buffer_realloc; 
		}
		
		/* Now store the target string */
		strncpy(buffer_ptr, target, target_len);
		len += target_len;
		buffer_ptr += target_len;
	}

	/* Null terminate the buffer */
	*buffer_ptr = '\0';

	*new_symbol = buffer;
	return STATUS_SUCCESS;

	omem:
	ERR(handle, "out of memory, could not expand symbol %s", symbol);
	free(buffer);
	return STATUS_ERR;
}

static int expand_contexts(
	semanage_handle_t* handle,
	seuser_entry_t* entries,
	dbase_config_t* target) {

	char* con_str = NULL;
	seuser_entry_t* entry;
	semanage_fcontext_t** fcontexts = NULL;
	unsigned int i, nfcontexts = 0;

	dbase_t* dbase = target->dbase;
	dbase_table_t* dtable = target->dtable;

	/* Before using any dtable functions, cache() must be called */
	if (dtable->cache(handle, dbase) < 0)
		goto err;

	if (dtable->list(handle, dbase, &fcontexts, &nfcontexts) < 0)
		goto err;

	for (i =0; i < nfcontexts; i++) {
		const char* expr = semanage_fcontext_get_expr(fcontexts[i]);
		semanage_context_t* con = semanage_fcontext_get_con(fcontexts[i]);

		if (con) {
			if (semanage_context_to_string(handle, con, &con_str) < 0)
				goto err;
		}

		/* Don't do anything - no templates */
		if (!contains_templates(expr) && !contains_templates(con_str)) {
			free(con_str); 
			con_str = NULL;
			continue;
		}

		printf ("Expanding expr=(%s), con=(%s) to: \n", expr, con_str);

		/* Otherwise before we do anything else, delete the 
		 * templated spec from the database */
		if (delete_fcon(handle, target, fcontexts[i]) < 0)
			goto err; 

		for (entry = entries; entry; entry = entry->next) {

			char* new_expr = NULL;
			char* new_con_str = NULL;
			semanage_context_t* new_con = NULL;			
			semanage_fcontext_t* new_fcon = NULL;
			semanage_fcontext_key_t* new_fcon_key = NULL;

			if (semanage_fcontext_clone(handle, fcontexts[i], &new_fcon) < 0)
				goto loop_err;

			if (expand_symbol(handle, expr, entry, &new_expr) < 0)
				goto loop_err;

			if (semanage_fcontext_set_expr(handle, new_fcon, new_expr) <  0)
				goto loop_err;

			if (con) {

				if (expand_symbol(handle, con_str, entry, &new_con_str) < 0) 
					goto loop_err;

				if (semanage_context_from_string(handle, new_con_str, &new_con) < 0)
					goto loop_err;

				if (semanage_fcontext_set_con(handle, new_fcon, new_con) < 0)
					goto loop_err;
				new_con = NULL;
			}

			if (semanage_fcontext_key_extract(handle, new_fcon, &new_fcon_key) < 0)
				goto loop_err;

			/* FIXME1: This is O(n) */
			/* FIXME2: an exists check on a templated contexts will not catch duplicate */
			if (dtable->modify(handle, dbase, new_fcon_key, new_fcon) < 0)
				goto loop_err;

			printf ("	expr=(%s), con=(%s)\n", new_expr, new_con_str);

			/* Success path */
			free(new_con_str);
			free(new_expr);
			semanage_fcontext_free(new_fcon);
			semanage_fcontext_key_free(new_fcon_key);
			new_con_str = NULL;
			new_expr = NULL;
			new_fcon = NULL;
			new_fcon_key = NULL;
			continue;

			/* Error path (loop) */
			loop_err:
			free(new_con_str);
			free(new_expr);
			semanage_context_free(new_con);
			semanage_fcontext_free(new_fcon);
			semanage_fcontext_key_free(new_fcon_key);
			goto err;
		}
	}

	for (i = 0; i < nfcontexts; i++)
		semanage_fcontext_free(fcontexts[i]);
	free(fcontexts);
	return STATUS_SUCCESS;

	err:
	free(con_str);
	for (i = 0; i < nfcontexts; i++)
		semanage_fcontext_free(fcontexts[i]);
	free(fcontexts);
	ERR(handle, "could not expand file contexts");
	return STATUS_ERR;
}

int hidden semanage_fcontext_expand(
	semanage_handle_t* handle,
	dbase_config_t* target) {

	seuser_entry_t* entries = NULL;

	/* First, collect all the information we need */
	if (fetch_homedirs(handle, &entries) < 0)
		goto err;

	if (fetch_seusers(handle, entries) < 0)
		goto err;

	if (fetch_users(handle, entries) < 0)
		goto err;

	if (expand_contexts(handle, entries, target) < 0)
		goto err;

	entries_destroy(entries);
	return STATUS_SUCCESS;

	err:
	ERR(handle, "could not expand file contexts");
	entries_destroy(entries);
	return STATUS_ERR;
}

--------------020602090404030508010303--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
