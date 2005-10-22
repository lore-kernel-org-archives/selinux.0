Message-ID: <435A7614.8000706@cornell.edu>
Date: Sat, 22 Oct 2005 13:25:40 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL 6 ] Fix all the bugs 
Content-Type: multipart/mixed;
 boundary="------------070509090800070403090300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070509090800070403090300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is the part where I fix all the bugs, after enhancing my test case 
to test everything.
At present, I think it covers pretty much all the new things that I've 
added.
It passes valgrind, and works great with one memory leak, which I'm 
pretty sure has been there for a while - I'll track it down eventually.

Bugs:
- mls.c:  fix invalid free() in mls_from_string (ugh... surprising it 
hasn't been found)
- context.c: fix false omem error in context.c, introduced by [ SEPOL 4 ]
- interfaces.c: fix out-of-order if statement, caused by [ SEPOL 5 ]
- interfaces.c: fix potential null dereference in error path of iface:add()
- ports.c: handle failure in ipproto2sepol
- booleans.c: fix invalid string being copied for booleans [ SEPOL 5 ]
- users.c: MLS: fix improper use of memcpy in users.c - introduce new 
functions mls_level_cpy, mls_level_destroy, mls_range_cpy, and use those 
instead of memcpy (and handle failure)
- users/ports/interfaces: call context_init/context_destroy where 
appropriate to fix memory leaks

New things (covered by test case):
- rework add() function as modify(), which is the planned way for 
iface/port updates
- implement exists() function for interfaces and ports
- simplify the port key check a bit - I'll probably have to have another 
look at this, because I don't think it will do the right thing on 
modify() - only on query. When you modify a range with a key as the 
subset of that range, we want it to punch a hole in the range, and split 
the declaration, but it will replace it entirely. This is easy to fix in 
sepol, but I also have to fix it in semanage, where it is not as easy - 
I'd rather think about this some more than do it the wrong way right now.

--------------070509090800070403090300
Content-Type: text/x-patch;
 name="libsepol.fix_all_bugs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.fix_all_bugs.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/interfaces.h new/libsepol/include/sepol/interfaces.h
--- old/libsepol/include/sepol/interfaces.h	2005-10-22 09:54:27.000000000 -0400
+++ new/libsepol/include/sepol/interfaces.h	2005-10-22 09:40:10.000000000 -0400
@@ -5,6 +5,12 @@
 #include <sepol/iface_record.h>
 #include <stddef.h>
 
+/* Check if an interface exists */
+extern int sepol_iface_exists(
+	sepol_policydb_t* policydb,
+	sepol_iface_key_t* key,
+	int* response);
+
 /* Query an interface */
 extern int sepol_iface_query(
 	sepol_policydb_t* policydb,
@@ -12,7 +18,7 @@ extern int sepol_iface_query(
 	sepol_iface_t** response);
 
 /* Add an interface to policy */
-extern int sepol_iface_add(
+extern int sepol_iface_modify(
 	sepol_policydb_t* policydb,
 	sepol_iface_key_t* key,
 	sepol_iface_t* data);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/policydb/context.h new/libsepol/include/sepol/policydb/context.h
--- old/libsepol/include/sepol/policydb/context.h	2005-10-22 06:10:06.000000000 -0400
+++ new/libsepol/include/sepol/policydb/context.h	2005-10-22 12:52:00.000000000 -0400
@@ -36,40 +36,33 @@ typedef struct context_struct {
 
 static inline void mls_context_init(context_struct_t * c)
 {
-	memset(&c->range, 0, sizeof(c->range));
+	mls_level_init(&c->range.level[0]);
+	mls_level_init(&c->range.level[1]);
 }
 
-static inline int mls_context_cpy(context_struct_t * dst, 
-				  context_struct_t * src)
-{
-	int rc;
-
-	dst->range.level[0].sens = src->range.level[0].sens;
-	rc = ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
-	if (rc)
-		goto out;
-
-	dst->range.level[1].sens = src->range.level[1].sens;
-	rc = ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[1].cat);
-	if (rc)
-		ebitmap_destroy(&dst->range.level[0].cat);
-out:
-	return rc;
+static inline int mls_context_cpy(
+	context_struct_t * dst, 
+	context_struct_t * src) {
+
+	if (mls_range_cpy(&dst->range, &src->range) < 0)
+		return -1;
+	
+	return 0;
 }
 
 static inline int mls_context_cmp(context_struct_t * c1,
                                   context_struct_t * c2)
+
 {
-	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
-		ebitmap_cmp(&c1->range.level[0].cat,&c2->range.level[0].cat) &&
-		(c1->range.level[1].sens == c2->range.level[1].sens) &&
-		ebitmap_cmp(&c1->range.level[1].cat,&c2->range.level[1].cat));
+	return (mls_level_eq(&c1->range.level[0], &c2->range.level[0]) &&
+	        mls_level_eq(&c1->range.level[1], &c2->range.level[1]));
+
 }
 
 static inline void mls_context_destroy(context_struct_t * c)
 {
-	ebitmap_destroy(&c->range.level[0].cat);
-	ebitmap_destroy(&c->range.level[1].cat);
+	mls_level_destroy(&c->range.level[0]);
+	mls_level_destroy(&c->range.level[1]);
 	mls_context_init(c);
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/policydb/mls_types.h new/libsepol/include/sepol/policydb/mls_types.h
--- old/libsepol/include/sepol/policydb/mls_types.h	2005-10-07 16:45:17.000000000 -0400
+++ new/libsepol/include/sepol/policydb/mls_types.h	2005-10-22 12:55:44.000000000 -0400
@@ -44,6 +44,29 @@ typedef struct mls_range {
 	mls_level_t level[2]; /* low == level[0], high == level[1] */
 } mls_range_t;
 
+static inline int mls_level_cpy(
+	struct mls_level* dst,
+	struct mls_level* src) {
+
+	dst->sens = src->sens;
+	if (ebitmap_cpy(&dst->cat, &src->cat) < 0)
+		return -1;
+	return 0;
+}
+
+static inline void mls_level_init(
+	struct mls_level* level) {
+
+	memset(level, 0, sizeof(mls_level_t));
+}
+
+static inline void mls_level_destroy(
+	struct mls_level* level) {
+
+	ebitmap_destroy(&level->cat);
+	mls_level_init(level);
+}
+
 static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
 {
 	return ((l1->sens == l2->sens) &&
@@ -66,7 +89,23 @@ static inline int mls_level_dom(struct m
 (mls_level_dom(&(r2).level[0], &(r1).level[0]) && \
  mls_level_dom(&(r1).level[1], &(r2).level[1]))
 
-#endif
+static inline int mls_range_cpy(
+	mls_range_t * dst,
+	mls_range_t * src)  {
+
+	if (mls_level_cpy(&dst->level[0], &src->level[0]) < 0)
+		goto err;
+
+	if (mls_level_cpy(&dst->level[1], &src->level[0]) < 0)
+		goto err_destroy;
+
+	return 0;
 
-/* FLASK */
+	err_destroy:
+	mls_level_destroy(&dst->level[0]);
 
+	err:
+	return -1;
+}
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/ports.h new/libsepol/include/sepol/ports.h
--- old/libsepol/include/sepol/ports.h	2005-10-22 09:54:27.000000000 -0400
+++ new/libsepol/include/sepol/ports.h	2005-10-22 09:40:45.000000000 -0400
@@ -5,14 +5,20 @@
 #include <sepol/port_record.h>
 #include <stddef.h>
 
+/* Check if a port exists */
+extern int sepol_port_exists(
+	sepol_policydb_t* policydb,
+	sepol_port_key_t* key,
+	int* response);
+
 /* Query a port */
 extern int sepol_port_query(
 	sepol_policydb_t* policydb,
 	sepol_port_key_t* key,
 	sepol_port_t** response);
 
-/* Add a port into policy */
-extern int sepol_port_add(
+/* Modify a port into policy */
+extern int sepol_port_modify(
 	sepol_policydb_t* policydb, 
 	sepol_port_key_t* key,
 	sepol_port_t* data);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/booleans.c new/libsepol/src/booleans.c
--- old/libsepol/src/booleans.c	2005-10-22 09:54:27.000000000 -0400
+++ new/libsepol/src/booleans.c	2005-10-22 13:13:20.000000000 -0400
@@ -22,7 +22,7 @@ static int bool_update (
 	int value;
 
 	sepol_bool_key_unpack(key, &cname);
-	name = strdup(name);	
+	name = strdup(cname);	
 	value = sepol_bool_get_value(data);
 
 	if (!name) {
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/context.c new/libsepol/src/context.c
--- old/libsepol/src/context.c	2005-10-22 08:42:17.000000000 -0400
+++ new/libsepol/src/context.c	2005-10-22 10:19:55.000000000 -0400
@@ -144,7 +144,7 @@ int context_from_record(
 	const char* mls = sepol_context_get_mls(record); 
 
 	scontext = (context_struct_t*) malloc(sizeof(context_struct_t));
- 	if (!user || !role || !type || !mls || !scontext) {
+ 	if (!user || !role || !type || !scontext) {
 		DEBUG(__FUNCTION__, "out of memory\n"); 
 		goto err;
 	}
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2005-10-22 09:54:27.000000000 -0400
+++ new/libsepol/src/interfaces.c	2005-10-22 11:50:51.000000000 -0400
@@ -34,6 +34,7 @@ static int iface_from_record (
 		&tmp_ifcon, sepol_iface_get_ifcon(record)) < 0)
 		goto err;
 	context_cpy(&tmp_iface->context[0], tmp_ifcon);
+	context_destroy(tmp_ifcon);
 	free(tmp_ifcon);
 
 	/* Message Context */
@@ -41,6 +42,7 @@ static int iface_from_record (
 		&tmp_msgcon, sepol_iface_get_msgcon(record)) < 0)
 		goto err;
 	context_cpy(&tmp_iface->context[1], tmp_msgcon);
+	context_destroy(tmp_msgcon);
 	free(tmp_msgcon);
 
 	*iface = tmp_iface;
@@ -96,7 +98,30 @@ static int iface_to_record (
 	return STATUS_ERR;
 }
 
-/* Get the current context mapping for this interface */
+/* Check if an interface exists */
+int sepol_iface_exists (
+	sepol_policydb_t* p,
+	sepol_iface_key_t* key,
+	int* response) {
+
+	policydb_t *policydb = &p->p;
+	ocontext_t *c, *head;
+
+	const char* name;
+	sepol_iface_key_unpack(key, &name);
+
+	head = policydb->ocontexts[OCON_NETIF];
+	for (c = head; c; c = c->next) {
+		if (!strcmp(name, c->u.name)) {
+			*response = 1;
+			return STATUS_SUCCESS;
+		}
+	}
+	*response = 0;
+	return STATUS_SUCCESS;
+}
+
+/* Query an interface */
 int sepol_iface_query (
 	sepol_policydb_t* p,
 	sepol_iface_key_t* key,
@@ -126,43 +151,51 @@ int sepol_iface_query (
 }
 
 /* Load an interface into policy */
-int sepol_iface_add(
+int sepol_iface_modify(
 	sepol_policydb_t* p,
 	sepol_iface_key_t* key, 
 	sepol_iface_t* data) {
 
 	policydb_t *policydb = &p->p;
-	ocontext_t* iface = NULL;
-	sepol_iface_t* query_response = NULL;
-	int rc;
+	ocontext_t *head, *prev, *c, *iface = NULL;
 
 	const char* name;
 	sepol_iface_key_unpack(key, &name);
 
-	rc = sepol_iface_query(p, key, &query_response);
-	if (rc < 0) 
-		goto err;
-
 	if (iface_from_record(policydb, &iface, data) < 0)
 		goto err;
 
-	else if (rc != STATUS_NODATA) {
-		DEBUG(__FUNCTION__, "interface is already configured\n"); 
-		goto err;
-	}
-	
+	prev = NULL;
+	head = policydb->ocontexts[OCON_NETIF];
+	for (c = head; c; c = c->next) {
+		if (!strcmp(name, c->u.name)) {
+
+			/* Replace */
+			iface->next = c->next;
+			if (prev == NULL)
+				policydb->ocontexts[OCON_NETIF] = iface;
+			else
+				prev->next = iface;
+			free(c->u.name);
+			free(c);
+
+			return STATUS_SUCCESS;
+		}
+		prev = c;
+	}	
+		
 	/* Attach to context list */
 	iface->next = policydb->ocontexts[OCON_NETIF];
 	policydb->ocontexts[OCON_NETIF] = iface;
-
-	sepol_iface_free(query_response);
 	return STATUS_SUCCESS;
 
 	err:
 	DEBUG(__FUNCTION__, "error while loading interface %s\n", name);
-	free(iface->u.name);
-	free(iface);
-	sepol_iface_free(query_response);
+
+	if (iface != NULL) {
+		free(iface->u.name);
+		free(iface);
+	}
 	return STATUS_ERR;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/mls.c new/libsepol/src/mls.c
--- old/libsepol/src/mls.c	2005-10-22 08:42:17.000000000 -0400
+++ new/libsepol/src/mls.c	2005-10-22 10:03:21.000000000 -0400
@@ -79,12 +79,13 @@ int mls_from_string(
 	context_struct_t* mls) {
 
 	char* tmp = strdup(str);
+	char* tmp_cp = tmp;
 	if (!tmp) {
 		DEBUG(__FUNCTION__, "out of memory\n");
 		return STATUS_ERR;
 	}
 
-	if (mls_context_to_sid(policydb, '$', &tmp, mls)) {
+	if (mls_context_to_sid(policydb, '$', &tmp_cp, mls)) {
 		DEBUG(__FUNCTION__, "invalid MLS context %s\n", str);
 		free(tmp);
 		return STATUS_ERR;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-10-22 09:54:27.000000000 -0400
+++ new/libsepol/src/ports.c	2005-10-22 11:49:33.000000000 -0400
@@ -74,6 +74,7 @@ static int port_from_record(
 		sepol_port_get_con(data)) < 0)
 		goto err;
 	context_cpy(&tmp_port->context[0], tmp_con);
+	context_destroy(tmp_con);
 	free(tmp_con);
 
 	*port = tmp_port;
@@ -94,6 +95,7 @@ static int port_to_record (
 	int low = port->u.port.low_port;
 	int high = port->u.port.high_port;
 	context_struct_t* con = &port->context[0];
+	int rec_proto;
 
 	sepol_context_t* tmp_con = NULL;
 	sepol_port_t* tmp_record = NULL;
@@ -101,7 +103,11 @@ static int port_to_record (
 	if (sepol_port_create(&tmp_record) < 0)
 		goto err;
 
-	if (sepol_port_set_proto(tmp_record, ipproto2sepol(proto)) < 0)
+	rec_proto = ipproto2sepol(proto);
+	if (rec_proto < 0)
+		goto err;
+
+	if (sepol_port_set_proto(tmp_record, rec_proto) < 0)
 		goto err;
 
 	if (sepol_port_set_range(tmp_record, low, high) < 0)
@@ -124,7 +130,43 @@ static int port_to_record (
 	return STATUS_ERR;
 }
 
-/* Get the current context mapping for this port */
+/* Check if a port exists */
+int sepol_port_exists (
+	sepol_policydb_t* p,
+	sepol_port_key_t* key,
+	int* response) {
+
+	policydb_t *policydb = &p->p;
+	ocontext_t *c, *head;
+
+	int low, high, proto;
+	sepol_port_key_unpack(key, &low, &high, &proto);
+	proto = sepol2ipproto(proto);
+	if (proto < 0)
+		goto err;
+
+	head = policydb->ocontexts[OCON_PORT];
+	for (c = head; c; c = c->next) {
+		int proto2 = c->u.port.protocol;
+		int low2 = c->u.port.low_port;
+		int high2 = c->u.port.high_port;
+
+		if (proto == proto2 && low2 <= low && high2 >= high) {
+			*response = 1;
+			return STATUS_SUCCESS;
+		}
+	}
+
+	*response = 0;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	return STATUS_ERR;
+
+}
+
+/* Query a port */
 int sepol_port_query(
 	sepol_policydb_t* p,
 	sepol_port_key_t* key,
@@ -136,7 +178,6 @@ int sepol_port_query(
 	int low, high, proto;
 	sepol_port_key_unpack(key, &low, &high, &proto);
 	proto = sepol2ipproto(proto);
-
 	if (proto < 0)
 		goto err;
 
@@ -145,17 +186,10 @@ int sepol_port_query(
 		int proto2 = c->u.port.protocol;
 		int low2 = c->u.port.low_port;
 		int high2 = c->u.port.high_port;
-		context_struct_t* con2 = &c->context[0];
-
-		if (proto != proto2)
-			continue;
-
-		if ((low == low2 && high == high2) ||
-		    (low2 <= low && high2 >= high)) {
 
+		if (proto == proto2 && low2 <= low && high2 >= high) {
 			if (port_to_record(policydb, c, response) < 0)
 				goto err;
-
 			return STATUS_SUCCESS;
 		}
 	}
@@ -170,32 +204,48 @@ int sepol_port_query(
 }
 
 /* Load a port into policy */
-int sepol_port_add(
+int sepol_port_modify(
 	sepol_policydb_t* p, 
 	sepol_port_key_t* key,
 	sepol_port_t* data) {
 
 	policydb_t *policydb = &p->p;
-	ocontext_t* port = NULL;
-	sepol_port_t* query_response = NULL;
-	int rc;
+	ocontext_t *c, *head, *prev, *port = NULL;
 
-	rc = sepol_port_query(p, key, &query_response);
-	if (rc < 0) 
-		goto err;
-	else if (rc != STATUS_NODATA) {
-		DEBUG(__FUNCTION__, "port entry is already configured\n");
+	int low, high, proto;
+	sepol_port_key_unpack(key, &low, &high, &proto);
+	proto = sepol2ipproto(proto);	
+	if (proto < 0)
 		goto err;
-	}
 
 	if (port_from_record(policydb, &port, data) < 0)
 		goto err;
-	
+
+	head = policydb->ocontexts[OCON_PORT];
+	for (c = head; c; c = c->next) {
+		int proto2 = c->u.port.protocol;
+		int low2 = c->u.port.low_port;
+		int high2 = c->u.port.high_port;
+
+		if (proto == proto2 && low2 <= low && high2 >= high) {
+
+			/* Replace */
+			port->next = c->next;
+			if (prev == NULL)
+				policydb->ocontexts[OCON_PORT] = port;
+			else
+				prev->next = port;
+			free(c);
+
+			return STATUS_SUCCESS;
+		}
+		prev = c;
+	}
+
 	/* Attach to context list */
 	port->next = policydb->ocontexts[OCON_PORT];
 	policydb->ocontexts[OCON_PORT] = port;
 
-	sepol_port_free(query_response);
 	return STATUS_SUCCESS;
 
 	err:
@@ -206,7 +256,6 @@ int sepol_port_add(
 		sepol_port_get_high(data));
 
 	free(port);
-	sepol_port_free(query_response);
 	return STATUS_ERR;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude database_policydb.h --exclude policy_components.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-22 09:54:27.000000000 -0400
+++ new/libsepol/src/users.c	2005-10-22 13:07:55.000000000 -0400
@@ -45,25 +45,41 @@ static int user_to_record (
 		char *str;
 
 		context_init(&context);
-		memcpy(&context.range.level[0],
-			&usrdatum->dfltlevel, sizeof(mls_level_t));
-		memcpy(&context.range.level[1],
-			&usrdatum->dfltlevel, sizeof(mls_level_t));
-
-		if (mls_to_string(policydb, &context, &str) < 0)
+		if (mls_level_cpy(&context.range.level[0], 
+			&usrdatum->dfltlevel) < 0) {
+			DEBUG(__FUNCTION__, "could not copy MLS level");
+			context_destroy(&context);
+			goto err;
+		}
+		if (mls_level_cpy(&context.range.level[1],
+			&usrdatum->dfltlevel) < 0) {
+			DEBUG(__FUNCTION__, "could not copy MLS level");
+			context_destroy(&context);
 			goto err;
+		}
+		if (mls_to_string(policydb, &context, &str) < 0) {
+			context_destroy(&context);
+			goto err;
+		}
+		context_destroy(&context);
 
-		if (sepol_user_set_mlslevel(tmp_record, str) < 0 ) {
+		if (sepol_user_set_mlslevel(tmp_record, str) < 0) {
 			free(str);
 			goto err;
 		}
 		free(str);
 
 		context_init(&context);
-		memcpy(&context.range, &usrdatum->range, sizeof(mls_range_t));
-
-		if (mls_to_string(policydb, &context, &str) < 0)
+		if (mls_range_cpy(&context.range, &usrdatum->range) < 0) {
+			DEBUG(__FUNCTION__, "could not copy MLS range");
+			context_destroy(&context);
+			goto err;
+		}
+		if (mls_to_string(policydb, &context, &str) < 0) {
+			context_destroy(&context);
 			goto err;
+		}
+		context_destroy(&context);
 
 		if (sepol_user_set_mlsrange(tmp_record, str) < 0) {
 			free(str);
@@ -171,7 +187,6 @@ int sepol_user_modify(
 
 	/* For MLS systems */
 	if (policydb->mls) {
-		context_init(&context);
 
 		/* MLS level */
 		if (mls_level == NULL) {
@@ -180,28 +195,40 @@ int sepol_user_modify(
 			goto err;
 		}
 		
+		context_init(&context);
 		if (mls_from_string(policydb, mls_level, &context) < 0) {
 			DEBUG(__FUNCTION__, "invalid MLS default level %s for user %s\n", 
 				mls_level, name);
+			context_destroy(&context);
 			goto err;
 		}
-		memcpy(&usrdatum->dfltlevel, &context.range.level[0], 
-		        sizeof(usrdatum->dfltlevel));
-		
+		if (mls_level_cpy(&usrdatum->dfltlevel, &context.range.level[0]) < 0) {
+			DEBUG(__FUNCTION__, "could not copy MLS level %s", mls_level); 
+			context_destroy(&context);
+			goto err;
+		}
+		context_destroy(&context);			
+	
 		/* MLS range */
-		context_init(&context);
 		if (mls_range == NULL) {
 			DEBUG(__FUNCTION__, "MLS is enabled, but no MLS"
 				"range was defined for user %s\n", name);
 			goto err;
 		}	
-
+		
+		context_init(&context);
 		if (mls_from_string(policydb, mls_range, &context) < 0) {
 			DEBUG(__FUNCTION__, "invalid MLS range %s for user %s\n", 
 				mls_range, name);
+			context_destroy(&context);
+			goto err;
+		}
+		if (mls_range_cpy(&usrdatum->range, &context.range) < 0) {
+			DEBUG(__FUNCTION__, "could not copy MLS range %s", mls_range);
+			context_destroy(&context);
 			goto err;
 		}
-		memcpy(&usrdatum->range, &context.range, sizeof(usrdatum->range));
+		context_destroy(&context);
 	}
 
 	/* If there are no errors, and this is a new user, add the user to policy */

--------------070509090800070403090300--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
