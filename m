Message-ID: <435446B6.3090608@cornell.edu>
Date: Mon, 17 Oct 2005 20:49:58 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Rename direct -> policydb as appropriate
Content-Type: multipart/mixed;
 boundary="------------070305000709030906090009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070305000709030906090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

During an off-list discussion w/ Joshua, it became apparent that there's 
confusion with the current naming of things.

In particular Tresys appear to use "direct" to refer to the method of 
access - if something is not accessed over the policy server, it is 
accessed directly, regardless of how it's stored. I've been using 
"direct" to refer specifically to the policydb backend.

The following patch rename direct -> policydb as appropriate to prevent 
further confusion. Note that both the FILE and POLICYDB database types 
are both considered "DIRECT," and are initialized in the direct_api.c 
connect() function.

Applies on top of the other patches sent, and should contain no 
functional changes, other than renames.


--------------070305000709030906090009
Content-Type: text/x-patch;
 name="libsemanage.direct_rename.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.direct_rename.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database_direct.c new/libsemanage/src/database_direct.c
--- old/libsemanage/src/database_direct.c	2005-10-17 20:32:15.000000000 -0400
+++ new/libsemanage/src/database_direct.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,439 +0,0 @@
-struct dbase_direct;
-typedef struct dbase_direct dbase_t;
-#define DBASE_DEFINED
-
-#include <stdlib.h>
-#include <string.h>
-#include <stdio.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <unistd.h>
-#include <string.h>
-#include <sepol/policydb.h>
-#include "database_direct.h"
-#include "semanage_store.h"
-#include "handle.h"
-#include "debug.h"
-
-/* POLICY DIRECT dbase */
-struct dbase_direct {
-
-	/* Backing file suffix */
-	const char* suffix;
-
-	/* Base record table */
-	record_table_t* rtable;
-
-	/* Policy extensions */
-	record_direct_table_t* rptable;
-
-	sepol_policydb_t* policy;
-	int cached;
-	int modified;
-	int attached;
-};
-
-static int construct_filename(
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase,
-	char** filename) {
-
-	const char* path = (handle->is_in_transaction)?
-		semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL):
-		semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
-	size_t fname_length = strlen(path) + strlen(dbase->suffix) + 2;
-
-	char* fname = malloc(fname_length);
-	if (!fname) {
-		/*  FIXME: handle error */
-		return STATUS_ERR;
-	}
-	snprintf(fname, fname_length, "%s/%s", path, dbase->suffix);
-
-	*filename = fname;
-	return STATUS_SUCCESS;
-}
-
-static int dbase_direct_cache(
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase) {
-
-	int fd = -1;
-	struct stat sb;
-	void* data = NULL;
-	sepol_policydb_t* policydb = NULL;
-
-	char* fname = NULL;
-
-	/* Already cached */
-	if (dbase->cached || dbase->attached)
-		return STATUS_SUCCESS;
-	
-	if (construct_filename(handle, dbase, &fname) < 0)
-		goto err;
-
-	/* Open file */
-	fd = open(fname, O_RDONLY);
-	if (fd < 0) {
-		/* FIXME: handle error */
-		goto err;
-	}
-
-	/* Stat */
-	if (fstat(fd, &sb) < 0) {
-		/* FIXME: handle error */
-		goto err;
-	}
-
-	/* Map file */
-	data = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	if (data == MAP_FAILED) {
-		/* FIXME: handle error */
-		goto err;
-        }
-
-	/* Create policydb image */
-	if (sepol_policydb_create(&policydb))
-		goto omem;
-	if (sepol_policydb_from_image(data, sb.st_size, policydb) < 0)
-		goto err;
-	dbase->policy = policydb;
-
-	close(fd);
-	munmap(data, sb.st_size);
-	free(fname);
-	dbase->cached = 1;
-	return STATUS_SUCCESS;
-	
-	omem:
-	/* FIXME: handle error */
-	
-	err:
-	/* FIXME: handle error */
-	if (fd > 0)
-		close(fd);
-	if (data != NULL)
-		munmap(data, sb.st_size);
-	
-	free(policydb);
-	free(fname);
-	return STATUS_ERR;
-
-}
-
-static int dbase_direct_flush(
-	semanage_handle_t* handle,	
-	dbase_direct_t* dbase) {
-
-	if (!dbase->modified || !dbase->cached)
-		return STATUS_SUCCESS;
-
-	dbase->modified = 0;
-
-	/* Stub */
-	handle = NULL;
-	return STATUS_SUCCESS;
-}
-
-
-static void dbase_direct_drop_cache(
-	semanage_handle_t* handle,       
-	 dbase_direct_t* dbase) {
-
-	if (dbase->cached) {
-		sepol_policydb_free(dbase->policy);
-		dbase->cached = 0;
-		dbase->modified = 0;
-	}
-
-	handle = NULL;
-}
-
-static int enter_ro(
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase) {
-
-	if (!handle->is_connected) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
-	}
-	
-	if (semanage_get_read_lock(handle) < 0) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
-	}
-
-	if (dbase_direct_cache(handle, dbase) < 0) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
-	}
-
-	return STATUS_SUCCESS;
-}
-
-static inline void exit_ro(
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase) {
-
-	semanage_release_read_lock(handle);
-	dbase_direct_drop_cache(handle, dbase);
-}
-
-static int enter_rw(
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase) {
-
-	if (!handle->is_connected) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
-	}
-	
-	if (!handle->is_in_transaction) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
-	}
-
-	if (dbase_direct_cache(handle, dbase) < 0) {
-		/* FIXME: handle error */
-		return STATUS_ERR;
-	}
-
-	return STATUS_SUCCESS;	
-}
-
-int dbase_direct_init(
-	const char* suffix,
-	record_table_t* rtable,
-	record_direct_table_t* rptable,
-        dbase_direct_t** dbase) {
-
-	dbase_direct_t* tmp_dbase =
-		(dbase_direct_t*) malloc(sizeof(dbase_direct_t));
-
-	if (!tmp_dbase)
-		goto omem;
-
-	tmp_dbase->suffix = suffix;
-	tmp_dbase->rtable = rtable;
-	tmp_dbase->rptable = rptable;
-	tmp_dbase->policy = NULL;
-	tmp_dbase->cached = 0;
-	tmp_dbase->modified = 0;
-	tmp_dbase->attached = 0;
-	*dbase = tmp_dbase;
-
-	return STATUS_SUCCESS;
-
-	omem:
-	/* FIXME: handle error condition */
-	free(tmp_dbase);
-
-	return STATUS_ERR;
-}
-
-/* Release dbase resources */
-void dbase_direct_release(
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase) {
-
-	dbase_direct_drop_cache(handle, dbase);
-	free(dbase);
-}
-
-/* Attach to a shared policydb.
- * This implies drop_cache(),
- * and prevents flush() and drop_cache()
- * until detached. */
-void dbase_direct_attach(
-        semanage_handle_t* handle,
-        dbase_direct_t* dbase,
-        sepol_policydb_t* policydb) {
-
-	dbase->attached = 1;
-	dbase_direct_drop_cache(handle, dbase);
-	dbase->policy = policydb;
-}
-
-/* Detach from a shared policdb.
- * This implies drop_cache. */
-void dbase_direct_detach(
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase) {
-
-	dbase->attached = 0;
-	handle = NULL;
-}
-
-static int dbase_direct_add (
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase,
-	record_key_t* key,
-	record_t* data) {
-	
-	if (enter_rw(handle, dbase) < 0)
-		goto err;
-
-	/* Stub */
-	key = NULL;
-	data = NULL;
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
-static int dbase_direct_modify (
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase,
-	record_key_t* key,
-	record_t* data) {
-
-	if (enter_rw(handle, dbase) < 0)
-		goto err;
-
-	/* Stub */
-	key = NULL;
-	data = NULL;
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
-static int dbase_direct_del (
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase,
-	record_key_t* key) {
-
-	if (enter_rw(handle, dbase) < 0)
-		goto err;
-
-	/* Stub */
-	key = NULL;
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	return STATUS_ERR;
-}
-
-static int dbase_direct_query (
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase,
-	record_key_t* key,
-	record_t** response) {
-
-	if (enter_ro(handle, dbase) < 0)
-		goto err;
-
-	/* Stub */
-	key = NULL;
-	response = NULL;
-	exit_ro(handle, dbase);
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	exit_ro(handle, dbase);
-	return STATUS_ERR;
-}
-
-static int dbase_direct_exists (
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase,
-	record_key_t* key,
-	int* response) {
-
-	if (enter_ro(handle, dbase) < 0)
-		goto err;
-
-	/* Stub */
-	key = NULL;
-	response = NULL;
-	exit_ro(handle, dbase);
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	exit_ro(handle, dbase);
-	return STATUS_ERR;
-}
-
-static int dbase_direct_count (
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase,
-	int* response) {
-
-	if (enter_ro(handle, dbase) < 0)
-		goto err;
-
-	/* Stub */
-	response = NULL;
-	exit_ro(handle, dbase);
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	exit_ro(handle, dbase);
-	return STATUS_ERR;
-}
-
-static int dbase_direct_iterate(
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase,
-	int (*fn) (record_t* record, void* fn_arg),
-	void* arg) {
-
-	if (enter_ro(handle, dbase) < 0)
-		goto err;
-	
-	if (dbase->rptable->iterate(dbase->policy, fn, arg) < 0)
-		goto err;
-
-	exit_ro(handle, dbase);
-        return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	exit_ro(handle, dbase);
-	return STATUS_ERR;
-}
-
-static int dbase_direct_list (
-	semanage_handle_t* handle,
-	dbase_t* dbase,
-	record_t*** records,
-	size_t* count) {
-
-	if (enter_ro(handle, dbase) < 0)
-		goto err;
-
-	/* Stub */
-	records = NULL;
-	count = NULL;
-	exit_ro(handle, dbase);
-	return STATUS_SUCCESS;
-
-	err:
-	/* FIXME: handle error */
-	exit_ro(handle, dbase);
-	return STATUS_ERR;
-}
-
-/* DIRECT POLICY dbase - method table implementation */
-dbase_table_t SEMANAGE_DIRECT_DTABLE = {
-	.drop_cache = dbase_direct_drop_cache,
-	.flush = dbase_direct_flush,
-	.iterate = dbase_direct_iterate,
-	.exists = dbase_direct_exists,
-	.list = dbase_direct_list,
-	.add = dbase_direct_add,
-	.del = dbase_direct_del,
-	.modify = dbase_direct_modify, 
-	.query = dbase_direct_query,
-	.count = dbase_direct_count,
-};
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database_direct.h new/libsemanage/src/database_direct.h
--- old/libsemanage/src/database_direct.h	2005-10-13 13:08:35.000000000 -0400
+++ new/libsemanage/src/database_direct.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,58 +0,0 @@
-#ifndef _SEMANAGE_DATABASE_DIRECT_INTERNAL_H_
-#define _SEMANAGE_DATABASE_DIRECT_INTERNAL_H_
-
-#include <sepol/policydb.h>
-#include "database.h"
-#include "handle.h"
-
-struct dbase_direct;
-typedef struct dbase_direct dbase_direct_t;
-
-/* POLICY DIRECT extension to RECORD interface - method table */
-typedef struct record_direct_table {
-
-	/* Add record into the policy database */
-	int (*add) (sepol_policydb_t* policydb, record_t* record);
-
-	/* Modify record into the policy database */
-	int (*modify) (sepol_policydb_t* policydb, record_t* record);
-
-	/* Iterate over records */
-	int (*iterate) (
-		sepol_policydb_t* policydb,
-		int (*fn)(record_t* record, void* fn_arg),
-	void* arg);
-
-} record_direct_table_t;
-
-/* Initialize database */
-extern int dbase_direct_init(
-	const char* suffix,
-	record_table_t* rtable,
-	record_direct_table_t* rptable,
-	dbase_direct_t** dbase);
-
-/* Attach to a shared policydb.
- * This implies drop_cache().
- * and prevents flush() and drop_cache()
- * until detached. */ 
-extern void dbase_direct_attach(
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase,
-	sepol_policydb_t* policydb);
-
-/* Detach from a shared policdb.
- * This implies drop_cache. */
-extern void dbase_direct_detach(
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase);
-
-/* Release allocated resources */
-extern void dbase_direct_release(
-	semanage_handle_t* handle,
-	dbase_direct_t* dbase);
-
-/* POLICY DIRECT - method table implementation */
-extern dbase_table_t SEMANAGE_DIRECT_DTABLE;
-
-#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/database_policydb.c	2005-10-17 20:40:17.000000000 -0400
@@ -0,0 +1,439 @@
+struct dbase_policydb;
+typedef struct dbase_policydb dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <string.h>
+#include <sepol/policydb.h>
+#include "database_policydb.h"
+#include "semanage_store.h"
+#include "handle.h"
+#include "debug.h"
+
+/* POLICYDB dbase */
+struct dbase_policydb {
+
+	/* Backing file suffix */
+	const char* suffix;
+
+	/* Base record table */
+	record_table_t* rtable;
+
+	/* Policy extensions */
+	record_policydb_table_t* rptable;
+
+	sepol_policydb_t* policy;
+	int cached;
+	int modified;
+	int attached;
+};
+
+static int construct_filename(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase,
+	char** filename) {
+
+	const char* path = (handle->is_in_transaction)?
+		semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL):
+		semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
+	size_t fname_length = strlen(path) + strlen(dbase->suffix) + 2;
+
+	char* fname = malloc(fname_length);
+	if (!fname) {
+		/*  FIXME: handle error */
+		return STATUS_ERR;
+	}
+	snprintf(fname, fname_length, "%s/%s", path, dbase->suffix);
+
+	*filename = fname;
+	return STATUS_SUCCESS;
+}
+
+static int dbase_policydb_cache(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase) {
+
+	int fd = -1;
+	struct stat sb;
+	void* data = NULL;
+	sepol_policydb_t* policydb = NULL;
+
+	char* fname = NULL;
+
+	/* Already cached */
+	if (dbase->cached || dbase->attached)
+		return STATUS_SUCCESS;
+	
+	if (construct_filename(handle, dbase, &fname) < 0)
+		goto err;
+
+	/* Open file */
+	fd = open(fname, O_RDONLY);
+	if (fd < 0) {
+		/* FIXME: handle error */
+		goto err;
+	}
+
+	/* Stat */
+	if (fstat(fd, &sb) < 0) {
+		/* FIXME: handle error */
+		goto err;
+	}
+
+	/* Map file */
+	data = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (data == MAP_FAILED) {
+		/* FIXME: handle error */
+		goto err;
+        }
+
+	/* Create policydb image */
+	if (sepol_policydb_create(&policydb))
+		goto omem;
+	if (sepol_policydb_from_image(data, sb.st_size, policydb) < 0)
+		goto err;
+	dbase->policy = policydb;
+
+	close(fd);
+	munmap(data, sb.st_size);
+	free(fname);
+	dbase->cached = 1;
+	return STATUS_SUCCESS;
+	
+	omem:
+	/* FIXME: handle error */
+	
+	err:
+	/* FIXME: handle error */
+	if (fd > 0)
+		close(fd);
+	if (data != NULL)
+		munmap(data, sb.st_size);
+	
+	free(policydb);
+	free(fname);
+	return STATUS_ERR;
+
+}
+
+static int dbase_policydb_flush(
+	semanage_handle_t* handle,	
+	dbase_policydb_t* dbase) {
+
+	if (!dbase->modified || !dbase->cached)
+		return STATUS_SUCCESS;
+
+	dbase->modified = 0;
+
+	/* Stub */
+	handle = NULL;
+	return STATUS_SUCCESS;
+}
+
+
+static void dbase_policydb_drop_cache(
+	semanage_handle_t* handle,       
+	 dbase_policydb_t* dbase) {
+
+	if (dbase->cached) {
+		sepol_policydb_free(dbase->policy);
+		dbase->cached = 0;
+		dbase->modified = 0;
+	}
+
+	handle = NULL;
+}
+
+static int enter_ro(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase) {
+
+	if (!handle->is_connected) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+	
+	if (semanage_get_read_lock(handle) < 0) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	if (dbase_policydb_cache(handle, dbase) < 0) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static inline void exit_ro(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase) {
+
+	semanage_release_read_lock(handle);
+	dbase_policydb_drop_cache(handle, dbase);
+}
+
+static int enter_rw(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase) {
+
+	if (!handle->is_connected) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+	
+	if (!handle->is_in_transaction) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	if (dbase_policydb_cache(handle, dbase) < 0) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;	
+}
+
+int dbase_policydb_init(
+	const char* suffix,
+	record_table_t* rtable,
+	record_policydb_table_t* rptable,
+        dbase_policydb_t** dbase) {
+
+	dbase_policydb_t* tmp_dbase =
+		(dbase_policydb_t*) malloc(sizeof(dbase_policydb_t));
+
+	if (!tmp_dbase)
+		goto omem;
+
+	tmp_dbase->suffix = suffix;
+	tmp_dbase->rtable = rtable;
+	tmp_dbase->rptable = rptable;
+	tmp_dbase->policy = NULL;
+	tmp_dbase->cached = 0;
+	tmp_dbase->modified = 0;
+	tmp_dbase->attached = 0;
+	*dbase = tmp_dbase;
+
+	return STATUS_SUCCESS;
+
+	omem:
+	/* FIXME: handle error condition */
+	free(tmp_dbase);
+
+	return STATUS_ERR;
+}
+
+/* Release dbase resources */
+void dbase_policydb_release(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase) {
+
+	dbase_policydb_drop_cache(handle, dbase);
+	free(dbase);
+}
+
+/* Attach to a shared policydb.
+ * This implies drop_cache(),
+ * and prevents flush() and drop_cache()
+ * until detached. */
+void dbase_policydb_attach(
+        semanage_handle_t* handle,
+        dbase_policydb_t* dbase,
+        sepol_policydb_t* policydb) {
+
+	dbase->attached = 1;
+	dbase_policydb_drop_cache(handle, dbase);
+	dbase->policy = policydb;
+}
+
+/* Detach from a shared policdb.
+ * This implies drop_cache. */
+void dbase_policydb_detach(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase) {
+
+	dbase->attached = 0;
+	handle = NULL;
+}
+
+static int dbase_policydb_add (
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+	
+	if (enter_rw(handle, dbase) < 0)
+		goto err;
+
+	/* Stub */
+	key = NULL;
+	data = NULL;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+static int dbase_policydb_modify (
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+
+	if (enter_rw(handle, dbase) < 0)
+		goto err;
+
+	/* Stub */
+	key = NULL;
+	data = NULL;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+static int dbase_policydb_del (
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase,
+	record_key_t* key) {
+
+	if (enter_rw(handle, dbase) < 0)
+		goto err;
+
+	/* Stub */
+	key = NULL;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
+
+static int dbase_policydb_query (
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase,
+	record_key_t* key,
+	record_t** response) {
+
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
+	/* Stub */
+	key = NULL;
+	response = NULL;
+	exit_ro(handle, dbase);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
+}
+
+static int dbase_policydb_exists (
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase,
+	record_key_t* key,
+	int* response) {
+
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
+	/* Stub */
+	key = NULL;
+	response = NULL;
+	exit_ro(handle, dbase);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
+}
+
+static int dbase_policydb_count (
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase,
+	int* response) {
+
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
+	/* Stub */
+	response = NULL;
+	exit_ro(handle, dbase);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
+}
+
+static int dbase_policydb_iterate(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase,
+	int (*fn) (record_t* record, void* fn_arg),
+	void* arg) {
+
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+	
+	if (dbase->rptable->iterate(dbase->policy, fn, arg) < 0)
+		goto err;
+
+	exit_ro(handle, dbase);
+        return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
+}
+
+static int dbase_policydb_list (
+	semanage_handle_t* handle,
+	dbase_t* dbase,
+	record_t*** records,
+	size_t* count) {
+
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
+	/* Stub */
+	records = NULL;
+	count = NULL;
+	exit_ro(handle, dbase);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
+}
+
+/* POLICYDB dbase - method table implementation */
+dbase_table_t SEMANAGE_POLICYDB_DTABLE = {
+	.drop_cache = dbase_policydb_drop_cache,
+	.flush = dbase_policydb_flush,
+	.iterate = dbase_policydb_iterate,
+	.exists = dbase_policydb_exists,
+	.list = dbase_policydb_list,
+	.add = dbase_policydb_add,
+	.del = dbase_policydb_del,
+	.modify = dbase_policydb_modify, 
+	.query = dbase_policydb_query,
+	.count = dbase_policydb_count,
+};
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database_policydb.h new/libsemanage/src/database_policydb.h
--- old/libsemanage/src/database_policydb.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/database_policydb.h	2005-10-17 20:40:50.000000000 -0400
@@ -0,0 +1,58 @@
+#ifndef _SEMANAGE_DATABASE_POLICYDB_INTERNAL_H_
+#define _SEMANAGE_DATABASE_POLICYDB_INTERNAL_H_
+
+#include <sepol/policydb.h>
+#include "database.h"
+#include "handle.h"
+
+struct dbase_policydb;
+typedef struct dbase_policydb dbase_policydb_t;
+
+/* POLICYDB extension to RECORD interface - method table */
+typedef struct record_policydb_table {
+
+	/* Add record into the policy database */
+	int (*add) (sepol_policydb_t* policydb, record_t* record);
+
+	/* Modify record into the policy database */
+	int (*modify) (sepol_policydb_t* policydb, record_t* record);
+
+	/* Iterate over records */
+	int (*iterate) (
+		sepol_policydb_t* policydb,
+		int (*fn)(record_t* record, void* fn_arg),
+	void* arg);
+
+} record_policydb_table_t;
+
+/* Initialize database */
+extern int dbase_policydb_init(
+	const char* suffix,
+	record_table_t* rtable,
+	record_policydb_table_t* rptable,
+	dbase_policydb_t** dbase);
+
+/* Attach to a shared policydb.
+ * This implies drop_cache().
+ * and prevents flush() and drop_cache()
+ * until detached. */ 
+extern void dbase_policydb_attach(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase,
+	sepol_policydb_t* policydb);
+
+/* Detach from a shared policdb.
+ * This implies drop_cache. */
+extern void dbase_policydb_detach(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase);
+
+/* Release allocated resources */
+extern void dbase_policydb_release(
+	semanage_handle_t* handle,
+	dbase_policydb_t* dbase);
+
+/* POLICYDB database - method table implementation */
+extern dbase_table_t SEMANAGE_POLICYDB_DTABLE;
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2005-10-17 18:10:59.000000000 -0400
+++ new/libsemanage/src/direct_api.c	2005-10-17 20:42:35.000000000 -0400
@@ -33,11 +33,11 @@
 #include "ports_file.h"
 #include "interfaces_file.h"
 #include "booleans_file.h"
-#include "users_direct.h"
-#include "ports_direct.h"
+#include "users_policydb.h"
+#include "ports_policydb.h"
 #if 0
-#include "interfaces_direct.h"
-#include "booleans_direct.h"
+#include "interfaces_policydb.h"
+#include "booleans_policydb.h"
 #endif
 
 #include "debug.h"
@@ -107,16 +107,16 @@ int semanage_direct_connect(semanage_han
 	if (seuser_file_dbase_init(semanage_seuser_dbase(sh)) < 0)
 		goto err;
 
-	if (user_direct_dbase_init(semanage_user_dbase_policy(sh)) < 0)
+	if (user_policydb_dbase_init(semanage_user_dbase_policy(sh)) < 0)
 		goto err;
 
-	if (port_direct_dbase_init(semanage_port_dbase_policy(sh)) < 0)
+	if (port_policydb_dbase_init(semanage_port_dbase_policy(sh)) < 0)
 		goto err;
 #if 0
-	if (iface_direct_dbase_init(semanage_iface_dbase_policy(sh)) < 0)
+	if (iface_policydb_dbase_init(semanage_iface_dbase_policy(sh)) < 0)
 		goto err;
 
-	if (bool_direct_dbase_init(semanage_bool_dbase_policy(sh)) < 0)
+	if (bool_policydb_dbase_init(semanage_bool_dbase_policy(sh)) < 0)
 		goto err;
 #endif
 
@@ -153,11 +153,11 @@ static int semanage_direct_disconnect(se
 	bool_file_dbase_release(sh, semanage_bool_dbase(sh));
 	seuser_file_dbase_release(sh, semanage_seuser_dbase(sh));
 
-	user_direct_dbase_release(sh, semanage_user_dbase_policy(sh));
-	port_direct_dbase_release(sh, semanage_port_dbase_policy(sh));
+	user_policydb_dbase_release(sh, semanage_user_dbase_policy(sh));
+	port_policydb_dbase_release(sh, semanage_port_dbase_policy(sh));
 #if 0
-	iface_direct_dbase_release(sh, semanage_iface_dbase_policy(sh));
-	bool_direct_dbase_release(sh, semanage_port_dbase_policy(sh));
+	iface_policydb_dbase_release(sh, semanage_iface_dbase_policy(sh));
+	bool_policydb_dbase_release(sh, semanage_port_dbase_policy(sh));
 #endif
 
 	return 0;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/ports_direct.c new/libsemanage/src/ports_direct.c
--- old/libsemanage/src/ports_direct.c	2005-10-14 15:49:56.000000000 -0400
+++ new/libsemanage/src/ports_direct.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,50 +0,0 @@
-#include <sepol/port_record.h>
-
-typedef sepol_port_t record_t;
-typedef sepol_port_key_t record_key_t;
-#define DBASE_RECORD_DEFINED
-
-struct dbase_direct;
-typedef struct dbase_direct dbase_t;
-#define DBASE_DEFINED
-
-#include <stddef.h>
-#include <sepol/ports.h>
-#include <sepol/policydb.h>
-#include "ports_direct.h"
-#include "debug.h"
-#include "handle.h"
-#include "database_direct.h"
-#include "semanage_store.h"
-
-/* PORT RECORD (SEPOL): method table (ports_policy.c) */
-extern record_table_t SEPOL_PORT_RTABLE;
-
-/* PORT RECORD (SEPOL): POLICY DIRECT extension : method table */
-record_direct_table_t SEMANAGE_PORT_DIRECT_RTABLE = {
-	.add         = sepol_port_add,
-	.modify      = NULL, /* FIXME */
-	.iterate     = sepol_port_iterate,
-};
-
-int port_direct_dbase_init(
-	dbase_config_t* dconfig) {
-
-	if (dbase_direct_init(
-		"policy.kern",
-		&SEPOL_PORT_RTABLE,
-		&SEMANAGE_PORT_DIRECT_RTABLE, 
-		&dconfig->dbase) < 0) 
-		return STATUS_ERR;
-
-	dconfig->dtable = &SEMANAGE_DIRECT_DTABLE;
-
-	return STATUS_SUCCESS;
-}
-
-void port_direct_dbase_release(
-	semanage_handle_t* handle,
-	dbase_config_t* dconfig) {
-
-	dbase_direct_release(handle, dconfig->dbase);
-}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/ports_direct.h new/libsemanage/src/ports_direct.h
--- old/libsemanage/src/ports_direct.h	2005-10-14 15:49:56.000000000 -0400
+++ new/libsemanage/src/ports_direct.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,14 +0,0 @@
-#ifndef _SEMANAGE_PORTS_DIRECT_H_
-#define _SEMANAGE_PORTS_DIRECT_H_
-
-#include "database.h"
-#include "handle.h"
-
-int port_direct_dbase_init(
-	dbase_config_t* dconfig);
-
-void port_direct_dbase_release(
-	semanage_handle_t* handle,
-	dbase_config_t* dconfig);
-
-#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/ports_policydb.c new/libsemanage/src/ports_policydb.c
--- old/libsemanage/src/ports_policydb.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/ports_policydb.c	2005-10-17 20:38:37.000000000 -0400
@@ -0,0 +1,50 @@
+#include <sepol/port_record.h>
+
+typedef sepol_port_t record_t;
+typedef sepol_port_key_t record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_policydb;
+typedef struct dbase_policydb dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <sepol/ports.h>
+#include <sepol/policydb.h>
+#include "ports_policydb.h"
+#include "debug.h"
+#include "handle.h"
+#include "database_policydb.h"
+#include "semanage_store.h"
+
+/* PORT RECORD (SEPOL): method table (ports_policy.c) */
+extern record_table_t SEPOL_PORT_RTABLE;
+
+/* PORT RECORD (SEPOL): POLICYDB extension : method table */
+record_policydb_table_t SEMANAGE_PORT_POLICYDB_RTABLE = {
+	.add         = sepol_port_add,
+	.modify      = NULL, /* FIXME */
+	.iterate     = sepol_port_iterate,
+};
+
+int port_policydb_dbase_init(
+	dbase_config_t* dconfig) {
+
+	if (dbase_policydb_init(
+		"policy.kern",
+		&SEPOL_PORT_RTABLE,
+		&SEMANAGE_PORT_POLICYDB_RTABLE, 
+		&dconfig->dbase) < 0) 
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_POLICYDB_DTABLE;
+
+	return STATUS_SUCCESS;
+}
+
+void port_policydb_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig) {
+
+	dbase_policydb_release(handle, dconfig->dbase);
+}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/ports_policydb.h new/libsemanage/src/ports_policydb.h
--- old/libsemanage/src/ports_policydb.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/ports_policydb.h	2005-10-17 20:39:48.000000000 -0400
@@ -0,0 +1,14 @@
+#ifndef _SEMANAGE_PORTS_POLICYDB_INTERNAL_H_
+#define _SEMANAGE_PORTS_POLICYDB_INTERNAL_H_
+
+#include "database.h"
+#include "handle.h"
+
+int port_policydb_dbase_init(
+	dbase_config_t* dconfig);
+
+void port_policydb_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users_direct.c new/libsemanage/src/users_direct.c
--- old/libsemanage/src/users_direct.c	2005-10-14 15:49:56.000000000 -0400
+++ new/libsemanage/src/users_direct.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,49 +0,0 @@
-#include <sepol/user_record.h>
-
-typedef sepol_user_t record_t;
-typedef sepol_user_key_t record_key_t;
-#define DBASE_RECORD_DEFINED
-
-struct dbase_direct;
-typedef struct dbase_direct dbase_t;
-#define DBASE_DEFINED
-
-#include <stddef.h>
-#include <sepol/users.h>
-#include <sepol/policydb.h>
-#include "users_direct.h"
-#include "debug.h"
-#include "database_direct.h"
-#include "handle.h"
-#include "semanage_store.h"
-
-/* USER RECORD (SEPOL): method table (users_policy.c) */
-extern record_table_t SEPOL_USER_RTABLE;
-
-/* USER RECRORD (SEPOL): POLICY DIRECT extension: method table */
-record_direct_table_t SEMANAGE_USER_DIRECT_RTABLE = {
-	.add         = sepol_user_add,
-	.modify      = sepol_user_modify,
-	.iterate     = sepol_user_iterate,
-};
-
-int user_direct_dbase_init(
-	dbase_config_t* dconfig) {
-
-	if (dbase_direct_init(
-		"policy.kern",
-		&SEPOL_USER_RTABLE, 
-		&SEMANAGE_USER_DIRECT_RTABLE, 
-		&dconfig->dbase) < 0)
-		return STATUS_ERR;
-
-	dconfig->dtable = &SEMANAGE_DIRECT_DTABLE;
-	return STATUS_SUCCESS;
-}
-
-void user_direct_dbase_release(
-	semanage_handle_t* handle, 
-	dbase_config_t* dconfig) {
-
-	dbase_direct_release(handle, dconfig->dbase);
-}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users_direct.h new/libsemanage/src/users_direct.h
--- old/libsemanage/src/users_direct.h	2005-10-14 15:49:56.000000000 -0400
+++ new/libsemanage/src/users_direct.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,14 +0,0 @@
-#ifndef _SEMANAGE_USERS_DIRECT_H_
-#define _SEMANAGE_USERS_DIRECT_H_
-
-#include "database.h"
-#include "handle.h"
-
-int user_direct_dbase_init(
-	dbase_config_t* dconfig);
-
-void user_direct_dbase_release(
-	semanage_handle_t* handle,
-	dbase_config_t* dconfig);
-
-#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users_policydb.c new/libsemanage/src/users_policydb.c
--- old/libsemanage/src/users_policydb.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/users_policydb.c	2005-10-17 20:39:05.000000000 -0400
@@ -0,0 +1,49 @@
+#include <sepol/user_record.h>
+
+typedef sepol_user_t record_t;
+typedef sepol_user_key_t record_key_t;
+#define DBASE_RECORD_DEFINED
+
+struct dbase_policydb;
+typedef struct dbase_policydb dbase_t;
+#define DBASE_DEFINED
+
+#include <stddef.h>
+#include <sepol/users.h>
+#include <sepol/policydb.h>
+#include "users_policydb.h"
+#include "debug.h"
+#include "database_policydb.h"
+#include "handle.h"
+#include "semanage_store.h"
+
+/* USER RECORD (SEPOL): method table (users_policy.c) */
+extern record_table_t SEPOL_USER_RTABLE;
+
+/* USER RECRORD (SEPOL): POLICYDB extension: method table */
+record_policydb_table_t SEMANAGE_USER_POLICYDB_RTABLE = {
+	.add         = sepol_user_add,
+	.modify      = sepol_user_modify,
+	.iterate     = sepol_user_iterate,
+};
+
+int user_policydb_dbase_init(
+	dbase_config_t* dconfig) {
+
+	if (dbase_policydb_init(
+		"policy.kern",
+		&SEPOL_USER_RTABLE, 
+		&SEMANAGE_USER_POLICYDB_RTABLE, 
+		&dconfig->dbase) < 0)
+		return STATUS_ERR;
+
+	dconfig->dtable = &SEMANAGE_POLICYDB_DTABLE;
+	return STATUS_SUCCESS;
+}
+
+void user_policydb_dbase_release(
+	semanage_handle_t* handle, 
+	dbase_config_t* dconfig) {
+
+	dbase_policydb_release(handle, dconfig->dbase);
+}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users_policydb.h new/libsemanage/src/users_policydb.h
--- old/libsemanage/src/users_policydb.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/users_policydb.h	2005-10-17 20:39:29.000000000 -0400
@@ -0,0 +1,14 @@
+#ifndef _SEMANAGE_USERS_POLICYDB_INTERNAL_H_
+#define _SEMANAGE_USERS_POLICYDB_INTERNAL_H_
+
+#include "database.h"
+#include "handle.h"
+
+int user_policydb_dbase_init(
+	dbase_config_t* dconfig);
+
+void user_policydb_dbase_release(
+	semanage_handle_t* handle,
+	dbase_config_t* dconfig);
+
+#endif

--------------070305000709030906090009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
