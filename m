Message-Id: <20071107205333.697495852@manicmethod.com>
References: <20071107205047.102519666@manicmethod.com>
Date: Wed, 07 Nov 2007 15:50:49 -0500
From: "Joshua Brindle" <method@manicmethod.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, paul.moore@hp.com
Subject: [patch 2/2] Peersid capability support
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Peersid capability support, keys the peersid capability on the peer object class.

---
 libsepol/src/polcaps.c |   26 ++++++++++++++++++++++++++
 libsepol/src/polcaps.h |    8 ++++++++
 libsepol/src/write.c   |    3 +++
 3 files changed, 37 insertions(+)

--- /dev/null
+++ trunk/libsepol/src/polcaps.c
@@ -0,0 +1,26 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include <sepol/policydb/policydb.h>
+#include "polcaps.h"
+
+int sepol_setup_capabilities(policydb_t *pol)
+{
+
+	if (!pol)
+		return POLICYDB_ERROR;
+
+	/* Each capability should be keyed in some way, 
+	 * such as the existance of an object class */
+
+	/* POLICYDB_CAPABILITY_NETPEER */
+	if (hashtab_search(pol->symtab[SYM_CLASSES].table, "peer")) {
+		if (ebitmap_set_bit(&pol->policycaps, 
+				POLICY_CAPABILITY_NETPEER, 1))
+			return POLICYDB_ERROR;
+	}
+
+	return POLICYDB_SUCCESS;
+
+}
--- /dev/null
+++ trunk/libsepol/src/polcaps.h
@@ -0,0 +1,8 @@
+#ifndef _SEPOL_INTERNAL_POLCAP_H_
+#define _SEPOL_INTERNAL_POLCAP_H_
+
+extern int sepol_setup_capabilities(policydb_t *pol);
+
+#define POLICY_CAPABILITY_NETPEER 1
+
+#endif
--- trunk.orig/libsepol/src/write.c
+++ trunk/libsepol/src/write.c
@@ -44,6 +44,7 @@
 #include "debug.h"
 #include "private.h"
 #include "mls.h"
+#include "polcaps.h"
 
 struct policy_data {
 	struct policy_file *fp;
@@ -1577,6 +1578,8 @@ int policydb_write(policydb_t * p, struc
 		return POLICYDB_ERROR;
 
 	if (p->policyvers >= POLICYDB_VERSION_POLCAP) {
+		if (sepol_setup_capabilities(p))
+			return POLICYDB_ERROR;
 		if (ebitmap_write(&p->policycaps, fp) == -1)
 			return POLICYDB_ERROR;
 	}

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
