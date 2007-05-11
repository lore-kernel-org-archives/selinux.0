Date: Fri, 11 May 2007 14:05:30 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Ver 4(Re: Ver3(Re: [patch] reducing size of libselinux(ver 2)
Message-Id: <20070511140530.66290212.ynakam@hitachisoft.jp>
In-Reply-To: <1178802414.3504.98.camel@moss-spartans.epoch.ncsc.mil>
References: <20070507133423.3bd2463a.ynakam@hitachisoft.jp>
	<1178738679.3504.25.camel@moss-spartans.epoch.ncsc.mil>
	<20070510181218.0499cd05.ynakam@hitachisoft.jp>
	<1178802414.3504.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 May 2007 09:06:54 -0400
Stephen Smalley  wrote:
> Looks mostly sane to me.  Some comments:
Thank you.

> - libselinux/utils/Makefile needs to properly handle the DISABLE_AVC and
> DISABLE_BOOLS options - some of those utilities won't build with your
> cut-down version of libselinux so a make EMBEDDED=y at the top of
> libselinux will fail.
I fixed utils/Makefile.

> - Is DISABLE_BOOLS still worthwhile?  Especially since I removed much of
> that code already as part of removing the legacy booleans/users support
> for setlocaldefs?
I think in some cases people do not use booleans.
So I leave DISABLE_BOOLS option in Makefile, but it is "n" by default.

> - Could likely introduce a DISABLE_SETRANS that reduces setrans_client.c
> to trivial stubs in the embedded case (no translation daemon likely
> there, right?).
> - Could likely introduce a DISABLE_RPM that drops rpm.o from the
> library.
I see, I've prepared DISABLE_SETRANS,DISABLE_RPM.

> - With the elimination of libsepol as a fixed dependency for libselinux,
> we can go back and remove -lsepol from a number of the Makefiles (e.g.
> libselinux/utils, several of the policycoreutils) and we can later
> eliminate it for the patched selinux userland packages (like coreutils -
> it would be nice if things like mv worked without libsepol present as
> they don't need it).
For now I fixed utils/Makefiles.

---
Below is patch ver 4.
I rewrote it for trunk.
 src/Makefile              |   36 ++++++++
 src/booleans_stub.c       |   49 ++++++++++++
 src/load_policy.c         |  187 +++++++++++++++++++++++++++++++++-------------
 src/policy.h              |    2 
 src/policyvers.c          |    2 
 src/setrans_client_stub.c |   44 ++++++++++
 utils/Makefile            |   16 +++
 7 files changed, 279 insertions(+), 57 deletions(-)
Index: trunk/libselinux/utils/Makefile
===================================================================
--- trunk/libselinux/utils/Makefile	(revision 2435)
+++ trunk/libselinux/utils/Makefile	(working copy)
@@ -5,9 +5,23 @@
 
 CFLAGS ?= -Wall
 override CFLAGS += -I../include -D_GNU_SOURCE
-LDLIBS += -L../src -lselinux -lsepol -L$(LIBDIR)
+LDLIBS += -L../src -lselinux -L$(LIBDIR)
 
+DISABLE_AVC ?= n
+DISABLE_BOOL ?= n
+ifeq ($(EMBEDDED),y)
+	override DISABLE_AVC=y
+	override DISABLE_BOOL=n
+endif
+
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+ifeq ($(DISABLE_AVC),y)
+	UNUSED_TARGETS+=compute_av compute_create compute_member compute_relabel
+endif
+ifeq ($(DISABLE_BOOL),y)
+	UNUSED_TARGETS+=getsebool togglesebool
+endif
+TARGETS:= $(filter-out $(UNUSED_TARGETS), $(TARGETS))
 
 all: $(TARGETS)
 
Index: trunk/libselinux/src/policyvers.c
===================================================================
--- trunk/libselinux/src/policyvers.c	(revision 2435)
+++ trunk/libselinux/src/policyvers.c	(working copy)
@@ -10,8 +10,6 @@
 #include "dso.h"
 #include <limits.h>
 
-#define DEFAULT_POLICY_VERSION 15
-
 int security_policyvers(void)
 {
 	int fd, ret;
Index: trunk/libselinux/src/policy.h
===================================================================
--- trunk/libselinux/src/policy.h	(revision 2435)
+++ trunk/libselinux/src/policy.h	(working copy)
@@ -20,4 +20,6 @@
 
 #define FILECONTEXTS "/etc/security/selinux/file_contexts"
 
+#define DEFAULT_POLICY_VERSION 15
+
 #endif
Index: trunk/libselinux/src/Makefile
===================================================================
--- trunk/libselinux/src/Makefile	(revision 2435)
+++ trunk/libselinux/src/Makefile	(working copy)
@@ -18,8 +18,38 @@
 SWIGSO=_selinux.so
 SWIGFILES=$(SWIGSO) selinux.py 
 LIBSO=$(TARGET).$(LIBVERSION)
-OBJS= $(patsubst %.c,%.o,$(filter-out $(SWIGCOUT),$(wildcard *.c))) 
-LOBJS= $(patsubst %.c,%.lo,$(filter-out $(SWIGCOUT),$(wildcard *.c)))
+
+DISABLE_AVC ?= n
+DISABLE_SETRANS ?= n
+DISABLE_RPM ?= n
+DISABLE_BOOL ?= n
+
+ifeq ($(EMBEDDED),y)
+	override DISABLE_AVC=y
+	override DISABLE_SETRANS=y
+	override DISABLE_RPM=y
+	override DISABLE_BOOL=n
+endif
+
+UNUSED_SRCS=setrans_client_stub.c booleans_stub.c
+ifeq ($(DISABLE_AVC),y)
+	UNUSED_SRCS+=avc.c avc_internal.c avc_sidtab.c 
+endif
+ifeq ($(DISABLE_SETRANS),y)
+	UNUSED_SRCS+=setrans_client.c
+	UNUSED_SRCS:=$(filter-out setrans_client_stub.c, $(UNUSED_SRCS))
+endif
+ifeq ($(DISABLE_BOOL),y)
+	UNUSED_SRCS+=booleans.c
+	UNUSED_SRCS:=$(filter-out booleans_stub.c, $(UNUSED_SRCS))
+endif
+ifeq ($(DISABLE_RPM),y)
+	UNUSED_SRCS+=rpm.c
+endif
+SRCS= $(filter-out $(UNUSED_SRCS), $(filter-out $(SWIGCOUT),$(wildcard *.c)))
+
+OBJS= $(patsubst %.c,%.o,$(SRCS))
+LOBJS= $(patsubst %.c,%.lo,$(SRCS))
 CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 RANLIB=ranlib
@@ -48,7 +78,7 @@
 	$(CC) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -lsepol -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
+	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c policy.h
Index: trunk/libselinux/src/booleans_stub.c
===================================================================
--- trunk/libselinux/src/booleans_stub.c	(revision 0)
+++ trunk/libselinux/src/booleans_stub.c	(revision 0)
@@ -0,0 +1,49 @@
+/*This is a stub of booleans.c,
+  used when compiled with DISABLE_BOOL=y
+*/
+#include "selinux_internal.h"
+#include "policy.h"
+
+int security_get_boolean_names(char ***names, int *len)
+{
+	return -1;
+}
+
+hidden_def(security_get_boolean_names)
+
+int security_get_boolean_pending(const char *name)
+{
+	return -1;
+}
+
+int security_get_boolean_active(const char *name)
+{
+	return -1;
+}
+
+hidden_def(security_get_boolean_active)
+
+int security_set_boolean(const char *name, int value)
+{
+	return -1;
+}
+
+hidden_def(security_set_boolean)
+
+int security_commit_booleans(void)
+{
+	return -1;
+}
+
+hidden_def(security_commit_booleans)
+
+int security_set_boolean_list(size_t boolcnt, SELboolean * boollist,
+			      int permanent)
+{
+	return -1;
+}
+
+int security_load_booleans(char *path)
+{
+	return -1;
+}
Index: trunk/libselinux/src/setrans_client_stub.c
===================================================================
--- trunk/libselinux/src/setrans_client_stub.c	(revision 0)
+++ trunk/libselinux/src/setrans_client_stub.c	(revision 0)
@@ -0,0 +1,44 @@
+/*This is a stub of setrans_client.c,
+  used when compiled with DISABLE_SETRANS=y
+*/
+#include <stdio.h>
+#include <string.h>
+#include "selinux_internal.h"
+
+hidden void fini_context_translations(void)
+{
+}
+
+hidden int init_context_translations(void)
+{
+	return 0;
+}
+
+int selinux_trans_to_raw_context(security_context_t trans,
+				 security_context_t * rawp)
+{
+	if (!trans) {
+		*rawp = NULL;
+		return 0;
+	}
+
+	*rawp = strdup(trans);
+	
+	return *rawp ? 0 : -1;
+}
+
+hidden_def(selinux_trans_to_raw_context)
+
+int selinux_raw_to_trans_context(security_context_t raw,
+				 security_context_t * transp)
+{
+	if (!raw) {
+		*transp = NULL;
+		return 0;
+	}
+	*transp = strdup(raw);
+	
+	return *transp ? 0 : -1;
+}
+
+hidden_def(selinux_raw_to_trans_context)
Index: trunk/libselinux/src/load_policy.c
===================================================================
--- trunk/libselinux/src/load_policy.c	(revision 2435)
+++ trunk/libselinux/src/load_policy.c	(working copy)
@@ -12,6 +12,7 @@
 #include "selinux_internal.h"
 #include <sepol/sepol.h>
 #include <sepol/policydb.h>
+#include <dlfcn.h>
 #include "policy.h"
 #include <limits.h>
 
@@ -42,9 +43,9 @@
 int load_setlocaldefs hidden = 1;
 
 int selinux_mkload_policy(int preservebools)
-{
-	int vers = sepol_policy_kern_vers_max();
+{	
 	int kernvers = security_policyvers();
+	int vers = kernvers, minvers = DEFAULT_POLICY_VERSION;
 	char path[PATH_MAX], **names;
 	struct stat sb;
 	size_t size;
@@ -52,20 +53,95 @@
 	int fd, rc = -1, *values, len, i, prot;
 	sepol_policydb_t *policydb;
 	sepol_policy_file_t *pf;
+	int usesepol = 0;
+	int (*vers_max)(void) = NULL;
+	int (*vers_min)(void) = NULL;
+	int (*policy_file_create)(sepol_policy_file_t **) = NULL;
+	void (*policy_file_free)(sepol_policy_file_t *) = NULL;
+	void (*policy_file_set_mem)(sepol_policy_file_t *, char*, size_t) = NULL;
+	int (*policydb_create)(sepol_policydb_t **) = NULL;
+	void (*policydb_free)(sepol_policydb_t *) = NULL;
+	int (*policydb_read)(sepol_policydb_t *, sepol_policy_file_t *) = NULL;
+	int (*policydb_set_vers)(sepol_policydb_t *, unsigned int) = NULL;
+	int (*policydb_to_image)(sepol_handle_t *, sepol_policydb_t *, void **, size_t *) = NULL;
+	int (*genbools_array)(void *data, size_t len, char **names, int *values, int nel) = NULL;
+	int (*genusers)(void *data, size_t len, const char *usersdir, void **newdata, size_t * newlen) = NULL;
+	int (*genbools)(void *data, size_t len, char *boolpath) = NULL;
 
+#ifdef SHARED
+	char *errormsg = NULL;
+	void *libsepolh = NULL;
+	libsepolh = dlopen("libsepol.so", RTLD_NOW);
+	if (libsepolh) {
+		usesepol = 1;
+		dlerror();
+#define DLERR() if ((errormsg = dlerror())) goto dlclose;
+		vers_max = dlsym(libsepolh, "sepol_policy_kern_vers_max");
+		DLERR();
+		vers_min = dlsym(libsepolh, "sepol_policy_kern_vers_min");
+		DLERR();
+
+		policy_file_create = dlsym(libsepolh, "sepol_policy_file_create");
+		DLERR();
+		policy_file_free = dlsym(libsepolh, "sepol_policy_file_free");
+		DLERR();
+		policy_file_set_mem = dlsym(libsepolh, "sepol_policy_file_set_mem");
+		DLERR();
+		policydb_create = dlsym(libsepolh, "sepol_policydb_create");
+		DLERR();
+		policydb_free = dlsym(libsepolh, "sepol_policydb_free");
+		DLERR();
+		policydb_read = dlsym(libsepolh, "sepol_policydb_read");
+		DLERR();
+		policydb_set_vers = dlsym(libsepolh, "sepol_policydb_set_vers");
+		DLERR();
+		policydb_to_image = dlsym(libsepolh, "sepol_policydb_to_image");
+		DLERR();
+		genbools_array = dlsym(libsepolh, "sepol_genbools_array");
+		DLERR();
+		genusers = dlsym(libsepolh, "sepol_genusers");
+		DLERR();
+		genbools = dlsym(libsepolh, "sepol_genbools");
+		DLERR();
+
+#undef DLERR
+	}
+#else
+	usesepol = 1;
+	vers_max = sepol_policy_kern_vers_max;
+	vers_min = sepol_policy_kern_vers_min;
+	policy_file_create = sepol_policy_file_create;
+	policy_file_free = sepol_policy_file_free;
+	policy_file_set_mem = sepol_policy_file_set_mem;
+	policydb_create = sepol_policydb_create;
+	policydb_free = sepol_policydb_free;
+	policydb_read = sepol_policydb_read;
+	policydb_set_vers = sepol_policydb_set_vers;
+	policydb_to_image = sepol_policydb_to_image;
+	genbools_array = sepol_genbools_array;
+	genusers = sepol_genusers;
+	genbools = sepol_genbools;
+
+#endif
+
+	if (usesepol) {
+		vers = vers_max();
+		minvers = vers_min();
+	}
+
       search:
 	snprintf(path, sizeof(path), "%s.%d",
 		 selinux_binary_policy_path(), vers);
 	fd = open(path, O_RDONLY);
 	while (fd < 0 && errno == ENOENT
-	       && --vers >= sepol_policy_kern_vers_min()) {
+	       && --vers >= minvers) {
 		/* Check prior versions to see if old policy is available */
 		snprintf(path, sizeof(path), "%s.%d",
 			 selinux_binary_policy_path(), vers);
 		fd = open(path, O_RDONLY);
 	}
 	if (fd < 0)
-		return -1;
+		goto dlclose;
 
 	if (fstat(fd, &sb) < 0)
 		goto close;
@@ -79,69 +155,71 @@
 	if (map == MAP_FAILED)
 		goto close;
 
-	if (vers > kernvers) {
+	if (vers > kernvers && usesepol) {
 		/* Need to downgrade to kernel-supported version. */
-		if (sepol_policy_file_create(&pf))
+		if (policy_file_create(&pf))
 			goto unmap;
-		if (sepol_policydb_create(&policydb)) {
-			sepol_policy_file_free(pf);
+		if (policydb_create(&policydb)) {
+			policy_file_free(pf);
 			goto unmap;
 		}
-		sepol_policy_file_set_mem(pf, data, size);
-		if (sepol_policydb_read(policydb, pf)) {
-			sepol_policy_file_free(pf);
-			sepol_policydb_free(policydb);
+		policy_file_set_mem(pf, data, size);
+		if (policydb_read(policydb, pf)) {
+			policy_file_free(pf);
+			policydb_free(policydb);
 			goto unmap;
 		}
-		if (sepol_policydb_set_vers(policydb, kernvers) ||
-		    sepol_policydb_to_image(NULL, policydb, &data, &size)) {
+		if (policydb_set_vers(policydb, kernvers) ||
+		    policydb_to_image(NULL, policydb, &data, &size)) {
 			/* Downgrade failed, keep searching. */
-			sepol_policy_file_free(pf);
-			sepol_policydb_free(policydb);
+			policy_file_free(pf);
+			policydb_free(policydb);
 			munmap(map, sb.st_size);
 			close(fd);
 			vers--;
 			goto search;
 		}
-		sepol_policy_file_free(pf);
-		sepol_policydb_free(policydb);
+		policy_file_free(pf);
+		policydb_free(policydb);
 	}
 
-	if (load_setlocaldefs) {
-		void *olddata = data;
-		size_t oldsize = size;
-		rc = sepol_genusers(olddata, oldsize, selinux_users_path(),
-				    &data, &size);
-		if (rc < 0) {
-			/* Fall back to the prior image if genusers failed. */
-			data = olddata;
-			size = oldsize;
-			rc = 0;
-		} else {
-			if (olddata != map)
-				free(olddata);
+	if (usesepol) {
+		if (load_setlocaldefs) {
+			void *olddata = data;
+			size_t oldsize = size;
+			rc = genusers(olddata, oldsize, selinux_users_path(),
+				      &data, &size);
+			if (rc < 0) {
+				/* Fall back to the prior image if genusers failed. */
+				data = olddata;
+				size = oldsize;
+				rc = 0;
+			} else {
+				if (olddata != map)
+					free(olddata);
+			}
 		}
-	}
-
-	if (preservebools) {
-		rc = security_get_boolean_names(&names, &len);
-		if (!rc) {
-			values = malloc(sizeof(int) * len);
-			if (!values)
-				goto unmap;
-			for (i = 0; i < len; i++)
-				values[i] =
-				    security_get_boolean_active(names[i]);
-			(void)sepol_genbools_array(data, size, names, values,
-						   len);
-			free(values);
-			for (i = 0; i < len; i++)
-				free(names[i]);
-			free(names);
+		
+		if (preservebools) {
+			rc = security_get_boolean_names(&names, &len);
+			if (!rc) {
+				values = malloc(sizeof(int) * len);
+				if (!values)
+					goto unmap;
+				for (i = 0; i < len; i++)
+					values[i] =
+						security_get_boolean_active(names[i]);
+				(void)genbools_array(data, size, names, values,
+						     len);
+				free(values);
+				for (i = 0; i < len; i++)
+					free(names[i]);
+				free(names);
+			}
+		} else if (load_setlocaldefs) {
+			(void)genbools(data, size,
+				       (char *)selinux_booleans_path());
 		}
-	} else if (load_setlocaldefs) {
-		(void)sepol_genbools(data, size,
-				     (char *)selinux_booleans_path());
 	}
 
 	rc = security_load_policy(data, size);
@@ -152,6 +230,13 @@
 	munmap(map, sb.st_size);
       close:
 	close(fd);
+      dlclose:
+#ifdef SHARED
+	if (errormsg)
+		fprintf(stderr, "libselinux:  %s\n", errormsg);
+	if (libsepolh)
+		dlclose(libsepolh);
+#endif
 	return rc;
 }
 

 

----
Yuichi Nakamura
Hitachi Software


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
