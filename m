Message-ID: <4350E962.5080606@cornell.edu>
Date: Sat, 15 Oct 2005 07:34:58 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Karl MacMillan <kmacmillan@tresys.com>,
   Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Add a few direct dbases to handle
References: <434FF612.8010708@cornell.edu> <4350131E.8060708@tresys.com> <435017B2.7040107@cornell.edu> <435018F7.6070706@cornell.edu> <4350177F.7010600@tresys.com> <43501C38.5040907@cornell.edu> <43501DD9.4010803@tresys.com> <435025EB.2060203@cornell.edu>
In-Reply-To: <435025EB.2060203@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------010103040202040408000703"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010103040202040408000703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>
>>>>>
>>>>> In fact, I want to convert your modules functions into a database 
>>>>> too, but
>>>>> I haven't gotten to it yet, and this isn't high priority.
>>>>>
>>>> Why? This doesn't solve any problem.
>>>
>>> For consistency, if nothing else... I think there are benefits to 
>>> hiding data collections under a uniform interface, but I don't want 
>>> to get into that right now - I sent Karl a long email some time ago. 
>>> I know he's not convinced, but it's just my pet project.
>>>
>> this is a library being used by many people, I don't know that adding 
>> things for the sake of adding them is appropriate.
> I don't waste my time adding things "for the sake of adding them". I 
> try to design things so that they are extensible. For example, one 
> concrete reason why I want to see the modules look like a database, is 
> that the dbase interface has more functions than you currently 
> provide, and provides better encapsulation. I think that having a 
> similar modules interface could be beneficial.

I don't understand why you don't see how this is useful. It separates 
backend logic from record logic, which is a good idea, because it makes 
the code clearer to understand - right now your backend logic is mixed 
with your record logic. Separation would also allow you to write 
backend-independent record code, and record-independent backend code. 
You don't have this right now - you have an interface of function 
pointers, but any code you implement has to be record-aware, and 
backend-aware. That's why Karl says "there's very little shared code". 
There could be more shared code, if you would allow for better 
abstractions, but you're dead set against those, for reasons I don't 
understand.

By "backend-independent record code" I mean, being able to add a user, 
and not care where the user is stored.. being able to loop over the 
seuser mappings, and not care whether the data is coming from LDAP or 
the seusers file, because all I want to do is load it into policy. In 
the particular case of modules, I should be able to loop over all 
modules, and, say, search for a particular symbol... or do search and 
replace (if you'll allow modifications), or... list all the modules. I 
should be able to do this without caring how the module is stored - 
whether it's on a policy server, or whatever... You could achieve this 
with the proper interface, but if your code is modeled that way 
internally, then you can also share implementation of higher-level 
algorithms.

By "record-independent backend code" I mean, things that are specific to 
the way a backend stores records, regardless of what kind of records 
they are. For example, all my flat files are handled the same way - loop 
over the file, read the records into a cache, operate, write the file 
out. If I want to change the format of the cache, or encrypt files, or 
do some sort of permission checks, or ... something.. I could wirte this 
code once, instead of per record. In the case of modules, I could use 
the "directory" backend for other purposes.... if I add  a directory 
with some other kind of files tomorrow... maybe I can add a "file" 
database for each file in the directory, and implement a shared flush() 
method, that writes changes to each individual file that was modified 
(regardless of what's in the file, or how it's stored - I don't care - 
that's what the file database hides). So, I could say: flush all changes 
in this directory to disk on event x-y-z, regardless of what's in there, 
or how it's distributed...

Here's a bunch of stubs that I wrote just now - they don't add anything 
right now, but they could become useful in the future, if this is done 
properly. I think it's a worthy goal to move towards a more object-based 
code, whether this is written in C or not.


--------------010103040202040408000703
Content-Type: text/x-patch;
 name="libsemanage.modules.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.modules.diff"

diff -Naur --exclude ChangeLog --exclude VERSION --exclude CVS libsemanage/include/semanage/module_record.h libsemanage.new/include/semanage/module_record.h
--- libsemanage/include/semanage/module_record.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/include/semanage/module_record.h	2005-10-15 06:42:12.000000000 -0400
@@ -0,0 +1,63 @@
+#ifndef _SEMANAGE_MODULE_RECORD_H_
+#define _SEMANAGE_MODULE_RECORD_H_
+
+#include <semanage/handle.h>
+
+struct semanage_module;
+struct semanage_module_key;
+typedef struct semanage_module semanage_module_t;
+typedef struct semanage_module_key semanage_module_key_t;
+
+/* Key */
+extern int semanage_module_key_create(
+	semanage_handle_t* handle,
+	const char* name, 
+	semanage_module_key_t** key);
+
+extern int semanage_module_key_extract(
+	semanage_handle_t* handle,
+	semanage_module_t* module, 
+	semanage_module_key_t** key);
+
+extern void semanage_module_key_free(
+	semanage_module_key_t* key);
+
+extern int semanage_module_compare(
+	semanage_module_t* module, 
+	semanage_module_key_t* key);
+	
+/* Name */
+#if 0 /* FIXME: conflict with modules.h */
+extern const char* semanage_module_get_name(
+	semanage_module_t* module);
+
+extern int semanage_module_set_name(
+	semanage_handle_t* handle,
+	semanage_module_t* module, 
+	const char* name);
+
+/* Module Version */
+extern const char* semanage_module_get_version(
+	semanage_module_t* module);
+
+extern int semanage_module_set_version(
+	semanage_handle_t* handle,
+	semanage_module_t* module,
+	const char* version);
+#endif
+
+/* FIXME: Add data fields here */
+
+/* Create/Clone/Destroy */
+extern int semanage_module_create(
+	semanage_handle_t* handle,
+	semanage_module_t** module_ptr);
+
+extern int semanage_module_clone(
+	semanage_handle_t* handle,
+	semanage_module_t* module, 
+	semanage_module_t** module_ptr);
+
+extern void semanage_module_free(
+	semanage_module_t* module);
+#endif
diff -Naur --exclude ChangeLog --exclude VERSION --exclude CVS libsemanage/include/semanage/seuser_record.h libsemanage.new/include/semanage/seuser_record.h
--- libsemanage/include/semanage/seuser_record.h	2005-10-14 13:26:14.000000000 -0400
+++ libsemanage.new/include/semanage/seuser_record.h	2005-10-15 06:28:40.000000000 -0400
@@ -1,7 +1,6 @@
 #ifndef _SEMANAGE_SEUSER_RECORD_H_
 #define _SEMANAGE_SEUSER_RECORD_H_
 
-#include <stddef.h>
 #include <semanage/handle.h>
 
 struct semanage_seuser;
diff -Naur --exclude ChangeLog --exclude VERSION --exclude CVS libsemanage/src/database_directory.c libsemanage.new/src/database_directory.c
--- libsemanage/src/database_directory.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/database_directory.c	2005-10-15 06:44:49.000000000 -0400
@@ -0,0 +1,319 @@
+struct dbase_dir;
+typedef struct dbase_dir dbase_t;
+#define DBASE_DEFINED
+
+#include <stdlib.h>
+#include <string.h>
+#include "debug.h"
+#include "handle.h"
+#include "database_directory.h"
+#include "semanage_store.h"
+
+/* DIRECTORY dbase */ 
+struct dbase_dir {
+
+	/* Backing directory suffix */
+	const char* suffix;
+
+	/* Base record table */
+	record_table_t* rtable;
+};
+
+#if 0
+static int construct_filename(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase,
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
+#endif
+
+static void dbase_dir_drop_cache(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+}	
+
+/* Flush database to file */
+static int dbase_dir_flush(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	return STATUS_SUCCESS;
+}
+
+static int enter_ro(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase) {
+
+	//if (semanage_handle_get_read_lock(handle) < 0) {
+	//	/* FIXME: handle error */
+	//	return STATUS_ERR;
+	//}
+
+	/* Stub */	
+	handle = NULL;
+	dbase = NULL;
+	return STATUS_SUCCESS;
+}
+
+static inline void exit_ro(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase) {
+
+	//semanage_release_read_lock(handle);
+	dbase_dir_drop_cache(handle, dbase);
+}
+
+static int enter_rw(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase) {
+
+	if (!handle->is_in_transaction) {
+		/* FIXME: handle error */
+		return STATUS_ERR;
+	}
+
+	/* Stub */
+	dbase = NULL;
+	return STATUS_SUCCESS;
+}
+
+int dbase_dir_init(
+	const char* suffix,
+	record_table_t* rtable,
+	dbase_dir_t** dbase) {
+
+	dbase_dir_t* tmp_dbase = 
+		(dbase_dir_t*) malloc(sizeof(dbase_dir_t));
+	
+	if (!tmp_dbase)
+		goto omem;
+
+	tmp_dbase->suffix = suffix;
+	tmp_dbase->rtable = rtable;
+	*dbase = tmp_dbase;
+	
+	return STATUS_SUCCESS;
+	
+	omem:
+	/* FIXME: handle error condition */
+	free(tmp_dbase);
+	return STATUS_ERR;
+}
+	
+/* Release dbase resources */
+void dbase_dir_release(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase) {
+
+	dbase_dir_drop_cache(handle, dbase);
+	free(dbase);
+}
+
+static int dbase_dir_exists(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase,
+	record_key_t* key,
+	int* response) {
+
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
+	/* Stub */
+	key = NULL;
+	response = NULL;
+
+	exit_ro(handle, dbase);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error condition */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
+}
+
+static int dbase_dir_add(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+
+	int exists;
+
+	if (enter_rw(handle, dbase) < 0)
+		goto err;
+
+	if (dbase_dir_exists(handle, dbase, key, &exists) < 0)
+		goto err;
+
+	else if (exists) {
+		/* FIXME: handle error condition */
+		goto err;
+	}
+
+	/* Stub */
+	data = NULL;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
+}
+
+static int dbase_dir_modify(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase,
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
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
+}
+
+static int dbase_dir_count(
+        semanage_handle_t* handle,
+        dbase_dir_t* dbase,
+        int* response) {
+
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
+	/* Stub */
+	response = NULL;
+
+	exit_ro(handle, dbase);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: Handle error condition */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
+}
+
+static int dbase_dir_query(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase,
+	record_key_t* key,
+	record_t** response) {
+
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
+	/* Stub */
+	key = NULL;
+	response = NULL;
+
+	exit_ro(handle, dbase);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: Handle error condition */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
+}
+
+static int dbase_dir_iterate(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase, 
+	int (*fn) (record_t* record, void* fn_arg),
+	void* arg) {
+
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
+	/* Stub */
+	fn = NULL;
+	arg = NULL;
+
+	exit_ro(handle, dbase);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: Handle error condition */
+	exit_ro(handle, dbase);
+	return STATUS_ERR;
+}
+
+static int dbase_dir_del(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase,
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
+	/* FIXME: Handle error condition */
+	return STATUS_ERR;
+}
+
+static int dbase_dir_list(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase,
+	record_t*** records,
+	size_t* count) {
+
+	if (enter_ro(handle, dbase) < 0)
+		goto err;
+
+	/* Stub */
+	records = NULL;
+	count = NULL;
+
+	exit_ro(handle, dbase);
+	return STATUS_SUCCESS;
+
+	err:
+	exit_ro(handle, dbase);
+	/* FIXME: handle error condition */
+	return STATUS_ERR;
+}
+
+
+/* DIRECTORY dbase - method table implementation */
+dbase_table_t SEMANAGE_DIR_DTABLE = {
+	.drop_cache = dbase_dir_drop_cache,
+	.flush = dbase_dir_flush,
+	.iterate = dbase_dir_iterate,
+	.exists = dbase_dir_exists, 
+	.list = dbase_dir_list,   
+	.add = dbase_dir_add,
+	.del = dbase_dir_del, 
+	.modify = dbase_dir_modify, 
+	.query = dbase_dir_query, 
+	.count = dbase_dir_count, 
+};
diff -Naur --exclude ChangeLog --exclude VERSION --exclude CVS libsemanage/src/database_directory.h libsemanage.new/src/database_directory.h
--- libsemanage/src/database_directory.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/database_directory.h	2005-10-15 06:38:23.000000000 -0400
@@ -0,0 +1,25 @@
+#ifndef _SEMANAGE_DATABASE_DIRECTORY_INTERNAL_H_
+#define _SEMANAGE_DATABASE_DIRECTORY_INTERNAL_H_
+
+#include <stdio.h>
+#include "database.h"
+#include "handle.h"
+
+struct dbase_dir;
+typedef struct dbase_dir dbase_dir_t;
+
+/* DIRECTORY - initialization */
+extern int dbase_dir_init(
+	const char* suffix,
+	record_table_t* rtable,
+	dbase_dir_t** dbase);
+
+/* DIRECTORY - release */
+extern void dbase_dir_release(
+	semanage_handle_t* handle,
+	dbase_dir_t* dbase);
+
+/* DIRECTORY - method table implementation */
+extern dbase_table_t SEMANAGE_DIR_DTABLE;
+
+#endif
diff -Naur --exclude ChangeLog --exclude VERSION --exclude CVS libsemanage/src/module_record.c libsemanage.new/src/module_record.c
--- libsemanage/src/module_record.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/module_record.c	2005-10-15 06:44:25.000000000 -0400
@@ -0,0 +1,172 @@
+#include <stdlib.h>
+#include <string.h>
+
+#include <semanage/module_record.h>
+#include "debug.h"
+#include "handle.h"
+
+struct semanage_module {
+	/* This module's name */
+	char* name;
+
+	/* This module's version */
+	char* version;
+
+	/* FIXME: Add data fields here */
+};
+
+struct semanage_module_key {
+	/* This module's name */
+	const char* name;
+};
+
+int semanage_module_key_create(
+	semanage_handle_t* handle,
+	const char* name,
+	semanage_module_key_t** key_ptr) {
+
+	semanage_module_key_t* tmp_key = 
+		(semanage_module_key_t*) 
+		malloc(sizeof (semanage_module_key_t));
+
+	if (!tmp_key) {
+		ERR(handle, "out of memory, could not create module key");
+		return STATUS_ERR;
+	}
+	tmp_key->name = name;
+
+	*key_ptr = tmp_key;
+	return STATUS_SUCCESS;
+}
+
+int semanage_module_key_extract(
+	semanage_handle_t* handle,
+	semanage_module_t* module, 
+	semanage_module_key_t** key_ptr) {
+
+	if (semanage_module_key_create(handle, module->name, key_ptr) < 0) {
+		ERR(handle, "could not extract key from module %s",
+			module->name);
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}	
+
+void semanage_module_key_free(semanage_module_key_t* key) {
+	free(key);
+}
+
+int semanage_module_compare(
+	semanage_module_t* module,
+	semanage_module_key_t* key) {
+	
+	if (!strcmp(module->name, key->name))
+		return 0;
+	return 1;
+}
+
+/* Name */
+#if 0 /* FIXME: conflict with modules.h */
+const char* semanage_module_get_name(
+	semanage_module_t* module) {
+
+	return module->name;
+}
+
+int semanage_module_set_name(
+	semanage_handle_t* handle, 
+	semanage_module_t* module, 
+	const char* name) {
+
+	module->name = strdup(name);
+	if (!module->name) {
+		ERR(handle,  "out of memory, could not set name");
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+/* Version */
+const char* semanage_module_get_version(
+	semanage_module_t* module) {
+
+	return module->version;
+}
+
+int semanage_module_set_version(
+	semanage_handle_t* handle,
+	semanage_module_t* module,
+	const char* version) {
+
+	module->version = strdup(version);
+	if (!module->version) {
+		ERR(handle,  "out of memory, could not set version");
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+#endif
+
+/* Create */
+int semanage_module_create(
+	semanage_handle_t* handle,
+	semanage_module_t** module_ptr) {
+
+	semanage_module_t* module = 
+		(semanage_module_t*) malloc(sizeof (semanage_module_t));
+
+        if (!module) {
+		ERR(handle, "out of memory, "
+			"could not create module record"); 
+		return STATUS_ERR;
+	}
+
+        module->name = NULL;
+	module->version = NULL;
+
+	*module_ptr = module;
+	return STATUS_SUCCESS;
+}
+
+/* Deep copy clone */
+int semanage_module_clone(
+	semanage_handle_t* handle,
+	semanage_module_t* module, 
+	semanage_module_t** module_ptr) {
+
+	semanage_module_t* new_module = NULL;
+
+	if (semanage_module_create(handle, &new_module) < 0)
+		goto err;
+
+#if 0 /* FIXME: conflict with modules.h */
+	if (semanage_module_set_name(handle, new_module, module->name) < 0)
+		goto err;
+
+	if (semanage_module_set_version(handle, new_module, 
+		module->version) < 0)
+		goto err;
+#endif
+	module = NULL;
+
+	*module_ptr = new_module;
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not clone module record");
+	semanage_module_free(new_module);
+	return STATUS_ERR;
+}
+
+/* Destroy */
+void semanage_module_free(
+	semanage_module_t* module) {
+
+	if (!module)
+		return;
+	
+	free(module->name);
+	free(module->version);
+	free(module);
+}

--------------010103040202040408000703--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
