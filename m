Message-ID: <433DD618.1070508@cornell.edu>
Date: Fri, 30 Sep 2005 20:19:36 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: dwalsh@redhat.com, selinux@tycho.nsa.gov,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: [ SEMANAGE ] [ SEPOL ] Backend iterate function
References: <433DA069.3090208@cornell.edu> <1128112109.12459.216.camel@moss-spartans.epoch.ncsc.mil> <433DA664.6040600@cornell.edu>
In-Reply-To: <433DA664.6040600@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------070202090001030202050401"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070202090001030202050401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Well, while you figure out if you want to merge the last patch I sent, 
here's a couple of other patches.

List() is basically a special case of iterate. As I mentioned in my 
other email, we *need* iterate functionality for large databases, 
because it won't be practical to load them in memory (at least in 
expanded form) - one such database is the list of all rules in base policy.

---

The first patch here replaces the user list() function which I just 
wrote with an iterate() one. This exercise wasn't useless - most of the 
code is exactly the same - we just don't put the users in an array, and 
we call a handler. List is removed, because it can be implemented on top 
of iterate. In fact, most of the other functions in the sepol 
users/interfaces/ports API should be removed once semanage is properly 
functioning. I've also added iterate() on interfaces, ports, and 
booleans. Tried this, and it seems to work fine - print handler prints 
out all the data.

The second patch corrects the corresponding table in semanage (the 
record_direct_table_t), and sets those functions in the tables for users 
and ports. It also adds an iterate() function to the backend table, and 
stubs for that. Finally, it adds cacheable parameter to each database, 
that will indicate whether the database should be cached. If it says 0, 
then .... it will fallback to implementation via iterate() in the 
backend (without making a list of records)) (I haven't set this up yet). 
Currently all databases are cacheable.

Again, the point of this is :
- for large POLICY databases (list of rules), not to expand the shared 
list of strings into an array of stand-alone records, which will take up 
tons of space.

- for large FILE databases, not to load the contents of the FILE in 
memory (not sure if I'll implement this).



--------------070202090001030202050401
Content-Type: text/x-patch;
 name="libsepol.01.iterate.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.01.iterate.diff"

diff -Naur libsepol/include/sepol/booleans.h libsepol.new/include/sepol/booleans.h
--- libsepol/include/sepol/booleans.h	2005-09-30 16:19:08.000000000 -0400
+++ libsepol.new/include/sepol/booleans.h	2005-09-30 18:59:14.000000000 -0400
@@ -16,4 +16,17 @@
 	sepol_bool_t** bool_arr,
 	size_t bool_arr_len);
 
+/* Iterate the booleans
+ * The handler may return:
+ * -1 to signal an error condition,
+ * 1 to signal successful exit
+ * 0 to signal continue */
+
+extern int sepol_bool_iterate(
+	policydb_t* policydb,
+	int (*fn)(
+		sepol_bool_t* boolean,
+		void* fn_arg),
+	void* arg);
+
 #endif
diff -Naur libsepol/include/sepol/interfaces.h libsepol.new/include/sepol/interfaces.h
--- libsepol/include/sepol/interfaces.h	2005-09-30 16:19:08.000000000 -0400
+++ libsepol.new/include/sepol/interfaces.h	2005-09-30 18:47:14.000000000 -0400
@@ -17,4 +17,17 @@
 	policydb_t* policydb,
 	sepol_iface_t* data);
 
+/* Iterate the interfaces
+ * The handler may return:
+ * -1 to signal an error condition,
+ * 1 to signal successful exit
+ * 0 to signal continue */
+
+extern int sepol_iface_iterate(
+	policydb_t* policydb,
+	int (*fn)(
+		sepol_iface_t* iface,
+		void* fn_arg),
+	void* arg);
+
 #endif
diff -Naur libsepol/include/sepol/ports.h libsepol.new/include/sepol/ports.h
--- libsepol/include/sepol/ports.h	2005-09-30 16:19:08.000000000 -0400
+++ libsepol.new/include/sepol/ports.h	2005-09-30 18:57:14.000000000 -0400
@@ -19,4 +19,17 @@
 	policydb_t* policydb, 
 	sepol_port_t* data);
 
+/* Iterate the ports 
+ * The handler may return:
+ * -1 to signal an error condition,
+ * 1 to signal successful exit
+ * 0 to signal continue */
+
+extern int sepol_port_iterate(
+	policydb_t* policydb,
+	int (*fn)(
+		sepol_port_t* port,
+		void* fn_arg),
+	void* arg);
+
 #endif
diff -Naur libsepol/include/sepol/users.h libsepol.new/include/sepol/users.h
--- libsepol/include/sepol/users.h	2005-09-30 16:19:08.000000000 -0400
+++ libsepol.new/include/sepol/users.h	2005-09-30 18:47:00.000000000 -0400
@@ -32,11 +32,18 @@
 	policydb_t* policydb,
 	const char* role);
 
-/* Obtain the user list */
-extern int sepol_user_list(
+/* Iterate the users
+ * The handler may return:
+ * -1 to signal an error condition,
+ * 1 to signal successful exit
+ * 0 to signal continue */
+
+extern int sepol_user_iterate(
 	policydb_t* policydb,
-	sepol_user_t*** users,
-	size_t* nusers);
+	int (*fn)(
+		sepol_user_t* user,
+		void* fn_arg),
+	void* arg);
 
 extern int sepol_get_valid_roles(
 	policydb_t* policydb, 
diff -Naur libsepol/src/booleans.c libsepol.new/src/booleans.c
--- libsepol/src/booleans.c	2005-09-30 16:19:08.000000000 -0400
+++ libsepol.new/src/booleans.c	2005-09-30 19:28:56.000000000 -0400
@@ -93,3 +93,51 @@
 	DEBUG(__FUNCTION__, "error while loading booleans\n");
 	return STATUS_ERR;
 }
+
+int sepol_bool_iterate(
+	policydb_t* policydb,
+	int (*fn)(
+		sepol_bool_t* boolean,
+		void* fn_arg),
+	void* arg) {
+
+	size_t nbools = policydb->p_bools.nprim;
+	sepol_bool_t* boolean = NULL;
+	size_t i;
+
+	/* For each boolean */
+	for (i = 0; i < nbools; i++) {
+
+		int status;
+		const char* name = policydb->p_bool_val_to_name[i];
+		cond_bool_datum_t* booldatum = policydb->bool_val_to_struct[i];
+		int value = booldatum->state;
+
+		if (sepol_bool_create(&boolean) < 0)
+			goto err;
+
+		if (sepol_bool_set_name(boolean, name) < 0)
+			goto err;
+
+		sepol_bool_set_value(boolean, value);
+
+		/* Invoke handler */
+		status = fn(boolean, arg);
+		if (status < 0)
+			goto err;
+
+		sepol_bool_free(boolean);
+		boolean = NULL;
+
+		/* Handler requested exit */
+		if (status > 0)
+			break;
+	}
+
+	return STATUS_SUCCESS;
+
+	err:
+	DEBUG(__FUNCTION__, "could not iterate over booleans\n");
+	sepol_bool_free(boolean);
+	return STATUS_ERR;
+}
diff -Naur libsepol/src/interfaces.c libsepol.new/src/interfaces.c
--- libsepol/src/interfaces.c	2005-09-30 16:19:08.000000000 -0400
+++ libsepol.new/src/interfaces.c	2005-09-30 19:01:12.000000000 -0400
@@ -131,3 +131,82 @@
 	free(iface);
 	return STATUS_ERR;
 }
+
+int sepol_iface_iterate(
+	policydb_t* policydb,
+	int (*fn)(
+		sepol_iface_t* iface,
+		void* fn_arg),
+	void* arg) {
+
+	ocontext_t *c, *l, *head;
+	sepol_iface_t* iface = NULL;
+	char* tmp_con_str = NULL;
+	size_t tmp_con_ssize;
+	sepol_context_t* tmp_con = NULL;
+
+	head = policydb->ocontexts[OCON_NETIF];
+	for (l = NULL, c = head; c; l = c, c = c->next) {
+
+		int status;
+		char* name = c->u.name;
+		context_struct_t* ifcon = &c->context[0];
+		context_struct_t* msgcon = &c->context[1];
+
+		if (sepol_iface_create(&iface) < 0)
+			goto err;
+	
+		if (sepol_iface_set_name(iface, name) < 0)
+			goto err;
+
+		/* Interface context */
+		if (sepol_ctx_struct_to_string(policydb, ifcon,
+			&tmp_con_str, &tmp_con_ssize) < 0)
+			goto err;
+
+		if (sepol_context_from_string(tmp_con_str, &tmp_con) < 0)
+			goto err;
+		free(tmp_con_str);
+		tmp_con_str = NULL;
+
+		if (sepol_iface_set_ifcon(iface, tmp_con) < 0)
+			goto err;
+		tmp_con = NULL;
+
+		/* Message context */
+		if (sepol_ctx_struct_to_string(policydb, msgcon,
+			&tmp_con_str, &tmp_con_ssize) < 0)
+			goto err;
+
+		if (sepol_context_from_string(tmp_con_str, &tmp_con) < 0)
+			goto err;
+		free(tmp_con_str);
+		tmp_con_str = NULL;
+
+		if (sepol_iface_set_msgcon(iface, tmp_con) < 0)
+			goto err;
+		tmp_con = NULL;
+
+		/* Invoke handler */
+		status = fn(iface, arg);
+		if (status < 0)
+			goto err;
+
+		sepol_iface_free(iface);
+		iface = NULL;
+
+		/* Handler requested exit */
+		if (status > 0)
+			break;
+	}
+
+	return STATUS_SUCCESS;
+
+	err:
+	DEBUG(__FUNCTION__, "could not iterate over interfaces\n");
+	free(tmp_con_str);
+	sepol_context_free(tmp_con);
+	sepol_iface_free(iface);
+	return STATUS_ERR;
+}
+
diff -Naur libsepol/src/ports.c libsepol.new/src/ports.c
--- libsepol/src/ports.c	2005-09-30 16:19:08.000000000 -0400
+++ libsepol.new/src/ports.c	2005-09-30 19:01:22.000000000 -0400
@@ -19,7 +19,20 @@
 		default:
 			DEBUG(__FUNCTION__, "unsupported protocol %d\n",
                                 proto);
-			return -1;
+			return STATUS_ERR;
+	}
+}
+
+static int ipproto2sepol(int proto) {
+	switch(proto) {
+		case IPPROTO_TCP:
+			return SEPOL_PROTO_TCP;
+		case IPPROTO_UDP:
+			return SEPOL_PROTO_UDP;
+		default:
+			DEBUG(__FUNCTION__, "invalid protocol %d "
+				"found in policy\n", proto);
+			return STATUS_ERR;
 	}
 }
 
@@ -158,3 +171,71 @@
 	free(port);
 	return STATUS_ERR;
 }
+
+int sepol_port_iterate(
+	policydb_t* policydb,
+	int (*fn)(
+		sepol_port_t* port,
+		void* fn_arg),
+	void* arg) {
+
+	ocontext_t *c, *l, *head;
+	sepol_port_t* port = NULL;	
+	char* tmp_con_str = NULL;
+	size_t tmp_con_ssize;
+	sepol_context_t* tmp_con = NULL; 	
+
+	head = policydb->ocontexts[OCON_PORT];
+	for (l = NULL, c = head; c; l = c, c = c->next) {
+
+		int status;
+		int proto = c->u.port.protocol;
+		int low = c->u.port.low_port;
+		int high = c->u.port.high_port;
+		context_struct_t* con = &c->context[0];
+
+		if (sepol_port_create(&port) < 0)
+			goto err;
+
+		if (sepol_port_set_proto(port, ipproto2sepol(proto)) < 0)
+			goto err;
+
+		if (sepol_port_set_range(port, low, high) < 0)
+			goto err;
+		
+		if (sepol_ctx_struct_to_string(policydb, con, 
+			&tmp_con_str, &tmp_con_ssize) < 0)
+			goto err;
+
+		if (sepol_context_from_string(tmp_con_str, &tmp_con) < 0)
+			goto err;
+		free(tmp_con_str);
+		tmp_con_str = NULL;			
+
+		if (sepol_port_set_con(port, tmp_con) < 0)
+			goto err;
+		tmp_con = NULL;
+	
+		/* Invoke handler */	
+		status = fn(port, arg);
+		if (status < 0)
+			goto err;
+		
+		sepol_port_free(port);
+		port = NULL;
+
+		/* Handler requested exit */
+		if (status > 0) 
+			break;
+	}
+
+
+	return STATUS_SUCCESS;
+
+	err:
+	DEBUG(__FUNCTION__, "could not iterate over ports\n");
+	free(tmp_con_str);
+	sepol_context_free(tmp_con);
+	sepol_port_free(port);
+	return STATUS_ERR;
+}
diff -Naur libsepol/src/users.c libsepol.new/src/users.c
--- libsepol/src/users.c	2005-09-30 16:19:08.000000000 -0400
+++ libsepol.new/src/users.c	2005-09-30 18:57:34.000000000 -0400
@@ -365,40 +365,38 @@
 
 /* Fill an array with all valid users */
 
-int sepol_user_list(
+int sepol_user_iterate(
 	policydb_t* policydb, 
-	sepol_user_t*** users,
-	size_t* nusers) {
+	int (*fn)(
+		sepol_user_t* user,
+		void* fn_arg),
+	void* arg) {
 
-	size_t tmp_nusers = policydb->p_users.nprim;
-	sepol_user_t** tmp_users = 
-		(sepol_user_t**) calloc(tmp_nusers, sizeof(sepol_user_t*));
-
-	sepol_user_t** ptr;
+	size_t nusers = policydb->p_users.nprim;
+	sepol_user_t* user = NULL;
 	size_t i;
-	if (!tmp_users)
-		goto omem;
 
 	/* For each user */	
-	for (i = 0; i < tmp_nusers; i++) {
-			
+	for (i = 0; i < nusers; i++) {
+
+		int status;
 		const char* name = policydb->p_user_val_to_name[i];
 		user_datum_t* usrdatum = policydb->user_val_to_struct[i];
 		ebitmap_t* roles = &(usrdatum->roles.roles);
 		ebitmap_node_t* rnode;
 		unsigned bit;
 
-		if (sepol_user_create(&tmp_users[i]) < 0)
+		if (sepol_user_create(&user) < 0)
 			goto err;
 
-		if (sepol_user_set_name(tmp_users[i], name) < 0)
+		if (sepol_user_set_name(user, name) < 0)
 			goto err; 
 
 		/* Extract roles */
 		ebitmap_for_each_bit(roles, rnode, bit) {
 			if (ebitmap_node_get_bit(rnode, bit)) {
 				char* role = policydb->p_role_val_to_name[bit];
-				if (sepol_user_add_role(tmp_users[i], role) < 0)
+				if (sepol_user_add_role(user, role) < 0)
 					goto err;
 			}
 		}
@@ -417,7 +415,7 @@
 			if (mls_struct_to_string(policydb, &context, &str) < 0)
 				goto err;
 	
-			if (sepol_user_set_mlslevel(tmp_users[i], str) < 0 ) {
+			if (sepol_user_set_mlslevel(user, str) < 0 ) {
 				free(str);
 				goto err;
 			}
@@ -429,29 +427,31 @@
 			if (mls_struct_to_string(policydb, &context, &str) < 0)
 				goto err;
 
-			if (sepol_user_set_mlsrange(tmp_users[i], str) < 0) {
+			if (sepol_user_set_mlsrange(user, str) < 0) {
 				free(str);
 				goto err;
 			}
 			free(str);
 		}
-	}
 
-	*nusers = tmp_nusers;
-	*users = tmp_users;
+		/* Invoke handler */
+		status = fn(user, arg);
+		if (status < 0) 
+			goto err;
 
-	return STATUS_SUCCESS;
+		sepol_user_free(user);		
+		user = NULL;
 
-	omem:
-	DEBUG(__FUNCTION__, "out of memory\n");
+		/* Handler requested exit */
+		if (status > 0)
+			break;
+	}
 
-	err:
-	DEBUG(__FUNCTION__, "could not enumerate users\n");
+	return STATUS_SUCCESS;
 
-	ptr = tmp_users;
-	while (ptr && (*ptr != NULL)) 
-		sepol_user_free(*ptr++);
-	free(tmp_users);
+	err:
+	DEBUG(__FUNCTION__, "could not iterate over users\n");
+	sepol_user_free(user);
 	return STATUS_ERR;
 }
 

--------------070202090001030202050401
Content-Type: text/x-patch;
 name="libsemanage.02.iterate.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.02.iterate.diff"

diff -Naur libsemanage/src/database.c libsemanage.new/src/database.c
--- libsemanage/src/database.c	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/database.c	2005-09-30 19:45:28.000000000 -0400
@@ -10,6 +10,7 @@
 	record_table_t* rtable,
 	dbase_backend_t* backend,
 	dbase_backend_table_t* btable,
+	int cacheable,
 	dbase_t** dbase) {
 
 	dbase_t* tmp_dbase =
@@ -25,6 +26,7 @@
 	tmp_dbase->cache_sz = 0;
 	tmp_dbase->cached = 0;
 	tmp_dbase->cache_invalid = 0;
+	tmp_dbase->cacheable = cacheable;
 
 	*dbase = tmp_dbase;
 	return STATUS_SUCCESS;
@@ -54,15 +56,17 @@
 void dbase_invalidate_cache(
 	dbase_t* dbase) {
 
-	dbase->cache_invalid = 1;
+	if (dbase->cacheable)
+		dbase->cache_invalid = 1;
 }
 
 /* Flush the database cache */
 int dbase_flush(
 	dbase_t* dbase) {
 
-	if (dbase->btable->flush(dbase, dbase->backend) < 0)
-		return STATUS_ERR;
+	if (dbase->cacheable) 
+		if (dbase->btable->flush(dbase, dbase->backend) < 0)
+			return STATUS_ERR;
 
 	return STATUS_SUCCESS;
 }
@@ -93,6 +97,7 @@
 	
 	cache_entry_t* ptr;
 
+	/* FIXME: respect cacheable */
 	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
@@ -117,6 +122,7 @@
 
 	int exists;
 
+	/* FIXME: respect cacheable */
 	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
@@ -148,6 +154,7 @@
 	cache_entry_t* entry;
 	int status;
 
+	/* FIXME: respect cacheable */
 	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
@@ -174,6 +181,7 @@
 
 	cache_entry_t *ptr, *prev = NULL;
 
+	/* FIXME: respect cacheable */
 	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
@@ -209,6 +217,7 @@
 	cache_entry_t* entry;
 	int status;
 
+	/* FIXME: respect cacheable */
 	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
@@ -235,6 +244,7 @@
 	cache_entry_t* entry;
 	int status;
 
+	/* FIXME: respect cacheable */
 	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
@@ -256,6 +266,7 @@
 	dbase_t* dbase,
 	int* response) {
 
+	/* FIXME: respect cacheable */
 	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
@@ -277,6 +288,7 @@
 	int status;	
 	cache_entry_t* ptr;
 	
+	/* FIXME: respect cacheable */
 	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
@@ -308,6 +320,7 @@
 	size_t tmp_count;
 	int i = 0;
 	
+	/* FIXME: respect cacheable */
 	if (dbase->btable->cache(dbase, dbase->backend) < 0)
 		goto err;
 
diff -Naur libsemanage/src/database_direct.c libsemanage.new/src/database_direct.c
--- libsemanage/src/database_direct.c	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/database_direct.c	2005-09-30 19:51:01.000000000 -0400
@@ -87,8 +87,23 @@
 	free(backend);
 }
 
+/* Iterate over backend */
+int dbase_direct_iterate(
+	dbase_direct_backend_t* backend,
+	int (*fn) (record_t* record, void* fn_arg),
+	void* arg) {
+
+	/* Stub */
+	backend = NULL;
+	fn = NULL;
+	arg = NULL;
+
+        return STATUS_SUCCESS;
+}
+
 /* DIRECT POLICY backend - method table implementation */
 dbase_backend_table_t SEMANAGE_DIRECT_BTABLE = {
 	.cache = dbase_direct_cache,
 	.flush = dbase_direct_flush,
+	.iterate = dbase_direct_iterate,
 };
diff -Naur libsemanage/src/database_file.c libsemanage.new/src/database_file.c
--- libsemanage/src/database_file.c	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/database_file.c	2005-09-30 19:49:58.000000000 -0400
@@ -136,8 +136,23 @@
 	free(backend);
 }
 
+/* Iterate over backend */
+int dbase_file_iterate(
+	dbase_file_backend_t* backend, 
+	int (*fn) (record_t* record, void* fn_arg),
+	void* arg) {
+
+	/* Stub */
+	backend = NULL;
+	fn = NULL;
+	arg = NULL;
+
+	return STATUS_SUCCESS;
+}
+
 /* FILE backend - method table implementation */
 dbase_backend_table_t SEMANAGE_FILE_BTABLE = {
 	.cache = dbase_file_cache,
 	.flush = dbase_file_flush,
+	.iterate = dbase_file_iterate,
 };
diff -Naur libsemanage/src/database.h libsemanage.new/src/database.h
--- libsemanage/src/database.h	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/database.h	2005-09-30 19:38:26.000000000 -0400
@@ -44,6 +44,7 @@
         size_t cache_sz;
         int cached;
         int cache_invalid;
+	int cacheable;
 } dbase_t;
 
 /* Add a record to the database cache */
@@ -60,6 +61,7 @@
 	record_table_t* rtable,
 	dbase_backend_t* backend,
 	dbase_backend_table_t* btable,
+	int cacheable,
 	dbase_t** dbase);
 
 /* Get back the backend object  */
diff -Naur libsemanage/src/interfaces.h libsemanage.new/src/interfaces.h
--- libsemanage/src/interfaces.h	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/interfaces.h	2005-09-30 19:48:01.000000000 -0400
@@ -74,11 +74,14 @@
 /* POLICY DIRECT extension to RECORD interface - method table */
 typedef struct record_direct_table {
 
-	/* Load record into policy store */
+	/* Load record into the policy database  */
 	int (*load) (policydb_t* policy, record_t* record); 
 
-	/* Extract records from policy store */
-	int (*list) (policydb_t* policy, record_t*** records, size_t* nrecords);
+	/* Iterate over records */
+	int (*iterate) (
+		policydb_t* policydb,
+		int (*fn)(record_t* record, void* fn_arg),
+		void* arg);
 
 } record_direct_table_t;
 
@@ -91,6 +94,12 @@
 	/* Flush dbase to backend */
 	int (*flush) (struct dbase* dbase, dbase_backend_t* backend);
 
+	/* Iterate over backend */
+	int (*iterate) (
+		dbase_backend_t* backend,
+		int (*fn)(record_t* record, void* fn_arg),
+		void* arg);
+
 } dbase_backend_table_t;
 
 #endif 
diff -Naur libsemanage/src/ports_direct.c libsemanage.new/src/ports_direct.c
--- libsemanage/src/ports_direct.c	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/ports_direct.c	2005-09-30 19:54:48.000000000 -0400
@@ -25,23 +25,24 @@
 /* PORT RECORD (SEPOL): POLICY DIRECT extension : method table */
 record_direct_table_t SEMANAGE_PORT_DIRECT_RTABLE = {
 	.load        = sepol_port_load,
-	.list        = NULL, /* sepol_port_list,  */      
+	.iterate     = sepol_port_iterate,
 };
 
 int port_direct_dbase_init(dbase_t** dbase) {
 	dbase_direct_backend_t* backend;
 
 	if (dbase_direct_init(
-		NULL, /* FIXME */
-		NULL, /* FIXME */
-		&SEMANAGE_PORT_DIRECT_RTABLE,
-		&backend) < 0)
+		NULL,                         /* FIXME: backing file         */
+		NULL,                         /* FIXME: policydb pointer     */
+		&SEMANAGE_PORT_DIRECT_RTABLE, /* record backend method table */
+		&backend) < 0) 
 		return STATUS_ERR;
 
 	return dbase_init(
-		&SEPOL_PORT_RTABLE,
-		backend,
-		&SEMANAGE_DIRECT_BTABLE,
+		&SEPOL_PORT_RTABLE,           /* record base method table    */
+		backend,                      /* backend                     */
+		&SEMANAGE_DIRECT_BTABLE,      /* backend method table        */
+		1,                            /* cacheable                   */
 		dbase);
 }
 
diff -Naur libsemanage/src/ports_file.c libsemanage.new/src/ports_file.c
--- libsemanage/src/ports_file.c	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/ports_file.c	2005-09-30 19:54:33.000000000 -0400
@@ -48,15 +48,16 @@
 	dbase_file_backend_t* backend;
 
 	if (dbase_file_init(
-		NULL, /* FIXME */
-		&SEMANAGE_PORT_FILE_RTABLE, 
+		NULL,                         /* FIXME: backing file         */
+		&SEMANAGE_PORT_FILE_RTABLE,   /* record backend method table */
 		&backend) < 0)
 		return STATUS_ERR;
 
 	return dbase_init(
-		&SEMANAGE_PORT_RTABLE,
-		backend,
-		&SEMANAGE_FILE_BTABLE,
+		&SEMANAGE_PORT_RTABLE,        /* record base method table   */ 
+		backend,                      /* backend                    */
+		&SEMANAGE_FILE_BTABLE,        /* backend method table       */
+		1,                            /* cacheable                  */
 		dbase);
 }
 
diff -Naur libsemanage/src/users_direct.c libsemanage.new/src/users_direct.c
--- libsemanage/src/users_direct.c	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/users_direct.c	2005-09-30 19:54:58.000000000 -0400
@@ -25,23 +25,24 @@
 /* USER RECRORD (SEPOL): POLICY DIRECT extension: method table */
 record_direct_table_t SEMANAGE_USER_DIRECT_RTABLE = {
 	.load        = sepol_user_load,
-	.list        = NULL, /* sepol_user_list */      
+	.iterate     = sepol_user_iterate,
 };
 
 int user_direct_dbase_init(dbase_t** dbase) {
 	dbase_direct_backend_t* backend;
 
 	if (dbase_direct_init(
-		NULL, /* FIXME */
-		NULL, /* FIXME */
-		&SEMANAGE_USER_DIRECT_RTABLE,
+		NULL,                         /* FIXME: backing file         */
+		NULL,                         /* FIXME: policydb pointer     */
+		&SEMANAGE_USER_DIRECT_RTABLE, /* record backend method table */
 		&backend) < 0)
 		return STATUS_ERR;
 
 	return dbase_init(
-		&SEPOL_USER_RTABLE,
-		backend,
-		&SEMANAGE_DIRECT_BTABLE,
+		&SEPOL_USER_RTABLE,           /* record base method table   */
+		backend,                      /* backend                    */
+		&SEMANAGE_DIRECT_BTABLE,      /* backend method table       */
+		1,                            /* cacheable                  */
 		dbase);
 }
 
diff -Naur libsemanage/src/users_file.c libsemanage.new/src/users_file.c
--- libsemanage/src/users_file.c	2005-09-30 16:19:07.000000000 -0400
+++ libsemanage.new/src/users_file.c	2005-09-30 19:54:24.000000000 -0400
@@ -47,15 +47,16 @@
 	dbase_file_backend_t* backend;
 	
 	if (dbase_file_init(
-		NULL, /* FIXME */
-		&SEMANAGE_USER_FILE_RTABLE,
+		NULL,                          /* FIXME: backing file         */
+		&SEMANAGE_USER_FILE_RTABLE,    /* record backend method table */
 		&backend) < 0)
 		return STATUS_ERR;
 
 	return dbase_init(
-		&SEMANAGE_USER_RTABLE,
-		backend,
-		&SEMANAGE_FILE_BTABLE,
+		&SEMANAGE_USER_RTABLE,         /* record base method table    */
+		backend,                       /* backend                     */
+		&SEMANAGE_FILE_BTABLE,         /* backend method table        */
+		1,                             /* cacheable                   */
 		dbase);
 }
 

--------------070202090001030202050401--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
