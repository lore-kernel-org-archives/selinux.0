Message-ID: <43686887.7080001@cornell.edu>
Date: Wed, 02 Nov 2005 02:19:35 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL ] [ SEMANAGE 2] Fix spec for sepol_context_to_string
Content-Type: multipart/mixed;
 boundary="------------040907050703050105050807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040907050703050105050807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Do not mix exit status with return value - use a parameter instead, like 
it's done for everything else.


--------------040907050703050105050807
Content-Type: text/x-patch;
 name="libsepol.libsemanage.context_to_string.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.libsemanage.context_to_string.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/context_record.h new/libsemanage/include/semanage/context_record.h
--- old/libsemanage/include/semanage/context_record.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/include/semanage/context_record.h	2005-11-02 02:13:39.000000000 -0500
@@ -61,8 +61,9 @@ extern int semanage_context_from_string(
 	const char* str, 
 	semanage_context_t** con);
 
-extern char* semanage_context_to_string(
+extern int semanage_context_to_string(
 	semanage_handle_t* handle,
-	semanage_context_t* con);
+	semanage_context_t* con,
+	char** str_ptr);
 
 #endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/context_record.c new/libsemanage/src/context_record.c
--- old/libsemanage/src/context_record.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsemanage/src/context_record.c	2005-11-02 02:11:36.000000000 -0500
@@ -88,9 +88,10 @@ int semanage_context_from_string(
 	return sepol_context_from_string(handle->sepolh, str, con);
 }
 
-char* semanage_context_to_string(
+int semanage_context_to_string(
 	semanage_handle_t* handle,
-	semanage_context_t* con) {
+	semanage_context_t* con,
+	char** str_ptr) {
 
-	return sepol_context_to_string(handle->sepolh, con);
+	return sepol_context_to_string(handle->sepolh, con, str_ptr);
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2005-11-02 02:04:33.000000000 -0500
+++ new/libsemanage/src/interfaces_file.c	2005-11-02 02:17:15.000000000 -0500
@@ -32,16 +32,14 @@ static int iface_print(
 	if (fprintf(str, "netifcon %s ", name) < 0)
 		goto err;
 
-	con_str = semanage_context_to_string(handle, ifcon);
-	if (!con_str)
+	if (semanage_context_to_string(handle, ifcon, &con_str) < 0)
 		goto err;
 	if (fprintf(str, "%s", con_str) < 0)
 		goto err;
 	free(con_str);
 	con_str = NULL;
 
-	con_str = semanage_context_to_string(handle, msgcon);
-	if (!con_str)
+	if (semanage_context_to_string(handle, msgcon, &con_str) < 0)
 		goto err;
 	if (fprintf(str, "%s\n", con_str) < 0)
 		goto err;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2005-11-02 02:04:33.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2005-11-02 02:17:30.000000000 -0500
@@ -28,6 +28,7 @@ static int port_print(
 	int low = semanage_port_get_low(port);
 	int high = semanage_port_get_high(port);
 	const char* proto = semanage_port_get_proto_str(port);
+	semanage_context_t* con = semanage_port_get_con(port);
 
 	if (fprintf(str, "portcon %s ", proto) < 0)
 		goto err;
@@ -40,10 +41,8 @@ static int port_print(
 			goto err;
 	}
 
-	con_str = semanage_context_to_string(handle, semanage_port_get_con(port));
-	if (!con_str)
+	if (semanage_context_to_string(handle, con, &con_str) < 0)
 		goto err;
-
 	if (fprintf(str, "%s\n", con_str) < 0)
 		goto err;
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsepol/include/sepol/context_record.h new/libsepol/include/sepol/context_record.h
--- old/libsepol/include/sepol/context_record.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsepol/include/sepol/context_record.h	2005-11-02 02:10:35.000000000 -0500
@@ -64,8 +64,9 @@ extern int sepol_context_from_string(
 	const char* str, 
 	sepol_context_t** con);
 
-extern char* sepol_context_to_string(
+extern int sepol_context_to_string(
 	sepol_handle_t* handle,
-	sepol_context_t* con);
+	sepol_context_t* con,
+	char** str_ptr);
 
 #endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsepol/src/context_record.c new/libsepol/src/context_record.c
--- old/libsepol/src/context_record.c	2005-10-31 11:09:39.000000000 -0500
+++ new/libsepol/src/context_record.c	2005-11-02 02:14:07.000000000 -0500
@@ -246,21 +246,20 @@ int sepol_context_from_string(
 	return STATUS_ERR;
 }
 
-char* sepol_context_to_string(
+int sepol_context_to_string(
 	sepol_handle_t* handle,
-	sepol_context_t* con) {
+	sepol_context_t* con,
+	char** str_ptr) {
 
+	int rc;
 	const int user_sz = strlen(con->user);
 	const int role_sz = strlen(con->role);
 	const int type_sz = strlen(con->type);
 	const int mls_sz = (con->mls)? strlen(con->mls): 0;	
-
 	const int total_sz = user_sz + role_sz + type_sz + 
 		mls_sz + ((con->mls)? 3:2);
 
-	char* str = malloc(total_sz + 1);
-	int rc;
-
+	char* str = (char*) malloc(total_sz + 1);
 	if (!str)
 		goto omem;
 	
@@ -281,14 +280,14 @@ char* sepol_context_to_string(
 		}
 	}
 
-	return str; 
+	*str_ptr = str;
+	return STATUS_SUCCESS; 
 
 	omem:
 	ERR(handle, "out of memory");
 
 	err:
 	ERR(handle, "could not convert context to string");
-	if (str)
-		free(str);
-	return NULL;
+	free(str);
+	return STATUS_ERR;
 }

--------------040907050703050105050807--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
