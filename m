Date: Wed, 23 May 2007 10:39:36 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: selinux@tycho.nsa.gov
Cc: ynakam@hitachisoft.jp, busybox@kaigai.gr.jp, sds@tycho.nsa.gov
Subject: [patch] Reducing size of libselinux/libsepol: 3rd
Message-Id: <20070523103936.baf38e0b.ynakam@hitachisoft.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi. 
As discussed in previous threads, 
http://marc.info/?t=117609454600002&r=1&w=2
http://marc.info/?t=117886013000001&r=1&w=2
I would like to submit patch to reduce size of libselinux+libsepol, again.

1. Background
Current libselinux+libsepol size is big for embedded devices.
libselinux.so.1: 115348 byte
libsepol.so.1:302067
Total: 417415 byte
It uses more than 400kbyte.
Needs for embedded device is various, because hardware resource is various.
If device is rich enough, people may want full-featured SELinux.
If device is not rich, people want to reduce binary size by removing 
some features. 
For example, some may not want modular policy, may not want boolean.

We thought size of libselinux+libsepol can be reduced 
by removing libsepol and removing unnecessary functions from libselinux.

2. What this patch does
1) libsepol is separated from libselinux
 libsepol is not required by libselinux. 
 So you do not have to compile libsepol,
 if you do not need libsepol functions.

2) Some features are disabled in libselinux
By typing "make EMBEDDED=y" in libselinux dir, what happens is following.
Following values are defined in Makefile.
>ifeq ($(EMBEDDED),y)
>        override DISABLE_AVC=y
>        override DISABLE_SETRANS=y
>        override DISABLE_RPM=y
>        override DISABLE_BOOL=y
>endif

* DISABLE_AVC
  Disables user space avc support, avc.c avc_internal.c avc_sidtab.c are not compiled.
* DISABLE_SETRANS
  Some functions of translations are replaced with stubs in setrans_client.c
* DISABLE_RPM
  Disables rpm features, rpm.c are not compiled.
* DISABLE_BOOL
  Disable boolean features, booleans.c are not compiled.

3) Fixes to libselinux/utils
 * -lsepol is removed
 *  When make EMBEDDED=y, some utils are not compiled.

3. Size measurement
Compiled libselinux/libsepol in trunk by gcc(x86).

* Before
libselinux.so.1: 115348 byte
libsepol.so.1:302067
Total: 417415 byte

* After
libselinux.so.1: 77103 byte
libsepol.so.1:0 byte(do not have to compile)
Total: 77103 byte

Please consider merging this patch.

-------
 Makefile             |   18 ++++
 src/Makefile         |   20 ++++-
 src/load_policy.c    |  190 +++++++++++++++++++++++++++++++++++++--------------
 src/policy.h         |    2
 src/policyvers.c     |    2
 src/setrans_client.c |   49 ++++++++++++-
 utils/Makefile       |   11 ++


Index: trunk/libselinux/utils/Makefile
===================================================================
--- trunk/libselinux/utils/Makefile	(revision 2445)
+++ trunk/libselinux/utils/Makefile	(working copy)
@@ -4,10 +4,17 @@
 BINDIR ?= $(PREFIX)/sbin
 
 CFLAGS ?= -Wall
-override CFLAGS += -I../include -D_GNU_SOURCE
-LDLIBS += -L../src -lselinux -lsepol -L$(LIBDIR)
+override CFLAGS += -I../include -D_GNU_SOURCE $(EMFLAGS)
+LDLIBS += -L../src -lselinux -L$(LIBDIR)
 
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
--- trunk/libselinux/src/policyvers.c	(revision 2445)
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
--- trunk/libselinux/src/policy.h	(revision 2445)
+++ trunk/libselinux/src/policy.h	(working copy)
@@ -20,4 +20,6 @@
 
 #define FILECONTEXTS "/etc/security/selinux/file_contexts"
 
+#define DEFAULT_POLICY_VERSION 15
+
 #endif
Index: trunk/libselinux/src/setrans_client.c
===================================================================
--- trunk/libselinux/src/setrans_client.c	(revision 2445)
+++ trunk/libselinux/src/setrans_client.c	(working copy)
@@ -1,4 +1,10 @@
-/* Copyright (c) 2006 Trusted Computer Solutions, Inc. */
+/* Copyright (c) 2006 Trusted Computer Solutions, Inc. 
+ * 
+ * Modified:
+ * Yuichi Nakamura <ynakam@hitachisoft.jp> 
+ - Stubs are used when DISABLE_SETRANS is defined, 
+   it is to reduce size for such as embedded devices.
+*/
 
 #include <sys/types.h>
 #include <sys/socket.h>
@@ -16,6 +22,7 @@
 #include "selinux_internal.h"
 #include "setrans_internal.h"
 
+#ifndef DISABLE_SETRANS
 static int mls_enabled = -1;
 
 // Simple cache
@@ -290,3 +297,43 @@
 }
 
 hidden_def(selinux_raw_to_trans_context)
+#else /*DISABLE_SETRANS*/
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
+#endif /*DISABLE_SETRANS*/
Index: trunk/libselinux/src/Makefile
===================================================================
--- trunk/libselinux/src/Makefile	(revision 2445)
+++ trunk/libselinux/src/Makefile	(working copy)
@@ -18,10 +18,22 @@
 SWIGSO=_selinux.so
 SWIGFILES=$(SWIGSO) selinux.py 
 LIBSO=$(TARGET).$(LIBVERSION)
-OBJS= $(patsubst %.c,%.o,$(filter-out $(SWIGCOUT),$(wildcard *.c))) 
-LOBJS= $(patsubst %.c,%.lo,$(filter-out $(SWIGCOUT),$(wildcard *.c)))
+
+ifeq ($(DISABLE_AVC),y)
+	UNUSED_SRCS+=avc.c avc_internal.c avc_sidtab.c 
+endif
+ifeq ($(DISABLE_BOOL),y)
+	UNUSED_SRCS+=booleans.c
+endif
+ifeq ($(DISABLE_RPM),y)
+	UNUSED_SRCS+=rpm.c
+endif
+SRCS= $(filter-out $(UNUSED_SRCS), $(filter-out $(SWIGCOUT),$(wildcard *.c)))
+
+OBJS= $(patsubst %.c,%.o,$(SRCS))
+LOBJS= $(patsubst %.c,%.lo,$(SRCS))
 CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
-override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
+override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
 RANLIB=ranlib
 
 ARCH := $(patsubst i%86,i386,$(shell uname -m))
@@ -48,7 +60,7 @@
 	$(CC) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -lsepol -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
+	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c policy.h
Index: trunk/libselinux/src/load_policy.c
===================================================================
--- trunk/libselinux/src/load_policy.c	(revision 2445)
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
@@ -79,71 +155,76 @@
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
+#ifndef DISABLE_BOOL
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
+#endif
 	}
 
+
 	rc = security_load_policy(data, size);
 
       unmap:
@@ -152,6 +233,13 @@
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
 
Index: trunk/libselinux/Makefile
===================================================================
--- trunk/libselinux/Makefile	(revision 2445)
+++ trunk/libselinux/Makefile	(working copy)
@@ -1,3 +1,21 @@
+DISABLE_AVC ?= n
+DISABLE_SETRANS ?= n
+DISABLE_RPM ?= n
+DISABLE_BOOL ?= n
+ifeq ($(EMBEDDED),y)
+	override DISABLE_AVC=y
+	override DISABLE_SETRANS=y
+	override DISABLE_RPM=y
+	override DISABLE_BOOL=y
+endif
+ifeq ($(DISABLE_BOOL),y)
+	EMFLAGS+= -DDISABLE_BOOL
+endif
+ifeq ($(DISABLE_SETRANS),y)
+	EMFLAGS+= -DDISABLE_SETRANS
+endif
+export DISABLE_AVC DISABLE_SETRANS DISABLE_RPM DISABLE_BOOL EMFLAGS
+
 all: 
 	$(MAKE) -C src 
 	$(MAKE) -C utils


Regards,
-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
