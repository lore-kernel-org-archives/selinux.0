Message-ID: <4356F1B3.3060000@cornell.edu>
Date: Wed, 19 Oct 2005 21:24:03 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] More work on policy_components.c
Content-Type: multipart/mixed;
 boundary="------------020705090104080606060705"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020705090104080606060705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch makes the commit function shorter, and more intelligent, and 
implements a lot more of the "merge into base" function (but not all of 
it). It also adds comments in database.h about the behavior of the 
add(), modify(), and iterate() functions.

Note how I can loop over the components, and not care about the details 
(what's being loaded, what backend is it coming from, or going to).  
That's why I can implement one load handler, and not 5 of them 
(multiplied by the number of source and target backends). So, despite 
what Tresys says, I think I'll keep my method tables around, since I 
like them very much - oop is your friend.

Note the FIXME on the key that's supposed to be passed into modify - 
that indicates an interface flaw. I could easily hardcode the right 
key_extract function into the load_table...but I shouldn't have to do 
this. What really needs to be done is to add a function into the 
database interface that allows me to retrieve the record table that the 
database is using. Since I'm not sure what I'll do about keys, leave 
this out for now - I'll get back to it a bit later.

Once this detail is fixed, I can add attach/detach calls in commit for 
the policydb database(s), and this whole system should (in theory) work 
(minus the functions that are stubbed, or unimplemented). Of course, 
after that I'd need to carefully test it..


--------------020705090104080606060705
Content-Type: text/x-patch;
 name="libsemanage.dbase_components.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.dbase_components.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2005-10-06 15:22:48.000000000 -0400
+++ new/libsemanage/src/database.h	2005-10-19 21:00:36.000000000 -0400
@@ -45,12 +45,20 @@ typedef struct record_table {
 /* DBASE interface - method table */
 typedef struct dbase_table {
 
+	/* Add the specified record to
+	 * the database if it is not present,
+	 * or fail if it already exists */
+
 	int (*add) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
 		record_key_t* key,
 		record_t* data);
 
+	/* Add the specified record to the  
+	 * database if it not present. 
+	 * If it's present, replace it */
+
 	int (*modify) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
@@ -79,6 +87,12 @@ typedef struct dbase_table {
 		dbase_t* dbase,
 		int* response);
 
+	/* Execute the specified handler over 
+	 * the records of this database. The handler
+	 * can signal a successful exit by returning 1,
+	 * an error exit by returning -1, and continue by
+	 * returning 0 */
+
 	int (*iterate) (
 		struct semanage_handle* handle,
 		dbase_t* dbase,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-10-19 20:07:11.000000000 -0400
+++ new/libsemanage/src/policy_components.c	2005-10-19 20:54:20.000000000 -0400
@@ -4,85 +4,128 @@
 #include "modules.h"
 #include "debug.h"
 
-int semanage_base_merge_components(
-	semanage_handle_t* handle) {
-
-	//dbase_config_t* modules = dbase_modules_dbase(handle);
-	dbase_config_t* interfaces = semanage_iface_dbase_local(handle);
-	dbase_config_t* booleans = semanage_bool_dbase_local(handle);
-	dbase_config_t* users = semanage_user_dbase_local(handle);
-	dbase_config_t* ports = semanage_port_dbase_local(handle);
+#define MODE_SET    1
+#define MODE_MODIFY 2
 
+typedef struct load_handler_arg {
+	semanage_handle_t* handle;
+	dbase_config_t* dconfig;
+	int mode; 
+} load_handler_arg_t;
+
+static int load_handler(
+	record_t* record,
+	void* varg) {
+
+	load_handler_arg_t* arg = 
+		(load_handler_arg_t*) varg;
+
+	semanage_handle_t* handle = arg->handle;
+	dbase_t* dbase = arg->dconfig->dbase;
+	dbase_table_t* dtable = arg->dconfig->dtable;
+
+	switch (arg->mode) {
+		
+		case MODE_SET:
 #if 0
-	if (modules->dtable->iterate(handle,
-		modules->dbase, NULL, NULL, /* FIXME */) < 0)
-		goto err;	
+			if (dtable->set(handle, dtable,
+				NULL, /* FIXME: KEY */, record) < 0)
+				goto err;
 #endif
+			break;
+		
+		default:
+		case MODE_MODIFY:
+			if (dtable->modify(handle, dbase,
+				NULL, /* FIXME: KEY */ record) < 0)
+				goto err;
+			break;
 
-	if (interfaces->dtable->iterate(handle,
-		interfaces->dbase, NULL, NULL /* FIXME */) < 0)
-		goto err;
-
-	if (booleans->dtable->iterate(handle,
-		booleans->dbase, NULL, NULL /* FIXME */) < 0)
-		goto err;
-
-	if (users->dtable->iterate(handle, 
-		users->dbase, NULL, NULL /* FIXME */) < 0)
-		goto err;
-
-	if (ports->dtable->iterate(handle, 
-		ports->dbase, NULL, NULL /* FIXME */) < 0)
-		goto err;
-
-	return STATUS_SUCCESS;
+	}
+	return 0;
 
 	err:
 	/* FIXME: handle error */
-	return STATUS_SUCCESS;
+	return -1;
 }
 
-int semanage_commit_components(
+
+typedef struct load_table {
+	dbase_config_t* from;
+	dbase_config_t* to;
+	int mode;
+} load_table_t;
+
+int semanage_base_merge_components(
 	semanage_handle_t* handle) {
 
-	//dbase_config_t* modules = semanage_modules_dbase(handle);
-	dbase_config_t* interfaces = semanage_iface_dbase_local(handle);
-	dbase_config_t* booleans = semanage_bool_dbase_local(handle);
-	dbase_config_t* users = semanage_user_dbase_local(handle);
-	dbase_config_t* ports = semanage_port_dbase_local(handle);
-	dbase_config_t* seusers = semanage_seuser_dbase(handle);
+	int i;
+	const int CCOUNT = 4;
+	load_table_t components[4] = {
 
-#if 0
-        if (modules->dtable->flush(handle, modules->dbase) < 0)
-                goto err;
-#endif
+		/* FIXME: modules */
 
-        if (interfaces->dtable->flush(handle, interfaces->dbase) < 0)
-                goto err;
+		{ semanage_user_dbase_local(handle),
+		  semanage_user_dbase_policy(handle), MODE_MODIFY },
 
-        if (booleans->dtable->flush(handle, booleans->dbase) < 0)
-                goto err;
+		{ semanage_port_dbase_local(handle),
+		  semanage_port_dbase_policy(handle), MODE_MODIFY },
 
-	if (users->dtable->flush(handle, users->dbase) < 0) 
-		goto err;
+		{ semanage_iface_dbase_local(handle),
+		  semanage_iface_dbase_policy(handle), MODE_MODIFY },
+	
+		{ semanage_bool_dbase_local(handle),
+		  semanage_bool_dbase_policy(handle), MODE_SET },
+	};
+
+	load_handler_arg_t load_arg;
+	load_arg.handle = handle;
+
+	for (i = 0; i < CCOUNT; i++) {
+		dbase_config_t* from = components[i].from;
+		load_arg.dconfig = components[i].to;
+		load_arg.mode   = components[i].mode;
+
+		if (from->dtable->iterate(
+			handle, from->dbase, load_handler, &load_arg) < 0)
+			goto err;
+					
+	}	
 	
-	if (ports->dtable->flush(handle, ports->dbase) < 0) 
-		goto err;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+}
 
-	if (seusers->dtable->flush(handle,  seusers->dbase) < 0)
-		goto err;
+int semanage_commit_components(
+	semanage_handle_t* handle) {
+
+	int i;
+	const int CCOUNT = 5;
+	dbase_config_t* components[5] = {
+		/* semanage_modules_dbase(handle), */
+		semanage_iface_dbase_local(handle),
+		semanage_bool_dbase_local(handle),
+		semanage_user_dbase_local(handle),
+		semanage_port_dbase_local(handle),
+		semanage_seuser_dbase(handle)
+	};
+
+	for (i = 0; i < CCOUNT; i++) {
+		if (components[i]->dtable->flush(
+			handle, components[i]->dbase) < 0)
+			goto err;		 
+	}
 
 	return STATUS_SUCCESS;
 
 	err:
 	/* FIXME: handle error */
-#if 0
-	modules->dtable->drop_cache(handle, modules->dbase);
-#endif
-	interfaces->dtable->drop_cache(handle, interfaces->dbase);
-	booleans->dtable->drop_cache(handle, booleans->dbase);
-	users->dtable->drop_cache(handle, users->dbase);
-	ports->dtable->drop_cache(handle, ports->dbase);
-	seusers->dtable->drop_cache(handle, seusers->dbase);
+
+	for (i=0; i < CCOUNT; i++) 
+		components[i]->dtable->drop_cache(
+			handle, components[i]->dbase);
 	return STATUS_ERR;
 }

--------------020705090104080606060705--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
