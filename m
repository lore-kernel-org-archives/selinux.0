Message-ID: <435A11EE.9020507@cornell.edu>
Date: Sat, 22 Oct 2005 06:18:22 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL 2 ] Context_to_record function
Content-Type: multipart/mixed;
 boundary="------------090904010104090204050307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090904010104090204050307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Interfaces and ports currently use a temporary string to convert from 
the internal context_struct to a record.
This patch fixes this craziness, and adds a proper convert function 
(context_to_record).

It's based on the last one - see my followup comments about that.



--------------090904010104090204050307
Content-Type: text/x-patch;
 name="libsepol.context_to_record.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.context_to_record.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/context.c new/libsepol/src/context.c
--- old/libsepol/src/context.c	2005-10-22 06:10:06.000000000 -0400
+++ new/libsepol/src/context.c	2005-10-22 05:44:14.000000000 -0400
@@ -131,7 +131,7 @@ int context_to_string(
 int context_from_record(
 	policydb_t* policydb, 
 	context_struct_t** cptr, 
-	sepol_context_t* data) {
+	sepol_context_t* record) {
 
 	context_struct_t* scontext = NULL;
 	user_datum_t* usrdatum;
@@ -139,11 +139,11 @@ int context_from_record(
 	type_datum_t* typdatum;
 
 	/* Hashtab keys are not constant - suppress warnings */
-	char* user = strdup(sepol_context_get_user(data)); 
-	char* role = strdup(sepol_context_get_role(data));
-	char* type = strdup(sepol_context_get_type(data));
+	char* user = strdup(sepol_context_get_user(record)); 
+	char* role = strdup(sepol_context_get_role(record));
+	char* type = strdup(sepol_context_get_type(record));
  
- 	const char* tmp = sepol_context_get_mls(data);
+ 	const char* tmp = sepol_context_get_mls(record);
  	char* mls = tmp ? strdup(tmp): NULL;
  	char* mls_ptr = mls;
 
@@ -233,6 +233,50 @@ int context_from_record(
 	return STATUS_ERR;
 }
 
+/* Create a record from the context structure */
+
+int context_to_record(
+	policydb_t* policydb,
+	context_struct_t* context,
+	sepol_context_t** record) {
+
+	sepol_context_t* tmp_record = NULL;
+	char* mls = NULL;
+
+	if (sepol_context_create(&tmp_record) < 0)
+		goto err;
+
+	if (sepol_context_set_user(tmp_record, 
+		policydb->p_user_val_to_name[context->user - 1]) < 0)
+		goto err;
+
+	if (sepol_context_set_role(tmp_record,
+		policydb->p_role_val_to_name[context->role - 1]) < 0)
+		goto err;
+
+	if (sepol_context_set_type(tmp_record,
+		policydb->p_type_val_to_name[context->type - 1]) <  0)
+		goto err;
+
+	if (policydb->mls) {
+		if (mls_struct_to_string(policydb, context, &mls) < 0)
+			goto err;
+
+		if (sepol_context_set_mls(tmp_record, mls) < 0)
+			goto err;
+	}
+	
+	free(mls);
+	*record = tmp_record;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	sepol_context_free(tmp_record);
+	free(mls);
+	return STATUS_ERR;
+}
+
 /*
  * Create a context structure from the provided string.
  */
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/context.h new/libsepol/src/context.h
--- old/libsepol/src/context.h	2005-10-22 06:10:06.000000000 -0400
+++ new/libsepol/src/context.h	2005-10-22 05:38:23.000000000 -0400
@@ -12,6 +12,11 @@ extern int context_from_record(
 	context_struct_t** cptr,
 	sepol_context_t* data);
 
+extern int context_to_record(
+	policydb_t* policydb,
+	context_struct_t* context,
+	sepol_context_t** record);
+
 /* Create a context structure from string representation */
 extern int context_from_string(
 	policydb_t* policydb,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2005-10-22 06:10:06.000000000 -0400
+++ new/libsepol/src/interfaces.c	2005-10-22 05:43:14.000000000 -0400
@@ -138,11 +138,10 @@ int sepol_iface_iterate(
 		sepol_iface_t* iface,
 		void* fn_arg),
 	void* arg) {
+
 	policydb_t *policydb = &p->p;
 	ocontext_t *c, *l, *head;
 	sepol_iface_t* iface = NULL;
-	char* tmp_con_str = NULL;
-	size_t tmp_con_ssize;
 	sepol_context_t* tmp_con = NULL;
 
 	head = policydb->ocontexts[OCON_NETIF];
@@ -159,30 +158,14 @@ int sepol_iface_iterate(
 		if (sepol_iface_set_name(iface, name) < 0)
 			goto err;
 
-		/* Interface context */
-		if (context_to_string(policydb, ifcon,
-			&tmp_con_str, &tmp_con_ssize) < 0)
-			goto err;
-
-		if (sepol_context_from_string(tmp_con_str, &tmp_con) < 0)
+		if (context_to_record(policydb, ifcon, &tmp_con) < 0)
 			goto err;
-		free(tmp_con_str);
-		tmp_con_str = NULL;
-
 		if (sepol_iface_set_ifcon(iface, tmp_con) < 0)
 			goto err;
 		tmp_con = NULL;
 
-		/* Message context */
-		if (context_to_string(policydb, msgcon,
-			&tmp_con_str, &tmp_con_ssize) < 0)
+		if (context_to_record(policydb, msgcon, &tmp_con) < 0)
 			goto err;
-
-		if (sepol_context_from_string(tmp_con_str, &tmp_con) < 0)
-			goto err;
-		free(tmp_con_str);
-		tmp_con_str = NULL;
-
 		if (sepol_iface_set_msgcon(iface, tmp_con) < 0)
 			goto err;
 		tmp_con = NULL;
@@ -204,7 +187,6 @@ int sepol_iface_iterate(
 
 	err:
 	DEBUG(__FUNCTION__, "could not iterate over interfaces\n");
-	free(tmp_con_str);
 	sepol_context_free(tmp_con);
 	sepol_iface_free(iface);
 	return STATUS_ERR;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-10-22 06:10:06.000000000 -0400
+++ new/libsepol/src/ports.c	2005-10-22 05:42:08.000000000 -0400
@@ -178,11 +178,10 @@ int sepol_port_iterate(
 		sepol_port_t* port,
 		void* fn_arg),
 	void* arg) {
+
 	policydb_t *policydb = &p->p;
 	ocontext_t *c, *l, *head;
 	sepol_port_t* port = NULL;	
-	char* tmp_con_str = NULL;
-	size_t tmp_con_ssize;
 	sepol_context_t* tmp_con = NULL; 	
 
 	head = policydb->ocontexts[OCON_PORT];
@@ -202,16 +201,10 @@ int sepol_port_iterate(
 
 		if (sepol_port_set_range(port, low, high) < 0)
 			goto err;
-		
-		if (context_to_string(policydb, con, 
-			&tmp_con_str, &tmp_con_ssize) < 0)
-			goto err;
-
-		if (sepol_context_from_string(tmp_con_str, &tmp_con) < 0)
+	
+		if (context_to_record(policydb, con, &tmp_con) < 0)
 			goto err;
-		free(tmp_con_str);
-		tmp_con_str = NULL;			
-
+	
 		if (sepol_port_set_con(port, tmp_con) < 0)
 			goto err;
 		tmp_con = NULL;
@@ -234,7 +227,6 @@ int sepol_port_iterate(
 
 	err:
 	DEBUG(__FUNCTION__, "could not iterate over ports\n");
-	free(tmp_con_str);
 	sepol_context_free(tmp_con);
 	sepol_port_free(port);
 	return STATUS_ERR;

--------------090904010104090204050307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
