Message-ID: <432CC1A1.2090503@cornell.edu>
Date: Sat, 17 Sep 2005 21:23:45 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: dwalsh@redhat.com
Subject: [ SEMANAGE ] Stub iterate
Content-Type: multipart/mixed;
 boundary="------------080901010709050708080504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080901010709050708080504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch adds the file iterator config structure, and stubs 
iterate().
I actually have a lot of code written, but I can't merge any of it 
before figuring out
what to do with respect to debugging.

Anyway, in the mean time I can stub things out, and describe design.

The dbase_* functions will each fill out the iterator structure,
and invoke iterate(). On a different backend, those functions
wouldn't iterate, but would perform O(1) operations. The add()
function doesn't actually need to iterate - I have an alternative
implementation which seeks to the end of file, but it is not atomic.
I haven't decided which to use - given the sandbox, the non-atomic
implementation might be preferable.

The flat file engine will work by iterating over "records".
Those records are each described by the record table merged last week.
In particular, the table describes how to input (parse) and output (print)
such records. That's how we keep the engine generic by polymorphism.

The iterator will parse each record using the provided function.
It will then pass this record to a processing handler function, which can do
whatever it wants with it, and can send back signals to communicate with
the engine. Do not confuse this processing function with the one
supplied in dbase_iterate - the engine handler has specialized format
and return codes, and I'll be providing those.
 
If config->modify is set to true, a second file is opened, and
each record is printed to it as the original file is parsed. On SIGDEL,
the record is skipped. On SIGADD, the engine reads a feedback record
from the processing handler, and writes that out.  On SIGEXIT or SIGERR
processing is terminated with the appropriate status code (it has to be 
explicit,
otherwise it keeps calling the handler with NULL argument). On SIGOK,
processing continues. If config->merr_fatal is on, and SIGMATCH
was never received by the engine, an error is reported.



--------------080901010709050708080504
Content-Type: text/x-patch;
 name="libsemanage.iterate.stub.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.iterate.stub.diff"

diff -Nrua libsemanage/src/database_file.c libsemanage.new/src/database_file.c
--- libsemanage/src/database_file.c	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage.new/src/database_file.c	2005-09-17 21:00:24.000000000 -0400
@@ -41,8 +41,10 @@
 	record_key_t key,
 	record_t data) {
 
+	iterate_config_t config;
+	config.rtable = dconfig->rtable;
+
 	/* Stub */
-	dconfig = NULL;
 	key = NULL;
 	data = NULL;
 	return -1;
@@ -53,8 +55,10 @@
 	record_key_t key,
 	record_t data) {
 
+	iterate_config_t config;
+	config.rtable = dconfig->rtable;
+
 	/* Stub */
-	dconfig = NULL;
 	key = NULL;
 	data = NULL;
 	return -1;
@@ -63,9 +67,11 @@
 int dbase_del(
 	dbase_config_t* dconfig,
 	record_key_t key) {
+
+	iterate_config_t config;
+	config.rtable = dconfig->rtable;
 	
 	/* Stub */
-	dconfig = NULL;
 	key = NULL;
 	return -1;
 }
@@ -74,9 +80,11 @@
 	dbase_config_t* dconfig,
 	record_key_t key,
 	record_t* response) {
+
+	iterate_config_t config;
+	config.rtable = dconfig->rtable;
 	
 	/* Stub */
-	dconfig = NULL;
 	key = NULL;
 	response = NULL;
 	return -1;
@@ -86,9 +94,11 @@
 	dbase_config_t* dconfig,
 	record_key_t key,
 	int* response) {
+
+	iterate_config_t config;
+	config.rtable = dconfig->rtable;
 	
 	/* Stub */
-	dconfig = NULL;
 	key = NULL;
 	response = NULL;
 	return -1;
@@ -98,8 +108,10 @@
 	dbase_config_t* dconfig,
 	int* response) {
 	
+	iterate_config_t config;
+	config.rtable = dconfig->rtable;
+
 	/* Stub */
-	dconfig = NULL;
 	response = NULL;
 	return -1;
 }
@@ -111,8 +123,10 @@
 	                void* varg),
 	void* handler_arg) {
 
+	iterate_config_t config;
+	config.rtable = dconfig->rtable;
+
 	/* Stub */
-	dconfig = NULL;
 	handler = NULL;
 	handler_arg = NULL;
 	return -1;
@@ -124,9 +138,10 @@
 	record_t** dataset,	
 	size_t* count) {
 
-	
+	iterate_config_t config;
+	config.rtable = dconfig->rtable;
+
 	/* Stub */
-	dconfig = NULL;
 	keyset = NULL;
 	dataset = NULL;
 	count = NULL;
diff -Nrua libsemanage/src/record_file.c libsemanage.new/src/record_file.c
--- libsemanage/src/record_file.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/record_file.c	2005-09-17 20:50:42.000000000 -0400
@@ -0,0 +1,8 @@
+#include "record_file.h"
+
+int record_iterate_file(iterate_config_t* config) {
+
+	/* Stub */
+	config = NULL;
+	return 0;
+}
diff -Nrua libsemanage/src/record_file.h libsemanage.new/src/record_file.h
--- libsemanage/src/record_file.h	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage.new/src/record_file.h	2005-09-17 20:50:46.000000000 -0400
@@ -9,6 +9,14 @@
 #define RECORD_DEFINED
 #endif
 
+/* Signals available to handlers during processing. */
+#define RECORD_HANDLER_SIGOK    0x00000001 /* Continue */
+#define RECORD_HANDLER_SIGERR   0x00000002 /* Exit with error */
+#define RECORD_HANDLER_SIGMATCH 0x00000004 /* Match is found */
+#define RECORD_HANDLER_SIGDEL   0x00000008 /* Delete current record */
+#define RECORD_HANDLER_SIGADD   0x00000010 /* Add feedback record */
+#define RECORD_HANDLER_SIGEXIT  0x00000020 /* Exit successfully */
+
 /* Structure available during parsing (created internally) */
 typedef struct parse_info {
 	/* Stub */	
@@ -44,4 +52,33 @@
 	void (*free) (record_t rec);
 } record_table_t;
 
+/* Structure to configure iterate */
+typedef struct iterate_config {
+
+	/* What and How? */
+	const char* filename;            /* Filename to process */
+	record_table_t* rtable;		 /* Table that describes how to do that */
+
+	/* Parsing stage */
+	void* parse_arg;                 /* Argument to pass to parser */
+	int perr_fatal;                  /* Is parse error fatal ? */
+
+	/* Processing stage */
+	int (*handler) (                  /* Processing handler */
+		record_t process_record,      /* Current record, or NULL */
+		record_t* feedback_record,    /* Record for SIGADD */
+		void* arg);                   /* Caller supplied argument */
+	void* handler_arg;                /* Argument to pass to handler */
+	int modify;                       /* Will the handler issue 
+					   * modification signals */
+	/* Post-processing */
+	int merr_fatal;                   /* Is lack of SIGMATCH fatal? */
+} iterate_config_t;
+
+/*
+ * Iterate over all records in the given file,
+ * subject to the provided parse and processing config.
+ */
+extern int record_iterate_file(iterate_config_t* config);
+
 #endif 

--------------080901010709050708080504--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
