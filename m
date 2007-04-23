Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OIUXSL001614
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 14:30:33 -0400
Received: from scarecrow.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OIUVJc002834
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 18:30:31 GMT
Message-Id: <20070423213730.024871000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Date: Mon, 23 Apr 2007 17:35:05 -0400
From: jbrindle@tresys.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 10/33] libsemanage: database serialization
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds serialize/unserialize methods for databases

---
 libsemanage/src/database.c          |  153 ++++++++++++++++++++++++++++++++++++
 libsemanage/src/database.h          |   21 ++++
 libsemanage/src/database_policydb.c |   10 ++
 3 files changed, 184 insertions(+)

Index: selinux-pms-support/libsemanage/src/database.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database.c
+++ selinux-pms-support/libsemanage/src/database.c
@@ -20,6 +20,8 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <limits.h>
+#include <stdlib.h>
 #include <semanage/handle.h>
 #include "semanage_store.h"
 #include "semanage_conf.h"
@@ -219,3 +221,154 @@ int dbase_list(semanage_handle_t * handl
 
 	return exit_ro(handle, dconfig);
 }
+
+/* Serialize the given database. */
+int dbase_serialize(struct semanage_handle *handle,
+		    dbase_config_t * dconfig,
+		    char **data, uint64_t * data_length)
+{
+	int status = 0;
+	unsigned int count = 0;
+	unsigned int completed_count = 0;
+	unsigned int i = 0;
+	uint64_t size = 0;
+	char *ptr = NULL;
+	record_t **records = NULL;
+
+	status = enter_ro(handle, dconfig);
+	if (status != STATUS_SUCCESS)
+		goto err;
+
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+
+	/* Initialize */
+	*data = NULL;
+	*data_length = 0;
+
+	/* Get a list of the records. */
+	status = dconfig->dtable->list(handle, dconfig, &records, &count);
+	if (status != STATUS_SUCCESS)
+		goto err;
+
+	/* Iterate over all records and calculate
+	 * the size of the serialized data. */
+	for (i = 0; i < count; i++) {
+		status = rtable->serialize(handle, records[i], NULL, &size);
+		if (status != STATUS_SUCCESS) {
+			completed_count = i - 1;
+			goto err;
+		}
+	}
+
+	*data_length = size;
+
+	/* Allocate space for the serialized data. */
+	*data = calloc((size_t) size, sizeof(char));
+	if (data == NULL)
+		goto err;
+
+	/* Iterate over all records and serialize them. */
+	ptr = *data;
+	completed_count = 0;
+	for (i = 0; i < count; i++) {
+		status = rtable->serialize(handle, records[i], &ptr, NULL);
+		if (status != STATUS_SUCCESS) {
+			completed_count = i - 1;
+			goto err;
+		}
+	}
+
+	/* Clean up. */
+	for (i = 0; i < count; i++)
+		rtable->free(records[i]);
+	free(records);
+
+	if (exit_ro(handle, dconfig) < 0)
+		goto err;
+
+	return STATUS_SUCCESS;
+
+      err:
+	if (records) {
+		for (i = 0; i < completed_count; i++)
+			rtable->free(records[i]);
+	}
+	free(records);
+	free(*data);
+	*data = NULL;
+	*data_length = 0;
+
+	exit_ro(handle, dconfig);
+
+	return STATUS_ERR;
+}
+
+/* Unserialize the given database.
+ * This function DOES move the data pointer passed in.
+ */
+int dbase_unserialize(struct semanage_handle *handle,
+		      dbase_config_t * dconfig,
+		      char *data, uint64_t data_length)
+{
+	int status = 0;
+	char *ptr = data;
+	uint64_t current_length = data_length;
+	record_t *record = NULL;
+	record_key_t *key = NULL;
+	record_table_t *rtable = dconfig->dtable->get_rtable(dconfig);
+	unsigned int write = 0;
+
+	if ((data == NULL) || (data_length == 0)) {
+		status = dconfig->dtable->clear(handle, dconfig);
+		if (status < 0)
+			goto err;
+		return STATUS_SUCCESS;
+	}
+
+	/* Iterate over the serialized records, adding them
+	 * to the database one by one. */
+	while (current_length > 0) {
+		status =
+		    rtable->unserialize(handle, &ptr, &current_length, &record);
+		if (status != STATUS_SUCCESS)
+			goto err;
+
+		status = rtable->key_extract(handle, record, &key);
+		if (status != STATUS_SUCCESS)
+			goto err;
+
+		if (write == 1) {
+			status = dconfig->dtable->add(handle, dconfig, key, record);
+			if (status != STATUS_SUCCESS)
+				goto err;
+		}
+
+		rtable->key_free(key);
+		key = NULL;
+		rtable->free(record);
+		record = NULL;
+
+		if (current_length == 0 && write == 0) {
+			/* Remove all current entries to the database. */
+			status = dconfig->dtable->clear(handle, dconfig);
+			if (status < 0)
+				goto err;
+
+			/* Rerun and actually add the entries. */
+			write = 1;
+			ptr = data;
+			current_length = data_length;
+		}
+	}
+	/* Unserializing should move the pointer passed in */
+	data = ptr;
+
+	return STATUS_SUCCESS;
+
+err:
+	rtable->key_free(key);
+	key = NULL;
+	rtable->free(record);
+	record = NULL;
+	return STATUS_ERR;
+}
Index: selinux-pms-support/libsemanage/src/database.h
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database.h
+++ selinux-pms-support/libsemanage/src/database.h
@@ -23,6 +23,8 @@
 #ifndef _SEMANAGE_DATABASE_H_
 #define _SEMANAGE_DATABASE_H_
 
+#include <inttypes.h>
+
 #ifndef DBASE_RECORD_DEFINED
 typedef void *record_t;
 typedef void *record_key_t;
@@ -70,6 +72,17 @@ typedef struct record_table {
 	int (*clone) (struct semanage_handle * handle,
 		      const record_t * rec, record_t ** new_rec);
 
+	/* Serialize this record.  rec_data must be allocated
+	 * and large enough to hold the result. */
+	int (*serialize) (struct semanage_handle * handle,
+			  const record_t * rec,
+			  char **rec_data, uint64_t * size);
+
+	/* Unserialize this record data */
+	int (*unserialize) (struct semanage_handle * handle,
+					char **rec_data, uint64_t * size,
+			    record_t ** rec);
+
 	/* Deallocate record resources. Must sucessfully handle NULL. */
 	void (*free) (record_t * rec);
 
@@ -241,4 +254,12 @@ extern int dbase_list(struct semanage_ha
 		      dbase_config_t * dconfig,
 		      record_t *** records, unsigned int *count);
 
+extern int dbase_serialize(struct semanage_handle *handle,
+			   dbase_config_t * dconfig,
+			   char **data, uint64_t * data_length);
+
+extern int dbase_unserialize(struct semanage_handle *handle,
+			     dbase_config_t * dconfig,
+			     char *data, uint64_t data_length);
+
 #endif
Index: selinux-pms-support/libsemanage/src/database_policydb.c
===================================================================
--- selinux-pms-support.orig/libsemanage/src/database_policydb.c
+++ selinux-pms-support/libsemanage/src/database_policydb.c
@@ -21,6 +21,7 @@
  */
 
 /* Object: dbase_policydb_t (Policy)
+ * Extends: dbase_llist_t (Linked List)
  * Implements: dbase_t (Database)
  */
 
@@ -38,6 +39,7 @@ typedef struct dbase_policydb dbase_t;
 #include <sepol/policydb.h>
 
 #include "database_policydb.h"
+#include "database_llist.h"
 #include "semanage_store.h"
 #include "handle.h"
 #include "debug.h"
@@ -45,6 +47,11 @@ typedef struct dbase_policydb dbase_t;
 /* POLICYDB dbase */
 struct dbase_policydb {
 
+	/* Parent object - must always be
+	 * the first field - here we are using
+	 * a linked list to store the records */
+	dbase_llist_t llist;
+
 	/* Backing file suffix */
 	const char *suffix;
 
@@ -65,6 +72,7 @@ void dbase_policydb_drop_cache(dbase_t *
 {
 
 	if (dbase->cache_serial >= 0) {
+		dbase_llist_drop_cache(&dbase->llist);
 		sepol_policydb_free(dbase->policydb);
 		dbase->cache_serial = -1;
 		dbase->modified = 0;
@@ -242,6 +250,8 @@ int dbase_policydb_init(semanage_handle_
 	tmp_dbase->cache_serial = -1;
 	tmp_dbase->modified = 0;
 	tmp_dbase->attached = 0;
+
+	dbase_llist_init(&tmp_dbase->llist, rtable);
 	*dbase = tmp_dbase;
 
 	return STATUS_SUCCESS;

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
