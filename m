Message-ID: <43DBDBE7.2030405@cornell.edu>
Date: Sat, 28 Jan 2006 14:02:31 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE,SEPOL,UTILS] Improve port/fcontext type string API
Content-Type: multipart/mixed;
 boundary="------------030402040505000409050409"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030402040505000409050409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Improve:

[semanage/sepol]_port_get_proto_str
[semanage/sepol]_fcontext_get_type_str

to take the integer code, and not the record as an argument.
This makes more sense, as the removal of several sepol FIXMEs 
demonstrate (we can get the type code from places other than the 
record... from its key, or from sepol structures). This is an API 
change, dependencies fixed in the patch.


--------------030402040505000409050409
Content-Type: text/x-patch;
 name="libsemanage.libsepol.pcoreutils.type_str_improve.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="libsemanage.libsepol.pcoreutils.type_str_improve.diff"

diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/fcontext_record.h new/libsemanage/include/semanage/fcontext_record.h
--- old/libsemanage/include/semanage/fcontext_record.h	2006-01-06 07:36:29.000000000 -0700
+++ new/libsemanage/include/semanage/fcontext_record.h	2006-01-28 13:49:25.000000000 -0700
@@ -60,7 +60,7 @@ extern int semanage_fcontext_get_type(
 	const semanage_fcontext_t* fcontext);
 
 extern const char* semanage_fcontext_get_type_str(
-	const semanage_fcontext_t* fcontext);
+	int type);
 
 extern void semanage_fcontext_set_type(
 	semanage_fcontext_t* fcontext,
diff -Naurp --exclude-from excludes old/libsemanage/include/semanage/port_record.h new/libsemanage/include/semanage/port_record.h
--- old/libsemanage/include/semanage/port_record.h	2006-01-06 07:36:29.000000000 -0700
+++ new/libsemanage/include/semanage/port_record.h	2006-01-28 13:48:53.000000000 -0700
@@ -48,7 +48,7 @@ extern void semanage_port_set_proto(
 	int proto);
 
 extern const char* semanage_port_get_proto_str(
-	const semanage_port_t* port);
+	int proto);
 
 /* Port */
 extern int semanage_port_get_low(
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontext_record.c new/libsemanage/src/fcontext_record.c
--- old/libsemanage/src/fcontext_record.c	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/fcontext_record.c	2006-01-28 13:40:03.000000000 -0700
@@ -63,7 +63,7 @@ int semanage_fcontext_key_extract(
 		fcontext->type, key_ptr) < 0) {
 		ERR(handle, "could not extract key from "
 			"file context %s (%s)", fcontext->expr, 
-			semanage_fcontext_get_type_str(fcontext));
+			semanage_fcontext_get_type_str(fcontext->type));
 		return STATUS_ERR;
 	}
 
@@ -179,10 +179,9 @@ int semanage_fcontext_get_type(
 hidden_def(semanage_fcontext_get_type)
 
 const char* semanage_fcontext_get_type_str(
-	const semanage_fcontext_t* fcontext) {
+	int type) {
 
-	switch (fcontext->type) {
-		default:
+	switch (type) {
 		case SEMANAGE_FCONTEXT_ALL:
 			return "all files";
 		case SEMANAGE_FCONTEXT_REG:
@@ -199,6 +198,8 @@ const char* semanage_fcontext_get_type_s
 			return "symbolic link";
 		case SEMANAGE_FCONTEXT_PIPE:
 			return "named pipe";
+		default:
+			return "????";
 	}
 }
 hidden_def(semanage_fcontext_get_type_str)
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontexts_file.c new/libsemanage/src/fcontexts_file.c
--- old/libsemanage/src/fcontexts_file.c	2006-01-04 10:18:17.000000000 -0700
+++ new/libsemanage/src/fcontexts_file.c	2006-01-28 13:42:55.000000000 -0700
@@ -50,10 +50,12 @@ static int fcontext_print(
 	char* con_str = NULL;
 
 	const char* expr = semanage_fcontext_get_expr(fcontext);
-	const char* type = type_str(semanage_fcontext_get_type(fcontext));
+	int type = semanage_fcontext_get_type(fcontext);
+	const char* print_str = type_str(type);
+	const char* type_str = semanage_fcontext_get_type_str(type);
 	semanage_context_t* con = semanage_fcontext_get_con(fcontext);
 
-	if (fprintf(str, "%s %s ", expr, type) < 0)
+	if (fprintf(str, "%s %s ", expr, print_str) < 0)
 		goto err;
 
 	if (con != NULL) {
@@ -70,8 +72,8 @@ static int fcontext_print(
 	return STATUS_SUCCESS;
 
 	err:
-	ERR(handle, "could not print file context "
-		"%s (%s) to stream", expr, type);
+	ERR(handle, "could not print file context for "
+		"%s (%s) to stream", expr, type_str);
 	free(con_str);
 	return STATUS_ERR;
 }
diff -Naurp --exclude-from excludes old/libsemanage/src/fcontexts_local.c new/libsemanage/src/fcontexts_local.c
--- old/libsemanage/src/fcontexts_local.c	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/fcontexts_local.c	2006-01-28 13:40:31.000000000 -0700
@@ -98,7 +98,8 @@ static int validate_handler(
 
 	/* Unpack fcontext */
 	const char* expr = semanage_fcontext_get_expr(fcon);
-	const char* type_str = semanage_fcontext_get_type_str(fcon);
+	int type = semanage_fcontext_get_type(fcon);
+	const char* type_str = semanage_fcontext_get_type_str(type);
 	semanage_context_t* con = semanage_fcontext_get_con(fcon);
 
 	if (sepol_context_check(handle->sepolh, policydb, con) < 0)
diff -Naurp --exclude-from excludes old/libsemanage/src/port_record.c new/libsemanage/src/port_record.c
--- old/libsemanage/src/port_record.c	2006-01-13 06:37:33.000000000 -0700
+++ new/libsemanage/src/port_record.c	2006-01-28 13:49:07.000000000 -0700
@@ -88,9 +88,9 @@ void semanage_port_set_proto(
 hidden_def(semanage_port_set_proto)
 
 const char* semanage_port_get_proto_str(
-	const semanage_port_t* port) {
+	int proto) {
 
-	return sepol_port_get_proto_str(port);
+	return sepol_port_get_proto_str(proto);
 }
 hidden_def(semanage_port_get_proto_str)
 
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_file.c new/libsemanage/src/ports_file.c
--- old/libsemanage/src/ports_file.c	2006-01-28 11:03:16.000000000 -0700
+++ new/libsemanage/src/ports_file.c	2006-01-28 13:47:57.000000000 -0700
@@ -29,10 +29,11 @@ static int port_print(
 
 	int low = semanage_port_get_low(port);
 	int high = semanage_port_get_high(port);
-	const char* proto = semanage_port_get_proto_str(port);
+	int proto = semanage_port_get_proto(port);
+	const char* proto_str = semanage_port_get_proto_str(proto);
 	semanage_context_t* con = semanage_port_get_con(port);
 
-	if (fprintf(str, "portcon %s ", proto) < 0)
+	if (fprintf(str, "portcon %s ", proto_str) < 0)
 		goto err;
 
 	if (low == high) {
@@ -53,7 +54,7 @@ static int port_print(
 
 	err:
 	ERR(handle, "could not print port range %u - %u (%s) to stream", 
-		low, high, proto);
+		low, high, proto_str);
 	free(con_str);
 	return STATUS_ERR;
 }
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_local.c new/libsemanage/src/ports_local.c
--- old/libsemanage/src/ports_local.c	2006-01-18 09:03:28.000000000 -0700
+++ new/libsemanage/src/ports_local.c	2006-01-28 13:39:29.000000000 -0700
@@ -95,7 +95,7 @@ int hidden semanage_port_validate_local(
 		int proto = semanage_port_get_proto(ports[i]);
 		int low = semanage_port_get_low(ports[i]);
 		int high = semanage_port_get_high(ports[i]);
-		const char* proto_str = semanage_port_get_proto_str(ports[i]); 
+		const char* proto_str = semanage_port_get_proto_str(proto); 
 		
 		const char* proto_str2;
 		int proto2, low2, high2;
@@ -109,7 +109,7 @@ int hidden semanage_port_validate_local(
 			proto2 = semanage_port_get_proto(ports[j]);
 			low2 = semanage_port_get_low(ports[j]);
 			high2 = semanage_port_get_high(ports[j]);
-			proto_str2 = semanage_port_get_proto_str(ports[j]);
+			proto_str2 = semanage_port_get_proto_str(proto2);
 
 		} while (proto != proto2);
 
diff -Naurp --exclude-from excludes old/libsemanage/src/pywrap-test.py new/libsemanage/src/pywrap-test.py
--- old/libsemanage/src/pywrap-test.py	2006-01-28 12:09:19.000000000 -0700
+++ new/libsemanage/src/pywrap-test.py	2006-01-28 13:44:02.000000000 -0700
@@ -205,7 +205,8 @@ class Tests:
 			low = semanage.semanage_port_get_low(port)
 			high = semanage.semanage_port_get_high(port)
 			con = semanage.semanage_port_get_con(port)
-			proto_str = semanage.semanage_port_get_proto_str(port)
+			proto = semanage.semanage_port_get_proto_str(port)
+			proto_str = semanage.semanage_port_get_proto_str(proto)
 			if low == high:
 				range_str = str(low)
 			else:
@@ -234,7 +235,8 @@ class Tests:
 			fcon = semanage.semanage_fcontext_by_idx(flist, idx)
 			if self.verbose: print "File Context reference: ", fcon
 			expr = semanage.semanage_fcontext_get_expr(fcon)
-			type_str = semanage.semanage_fcontext_get_type_str(fcon)
+			type = semanage.semanage_fcontext_get_type(type)
+			type_str = semanage.semanage_fcontext_get_type_str(type)
 			con = semanage.semanage_fcontext_get_con(fcon)
 			if not con: 
 				con_str = "<<none>>"
@@ -499,7 +501,8 @@ class Tests:
 		if self.verbose: print "SEPort range set: ", low, "-", high
 		
 		semanage.semanage_port_set_proto(port, semanage.SEMANAGE_PROTO_TCP);
-		if self.verbose: print "SEPort protocol set: ", semanage.semanage_port_get_proto_str(port)
+		if self.verbose: print "SEPort protocol set: ", 
+			semanage.semanage_port_get_proto_str(semanage.SEMANAGE_PROTO_TCP)
 		
 		(status, con) = semanage.semanage_context_create(sh)
 		if status < 0:
diff -Naurp --exclude-from excludes old/libsepol/include/sepol/port_record.h new/libsepol/include/sepol/port_record.h
--- old/libsepol/include/sepol/port_record.h	2006-01-06 07:36:28.000000000 -0700
+++ new/libsepol/include/sepol/port_record.h	2006-01-28 13:34:58.000000000 -0700
@@ -47,7 +47,7 @@ extern void sepol_port_set_proto(
 	int proto);
 
 extern const char* sepol_port_get_proto_str(
-	const sepol_port_t* port);
+	int proto);
 
 /* Port */
 extern int sepol_port_get_low(
diff -Naurp --exclude-from excludes old/libsepol/src/port_record.c new/libsepol/src/port_record.c
--- old/libsepol/src/port_record.c	2006-01-06 07:36:28.000000000 -0700
+++ new/libsepol/src/port_record.c	2006-01-28 13:26:18.000000000 -0700
@@ -67,7 +67,7 @@ int sepol_port_key_extract(
 		handle, port->low, port->high, port->proto, key_ptr) < 0) {
 
 		ERR(handle, "could not extract key from port %s %d:%d", 
-			sepol_port_get_proto_str(port),
+			sepol_port_get_proto_str(port->proto),
 			port->low, port->high);
 
 		return STATUS_ERR;
@@ -178,9 +178,9 @@ int sepol_port_get_proto(
 hidden_def(sepol_port_get_proto)
 
 const char* sepol_port_get_proto_str(
-	const sepol_port_t* port) {
+	int proto) {
 
-	switch (port->proto) {
+	switch (proto) {
 		case SEPOL_PROTO_UDP:
 			return "udp";
 		case SEPOL_PROTO_TCP:
diff -Naurp --exclude-from excludes old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2006-01-06 07:36:28.000000000 -0700
+++ new/libsepol/src/ports.c	2006-01-28 13:55:26.000000000 -0700
@@ -107,7 +107,7 @@ static int port_to_record (
 	int low = port->u.port.low_port;
 	int high = port->u.port.high_port;
 	context_struct_t* con = &port->context[0];
-	int rec_proto;
+	int rec_proto = -1;
 
 	sepol_context_t* tmp_con = NULL;
 	sepol_port_t* tmp_record = NULL;
@@ -132,9 +132,8 @@ static int port_to_record (
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: print protocol string */
-	ERR(handle, "could not convert port range %u - %u (protocol: %u)"
-		"to record", low, high, proto);
+	ERR(handle, "could not convert port range %u - %u (%s) "
+		"to record", low, high, sepol_port_get_proto_str(rec_proto));
 	sepol_context_free(tmp_con);
 	sepol_port_free(tmp_record);
 	return STATUS_ERR;
@@ -171,7 +170,9 @@ int sepol_port_exists (
 	ocontext_t *c, *head;
 
 	int low, high, proto;
+	const char* proto_str;
 	sepol_port_key_unpack(key, &low, &high, &proto);
+	proto_str = sepol_port_get_proto_str(proto);
 	proto = sepol2ipproto(handle, proto);
 	if (proto < 0)
 		goto err;
@@ -192,9 +193,8 @@ int sepol_port_exists (
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: print out protocol string */
-	ERR(handle, "could not check if port range %u - %u (protocol: %u) exists",
-		low, high, proto);
+	ERR(handle, "could not check if port range %u - %u (%s) exists",
+		low, high, proto_str);
 	return STATUS_ERR;
 }
 
@@ -209,7 +209,9 @@ int sepol_port_query(
 	ocontext_t *c, *l, *head;
 
 	int low, high, proto;
+	const char* proto_str;
 	sepol_port_key_unpack(key, &low, &high, &proto);
+	proto_str = sepol_port_get_proto_str(proto);
 	proto = sepol2ipproto(handle, proto);
 	if (proto < 0)
 		goto err;
@@ -231,9 +233,8 @@ int sepol_port_query(
 	return STATUS_SUCCESS;
 
 	err: 
-	/* FIXME: print protocol string */
-	ERR(handle, "could not query port range %u - %u (protocol: %u)",
-		low, high, proto);
+	ERR(handle, "could not query port range %u - %u (%s)",
+		low, high, proto_str);
 	return STATUS_ERR;
 
 }
@@ -249,7 +250,10 @@ int sepol_port_modify(
 	ocontext_t *c, *head, *prev = NULL, *port = NULL;
 
 	int low, high, proto;
+	const char* proto_str;
+
 	sepol_port_key_unpack(key, &low, &high, &proto);
+	proto_str = sepol_port_get_proto_str(proto);
 	proto = sepol2ipproto(handle, proto);	
 	if (proto < 0)
 		goto err;
@@ -286,9 +290,8 @@ int sepol_port_modify(
 	return STATUS_SUCCESS;
 
 	err:
-	/* FIXME: print protocol string */
-	ERR(handle, "could not load port range %u - %u (protocol: %u)",
-		low, high, proto);
+	ERR(handle, "could not load port range %u - %u (%s)",
+		low, high, proto_str);
 	if (port != NULL) {
 		context_destroy(&port->context[0]);
 		free(port);
diff -Naurp --exclude-from excludes old/policycoreutils/semanage/seobject.py new/policycoreutils/semanage/seobject.py
--- old/policycoreutils/semanage/seobject.py	2006-01-28 12:09:20.000000000 -0700
+++ new/policycoreutils/semanage/seobject.py	2006-01-28 13:47:21.000000000 -0700
@@ -639,16 +639,17 @@ class portRecords(semanageRecords):
 			raise ValueError("Could not list ports")
 
 		for idx in range(self.psize):
-			u = semanage_port_by_idx(self.plist, idx)
-			con = semanage_port_get_con(u)
+			port = semanage_port_by_idx(self.plist, idx)
+			con = semanage_port_get_con(port)
 			ctype = semanage_context_get_type(con)
 			if ctype == "reserved_port_t":
 				continue
 			level = semanage_context_get_mls(con)
-			proto=semanage_port_get_proto_str(u)
-			low=semanage_port_get_low(u)
-			high = semanage_port_get_high(u)
-			ddict[(low, high)]=(ctype, proto, level)
+			proto = semanage_port_get_proto(port)
+			proto_str = semanage_port_get_proto_str(proto)
+			low = semanage_port_get_low(port)
+			high = semanage_port_get_high(port)
+			ddict[(low, high)]=(ctype, proto_str, level)
 		return ddict
 
 	def get_all_by_type(self):
@@ -658,20 +659,21 @@ class portRecords(semanageRecords):
 			raise ValueError("Could not list ports")
 
 		for idx in range(self.psize):
-			u = semanage_port_by_idx(self.plist, idx)
-			con = semanage_port_get_con(u)
+			port = semanage_port_by_idx(self.plist, idx)
+			con = semanage_port_get_con(port)
 			ctype = semanage_context_get_type(con)
 			if ctype == "reserved_port_t":
 				continue
-			proto = semanage_port_get_proto_str(u)
-			low = semanage_port_get_low(u)
-			high = semanage_port_get_high(u)
-			if (ctype, proto) not in ddict.keys():
-				ddict[(ctype,proto)]=[]
+			proto = semanage_port_get_proto(port)
+			proto_str = semanage_port_get_proto_str(proto)
+			low = semanage_port_get_low(port)
+			high = semanage_port_get_high(port)
+			if (ctype, proto_str) not in ddict.keys():
+				ddict[(ctype,proto_str)]=[]
 			if low == high:
-				ddict[(ctype,proto)].append("%d" % low)
+				ddict[(ctype,proto_str)].append("%d" % low)
 			else:
-				ddict[(ctype,proto)].append("%d-%d" % (low, high))
+				ddict[(ctype,proto_str)].append("%d-%d" % (low, high))
 		return ddict
 
 	def list(self, heading=1):
@@ -1017,13 +1019,14 @@ class fcontextRecords(semanageRecords):
 
 		for idx in range(self.psize):
 			fcontext = semanage_fcontext_by_idx(self.plist, idx)
-			expr=semanage_fcontext_get_expr(fcontext)
-			ftype=semanage_fcontext_get_type_str(fcontext)
+			expr = semanage_fcontext_get_expr(fcontext)
+			ftype = semanage_fcontext_get_type(fcontext)
+			ftype_str = semanage_fcontext_get_type_str(ftype)
 			con = semanage_fcontext_get_con(fcontext)
 			if con:
-				ddict[expr, ftype]=(semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
+				ddict[expr, ftype_str] = (semanage_context_get_user(con), semanage_context_get_role(con), semanage_context_get_type(con), semanage_context_get_mls(con))
 			else:
-				ddict[expr, ftype]=con
+				ddict[expr, ftype_str] = con
 
 		return ddict
 			

--------------030402040505000409050409--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
