Message-ID: <435A19EB.7080107@cornell.edu>
Date: Sat, 22 Oct 2005 06:52:27 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL 3 ] Interfaces, ports, booleans - record conversion fn
Content-Type: multipart/mixed;
 boundary="------------050108030708080607090404"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050108030708080607090404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- renames sepol_[iface/port]_struct_create functions to _from_record, 
which reflects what they do better.
- removes the sepol prefix from those functions - they are both 
internal, and marked static (if this is a namespace problem - will 
address in followup patch, along with the other patches that did the 
same thing). This is now consistent w/ context_to/from record
- moves code from iterate into _to_record() functions that will be 
shared with query, and other things that need to make a record.
- renames boolean _load() functions to _set().



--------------050108030708080607090404
Content-Type: text/x-patch;
 name="libsepol.record_conv2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.record_conv2.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/booleans.h new/libsepol/include/sepol/booleans.h
--- old/libsepol/include/sepol/booleans.h	2005-10-21 16:17:46.000000000 -0400
+++ new/libsepol/include/sepol/booleans.h	2005-10-22 06:42:07.000000000 -0400
@@ -28,12 +28,12 @@ extern int sepol_genbools_array(
 /*---------------end compatbility------------*/
 
 /* Load a boolean into the policy */
-extern int sepol_bool_load (
+extern int sepol_bool_set (
 	sepol_policydb_t* policydb, 
 	sepol_bool_t* boolean);
 
 /* Load a boolean array into the policy */
-extern int sepol_bool_load_array(
+extern int sepol_bool_set_array(
 	sepol_policydb_t* policydb,
 	sepol_bool_t** bool_arr,
 	size_t bool_arr_len);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/booleans.c new/libsepol/src/booleans.c
--- old/libsepol/src/booleans.c	2005-10-07 16:45:46.000000000 -0400
+++ new/libsepol/src/booleans.c	2005-10-22 06:43:42.000000000 -0400
@@ -46,8 +46,38 @@ static inline int bool_update (
 	return STATUS_ERR;		
 }
 
-int sepol_bool_load (
-	sepol_policydb_t* p, sepol_bool_t* boolean) {
+static int bool_to_record (
+	policydb_t* policydb,
+	int bool_idx,
+	sepol_bool_t** record) {
+
+	const char* name = policydb->p_bool_val_to_name[bool_idx];
+	cond_bool_datum_t* booldatum = policydb->bool_val_to_struct[bool_idx];
+	int value = booldatum->state;
+
+	sepol_bool_t* tmp_record = NULL;
+
+	if (sepol_bool_create(&tmp_record) < 0)
+		goto err;
+
+	if (sepol_bool_set_name(tmp_record, name) < 0)
+		goto err;
+
+	sepol_bool_set_value(tmp_record, value);
+
+	*record = tmp_record;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	sepol_bool_free(tmp_record);
+	return STATUS_ERR;
+}
+
+int sepol_bool_set (
+	sepol_policydb_t* p, 
+	sepol_bool_t* boolean) {
+
 	policydb_t *policydb = &p->p;
 	if (bool_update(policydb, boolean) < 0)
 		goto err;	
@@ -66,10 +96,11 @@ int sepol_bool_load (
 	return STATUS_ERR;
 }
 
-int sepol_bool_load_array(
+int sepol_bool_set_array(
 	sepol_policydb_t* p,
 	sepol_bool_t** bool_arr,
 	size_t bool_arr_len) {	
+
 	policydb_t *policydb = &p->p;
 	unsigned int i, errors = 0;
 
@@ -100,6 +131,7 @@ int sepol_bool_iterate(
 		sepol_bool_t* boolean,
 		void* fn_arg),
 	void* arg) {
+
 	policydb_t *policydb = &p->p;
 	size_t nbools = policydb->p_bools.nprim;
 	sepol_bool_t* boolean = NULL;
@@ -109,18 +141,10 @@ int sepol_bool_iterate(
 	for (i = 0; i < nbools; i++) {
 
 		int status;
-		const char* name = policydb->p_bool_val_to_name[i];
-		cond_bool_datum_t* booldatum = policydb->bool_val_to_struct[i];
-		int value = booldatum->state;
-
-		if (sepol_bool_create(&boolean) < 0)
-			goto err;
 
-		if (sepol_bool_set_name(boolean, name) < 0)
+		if (bool_to_record(policydb, i, &boolean) < 0)
 			goto err;
-
-		sepol_bool_set_value(boolean, value);
-
+			
 		/* Invoke handler */
 		status = fn(boolean, arg);
 		if (status < 0)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2005-10-22 06:46:18.000000000 -0400
+++ new/libsepol/src/interfaces.c	2005-10-22 06:43:59.000000000 -0400
@@ -10,12 +10,11 @@
 #include <sepol/interfaces.h>
 #include <sepol/iface_record.h>
 
-/* Create a low level interface structure from
- * a high level representation */
-static int sepol_iface_struct_create (
+/* Create a low level structure from record */
+static int iface_from_record (
 	policydb_t* policydb,
 	ocontext_t** iface,
-	sepol_iface_t* data) {
+	sepol_iface_t* record) {
 
 	ocontext_t* tmp_iface = NULL;
 	context_struct_t* tmp_ifcon = NULL;
@@ -26,20 +25,20 @@ static int sepol_iface_struct_create (
 		goto omem;
 
 	/* Name */
-	tmp_iface->u.name = strdup(sepol_iface_get_name(data));
+	tmp_iface->u.name = strdup(sepol_iface_get_name(record));
 	if (!tmp_iface->u.name)
 		goto omem;
 
 	/* Interface Context */
 	if (context_from_record(policydb, 
-		&tmp_ifcon, sepol_iface_get_ifcon(data)) < 0)
+		&tmp_ifcon, sepol_iface_get_ifcon(record)) < 0)
 		goto err;
 	context_cpy(&tmp_iface->context[0], tmp_ifcon);
 	free(tmp_ifcon);
 
 	/* Message Context */
 	if (context_from_record(policydb, 
-		&tmp_msgcon, sepol_iface_get_msgcon(data)) < 0)
+		&tmp_msgcon, sepol_iface_get_msgcon(record)) < 0)
 		goto err;
 	context_cpy(&tmp_iface->context[1], tmp_msgcon);
 	free(tmp_msgcon);
@@ -57,12 +56,53 @@ static int sepol_iface_struct_create (
 	return STATUS_ERR;
 }
 
+static int iface_to_record (
+	policydb_t* policydb,
+	ocontext_t* iface,
+        sepol_iface_t** record) {
+
+	char* name = iface->u.name;
+	context_struct_t* ifcon = &iface->context[0];
+	context_struct_t* msgcon = &iface->context[1];
+
+	sepol_context_t* tmp_con = NULL;
+	sepol_iface_t* tmp_record = NULL;
+
+	if (sepol_iface_create(&tmp_record) < 0)
+		goto err;
+
+	if (sepol_iface_set_name(tmp_record, name) < 0)
+		goto err;
+
+	if (context_to_record(policydb, ifcon, &tmp_con) < 0)
+		goto err;
+	if (sepol_iface_set_ifcon(tmp_record, tmp_con) < 0)
+		goto err;
+	tmp_con = NULL;
+
+	if (context_to_record(policydb, msgcon, &tmp_con) < 0)
+		goto err;
+	if (sepol_iface_set_msgcon(tmp_record, tmp_con) < 0)
+		goto err;
+	tmp_con = NULL;
+
+	*record = tmp_record;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	sepol_context_free(tmp_con);
+	sepol_iface_free(tmp_record);
+	return STATUS_ERR;
+}
+
 /* Get the current context mapping for this interface */
 int sepol_iface_get_context(
 	sepol_policydb_t* p,
 	sepol_iface_t* data,
 	char** ifcon_str, size_t* ifcon_str_len,	
 	char** msgcon_str, size_t* msgcon_str_len) {
+
 	policydb_t *policydb = &p->p;
 	ocontext_t *c, *head;
 	const char* name = sepol_iface_get_name(data);
@@ -94,6 +134,7 @@ int sepol_iface_get_context(
 int sepol_iface_add(
 	sepol_policydb_t* p, 
 	sepol_iface_t* data) {
+
 	policydb_t *policydb = &p->p;
 	ocontext_t* iface = NULL;
 	char *ifcon_str, *msgcon_str;
@@ -102,7 +143,7 @@ int sepol_iface_add(
 
 	const char* name = sepol_iface_get_name(data);
 
-	if (sepol_iface_struct_create(policydb, &iface, data) < 0)
+	if (iface_from_record(policydb, &iface, data) < 0)
 		goto err;
 
 	rc = sepol_iface_get_context(
@@ -142,34 +183,14 @@ int sepol_iface_iterate(
 	policydb_t *policydb = &p->p;
 	ocontext_t *c, *l, *head;
 	sepol_iface_t* iface = NULL;
-	sepol_context_t* tmp_con = NULL;
 
 	head = policydb->ocontexts[OCON_NETIF];
 	for (l = NULL, c = head; c; l = c, c = c->next) {
-
 		int status;
-		char* name = c->u.name;
-		context_struct_t* ifcon = &c->context[0];
-		context_struct_t* msgcon = &c->context[1];
-
-		if (sepol_iface_create(&iface) < 0)
-			goto err;
-	
-		if (sepol_iface_set_name(iface, name) < 0)
-			goto err;
 
-		if (context_to_record(policydb, ifcon, &tmp_con) < 0)
+		if (iface_to_record(policydb, c, &iface) < 0)
 			goto err;
-		if (sepol_iface_set_ifcon(iface, tmp_con) < 0)
-			goto err;
-		tmp_con = NULL;
-
-		if (context_to_record(policydb, msgcon, &tmp_con) < 0)
-			goto err;
-		if (sepol_iface_set_msgcon(iface, tmp_con) < 0)
-			goto err;
-		tmp_con = NULL;
-
+		
 		/* Invoke handler */
 		status = fn(iface, arg);
 		if (status < 0)
@@ -187,7 +208,6 @@ int sepol_iface_iterate(
 
 	err:
 	DEBUG(__FUNCTION__, "could not iterate over interfaces\n");
-	sepol_context_free(tmp_con);
 	sepol_iface_free(iface);
 	return STATUS_ERR;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-10-22 06:46:18.000000000 -0400
+++ new/libsepol/src/ports.c	2005-10-22 06:45:05.000000000 -0400
@@ -38,7 +38,7 @@ static int ipproto2sepol(int proto) {
 
 /* Create a low level port structure from
  * a high level representation */
-static int sepol_port_struct_create(
+static int port_from_record(
 	policydb_t* policydb,
 	ocontext_t** port,
 	sepol_port_t* data) {
@@ -85,12 +85,52 @@ static int sepol_port_struct_create(
 	return STATUS_ERR;
 }
 
+static int port_to_record (
+	policydb_t* policydb,
+	ocontext_t* port,
+	sepol_port_t** record) {
+
+	int proto = port->u.port.protocol;
+	int low = port->u.port.low_port;
+	int high = port->u.port.high_port;
+	context_struct_t* con = &port->context[0];
+
+	sepol_context_t* tmp_con = NULL;
+	sepol_port_t* tmp_record = NULL;
+
+	if (sepol_port_create(&tmp_record) < 0)
+		goto err;
+
+	if (sepol_port_set_proto(tmp_record, ipproto2sepol(proto)) < 0)
+		goto err;
+
+	if (sepol_port_set_range(tmp_record, low, high) < 0)
+		goto err;
+
+	if (context_to_record(policydb, con, &tmp_con) < 0)
+		goto err;
+
+	if (sepol_port_set_con(tmp_record, tmp_con) < 0)
+		goto err;
+	tmp_con = NULL;
+
+	*record = tmp_record;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	sepol_context_free(tmp_con);
+	sepol_port_free(tmp_record);
+	return STATUS_ERR;
+}
+
 /* Get the current context mapping for this port */
 int sepol_port_get_context(
 	sepol_policydb_t* p,
 	sepol_port_t* data,
 	char** con_str,	
 	size_t* con_str_len) {
+
 	policydb_t *policydb = &p->p;
 	int low = sepol_port_get_low(data);	
 	int high = sepol_port_get_high(data);
@@ -141,7 +181,7 @@ int sepol_port_add(
 	size_t dup_size; 
 	int rc;
 
-	if (sepol_port_struct_create(policydb, &port, data) < 0)
+	if (port_from_record(policydb, &port, data) < 0)
 		goto err;
 
 	rc = sepol_port_get_context(p, data, &dup_match, &dup_size);
@@ -182,33 +222,14 @@ int sepol_port_iterate(
 	policydb_t *policydb = &p->p;
 	ocontext_t *c, *l, *head;
 	sepol_port_t* port = NULL;	
-	sepol_context_t* tmp_con = NULL; 	
 
 	head = policydb->ocontexts[OCON_PORT];
 	for (l = NULL, c = head; c; l = c, c = c->next) {
-
 		int status;
-		int proto = c->u.port.protocol;
-		int low = c->u.port.low_port;
-		int high = c->u.port.high_port;
-		context_struct_t* con = &c->context[0];
-
-		if (sepol_port_create(&port) < 0)
-			goto err;
 
-		if (sepol_port_set_proto(port, ipproto2sepol(proto)) < 0)
+		if (port_to_record(policydb, c, &port) < 0)
 			goto err;
 
-		if (sepol_port_set_range(port, low, high) < 0)
-			goto err;
-	
-		if (context_to_record(policydb, con, &tmp_con) < 0)
-			goto err;
-	
-		if (sepol_port_set_con(port, tmp_con) < 0)
-			goto err;
-		tmp_con = NULL;
-	
 		/* Invoke handler */	
 		status = fn(port, arg);
 		if (status < 0)
@@ -222,12 +243,10 @@ int sepol_port_iterate(
 			break;
 	}
 
-
 	return STATUS_SUCCESS;
 
 	err:
 	DEBUG(__FUNCTION__, "could not iterate over ports\n");
-	sepol_context_free(tmp_con);
 	sepol_port_free(port);
 	return STATUS_ERR;
 }

--------------050108030708080607090404--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
