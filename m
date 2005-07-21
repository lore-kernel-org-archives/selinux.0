Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LHrkgA028188
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:53:47 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LHmNBa026704
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 17:48:23 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6LHnA9f020683
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:49:10 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6LHnAV32466
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:49:10 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6LHnAll028256
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:49:10 -0400
Subject: [ libsepol 4/6] Booleans
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-XGBBnwmaYBHpz0VeoEyp"
Date: Thu, 21 Jul 2005 13:46:45 -0400
Message-Id: <1121968005.9844.36.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-XGBBnwmaYBHpz0VeoEyp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch is intended to replace
genbools.c (but not yet). It provides functions 
to load booleans into a policydb object. It
uses a structure (sepol_boolinfo_t) as the higher
level representation for a boolean, and takes
out file operations and parsing.

libsepol-bools.diff


--=-XGBBnwmaYBHpz0VeoEyp
Content-Disposition: attachment; filename=libsepol-bools.diff
Content-Type: text/x-patch; name=libsepol-bools.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -aru libsepol.work/include/sepol/booleans.h libsepol-bools/include/sepol/booleans.h
--- libsepol.work/include/sepol/booleans.h	2005-07-04 06:38:12.000000000 -0400
+++ libsepol-bools/include/sepol/booleans.h	2005-07-21 08:49:13.000000000 -0400
@@ -0,0 +1,23 @@
+#ifndef _SEPOL_BOOLEANS_H_
+#define _SEPOL_BOOLEANS_H_
+
+#include <sepol/policydb.h>
+
+/* High level representation of a boolean */
+typedef struct sepol_boolinfo {
+	char* name;
+	int value;
+} sepol_boolinfo_t;
+
+/* Load a boolean into the policy */
+extern int sepol_bool_load (
+	policydb_t* policydb, 
+	sepol_boolinfo_t* boolean);
+
+/* Load a boolean array into the policy */
+extern int sepol_bool_load_array(
+	policydb_t* policydb,
+	sepol_boolinfo_t* bool_arr,
+	int bool_arr_len);
+
+#endif /* _SEPOL_BOOLEANS_H_ */
diff -aru libsepol.work/src/booleans.c libsepol-bools/src/booleans.c
--- libsepol.work/src/booleans.c	2005-07-04 06:38:26.000000000 -0400
+++ libsepol-bools/src/booleans.c	2005-07-21 08:49:32.000000000 -0400
@@ -0,0 +1,79 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include "private.h"
+#include "debug.h"
+
+#include <sepol/booleans.h>
+#include <sepol/hashtab.h>
+#include <sepol/policydb.h>
+#include <sepol/conditional.h>
+
+static inline int bool_update (
+	policydb_t* policydb,
+	sepol_boolinfo_t* boolean) {
+
+	cond_bool_datum_t *datum = 
+		hashtab_search(policydb->p_bools.table, boolean->name);
+	if (!datum) {
+		DEBUG(__FUNCTION__, "boolean %s no longer in policy\n",
+			boolean->name);
+		return STATUS_ERR;
+        }
+	if (boolean->value != 0 && boolean->value != 1) {
+		DEBUG(__FUNCTION__, "illegal value %d for boolean %s\n",
+			boolean->value, boolean->name);
+		return STATUS_ERR;
+        }
+        datum->state = boolean->value;
+	return STATUS_SUCCESS;
+}
+
+int sepol_bool_load (
+	policydb_t* policydb, sepol_boolinfo_t* boolean) {
+
+	if (bool_update(policydb, boolean) < 0)
+		goto err;	
+	
+        if (evaluate_conds(policydb) < 0) {
+		DEBUG(__FUNCTION__, "error while re-evaluating conditionals\n");
+		goto err;
+	}
+
+	return STATUS_SUCCESS;
+
+	err:
+	DEBUG(__FUNCTION__, "could not load boolean %s\n", boolean->name);
+	errno = EINVAL;
+	return STATUS_ERR;
+}
+
+int sepol_bool_load_array(
+	policydb_t* policydb,
+	sepol_boolinfo_t* bool_arr,
+	int bool_arr_len) {	
+
+	int i, errors = 0;
+
+	for (i = 0; i < bool_arr_len; i++)
+		if (bool_update(policydb, &bool_arr[i]) < 0) {
+			errors++;
+			continue;
+		}	
+
+	if (evaluate_conds(policydb) < 0) {
+		DEBUG("%s: error while re-evaluating conditionals\n", 
+			__FUNCTION__);
+		goto err;
+	}
+
+	if (errors) 
+		goto err;
+
+	return STATUS_SUCCESS;
+	err:
+	errno = EINVAL;
+	DEBUG("%s: error while loading booleans\n", __FUNCTION__);
+	return STATUS_ERR;
+}

--=-XGBBnwmaYBHpz0VeoEyp--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
