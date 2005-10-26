Message-ID: <435F02AD.1000309@cornell.edu>
Date: Wed, 26 Oct 2005 00:14:37 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [ SEMANAGE 3 ] Simplify and fix dbase_policydb_cache
Content-Type: multipart/mixed;
 boundary="------------030302000703090001020104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030302000703090001020104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:

- simplifies dbase_policydb_cache to use pf and sepol_policydb_read
- fix incorrect free in that function (should be sepol_policydb_free)
- correctly treat ENOENT by creating an empty policydb (bootstrap 
policy.kern, as advised by Joshua).
- drop a whole bunch of imports that no longer seem necessary

Tested this...seems to work.


--------------030302000703090001020104
Content-Type: text/x-patch;
 name="libsemanage.policydb_cache.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.policydb_cache.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsemanage/src/database_policydb.c new/libsemanage/src/database_policydb.c
--- old/libsemanage/src/database_policydb.c	2005-10-25 20:17:53.000000000 -0400
+++ new/libsemanage/src/database_policydb.c	2005-10-26 00:07:17.000000000 -0400
@@ -5,14 +5,10 @@ typedef struct dbase_policydb dbase_t;
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
 #include <errno.h>
-#include <unistd.h>
-#include <string.h>
+
 #include <sepol/policydb.h>
+
 #include "database_policydb.h"
 #include "semanage_store.h"
 #include "handle.h"
@@ -61,11 +57,9 @@ static int dbase_policydb_cache(
 	semanage_handle_t* handle,
 	dbase_policydb_t* dbase) {
 
-	int fd = -1;
-	struct stat sb;
-	void* data = NULL;
+	FILE* fp = NULL;
 	sepol_policydb_t* policydb = NULL;
-
+	sepol_policy_file_t* pf = NULL;
 	char* fname = NULL;
 
 	/* Already cached */
@@ -75,52 +69,51 @@ static int dbase_policydb_cache(
 	if (construct_filename(handle, dbase, &fname) < 0) 
 		goto err;
 
-	/* Open file */
-	fd = open(fname, O_RDONLY);
-	if (fd < 0) {
-		ERR(handle, "could not open %s for reading: %s",
-			fname, strerror(errno));
+	if (sepol_policydb_create(&policydb) < 0) {
+		ERR(handle, "could not create policydb object");
 		goto err;
 	}
 
-	/* Stat */
-	if (fstat(fd, &sb) < 0) {
-		ERR(handle, "could not stat %s: %s",
+	/* Try opening file 
+	 * ENOENT is not fatal - we just create an empty policydb */
+	fp = fopen(fname, "rb");
+	if (fp == NULL && errno != ENOENT) {
+		ERR(handle, "could not open %s for reading: %s",
 			fname, strerror(errno));
 		goto err;
 	}
+	
+	/* If the file was opened successfully, read a policydb */
+	if (fp != NULL) {
+		if (sepol_policy_file_create(&pf) < 0) {
+			ERR(handle, "could not create policy file object");
+			goto err;
+		}
 
-	/* Map file */
-	data = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	if (data == MAP_FAILED) {
-		ERR(handle, "could not map policy: %s", strerror(errno));
-		goto err;
-        }
+		sepol_policy_file_set_fp(pf, fp);
+		sepol_policy_file_set_handle(pf, handle->sepolh);
 
-	/* Create policydb image */
-	if (sepol_policydb_create(&policydb))
-		goto omem;
-	if (sepol_policydb_from_image(handle->sepolh, data, sb.st_size, policydb) < 0)
-		goto err;
+		if (sepol_policydb_read(policydb, pf) < 0)
+			goto err;
+
+		sepol_policy_file_free(pf);
+		fclose(fp);
+	}
+
+	/* Either way, update the database policydb */	
 	dbase->policydb = policydb;
 
-	close(fd);
-	munmap(data, sb.st_size);
 	free(fname);
 	dbase->cached = 1;
 	return STATUS_SUCCESS;
 	
-	omem:
-	ERR(handle, "out of memory");
-	
 	err:
 	ERR(handle, "unable to cache policy database from %s", fname);
-	if (fd > 0)
-		close(fd);
-	if (data != NULL)
-		munmap(data, sb.st_size);
-	
-	free(policydb);
+
+	if (fp)
+		fclose(fp);
+	sepol_policydb_free(policydb);
+	sepol_policy_file_free(pf);
 	free(fname);
 	return STATUS_ERR;
 

--------------030302000703090001020104--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
