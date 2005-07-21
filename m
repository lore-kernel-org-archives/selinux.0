Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LK2lgA029849
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 16:02:47 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LJw8rg013603
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 19:58:08 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6LJwA0R000791
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 15:58:10 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6LJw9V09701
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 15:58:09 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6LJw9ll007768
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 15:58:09 -0400
Subject: [ libsepol 7/6] Interfaces
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-niHPeHgYL1ae0oJjgTll"
Date: Thu, 21 Jul 2005 15:55:44 -0400
Message-Id: <1121975744.9844.90.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-niHPeHgYL1ae0oJjgTll
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here's interfaces done exactly the same way as ports.

Todo:

- must decide on the length parameter - probably drop
that

- must decide what to do with shadowing/override, 
which could be useful for both ports and interfaces.

This patch depends on:
libsepol-1.1-context.diff

--=-niHPeHgYL1ae0oJjgTll
Content-Disposition: attachment; filename=libsepol-1.2-interfaces.diff
Content-Type: text/x-patch; name=libsepol-1.2-interfaces.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -p -aru libsepol.work/include/sepol/interfaces.h libsepol-1.2-interfaces/include/sepol/interfaces.h
--- libsepol.work/include/sepol/interfaces.h	2005-07-21 15:41:17.000000000 -0400
+++ libsepol-1.2-interfaces/include/sepol/interfaces.h	2005-07-21 15:40:12.000000000 -0400
@@ -0,0 +1,28 @@
+#include <sepol/policydb.h>
+#include <sepol/context.h>
+
+/* High level representation of an interface */
+typedef struct sepol_iface {
+        const char* name;
+        sepol_ctxinfo_t netif_con;
+        sepol_ctxinfo_t netmsg_con;
+} sepol_iface_t;
+
+/* Create a low level interface structure from
+ * a high level representation */
+extern int sepol_iface_create(
+	policydb_t* policydb,
+	ocontext_t** iface,
+	sepol_iface_t* data);
+
+/* Get the current context mapping for this interface */
+extern int sepol_iface_get_context(
+	policydb_t* policydb,
+	sepol_iface_t* data,
+	char** ifcon_str, size_t* ifcon_str_len,
+	char** msgcon_str, size_t* msgcon_str_len);
+
+/* Load an interface into policy */
+extern int sepol_iface_load(
+	policydb_t* policydb,
+	sepol_iface_t* data);
diff -p -aru libsepol.work/src/interfaces.c libsepol-1.2-interfaces/src/interfaces.c
--- libsepol.work/src/interfaces.c	2005-07-21 15:41:55.000000000 -0400
+++ libsepol-1.2-interfaces/src/interfaces.c	2005-07-21 15:40:23.000000000 -0400
@@ -0,0 +1,130 @@
+#include <netinet/in.h>
+#include <stdlib.h>
+
+#include "debug.h"
+#include <sepol/sepol.h>
+#include <sepol/policydb.h>
+#include <sepol/context.h>
+#include <sepol/sidtab.h>
+#include <sepol/services.h>
+#include <sepol/interfaces.h>
+
+/* Create a low level interface structure from
+ * a high level representation */
+int sepol_iface_create(
+	policydb_t* policydb,
+	ocontext_t** iface,
+	sepol_iface_t* data) {
+
+	ocontext_t* tmp_iface = NULL;
+	context_struct_t* tmp_ifcon = NULL;
+	context_struct_t* tmp_msgcon = NULL;
+
+	tmp_iface = (ocontext_t *) calloc(1, sizeof(ocontext_t));
+	if (!tmp_iface) 	
+		goto omem;
+
+	/* Name */
+	tmp_iface->u.name = strdup(data->name);
+	if (!tmp_iface->u.name)
+		goto omem;
+
+	/* Interface Context */
+	if (sepol_context_create(policydb, &tmp_ifcon, 
+		&data->netif_con) < 0)
+		goto err;
+	context_cpy(&tmp_iface->context[0], tmp_ifcon);
+	free(tmp_ifcon);
+
+	/* Message Context */
+	if (sepol_context_create(policydb, &tmp_msgcon,
+		&data->netmsg_con) < 0)
+		goto err;
+	context_cpy(&tmp_iface->context[1], tmp_msgcon);
+	free(tmp_msgcon);
+
+	*iface = tmp_iface;
+	return STATUS_SUCCESS;
+
+	omem:
+	DEBUG(__FUNCTION__, "out of memory\n");
+
+	err:
+	free(tmp_iface);
+	DEBUG(__FUNCTION__, "error creating interface structure\n");
+	return STATUS_ERR;
+}
+
+/* Get the current context mapping for this interface */
+int sepol_iface_get_context(
+	policydb_t* policydb,
+	sepol_iface_t* data,
+	char** ifcon_str, size_t* ifcon_str_len,	
+	char** msgcon_str, size_t* msgcon_str_len) {
+
+	ocontext_t *c, *head;
+
+	head = policydb->ocontexts[OCON_NETIF];
+	for (c = head; c; c = c->next) {
+		if (!strcmp(data->name, c->u.name)) { 
+			if (sepol_context_to_string(policydb, 
+				&c->context[0], ifcon_str, ifcon_str_len) < 0)
+				goto err;
+	
+			if (sepol_context_to_string(policydb,
+				&c->context[1], msgcon_str, msgcon_str_len) < 0)
+				goto err;
+
+			return STATUS_SUCCESS;
+		}
+	}
+
+	return STATUS_NODATA;
+
+	err: 
+	DEBUG(__FUNCTION__, "could not construct  context string for "
+		"interface %s\n", data->name);
+	return STATUS_ERR;
+}
+
+/* Load an interface into policy */
+int sepol_iface_load(
+	policydb_t* policydb, 
+	sepol_iface_t* data) {
+
+	ocontext_t* iface = NULL;
+	char *ifcon_str, *msgcon_str;
+	size_t ifcon_str_len, msgcon_str_len;
+	int rc;
+
+	if (sepol_iface_create(policydb, &iface, data) < 0)
+		goto err;
+
+	rc = sepol_iface_get_context(
+		policydb, data, 
+		&ifcon_str, &ifcon_str_len,
+		&msgcon_str, &msgcon_str_len);
+	if (rc < 0) 
+		goto err;
+
+#warning Is dup_match null terminated ??
+#warning if so, what's the purpose of dup_size
+	else if (rc != STATUS_NODATA) {
+		DEBUG(__FUNCTION__, "interface %s is already mapped to " 
+			"context %s with message context %s\n", 
+			data->name, ifcon_str, msgcon_str);
+		goto err;
+	}
+	
+	/* Attach to context list */
+	iface->next = policydb->ocontexts[OCON_NETIF];
+	policydb->ocontexts[OCON_NETIF] = iface;
+
+	return STATUS_SUCCESS;
+
+	err:
+	DEBUG(__FUNCTION__, "error while loading interface %s\n",
+		data->name);
+	free(iface);
+	return STATUS_ERR;
+}

--=-niHPeHgYL1ae0oJjgTll--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
