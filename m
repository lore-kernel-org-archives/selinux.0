Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MH5ngA007559
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 13:05:49 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MH11YP005612
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 17:01:01 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6MH13DT004347
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 13:01:03 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6MH12V10849
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 13:01:02 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6MH12ll027991
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 13:01:02 -0400
Subject: [ libsepol 8/6] Cache corrections
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-cGcDqeK2+x5s7K1u7QLF"
Date: Fri, 22 Jul 2005 12:58:34 -0400
Message-Id: <1122051515.26463.45.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-cGcDqeK2+x5s7K1u7QLF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch does the role set expansion
when adding users in reindex_user (necessary for
sepol_genusers_policydb), and in my users patch.
This is a bugfix. The first bit is needed, 
even if the users patch is not merged.

This patch depends on:
libsepol-1.1-context.diff
libsepol-1.2-fix_memory_leaks.diff
libsepol-2.1-users.diff




--=-cGcDqeK2+x5s7K1u7QLF
Content-Disposition: attachment; filename=libsepol-1.3-2.2-cache_corrections.diff
Content-Type: text/x-patch; name=libsepol-1.3-2.2-cache_corrections.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -p -aru libsepol.work/src/policydb.c libsepol-1.3-2.2-cache_corrections/src/policydb.c
--- libsepol.work/src/policydb.c	2005-07-22 12:52:54.000000000 -0400
+++ libsepol-1.3-2.2-cache_corrections/src/policydb.c	2005-07-22 12:40:59.000000000 -0400
@@ -2602,8 +2602,9 @@ int policydb_reindex_users(policydb_t * 
 	if (hashtab_map(p->symtab[i].table, index_f[i], p))
 		return -1;
 
+	/* Expand user roles for context validity checking */
+	if (hashtab_map(p->p_users.table, policydb_user_cache, p))
+		return -1;
+
 	return 0;
 }
-
-
-
diff -p -aru libsepol.work/src/users.c libsepol-1.3-2.2-cache_corrections/src/users.c
--- libsepol.work/src/users.c	2005-07-22 12:52:53.000000000 -0400
+++ libsepol-1.3-2.2-cache_corrections/src/users.c	2005-07-22 12:40:55.000000000 -0400
@@ -5,6 +5,7 @@
 
 #include <sepol/sepol.h>
 #include <sepol/policydb.h>
+#include <sepol/expand.h>
 #include <sepol/mls.h>
 #include <sepol/users.h>
 #include <sys/types.h>
@@ -295,6 +296,12 @@ int sepol_user_load(policydb_t* policydb
 		/* Set up reverse entry */
 		policydb->p_user_val_to_name[usrdatum->value - 1] = key;
 		policydb->user_val_to_struct[usrdatum->value - 1] = usrdatum;
+
+		/* Expand roles */
+		if (role_set_expand(&usrdatum->roles, &usrdatum->cache, policydb)) {
+			DEBUG(__FUNCTION__, "unable to expand role set\n");
+			goto err;
+		}
 	}	
 	 
 	free(name);

--=-cGcDqeK2+x5s7K1u7QLF--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
