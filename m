Message-Id: <200509262347.j8QNlEYs018823@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage-reorg 2/7 
Date: Mon, 26 Sep 2005 19:47:14 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_009B_01C5C2D3.17D3C650"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_009B_01C5C2D3.17D3C650
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch removes commit_api.c. The bulk of the code in this file is
modified and moved into module_store.c in the next patch set.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_009B_01C5C2D3.17D3C650
Content-Type: application/octet-stream;
	name="2-remove-commit_api.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="2-remove-commit_api.diff"

--- libsemanage/src/commit_api.c	2005-09-19 09:03:15.000000000 -0400=0A=
+++ libsemanage/src/commit_api.c	1969-12-31 19:00:00.000000000 -0500=0A=
@@ -1,756 +0,0 @@=0A=
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
-#include <assert.h>=0A=
-#include <ctype.h>=0A=
-#include <fcntl.h>=0A=
-#include <stdarg.h>=0A=
-#include <stdlib.h>=0A=
-#include <unistd.h>=0A=
-#include <sys/mman.h>=0A=
-#include <sys/stat.h>=0A=
-#include <sys/types.h>=0A=
-#include <sys/wait.h>=0A=
-=0A=
-#include <sepol/sepol.h>=0A=
-#include <sepol/link.h>=0A=
-#include <sepol/expand.h>=0A=
-#include <sepol/module.h>=0A=
-#include <selinux/selinux.h>=0A=
-=0A=
-static int exec_prog (external_prog_t *v, char *new_name, char =
*old_name);=0A=
-static char **split_args (char *arg0, char *arg_string,=0A=
-                          char *new_name, char *old_name);=0A=
-static char *append (char *s, char c);=0A=
-static char *append_str (char *s, char *t);=0A=
-static char **append_arg (char **argv, int *num_args, char *arg);=0A=
-static void free_argv (char **argv);=0A=
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
-/* Links all of the modules within the sandbox into the base module.=0A=
- * '*base' will point to the module package that contains everything=0A=
- * linked together (caller must call semod_module_package_destroy() on=0A=
- * it afterwards).  '*mods' will be a list of module packages and=0A=
- * '*num_modules' will be the number of elements within '*mods'=0A=
- * (caller must destroy each element as well as the pointer itself.)=0A=
- * Both '*base' and '*mods' will be set to NULL upon entering this=0A=
- * function.  If 'error_buf' is not NULL then any error messages=0A=
- * that arise during the link (e.g., a required type not found) will=0A=
- * be written to the buffer; 'error_buf_size' specifies how many bytes=0A=
- * are in the error buffer.  Returns 0 on success, -1 if out of=0A=
- * memory, -2 if base module does not exist or could not be read, -3=0A=
- * if a module does not exist or could not be read, -4 if modules=0A=
- * could not be linked (and error_buf will contain details).=0A=
- */=0A=
-int semod_link_sandbox(char *sandbox,=0A=
-                       sepol_module_package_t **base,=0A=
-                       sepol_module_package_t ***mods, int *num_modules,=0A=
-                       char *error_buf, size_t error_buf_size) {=0A=
-        char *base_filename =3D NULL, **module_filenames =3D NULL;=0A=
-        int retval, i;=0A=
-        *base =3D NULL;=0A=
-        *mods =3D NULL;=0A=
-        *num_modules =3D 0;=0A=
-=0A=
-        /* first make sure that base module is readable */=0A=
-        if ((base_filename =3D semod_sandbox_base_name (sandbox)) =
=3D=3D NULL) {=0A=
-                write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if (access (base_filename, R_OK) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Could not =
access sandbox.");=0A=
-                retval =3D -2;=0A=
-                goto cleanup;=0A=
-        }=0A=
-=0A=
-        /* get list of modules and load them */=0A=
-        switch (semod_get_sandbox_modules_names (sandbox, =
&module_filenames,=0A=
-                                                 num_modules)) {=0A=
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
-        switch (semod_load_module (base_filename, base)) {=0A=
-        case -1: {=0A=
-                write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        case -2: {=0A=
-                write_error (error_buf, error_buf_size, "Could not read =
sandbox base module.");=0A=
-                retval =3D -2;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        }=0A=
-        if (*num_modules =3D=3D 0) {=0A=
-                /* no modules, so skip over the rest of this function */=0A=
-                retval =3D 0;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if ((*mods =3D calloc (*num_modules, sizeof (**mods))) =3D=3D =
NULL) {=0A=
-                write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        for (i =3D 0; i < *num_modules; i++) {=0A=
-                switch (semod_load_module (module_filenames [i], =
(*mods) + i)) {=0A=
-                case -1: {=0A=
-                        write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                        retval =3D -1;=0A=
-                        goto cleanup;=0A=
-                }=0A=
-                case -2: {=0A=
-                        write_error (error_buf, error_buf_size, "Could =
not read sandbox modules.");=0A=
-                        retval =3D -3;=0A=
-                        goto cleanup;=0A=
-                }=0A=
-                }=0A=
-        }=0A=
-        =0A=
-        if (sepol_link_packages(*base, *mods, *num_modules, 0, =
error_buf,=0A=
-                                error_buf_size) !=3D 0) {=0A=
-                retval =3D -4;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        retval =3D 0;=0A=
-        =0A=
- cleanup:=0A=
-        free (base_filename);=0A=
-        for (i =3D 0; module_filenames !=3D NULL && i < *num_modules; =
i++) {=0A=
-                free (module_filenames [i]);=0A=
-        }=0A=
-        free (module_filenames);=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-/* Expands the policy contained within *base and write the final=0A=
- * policy to the sandbox's kernel policy.  If 'error_buf' is=0A=
- * not NULL then any error message that arise during expansion will be=0A=
- * written to the buffer; 'error_buf_size' specifies how many bytes=0A=
- * are in the error buffer.  Returns 0 on success, -1 if out of=0A=
- * memory, -2 if could not expand (and error_buf will contain=0A=
- * details), or -3 if could not write expanded policy.=0A=
- */=0A=
-int semod_expand_sandbox(char *sandbox, sepol_module_package_t *base,=0A=
-                         uint32_t policyvers,=0A=
-                         char *error_buf, size_t error_buf_size) {=0A=
-        policydb_t out;=0A=
-        int retval;=0A=
-        char *kernel_filename =3D NULL;=0A=
-        sidtab_t sidtab;=0A=
-        struct policy_file pf;=0A=
-        FILE *outfile =3D NULL;=0A=
-        if (policydb_init (&out, POLICY_KERN) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        /* activate the global branch before expansion */=0A=
-        base->policy->global->branch_list->enabled =3D 1;=0A=
-        base->policy->global->enabled =3D =
base->policy->global->branch_list;=0A=
-        if (expand_module (base->policy, &out, 0,=0A=
-                           error_buf, error_buf_size) =3D=3D -1) {=0A=
-                retval =3D -2;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if (policydb_load_isids (&out, &sidtab) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Error while =
loading initial SIDs.");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if (policydb_index_others (&out, 0) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if (sepol_set_policyvers (POLICY_KERN, policyvers)) {=0A=
-                write_error (error_buf, error_buf_size, "Incompatible =
policy version %d.", policyvers);=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if ((kernel_filename =3D semod_sandbox_kernel_name (sandbox)) =
=3D=3D NULL) {=0A=
-                write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if ((outfile =3D fopen (kernel_filename, "wb")) =3D=3D NULL) {=0A=
-                write_error (error_buf, error_buf_size, "Could not open =
kernel policy for writing.");=0A=
-                retval =3D -3;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        pf.type =3D PF_USE_STDIO;=0A=
-        pf.fp =3D outfile;=0A=
-        if (policydb_write (&out, &pf) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Error while =
writing kernel policy.");=0A=
-                retval =3D -3;=0A=
-        }=0A=
-        else {=0A=
-                retval =3D 0;=0A=
-        }=0A=
- cleanup:=0A=
-        free (kernel_filename);=0A=
-        if (outfile !=3D NULL) {=0A=
-                (void) fclose (outfile);=0A=
-        }=0A=
-        policydb_destroy (&out);=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-/* Takes the kernel policy in a sandbox, move it to the active=0A=
- * directory, copy it to the binary policy path, then load it.  Upon=0A=
- * error move the active directory back to the sandbox.  This function=0A=
- * should be placed within a mutex lock to ensure that it runs=0A=
- * atomically.  Returns 0 on success, -1 if out of memory, -2 if could=0A=
- * not copy a file or move sandbox, -3 if could not load policy into=0A=
- * kernel.=0A=
- */=0A=
-int semod_install_sandbox (char *sandbox,=0A=
-                           char *error_buf, size_t error_buf_size) {=0A=
-        char *running_policy =3D NULL;=0A=
-        const char *active_kernel =3D semod_active_kernel_name ();=0A=
-        const char *active_kernel_backup =3D =
semod_active_kernel_backup_name ();=0A=
-        const char *running_fc =3D selinux_file_context_path ();=0A=
-        const char *active_fc =3D semod_active_fc_name ();=0A=
-        const char *active_fc_backup =3D semod_active_fc_backup_name ();=0A=
-        int retval;=0A=
-        semod_conf_t *conf =3D semod_get_current_conf ();=0A=
-        if (conf->load_policy =3D=3D NULL) {=0A=
-                write_error (error_buf, error_buf_size, "No load_policy =
program specified in configuration file.");=0A=
-                retval =3D -3;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if (conf->setfiles =3D=3D NULL) {=0A=
-                write_error (error_buf, error_buf_size, "No set_files =
program specified in configuration file.");=0A=
-                retval =3D -3;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if (semod_commit_sandbox (sandbox) !=3D 0) {=0A=
-                write_error (error_buf, error_buf_size, "Could not =
commit sandbox.");=0A=
-                retval =3D -2;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if (asprintf (&running_policy, "%s.%d", =
selinux_binary_policy_path (), security_policyvers ()) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Out of =
memory!");=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        if (semod_copy_file (running_policy, active_kernel_backup) =
=3D=3D -1 ||=0A=
-            semod_copy_file (active_kernel, running_policy) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Could not copy =
policy to sandbox.");=0A=
-                retval =3D -2;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        =0A=
-        if (semod_copy_file (running_fc, active_fc_backup) =3D=3D -1 ||=0A=
-            semod_copy_file (active_fc, running_fc) =3D=3D -1) {=0A=
-                write_error (error_buf, error_buf_size, "Could not copy =
file contexts.");=0A=
-                retval =3D -2;=0A=
-                goto cleanup;=0A=
-        }=0A=
-=0A=
-        if (exec_prog (conf->load_policy, running_policy, "") !=3D 0) {=0A=
-                write_error (error_buf, error_buf_size, "Could not load =
newly expanded policy.");=0A=
-                retval =3D -3;=0A=
-                goto revert;=0A=
-        }=0A=
-        =0A=
-        if (exec_prog (conf->setfiles, running_policy, (char *) =
running_fc) !=3D 0) {=0A=
-                write_error (error_buf, error_buf_size, "Could not =
validate file contexts.");=0A=
-                retval =3D -3;=0A=
-                goto revert;=0A=
-        }=0A=
-        =0A=
-        retval =3D 0;=0A=
-        goto cleanup;=0A=
-=0A=
- revert:=0A=
-        /* revert to backup */=0A=
-        (void) semod_copy_file (active_kernel_backup, running_policy);=0A=
-        (void) semod_copy_file (active_fc_backup, running_fc);=0A=
-        =0A=
- cleanup:=0A=
-        free (running_policy);=0A=
-        if (retval !=3D 0) {=0A=
-                (void) semod_undo_commit_sandbox (sandbox);=0A=
-        }=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-/* Execute the module verification programs for each source module.=0A=
- * Returns 0 if every verifier returned success, -1 if out of memory,=0A=
- * -2 if verifier could not execute, or -3 if one of the verifiers did=0A=
- * not exit successfully.=0A=
- */=0A=
-int semod_verify_modules (char *sandbox, char **module_filenames,=0A=
-                         int num_modules) {=0A=
-        int i, retval;=0A=
-        size_t sandbox_len;=0A=
-        semod_conf_t *conf =3D semod_get_current_conf ();=0A=
-        if (conf->mod_prog =3D=3D NULL) {=0A=
-                return 0;=0A=
-        }=0A=
-        sandbox_len =3D strlen (sandbox);=0A=
-        for (i =3D 0; i < num_modules; i++) {=0A=
-                char *module =3D module_filenames [i];=0A=
-                external_prog_t *e;=0A=
-                char *old_name =3D semod_get_active_filename (module + =
sandbox_len + 1);=0A=
-                for (e =3D conf->mod_prog; e !=3D NULL; e =3D e->next) {=0A=
-                        if ((retval =3D exec_prog (e, module, =
old_name)) !=3D 0) {=0A=
-                                free (old_name);=0A=
-                                if (retval > 0) {=0A=
-                                        return -3;=0A=
-                                }=0A=
-                                else {=0A=
-                                        return retval;=0A=
-                                }=0A=
-                        }=0A=
-                }=0A=
-                free (old_name);=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/* Execute the linker verification programs for the linked (but not=0A=
- * expanded) base.  Returns 0 if every verifier returned success, -1=0A=
- * if out of memory, -2 if verifier could not execute, or -3 if one of=0A=
- * the verifiers did not exit successfully.=0A=
- */=0A=
-int semod_verify_linked (char *sandbox) {=0A=
-        size_t sandbox_len; =0A=
-        external_prog_t *e;=0A=
-        semod_conf_t *conf =3D semod_get_current_conf ();=0A=
-        char *linked_filename =3D NULL, *old_name =3D NULL;=0A=
-        int retval;=0A=
-        if (conf->linked_prog =3D=3D NULL) {=0A=
-                return 0;=0A=
-        }=0A=
-        if ((linked_filename =3D semod_sandbox_linked_name (sandbox)) =
=3D=3D NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        sandbox_len =3D strlen (sandbox);=0A=
-        old_name =3D semod_get_active_filename (linked_filename + =
sandbox_len + 1);=0A=
-        for (e =3D conf->linked_prog; e !=3D NULL; e =3D e->next) {=0A=
-                retval =3D exec_prog (e, linked_filename, old_name);=0A=
-                if (retval =3D=3D -1 || retval =3D=3D -2) {=0A=
-                        goto cleanup;=0A=
-                }=0A=
-                else if (retval > 0) {=0A=
-                        retval =3D -3;=0A=
-                        goto cleanup;=0A=
-                }=0A=
-        }=0A=
-        retval =3D 0;=0A=
- cleanup:=0A=
-        free (linked_filename);=0A=
-        free (old_name);=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-/* Execute each of the kernel verification programs.  Returns 0 if=0A=
- * every verifier returned success, -1 if out of memory, -2 if=0A=
- * verifier could not execute, or -3 if one of the verifiers did not=0A=
- * exit successfully.=0A=
- */=0A=
-int semod_verify_kernel (char *sandbox) {=0A=
-        int retval;=0A=
-        size_t sandbox_len;=0A=
-        char *old_name =3D NULL, *kernel_filename =3D NULL;;=0A=
-        semod_conf_t *conf =3D semod_get_current_conf ();=0A=
-        external_prog_t *e;=0A=
-        if (conf->kernel_prog =3D=3D NULL) {=0A=
-                return 0;=0A=
-        }=0A=
-        sandbox_len =3D strlen (sandbox);=0A=
-        if ((kernel_filename =3D semod_sandbox_kernel_name (sandbox)) =
=3D=3D NULL) {=0A=
-                retval =3D -1;=0A=
-                goto cleanup;=0A=
-        }=0A=
-        old_name =3D semod_get_active_filename (kernel_filename + =
sandbox_len + 1);=0A=
-        for (e =3D conf->kernel_prog; e !=3D NULL; e =3D e->next) {=0A=
-                retval =3D exec_prog (e, kernel_filename, old_name);=0A=
-                if (retval =3D=3D -1 || retval =3D=3D -2) {=0A=
-                        goto cleanup;=0A=
-                }=0A=
-                else if (retval > 0) {=0A=
-                        retval =3D -3;=0A=
-                        goto cleanup;=0A=
-                }=0A=
-        }=0A=
-        retval =3D 0;=0A=
- cleanup:=0A=
-        free (old_name);=0A=
-        free (kernel_filename);=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-/* Loads a module (or a base) from a fully-qualified 'filename' into a=0A=
- * newly allocated semod_module_package_t structure and returns it in=0A=
- * '*package'.  Caller is responsible for destroying it afterwards via=0A=
- * module_package_destroy().  Returns 0 on success, -1 if out of=0A=
- * memory, or -2 if the module could not be loaded.=0A=
- */=0A=
-int semod_load_module(char *filename, sepol_module_package_t **package) =
{=0A=
-	int retval =3D 0;=0A=
-	struct policy_file pf;=0A=
-=0A=
-	if ((*package =3D (sepol_module_package_t*) malloc(sizeof(**package))) =
=3D=3D NULL) {=0A=
-                return -1;=0A=
-	}=0A=
-	if (sepol_module_package_init(*package) =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-=0A=
-	if ((pf.fp =3D fopen (filename, "rb")) =3D=3D NULL) {=0A=
-                return -2;=0A=
-	}=0A=
-	pf.type =3D PF_USE_STDIO;=0A=
-	if (sepol_module_package_read(*package, &pf, 0) =3D=3D -1) {=0A=
-                retval =3D -2;=0A=
-        }=0A=
-	(void) fclose (pf.fp);=0A=
-	if (retval =3D=3D 0 &&=0A=
-            (*package)->policy->policy_type =3D=3D POLICY_MOD) {=0A=
-		if (policydb_index_classes ((*package)->policy) ||=0A=
-                    policydb_index_others ((*package)->policy, 0)) {=0A=
-                        retval =3D -2;=0A=
-                }=0A=
-	}=0A=
-        return retval;=0A=
-}=0A=
-=0A=
-/* Writes a module (or a base) to the file given by a fully-qualified=0A=
- * 'filename'.  Returns 0 on success, -1 if file could not be written.=0A=
- */=0A=
-int semod_write_module(char *filename, sepol_module_package_t *package,=0A=
-                       uint32_t policy_type, int policyvers) {=0A=
-        struct policy_file pf;=0A=
-        FILE *outfile;=0A=
-        int retval;=0A=
-        if (sepol_set_policyvers (policy_type, policyvers) !=3D 0 ||=0A=
-            (outfile =3D fopen (filename, "wb")) =3D=3D NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        pf.type =3D PF_USE_STDIO;=0A=
-        pf.fp =3D outfile;=0A=
-        retval =3D sepol_module_package_write(package, &pf);=0A=
-        fclose(outfile);=0A=
-        if (retval =3D=3D -1) {=0A=
-                return -1;=0A=
-        }=0A=
-        return 0;=0A=
-}=0A=
-=0A=
-/********************* private stuff below *********************/=0A=
-=0A=
-/* Take the arguments given in v->args and expand any $ macros within.=0A=
- * Split the arguments into different strings (argv).  Next fork and=0A=
- * execute the process.  BE SURE THAT ALL FILE DESCRIPTORS ARE SET TO=0A=
- * CLOSE-ON-EXEC.  Take the return value of the child process and=0A=
- * return it, -1 if out of memory, -2 if could not fork/exec.=0A=
- */=0A=
-static int exec_prog (external_prog_t *e, char *new_name, char =
*old_name) {=0A=
-        char *arg0, **argv;=0A=
-        pid_t forkval;=0A=
-=0A=
-        if ((arg0 =3D strdup (e->path)) =3D=3D NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        if ((argv =3D split_args (arg0, e->args, new_name, old_name)) =
=3D=3D NULL) {=0A=
-                return -1;=0A=
-        }=0A=
-        =0A=
-        /* no need to use pthread_atfork() -- child will not be using=0A=
-         * any mutexes. */=0A=
-        if ((forkval =3D fork ()) =3D=3D -1) {=0A=
-                return -2;=0A=
-        }=0A=
-        else if (forkval =3D=3D 0) {=0A=
-                /* child process.  file descriptors will be closed=0A=
-                 * because they were set as close-on-exec. */=0A=
-                (void) execve (e->path, argv, NULL);=0A=
-                exit (EXIT_FAILURE);             /* if execve() failed =
*/=0A=
-        }=0A=
-        else {=0A=
-                /* parent process.  wait for child to finish */=0A=
-                int status;=0A=
-                free_argv (argv);=0A=
-                if (waitpid (forkval, &status, 0) =3D=3D -1 ||=0A=
-                    !WIFEXITED (status)) {=0A=
-                        return -2;=0A=
-                }=0A=
-                return WEXITSTATUS (status);=0A=
-        }=0A=
-        assert(0);=0A=
-        return 0;        /* never reached, but here to satisfy lint */=0A=
-}=0A=
-=0A=
-/* Take an argument string and split and place into an argument=0A=
- * vector.  Respect normal quoting, double-quoting, and backslash=0A=
- * conventions.  Perform substitutions on $@ and $< symbols.  Returns=0A=
- * a NULL-terminated argument vector; caller is responsible for=0A=
- * free()ing the vector and its elements. */=0A=
-static char **split_args (char *arg0, char *arg_string,=0A=
-                          char *new_name, char *old_name) {=0A=
-        char **argv =3D NULL, **tv, *s, *arg =3D NULL, *targ;=0A=
-        int num_args =3D 0, in_quote =3D 0, in_dquote =3D 0;=0A=
-=0A=
-        if ((tv =3D append_arg (argv, &num_args, arg0)) =3D=3D NULL) {=0A=
-                goto cleanup;=0A=
-        }=0A=
-        else {=0A=
-                argv =3D tv;=0A=
-        }=0A=
-        s =3D arg_string;=0A=
-        /* parse the argument string one character at a time,=0A=
-         * repsecting quotes and other special characters */=0A=
-        while (s !=3D NULL && *s !=3D '\0') {=0A=
-                switch (*s) {=0A=
-                case '\\': {=0A=
-                        if (*(s + 1) =3D=3D '\0') {=0A=
-                                if ((targ =3D append (arg, '\\')) =
=3D=3D NULL) {=0A=
-                                        goto cleanup;=0A=
-                                }=0A=
-                                else {=0A=
-                                        arg =3D targ;=0A=
-                                }=0A=
-                        }=0A=
-                        else {=0A=
-                                if ((targ =3D append (arg, *(s + 1))) =
=3D=3D NULL) {=0A=
-                                        goto cleanup;=0A=
-                                }=0A=
-                                else {=0A=
-                                        arg =3D targ;=0A=
-                                }=0A=
-                                s++;=0A=
-                        }=0A=
-                        break;=0A=
-                }=0A=
-                case '\'': {=0A=
-                        if (in_dquote) {=0A=
-                                if ((targ =3D append (arg, *s)) =3D=3D =
NULL) {=0A=
-                                        goto cleanup;=0A=
-                                }=0A=
-                                else {=0A=
-                                        arg =3D targ;=0A=
-                                }=0A=
-                        }=0A=
-                        else if (in_quote) {=0A=
-                                in_quote =3D 0;=0A=
-                        }=0A=
-                        else {=0A=
-                                in_quote =3D 1;=0A=
-                                if ((targ =3D append (arg, '\0')) =
=3D=3D NULL) {=0A=
-                                        goto cleanup;=0A=
-                                }=0A=
-                                else {=0A=
-                                        arg =3D targ;=0A=
-                                }=0A=
-                        }=0A=
-                        break;=0A=
-                }=0A=
-                case '\"': {=0A=
-                        if (in_quote) {=0A=
-                                if ((targ =3D append (arg, *s)) =3D=3D =
NULL) {=0A=
-                                        goto cleanup;=0A=
-                                }=0A=
-                                else {=0A=
-                                        arg =3D targ;=0A=
-                                }=0A=
-                        }=0A=
-                        else if (in_dquote) {=0A=
-                                in_dquote =3D 0;=0A=
-                        }=0A=
-                        else {=0A=
-                                in_dquote =3D 1;=0A=
-                                if ((targ =3D append (arg, '\0')) =
=3D=3D NULL) {=0A=
-                                        goto cleanup;=0A=
-                                }=0A=
-                                else {=0A=
-                                        arg =3D targ;=0A=
-                                }=0A=
-                        }=0A=
-                        break;=0A=
-                }=0A=
-                case '$': {=0A=
-                        switch (*(s + 1)) {=0A=
-                        case '@': {=0A=
-                                if ((targ =3D append_str (arg, =
new_name)) =3D=3D NULL) {=0A=
-                                        goto cleanup;=0A=
-                                }=0A=
-                                else {=0A=
-                                        arg =3D targ;=0A=
-                                }=0A=
-                                s++;=0A=
-                                break;=0A=
-                        }=0A=
-                        case '<': {=0A=
-                                if ((targ =3D append_str (arg, =
old_name)) =3D=3D NULL) {=0A=
-                                        goto cleanup;=0A=
-                                }=0A=
-                                else {=0A=
-                                        arg =3D targ;=0A=
-                                }=0A=
-                                s++;=0A=
-                                break;=0A=
-                        }=0A=
-                        default: {=0A=
-                                if ((targ =3D append (arg, *s)) =3D=3D =
NULL) {=0A=
-                                        goto cleanup;=0A=
-                                }=0A=
-                                else {=0A=
-                                        arg =3D targ;=0A=
-                                }=0A=
-                        }=0A=
-                        }=0A=
-                        break;=0A=
-                }=0A=
-                default: {=0A=
-                        if (isspace (*s) && !in_quote && !in_dquote) {=0A=
-                                if (arg !=3D NULL) {=0A=
-                                        if ((tv =3D append_arg (argv, =
&num_args, arg)) =3D=3D NULL) {=0A=
-                                                goto cleanup;=0A=
-                                        }=0A=
-                                        else {=0A=
-                                                argv =3D tv;=0A=
-                                        }=0A=
-                                        arg =3D NULL;=0A=
-                                }=0A=
-                        }=0A=
-                        else {=0A=
-                                if ((targ =3D append (arg, *s)) =3D=3D =
NULL) {=0A=
-                                        goto cleanup;=0A=
-                                }=0A=
-                                else {=0A=
-                                        arg =3D targ;=0A=
-                                }=0A=
-                        }=0A=
-                }=0A=
-                }=0A=
-                s++;=0A=
-        }=0A=
-        if (arg !=3D NULL) {=0A=
-                if ((tv =3D append_arg (argv, &num_args, arg)) =3D=3D =
NULL) {=0A=
-                        goto cleanup;=0A=
-                }=0A=
-                else {=0A=
-                        argv =3D tv;=0A=
-                }=0A=
-                arg =3D NULL;=0A=
-        }=0A=
-        /* explicitly add a NULL at the end */=0A=
-        if ((tv =3D append_arg (argv, &num_args, NULL)) !=3D NULL) {=0A=
-                return tv;=0A=
-        }=0A=
- cleanup:=0A=
-        free_argv (argv);=0A=
-        free (arg);=0A=
-        return NULL;=0A=
-}=0A=
-=0A=
-/* Appends a single character to a string.  Returns a pointer to the=0A=
- * realloc()ated string.  If out of memory return NULL; original=0A=
- * string will remain untouched.=0A=
- */=0A=
-static char *append (char *s, char c) {=0A=
-        size_t len =3D (s =3D=3D NULL ? 0 : strlen (s));=0A=
-        char *new_s =3D realloc (s, len + 2);=0A=
-        if (new_s =3D=3D NULL) {=0A=
-                return NULL;=0A=
-        }=0A=
-        s =3D new_s;=0A=
-        s [len] =3D c;=0A=
-        s [len + 1] =3D '\0';=0A=
-        return s;=0A=
-}=0A=
-=0A=
-/* Append string 't' to string 's', realloc()ating 's' as needed.  't'=0A=
- * may be safely free()d afterwards.  Returns a pointer to the=0A=
- * realloc()ated 's'.  If out of memory return NULL; original strings=0A=
- * will remain untouched.=0A=
- */=0A=
-static char *append_str (char *s, char *t) {=0A=
-        size_t s_len =3D (s =3D=3D NULL ? 0 : strlen (s));=0A=
-        size_t t_len =3D (t =3D=3D NULL ? 0 : strlen (t));=0A=
-        char *new_s =3D realloc (s, s_len + t_len + 1);=0A=
-        if (new_s =3D=3D NULL) {=0A=
-                return NULL;=0A=
-        }=0A=
-        s =3D new_s;=0A=
-        (void) memcpy (s + s_len, t, t_len);=0A=
-        s [s_len + t_len] =3D '\0';=0A=
-        return s;=0A=
-}=0A=
-=0A=
-/* Append an argument string to an argument vector, returning a=0A=
- * pointer to the realloc()ated argument vector.  Also increments=0A=
- * 'num_args'.  DO NOT FREE arg afterwards if function is successful.=0A=
- * If out of memory return NULL; original strings will remain=0A=
- * untouched.=0A=
- */=0A=
-static char **append_arg (char **argv, int *num_args, char *arg) {=0A=
-        char **a;=0A=
-        if ((a =3D realloc (argv, sizeof (*argv) * (*num_args + 1))) =
=3D=3D NULL) {=0A=
-                return NULL;=0A=
-        }=0A=
-        argv =3D a;=0A=
-        argv [*num_args] =3D arg;=0A=
-        (*num_args)++;=0A=
-        return argv;=0A=
-}=0A=
-=0A=
-=0A=
-/* free()s all strings within a null-terminated argument vector, as=0A=
- * well as the pointer itself. */=0A=
-static void free_argv (char **argv) {=0A=
-        int i;=0A=
-        for (i =3D 0; argv !=3D NULL && argv [i] !=3D NULL; i++) {=0A=
-                free (argv [i]);=0A=
-        }=0A=
-        free (argv);=0A=
-}=0A=

------=_NextPart_000_009B_01C5C2D3.17D3C650--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
