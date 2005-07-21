Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LHl3gA028103
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:47:03 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LHgPrg027868
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 17:42:26 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6LHgRlK018328
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:42:27 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6LHgQV30259
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:42:26 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6LHgQll027659
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:42:26 -0400
Subject: [ libsepol 2/6] Ports
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-WwKyqdmNdl7UdQXgUChI"
Date: Thu, 21 Jul 2005 13:40:01 -0400
Message-Id: <1121967601.9844.26.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WwKyqdmNdl7UdQXgUChI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch pushes the port loading
code into libsepol. It adds a function to
load a port, and a function to get the context
for a port. No shadowing is allowed. It creates
a structure for high level representation of
a port (sepol_portinfo_t). Uses new debug system
and writes to policydb object. Comments welcome.

libsepol-1.2-ports.diff

This patch depends on:
libsepol-1.1-context.diff



--=-WwKyqdmNdl7UdQXgUChI
Content-Disposition: attachment; filename=libsepol-1.2-ports.diff
Content-Type: text/x-patch; name=libsepol-1.2-ports.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -aru libsepol.work/include/sepol/ports.h libsepol-1.2-ports/include/sepol/ports.h
--- libsepol.work/include/sepol/ports.h	2005-07-08 19:30:00.000000000 -0400
+++ libsepol-1.2-ports/include/sepol/ports.h	2005-07-21 08:48:52.000000000 -0400
@@ -0,0 +1,42 @@
+#ifndef _SEPOL_PORTS_H_
+#define _SEPOL_PORTS_H_
+
+#include <sepol/policydb.h>
+#include <sepol/context.h>
+
+#define SEPOL_TCP_PROTO 0
+#define SEPOL_UDP_PROTO 1
+
+/* High level representation of a port */
+typedef struct sepol_portinfo {
+
+	/* Port parameters */
+	int protocol;
+	int low, high;
+
+	/* Sufficient information to construct 
+	 * the port context */
+	sepol_ctxinfo_t con;
+} sepol_portinfo_t;
+
+/* Create a port structure from high level representation */
+extern int sepol_port_create(
+	policydb_t* policydb,
+	ocontext_t** port,
+	sepol_portinfo_t* data);
+
+/* Get the current context mapping
+ * for this port. Returns 1 if no match, -1 on error, 0 on
+ * success. The returned data is allocated on the heap */
+int sepol_port_get_context(
+	policydb_t* policydb,
+	sepol_portinfo_t* data,
+	char** con_str,
+	size_t* con_str_len);
+
+/* Load the given port into policy. No shadowing is allowed. */
+extern int sepol_port_load(
+	policydb_t* policydb, 
+	sepol_portinfo_t* port);
+
+#endif /* _SEPOL_PORTS_H_ */
diff -aru libsepol.work/src/ports.c libsepol-1.2-ports/src/ports.c
--- libsepol.work/src/ports.c	2005-07-08 19:30:04.000000000 -0400
+++ libsepol-1.2-ports/src/ports.c	2005-07-21 12:19:19.000000000 -0400
@@ -0,0 +1,167 @@
+#include <netinet/in.h>
+#include <stdlib.h>
+
+#include "debug.h"
+#include <sepol/sepol.h>
+#include <sepol/policydb.h>
+#include <sepol/context.h>
+#include <sepol/sidtab.h>
+#include <sepol/services.h>
+#include <sepol/ports.h>
+
+static const char* proto_to_str(int proto) {
+	switch(proto) {
+		case SEPOL_TCP_PROTO:
+			return "TCP";
+		case SEPOL_UDP_PROTO:
+			return "UDP";
+		default:
+			return "???";
+	}
+}
+
+static int sepol2ipproto(int proto) {
+	switch(proto) {
+		case SEPOL_TCP_PROTO:
+			return IPPROTO_TCP;
+		case SEPOL_UDP_PROTO:
+			return IPPROTO_UDP;
+		default:
+			DEBUG(__FUNCTION__, "unsupported protocol %d\n",
+                                proto);
+			return -1;
+	}
+}
+
+/* Create a low level port structure from
+ * a high level representation */
+int sepol_port_create(
+	policydb_t* policydb,
+	ocontext_t** port,
+	sepol_portinfo_t* data) {
+
+	ocontext_t* tmp_port = NULL;
+	context_struct_t* tmp_con = NULL;
+	int tmp_proto;
+
+	tmp_port = (ocontext_t *) calloc(1, sizeof(ocontext_t));
+	if (!tmp_port) {
+		DEBUG(__FUNCTION__, "out of memory\n");
+		goto err;
+	}
+	
+	/* Process protocol */
+	tmp_proto = sepol2ipproto(data->protocol);
+	if (tmp_proto < 0)
+		goto err;
+	tmp_port->u.port.protocol = tmp_proto;
+
+	/* Port range */
+	tmp_port->u.port.low_port = data->low;
+	tmp_port->u.port.high_port = data->high;
+	if (data->low > data->high) {
+		DEBUG(__FUNCTION__, "low port %d exceeds high port %d\n",
+			data->low, data->high);
+		goto err;
+	}
+
+	/* Context */
+	if (sepol_context_create(policydb, &tmp_con, &data->con) < 0)
+		goto err;
+	context_cpy(&tmp_port->context[0], tmp_con);
+	free(tmp_con);
+
+	*port = tmp_port;
+	return STATUS_SUCCESS;
+
+	err:
+	free(tmp_port);
+	DEBUG(__FUNCTION__, "error creating port structure\n");
+	return STATUS_ERR;
+}
+
+/* Get the current context mapping for this port */
+int sepol_port_get_context(
+	policydb_t* policydb,
+	sepol_portinfo_t* data,
+	char** con_str,	
+	size_t* con_str_len) {
+
+	int low = data->low;	
+	int high = data->high;
+
+	int proto = sepol2ipproto(data->protocol);
+	if (proto < 0)
+		goto err;
+
+	ocontext_t *c, *l, *head;
+
+	head = policydb->ocontexts[OCON_PORT];
+	for (l = NULL, c = head; c; l = c, c = c->next) {
+		int proto2 = c->u.port.protocol;
+		int low2 = c->u.port.low_port;
+		int high2 = c->u.port.high_port;
+		context_struct_t* con2 = &c->context[0];
+
+		if (proto != proto2)
+			continue;
+
+		if ((low == low2 && high == high2) ||
+		    (low2 <= low && high2 >= high)) {
+			if (sepol_context_to_string(policydb, con2, 
+				con_str, con_str_len) < 0)
+				goto err;		
+	
+			return STATUS_SUCCESS;
+		}
+	}
+
+	return STATUS_NODATA;
+
+	err: 
+	DEBUG(__FUNCTION__, "could not retrieve context string for "
+		"port entry %s %d-%d\n", proto_to_str(data->protocol), 
+			low, high);
+	return STATUS_ERR;
+
+}
+
+/* Load a port into policy */
+int sepol_port_load(
+	policydb_t* policydb, 
+	sepol_portinfo_t* data) {
+
+	ocontext_t* port = NULL;
+	char* dup_match;
+	size_t dup_size; 
+	int rc;
+
+	if (sepol_port_create(policydb, &port, data) < 0)
+		goto err;
+
+	rc = sepol_port_get_context(policydb, data, &dup_match, &dup_size);
+	if (rc < 0) 
+		goto err;
+
+#warning Is dup_match null terminated ??
+#warning if so, what's the purpose of dup_size
+	else if (rc != STATUS_NODATA) {
+		DEBUG(__FUNCTION__, "port entry for %s %d-%d "
+			"is already mapped to context %s\n",
+			proto_to_str(data->protocol), 
+			data->low, data->high, dup_match);
+		goto err;
+	}
+	
+	/* Attach to context list */
+	port->next = policydb->ocontexts[OCON_PORT];
+	policydb->ocontexts[OCON_PORT] = port;
+
+	return STATUS_SUCCESS;
+
+	err:
+	DEBUG(__FUNCTION__, "error while loading port %s %d-%d\n",
+		proto_to_str(data->protocol), data->low, data->high);
+	free(port);
+	return STATUS_ERR;
+}

--=-WwKyqdmNdl7UdQXgUChI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
