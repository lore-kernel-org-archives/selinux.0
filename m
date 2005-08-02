Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j72FOCgA027398
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2005 11:24:14 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j72FGecP022241
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2005 15:16:40 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j72FHrG6005812
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2005 11:17:53 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j72FHrQw005811
	for selinux@tycho.nsa.gov; Tue, 2 Aug 2005 11:17:53 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j72F7fgA027148
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2005 11:07:41 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j72F04cP019135
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2005 15:00:04 GMT
Received: from [10.1.13.10] ([10.1.13.10])
	by gotham.columbia.tresys.com (8.12.8/8.12.8) with ESMTP id j72F0ssq010134
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2005 11:00:54 -0400
Subject: [PATCH] move module read/write code into libsepol
From: Jason Tang <jtang@tresys.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-Xa/ZVus8e8LOljfg05JF"
Date: Tue, 02 Aug 2005 11:00:54 -0400
Message-Id: <1122994854.5842.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Xa/ZVus8e8LOljfg05JF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

With the newly agreed upon use of libsepol as "internal representation
of data" it has become apparant that module read/write code really
belongs in libsepol and not in libsemanage.  The following patch moves
that logic into a new file libsepol/module.c.  It also corrects an
outstanding error, by adding checkpolicy/test and
policycoreutils/semodule_package into their parents' Makefile.

-- 
Jason Tang / jtang@tresys.com

--=-Xa/ZVus8e8LOljfg05JF
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN nsa/selinux-usr/checkpolicy/Makefile nsa-selinux-usr/checkpolicy/Makefile
--- nsa/selinux-usr/checkpolicy/Makefile	2005-07-18 15:45:46.000000000 -0400
+++ nsa-selinux-usr/checkpolicy/Makefile	2005-08-01 15:45:44.000000000 -0400
@@ -19,6 +19,7 @@ CHECKMODOBJS = $(CHECKOBJS) checkmodule.
 LDLIBS=$(LIBDIR)/libsepol.a -lfl
 
 all:  $(TARGETS)
+	$(MAKE) -C test
 
 checkpolicy: $(CHECKPOLOBJS)
 
@@ -50,5 +51,6 @@ relabel: install
 	/sbin/restorecon $(BINDIR)/checkmodule
 
 clean:
-	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c 
+	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c
+	$(MAKE) -C test clean
 
diff -purN nsa/selinux-usr/checkpolicy/test/dismod.c nsa-selinux-usr/checkpolicy/test/dismod.c
--- nsa/selinux-usr/checkpolicy/test/dismod.c	2005-07-06 13:46:24.000000000 -0400
+++ nsa-selinux-usr/checkpolicy/test/dismod.c	2005-08-01 15:40:15.000000000 -0400
@@ -32,7 +32,7 @@
 #include <sepol/conditional.h>
 #include <sepol/flask.h>
 #include <sepol/link.h>
-#include <semod/module.h>
+#include <sepol/module.h>
 
 #include <byteswap.h>
 #include <endian.h>
@@ -691,11 +691,11 @@ static int read_policy(char *filename, p
                 exit(1);
         }
         rewind(in_fp);
-        if (le32_to_cpu(buf[0]) == SEMOD_MODULE_PACKAGE_MAGIC) {
-                semod_module_package_t package;
+        if (le32_to_cpu(buf[0]) == SEPOL_MODULE_PACKAGE_MAGIC) {
+                sepol_module_package_t package;
                 package.policy = policy;
                 package.file_contexts = NULL;
-                retval = semod_module_package_read(&package, &f, 1);
+                retval = sepol_module_package_read(&package, &f, 1);
                 free(package.file_contexts);
         }
         else {
diff -purN nsa/selinux-usr/checkpolicy/test/Makefile nsa-selinux-usr/checkpolicy/test/Makefile
--- nsa/selinux-usr/checkpolicy/test/Makefile	2005-07-18 15:45:46.000000000 -0400
+++ nsa-selinux-usr/checkpolicy/test/Makefile	2005-08-01 15:41:19.000000000 -0400
@@ -9,7 +9,7 @@ INCLUDEDIR ?= $(PREFIX)/include
 CFLAGS ?= -g -Wall -O2 -pipe
 override CFLAGS += -I$(INCLUDEDIR)
 
-LDLIBS=-lfl -lsemod -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
+LDLIBS=-lfl -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
 
 all: dispol dismod
 
diff -purN nsa/selinux-usr/libsemanage/include/semanage/commit_api.h nsa-selinux-usr/libsemanage/include/semanage/commit_api.h
--- nsa/selinux-usr/libsemanage/include/semanage/commit_api.h	2005-07-27 13:46:52.000000000 -0400
+++ nsa-selinux-usr/libsemanage/include/semanage/commit_api.h	2005-08-01 16:05:36.000000000 -0400
@@ -20,15 +20,14 @@
 #ifndef SEMOD_COMMIT_API_H
 #define SEMOD_COMMIT_API_H
 
-#include "semanage/module.h"
-
+#include <sepol/module.h>
 #include <stdlib.h>
 
 int semod_link_sandbox(char *sandbox,
-                       semod_module_package_t **base,
-                       semod_module_package_t ***mods, int *num_modules,
+                       sepol_module_package_t **base,
+                       sepol_module_package_t ***mods, int *num_modules,
                        char *error_buf, size_t error_buf_size);
-int semod_expand_sandbox(char *sandbox, semod_module_package_t *base,
+int semod_expand_sandbox(char *sandbox, sepol_module_package_t *base,
                          uint32_t policyvers,
                          char *error_buf, size_t error_buf_size);
 int semod_install_sandbox (char *sandbox,
@@ -39,8 +38,8 @@ int semod_verify_modules(char *sandbox, 
 int semod_verify_linked(char *sandbox);
 int semod_verify_kernel(char *sandbox);
 
-int semod_load_module (char *filename, semod_module_package_t **package);
-int semod_write_module (char *filename, semod_module_package_t *package,
-                        uint32_t policy_type, int policyvers);
+int semod_load_module(char *filename, sepol_module_package_t **package);
+int semod_write_module(char *filename, sepol_module_package_t *package,
+                       uint32_t policy_type, int policyvers);
 
 #endif
diff -purN nsa/selinux-usr/libsemanage/include/semanage/module.h nsa-selinux-usr/libsemanage/include/semanage/module.h
--- nsa/selinux-usr/libsemanage/include/semanage/module.h	2005-07-27 13:46:52.000000000 -0400
+++ nsa-selinux-usr/libsemanage/include/semanage/module.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,50 +0,0 @@
-/* Author: Karl MacMillan <kmacmillan@tresys.com>
- *
- * Copyright (C) 2004-2005 Tresys Technology, LLC
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
- 
-#ifndef _SEMOD_MODULE_H_
-#define _SEMOD_MODULE_H_
-
-#include <stdlib.h>
-
-#include <sepol/policydb.h>
-#include <sepol/conditional.h>
-#include <selinux/avc.h>
-
-#define SEMOD_MODULE_PACKAGE_MAGIC 0xf97cff8e
-
-typedef struct semod_module_package {
-	policydb_t	*policy;
-	char 		*file_contexts;
-	uint32_t	file_contexts_len;
-} semod_module_package_t;
-
- /* link a base module and an array of modules - base module is modified and will
- * contain the base policy and modules
- */ 
-extern int semod_module_package_init(semod_module_package_t *p);
-extern void semod_module_package_destroy(semod_module_package_t *p);
-extern int semod_link_packages(semod_module_package_t *base,
-                               semod_module_package_t **modules, int num_modules,
-                               int verbose, char *error_buf, size_t error_buf_size);
-extern int semod_module_package_read(semod_module_package_t *mod, struct policy_file *file, int verbose);
-extern int semod_module_package_info(struct policy_file *file, int *type, char **name, char **version);
-extern int semod_module_package_write(semod_module_package_t *p, struct policy_file *file);
-extern int semod_module_package_create(struct policy_file *policy, struct policy_file *fc, struct policy_file *file);
-
-#endif
diff -purN nsa/selinux-usr/libsemanage/src/commit_api.c nsa-selinux-usr/libsemanage/src/commit_api.c
--- nsa/selinux-usr/libsemanage/src/commit_api.c	2005-07-27 13:46:52.000000000 -0400
+++ nsa-selinux-usr/libsemanage/src/commit_api.c	2005-08-01 15:26:20.000000000 -0400
@@ -22,7 +22,6 @@
 #endif
 
 #include "semanage/commit_api.h"
-#include "semanage/module.h"
 #include "semanage/module_store.h"
 #include "semanage/semod_conf.h"
 
@@ -40,6 +39,7 @@
 #include <sepol/sepol.h>
 #include <sepol/link.h>
 #include <sepol/expand.h>
+#include <sepol/module.h>
 #include <selinux/selinux.h>
 
 static int exec_prog (external_prog_t *v, char *new_name, char *old_name);
@@ -78,8 +78,8 @@ static void write_error(char *error_buf,
  * could not be linked (and error_buf will contain details).
  */
 int semod_link_sandbox(char *sandbox,
-                       semod_module_package_t **base,
-                       semod_module_package_t ***mods, int *num_modules,
+                       sepol_module_package_t **base,
+                       sepol_module_package_t ***mods, int *num_modules,
                        char *error_buf, size_t error_buf_size) {
         char *base_filename = NULL, **module_filenames = NULL;
         int retval, i;
@@ -150,8 +150,8 @@ int semod_link_sandbox(char *sandbox,
                 }
         }
         
-        if (semod_link_packages (*base, *mods, *num_modules, 0, error_buf,
-                                 error_buf_size) != 0) {
+        if (sepol_link_packages(*base, *mods, *num_modules, 0, error_buf,
+                                error_buf_size) != 0) {
                 retval = -4;
                 goto cleanup;
         }
@@ -174,7 +174,7 @@ int semod_link_sandbox(char *sandbox,
  * memory, -2 if could not expand (and error_buf will contain
  * details), or -3 if could not write expanded policy.
  */
-int semod_expand_sandbox(char *sandbox, semod_module_package_t *base,
+int semod_expand_sandbox(char *sandbox, sepol_module_package_t *base,
                          uint32_t policyvers,
                          char *error_buf, size_t error_buf_size) {
         policydb_t out;
@@ -432,14 +432,14 @@ int semod_verify_kernel (char *sandbox) 
  * module_package_destroy().  Returns 0 on success, -1 if out of
  * memory, or -2 if the module could not be loaded.
  */
-int semod_load_module (char *filename, semod_module_package_t **package) {
+int semod_load_module(char *filename, sepol_module_package_t **package) {
 	int retval = 0;
 	struct policy_file pf;
 
-	if ((*package = (semod_module_package_t*) malloc (sizeof (**package))) == NULL) {
+	if ((*package = (sepol_module_package_t*) malloc(sizeof(**package))) == NULL) {
                 return -1;
 	}
-	if (semod_module_package_init (*package) == -1) {
+	if (sepol_module_package_init(*package) == -1) {
                 return -1;
         }
 
@@ -447,7 +447,7 @@ int semod_load_module (char *filename, s
                 return -2;
 	}
 	pf.type = PF_USE_STDIO;
-	if (semod_module_package_read (*package, &pf, 0) == -1) {
+	if (sepol_module_package_read(*package, &pf, 0) == -1) {
                 retval = -2;
         }
 	(void) fclose (pf.fp);
@@ -464,8 +464,8 @@ int semod_load_module (char *filename, s
 /* Writes a module (or a base) to the file given by a fully-qualified
  * 'filename'.  Returns 0 on success, -1 if file could not be written.
  */
-int semod_write_module (char *filename, semod_module_package_t *package,
-                        uint32_t policy_type, int policyvers) {
+int semod_write_module(char *filename, sepol_module_package_t *package,
+                       uint32_t policy_type, int policyvers) {
         struct policy_file pf;
         FILE *outfile;
         int retval;
@@ -475,8 +475,8 @@ int semod_write_module (char *filename, 
         }
         pf.type = PF_USE_STDIO;
         pf.fp = outfile;
-        retval = semod_module_package_write (package, &pf);
-        (void) fclose (outfile);
+        retval = sepol_module_package_write(package, &pf);
+        fclose(outfile);
         if (retval == -1) {
                 return -1;
         }
diff -purN nsa/selinux-usr/libsemanage/src/module.c nsa-selinux-usr/libsemanage/src/module.c
--- nsa/selinux-usr/libsemanage/src/module.c	2005-07-27 13:46:52.000000000 -0400
+++ nsa-selinux-usr/libsemanage/src/module.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,355 +0,0 @@
-/* Author: Karl MacMillan <kmacmillan@tresys.com>
- *         Jason Tang     <jtang@tresys.com>
- *
- * Copyright (C) 2004-2005 Tresys Technology, LLC
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <sepol/link.h>
-#include <semanage/module.h>
-#include "private.h"
-
-#include <stdio.h>
-#include <stdlib.h>
-
-int semod_module_package_init(semod_module_package_t *p)
-{
-	memset(p, 0, sizeof(semod_module_package_t));
-	p->policy = (policydb_t*)calloc(1, sizeof(policydb_t));
-	if (!p->policy)
-		return -1;
-	return 0;
-}
-
-/* Deallocates all memory associated with a module package, including
- * the pointer itself.  Does nothing if p is NULL.
- */
-void semod_module_package_destroy(semod_module_package_t *p) {
-        if (p == NULL) {
-                return;
-        }
-        policydb_destroy(p->policy);
-        free(p->file_contexts);
-        free(p);
-}
-
-/* Append each of the file contexts from each module to the base
- * policy's file context.  'base_context' will be reallocated to a
- * larger size (and thus it is an in/out reference
- * variable). 'base_fc_len' is the length of base's file context; it
- * too is a reference variable.  Return 0 on success, -1 if out of
- * memory. */
-static int link_file_contexts(semod_module_package_t *base,
-                              semod_module_package_t **modules, int num_modules) {
-        size_t fc_len;
-        int i;
-        char *s;
-
-        fc_len = base->file_contexts_len;
-        for (i = 0; i < num_modules; i++) {
-        	fc_len += modules[i]->file_contexts_len;
-        }
-
-        if ((s = (char*)realloc(base->file_contexts, fc_len)) == NULL) {
-                return -1;
-        }
-        base->file_contexts = s;
-        for (i = 0; i < num_modules; i++) {
-                memcpy(base->file_contexts + base->file_contexts_len,
-                       modules[i]->file_contexts,
-                       modules[i]->file_contexts_len);
-                base->file_contexts_len += modules[i]->file_contexts_len;
-        }
-        return 0;
-}
-
-
-/* Links the module packages into the base.  Returns 0 on success, -1
- * if a requirement was not met, or -2 for all other errors. */
-int semod_link_packages(semod_module_package_t *base,
-                        semod_module_package_t **modules, int num_modules,
-                        int verbose, char *error_buf, size_t error_buf_size) {
-        policydb_t **mod_pols = NULL;
-        int i, retval;
-        if ((mod_pols = calloc(num_modules, sizeof(*mod_pols))) == NULL) {
-                if (error_buf != NULL) {
-                        snprintf(error_buf, error_buf_size, "Out of memory!");
-                }
-                return -2;
-        }
-        for (i = 0; i < num_modules; i++) {
-                mod_pols[i] = modules[i]->policy;
-        }
-
-        retval = link_modules(base->policy, mod_pols, num_modules,
-                              verbose, error_buf, error_buf_size);
-        free(mod_pols);
-        if (retval == -3) {
-                return -1;
-        }
-        else if (retval < 0) {
-                return -2;
-        }
-
-        if (link_file_contexts(base, modules, num_modules) == -1) {
-                if (error_buf != NULL) {
-                        snprintf(error_buf, error_buf_size, "Out of memory!");
-                }
-                return -2;
-        }
-        return 0;
-}
-
-
-/* buf must be large enough - no checks are performed */
-#define _read_helper_bufsize 512
-static int read_helper(char *buf, struct policy_file *file, uint32_t bytes)
-{
-	uint32_t offset, nel, read_len;
-	void *tmp;
-	
-	offset = 0;
-	nel = bytes;
-	
-	while (nel) {
-		if (nel < _read_helper_bufsize)
-			read_len = nel;
-		else
-			read_len = _read_helper_bufsize;
-		tmp = next_entry(file, read_len);
-		if (!tmp)
-			return -1;
-		memcpy(&buf[offset], tmp, read_len);
-		offset += read_len;
-		nel -= read_len;
-	}
-	return 0;
-}
- 
-int semod_module_package_read(semod_module_package_t *mod, struct policy_file *file, int verbose)
-{
-	uint32_t *buf;
-	
-	buf = next_entry(file, sizeof(uint32_t) * 2);
-	if (!buf)
-		return -1;
-	if (le32_to_cpu(buf[0]) != SEMOD_MODULE_PACKAGE_MAGIC) {
-		return -1;	
-	}
-	mod->file_contexts_len = le32_to_cpu(buf[1]);
-	
-	if (mod->file_contexts_len) {		
-		mod->file_contexts = (char *)malloc(mod->file_contexts_len);
-		if (!mod->file_contexts) {
-			return -1;	
-		}
-		if (read_helper(mod->file_contexts, file, mod->file_contexts_len))
-			return -1;
-	}
-	
-	return policydb_read(mod->policy, file, verbose);	
-}
-
-int semod_module_package_info(struct policy_file *file, int *type, char **name, char **version)
-{
-	uint32_t *buf, *buf2, len;
-	
-	buf = next_entry(file, sizeof(uint32_t) * 2);
-	if (!buf)
-		return -1;
-	if (le32_to_cpu(buf[0]) != SEMOD_MODULE_PACKAGE_MAGIC) {
-		return -1;	
-	}
-	
-	/* skip file contexts */
-	len = le32_to_cpu(buf[1]);
-	if (len) {
-		buf2 = malloc(len);
-		if (!buf2) {
-			return -1;	
-		}
-		if (read_helper((char*)buf2, file, len))
-			return -1;
-		free(buf2);
-	}
-	
-	buf = next_entry(file, sizeof(uint32_t)* 2);
-	if (!buf) {
-		return -1;
-	}
-        if (le32_to_cpu(buf[0]) != POLICYDB_MOD_MAGIC) {
-                return -1;
-        }
-
-	len = le32_to_cpu(buf[1]);
-	if (len != strlen(POLICYDB_MOD_STRING)) {
-		return -1;
-	}
-	
-	/* skip id */
-	buf = next_entry(file, len);
-	if (!buf) {
-		return -1;
-	}
-	
-	buf = next_entry(file, sizeof(uint32_t)* 5);
-	if (!buf)
-		return -1;
-	
-	*type = le32_to_cpu(buf[0]);
-	/* if base - we're done */
-	if (*type == POLICY_BASE) {
-		*name = NULL;
-		*version = NULL;
-		return 0;
-	} else if (*type != POLICY_MOD) {
-		return -1;	
-	}
-	
-	/* read the name and version */
-	buf = next_entry(file, sizeof(uint32_t));
-        if (!buf)
-                return -1;
-        len = le32_to_cpu(buf[0]);
-        buf = next_entry(file, len);
-        if (!buf)
-                return -1;
-        *name = malloc(len + 1);
-        if (!*name) {
-                return -1;
-        }
-        memcpy(*name, buf, len);
-        (*name)[len] = '\0';
-        buf = next_entry(file, sizeof(uint32_t));
-        if (!buf)
-                return -1;
-        len = le32_to_cpu(buf[0]);
-        buf = next_entry(file, len);
-        if (!buf)
-                return -1;
-        *version = malloc(len + 1);
-        if (!*version)
-                return -1;
-        memcpy(*version, buf, len);
-        (*version)[len] = '\0';
-	
-	return 0;
-}
-
-#define BUF_SIZE 2048
-static int semod_module_write_helper(struct policy_file *in, struct policy_file *out, int write_len)
-{
-	uint32_t buf[1], *buf2, len, len2;
-	long start, end;
-	
-	if (in->type == PF_USE_MEMORY) {
-		len = in->len;
-	} else {
-		/* get the length - this doesn't assume that the stream
-		 * was at the beginning */
-		if ((start = ftell(in->fp)) == -1)
-			return -1;
-		if (fseek(in->fp, 0, SEEK_END))
-			return -1;
-		if ((end = ftell(in->fp)) == -1)
-			return -1;
-		len = end - start;
-		if (fseek(in->fp, start, SEEK_SET))
-			return -1;
-	}
-	
-	if (write_len) {
-		buf[0] = cpu_to_le32(len);	
-		if (put_entry(buf, sizeof(uint32_t), 1, out) != 1)
-			return -1;
-	}
-	while (len) {
-		if (len > BUF_SIZE)
-			len2 = BUF_SIZE;
-		else
-			len2 = len;
-		buf2 = next_entry(in, len2);
-		if (!buf2) {
-			return -1;
-		}
-		if (put_entry(buf2, 1, len2, out) != len2) {
-			perror("error writing file");
-			return -1;
-		}
-		len -= len2;
-	}
-	return 0;
-}
-
-int semod_module_package_write(semod_module_package_t *p, struct policy_file *file)
-{
-	uint32_t buf[1], len, len2, index;
-		
-	buf[0] = cpu_to_le32(SEMOD_MODULE_PACKAGE_MAGIC);
-	if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
-		return -1;
-		
-	buf[0] = cpu_to_le32(p->file_contexts_len);
-	if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
-		return -1;
-		
-	len = p->file_contexts_len;
-	index = 0;
-	while (len) {
-		if (len > BUF_SIZE)
-			len2 = BUF_SIZE;
-		else
-			len2 = len;
-
-		if (put_entry(&p->file_contexts[index], 1, len2, file) != len2) {
-			perror("error writing file");
-			return -1;
-		}
-		len -= len2;
-		index += len2;
-	}
-	
-	return policydb_write(p->policy, file);
-}
-
-/* file must use stdio */
-int semod_module_package_create(struct policy_file *policy, struct policy_file *fc, struct policy_file *file)
-{
-	uint32_t buf[BUF_SIZE];
-
-	
-	if (!file->type == PF_USE_STDIO)
-		return -1;
-	
-	buf[0] = cpu_to_le32(SEMOD_MODULE_PACKAGE_MAGIC);
-	if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
-		return -1;
-		
-	if (!fc) {
-		buf[0] = cpu_to_le32(0);
-		if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
-			return -1;
-	} else {	
-		if (semod_module_write_helper(fc, file, 1)) {
-			return -1;
-		}
-	}
-	if (semod_module_write_helper(policy, file, 0)) {
-		return -1;	
-	}
-	
-	return 0;
-}
diff -purN nsa/selinux-usr/libsemanage/src/module_direct_api.c nsa-selinux-usr/libsemanage/src/module_direct_api.c
--- nsa/selinux-usr/libsemanage/src/module_direct_api.c	2005-07-27 13:46:52.000000000 -0400
+++ nsa-selinux-usr/libsemanage/src/module_direct_api.c	2005-08-01 16:06:17.000000000 -0400
@@ -22,10 +22,11 @@
 #endif
 
 #include "semanage/commit_api.h"
-#include "semanage/module.h"
 #include "semanage/module_store.h"
 #include "semanage/semod_conf.h"
 
+#include <sepol/module.h>
+
 #include <fcntl.h>
 #include <stdarg.h>
 #include <string.h>
@@ -294,7 +295,7 @@ int semod_direct_list_sandbox(char *sand
 int semod_direct_commit(char *sandbox, unsigned int policyvers,
                         char *error_buf, size_t error_buf_size) {
         char **mod_filenames = NULL, *linked_filename = NULL, *fc_filename = NULL;
-        semod_module_package_t *base = NULL, **mods = NULL;
+        sepol_module_package_t *base = NULL, **mods = NULL;
         int retval, num_modfiles = 0, num_modules = 0, i;
 
         if (semod_get_sandbox_modules_names (sandbox, &mod_filenames, &num_modfiles) != 0 ||
@@ -348,9 +349,9 @@ int semod_direct_commit(char *sandbox, u
         free (mod_filenames);
         free (linked_filename);
         free (fc_filename);
-        semod_module_package_destroy (base);
+        sepol_module_package_destroy(base);
         for (i = 0; mods != NULL && i < num_modules; i++) {
-                semod_module_package_destroy (mods[i]);
+                sepol_module_package_destroy(mods[i]);
         }
         free (mods);
         return retval;
@@ -419,8 +420,8 @@ static int parse_module_headers (char *s
         pf.fp = NULL;
         if (module_data == NULL ||
             data_len <= 0 ||
-            semod_module_package_info (&pf, &file_type, module_name,
-                                       version) == -1) {
+            sepol_module_package_info(&pf, &file_type, module_name,
+                                      version) == -1) {
                 write_error (error_buf, error_buf_size, "Could not read module file.");
                 return -2;
         }
@@ -457,7 +458,7 @@ static int parse_base_headers (char *san
         pf.fp = NULL;
         if (module_data == NULL ||
             data_len <= 0 ||
-            semod_module_package_info (&pf, &file_type, &module_name, &version) == -1) {
+            sepol_module_package_info(&pf, &file_type, &module_name, &version) == -1) {
                 write_error (error_buf, error_buf_size, "Could not read base policy file.");
                 return -2;
         }
diff -purN nsa/selinux-usr/libsemanage/src/module_store.c nsa-selinux-usr/libsemanage/src/module_store.c
--- nsa/selinux-usr/libsemanage/src/module_store.c	2005-07-27 13:46:52.000000000 -0400
+++ nsa-selinux-usr/libsemanage/src/module_store.c	2005-08-01 15:28:58.000000000 -0400
@@ -28,10 +28,11 @@
 #define _GNU_SOURCE
 #endif
 
-#include "semanage/module.h"
 #include "semanage/module_store.h"
 #include "semanage/semod_conf.h"
 
+#include <sepol/module.h>
+
 #include <assert.h>
 #include <dirent.h>
 #include <errno.h>
@@ -359,7 +360,7 @@ char *semod_get_active_module_filename (
                         continue;  /* could not open this module for reading */
 		}
 		pf.type = PF_USE_STDIO;
-		retval = semod_module_package_info (&pf, &type, &name, &version);
+		retval = sepol_module_package_info(&pf, &type, &name, &version);
                 (void) fclose (pf.fp);
                 free (version);
 		if (retval == 0 && type == POLICY_MOD && strcmp (name, module_name) == 0) {
@@ -729,7 +730,7 @@ static int semod_build_modules_list (con
 		}
                 free (filename);
 		pf.type = PF_USE_STDIO;
-		if (semod_module_package_info (&pf, &type, &name, &version)) {
+		if (sepol_module_package_info(&pf, &type, &name, &version)) {
 			(void) fclose (pf.fp);
                         continue;
 		}
diff -purN nsa/selinux-usr/libsepol/include/sepol/module.h nsa-selinux-usr/libsepol/include/sepol/module.h
--- nsa/selinux-usr/libsepol/include/sepol/module.h	1969-12-31 19:00:00.000000000 -0500
+++ nsa-selinux-usr/libsepol/include/sepol/module.h	2005-08-01 15:29:10.000000000 -0400
@@ -0,0 +1,49 @@
+/* Author: Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * Copyright (C) 2004-2005 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+ 
+#ifndef _SEPOL_MODULE_H_
+#define _SEPOL_MODULE_H_
+
+#include <stdlib.h>
+
+#include <sepol/policydb.h>
+#include <sepol/conditional.h>
+
+#define SEPOL_MODULE_PACKAGE_MAGIC 0xf97cff8e
+
+typedef struct sepol_module_package {
+	policydb_t	*policy;
+	char 		*file_contexts;
+	uint32_t	file_contexts_len;
+} sepol_module_package_t;
+
+ /* link a base module and an array of modules - base module is modified and will
+ * contain the base policy and modules
+ */ 
+extern int sepol_module_package_init(sepol_module_package_t *p);
+extern void sepol_module_package_destroy(sepol_module_package_t *p);
+extern int sepol_link_packages(sepol_module_package_t *base,
+                               sepol_module_package_t **modules, int num_modules,
+                               int verbose, char *error_buf, size_t error_buf_size);
+extern int sepol_module_package_read(sepol_module_package_t *mod, struct policy_file *file, int verbose);
+extern int sepol_module_package_info(struct policy_file *file, int *type, char **name, char **version);
+extern int sepol_module_package_write(sepol_module_package_t *p, struct policy_file *file);
+extern int sepol_module_package_create(struct policy_file *policy, struct policy_file *fc, struct policy_file *file);
+
+#endif
diff -purN nsa/selinux-usr/libsepol/include/sepol/policydb.h nsa-selinux-usr/libsepol/include/sepol/policydb.h
--- nsa/selinux-usr/libsepol/include/sepol/policydb.h	2005-08-01 13:42:13.000000000 -0400
+++ nsa-selinux-usr/libsepol/include/sepol/policydb.h	2005-08-01 15:29:26.000000000 -0400
@@ -570,9 +570,6 @@ extern int sepol_mls_enabled(void);
 #define POLICYDB_MOD_MAGIC SELINUX_MOD_MAGIC
 #define POLICYDB_MOD_STRING "SE Linux Module"
 
-/* Just here for debugging module packages */
-#define SEMOD_MODULE_PACKAGE_MAGIC 0xf97cff8e
-
 #endif	/* _POLICYDB_H_ */
 
 /* FLASK */
diff -purN nsa/selinux-usr/libsepol/src/module.c nsa-selinux-usr/libsepol/src/module.c
--- nsa/selinux-usr/libsepol/src/module.c	1969-12-31 19:00:00.000000000 -0500
+++ nsa-selinux-usr/libsepol/src/module.c	2005-08-01 15:29:33.000000000 -0400
@@ -0,0 +1,355 @@
+/* Author: Karl MacMillan <kmacmillan@tresys.com>
+ *         Jason Tang     <jtang@tresys.com>
+ *
+ * Copyright (C) 2004-2005 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <sepol/link.h>
+#include <sepol/module.h>
+#include "private.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+
+int sepol_module_package_init(sepol_module_package_t *p)
+{
+	memset(p, 0, sizeof(sepol_module_package_t));
+	p->policy = (policydb_t*)calloc(1, sizeof(policydb_t));
+	if (!p->policy)
+		return -1;
+	return 0;
+}
+
+/* Deallocates all memory associated with a module package, including
+ * the pointer itself.  Does nothing if p is NULL.
+ */
+void sepol_module_package_destroy(sepol_module_package_t *p) {
+        if (p == NULL) {
+                return;
+        }
+        policydb_destroy(p->policy);
+        free(p->file_contexts);
+        free(p);
+}
+
+/* Append each of the file contexts from each module to the base
+ * policy's file context.  'base_context' will be reallocated to a
+ * larger size (and thus it is an in/out reference
+ * variable). 'base_fc_len' is the length of base's file context; it
+ * too is a reference variable.  Return 0 on success, -1 if out of
+ * memory. */
+static int link_file_contexts(sepol_module_package_t *base,
+                              sepol_module_package_t **modules, int num_modules) {
+        size_t fc_len;
+        int i;
+        char *s;
+
+        fc_len = base->file_contexts_len;
+        for (i = 0; i < num_modules; i++) {
+        	fc_len += modules[i]->file_contexts_len;
+        }
+
+        if ((s = (char*)realloc(base->file_contexts, fc_len)) == NULL) {
+                return -1;
+        }
+        base->file_contexts = s;
+        for (i = 0; i < num_modules; i++) {
+                memcpy(base->file_contexts + base->file_contexts_len,
+                       modules[i]->file_contexts,
+                       modules[i]->file_contexts_len);
+                base->file_contexts_len += modules[i]->file_contexts_len;
+        }
+        return 0;
+}
+
+
+/* Links the module packages into the base.  Returns 0 on success, -1
+ * if a requirement was not met, or -2 for all other errors. */
+int sepol_link_packages(sepol_module_package_t *base,
+                        sepol_module_package_t **modules, int num_modules,
+                        int verbose, char *error_buf, size_t error_buf_size) {
+        policydb_t **mod_pols = NULL;
+        int i, retval;
+        if ((mod_pols = calloc(num_modules, sizeof(*mod_pols))) == NULL) {
+                if (error_buf != NULL) {
+                        snprintf(error_buf, error_buf_size, "Out of memory!");
+                }
+                return -2;
+        }
+        for (i = 0; i < num_modules; i++) {
+                mod_pols[i] = modules[i]->policy;
+        }
+
+        retval = link_modules(base->policy, mod_pols, num_modules,
+                              verbose, error_buf, error_buf_size);
+        free(mod_pols);
+        if (retval == -3) {
+                return -1;
+        }
+        else if (retval < 0) {
+                return -2;
+        }
+
+        if (link_file_contexts(base, modules, num_modules) == -1) {
+                if (error_buf != NULL) {
+                        snprintf(error_buf, error_buf_size, "Out of memory!");
+                }
+                return -2;
+        }
+        return 0;
+}
+
+
+/* buf must be large enough - no checks are performed */
+#define _read_helper_bufsize 512
+static int read_helper(char *buf, struct policy_file *file, uint32_t bytes)
+{
+	uint32_t offset, nel, read_len;
+	void *tmp;
+	
+	offset = 0;
+	nel = bytes;
+	
+	while (nel) {
+		if (nel < _read_helper_bufsize)
+			read_len = nel;
+		else
+			read_len = _read_helper_bufsize;
+		tmp = next_entry(file, read_len);
+		if (!tmp)
+			return -1;
+		memcpy(&buf[offset], tmp, read_len);
+		offset += read_len;
+		nel -= read_len;
+	}
+	return 0;
+}
+ 
+int sepol_module_package_read(sepol_module_package_t *mod, struct policy_file *file, int verbose)
+{
+	uint32_t *buf;
+	
+	buf = next_entry(file, sizeof(uint32_t) * 2);
+	if (!buf)
+		return -1;
+	if (le32_to_cpu(buf[0]) != SEPOL_MODULE_PACKAGE_MAGIC) {
+		return -1;	
+	}
+	mod->file_contexts_len = le32_to_cpu(buf[1]);
+	
+	if (mod->file_contexts_len) {		
+		mod->file_contexts = (char *)malloc(mod->file_contexts_len);
+		if (!mod->file_contexts) {
+			return -1;	
+		}
+		if (read_helper(mod->file_contexts, file, mod->file_contexts_len))
+			return -1;
+	}
+	
+	return policydb_read(mod->policy, file, verbose);	
+}
+
+int sepol_module_package_info(struct policy_file *file, int *type, char **name, char **version)
+{
+	uint32_t *buf, *buf2, len;
+	
+	buf = next_entry(file, sizeof(uint32_t) * 2);
+	if (!buf)
+		return -1;
+	if (le32_to_cpu(buf[0]) != SEPOL_MODULE_PACKAGE_MAGIC) {
+		return -1;	
+	}
+	
+	/* skip file contexts */
+	len = le32_to_cpu(buf[1]);
+	if (len) {
+		buf2 = malloc(len);
+		if (!buf2) {
+			return -1;	
+		}
+		if (read_helper((char*)buf2, file, len))
+			return -1;
+		free(buf2);
+	}
+	
+	buf = next_entry(file, sizeof(uint32_t)* 2);
+	if (!buf) {
+		return -1;
+	}
+        if (le32_to_cpu(buf[0]) != POLICYDB_MOD_MAGIC) {
+                return -1;
+        }
+
+	len = le32_to_cpu(buf[1]);
+	if (len != strlen(POLICYDB_MOD_STRING)) {
+		return -1;
+	}
+	
+	/* skip id */
+	buf = next_entry(file, len);
+	if (!buf) {
+		return -1;
+	}
+	
+	buf = next_entry(file, sizeof(uint32_t)* 5);
+	if (!buf)
+		return -1;
+	
+	*type = le32_to_cpu(buf[0]);
+	/* if base - we're done */
+	if (*type == POLICY_BASE) {
+		*name = NULL;
+		*version = NULL;
+		return 0;
+	} else if (*type != POLICY_MOD) {
+		return -1;	
+	}
+	
+	/* read the name and version */
+	buf = next_entry(file, sizeof(uint32_t));
+        if (!buf)
+                return -1;
+        len = le32_to_cpu(buf[0]);
+        buf = next_entry(file, len);
+        if (!buf)
+                return -1;
+        *name = malloc(len + 1);
+        if (!*name) {
+                return -1;
+        }
+        memcpy(*name, buf, len);
+        (*name)[len] = '\0';
+        buf = next_entry(file, sizeof(uint32_t));
+        if (!buf)
+                return -1;
+        len = le32_to_cpu(buf[0]);
+        buf = next_entry(file, len);
+        if (!buf)
+                return -1;
+        *version = malloc(len + 1);
+        if (!*version)
+                return -1;
+        memcpy(*version, buf, len);
+        (*version)[len] = '\0';
+	
+	return 0;
+}
+
+#define BUF_SIZE 2048
+static int sepol_module_write_helper(struct policy_file *in, struct policy_file *out, int write_len)
+{
+	uint32_t buf[1], *buf2, len, len2;
+	long start, end;
+	
+	if (in->type == PF_USE_MEMORY) {
+		len = in->len;
+	} else {
+		/* get the length - this doesn't assume that the stream
+		 * was at the beginning */
+		if ((start = ftell(in->fp)) == -1)
+			return -1;
+		if (fseek(in->fp, 0, SEEK_END))
+			return -1;
+		if ((end = ftell(in->fp)) == -1)
+			return -1;
+		len = end - start;
+		if (fseek(in->fp, start, SEEK_SET))
+			return -1;
+	}
+	
+	if (write_len) {
+		buf[0] = cpu_to_le32(len);	
+		if (put_entry(buf, sizeof(uint32_t), 1, out) != 1)
+			return -1;
+	}
+	while (len) {
+		if (len > BUF_SIZE)
+			len2 = BUF_SIZE;
+		else
+			len2 = len;
+		buf2 = next_entry(in, len2);
+		if (!buf2) {
+			return -1;
+		}
+		if (put_entry(buf2, 1, len2, out) != len2) {
+			perror("error writing file");
+			return -1;
+		}
+		len -= len2;
+	}
+	return 0;
+}
+
+int sepol_module_package_write(sepol_module_package_t *p, struct policy_file *file)
+{
+	uint32_t buf[1], len, len2, index;
+		
+	buf[0] = cpu_to_le32(SEPOL_MODULE_PACKAGE_MAGIC);
+	if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
+		return -1;
+		
+	buf[0] = cpu_to_le32(p->file_contexts_len);
+	if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
+		return -1;
+		
+	len = p->file_contexts_len;
+	index = 0;
+	while (len) {
+		if (len > BUF_SIZE)
+			len2 = BUF_SIZE;
+		else
+			len2 = len;
+
+		if (put_entry(&p->file_contexts[index], 1, len2, file) != len2) {
+			perror("error writing file");
+			return -1;
+		}
+		len -= len2;
+		index += len2;
+	}
+	
+	return policydb_write(p->policy, file);
+}
+
+/* file must use stdio */
+int sepol_module_package_create(struct policy_file *policy, struct policy_file *fc, struct policy_file *file)
+{
+	uint32_t buf[BUF_SIZE];
+
+	
+	if (!file->type == PF_USE_STDIO)
+		return -1;
+	
+	buf[0] = cpu_to_le32(SEPOL_MODULE_PACKAGE_MAGIC);
+	if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
+		return -1;
+		
+	if (!fc) {
+		buf[0] = cpu_to_le32(0);
+		if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
+			return -1;
+	} else {	
+		if (sepol_module_write_helper(fc, file, 1)) {
+			return -1;
+		}
+	}
+	if (sepol_module_write_helper(policy, file, 0)) {
+		return -1;	
+	}
+	
+	return 0;
+}
diff -purN nsa/selinux-usr/libsepol/src/private.h nsa-selinux-usr/libsepol/src/private.h
--- nsa/selinux-usr/libsepol/src/private.h	2005-07-18 11:17:15.000000000 -0400
+++ nsa-selinux-usr/libsepol/src/private.h	2005-08-01 15:47:57.000000000 -0400
@@ -57,4 +57,30 @@ static inline void *next_entry(struct po
 	return buffer;
 }
 
+static inline size_t put_entry(const void *ptr, size_t size, size_t n, struct policy_file *fp)
+{
+	size_t bytes = size * n;
+
+	switch (fp->type) {
+	case PF_USE_STDIO:
+		return fwrite(ptr, size, n, fp->fp);
+	case PF_USE_MEMORY:
+		if (bytes > fp->len) {
+			errno = ENOSPC;
+			return 0;
+		}
+
+		memcpy(fp->data, ptr, bytes);
+		fp->data += bytes;
+		fp->len -= bytes;
+		return n;
+	case PF_LEN:
+		fp->len += bytes;
+		return n;
+	default:
+		return 0;
+	}
+	return 0;
+}
+
 extern int mls_enabled;
diff -purN nsa/selinux-usr/libsepol/src/write.c nsa-selinux-usr/libsepol/src/write.c
--- nsa/selinux-usr/libsepol/src/write.c	2005-08-01 13:42:16.000000000 -0400
+++ nsa-selinux-usr/libsepol/src/write.c	2005-08-01 15:48:19.000000000 -0400
@@ -15,7 +15,7 @@
  *	Module writing support
  *
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
- * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ * Copyright (C) 2003-2005 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -69,32 +69,6 @@ int sepol_set_policyvers(unsigned int ty
 	return 0;
 }
 
-static inline size_t put_entry(const void *ptr, size_t size, size_t n, struct policy_file *fp)
-{
-	size_t bytes = size * n;
-
-	switch (fp->type) {
-	case PF_USE_STDIO:
-		return fwrite(ptr, size, n, fp->fp);
-	case PF_USE_MEMORY:
-		if (bytes > fp->len) {
-			errno = ENOSPC;
-			return 0;
-		}
-
-		memcpy(fp->data, ptr, bytes);
-		fp->data += bytes;
-		fp->len -= bytes;
-		return n;
-	case PF_LEN:
-		fp->len += bytes;
-		return n;
-	default:
-		return 0;
-	}
-	return 0;
-}
-
 static int ebitmap_write(ebitmap_t * e, struct policy_file * fp)
 {
 	ebitmap_node_t *n;
diff -purN nsa/selinux-usr/policycoreutils/Makefile nsa-selinux-usr/policycoreutils/Makefile
--- nsa/selinux-usr/policycoreutils/Makefile	2005-07-18 15:46:00.000000000 -0400
+++ nsa-selinux-usr/policycoreutils/Makefile	2005-08-01 15:32:04.000000000 -0400
@@ -1,4 +1,4 @@
-SUBDIRS=setfiles load_policy newrole run_init restorecon audit2allow audit2why scripts po sestatus semodule_link semodule_expand semodule
+SUBDIRS=setfiles load_policy newrole run_init restorecon audit2allow audit2why scripts po sestatus semodule_link semodule_expand semodule_package semodule
 
 all install relabel clean: 
 	@for subdir in $(SUBDIRS); do \
diff -purN nsa/selinux-usr/policycoreutils/semodule_expand/semodule_expand.c nsa-selinux-usr/policycoreutils/semodule_expand/semodule_expand.c
--- nsa/selinux-usr/policycoreutils/semodule_expand/semodule_expand.c	2005-08-01 13:42:33.000000000 -0400
+++ nsa-selinux-usr/policycoreutils/semodule_expand/semodule_expand.c	2005-08-01 15:30:18.000000000 -0400
@@ -7,7 +7,7 @@
  *	the Free Software Foundation, version 2.
  */
 
-#include <semanage/module.h>
+#include <sepol/module.h>
 #include <sepol/expand.h>
 #include <sepol/services.h>
 
@@ -40,7 +40,7 @@ int main(int argc, char **argv)
 	char ch, *basename, *outname, error_buf [256];
 	int fd, ret, show_version = 0, verbose = 0;
 	struct policy_file pf;
-	semod_module_package_t base;
+	sepol_module_package_t base;
 	policydb_t out;
 	FILE *outfile;
 	struct stat sb;
@@ -95,7 +95,7 @@ int main(int argc, char **argv)
 	outname = argv[optind];
 	
 	/* read the base module */
-	if (semod_module_package_init(&base))
+	if (sepol_module_package_init(&base))
 		exit(1);
 	fd = open(basename, O_RDONLY);
 	if (fd < 0) {
@@ -117,7 +117,7 @@ int main(int argc, char **argv)
 	pf.type = PF_USE_MEMORY;
 	pf.data = map;
 	pf.len = sb.st_size;
-	ret = semod_module_package_read(&base, &pf, 0);
+	ret = sepol_module_package_read(&base, &pf, 0);
 	if (ret) {
 		fprintf(stderr, "%s:  error(s) encountered while parsing configuration\n", argv[0]);
 		exit(1);
diff -purN nsa/selinux-usr/policycoreutils/semodule_link/semodule_link.c nsa-selinux-usr/policycoreutils/semodule_link/semodule_link.c
--- nsa/selinux-usr/policycoreutils/semodule_link/semodule_link.c	2005-08-01 13:42:34.000000000 -0400
+++ nsa-selinux-usr/policycoreutils/semodule_link/semodule_link.c	2005-08-01 15:30:44.000000000 -0400
@@ -6,7 +6,7 @@
  *	the Free Software Foundation, version 2.
  */
  
-#include <semanage/module.h>
+#include <sepol/module.h>
 
 #include <getopt.h>
 #include <fcntl.h>
@@ -29,18 +29,18 @@ static void usage(char *program_name)
         exit(1);
 }
 
-static semod_module_package_t *load_module(char *filename)
+static sepol_module_package_t *load_module(char *filename)
 {
 	int ret;
 	struct policy_file pf;
-	semod_module_package_t *p;
+	sepol_module_package_t *p;
 
-	p = (semod_module_package_t*)malloc(sizeof(semod_module_package_t));
+	p = (sepol_module_package_t*)malloc(sizeof(sepol_module_package_t));
 	if (!p) {
 		fprintf(stderr, "Memory error\n");
 		return NULL;
 	}
-	if (semod_module_package_init(p))
+	if (sepol_module_package_init(p))
 		return NULL;
 		
 	pf.fp = fopen(filename, "r");
@@ -54,7 +54,7 @@ static semod_module_package_t *load_modu
 	
 	printf("loading policy from file %s\n", filename);
 	
-	ret = semod_module_package_read(p, &pf, 0);
+	ret = sepol_module_package_read(p, &pf, 0);
 	if (ret) {
 		fprintf(stderr, "error(s) encountered while parsing configuration\n");
 		exit(1);
@@ -82,7 +82,7 @@ int main(int argc, char **argv)
 {
 	int i, show_version = 0, verbose = 0, num_mods;
 	char ch, *basename, *outname = NULL, error_buf[256];
-	semod_module_package_t *base, **mods;
+	sepol_module_package_t *base, **mods;
 	FILE *outfile;
 	struct policy_file pf;
 	
@@ -121,12 +121,12 @@ int main(int argc, char **argv)
         }
        
         num_mods = argc - optind;
-        mods = (semod_module_package_t**)malloc(sizeof(semod_module_package_t*) * num_mods);
+        mods = (sepol_module_package_t**)malloc(sizeof(sepol_module_package_t*) * num_mods);
         if (!mods) {
         	fprintf(stderr, "Memory error\n");
         	exit(1);	
         }
-        memset(mods, 0, sizeof(semod_module_package_t*) * num_mods);
+        memset(mods, 0, sizeof(sepol_module_package_t*) * num_mods);
         
         for (i = 0; optind < argc; optind++, i++) {
         	mods[i] = load_module(argv[optind]);
@@ -135,7 +135,7 @@ int main(int argc, char **argv)
         }
 
         error_buf[0] = '\0';
-        if (semod_link_packages(base, mods, num_mods, verbose, error_buf, sizeof (error_buf))) {
+        if (sepol_link_packages(base, mods, num_mods, verbose, error_buf, sizeof (error_buf))) {
         	fprintf(stderr, "error linking modules: %s\n", error_buf);
         	exit(1);	
         }
@@ -154,7 +154,7 @@ int main(int argc, char **argv)
 	
 		pf.type = PF_USE_STDIO;
 		pf.fp = outfile;
-        	if (semod_module_package_write(base, &pf)) {
+        	if (sepol_module_package_write(base, &pf)) {
         		fprintf(stderr, "Error writing module\n");
         		exit(1);	
         	}	
diff -purN nsa/selinux-usr/policycoreutils/semodule_package/semodule_package.c nsa-selinux-usr/policycoreutils/semodule_package/semodule_package.c
--- nsa/selinux-usr/policycoreutils/semodule_package/semodule_package.c	2005-08-01 13:42:34.000000000 -0400
+++ nsa-selinux-usr/policycoreutils/semodule_package/semodule_package.c	2005-08-01 15:30:55.000000000 -0400
@@ -6,7 +6,7 @@
  *	the Free Software Foundation, version 2.
  */
  
-#include <semanage/module.h>
+#include <sepol/module.h>
 
 #include <fcntl.h>
 #include <stdio.h>
@@ -60,7 +60,7 @@ int main(int argc, char **argv)
 	if (file_to_policy_file(argv[1], &out, "w"))
 		exit(1);
 		
-        if (semod_module_package_create(&mod, (argc == 3 ? NULL : &fc), &out)) {
+        if (sepol_module_package_create(&mod, (argc == 3 ? NULL : &fc), &out)) {
                 fprintf(stderr, "Could not write module package\n");
                 exit(1);
         }

--=-Xa/ZVus8e8LOljfg05JF--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
