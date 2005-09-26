Message-Id: <200509262348.j8QNmQYs018842@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage-reorg 6/7 
Date: Mon, 26 Sep 2005 19:48:26 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00A7_01C5C2D3.42AD5170"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_00A7_01C5C2D3.42AD5170
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch removes module_store.c. This code is changed and moved to
semanage_store.c in the next patch set.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_00A7_01C5C2D3.42AD5170
Content-Type: application/octet-stream;
	name="6-remove-module_store.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="6-remove-module_store.diff"

--- libsemanage/src/module_store.c	2005-09-19 09:03:15.000000000 -0400=0A=
+++ libsemanage/src/module_store.c	1969-12-31 19:00:00.000000000 -0500=0A=
@@ -1,828 +0,0 @@=0A=
-/* Authors: Karl MacMillan <kmacmillan@tresys.com>=0A=
- * 	    Joshua Brindle <jbrindle@tresys.com>=0A=
- *          Jason Tang <jtang@tresys.com>=0A=
- *=0A=
- * Copyright (C) 2004-2005 Tresys Technology, LLC=0A=
- *=0A=
- *  This library is free software; you can redistribute it and/or=0A=
- *  modify it under the terms of the GNU Lesser General Public=0A=
- *  License as published by the Free Software Foundation; either=0A=
- *  version 2.1 of the License, or (at your option) any later version.=0A=
- *=0A=
- *  This library is distributed in the hope that it will be useful,=0A=
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
- *  Lesser General Public License for more details.=0A=
- *=0A=
- *  You should have received a copy of the GNU Lesser General Public=0A=
- *  License along with this library; if not, write to the Free Software=0A=
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
- */=0A=
-=0A=
-/* This file contains routines that access the different directories=0A=
- * used by policy-server, semodule, and anything else that uses the=0A=
- * module store.=0A=
- */=0A=
-=0A=
-#ifndef _GNU_SOURCE=0A=
-#define _GNU_SOURCE=0A=
-#endif=0A=
-=0A=
-#include "semanage/module_store.h"=0A=
-#include "semanage/semod_conf.h"=0A=
-=0A=
-#include <selinux/selinux.h>=0A=
-#include <sepol/module.h>=0A=
-=0A=
-#include <assert.h>=0A=
-#include <dirent.h>=0A=
-#include <errno.h>=0A=
-#include <fcntl.h>=0A=
-#include <stdarg.h>=0A=
-#include <stdio.h>=0A=
-#include <stdlib.h>=0A=
-#include <string.h>=0A=
-#include <unistd.h>=0A=
-#include <sys/stat.h>=0A=
-#include <sys/types.h>=0A=
-=0A=
-=0A=
-/* enumeration and relative path names to special files and=0A=
- * directories for the module store */=0A=
-enum {=0A=
-        SEMOD_STORE, SEMOD_LOCK, SEMOD_CONF,=0A=
-        SEMOD_ACTIVE, SEMOD_ACTIVE_MODULES,=0A=
-	SEMOD_ACTIVE_BASE, SEMOD_ACTIVE_KERNEL, SEMOD_ACTIVE_KERNEL_BACKUP,=0A=
-        SEMOD_ACTIVE_FC, SEMOD_ACTIVE_FC_BACKUP,=0A=
-        SEMOD_BACKUP,=0A=
-        SEMOD_NUM_PATHS=0A=
-};=0A=
-static char *semod_paths[SEMOD_NUM_PATHS] =3D { NULL };=0A=
-static int semod_paths_initialized =3D 0;=0A=
-static const char *semod_relative_paths[SEMOD_NUM_PATHS] =3D {=0A=
-	"", "/policy-server.LOCK", "/semod.conf",=0A=
-	"/active", "/active/modules/",=0A=
-	"/active/base.pp", "/active/policy.kern", "/active/policy.old",=0A=
-        "/active/file_contexts", "/active/file_contexts.old",=0A=
-        "/previous/"=0A=
-};=0A=
-=0A=
-/* enumerations and relative path names to special files within a=0A=
- * sandbox */=0A=
-enum {=0A=
-        SEMOD_TMP, SEMOD_TMP_MODULES, SEMOD_TMP_KERNEL,=0A=
-        SEMOD_TMP_BASE, SEMOD_TMP_LINKED, SEMOD_TMP_FC,=0A=
-        SEMOD_SANDBOX_PATHS=0A=
-};=0A=
-static const char *semod_sandbox_paths[SEMOD_SANDBOX_PATHS] =3D {=0A=
-	"/tmp",=0A=
-	"/modules",=0A=
-	"/policy.kern",=0A=
-	"/base.pp",=0A=
-        "/base.linked",=0A=
-        "/file_contexts"=0A=
-};=0A=
-=0A=
-#define SEMOD_CHECK_INIT assert(semod_paths_initialized !=3D 0);=0A=
-=0A=
-static void write_error(char *error_buf, size_t error_buf_size, char =
*fmt, ...);=0A=
-static int semod_filename_select (const struct dirent *d);=0A=
-static int semod_copy_dir (const char *src, const char *dst);=0A=
-static int semod_build_modules_list (const char *path, struct dirent =
**namelist,=0A=
-                                     char ***names, char ***versions, =
int *len);=0A=
-static const char *semod_lock_name (void);=0A=
-static const char *semod_conf_name (void);=0A=
-static const char *semod_store_path (void);=0A=
-static const char *semod_active_path (void);=0A=
-static const char *semod_active_modules_path (void);=0A=
-static const char *semod_backup_path (void);=0A=
-=0A=
-/* Write an error message to the current error buffer, up to the=0A=
- * buffer's specified size. */=0A=
-#ifdef __GNUC__=0A=
-__attribute__ ((format (printf, 3, 4)))=0A=
-#endif=0A=
-static void write_error(char *error_buf, size_t error_buf_size, char =
*fmt, ...) {=0A=
-        va_list ap;=0A=
-        if (error_buf =3D=3D NULL) {=0A=
-                return;=0A=
-        }=0A=
-        va_start(ap, fmt);=0A=
-        vsnprintf(error_buf, error_buf_size, fmt, ap);=0A=
-        va_end(ap);=0A=
-}=0A=
-=0A=
-/* THIS MUST BE THE FIRST FUNCTION CALLED IN THIS LIBRARY.  Initialize=0A=
- * the module store at the given 'module_store_path'.  If=0A=
- * 'module_store_path' is NULL then default to selinux_policy_root() +=0A=
- * "/modules".  Next read the libsemod configuration file if it=0A=
- * exists.  You should probably also call semod_create_module_store()=0A=
- * after this one.  Returns 0 on success, -1 if out of memory, -2 if=0A=
- * configuration file could not be read, or -3 if there were errors=0A=
- * while parsing the file.=0A=
- */=0A=
-int semod_init_module_store (char *module_store_path,=0A=
-                             char *error_buf, size_t error_buf_size) {=0A=
-	int i;=0A=
-        size_t len;=0A=
-        char *conf_name;=0A=
-        free (semod_paths[SEMOD_STORE]);=0A=
-        if (module_store_path =3D=3D NULL) {=0A=
-                if (asprintf (&(semod_paths[SEMOD_STORE]), "%s%s", =
selinux_policy_root (), "/modules") =3D=3D -1) {=0A=
-                        write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        else {=0A=
-                if ((semod_paths[SEMOD_STORE] =3D strdup =
(module_store_path)) =3D=3D NULL) {=0A=
-                        write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        len =3D strlen (semod_paths[SEMOD_STORE]);=0A=
-	if (semod_paths[SEMOD_STORE][len - 1] =3D=3D '/') {=0A=
-		semod_paths[SEMOD_STORE][len -1] =3D '\0';=0A=
-		len--;	=0A=
-	}=0A=
-	for (i =3D SEMOD_LOCK; i < SEMOD_NUM_PATHS; i++) {=0A=
-                free (semod_paths[i]);=0A=
-                if (asprintf (&(semod_paths[i]), "%s%s",=0A=
-                              semod_paths[SEMOD_STORE], =
semod_relative_paths[i]) =3D=3D -1) {=0A=
-                        write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                        return -1;=0A=
-                }=0A=
-	}=0A=
-	semod_paths_initialized =3D 1;=0A=
-        conf_name =3D (char *) semod_conf_name();=0A=
-        switch (semod_config_parse (conf_name)) {=0A=
-        case -1: {=0A=
-                write_error (error_buf, error_buf_size, "Could not read =
from semod configuration file %s.", conf_name);=0A=
-                return -2;=0A=
-        }=0A=
-        case 0: return 0;=0A=
-        default: {=0A=
-                write_error (error_buf, error_buf_size, "Could not =
parse configuration file %s.", conf_name);=0A=
-                return -3;=0A=
-        }=0A=
-        }=0A=
-}=0A=
-=0A=
-/* Check that the module store exists.  If 'create' is non-zero then=0A=
- * create the directories.  Returns 0 if module store exists (either=0A=
- * already or just created), -1 if does not exist or could not be=0A=
- * read, or -2 if it could not create the store. */=0A=
-int semod_create_module_store (int create,=0A=
-                               char *error_buf, size_t error_buf_size) {=0A=
-        struct stat sb;=0A=
-        int mode_mask =3D R_OK | W_OK | X_OK;=0A=
-        const char *path =3D semod_store_path ();=0A=
-        if (stat (path, &sb) =3D=3D -1) {=0A=
-                if (errno =3D=3D ENOENT && create) {=0A=
-                        if (mkdir (path, S_IRWXU) =3D=3D -1) {=0A=
-                                write_error (error_buf, error_buf_size, =
"Could not create module store.");=0A=
-                                return -2;=0A=
-                        }=0A=
-                }=0A=
-                else {=0A=
-                        write_error (error_buf, error_buf_size, "Could =
not read from module store.");=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        else {=0A=
-                if (!S_ISDIR (sb.st_mode) || access (path, mode_mask) =
=3D=3D -1) {=0A=
-                        write_error (error_buf, error_buf_size, "Could =
not access module store, or it is not a directory.");=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        if (create) {=0A=
-                if (semod_copy_file (DEFAULT_SEMOD_CONF_LOCATION, =
semod_conf_name ()) =3D=3D -1) {=0A=
-                        write_error (error_buf, error_buf_size, "Could =
not copy default %s.", DEFAULT_SEMOD_CONF_LOCATION);=0A=
-                        return -2;=0A=
-                }=0A=
-        }=0A=
-        path =3D semod_active_path ();=0A=
-        if (stat (path, &sb) =3D=3D -1) {=0A=
-                if (errno =3D=3D ENOENT && create) {=0A=
-                        if (mkdir (path, S_IRWXU) =3D=3D -1) {=0A=
-                                write_error (error_buf, error_buf_size, =
"Could not create module store, active subdirectory.");=0A=
-                                return -2;=0A=
-                        }=0A=
-                }=0A=
-                else {=0A=
-                        write_error (error_buf, error_buf_size, "Could =
not read from module store, active subdirectory.");=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        else {=0A=
-                if (!S_ISDIR (sb.st_mode) || access (path, mode_mask) =
=3D=3D -1) {=0A=
-                        write_error (error_buf, error_buf_size, "Could =
not access module store active subdirectory, or it is not a directory.");=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        path =3D semod_active_modules_path ();=0A=
-        if (stat (path, &sb) =3D=3D -1) {=0A=
-                if (errno =3D=3D ENOENT && create) {=0A=
-                        if (mkdir (path, S_IRWXU) =3D=3D -1) {=0A=
-                                write_error (error_buf, error_buf_size, =
"Could not create module store, active modules subdirectory.");=0A=
-                                return -2;=0A=
-                        }=0A=
-                }=0A=
-                else {=0A=
-                        write_error (error_buf, error_buf_size, "Could =
not read from module store, active modules subdirectory.");=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        else {=0A=
-                if (!S_ISDIR (sb.st_mode) || access (path, mode_mask) =
=3D=3D -1) {=0A=
-                        write_error (error_buf, error_buf_size, "Could =
not access module store active modules subdirectory, or it is not a =
directory.");=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Locking for the module store.  This is very basic locking of the=0A=
- * module store and doesn't do anything if the module store is being=0A=
- * manipulated with a program not using this library (but the policy=0A=
- * should prevent that).  If 'force_lock' is non-zero then delete any=0A=
- * old lock instead of aborting.  Returns 0 on success, -1 if lock=0A=
- * already exists, -2 if it could not create a lock.=0A=
- */=0A=
-int semod_create_store_lock (int force_lock,=0A=
-                             char *error_buf, size_t error_buf_size) {=0A=
-	int fd;=0A=
-	struct stat s;=0A=
-        const char *lock_file =3D semod_lock_name ();=0A=
-=0A=
-	if (stat (lock_file, &s) =3D=3D 0) {=0A=
-                if (force_lock =3D=3D 0) {=0A=
-                        write_error(error_buf, error_buf_size, "Module =
store is already locked.");=0A=
-                        return -1;=0A=
-                }=0A=
-	}=0A=
-=0A=
-	if ((fd =3D creat (lock_file, 0)) =3D=3D -1) {=0A=
-                write_error(error_buf, error_buf_size, "Could not =
create module store lock.");=0A=
-                return -2;=0A=
-	}=0A=
-	(void) close(fd);=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Removes a lock file.  Does nothing if there was not one already=0A=
- * there. */=0A=
-void semod_remove_store_lock (void) {=0A=
-	(void) unlink (semod_lock_name ());=0A=
-}=0A=
-=0A=
-/* Recursively removes the contents of a directory along with the=0A=
- * directory itself.  Returns 0 on success, non-zero on error. */=0A=
-int semod_remove_directory (char *path) {=0A=
-        struct dirent **namelist =3D NULL;=0A=
-        int num_entries, i;=0A=
-        if ((num_entries =3D scandir (path, &namelist, =
semod_filename_select,=0A=
-                                    NULL)) =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        for (i =3D 0; i < num_entries; i++) {=0A=
-                char s[NAME_MAX];=0A=
-                struct stat buf;=0A=
-                (void) snprintf (s, sizeof (s), "%s/%s", path, =
namelist[i]->d_name);=0A=
-                if (stat (s, &buf) =3D=3D -1) {=0A=
-                        return -2;=0A=
-                }=0A=
-                if (S_ISDIR (buf.st_mode)) {=0A=
-                        int retval;=0A=
-                        if ((retval =3D semod_remove_directory (s)) =
!=3D 0) {=0A=
-                                return retval;=0A=
-                        }=0A=
-                }=0A=
-                else {=0A=
-                        if (remove (s) =3D=3D -1) {=0A=
-                                return -3;=0A=
-                        }=0A=
-                }=0A=
-                free (namelist[i]);=0A=
-        }=0A=
-        free (namelist);=0A=
-        if (remove (path) =3D=3D -1) {=0A=
-                return -4;=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Scans the active module directory.  Allocates and fills in *names=0A=
- * and *versions with an array of module names and version; length of=0A=
- * array is stored in *len.  Any elements in names which are NULL=0A=
- * indicate a module that could not be read.  The caller is=0A=
- * responsible for free()ing *names, *versions, and their individual=0A=
- * elements.  Upon success returns 0, -1 if out of memory, or -2 if=0A=
- * module directory could not be scanned. */=0A=
-int semod_get_active_modules_list (char ***names, char ***versions, int =
*len) {=0A=
-        const char *modules_path =3D semod_active_modules_path ();=0A=
-	struct dirent **namelist =3D NULL;=0A=
-=0A=
-	*names =3D *versions =3D NULL;=0A=
-        if ((*len =3D scandir (modules_path, &namelist,=0A=
-                             semod_filename_select, alphasort)) =3D=3D =
-1) {=0A=
-                *len =3D 0;=0A=
-                return -2;=0A=
-        }=0A=
-        if (semod_build_modules_list (modules_path, namelist, names, =
versions, len) =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Given a module name, returns the filename for that module within=0A=
- * the active store's module directory.  If the module does not exist=0A=
- * or if an error occurs return NULL.  The caller is responsible for=0A=
- * free()ing the returned path.=0A=
- */=0A=
-char *semod_get_active_module_filename (char *module_name) {=0A=
-        const char *modules_path =3D semod_active_modules_path ();=0A=
-	struct dirent **namelist =3D NULL;=0A=
-        char *filename =3D NULL;=0A=
-        int i, len;=0A=
-        if ((len =3D scandir (modules_path, &namelist,=0A=
-                            semod_filename_select, alphasort)) =3D=3D =
-1) {=0A=
-                return NULL;=0A=
-        }=0A=
-        for (i =3D 0; i < len; i++) {=0A=
-                char *name =3D NULL, *version =3D NULL;=0A=
-                struct policy_file pf;=0A=
-                int type, retval;=0A=
-                if (asprintf (&filename, "%s/%s", modules_path, =
namelist[i]->d_name) =3D=3D -1) {=0A=
-                        filename =3D NULL;=0A=
-                        goto finish;=0A=
-                }=0A=
-		if ((pf.fp =3D fopen (filename, "r")) =3D=3D NULL) {=0A=
-                        free (filename);=0A=
-                        filename =3D NULL;=0A=
-                        continue;  /* could not open this module for =
reading */=0A=
-		}=0A=
-		pf.type =3D PF_USE_STDIO;=0A=
-		retval =3D sepol_module_package_info(&pf, &type, &name, &version);=0A=
-                (void) fclose (pf.fp);=0A=
-                free (version);=0A=
-		if (retval =3D=3D 0 && type =3D=3D POLICY_MOD && strcmp (name, =
module_name) =3D=3D 0) {=0A=
-                        free (name);=0A=
-                        goto finish;=0A=
-		}=0A=
-                free (name);=0A=
-                free (filename);=0A=
-                filename =3D NULL;=0A=
-        }=0A=
- finish:=0A=
-        for (i =3D 0; i < len; i++) {=0A=
-                free (namelist[i]);=0A=
-        }=0A=
-        free (namelist);=0A=
-        return filename;=0A=
-}=0A=
-=0A=
-/* Given some filename, checks if that file exists and is readable=0A=
- * relative to the active store directory.  If so returns a newly=0A=
- * allocated path to the active version, otherwise return NULL.  The=0A=
- * caller is responsible for free()ing the returned path.=0A=
- */=0A=
-char *semod_get_active_filename (char *filename) {=0A=
-        const char *active_path =3D semod_active_path ();=0A=
-        char *active_filename;=0A=
-        if (asprintf (&active_filename, "%s/%s", active_path, filename) =
=3D=3D -1) {=0A=
-                return NULL;=0A=
-        }=0A=
-        if (access (active_filename, R_OK) =3D=3D 0) {=0A=
-                return active_filename;=0A=
-        }=0A=
-        free (active_filename);=0A=
-        return NULL;=0A=
-}=0A=
-=0A=
-/* Callback used by scandir() to select files. */=0A=
-static int semod_filename_select (const struct dirent *d) {=0A=
-	int len;=0A=
-=0A=
-	/* For some reason XFS doesn't set d_type so we actually have=0A=
-	 * to use stat() to decide if it's a directory or not :(=0A=
-	 */=0A=
-	len =3D strlen(d->d_name);=0A=
-	if (len =3D=3D 1 && d->d_name[0] =3D=3D '.')=0A=
-		return 0;=0A=
-	if (len =3D=3D 2 && d->d_name[0] =3D=3D '.' &&=0A=
-	    d->d_name[1] =3D=3D '.')=0A=
-		return 0;=0A=
-	return 1;=0A=
-}=0A=
-=0A=
-/********************* sandbox management routines =
*********************/=0A=
-=0A=
-/* Creates a sandbox for a single client.  The sandbox's name is the=0A=
- * concatenation of SEMOD_STORE + SEMOD_TMP + suffix; if suffix is=0A=
- * NULL then it is treated as an empty string.  Returns the sandbox=0A=
- * name, or NULL upon error.=0A=
- */=0A=
-char *semod_make_sandbox (char *suffix,=0A=
-                          char *error_buf, size_t error_buf_size) {=0A=
-        char *tmp_path, *tmp_modules_path;=0A=
-        struct stat buf;=0A=
-        SEMOD_CHECK_INIT;=0A=
-=0A=
-        if (suffix =3D=3D NULL) {=0A=
-                suffix =3D "";=0A=
-        }=0A=
-        if (asprintf (&tmp_path, "%s%s%s", semod_paths[SEMOD_STORE],=0A=
-                      semod_sandbox_paths[SEMOD_TMP], suffix) =3D=3D =
-1) {=0A=
-                return NULL;=0A=
-        }=0A=
-        /* check if path already exists; if so delete it */=0A=
-        if (stat (tmp_path, &buf) =3D=3D 0) {=0A=
-                if (S_ISDIR (buf.st_mode)) {=0A=
-                        if (semod_remove_directory (tmp_path) !=3D 0) {=0A=
-                                write_error (error_buf, error_buf_size, =
"Could not remove existing sandbox %s.", tmp_path);=0A=
-                                return NULL;=0A=
-                        }=0A=
-                }=0A=
-        }=0A=
-        else if (errno !=3D ENOENT) {=0A=
-                return NULL;=0A=
-        }=0A=
-        if (mkdir (tmp_path, S_IRWXU) =3D=3D -1 ||=0A=
-            (semod_copy_dir (semod_active_path (), tmp_path)) =3D=3D =
-1) {=0A=
-                write_error (error_buf, error_buf_size, "Could not copy =
files to sandbox.");=0A=
-                return NULL;=0A=
-        }=0A=
-        if ((tmp_modules_path =3D semod_sandbox_modules_path =
(tmp_path)) =3D=3D NULL ||=0A=
-            mkdir (tmp_modules_path, S_IRWXU) =3D=3D -1 ||=0A=
-            semod_copy_dir (semod_active_modules_path (), =
tmp_modules_path) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Could not copy =
modules to sandbox.");=0A=
-                return NULL;=0A=
-        }=0A=
-        free (tmp_modules_path);=0A=
-        return tmp_path;=0A=
-}=0A=
-=0A=
-/* Deletes the previous (backup) directory, if it exists.  Moves the=0A=
- * current active path to the backup, then moves the sandbox over to=0A=
- * active.  Returns 0 if commit was successful, -1 if it could not=0A=
- * remove the backup directory, -2 if the active directory not=0A=
- * renamed, or -3 if sandbox directory not renamed.=0A=
- */=0A=
-int semod_commit_sandbox (char *sandbox) {=0A=
-        const char *active =3D semod_active_path ();=0A=
-        const char *backup =3D semod_backup_path ();=0A=
-        struct stat buf;=0A=
-        /* check if backup exists; if so delete it */=0A=
-        if (stat (backup, &buf) =3D=3D 0) {=0A=
-                if (S_ISDIR (buf.st_mode) && =0A=
-                    semod_remove_directory ((char *) backup) !=3D 0) {=0A=
-                        return -1;=0A=
-                }=0A=
-        }=0A=
-        else if (errno !=3D ENOENT) {=0A=
-                return -1;=0A=
-        }=0A=
-        if (rename (active, backup) =3D=3D -1) {=0A=
-                return -2;=0A=
-        }=0A=
-        if (rename (sandbox, active) =3D=3D -1) {=0A=
-                return -3;=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Moves the active directory back to the sandbox path, then move the=0A=
- * backup back to active.  Returns 0 on success, -2 if the active=0A=
- * directory not renamed, or -3 if sandbox directory not renamed.=0A=
- */=0A=
-int semod_undo_commit_sandbox (char *sandbox) {=0A=
-        const char *active =3D semod_active_path ();=0A=
-        const char *backup =3D semod_backup_path ();=0A=
-        if (rename (active, sandbox) =3D=3D -1) {=0A=
-                return -2;=0A=
-        }=0A=
-        if (rename (backup, active) =3D=3D -1) {=0A=
-                return -3;=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Scans the modules directory within a sandbox.  Allocates and fills=0A=
- * in *filenames with an array of module filenames; length of array is=0A=
- * stored in *len.  The caller is responsible for free()ing *filenames=0A=
- * and its individual elements.  Upon success returns 0, -1 if out of=0A=
- * memory, or -2 if module directory could not be scanned.=0A=
- */=0A=
-int semod_get_sandbox_modules_names (char *sandbox, char ***filenames, =
int *len) {=0A=
-        char *modules_path =3D semod_sandbox_modules_path (sandbox);=0A=
-	struct dirent **namelist =3D NULL;=0A=
-	int i;=0A=
-=0A=
-	*filenames =3D NULL;=0A=
-        *len =3D 0;=0A=
-        if (modules_path =3D=3D NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((*len =3D scandir (modules_path, &namelist,=0A=
-                             semod_filename_select, alphasort)) =3D=3D =
-1) {=0A=
-                *len =3D 0;=0A=
-                free (modules_path);=0A=
-                return -2;=0A=
-        }=0A=
-        if (*len =3D=3D 0) {=0A=
-                free (modules_path);=0A=
-                return 0;=0A=
-        }	=0A=
-	if ((*filenames =3D (char **) calloc (*len, sizeof (**filenames))) =
=3D=3D NULL) {=0A=
-                return -1;=0A=
-	}	=0A=
-	for (i =3D 0; i < *len; i++) {=0A=
-                char *filename;=0A=
-                if (asprintf (&filename, "%s/%s", modules_path, =
namelist[i]->d_name) =3D=3D -1) {=0A=
-                        return -1;=0A=
-                }=0A=
-                (*filenames)[i] =3D filename;=0A=
-                free (namelist[i]);=0A=
-	}=0A=
-        free (modules_path);=0A=
-        free (namelist);=0A=
-	return 0;=0A=
-}=0A=
-=0A=
-/* Scans the sandbox module directory.  Allocates and fills in *names=0A=
- * and *versions with an array of module names and versions; length of=0A=
- * array is stored in *len.  Any elements in names which are NULL=0A=
- * indicate a module that could not be read.  The caller is=0A=
- * responsible for free()ing *names, *versions, and their individual=0A=
- * elements.  Upon success returns 0, -1 if out of memory, or -2 if=0A=
- * module directory could not be scanned.=0A=
- */=0A=
-int semod_get_sandbox_modules_list (char *sandbox, char ***names, char =
***versions, int *len) {=0A=
-        char *sandbox_path =3D semod_sandbox_modules_path (sandbox);=0A=
-        struct dirent **namelist =3D NULL;=0A=
-        *names =3D *versions =3D NULL;=0A=
-        *len =3D 0;=0A=
-        if (sandbox_path =3D=3D NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((*len =3D scandir (sandbox_path, &namelist,=0A=
-                             semod_filename_select, alphasort)) =3D=3D =
-1) {=0A=
-                *len =3D 0;=0A=
-                free (sandbox_path);=0A=
-                return -2;=0A=
-        }=0A=
-        if (semod_build_modules_list (sandbox_path, namelist, names, =
versions, len) =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        free (sandbox_path);=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Returns the modules subdirectory given a sandbox name.  Caller is=0A=
- * responsible for free()ing the path afterwards.  Returns NULL on out=0A=
- * of memory.=0A=
- */=0A=
-char *semod_sandbox_modules_path (char *sandbox) {=0A=
-        char *tmp_modules_path;=0A=
-        if (asprintf (&tmp_modules_path, "%s%s", sandbox,=0A=
-                      semod_sandbox_paths[SEMOD_TMP_MODULES]) =3D=3D =
-1) {=0A=
-                return NULL;=0A=
-        }=0A=
-        return tmp_modules_path;=0A=
-}=0A=
-=0A=
-/* Returns the kernel policy name given a sandbox name.  Caller is=0A=
- * responsible for free()ing the path afterwards.  Returns NULL on out=0A=
- * of memory.=0A=
- */=0A=
-char *semod_sandbox_kernel_name (char *sandbox) {=0A=
-        char *tmp_kernel_name;=0A=
-        if (asprintf (&tmp_kernel_name, "%s%s", sandbox,=0A=
-                      semod_sandbox_paths[SEMOD_TMP_KERNEL]) =3D=3D -1) =
{=0A=
-                return NULL;=0A=
-        }=0A=
-        return tmp_kernel_name;=0A=
-}=0A=
-=0A=
-/* Returns the base policy name given a sandbox name.  Caller is=0A=
- * responsible for free()ing the path afterwards.  Returns NULL on out=0A=
- * of memory.=0A=
- */=0A=
-char *semod_sandbox_base_name (char *sandbox) {=0A=
-        char *tmp_base_name;=0A=
-        if (asprintf (&tmp_base_name, "%s%s", sandbox,=0A=
-                      semod_sandbox_paths[SEMOD_TMP_BASE]) =3D=3D -1) {=0A=
-                return NULL;=0A=
-        }=0A=
-        return tmp_base_name;=0A=
-}=0A=
-=0A=
-/* Returns the linked module name given a sandbox name.  Caller is=0A=
- * responsible for free()ing the path afterwards.  Returns NULL on out=0A=
- * of memory.=0A=
- */=0A=
-char *semod_sandbox_linked_name (char *sandbox) {=0A=
-        char *tmp_linked_name;=0A=
-        if (asprintf (&tmp_linked_name, "%s%s", sandbox,=0A=
-                      semod_sandbox_paths[SEMOD_TMP_LINKED]) =3D=3D -1) =
{=0A=
-                return NULL;=0A=
-        }=0A=
-        return tmp_linked_name;=0A=
-}=0A=
-=0A=
-/* Returns the file contexts name given a sandbox name.  Caller is=0A=
- * responsible for free()ing the path afterwards.  Returns NULL on out=0A=
- * of memory.=0A=
- */=0A=
-char *semod_sandbox_fc_name (char *sandbox) {=0A=
-        char *tmp_fc_name;=0A=
-        if (asprintf (&tmp_fc_name, "%s%s", sandbox,=0A=
-                      semod_sandbox_paths[SEMOD_TMP_FC]) =3D=3D -1) {=0A=
-                return NULL;=0A=
-        }=0A=
-        return tmp_fc_name;=0A=
-}=0A=
-=0A=
-/* Copies all of the files from src to dst.  Does not recurse into=0A=
- * subdirectories.  Returns 0 on success, -1 on error. */=0A=
-static int semod_copy_dir (const char *src, const char *dst) {=0A=
-	int i, len;=0A=
-	struct stat sb;=0A=
-	struct dirent **names;=0A=
-	char path[PATH_MAX], path2[PATH_MAX];=0A=
-=0A=
-        if ((len =3D scandir (src, &names, semod_filename_select, =
NULL)) =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-	for (i =3D 0; i < len; i++) {=0A=
-		(void) snprintf (path, sizeof (path), "%s/%s", src, names[i]->d_name);=0A=
-		/* stat() to see if this entry is a file or not since=0A=
-		 * d_type isn't set properly on XFS */=0A=
-                if (stat (path, &sb)) {=0A=
-                        return -1;=0A=
-		}=0A=
-  		if (!S_ISREG (sb.st_mode))=0A=
- 			continue;=0A=
- =0A=
- 		(void) snprintf (path2, sizeof (path2), "%s/%s", dst, =
names[i]->d_name);=0A=
-		if (semod_copy_file (path, path2) =3D=3D -1) {=0A=
-                        return -1;=0A=
-		}=0A=
-		free (names[i]);=0A=
-	}=0A=
-	free (names);=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/********************* other I/O functions *********************/=0A=
-=0A=
-/* Copies a file from src to dst.  If dst already exists then=0A=
- * overwrite it.  Returns 0 on success, -1 on error. */=0A=
-int semod_copy_file (const char *src, const char *dst) {=0A=
-	int in, out, retval =3D 0, amount_read;=0A=
-        char buf[4192];=0A=
-        if ((in =3D open (src, O_RDONLY)) =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((out =3D open (dst, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR)) =
=3D=3D -1) {=0A=
-                close (in);=0A=
-                return -1;=0A=
-        }=0A=
-        while (retval =3D=3D 0 &&=0A=
-               (amount_read =3D read (in, buf, sizeof (buf))) > 0) {=0A=
-                if (write (out, buf, amount_read) !=3D amount_read) {=0A=
-                        retval =3D -1;=0A=
-                }=0A=
-        }=0A=
-	if (amount_read < 0)=0A=
-		retval =3D -1;=0A=
-        close (in);=0A=
-        close (out);=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-/* Iterates through each element of namelist and allocates space=0A=
- * within the names and versions list of modules that could be read.=0A=
- * free()s namelist and its elements afterwards.  Returns 0 on success,=0A=
- * -1 if out of memory.=0A=
- */=0A=
-static int semod_build_modules_list (const char *path, struct dirent =
**namelist,=0A=
-                                     char ***names, char ***versions, =
int *len) {=0A=
-	int i;=0A=
-        struct policy_file pf;=0A=
-        *names =3D *versions =3D NULL;=0A=
-        if (*len =3D=3D 0) {=0A=
-                return 0;=0A=
-        }	=0A=
-	if ((*names =3D (char **) calloc (*len, sizeof (**names))) =3D=3D NULL =
||=0A=
-            (*versions =3D (char **) calloc (*len, sizeof =
(**versions))) =3D=3D NULL) {=0A=
-                goto err;=0A=
-	}=0A=
-	for (i =3D 0; i < *len; i++) {=0A=
-                char *filename, *name, *version;=0A=
-                int type;=0A=
-                if (asprintf (&filename, "%s/%s", path, =
namelist[i]->d_name) =3D=3D -1) {=0A=
-                        goto err;=0A=
-                }=0A=
-		if ((pf.fp =3D fopen (filename, "r")) =3D=3D NULL) {=0A=
-                        free (filename);=0A=
-                        continue;=0A=
-		}=0A=
-                free (filename);=0A=
-		pf.type =3D PF_USE_STDIO;=0A=
-		if (sepol_module_package_info(&pf, &type, &name, &version)) {=0A=
-			(void) fclose (pf.fp);=0A=
-                        continue;=0A=
-		}=0A=
-                (void) fclose (pf.fp);=0A=
-		if (type =3D=3D POLICY_MOD) {=0A=
-                        (*names)[i] =3D name;=0A=
-                        (*versions)[i] =3D version;=0A=
-                }=0A=
-                free (namelist[i]);=0A=
-	}=0A=
-        free(namelist);=0A=
-        return 0;=0A=
-=0A=
-err:=0A=
-	if (*names) {=0A=
-		for (i=3D0; i< *len; i++) {=0A=
-			if ((*names)[i])=0A=
-				free((*names)[i]);=0A=
-		}=0A=
-		free(*names);=0A=
-	}=0A=
-	if (*versions) {=0A=
-		for (i=3D0; i< *len; i++) {=0A=
-			if ((*versions)[i])=0A=
-				free((*versions)[i]);=0A=
-		}=0A=
-		free(*versions);=0A=
-	}=0A=
-=0A=
-	return -1;=0A=
-}=0A=
-=0A=
-/********************* accessor functions below *********************/=0A=
-=0A=
-const char *semod_active_base_name (void) {=0A=
-        SEMOD_CHECK_INIT;=0A=
-        return semod_paths[SEMOD_ACTIVE_BASE];=0A=
-}=0A=
-=0A=
-const char *semod_active_kernel_name (void) {=0A=
-        SEMOD_CHECK_INIT;=0A=
-        return semod_paths[SEMOD_ACTIVE_KERNEL];=0A=
-}=0A=
-=0A=
-const char *semod_active_kernel_backup_name (void) {=0A=
-        SEMOD_CHECK_INIT;=0A=
-        return semod_paths[SEMOD_ACTIVE_KERNEL_BACKUP];=0A=
-}=0A=
-=0A=
-const char *semod_active_fc_name(void)=0A=
-{=0A=
-	SEMOD_CHECK_INIT;=0A=
-	return semod_paths[SEMOD_ACTIVE_FC];=0A=
-}=0A=
-=0A=
-const char *semod_active_fc_backup_name(void)=0A=
-{=0A=
-	SEMOD_CHECK_INIT;=0A=
-	return semod_paths[SEMOD_ACTIVE_FC_BACKUP];=0A=
-}=0A=
-=0A=
-static const char *semod_lock_name(void)=0A=
-{=0A=
-        SEMOD_CHECK_INIT;=0A=
-        return semod_paths[SEMOD_LOCK];=0A=
-}=0A=
-=0A=
-static const char *semod_conf_name(void)=0A=
-{=0A=
-        SEMOD_CHECK_INIT;=0A=
-        return semod_paths[SEMOD_CONF];=0A=
-}=0A=
-=0A=
-static const char *semod_store_path(void)=0A=
-{=0A=
-	SEMOD_CHECK_INIT;=0A=
-	return semod_paths[SEMOD_STORE];=0A=
-}=0A=
-            =0A=
-static const char *semod_active_path(void)=0A=
-{=0A=
-	SEMOD_CHECK_INIT;=0A=
-	return semod_paths[SEMOD_ACTIVE];=0A=
-}=0A=
-=0A=
-static const char *semod_active_modules_path(void)=0A=
-{=0A=
-	SEMOD_CHECK_INIT;=0A=
-	return semod_paths[SEMOD_ACTIVE_MODULES];=0A=
-}=0A=
-=0A=
-static const char *semod_backup_path (void) {=0A=
-        SEMOD_CHECK_INIT;=0A=
-        return semod_paths[SEMOD_BACKUP];=0A=
-}=0A=

------=_NextPart_000_00A7_01C5C2D3.42AD5170--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
