Message-Id: <200509262348.j8QNm8Ys018839@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage-reorg 5/7 
Date: Mon, 26 Sep 2005 19:48:08 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00A4_01C5C2D3.38081930"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_00A4_01C5C2D3.38081930
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch removes module_direct_api.c. Most of this code is changed and
moved to direct_api.c in the next patch set.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_00A4_01C5C2D3.38081930
Content-Type: application/octet-stream;
	name="5-remove-module_direct_api.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="5-remove-module_direct_api.diff"

--- libsemanage/src/module_direct_api.c	2005-09-19 09:03:15.000000000 =
-0400=0A=
+++ libsemanage/src/module_direct_api.c	1969-12-31 19:00:00.000000000 =
-0500=0A=
@@ -1,536 +0,0 @@=0A=
-/* Author: Jason Tang     <jtang@tresys.com>=0A=
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
-#ifndef _GNU_SOURCE=0A=
-#define _GNU_SOURCE=0A=
-#endif=0A=
-=0A=
-#include "semanage/commit_api.h"=0A=
-#include "semanage/module_store.h"=0A=
-#include "semanage/semod_conf.h"=0A=
-=0A=
-#include <sepol/module.h>=0A=
-=0A=
-#include <fcntl.h>=0A=
-#include <stdarg.h>=0A=
-#include <string.h>=0A=
-#include <unistd.h>=0A=
-=0A=
-#include <sepol/policydb.h>=0A=
-=0A=
-static void write_error(char *error_buf, size_t error_buf_size, char =
*fmt, ...);=0A=
-static int parse_module_headers (char *sandbox, char *module_data,=0A=
-                                 size_t data_len, char **module_name,=0A=
-                                 char **version, char **filename,=0A=
-                                 char *error_buf, size_t =
error_buf_size);=0A=
-static int parse_base_headers (char *sandbox, char *module_data,=0A=
-                               size_t data_len,=0A=
-                               char *error_buf, size_t error_buf_size);=0A=
-static int write_file (char *filename, char *data, size_t num_bytes);=0A=
-static int list_modules_common (char **results,=0A=
-                                char **names, char **versions, int len);=0A=
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
-/* Writes a module to the sandbox's module directory, overwriting any=0A=
- * previous module stored within.  The module name will be stored in=0A=
- * '*modname' if it is not NULL (caller is responsible for free()ing=0A=
- * it afterwards).  Note that 'module_data' is not free()d by this=0A=
- * function; caller is responsible for deallocating it if necessary.=0A=
- * Returns 0 on success, -1 if out of memory, -2 if the data does not=0A=
- * represent a valid module file, -3 if error while writing file. */=0A=
-int semod_direct_install_module(char *sandbox, char *module_data,=0A=
-                                size_t data_len, char **modname,=0A=
-                                char *error_buf, size_t error_buf_size) =
{=0A=
-        int retval;=0A=
-        char *module_name, *version, *filename;=0A=
-        if ((retval =3D parse_module_headers (sandbox, module_data, =
data_len,=0A=
-                                            &module_name, &version, =
&filename,=0A=
-                                            error_buf, error_buf_size)) =
!=3D 0) {=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if (write_file (filename, module_data, data_len) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Could not =
write module.");=0A=
-                retval =3D -3;=0A=
-        }=0A=
-        else {=0A=
-                retval =3D 0;=0A=
-        }=0A=
- cleanup:=0A=
-        free (version);=0A=
-        free (filename);=0A=
-        if (modname =3D=3D NULL) {=0A=
-                free (module_name);=0A=
-        }=0A=
-        else {=0A=
-                *modname =3D module_name;=0A=
-        }=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-/* Similar to semod_install_module(), except that it checks that there=0A=
- * already exists a module with the same name and that the module is=0A=
- * an older version then the one in 'module_data'.  Caller is=0A=
- * responsible for free()ing '*modname' afterwards, if 'modname' is=0A=
- * not NULL.  Returns 0 on success, -1 if out of memory, -2 if the=0A=
- * data does not represent a valid module file, -3 if error while=0A=
- * writing file or reading modules directory, -4 if there does not=0A=
- * exist an older module, or -5 if the previous module is same or=0A=
- * newer than 'module_data'.=0A=
- */=0A=
-int semod_direct_upgrade_module(char *sandbox, char *module_data,=0A=
-                                size_t data_len, char **modname,=0A=
-                                char *error_buf, size_t error_buf_size) =
{=0A=
-        int retval, num_old =3D 0, i;=0A=
-        char *module_name, *version, *filename;=0A=
-        char **old_names =3D NULL, **old_versions =3D NULL;=0A=
-        if ((retval =3D parse_module_headers (sandbox, module_data, =
data_len,=0A=
-                                            &module_name, &version, =
&filename,=0A=
-                                            error_buf, error_buf_size)) =
!=3D 0) {=0A=
-                goto cleanup;=0A=
-        }=0A=
-        switch (semod_get_sandbox_modules_list (sandbox, &old_names,=0A=
-                                                &old_versions, =
&num_old)) {=0A=
-        case -1: {=0A=
-                write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        case -2: {=0A=
-                write_error (error_buf, error_buf_size, "Could not read =
sandbox modules.");=0A=
-                retval =3D -3;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        }=0A=
-        retval =3D -4;=0A=
-        for (i =3D 0; i < num_old; i++) {=0A=
-                if (strcmp (old_names [i], module_name) =3D=3D 0) {=0A=
-                        if (strverscmp (version, old_versions [i]) > 0) =
{=0A=
-                                retval =3D 0;=0A=
-                                break;=0A=
-                        }=0A=
-                        else {=0A=
-                                write_error (error_buf, error_buf_size, =
"Previous module %s is same or newer.", module_name);=0A=
-                                retval =3D -5;=0A=
-                                goto cleanup;=0A=
-                        }=0A=
-                }=0A=
-        }=0A=
-        if (retval =3D=3D -4) {=0A=
-                write_error (error_buf, error_buf_size, "There does not =
already exist a module named %s.", module_name);=0A=
-        }=0A=
-        else {=0A=
-                if (write_file (filename, module_data, data_len) =3D=3D =
-1) {=0A=
-                        write_error (error_buf, error_buf_size, "Could =
not write module.");=0A=
-                        retval =3D -3;=0A=
-                }=0A=
-        }=0A=
- cleanup:=0A=
-        free (version);=0A=
-        free (filename);=0A=
-        for (i =3D 0; i < num_old; i++) {=0A=
-                free (old_names [i]);=0A=
-                free (old_versions [i]);=0A=
-        }=0A=
-        free (old_names);=0A=
-        free (old_versions);=0A=
-        if (modname =3D=3D NULL) {=0A=
-                free (module_name);=0A=
-        }=0A=
-        else {=0A=
-                *modname =3D module_name;=0A=
-        }=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-/* Writes a base module into a sandbox, overwriting any previous base=0A=
- * module.  The fully qualified filename for the module will be stored=0A=
- * in 'filename' if it is not NULL (caller is responsible for=0A=
- * free()ing it afterwards).  Note that 'module_data' is not free()d=0A=
- * by this function; caller is responsible for deallocating it if=0A=
- * necessary.  Returns 0 on success, -1 if out of memory, -2 if the=0A=
- * data does not represent a valid module file, -3 if error while=0A=
- * writing file.=0A=
- */=0A=
-int semod_direct_install_base_module(char *sandbox, char *module_data,=0A=
-                                     size_t data_len,=0A=
-                                     char *error_buf, size_t =
error_buf_size) {=0A=
-        int retval;=0A=
-        char *filename =3D NULL;=0A=
-        if ((retval =3D parse_base_headers (sandbox, module_data, =
data_len,=0A=
-                                          error_buf, error_buf_size)) =
!=3D 0) {=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if ((filename =3D semod_sandbox_base_name (sandbox)) =3D=3D =
NULL) {=0A=
-                write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if (write_file (filename, module_data, data_len) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Could not =
write base module.");=0A=
-                retval =3D -3;=0A=
-        }=0A=
-        else {=0A=
-                retval =3D 0;=0A=
-        }=0A=
- cleanup:=0A=
-        free (filename);=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-/* Remove (unlink(2)) a module from the sandbox.  Returns 0 on=0A=
- * success, -1 if out of memory, -2 if could not read module store, -3=0A=
- * if module could not be removed, or -4 if module not found.=0A=
- */=0A=
-int semod_direct_remove_module(char *sandbox, char *module_name,=0A=
-                               char *error_buf, size_t error_buf_size) {=0A=
-        char **module_names;=0A=
-        int num_modules =3D 0, i, retval;=0A=
-        size_t name_len =3D strlen (module_name);=0A=
-        if ((retval =3D semod_get_sandbox_modules_names (sandbox, =
&module_names,=0A=
-                                                       &num_modules)) =
!=3D 0) {=0A=
-                write_error (error_buf, error_buf_size, "Could not read =
module names.");=0A=
-                goto cleanup;=0A=
-        }=0A=
-        for (i =3D 0; i < num_modules; i++) {=0A=
-                char *base =3D strrchr (module_names[i], '/');=0A=
-                if (base =3D=3D NULL) {=0A=
-                        write_error (error_buf, error_buf_size, "Could =
not read module names.");=0A=
-                        retval =3D -2;=0A=
-                        goto cleanup;=0A=
-                }=0A=
-                base++;=0A=
-                if (memcmp (module_name, base, name_len) =3D=3D 0 &&=0A=
-                    strcmp (base + name_len, ".pp") =3D=3D 0) {=0A=
-                        if (unlink (module_names[i]) =3D=3D -1) {=0A=
-                                write_error (error_buf, error_buf_size, =
"Could not remove module.");=0A=
-                                retval =3D -3;=0A=
-                        }=0A=
-                        else {=0A=
-                                retval =3D 0;=0A=
-                        }=0A=
-                        goto cleanup;=0A=
-                }=0A=
-        }=0A=
-        write_error (error_buf, error_buf_size, "Module %s was not =
found.", module_name);=0A=
-        retval =3D -4;                               /* module not =
found */=0A=
- cleanup:=0A=
-        for (i =3D 0; i < num_modules; i++) {=0A=
-                free (module_names[i]);=0A=
-        }=0A=
-        free (module_names);=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-/* Obtains a list of modules in the currently active kernel.  Write a=0A=
- * newline separated list to '*results', which will be dynamically=0A=
- * allocated.  The caller is responsible for free()ing '*results'=0A=
- * afterwards.  Returns 0 on success, -1 if out of memory, or -2 a=0A=
- * module could not be read.  Note that if there are no modules then=0A=
- * *results will point to a newly allocated empty string.=0A=
- */=0A=
-int semod_direct_list_modules(char **results) {=0A=
-        int len, retval;=0A=
-        char **names, **versions;=0A=
-        *results =3D NULL;=0A=
-        if ((retval =3D semod_get_active_modules_list (&names, =
&versions, &len)) < 0) {=0A=
-                return retval;=0A=
-        }=0A=
-        return list_modules_common (results, names, versions, len);=0A=
-}=0A=
-=0A=
-/* Obtains a list of modules in the current sandbox.  Write a newline=0A=
- * separated list to '*results', which will be dynamically allocated.=0A=
- * The caller is responsible for free()ing '*results' afterwards.=0A=
- * Returns 0 on success, -1 if out of memory, or -2 a module could not=0A=
- * be read.  Note that if there are no modules then *results will will=0A=
- * point to a newly allocated empty string.=0A=
- */=0A=
-int semod_direct_list_sandbox(char *sandbox, char **results) {=0A=
-        int len, retval;=0A=
-        char **names, **versions;=0A=
-        *results =3D NULL;=0A=
-        if ((retval =3D semod_get_sandbox_modules_list (sandbox,=0A=
-                                                      &names, =
&versions, &len)) < 0) {=0A=
-                return retval;=0A=
-        }=0A=
-        return list_modules_common (results, names, versions, len);=0A=
-}=0A=
-=0A=
-/* Commits all changes in sandbox to the actual kernel policy.=0A=
- * 'policyvers' gives the version number for the final policy;=0A=
- * POLICYDB_VERSION_MAX is recommended.  Returns 0 on success, -1 if=0A=
- * the module link failed, -2 if module expand failed, or -3 if=0A=
- * loading of final policy failed.  If there were no errors (i.e.,=0A=
- * return value of 0, then the sandbox directory shall no longer=0A=
- * exist).  (If the 'sandbox' variable was dynamically allocated the=0A=
- * caller is still responsible for free()ing its memory.)=0A=
- */=0A=
-int semod_direct_commit(char *sandbox, unsigned int policyvers,=0A=
-                        char *error_buf, size_t error_buf_size) {=0A=
-        char **mod_filenames =3D NULL, *linked_filename =3D NULL, =
*fc_filename =3D NULL;=0A=
-        sepol_module_package_t *base =3D NULL, **mods =3D NULL;=0A=
-        int retval, num_modfiles =3D 0, num_modules =3D 0, i;=0A=
-=0A=
-        if (semod_get_sandbox_modules_names (sandbox, &mod_filenames, =
&num_modfiles) !=3D 0 ||=0A=
-            semod_verify_modules (sandbox, mod_filenames, num_modfiles) =
!=3D 0) {=0A=
-                write_error (error_buf, error_buf_size, "Could not =
verify modules.");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if (semod_link_sandbox (sandbox, &base, &mods, &num_modules, =
error_buf, error_buf_size) < 0) {=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-=0A=
-        /* write the linked base */=0A=
-        if ((linked_filename =3D semod_sandbox_linked_name (sandbox)) =
=3D=3D NULL ||=0A=
-            semod_write_module (linked_filename, base, POLICY_BASE, =
POLICYDB_VERSION_MAX) =3D=3D -1 ||=0A=
-            semod_verify_linked (sandbox) !=3D 0) {=0A=
-                write_error (error_buf, error_buf_size, "Could not =
verify linked module.");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-=0A=
-        /* write the linked file contexts */=0A=
-        if ((fc_filename =3D semod_sandbox_fc_name (sandbox)) =3D=3D =
NULL ||=0A=
-            write_file (fc_filename, base->file_contexts, =
base->file_contexts_len) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Could not =
write file contexts.");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        =0A=
-        if (semod_expand_sandbox (sandbox, base, policyvers, error_buf, =
error_buf_size) < 0) {=0A=
-                retval =3D -2;=0A=
-                goto cleanup;=0A=
-        }=0A=
-=0A=
-        if (semod_verify_kernel (sandbox) !=3D 0) {=0A=
-                write_error (error_buf, error_buf_size, "Could not =
verify expanded module.");=0A=
-                retval =3D -2;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if (semod_install_sandbox (sandbox, error_buf, error_buf_size) =
< 0) {=0A=
-                retval =3D -3;=0A=
-        }=0A=
-        else {=0A=
-                retval =3D 0;=0A=
-        }=0A=
- cleanup:=0A=
-        for (i =3D 0; mod_filenames !=3D NULL && i < num_modfiles; i++) =
{=0A=
-                free (mod_filenames[i]);=0A=
-        }=0A=
-        free (mod_filenames);=0A=
-        free (linked_filename);=0A=
-        free (fc_filename);=0A=
-        sepol_module_package_destroy(base);=0A=
-        for (i =3D 0; mods !=3D NULL && i < num_modules; i++) {=0A=
-                sepol_module_package_destroy(mods[i]);=0A=
-        }=0A=
-        free (mods);=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-=0A=
-/* Check that the module store exists and then create a lock on the=0A=
- * module store.  Next create a sandbox.  Returns a pointer to the=0A=
- * sandbox or NULL on error.  The caller is responsible for free()ing=0A=
- * the pointer afterwards.=0A=
- */=0A=
-char *semod_direct_connect (char *error_buf, size_t error_buf_size) {=0A=
-        char *sandbox;=0A=
-        if (semod_create_module_store (0, error_buf, error_buf_size) < =
0 ||=0A=
-            semod_create_store_lock (0, error_buf, error_buf_size) < 0) =
{=0A=
-                return NULL;=0A=
-        }=0A=
-        sandbox =3D semod_make_sandbox ("-libsemod", error_buf, =
error_buf_size);=0A=
-        return sandbox;=0A=
-}=0A=
-=0A=
-/* If 'commit' is non-zero, attempt to commit the sandbox.  If the=0A=
- * commit failed then destroy the sandbox.  Regardless if there was a=0A=
- * commit or not, remove the store lock and free() 'sandbox'.  Returns=0A=
- * 0 on success, negative value on error.=0A=
- */=0A=
-int semod_direct_disconnect (char *sandbox, int commit,=0A=
-                             char *error_buf, size_t error_buf_size) {=0A=
-        int retval =3D 0;=0A=
-        if (commit) {=0A=
-                retval =3D semod_direct_commit (sandbox, =
semod_get_current_conf ()->policyvers,=0A=
-                                              error_buf, =
error_buf_size);=0A=
-                if (retval < 0) {=0A=
-                        (void) semod_remove_directory (sandbox);=0A=
-                }=0A=
-        }=0A=
-        else {=0A=
-                (void) semod_remove_directory (sandbox);=0A=
-        }=0A=
-        semod_remove_store_lock ();=0A=
-        free (sandbox);=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-/********************* private stuff below *********************/=0A=
-=0A=
-/* Takes a module stored in 'module_data' and parses its headers.=0A=
- * Sets reference variables 'filename' to module's fully qualified=0A=
- * path name into the sandbox, 'module_name' to module's name, and=0A=
- * 'version' to module's version.  The caller is responsible for=0A=
- * free()ing 'filename', 'module_name', and 'version'; they will be=0A=
- * set to NULL upon entering this function.  Returns 0 on success, -1=0A=
- * if out of memory, or -2 if data did not represent a module.=0A=
- */=0A=
-static int parse_module_headers (char *sandbox, char *module_data,=0A=
-                                 size_t data_len, char **module_name,=0A=
-                                 char **version, char **filename,=0A=
-                                 char *error_buf, size_t =
error_buf_size) {=0A=
-        struct policy_file pf;=0A=
-        int file_type;=0A=
-        char *module_path;=0A=
-        *module_name =3D *version =3D *filename =3D NULL;=0A=
-        pf.type =3D PF_USE_MEMORY;=0A=
-        pf.data =3D module_data;=0A=
-        pf.len =3D data_len;=0A=
-        pf.fp =3D NULL;=0A=
-        if (module_data =3D=3D NULL ||=0A=
-            data_len <=3D 0 ||=0A=
-            sepol_module_package_info(&pf, &file_type, module_name,=0A=
-                                      version) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Could not read =
module file.");=0A=
-                return -2;=0A=
-        }=0A=
-        if (file_type !=3D POLICY_MOD) {=0A=
-                write_error (error_buf, error_buf_size, "Read policy =
was not a module.");=0A=
-                return -2;=0A=
-        }=0A=
-        if ((module_path =3D semod_sandbox_modules_path (sandbox)) =
=3D=3D NULL) {=0A=
-                write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                return -1;=0A=
-        }=0A=
-        if (asprintf (filename, "%s/%s.pp", module_path, *module_name) =
=3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                free (module_path);=0A=
-                return -1;=0A=
-        }=0A=
-        free (module_path);=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Takes a base module stored in 'module_data' and parse its headers.=0A=
- * Returns 0 on success, -1 if out of memory, or -2 if data did not=0A=
- * represent a module.=0A=
- */=0A=
-static int parse_base_headers (char *sandbox __attribute__ ((unused)), =0A=
-			       char *module_data,=0A=
-                               size_t data_len,=0A=
-                               char *error_buf, size_t error_buf_size) {=0A=
-        struct policy_file pf;=0A=
-        char *module_name =3D NULL, *version =3D NULL;=0A=
-        int file_type;=0A=
-        pf.type =3D PF_USE_MEMORY;=0A=
-        pf.data =3D module_data;=0A=
-        pf.len =3D data_len;=0A=
-        pf.fp =3D NULL;=0A=
-        if (module_data =3D=3D NULL ||=0A=
-            data_len <=3D 0 ||=0A=
-            sepol_module_package_info(&pf, &file_type, &module_name, =
&version) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Could not read =
base policy file.");=0A=
-                return -2;=0A=
-        }=0A=
-        free (module_name);=0A=
-        free (version);=0A=
-        if (file_type !=3D POLICY_BASE) {=0A=
-                write_error (error_buf, error_buf_size, "Read policy =
was not a base module.");=0A=
-                return -2;=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Writes a block of data to a file.  Returns 0 on success, -1 on=0A=
- * error.=0A=
- */=0A=
-static int write_file (char *filename, char *data, size_t num_bytes) {=0A=
-        int out;=0A=
-        if ((out =3D open (filename, O_WRONLY | O_CREAT, S_IRUSR | =
S_IWUSR)) =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        if (write (out, data, num_bytes) !=3D (ssize_t) num_bytes) {=0A=
-                (void) close (out);=0A=
-                return -1;=0A=
-        }=0A=
-        (void) close (out);=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Write to '*results' a string listing all modules and their=0A=
- * versions.  '*results' will be dyanmically allocated; caller is=0A=
- * responsible for free()ing it afterwards.  A tab character separates=0A=
- * a module name from its version; newlines separate between modules.=0A=
- * The arrays 'names' and 'versions' will be free()ed by this function=0A=
- * regardless if there is an error or not.  Returns 0 on success, or=0A=
- * -1 if out of memory.=0A=
- */=0A=
-static int list_modules_common (char **results,=0A=
-                                char **names, char **versions, int len) =
{=0A=
-        int i, retval =3D 0;=0A=
-        char *t =3D NULL;=0A=
-        size_t result_len =3D 0;=0A=
-        if ((*results =3D strdup ("")) =3D=3D NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        /* collate names and versions into a single string */=0A=
-        for (i =3D 0; i < len; i++) {=0A=
-                if (retval =3D=3D 0 && names[i] !=3D NULL && =
versions[i] !=3D NULL) {=0A=
-                        size_t name_len =3D strlen(names [i]);=0A=
-                        size_t vers_len =3D strlen(versions [i]);=0A=
-                        t =3D realloc(*results, result_len + name_len + =
vers_len + 3);=0A=
-                        if (t =3D=3D NULL) {=0A=
-                                retval =3D -1;=0A=
-                        }=0A=
-                        else {=0A=
-                                *results =3D t;=0A=
-                                (void) memcpy(*results + result_len, =
names [i], name_len);=0A=
-                                (*results)[result_len + name_len] =3D =
'\t';=0A=
-                                result_len +=3D name_len + 1;=0A=
-                                (void) memcpy(*results + result_len, =
versions [i], vers_len);=0A=
-                                (*results)[result_len + vers_len] =3D =
'\n';=0A=
-                                result_len +=3D vers_len + 1;=0A=
-                                (*results)[result_len] =3D '\0';=0A=
-                        }=0A=
-                }=0A=
-                free(names[i]);=0A=
-                free(versions[i]);=0A=
-        }=0A=
-        free(names);=0A=
-        free(versions);=0A=
-        return retval;=0A=
-}=0A=

------=_NextPart_000_00A4_01C5C2D3.38081930--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
