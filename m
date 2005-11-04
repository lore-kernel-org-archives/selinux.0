Message-ID: <436B02BC.7080001@cornell.edu>
Date: Fri, 04 Nov 2005 01:42:04 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL ] Fix usage of context_destroy - correct memory leaks/null
 derefs
Content-Type: multipart/mixed;
 boundary="------------010601080800070508080106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010601080800070508080106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix multiple potential memory leaks and null dereferences in 
interfaces/ports, caused by improper use of context_destroy.
More importantly, change all _destroy() functions to properly handle a 
NULL pointer, as all such functions should do.



--------------010601080800070508080106
Content-Type: text/x-patch;
 name="libsepol.context_destroy_audit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.context_destroy_audit.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsepol/include/sepol/policydb/context.h new/libsepol/include/sepol/policydb/context.h
--- old/libsepol/include/sepol/policydb/context.h	2005-10-24 12:30:39.000000000 -0400
+++ new/libsepol/include/sepol/policydb/context.h	2005-11-04 01:23:40.000000000 -0500
@@ -61,6 +61,9 @@ static inline int mls_context_cmp(contex
 
 static inline void mls_context_destroy(context_struct_t * c)
 {
+	if (c == NULL)
+		return;
+
 	mls_level_destroy(&c->range.level[0]);
 	mls_level_destroy(&c->range.level[1]);
 	mls_context_init(c);
@@ -82,6 +85,9 @@ static inline int context_cpy(context_st
 
 static inline void context_destroy(context_struct_t * c)
 {
+	if (c == NULL)
+		return;
+
 	c->user = c->role = c->type = 0;
 	mls_context_destroy(c);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsepol/include/sepol/policydb/mls_types.h new/libsepol/include/sepol/policydb/mls_types.h
--- old/libsepol/include/sepol/policydb/mls_types.h	2005-10-24 12:30:39.000000000 -0400
+++ new/libsepol/include/sepol/policydb/mls_types.h	2005-11-04 01:23:57.000000000 -0500
@@ -63,6 +63,9 @@ static inline void mls_level_init(
 static inline void mls_level_destroy(
 	struct mls_level* level) {
 
+	if (level == NULL)
+		return;
+
 	ebitmap_destroy(&level->cat);
 	mls_level_init(level);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/interfaces.c	2005-11-04 01:27:12.000000000 -0500
@@ -16,8 +16,7 @@ static int iface_from_record (
 	sepol_iface_t* record) {
 
 	ocontext_t* tmp_iface = NULL;
-	context_struct_t* tmp_ifcon = NULL;
-	context_struct_t* tmp_msgcon = NULL;
+	context_struct_t* tmp_con = NULL;
 
 	tmp_iface = (ocontext_t *) calloc(1, sizeof(ocontext_t));
 	if (!tmp_iface) 	
@@ -30,19 +29,21 @@ static int iface_from_record (
 
 	/* Interface Context */
 	if (context_from_record(handle, policydb, 
-		&tmp_ifcon, sepol_iface_get_ifcon(record)) < 0)
+		&tmp_con, sepol_iface_get_ifcon(record)) < 0)
 		goto err;
-	context_cpy(&tmp_iface->context[0], tmp_ifcon);
-	context_destroy(tmp_ifcon);
-	free(tmp_ifcon);
+	context_cpy(&tmp_iface->context[0], tmp_con);
+	context_destroy(tmp_con);
+	free(tmp_con);
+	tmp_con = NULL;
 
 	/* Message Context */
 	if (context_from_record(handle, policydb, 
-		&tmp_msgcon, sepol_iface_get_msgcon(record)) < 0)
+		&tmp_con, sepol_iface_get_msgcon(record)) < 0)
 		goto err;
-	context_cpy(&tmp_iface->context[1], tmp_msgcon);
-	context_destroy(tmp_msgcon);
-	free(tmp_msgcon);
+	context_cpy(&tmp_iface->context[1], tmp_con);
+	context_destroy(tmp_con);
+	free(tmp_con);
+	tmp_con = NULL;
 
 	*iface = tmp_iface;
 	return STATUS_SUCCESS;
@@ -51,8 +52,14 @@ static int iface_from_record (
 	ERR(handle, "out of memory");
 
 	err:
-	free(tmp_iface->u.name);
-	free(tmp_iface);
+	if (tmp_iface != NULL) {
+		free(tmp_iface->u.name);
+		context_destroy(&tmp_iface->context[0]);
+		context_destroy(&tmp_iface->context[1]);
+		free(tmp_iface);
+	}
+	context_destroy(tmp_con);
+	free(tmp_con);
 	ERR(handle, "error creating interface structure");
 	return STATUS_ERR;
 }
@@ -201,6 +208,8 @@ int sepol_iface_modify(
 
 	if (iface != NULL) {
 		free(iface->u.name);
+		context_destroy(&c->context[0]);
+		context_destroy(&c->context[1]);
 		free(iface);
 	}
 	return STATUS_ERR;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/ports.c	2005-11-04 01:28:27.000000000 -0500
@@ -78,6 +78,7 @@ static int port_from_record(
 	context_cpy(&tmp_port->context[0], tmp_con);
 	context_destroy(tmp_con);
 	free(tmp_con);
+	tmp_con = NULL;
 
 	*port = tmp_port;
 	return STATUS_SUCCESS;
@@ -86,7 +87,12 @@ static int port_from_record(
 	ERR(handle, "out of memory");
 
 	err:
-	free(tmp_port);
+	if (tmp_port != NULL) {
+		context_destroy(&tmp_port->context[0]);
+		free(tmp_port);
+        }
+	context_destroy(tmp_con);
+	free(tmp_con);
 	ERR(handle, "error creating port structure");
 	return STATUS_ERR;
 }
@@ -282,8 +288,11 @@ int sepol_port_modify(
 	err:
 	/* FIXME: print protocol string */
 	ERR(handle, "could not load port range %u - %u (protocol: %u)",
-		low, high, proto); 
-	free(port);
+		low, high, proto);
+	if (port != NULL) {
+		context_destroy(&port->context[0]);
+		free(port);
+	}
 	return STATUS_ERR;
 }
 

--------------010601080800070508080106--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
