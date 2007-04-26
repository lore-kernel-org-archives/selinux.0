Subject: [PATCH 2/6] libsepol: Remove obsolete interfaces and code used to
	support local boolean and user files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
References: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 09:51:38 -0400
Message-Id: <1177595498.24282.332.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove obsolete interfaces and code used to support local
boolean and user files.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libsepol/man/man3/sepol_genbools.3 |   16 -
 libsepol/man/man3/sepol_genusers.3 |   54 ------
 libsepol/man/man8/genpolbools.8    |   16 -
 libsepol/man/man8/genpolusers.8    |   42 ----
 libsepol/src/genbools.c            |  179 ---------------------
 libsepol/src/genusers.c            |  315 -------------------------------------
 libsepol/src/libsepol.map          |    4 
 7 files changed, 6 insertions(+), 620 deletions(-)

Index: policyrep/libsepol/src/libsepol.map
===================================================================
--- policyrep/libsepol/src/libsepol.map	(revision 2382)
+++ policyrep/libsepol/src/libsepol.map	(working copy)
@@ -1,12 +1,12 @@
 LIBSEPOL_2.0 {
   global: 
 	sepol_module_package_*; sepol_link_modules; sepol_expand_module; sepol_link_packages;
-	sepol_bool_*; sepol_genbools*; 
+	sepol_bool_*; sepol_genbools_array; 
 	sepol_context_*; sepol_mls_*; sepol_check_context;
 	sepol_iface_*; 
 	sepol_port_*;
 	sepol_node_*;
-	sepol_user_*; sepol_genusers; sepol_set_delusers;
+	sepol_user_*; 
 	sepol_msg_*; sepol_debug;
 	sepol_handle_*;
 	sepol_policydb_*; sepol_set_policydb_from_file; 
Index: policyrep/libsepol/src/genbools.c
===================================================================
--- policyrep/libsepol/src/genbools.c	(revision 2382)
+++ policyrep/libsepol/src/genbools.c	(working copy)
@@ -10,185 +10,6 @@
 #include "private.h"
 #include "dso.h"
 
-/* -- Deprecated -- */
-
-static char *strtrim(char *dest, char *source, int size)
-{
-	int i = 0;
-	char *ptr = source;
-	i = 0;
-	while (isspace(*ptr) && i < size) {
-		ptr++;
-		i++;
-	}
-	strncpy(dest, ptr, size);
-	for (i = strlen(dest) - 1; i > 0; i--) {
-		if (!isspace(dest[i]))
-			break;
-	}
-	dest[i + 1] = '\0';
-	return dest;
-}
-
-static int process_boolean(char *buffer, char *name, int namesize, int *val)
-{
-	char name1[BUFSIZ];
-	char *ptr;
-	char *tok = strtok_r(buffer, "=", &ptr);
-	if (tok) {
-		strncpy(name1, tok, BUFSIZ - 1);
-		strtrim(name, name1, namesize - 1);
-		if (name[0] == '#')
-			return 0;
-		tok = strtok_r(NULL, "\0", &ptr);
-		if (tok) {
-			while (isspace(*tok))
-				tok++;
-			*val = -1;
-			if (isdigit(tok[0]))
-				*val = atoi(tok);
-			else if (!strncasecmp(tok, "true", sizeof("true") - 1))
-				*val = 1;
-			else if (!strncasecmp
-				 (tok, "false", sizeof("false") - 1))
-				*val = 0;
-			if (*val != 0 && *val != 1) {
-				ERR(NULL, "illegal value for boolean "
-				    "%s=%s", name, tok);
-				return -1;
-			}
-
-		}
-	}
-	return 1;
-}
-
-static int load_booleans(struct policydb *policydb, const char *path,
-			 int *changesp)
-{
-	FILE *boolf;
-	char *buffer = NULL;
-	size_t size = 0;
-	char localbools[BUFSIZ];
-	char name[BUFSIZ];
-	int val;
-	int errors = 0, changes = 0;
-	struct cond_bool_datum *datum;
-
-	boolf = fopen(path, "r");
-	if (boolf == NULL)
-		goto localbool;
-
-	while (getline(&buffer, &size, boolf) > 0) {
-		int ret = process_boolean(buffer, name, sizeof(name), &val);
-		if (ret == -1)
-			errors++;
-		if (ret == 1) {
-			datum = hashtab_search(policydb->p_bools.table, name);
-			if (!datum) {
-				ERR(NULL, "unknown boolean %s", name);
-				errors++;
-				continue;
-			}
-			if (datum->state != val) {
-				datum->state = val;
-				changes++;
-			}
-		}
-	}
-	fclose(boolf);
-      localbool:
-	snprintf(localbools, sizeof(localbools), "%s.local", path);
-	boolf = fopen(localbools, "r");
-	if (boolf != NULL) {
-		while (getline(&buffer, &size, boolf) > 0) {
-			int ret =
-			    process_boolean(buffer, name, sizeof(name), &val);
-			if (ret == -1)
-				errors++;
-			if (ret == 1) {
-				datum =
-				    hashtab_search(policydb->p_bools.table,
-						   name);
-				if (!datum) {
-					ERR(NULL, "unknown boolean %s", name);
-					errors++;
-					continue;
-				}
-				if (datum->state != val) {
-					datum->state = val;
-					changes++;
-				}
-			}
-		}
-		fclose(boolf);
-	}
-	free(buffer);
-	if (errors)
-		errno = EINVAL;
-	*changesp = changes;
-	return errors ? -1 : 0;
-}
-
-int sepol_genbools(void *data, size_t len, char *booleans)
-{
-	struct policydb policydb;
-	struct policy_file pf;
-	int rc, changes = 0;
-
-	if (policydb_init(&policydb))
-		goto err;
-	if (policydb_from_image(NULL, data, len, &policydb) < 0)
-		goto err;
-
-	if (load_booleans(&policydb, booleans, &changes) < 0) {
-		WARN(NULL, "error while reading %s", booleans);
-	}
-
-	if (!changes)
-		goto out;
-
-	if (evaluate_conds(&policydb) < 0) {
-		ERR(NULL, "error while re-evaluating conditionals");
-		errno = EINVAL;
-		goto err_destroy;
-	}
-
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		ERR(NULL, "unable to write new binary policy image");
-		errno = EINVAL;
-		goto err_destroy;
-	}
-
-      out:
-	policydb_destroy(&policydb);
-	return 0;
-
-      err_destroy:
-	policydb_destroy(&policydb);
-
-      err:
-	return -1;
-}
-
-int hidden sepol_genbools_policydb(policydb_t * policydb, const char *booleans)
-{
-	int rc, changes = 0;
-
-	rc = load_booleans(policydb, booleans, &changes);
-	if (!rc && changes)
-		rc = evaluate_conds(policydb);
-	if (rc)
-		errno = EINVAL;
-	return rc;
-}
-
-/* -- End Deprecated -- */
-
 int sepol_genbools_array(void *data, size_t len, char **names, int *values,
 			 int nel)
 {
Index: policyrep/libsepol/src/genusers.c
===================================================================
--- policyrep/libsepol/src/genusers.c	(revision 2382)
+++ policyrep/libsepol/src/genusers.c	(working copy)
@@ -1,315 +0,0 @@
-#include <stdio.h>
-#include <stdio_ext.h>
-#include <stdlib.h>
-#include <ctype.h>
-#include <errno.h>
-#include <limits.h>
-
-#include <sepol/policydb/policydb.h>
-#include <stdarg.h>
-
-#include "debug.h"
-#include "private.h"
-#include "dso.h"
-#include "mls.h"
-
-/* -- Deprecated -- */
-
-void sepol_set_delusers(int on __attribute((unused)))
-{
-	WARN(NULL, "Deprecated interface");
-}
-
-#undef BADLINE
-#define BADLINE() { \
-	ERR(NULL, "invalid entry %s (%s:%u)", \
-		buffer, path, lineno); \
-	continue; \
-}
-
-static int load_users(struct policydb *policydb, const char *path)
-{
-	FILE *fp;
-	char *buffer = NULL, *p, *q, oldc;
-	size_t len = 0;
-	ssize_t nread;
-	unsigned lineno = 0, islist = 0, bit;
-	user_datum_t *usrdatum;
-	role_datum_t *roldatum;
-	ebitmap_node_t *rnode;
-
-	fp = fopen(path, "r");
-	if (fp == NULL)
-		return -1;
-	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-
-	while ((nread = getline(&buffer, &len, fp)) > 0) {
-		lineno++;
-		if (buffer[nread - 1] == '\n')
-			buffer[nread - 1] = 0;
-		p = buffer;
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p) || *p == '#')
-			continue;
-
-		if (strncasecmp(p, "user", 4))
-			BADLINE();
-		p += 4;
-		if (!isspace(*p))
-			BADLINE();
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		q = p;
-		while (*p && !isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		*p++ = 0;
-
-		usrdatum = hashtab_search(policydb->p_users.table, q);
-		if (usrdatum) {
-			/* Replacing an existing user definition. */
-			ebitmap_destroy(&usrdatum->roles.roles);
-			ebitmap_init(&usrdatum->roles.roles);
-		} else {
-			char *id = strdup(q);
-
-			/* Adding a new user definition. */
-			usrdatum =
-			    (user_datum_t *) malloc(sizeof(user_datum_t));
-			if (!id || !usrdatum) {
-				ERR(NULL, "out of memory");
-				free(buffer);
-				fclose(fp);
-				return -1;
-			}
-			memset(usrdatum, 0, sizeof(user_datum_t));
-			usrdatum->s.value = ++policydb->p_users.nprim;
-			ebitmap_init(&usrdatum->roles.roles);
-			if (hashtab_insert(policydb->p_users.table,
-					   id, (hashtab_datum_t) usrdatum)) {
-				ERR(NULL, "out of memory");
-				free(buffer);
-				fclose(fp);
-				return -1;
-			}
-		}
-
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		if (strncasecmp(p, "roles", 5))
-			BADLINE();
-		p += 5;
-		if (!isspace(*p))
-			BADLINE();
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		if (*p == '{') {
-			islist = 1;
-			p++;
-		} else
-			islist = 0;
-
-		do {
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-
-			q = p;
-			while (*p && *p != ';' && *p != '}' && !isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			if (*p == '}')
-				islist = 0;
-			oldc = *p;
-			*p++ = 0;
-			if (!q[0])
-				break;
-
-			roldatum = hashtab_search(policydb->p_roles.table, q);
-			if (!roldatum) {
-				ERR(NULL, "undefined role %s (%s:%u)",
-				    q, path, lineno);
-				continue;
-			}
-			/* Set the role and every role it dominates */
-			ebitmap_for_each_bit(&roldatum->dominates, rnode, bit) {
-				if (ebitmap_node_get_bit(rnode, bit))
-					if (ebitmap_set_bit
-					    (&usrdatum->roles.roles, bit, 1)) {
-						ERR(NULL, "out of memory");
-						free(buffer);
-						fclose(fp);
-						return -1;
-					}
-			}
-		} while (islist);
-
-		if (policydb->mls) {
-			context_struct_t context;
-			char *scontext, *r, *s;
-
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			if (strncasecmp(p, "level", 5))
-				BADLINE();
-			p += 5;
-			if (!isspace(*p))
-				BADLINE();
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			q = p;
-			while (*p && strncasecmp(p, "range", 5))
-				p++;
-			if (!(*p))
-				BADLINE();
-			*--p = 0;
-			p++;
-
-			scontext = malloc(p - q);
-			if (!scontext) {
-				ERR(NULL, "out of memory");
-				free(buffer);
-				fclose(fp);
-				return -1;
-			}
-			r = scontext;
-			s = q;
-			while (*s) {
-				if (!isspace(*s))
-					*r++ = *s;
-				s++;
-			}
-			*r = 0;
-			r = scontext;
-
-			context_init(&context);
-			if (mls_context_to_sid(policydb, oldc, &r, &context) <
-			    0) {
-				ERR(NULL, "invalid level %s (%s:%u)", scontext,
-				    path, lineno);
-				free(scontext);
-				continue;
-
-			}
-			free(scontext);
-			memcpy(&usrdatum->dfltlevel, &context.range.level[0],
-			       sizeof(usrdatum->dfltlevel));
-
-			if (strncasecmp(p, "range", 5))
-				BADLINE();
-			p += 5;
-			if (!isspace(*p))
-				BADLINE();
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			q = p;
-			while (*p && *p != ';')
-				p++;
-			if (!(*p))
-				BADLINE();
-			*p++ = 0;
-
-			scontext = malloc(p - q);
-			if (!scontext) {
-				ERR(NULL, "out of memory");
-				free(buffer);
-				fclose(fp);
-				return -1;
-			}
-			r = scontext;
-			s = q;
-			while (*s) {
-				if (!isspace(*s))
-					*r++ = *s;
-				s++;
-			}
-			*r = 0;
-			r = scontext;
-
-			context_init(&context);
-			if (mls_context_to_sid(policydb, oldc, &r, &context) <
-			    0) {
-				ERR(NULL, "invalid range %s (%s:%u)", scontext,
-				    path, lineno);
-				free(scontext);
-				continue;
-			}
-			free(scontext);
-			memcpy(&usrdatum->range, &context.range,
-			       sizeof(usrdatum->range));
-		}
-	}
-
-	free(buffer);
-	fclose(fp);
-	return 0;
-}
-
-int sepol_genusers(void *data, size_t len,
-		   const char *usersdir, void **newdata, size_t * newlen)
-{
-	struct policydb policydb;
-	char path[PATH_MAX];
-
-	/* Construct policy database */
-	if (policydb_init(&policydb))
-		goto err;
-	if (policydb_from_image(NULL, data, len, &policydb) < 0)
-		goto err;
-
-	/* Load locally defined users. */
-	snprintf(path, sizeof path, "%s/local.users", usersdir);
-	if (load_users(&policydb, path) < 0)
-		goto err_destroy;
-
-	/* Write policy database */
-	if (policydb_to_image(NULL, &policydb, newdata, newlen) < 0)
-		goto err_destroy;
-
-	policydb_destroy(&policydb);
-	return 0;
-
-      err_destroy:
-	policydb_destroy(&policydb);
-
-      err:
-	return -1;
-}
-
-int hidden sepol_genusers_policydb(policydb_t * policydb, const char *usersdir)
-{
-	char path[PATH_MAX];
-
-	/* Load locally defined users. */
-	snprintf(path, sizeof path, "%s/local.users", usersdir);
-	if (load_users(policydb, path) < 0) {
-		ERR(NULL, "unable to load local.users: %s", strerror(errno));
-		return -1;
-	}
-
-	if (policydb_reindex_users(policydb) < 0) {
-		ERR(NULL, "unable to reindex users: %s", strerror(errno));
-		return -1;
-
-	}
-
-	return 0;
-}
-
-/* -- End Deprecated -- */
Index: policyrep/libsepol/man/man8/genpolbools.8
===================================================================
--- policyrep/libsepol/man/man8/genpolbools.8	(revision 2382)
+++ policyrep/libsepol/man/man8/genpolbools.8	(working copy)
@@ -1,16 +0,0 @@
-.TH "genpolbools" "8" "11 August 2004" "sds@epoch.ncsc.mil" "SELinux Command Line documentation"
-.SH "NAME"
-genpolbools \- Rewrite a binary policy with different boolean settings
-.SH "SYNOPSIS"
-.B genpolbools oldpolicy booleans newpolicy
-
-.SH "DESCRIPTION"
-.B genpolbools
-rewrites an existing binary policy with different boolean settings,
-generating a new binary policy.  The booleans file specifies the 
-different boolean settings using name=value lines, where value
-can be 0 or false to disable the boolean or 1 or true to enable it.
-
-
-
-
Index: policyrep/libsepol/man/man8/genpolusers.8
===================================================================
--- policyrep/libsepol/man/man8/genpolusers.8	(revision 2382)
+++ policyrep/libsepol/man/man8/genpolusers.8	(working copy)
@@ -1,42 +0,0 @@
-.\" Hey, Emacs! This is an -*- nroff -*- source file.
-.\" Copyright (c) 1997 Manoj Srivastava <srivasta@debian.org>
-.\"
-.\" This is free documentation; you can redistribute it and/or
-.\" modify it under the terms of the GNU General Public License as
-.\" published by the Free Software Foundation; either version 2 of
-.\" the License, or (at your option) any later version.
-.\"
-.\" The GNU General Public License's references to "object code"
-.\" and "executables" are to be interpreted as the output of any
-.\" document formatting or typesetting system, including
-.\" intermediate and printed output.
-.\"
-.\" This manual is distributed in the hope that it will be useful,
-.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-.\" GNU General Public License for more details.
-.\"
-.\" You should have received a copy of the GNU General Public
-.\" License along with this manual; if not, write to the Free
-.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
-.\" USA.
-.\"
-.TH GENPOLUSERS 8 "Mar 12 2005" "SELinux" "SELinux Command Line documentation"
-.SH NAME
-genpolusers \- Generate new binary policy with updated user configuration
-.SH SYNOPSIS
-genpolusers in-policy usersdir out-policy
-.SH DESCRIPTION
-Given an existing binary policy file 
-.I in\-policy, 
-generate a new binary policy 
-.I out\-policy 
-with an updated user configuration based on any 
-.B system.users 
-and
-.B local.users 
-files in the specified 
-.I usersdir.
-.SH AUTHOR
-This manual page (and just the manual page) was written by Manoj
-Srivastava <srivasta@debian.org>.
Index: policyrep/libsepol/man/man3/sepol_genbools.3
===================================================================
--- policyrep/libsepol/man/man3/sepol_genbools.3	(revision 2382)
+++ policyrep/libsepol/man/man3/sepol_genbools.3	(working copy)
@@ -4,25 +4,17 @@
 .SH "SYNOPSIS"
 .B #include <sepol/sepol.h>
 .sp
-.BI "int sepol_genbools(void *" data ", size_t "len ", char *" boolpath );
-.br
 .BI "int sepol_genbools_array(void *" data ", size_t " len ", char **" names ", int *" values ", int " nel );
 
 .SH "DESCRIPTION"
-.B sepol_genbools
+.B sepol_genbools_array
 rewrites a binary policy stored in the memory region described by
-(data, len) to use the boolean settings specified in the file named by
-boolpath.  The boolean settings are specified by name=value lines
-where value may be 0 or false to disable or 1 or true to enable.  The
-binary policy is rewritten in place in memory.
+(data, len) to use the boolean settings specified in the parallel
+arrays (names, values) with nel elements each. The binary policy is
+rewritten in place in memory.
 
-.B sepol_genbools_array
-does likewise, but obtains the boolean settings from the parallel arrays
-(names, values) with nel elements each.
-
 .SH "RETURN VALUE"
 Returns 0 on success or -1 otherwise, with errno set appropriately.
-An errno of ENOENT indicates that the boolean file did not exist.
 An errno of EINVAL indicates that one or more booleans listed in the
 boolean file was undefined in the policy or had an invalid value specified;
 in this case, the binary policy is still rewritten but any invalid
Index: policyrep/libsepol/man/man3/sepol_genusers.3
===================================================================
--- policyrep/libsepol/man/man3/sepol_genusers.3	(revision 2382)
+++ policyrep/libsepol/man/man3/sepol_genusers.3	(working copy)
@@ -1,54 +0,0 @@
-.TH "sepol_genusers" "3" "15 March 2005" "sds@tycho.nsa.gov" "SE Linux binary policy API documentation"
-.SH "NAME"
-sepol_genusers \- Generate a new binary policy image with a customized user configuration
-.SH "SYNOPSIS"
-.B #include <sepol/sepol.h>
-.sp
-.BI "int sepol_genusers(void *" data ", size_t "len ", const char *" usersdir ", void *" newdata ", size_t *" newlen);
-.sp
-.BI "void sepol_set_delusers(int " on ");"
-
-.SH "DESCRIPTION"
-.B sepol_genusers
-generates a new binary policy image from 
-an existing binary policy image stored in the memory region described by
-the starting address
-.I data
-and the length
-.I len
-and a pair of user configuration files named 
-.B system.users 
-and
-.B local.users
-from the directory specified by
-.I usersdir.
-The resulting binary policy is placed into dynamically allocated
-memory and the variables
-.I newdata
-and
-.I newlen
-are set to refer to the new binary image's starting address and length.
-The original binary policy image is not modified.
-
-By default, 
-.B sepol_genusers
-will preserve user entries that are defined in the original binary policy image
-but not defined in the user configuration files.  If such user entries
-should instead by omitted entirely from the new binary policy image, then
-the
-.B sepol_set_delusers
-function may be called with 
-.I on
-set to 1 prior to calling
-.B sepol_genusers
-in order to enable deletion of such users.
-
-.SH "RETURN VALUE"
-Returns 0 on success or -1 otherwise, with errno set appropriately.
-An errno of ENOENT indicates that one or both of the user
-configuration files did not exist.  An errno of EINVAL indicates that
-either the original binary policy image or the generated one were
-invalid.  An errno of ENOMEM indicates that insufficient memory was
-available to process the original binary policy image or to generate
-the new policy image.  Invalid entries in the user configuration files
-are skipped with a warning.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
