Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-xxJxmDl+EonwAxnpcqVH"
Date: Fri, 07 Oct 2005 10:30:26 -0400
Message-Id: <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-xxJxmDl+EonwAxnpcqVH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-10-06 at 15:27 -0400, Stephen Smalley wrote:
> BTW, I'd like to wean libsemanage off of its dependence on the static
> libsepol, so that users of libsemanage (like semodule) no longer need to
> link with the static libsepol even when they are using the shared
> libsemanage.  This means:
> - exporting your new libsepol interfaces via libsepol.map so that
> libsemanage can use them without depending on the static lib,
> - encapsulating the policydb internal types and functions that are
> currently used by libsemanage.
> 
> I think I'll push all of the policydb internal types and function
> interfaces down to include/sepol/policydb/*.h, and we'll introduce
> opaque types and interfaces where needed in include/sepol/*.h.  So we
> can still have a include/sepol/policydb.h, but it will become the opaque
> type definition there, with the internals in
> include/sepol/policydb/policydb.h.

Ok, I've made a first cut at the changes to libsepol and updated it and
checkpolicy to build again, and am starting to work through libsemanage.
As an example of what to expect, the diff below to database_direct.[ch]
was needed to get it to compile again.

-- 
Stephen Smalley
National Security Agency

--=-xxJxmDl+EonwAxnpcqVH
Content-Disposition: attachment; filename=ddirect.patch
Content-Type: text/x-patch; name=ddirect.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libsemanage/src/database_direct.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/database_direct.c,v
retrieving revision 1.5
diff -u -p -r1.5 database_direct.c
--- libsemanage/src/database_direct.c	6 Oct 2005 19:08:13 -0000	1.5
+++ libsemanage/src/database_direct.c	7 Oct 2005 14:19:07 -0000
@@ -9,6 +9,7 @@ typedef struct dbase_direct dbase_t;
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <unistd.h>
+#include <string.h>
 #include <sepol/policydb.h>
 #include "database_direct.h"
 #include "semanage_store.h"
@@ -27,7 +28,7 @@ struct dbase_direct {
 	/* Policy extensions */
 	record_direct_table_t* rptable;
 
-	policydb_t* policy;
+	sepol_policydb_t* policy;
 	int cached;
 	int modified;
 };
@@ -60,7 +61,7 @@ static int dbase_direct_cache(
 	int fd = -1;
 	struct stat sb;
 	void* data = NULL;
-	policydb_t* policydb = NULL;
+	sepol_policydb_t* policydb = NULL;
 
 	char* fname = NULL;
 
@@ -92,10 +93,9 @@ static int dbase_direct_cache(
         }
 
 	/* Create policydb image */
-	policydb = (policydb_t*) malloc(sizeof(policydb_t));
-	if (!policydb)
+	if (sepol_policydb_create(&policydb, SEPOL_POLICY_KERN))
 		goto omem;
-	if (policydb_from_image(data, sb.st_size, policydb) < 0)
+	if (sepol_policydb_from_image(data, sb.st_size, policydb) < 0)
 		goto err;
 	dbase->policy = policydb;
 
@@ -128,7 +128,7 @@ static int dbase_direct_flush(
 	if (!dbase->modified || !dbase->cached)
 		return STATUS_SUCCESS;
 
-	/* FIXME: policydb_to_image always writes a KERN policy */
+	/* FIXME: sepol_policydb_to_image always writes a KERN policy */
 
 	/* Stub */
 	handle = NULL;
@@ -142,8 +142,7 @@ static void dbase_direct_drop_cache(
 	 dbase_direct_t* dbase) {
 
 	if (dbase->cached) {
-		policydb_destroy(dbase->policy);
-		free(dbase->policy);
+		sepol_policydb_free(dbase->policy);
 		dbase->cached = 0;
 	}
 
Index: libsemanage/src/database_direct.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/database_direct.h,v
retrieving revision 1.4
diff -u -p -r1.4 database_direct.h
--- libsemanage/src/database_direct.h	6 Oct 2005 19:08:13 -0000	1.4
+++ libsemanage/src/database_direct.h	7 Oct 2005 14:10:41 -0000
@@ -12,14 +12,14 @@ typedef struct dbase_direct dbase_direct
 typedef struct record_direct_table {
 
 	/* Add record into the policy database */
-	int (*add) (policydb_t* policy, record_t* record);
+	int (*add) (sepol_policydb_t* policy, record_t* record);
 
 	/* Modify record into the policy database */
-	int (*modify) (policydb_t* policydb, record_t* record);
+	int (*modify) (sepol_policydb_t* policydb, record_t* record);
 
 	/* Iterate over records */
 	int (*iterate) (
-		policydb_t* policydb,
+		sepol_policydb_t* policydb,
 		int (*fn)(record_t* record, void* fn_arg),
 	void* arg);
 

--=-xxJxmDl+EonwAxnpcqVH--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
