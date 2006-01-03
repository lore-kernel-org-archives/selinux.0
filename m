Message-ID: <43BA6891.8090303@cornell.edu>
Date: Tue, 03 Jan 2006 07:05:37 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Improve dbase spec/documentaiton
Content-Type: multipart/mixed;
 boundary="------------080802000101000906030203"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080802000101000906030203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

... in order to prevent bugs like the one I just fixed in the previous 
patch.
Not sure whether there are also ways to enforce this via gcc.. const 
specifiers and things like that.



--------------080802000101000906030203
Content-Type: text/x-patch;
 name="libsemanage16.database_doc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage16.database_doc.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2005-12-23 01:51:54.000000000 -0500
+++ new/libsemanage/src/database.h	2006-01-03 06:59:35.000000000 -0500
@@ -61,9 +61,15 @@ typedef struct dbase_table {
 
 	/* --------------- Database Functionality ----------- */
 
+	/* Note: In all the functions below, the key is property
+	 * of the caller, and will not be modified by the database. */
+
 	/* Add the specified record to
 	 * the database if it is not present,
-	 * or fail if it already exists */
+	 * or fail if it already exists
+	 * 
+	 * Note: the <data> record becomes property of the 
+	 * database, and may not be further modified */
 	int (*add) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
@@ -72,7 +78,10 @@ typedef struct dbase_table {
 
 	/* Add the specified record to the  
 	 * database if it not present. 
-	 * If it's present, replace it */
+	 * If it's present, replace it
+	 * 
+	 * Note: The <data> record becomes property of the
+	 * database, and may not be further modified */
 	int (*modify) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
@@ -80,7 +89,10 @@ typedef struct dbase_table {
 		record_t* data);
 
 	/* Modify the specified record in the database
-	 * if it is present. Fail if it does not yet exist */
+	 * if it is present. Fail if it does not yet exist
+	 *
+	 * Note: The <data> record becomes property of the
+	 * database, and may not be further modified*/
 	int (*set) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
@@ -93,7 +105,12 @@ typedef struct dbase_table {
 		dbase_t* dbase,
 		record_key_t* key);
 
-	/* Retrieve a record */
+	/* Retrieve a record 
+	 * 
+	 * Note: the resultant record
+	 * becomes property of the caller, and
+	 * must be freed accordingly */
+
 	int (*query) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
@@ -117,7 +134,18 @@ typedef struct dbase_table {
 	 * the records of this database. The handler
 	 * can signal a successful exit by returning 1,
 	 * an error exit by returning -1, and continue by
-	 * returning 0 */
+	 * returning 0
+	 * 
+	 * Note: The record passed into the iterate handler
+	 * may or may not persist after the handler invocation,
+	 * and writing to it has unspecified behavior. It *must*
+	 * be cloned if modified, or preserved.
+	 * 
+	 * Note: The iterate handler may not invoke any other
+	 * semanage read functions outside a transaction. It is only
+	 * reentrant while in transaction. The iterate handler may
+	 * not modify the underlying database.
+	 */
 	int (*iterate) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
@@ -126,7 +154,11 @@ typedef struct dbase_table {
 			void* varg),
 		void* fn_arg);
 
-	/* Construct a list of all records in this database */
+	/* Construct a list of all records in this database
+	 * 
+	 * Note: The list returned becomes property of the caller,
+	 * and must be freed accordingly. 
+	 */
 	int (*list) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
@@ -136,9 +168,8 @@ typedef struct dbase_table {
 	/* ---------- Cache/Transaction Management ---------- */
 
 	/* Cache the database (if supported).
- 	 * Invoke this function before looking at
-	 * any data, since the database may require 
-	 * cached content */
+	 * This function must be invoked before using
+	 * any of the database functions above */
 	int (*cache) (
 		struct semanage_handle* handle,
 		dbase_t* dbase);
@@ -148,7 +179,7 @@ typedef struct dbase_table {
 	void (*drop_cache) (
 		dbase_t* dbase);
 
-	/* Checks if there are pending changes */
+	/* Checks if there are any changes not written to the backend */
 	int (*is_modified) (
 		dbase_t* dbase);
 
@@ -159,7 +190,6 @@ typedef struct dbase_table {
 
 	/* ------------- Polymorphism ----------------------- */
 
-
 	/* Retrieves the record table for this database,
 	 * which specifies how to perform basic operations
 	 * on each record. */

--------------080802000101000906030203--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
