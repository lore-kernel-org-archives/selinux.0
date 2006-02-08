Message-ID: <43E9AAC1.804@cornell.edu>
Date: Wed, 08 Feb 2006 03:24:33 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE][SEPOL] Minor cleanups
Content-Type: multipart/mixed;
 boundary="------------030703010208070802000107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030703010208070802000107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is left over after my other patches are applied...
- port and interface list traversals are confusing because of unneded 
variable
- increase verbosity in some error messages
- semanage: don't shadow type_str the function to keep gcc happy






--------------030703010208070802000107
Content-Type: text/x-patch;
 name="libsemanage.sepol.cleanups.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.sepol.cleanups.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/fcontexts_file.c new/libsemanage/src/fcontexts_file.c
--- old/libsemanage/src/fcontexts_file.c	2006-02-08 03:13:23.000000000 -0500
+++ new/libsemanage/src/fcontexts_file.c	2006-02-04 02:05:59.000000000 -0500
@@ -52,7 +52,7 @@ static int fcontext_print(
 	const char* expr = semanage_fcontext_get_expr(fcontext);
 	int type = semanage_fcontext_get_type(fcontext);
 	const char* print_str = type_str(type);
-	const char* type_str = semanage_fcontext_get_type_str(type);
+	const char* tstr = semanage_fcontext_get_type_str(type);
 	semanage_context_t* con = semanage_fcontext_get_con(fcontext);
 
 	if (fprintf(str, "%s %s ", expr, print_str) < 0)
@@ -73,7 +73,7 @@ static int fcontext_print(
 
 	err:
 	ERR(handle, "could not print file context for "
-		"%s (%s) to stream", expr, type_str);
+		"%s (%s) to stream", expr, tstr);
 	free(con_str);
 	return STATUS_ERR;
 }
diff -Naurp --exclude-from excludes old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2006-02-08 03:13:24.000000000 -0500
+++ new/libsepol/src/interfaces.c	2006-02-03 19:34:08.000000000 -0500
@@ -248,11 +248,11 @@ int sepol_iface_iterate(
 	void* arg) {
 
 	const policydb_t *policydb = &p->p;
-	ocontext_t *c, *l, *head;
+	ocontext_t *c, *head;
 	sepol_iface_t* iface = NULL;
 
 	head = policydb->ocontexts[OCON_NETIF];
-	for (l = NULL, c = head; c; l = c, c = c->next) {
+	for (c = head; c; c = c->next) {
 		int status;
 
 		if (iface_to_record(handle, policydb, c, &iface) < 0)
diff -Naurp --exclude-from excludes old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2006-02-08 03:13:24.000000000 -0500
+++ new/libsepol/src/ports.c	2006-02-03 20:25:06.000000000 -0500
@@ -51,19 +51,23 @@ static int port_from_record(
 	context_struct_t* tmp_con = NULL;
 	int tmp_proto;
 
+	int low = sepol_port_get_low(data);
+	int high = sepol_port_get_high(data);
+	int proto = sepol_port_get_proto(data);
+
 	tmp_port = (ocontext_t *) calloc(1, sizeof(ocontext_t));
 	if (!tmp_port) 
 		goto omem;
 	
 	/* Process protocol */
-	tmp_proto = sepol2ipproto(handle, sepol_port_get_proto(data));
+	tmp_proto = sepol2ipproto(handle, proto);
 	if (tmp_proto < 0)
 		goto err;
 	tmp_port->u.port.protocol = tmp_proto;
 
 	/* Port range */
-	tmp_port->u.port.low_port = sepol_port_get_low(data);
-	tmp_port->u.port.high_port = sepol_port_get_high(data);
+	tmp_port->u.port.low_port = low;
+	tmp_port->u.port.high_port = high;
 	if (tmp_port->u.port.low_port > tmp_port->u.port.high_port) {
 		ERR(handle, "low port %d exceeds high port %d",
 			tmp_port->u.port.low_port, 
@@ -93,7 +97,8 @@ static int port_from_record(
         }
 	context_destroy(tmp_con);
 	free(tmp_con);
-	ERR(handle, "error creating port structure");
+	ERR(handle, "could not create port structure for range %u:%u (%s)",
+		low, high, sepol_port_get_proto_str(proto));
 	return STATUS_ERR;
 }
 
@@ -207,7 +212,7 @@ int sepol_port_query(
 	sepol_port_t** response) {
 
 	const policydb_t *policydb = &p->p;
-	ocontext_t *c, *l, *head;
+	ocontext_t *c, *head;
 
 	int low, high, proto;
 	const char* proto_str;
@@ -218,7 +223,7 @@ int sepol_port_query(
 		goto err;
 
 	head = policydb->ocontexts[OCON_PORT];
-	for (l = NULL, c = head; c; l = c, c = c->next) {
+	for (c = head; c; c = c->next) {
 		int proto2 = c->u.port.protocol;
 		int low2 = c->u.port.low_port;
 		int high2 = c->u.port.high_port;
@@ -309,11 +314,11 @@ int sepol_port_iterate(
 	void* arg) {
 
 	const policydb_t *policydb = &p->p;
-	ocontext_t *c, *l, *head;
+	ocontext_t *c, *head;
 	sepol_port_t* port = NULL;	
 
 	head = policydb->ocontexts[OCON_PORT];
-	for (l = NULL, c = head; c; l = c, c = c->next) {
+	for (c = head; c; c = c->next) {
 		int status;
 
 		if (port_to_record(handle, policydb, c, &port) < 0)

--------------030703010208070802000107--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
