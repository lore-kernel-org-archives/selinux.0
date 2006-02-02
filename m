Message-ID: <43E22026.6070504@cornell.edu>
Date: Thu, 02 Feb 2006 10:07:18 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: [SEMANAGE][SEPOL][UTILS] Clone record on set_con
Content-Type: multipart/mixed;
 boundary="------------020002030808010604080603"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020002030808010604080603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this patch clones the context record passed to:

semanage_fcontext_set_con
[sepol/semanage]_iface_set_msgcon
[sepol/semanage]_iface_set_ifcon
[sepol/semanage]_port_set_con

This matches the behavior of the modify() function - no taking over the 
caller's objects. Less likely to run into an error this way, and it 
improves consistency. Unfortunately it also means set_con can fail, the 
failure has to be handled, and the context freed by the caller... but I 
think this is a more flexible interface (caller can reuse object if 
necessary).

This is an API change, dependency is seobject.py, fixed in this patch.

===
Patch also fixes 3 bugs in the pywrap-test, which is rather surprising - 
I do run those tests, not sure how they sneaked in.

--------------020002030808010604080603
Content-Type: text/x-patch;
 name="libsemanage.sepol.utils.clone_set_con.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.sepol.utils.clone_set_con.diff"

diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsemanage/include/semanage/fcontext_record.h new/libsemanage/include/semanage/fcontext_record.h
--- old/libsemanage/include/semanage/fcontext_record.h	2006-01-30 15:05:42.000000000 -0500
+++ new/libsemanage/include/semanage/fcontext_record.h	2006-02-02 09:34:01.000000000 -0500
@@ -70,7 +70,8 @@ extern void semanage_fcontext_set_type(
 extern semanage_context_t* semanage_fcontext_get_con(
 	const semanage_fcontext_t* fcontext);
 
-extern void semanage_fcontext_set_con(
+extern int semanage_fcontext_set_con(
+	semanage_handle_t* handle,
 	semanage_fcontext_t* fcontext, 
 	semanage_context_t* con);
 
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsemanage/include/semanage/iface_record.h new/libsemanage/include/semanage/iface_record.h
--- old/libsemanage/include/semanage/iface_record.h	2006-01-06 09:36:29.000000000 -0500
+++ new/libsemanage/include/semanage/iface_record.h	2006-02-02 06:15:50.000000000 -0500
@@ -49,14 +49,16 @@ extern int semanage_iface_set_name(
 extern semanage_context_t* semanage_iface_get_ifcon(
 	const semanage_iface_t* iface);
 
-extern void semanage_iface_set_ifcon(
+extern int semanage_iface_set_ifcon(
+	semanage_handle_t* handle,
 	semanage_iface_t* iface, 
 	semanage_context_t* con);
 
 extern semanage_context_t* semanage_iface_get_msgcon(
 	const semanage_iface_t* iface);
 
-extern void semanage_iface_set_msgcon(
+extern int semanage_iface_set_msgcon(
+	semanage_handle_t* handle,
 	semanage_iface_t* iface, 
 	semanage_context_t* con);
 
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsemanage/include/semanage/port_record.h new/libsemanage/include/semanage/port_record.h
--- old/libsemanage/include/semanage/port_record.h	2006-01-30 15:05:42.000000000 -0500
+++ new/libsemanage/include/semanage/port_record.h	2006-02-02 06:16:05.000000000 -0500
@@ -69,7 +69,8 @@ extern void semanage_port_set_range(
 extern semanage_context_t* semanage_port_get_con(
 	const semanage_port_t* port);
 
-extern void semanage_port_set_con(
+extern int semanage_port_set_con(
+	semanage_handle_t* handle,
 	semanage_port_t* port, 
 	semanage_context_t* con);
 
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsemanage/src/fcontext_record.c new/libsemanage/src/fcontext_record.c
--- old/libsemanage/src/fcontext_record.c	2006-01-30 15:05:58.000000000 -0500
+++ new/libsemanage/src/fcontext_record.c	2006-02-02 09:35:17.000000000 -0500
@@ -220,12 +220,21 @@ semanage_context_t* semanage_fcontext_ge
 }
 hidden_def(semanage_fcontext_get_con)
 
-void semanage_fcontext_set_con(
-	semanage_fcontext_t* fcontext, 
+int semanage_fcontext_set_con(
+	semanage_handle_t* handle,
+	semanage_fcontext_t* fcontext,
 	semanage_context_t* con) {
 
+	semanage_context_t* newcon;
+
+	if (semanage_context_clone(handle, con, &newcon) < 0) {
+		ERR(handle, "out of memory, could not set file context");
+		return STATUS_ERR;
+	}
+	
 	semanage_context_free(fcontext->con);
-	fcontext->con = con;
+	fcontext->con = newcon;
+	return STATUS_SUCCESS;
 }
 hidden_def(semanage_fcontext_set_con)
 
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsemanage/src/fcontexts_file.c new/libsemanage/src/fcontexts_file.c
--- old/libsemanage/src/fcontexts_file.c	2006-01-30 15:05:58.000000000 -0500
+++ new/libsemanage/src/fcontexts_file.c	2006-02-02 09:45:13.000000000 -0500
@@ -138,12 +138,13 @@ static int fcontext_parse(
 	free(str);
 	str = NULL;
 
-	semanage_fcontext_set_con(fcontext, con);
-	con = NULL;	
+	if (con && semanage_fcontext_set_con(handle, fcontext, con) < 0)
+		goto err;
 
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
 
+	semanage_context_free(con);
 	return STATUS_SUCCESS;
 
 	last:
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsemanage/src/iface_record.c new/libsemanage/src/iface_record.c
--- old/libsemanage/src/iface_record.c	2006-01-13 08:37:33.000000000 -0500
+++ new/libsemanage/src/iface_record.c	2006-02-02 06:15:19.000000000 -0500
@@ -96,11 +96,12 @@ semanage_context_t* semanage_iface_get_i
 }
 hidden_def(semanage_iface_get_ifcon)
 
-void semanage_iface_set_ifcon(
+int semanage_iface_set_ifcon(
+	semanage_handle_t* handle,
 	semanage_iface_t* iface, 
 	semanage_context_t* con) {
 
-	sepol_iface_set_ifcon(iface, con);
+	return sepol_iface_set_ifcon(handle->sepolh, iface, con);
 }
 hidden_def(semanage_iface_set_ifcon)
 
@@ -111,11 +112,12 @@ semanage_context_t* semanage_iface_get_m
 }
 hidden_def(semanage_iface_get_msgcon)
 
-void semanage_iface_set_msgcon(
+int semanage_iface_set_msgcon(
+	semanage_handle_t* handle,
 	semanage_iface_t* iface,
 	semanage_context_t* con) {
 
-	sepol_iface_set_msgcon(iface, con);
+	return sepol_iface_set_msgcon(handle->sepolh, iface, con);
 }
 hidden_def(semanage_iface_set_msgcon)
 
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsemanage/src/interfaces_file.c new/libsemanage/src/interfaces_file.c
--- old/libsemanage/src/interfaces_file.c	2006-01-30 15:05:58.000000000 -0500
+++ new/libsemanage/src/interfaces_file.c	2006-02-02 06:18:00.000000000 -0500
@@ -100,9 +100,11 @@ static int iface_parse(
 	}
 	free(str);
 	str = NULL;
-
-	semanage_iface_set_ifcon(iface, con);
-	con = NULL;	
+	
+	if (semanage_iface_set_ifcon(handle, iface, con) < 0)
+		goto err;
+	semanage_context_free(con);
+	con = NULL;
 
 	/* Message context */
 	if (parse_assert_space(handle, info) < 0)
@@ -122,9 +124,11 @@ static int iface_parse(
 	}
 	free(str);
 	str = NULL;
-	
-	semanage_iface_set_msgcon(iface, con);
-	con = NULL;
+
+	if (semanage_iface_set_msgcon(handle, iface, con) < 0)
+		goto err;
+	semanage_context_free(con);
+	con = NULL;	
 
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsemanage/src/port_record.c new/libsemanage/src/port_record.c
--- old/libsemanage/src/port_record.c	2006-01-30 15:05:58.000000000 -0500
+++ new/libsemanage/src/port_record.c	2006-02-02 06:15:23.000000000 -0500
@@ -133,11 +133,12 @@ semanage_context_t* semanage_port_get_co
 }
 hidden_def(semanage_port_get_con)
 
-void semanage_port_set_con(
+int semanage_port_set_con(
+	semanage_handle_t* handle,
 	semanage_port_t* port, 
 	semanage_context_t* con) {
 
-	sepol_port_set_con(port, con);
+	return sepol_port_set_con(handle->sepolh, port, con);
 }
 hidden_def(semanage_port_set_con)
 
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2006-01-30 15:05:58.000000000 -0500
+++ new/libsemanage/src/ports_file.c	2006-02-02 06:19:11.000000000 -0500
@@ -139,12 +139,13 @@ static int port_parse(
 	free(str);
 	str = NULL;
 
-	semanage_port_set_con(port, con);
-	con = NULL;
+	if (semanage_port_set_con(handle, port, con) < 0)
+		goto err;
 
 	if (parse_assert_space(handle, info) < 0)
 		goto err;
 
+	semanage_context_free(con);
 	return STATUS_SUCCESS;
 
 	last:
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2006-01-30 15:05:58.000000000 -0500
+++ new/libsemanage/src/pywrap-test.py	2006-02-02 09:51:45.000000000 -0500
@@ -205,7 +205,7 @@ class Tests:
 			low = semanage.semanage_port_get_low(port)
 			high = semanage.semanage_port_get_high(port)
 			con = semanage.semanage_port_get_con(port)
-			proto = semanage.semanage_port_get_proto_str(port)
+			proto = semanage.semanage_port_get_proto(port)
 			proto_str = semanage.semanage_port_get_proto_str(proto)
 			if low == high:
 				range_str = str(low)
@@ -235,7 +235,7 @@ class Tests:
 			fcon = semanage.semanage_fcontext_by_idx(flist, idx)
 			if self.verbose: print "File Context reference: ", fcon
 			expr = semanage.semanage_fcontext_get_expr(fcon)
-			type = semanage.semanage_fcontext_get_type(type)
+			type = semanage.semanage_fcontext_get_type(fcon)
 			type_str = semanage.semanage_fcontext_get_type_str(type)
 			con = semanage.semanage_fcontext_get_con(fcon)
 			if not con: 
@@ -501,7 +501,7 @@ class Tests:
 		if self.verbose: print "SEPort range set: ", low, "-", high
 		
 		semanage.semanage_port_set_proto(port, semanage.SEMANAGE_PROTO_TCP);
-		if self.verbose: print "SEPort protocol set: ", 
+		if self.verbose: print "SEPort protocol set: ", \
 			semanage.semanage_port_get_proto_str(semanage.SEMANAGE_PROTO_TCP)
 		
 		(status, con) = semanage.semanage_context_create(sh)
@@ -529,7 +529,9 @@ class Tests:
 			raise Error("Could not set context MLS fields")
 		if self.verbose: print "SEContext mls: ", semanage.semanage_context_get_mls(con)
 
-		semanage.semanage_port_set_con(port, con)
+		status = semanage.semanage_port_set_con(sh, port, con)
+		if status < 0:
+			raise Error("Could not set SEPort context")
 		if self.verbose: print "SEPort context set: ", con
 
                 (status,key) = semanage.semanage_port_key_extract(sh,port)
@@ -584,6 +586,7 @@ class Tests:
 			raise Error("Could not commit reset transaction")
 		print "Commit status (transaction number): ", status
 
+		semanage.semanage_context_free(con)
 		semanage.semanage_port_key_free(key)
 		semanage.semanage_port_free(port)
 		if exists: semanage.semanage_port_free(old_port)
@@ -629,7 +632,9 @@ class Tests:
 			raise Error("Could not set context MLS fields")
 		if self.verbose: print "SEContext mls: ", semanage.semanage_context_get_mls(con)
 
-		semanage.semanage_fcontext_set_con(fcon, con)
+		status = semanage.semanage_fcontext_set_con(sh, fcon, con)
+		if status < 0:
+			raise Error("Could not set SEFcontext context")
 		if self.verbose: print "SEFcontext context set: ", con
 
 		(status,key) = semanage.semanage_fcontext_key_extract(sh,fcon)
@@ -683,7 +688,8 @@ class Tests:
 		if status < 0:
 			raise Error("Could not commit reset transaction")
 		print "Commit status (transaction number): ", status
-	
+
+		semanage.semanage_context_free(con)	
 		semanage.semanage_fcontext_key_free(key)
 		semanage.semanage_fcontext_free(fcon)
 		if exists: semanage.semanage_fcontext_free(old_fcontext)
@@ -726,35 +732,14 @@ class Tests:
 			raise Error("Could not set interface context MLS fields")
 		if self.verbose: print "SEContext mls: ", semanage.semanage_context_get_mls(con)
 
-		semanage.semanage_iface_set_ifcon(iface, con)
-		if self.verbose: print "SEIface interface context set: ", con
-
-		(status, con) = semanage.semanage_context_create(sh)
+		status = semanage.semanage_iface_set_ifcon(sh, iface, con)
 		if status < 0:
-			raise Error("Could not create SEContext object")
-		if self.verbose: print "SEContext object created (for network interface)"
-
-		status = semanage.semanage_context_set_user(sh, con, "system_u")
-		if status < 0:
-			raise Error("Could not set message context user")
-		if self.verbose: print "SEContext user: ", semanage.semanage_context_get_user(con)
-
-		status = semanage.semanage_context_set_role(sh, con, "object_r")
-		if status < 0:
-			raise Error("Could not set message context role")
-		if self.verbose: print "SEContext role: ", semanage.semanage_context_get_role(con)
-
-		status = semanage.semanage_context_set_type(sh, con, "default_t")
-		if status < 0:
-			raise Error("Could not set message context type")
-		if self.verbose: print "SEContext type: ", semanage.semanage_context_get_type(con)
+			raise Error("Could not set SEIface interface context")
+		if self.verbose: print "SEIface interface context set: ", con
 
-		status = semanage.semanage_context_set_mls(sh, con, "s0:c0.c255")
+		status = semanage.semanage_iface_set_msgcon(sh, iface, con)
 		if status < 0:
-			raise Error("Could not set message context MLS fields")
-		if self.verbose: print "SEContext mls: ", semanage.semanage_context_get_mls(con)
-
-		semanage.semanage_iface_set_msgcon(iface, con)
+			raise Error("Could not set SEIface message context")
 		if self.verbose: print "SEIface message context set: ", con
 
 		(status,key) = semanage.semanage_iface_key_extract(sh,iface)
@@ -809,6 +794,7 @@ class Tests:
 			raise Error("Could not commit reset transaction")
 		print "Commit status (transaction number): ", status
 
+		semanage.semanage_context_free(con)
 		semanage.semanage_iface_key_free(key)
 		semanage.semanage_iface_free(iface)
 		if exists: semanage.semanage_iface_free(old_iface)
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsepol/include/sepol/iface_record.h new/libsepol/include/sepol/iface_record.h
--- old/libsepol/include/sepol/iface_record.h	2006-01-06 09:36:28.000000000 -0500
+++ new/libsepol/include/sepol/iface_record.h	2006-02-02 06:12:00.000000000 -0500
@@ -48,14 +48,16 @@ extern int sepol_iface_set_name(
 extern sepol_context_t* sepol_iface_get_ifcon(
 	const sepol_iface_t* iface);
 
-extern void sepol_iface_set_ifcon(
+extern int sepol_iface_set_ifcon(
+	sepol_handle_t* handle,
 	sepol_iface_t* iface, 
 	sepol_context_t* con);
 
 extern sepol_context_t* sepol_iface_get_msgcon(
 	const sepol_iface_t* iface);
 
-extern void sepol_iface_set_msgcon(
+extern int sepol_iface_set_msgcon(
+	sepol_handle_t* handle,
 	sepol_iface_t* iface, 
 	sepol_context_t* con);
 
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsepol/include/sepol/port_record.h new/libsepol/include/sepol/port_record.h
--- old/libsepol/include/sepol/port_record.h	2006-01-30 15:05:10.000000000 -0500
+++ new/libsepol/include/sepol/port_record.h	2006-02-02 06:11:30.000000000 -0500
@@ -68,7 +68,8 @@ extern void sepol_port_set_range(
 extern sepol_context_t* sepol_port_get_con(
 	const sepol_port_t* port);
 
-extern void sepol_port_set_con(
+extern int sepol_port_set_con(
+	sepol_handle_t* handle,
 	sepol_port_t* port, 
 	sepol_context_t* con);
 
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsepol/src/iface_record.c new/libsepol/src/iface_record.c
--- old/libsepol/src/iface_record.c	2006-01-06 09:36:28.000000000 -0500
+++ new/libsepol/src/iface_record.c	2006-02-02 06:13:33.000000000 -0500
@@ -141,12 +141,21 @@ sepol_context_t* sepol_iface_get_ifcon(
 }
 hidden_def(sepol_iface_get_ifcon)
 
-void sepol_iface_set_ifcon(
-	sepol_iface_t* iface, 
+int sepol_iface_set_ifcon(
+	sepol_handle_t* handle,
+	sepol_iface_t* iface,
 	sepol_context_t* con) {
 
+	sepol_context_t* newcon;
+
+	if (sepol_context_clone(handle, con, &newcon) < 0) {
+		ERR(handle, "out of memory, could not set interface context");
+		return STATUS_ERR;
+	}
+
 	sepol_context_free(iface->netif_con);
-	iface->netif_con = con;
+	iface->netif_con = newcon;
+	return STATUS_SUCCESS;
 }
 hidden_def(sepol_iface_set_ifcon)
 
@@ -158,12 +167,20 @@ sepol_context_t* sepol_iface_get_msgcon(
 }
 hidden_def(sepol_iface_get_msgcon)
 
-void sepol_iface_set_msgcon(
-	sepol_iface_t* iface, 
+int sepol_iface_set_msgcon(
+	sepol_handle_t* handle,
+	sepol_iface_t* iface,
 	sepol_context_t* con) {
 
+	sepol_context_t* newcon;
+	if (sepol_context_clone(handle, con, &newcon) < 0) {
+		ERR(handle, "out of memory, could not set message context");
+		return STATUS_ERR;
+	}
+
 	sepol_context_free(iface->netmsg_con);
-	iface->netmsg_con = con;
+	iface->netmsg_con = newcon;
+	return STATUS_SUCCESS;
 }
 hidden_def(sepol_iface_set_msgcon)
 
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2006-01-06 09:36:28.000000000 -0500
+++ new/libsepol/src/interfaces.c	2006-02-02 06:11:02.000000000 -0500
@@ -85,12 +85,16 @@ static int iface_to_record (
 
 	if (context_to_record(handle, policydb, ifcon, &tmp_con) < 0)
 		goto err;
-	sepol_iface_set_ifcon(tmp_record, tmp_con);
+	if (sepol_iface_set_ifcon(handle, tmp_record, tmp_con) < 0)
+		goto err;
+	sepol_context_free(tmp_con);
 	tmp_con = NULL;
-
+	
 	if (context_to_record(handle, policydb, msgcon, &tmp_con) < 0)
 		goto err;
-	sepol_iface_set_msgcon(tmp_record, tmp_con);
+	if (sepol_iface_set_msgcon(handle, tmp_record, tmp_con) < 0)
+		goto err;
+	sepol_context_free(tmp_con);
 	tmp_con = NULL;
 
 	*record = tmp_record;
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsepol/src/port_record.c new/libsepol/src/port_record.c
--- old/libsepol/src/port_record.c	2006-01-30 15:05:29.000000000 -0500
+++ new/libsepol/src/port_record.c	2006-02-02 06:12:57.000000000 -0500
@@ -270,11 +270,20 @@ sepol_context_t* sepol_port_get_con(
 }
 hidden_def(sepol_port_get_con)
 
-void sepol_port_set_con(
+int sepol_port_set_con(
+	sepol_handle_t* handle,
 	sepol_port_t* port, 
 	sepol_context_t* con) {
 
+	sepol_context_t* newcon;
+
+	if (sepol_context_clone(handle, con, &newcon) < 0) {
+		ERR(handle, "out of memory, could not set port context");
+		return STATUS_ERR;
+	}
+
 	sepol_context_free(port->con);
-	port->con = con;
+	port->con = newcon;
+	return STATUS_SUCCESS;
 }
 hidden_def(sepol_port_set_con)
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2006-01-30 15:05:29.000000000 -0500
+++ new/libsepol/src/ports.c	2006-02-02 06:08:08.000000000 -0500
@@ -125,9 +125,10 @@ static int port_to_record (
 	if (context_to_record(handle, policydb, con, &tmp_con) < 0)
 		goto err;
 
-	sepol_port_set_con(tmp_record, tmp_con);
-	tmp_con = NULL;
+	if (sepol_port_set_con(handle, tmp_record, tmp_con) < 0)
+		goto err;
 
+	sepol_context_free(tmp_con);
 	*record = tmp_record;
 	return STATUS_SUCCESS;
 
diff -Naurp --exclude semanageswig.i --exclude-from excludes old/policycoreutils/semanage/seobject.py new/policycoreutils/semanage/seobject.py
--- old/policycoreutils/semanage/seobject.py	2006-01-30 15:06:07.000000000 -0500
+++ new/policycoreutils/semanage/seobject.py	2006-02-02 09:55:44.000000000 -0500
@@ -549,7 +549,9 @@ class portRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not set mls fields in port context for %s/%s" % (proto, port))
 
-		semanage_port_set_con(p, con)
+		rc = semanage_port_set_con(self.sh, p, con)
+		if rc < 0:
+			raise ValueError("Could not set port context for %s/%s" % (proto, port))
 
 		rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
@@ -563,6 +565,7 @@ class portRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not add port %s/%s" % (proto, port))
 
+		semanage_context_free(con)
 		semanage_port_key_free(k)
 		semanage_port_free(p)
 
@@ -737,12 +740,13 @@ class interfaceRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not set mls fields in interface context for %s" % interface)
 
-		(rc, con2) = semanage_context_clone(self.sh, con)
+		rc = semanage_iface_set_ifcon(self.sh, iface, con)
 		if rc < 0:
-			raise ValueError("Could not clone interface context for %s" % interface)
+			raise ValueError("Could not set interface context for %s" % interface)
 
-		semanage_iface_set_ifcon(iface, con)
-		semanage_iface_set_msgcon(iface, con2)
+		rc = semanage_iface_set_msgcon(self.sh, iface, con)
+		if rc < 0:
+			raise ValueError("Could not set message context for %s" % interface)
 
 		rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
@@ -756,6 +760,7 @@ class interfaceRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not add interface %s" % interface)
 
+		semanage_context_free(con)
 		semanage_iface_key_free(k)
 		semanage_iface_free(iface)
 
@@ -921,7 +926,10 @@ class fcontextRecords(semanageRecords):
 			raise ValueError("Could not set mls fields in file context for %s" % target)
 
 		semanage_fcontext_set_type(fcontext, self.file_types[ftype])
-		semanage_fcontext_set_con(fcontext, con)
+
+		rc = semanage_fcontext_set_con(self.sh, fcontext, con)
+		if rc < 0:
+			raise ValueError("Could not set file context for %s" % target)
 
 		rc = semanage_begin_transaction(self.sh)
 		if rc < 0:
@@ -935,6 +943,7 @@ class fcontextRecords(semanageRecords):
 		if rc < 0:
 			raise ValueError("Could not add file context for %s" % target)
 
+		semanage_context_free(con)
 		semanage_fcontext_key_free(k)
 		semanage_fcontext_free(fcontext)
 

--------------020002030808010604080603--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
