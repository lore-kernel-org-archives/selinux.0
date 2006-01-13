Message-ID: <43C785BE.10300@cornell.edu>
Date: Fri, 13 Jan 2006 03:49:34 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEMANAGE] Disallow overlap of local port ranges
Content-Type: multipart/mixed;
 boundary="------------030400090509010805050307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030400090509010805050307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, this patch disallows overlapping port ranges in the local store, in 
the form of a commit validate run, where the ports are sorted and tested 
for overlap. The patch will not allow any kind of overlap, not just 
complete shadow. This was a feature requested by Joshua, since relying 
on the add() order for precedence seemed non-intuitive. Also, I'm not 
sure how useful overlapping ranges are to the local store - they seem 
more useful in the base policy where you want to set a default range of 
ports.

Overlap is still allowed in base policy, and local ranges are allowed to 
overlap (and shadow) base as well - they always take precedence.

=========
There is another problem related to ports, which is harder to solve - we 
want to remove the ordering significance of list() and iterate() - they 
should not show overlapping ranges (those still exist, because of the 
overlaps with policy). An example of why this is a problem is Dan's 
latest version of the semanage tool - it's in rawhide, but not 
upstreamed yet. He alphabetizes the ports by context, which does not 
provide any clue about order and precedence to the user (and I'm not 
sure the user should care about those things anyway - it seems 
reasonable to hide overlaps ). The tool shows 1-1023 as reserved, and 
ports displayed both below and above that are in the same (reserved) 
range, which seems confusing to me. Not sure how to resolve this problem...


--------------030400090509010805050307
Content-Type: text/x-patch;
 name="libsemanage.no_port_overlap.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.no_port_overlap.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/direct_api.c new/libsemanage/src/direct_api.c
--- old/libsemanage/src/direct_api.c	2006-01-12 04:29:52.000000000 -0700
+++ new/libsemanage/src/direct_api.c	2006-01-13 03:18:47.000000000 -0700
@@ -382,7 +382,8 @@ static int semanage_direct_commit(semana
 	sepol_policydb_t* out = NULL;
 
 	/* Declare some variables */
-	int modified, fcontexts_modified, seusers_modified, users_extra_modified;
+	int modified, fcontexts_modified, ports_modified, 
+		seusers_modified, users_extra_modified;
 	dbase_config_t* users = semanage_user_dbase_local(sh);
         dbase_config_t* users_base = semanage_user_base_dbase_local(sh);
         dbase_config_t* users_extra = semanage_user_extra_dbase_local(sh);
@@ -403,10 +404,11 @@ static int semanage_direct_commit(semana
 	fcontexts_modified = fcontexts->dtable->is_modified(fcontexts->dbase);
 	seusers_modified = seusers->dtable->is_modified(seusers->dbase);
 	users_extra_modified = users_extra->dtable->is_modified(users_extra->dbase);
+	ports_modified = ports->dtable->is_modified(ports->dbase);
 
 	modified = sh->modules_modified;
+	modified |= ports_modified;
 	modified |= users->dtable->is_modified(users_base->dbase);
-	modified |= ports->dtable->is_modified(ports->dbase);
 	modified |= bools->dtable->is_modified(bools->dbase);
 	modified |= ifaces->dtable->is_modified(ifaces->dbase);
 
@@ -479,6 +481,12 @@ static int semanage_direct_commit(semana
 			goto cleanup;
 	}
 
+	/* Validate local ports for overlap */
+	if (sh->do_rebuild || ports_modified) {
+		if (semanage_port_validate_local(sh) < 0)
+			goto cleanup;
+	}
+
 	/* Commit changes to components */
 	if (semanage_commit_components(sh) < 0)
 		goto cleanup;
diff -Naurp --exclude-from excludes old/libsemanage/src/port_internal.h new/libsemanage/src/port_internal.h
--- old/libsemanage/src/port_internal.h	2006-01-06 07:36:30.000000000 -0700
+++ new/libsemanage/src/port_internal.h	2006-01-13 03:13:20.000000000 -0700
@@ -42,4 +42,13 @@ extern int port_policydb_dbase_init(
 extern void port_policydb_dbase_release(
 	dbase_config_t* dconfig);
 
+extern int hidden semanage_port_validate_local(
+	semanage_handle_t* handle);
+
+/* ==== Internal (to ports) API === */
+
+hidden int semanage_port_compare2_qsort(
+	const semanage_port_t** port,
+	const semanage_port_t** port2);
+
 #endif
diff -Naurp --exclude-from excludes old/libsemanage/src/port_record.c new/libsemanage/src/port_record.c
--- old/libsemanage/src/port_record.c	2006-01-12 03:47:32.000000000 -0700
+++ new/libsemanage/src/port_record.c	2006-01-13 03:13:10.000000000 -0700
@@ -40,7 +40,7 @@ int semanage_port_compare2(
 }
 hidden_def(semanage_port_compare2)
 
-static int semanage_port_compare2_qsort(
+hidden int semanage_port_compare2_qsort(
 	const semanage_port_t** port,
 	const semanage_port_t** port2) {
 
diff -Naurp --exclude-from excludes old/libsemanage/src/ports_local.c new/libsemanage/src/ports_local.c
--- old/libsemanage/src/ports_local.c	2006-01-12 03:45:08.000000000 -0700
+++ new/libsemanage/src/ports_local.c	2006-01-13 03:31:08.000000000 -0700
@@ -6,8 +6,9 @@ typedef struct semanage_port_key record_
 typedef struct semanage_port record_t;
 #define DBASE_RECORD_DEFINED
 
-#include <stddef.h>
+#include <stdlib.h>
 #include "port_internal.h"
+#include "debug.h"
 #include "handle.h" 
 #include "database.h"
 
@@ -68,8 +69,77 @@ int semanage_port_iterate_local(
 int semanage_port_list_local(
 	semanage_handle_t* handle,
 	semanage_port_t*** records,
-	size_t* count) {
+	unsigned int* count) {
 
 	dbase_config_t* dconfig = semanage_port_dbase_local(handle);
 	return dbase_list(handle, dconfig, records, count);
 }
+
+int hidden semanage_port_validate_local(
+	semanage_handle_t* handle) {
+
+	semanage_port_t** ports = NULL;
+	unsigned int nports = 0;
+	unsigned int i = 0, j = 0;
+
+	/* List and sort the ports */
+	if (semanage_port_list_local(handle, &ports, &nports) < 0)
+		goto err;
+	qsort(ports, nports, sizeof(semanage_port_t*),
+		(int (*) (const void*, const void*)) &semanage_port_compare2_qsort);
+
+	/* Test each port for overlap */
+	while (i < nports) {
+
+		int proto = semanage_port_get_proto(ports[i]);
+		int low = semanage_port_get_low(ports[i]);
+		int high = semanage_port_get_high(ports[i]);
+		const char* proto_str = semanage_port_get_proto_str(ports[i]); 
+		
+		const char* proto_str2;
+		int proto2, low2, high2;
+
+		/* Find the first port with matching 
+		   protocol to compare against */
+		do {
+			if (j == nports - 1) 
+				goto next;
+			j++;
+			proto2 = semanage_port_get_proto(ports[j]);
+			low2 = semanage_port_get_low(ports[j]);
+			high2 = semanage_port_get_high(ports[j]);
+			proto_str2 = semanage_port_get_proto_str(ports[j]);
+
+		} while (proto != proto2);
+
+		/* Overlap detected */
+		if (low2 <= high) {
+			ERR(handle, "port overlap between ranges " 
+				"%u - %u (%s) <--> %u - %u (%s).",
+				low, high, proto_str, low2, high2, proto_str2);
+			goto invalid;		
+		}
+
+		/* If closest port of matching protocol doesn't overlap with
+		 * test port, neither do the rest of them, because that's 
+		 * how the sort function works on ports - lower bound 
+	 	 * ports come first */
+		next:
+		i++;
+		j = i;
+	}	
+
+	for (i=0; i < nports; i++)
+		semanage_port_free(ports[i]);
+	free(ports);
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not complete ports validity check");
+
+	invalid:
+	for (i=0; i < nports; i++)
+		semanage_port_free(ports[i]);
+	free(ports);
+	return STATUS_ERR;
+} 

--------------030400090509010805050307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
