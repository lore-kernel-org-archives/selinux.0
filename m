Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCE81A0737
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334646; cv=none; b=sOetjdbQzkp7mOetGAi/mfk2CRYqKzwZpo44bplpcaFtv5FFliMQpz+UMYhwzxkZgnerfwQ7zWVdok9UUVNSl1kc/kRz6nNTnO5eVIJYT+Wjf18aPzAOduot26gf/k4LbVIRHqmY8QXVDhY4/1w0p3CezYlHr772l7K1qS3DsAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334646; c=relaxed/simple;
	bh=z71ZbhSXb3pdrGo/puFOy/FT5LRgkypnoJXUuhnBmrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6Gyq2rhKdBHWHLVo92UgQl/nbmwUObXIEiPMw1V+wBqbH3t+G2cP400W/fdpZ/fz8THdf6rHUwt2RxIldJn1r7ISb0IAvuX1pTTVhVxyT3UHv5/+roKVrV0e26uCVCWEXc7vYVtqGaHjFiujgZ/RotTTwVAK4BzgU8QnLVRtio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=mpMANdjR; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="mpMANdjR"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334637;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEXDTBY/cZU686vPOZx+gpsYbSxS0dOl8HGyds6+N9s=;
	b=mpMANdjRqxJDe9l8Cjg6McRdnsqwLfn1SbH/sbbQTiv3xcpXKGYlZw1idxhqGqWhjvhveD
	iLp4UJJD2Vv8SnW8Z4OoSysugaIbf9umejMu1UBlNP5uyKM+i3xTXpPx2o7N4aIzbeu8ri
	FDaNQMI/rWtKQ3iNSE+Qq7UNDA2UKs9fUDXIwQsJ+u1oUg+U0AohphOm6tNtX7E9PviHTv
	u2VfuhlkxLW0d24LRskGRRYmxwInPvK9dt6qnnSvoybWYoeXdO6HL9zbhzfttsdnUV0YZq
	hgc1a3eORPkR5h7ziH/f3rqZig4fm/pXQbcWv+bnCnBXA46DedqSzfKexyetUQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 27/47] libsemanage: constify function pointer structures
Date: Mon, 11 Nov 2024 15:16:46 +0100
Message-ID: <20241111141706.38039-27-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Declare the read-only function pointer structures.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/boolean_internal.h    |  2 +-
 libsemanage/src/boolean_record.c      |  2 +-
 libsemanage/src/booleans_activedb.c   |  2 +-
 libsemanage/src/booleans_file.c       |  2 +-
 libsemanage/src/booleans_policydb.c   |  2 +-
 libsemanage/src/database.h            |  4 ++--
 libsemanage/src/database_activedb.c   | 16 +++++++-------
 libsemanage/src/database_activedb.h   |  6 ++---
 libsemanage/src/database_file.c       | 14 ++++++------
 libsemanage/src/database_file.h       |  6 ++---
 libsemanage/src/database_join.c       | 32 +++++++++++++--------------
 libsemanage/src/database_join.h       |  6 ++---
 libsemanage/src/database_llist.h      | 10 ++++-----
 libsemanage/src/database_policydb.c   | 14 ++++++------
 libsemanage/src/database_policydb.h   |  6 ++---
 libsemanage/src/direct_api.c          |  2 +-
 libsemanage/src/fcontext_internal.h   |  2 +-
 libsemanage/src/fcontext_record.c     |  2 +-
 libsemanage/src/fcontexts_file.c      |  2 +-
 libsemanage/src/handle.h              |  2 +-
 libsemanage/src/ibendport_internal.h  |  2 +-
 libsemanage/src/ibendport_record.c    |  2 +-
 libsemanage/src/ibendports_file.c     |  2 +-
 libsemanage/src/ibendports_policydb.c |  2 +-
 libsemanage/src/ibpkey_internal.h     |  2 +-
 libsemanage/src/ibpkey_record.c       |  2 +-
 libsemanage/src/ibpkeys_file.c        |  2 +-
 libsemanage/src/ibpkeys_policydb.c    |  2 +-
 libsemanage/src/iface_internal.h      |  2 +-
 libsemanage/src/iface_record.c        |  2 +-
 libsemanage/src/interfaces_file.c     |  2 +-
 libsemanage/src/interfaces_policydb.c |  2 +-
 libsemanage/src/node_internal.h       |  2 +-
 libsemanage/src/node_record.c         |  2 +-
 libsemanage/src/nodes_file.c          |  2 +-
 libsemanage/src/nodes_policydb.c      |  2 +-
 libsemanage/src/policy_components.c   | 12 +++++-----
 libsemanage/src/port_internal.h       |  2 +-
 libsemanage/src/port_record.c         |  2 +-
 libsemanage/src/ports_file.c          |  2 +-
 libsemanage/src/ports_policydb.c      |  2 +-
 libsemanage/src/seuser_internal.h     |  2 +-
 libsemanage/src/seuser_record.c       |  2 +-
 libsemanage/src/seusers_file.c        |  2 +-
 libsemanage/src/user_base_record.c    |  2 +-
 libsemanage/src/user_extra_record.c   |  2 +-
 libsemanage/src/user_internal.h       |  6 ++---
 libsemanage/src/user_record.c         |  2 +-
 libsemanage/src/users_base_file.c     |  2 +-
 libsemanage/src/users_base_policydb.c |  2 +-
 libsemanage/src/users_extra_file.c    |  2 +-
 libsemanage/src/users_join.c          |  2 +-
 52 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/libsemanage/src/boolean_internal.h b/libsemanage/src/boolean_internal.h
index 8d1c20dc..63a46b80 100644
--- a/libsemanage/src/boolean_internal.h
+++ b/libsemanage/src/boolean_internal.h
@@ -9,7 +9,7 @@
 #include "handle.h"
 
 /* BOOL RECORD: method table */
-extern record_table_t SEMANAGE_BOOL_RTABLE;
+extern const record_table_t SEMANAGE_BOOL_RTABLE;
 
 extern int bool_file_dbase_init(semanage_handle_t * handle,
 				const char *path_ro,
diff --git a/libsemanage/src/boolean_record.c b/libsemanage/src/boolean_record.c
index 7878b04d..2cbdd09b 100644
--- a/libsemanage/src/boolean_record.c
+++ b/libsemanage/src/boolean_record.c
@@ -181,7 +181,7 @@ void semanage_bool_free(semanage_bool_t * boolean)
 
 
 /* Record base functions */
-record_table_t SEMANAGE_BOOL_RTABLE = {
+const record_table_t SEMANAGE_BOOL_RTABLE = {
 	.create = semanage_bool_create,
 	.key_extract = semanage_bool_key_extract,
 	.key_free = semanage_bool_key_free,
diff --git a/libsemanage/src/booleans_activedb.c b/libsemanage/src/booleans_activedb.c
index 1d4e33b4..0ac0c3fb 100644
--- a/libsemanage/src/booleans_activedb.c
+++ b/libsemanage/src/booleans_activedb.c
@@ -141,7 +141,7 @@ static int bool_commit_list(semanage_handle_t * handle,
 }
 
 /* BOOL RECORD: ACTIVEDB extension: method table */
-static record_activedb_table_t SEMANAGE_BOOL_ACTIVEDB_RTABLE = {
+static const record_activedb_table_t SEMANAGE_BOOL_ACTIVEDB_RTABLE = {
 	.read_list = bool_read_list,
 	.commit_list = bool_commit_list,
 };
diff --git a/libsemanage/src/booleans_file.c b/libsemanage/src/booleans_file.c
index dae42ffb..52628b63 100644
--- a/libsemanage/src/booleans_file.c
+++ b/libsemanage/src/booleans_file.c
@@ -101,7 +101,7 @@ static int bool_parse(semanage_handle_t * handle,
 }
 
 /* BOOL RECORD: FILE extension: method table */
-static record_file_table_t SEMANAGE_BOOL_FILE_RTABLE = {
+static const record_file_table_t SEMANAGE_BOOL_FILE_RTABLE = {
 	.parse = bool_parse,
 	.print = bool_print,
 };
diff --git a/libsemanage/src/booleans_policydb.c b/libsemanage/src/booleans_policydb.c
index e838c3eb..23ede869 100644
--- a/libsemanage/src/booleans_policydb.c
+++ b/libsemanage/src/booleans_policydb.c
@@ -36,7 +36,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* BOOLEAN RECRORD (SEPOL): POLICYDB extension: method table */
-static record_policydb_table_t SEMANAGE_BOOL_POLICYDB_RTABLE = {
+static const record_policydb_table_t SEMANAGE_BOOL_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = NULL,
 /* FIXME: these casts depend on structs in libsepol matching structs
diff --git a/libsemanage/src/database.h b/libsemanage/src/database.h
index 8bd894df..1950b63d 100644
--- a/libsemanage/src/database.h
+++ b/libsemanage/src/database.h
@@ -166,7 +166,7 @@ typedef struct dbase_table {
 	/* Retrieves the record table for this database,
 	 * which specifies how to perform basic operations
 	 * on each record. */
-	record_table_t *(*get_rtable) (dbase_t * dbase);
+	const record_table_t *(*get_rtable) (dbase_t * dbase);
 
 } dbase_table_t;
 
@@ -176,7 +176,7 @@ typedef struct dbase_config {
 	dbase_t *dbase;
 
 	/* Database methods */
-	dbase_table_t *dtable;
+	const dbase_table_t *dtable;
 
 } dbase_config_t;
 
diff --git a/libsemanage/src/database_activedb.c b/libsemanage/src/database_activedb.c
index e0369963..8ba23aad 100644
--- a/libsemanage/src/database_activedb.c
+++ b/libsemanage/src/database_activedb.c
@@ -26,15 +26,15 @@ struct dbase_activedb {
 	dbase_llist_t llist;
 
 	/* ACTIVEDB extension */
-	record_activedb_table_t *ratable;
+	const record_activedb_table_t *ratable;
 };
 
 static int dbase_activedb_cache(semanage_handle_t * handle,
 				dbase_activedb_t * dbase)
 {
 
-	record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
-	record_activedb_table_t *ratable = dbase->ratable;
+	const record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
+	const record_activedb_table_t *ratable = dbase->ratable;
 
 	record_t **records = NULL;
 	unsigned int rcount = 0;
@@ -77,8 +77,8 @@ static int dbase_activedb_flush(semanage_handle_t * handle,
 				dbase_activedb_t * dbase)
 {
 
-	record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
-	record_activedb_table_t *ratable = dbase->ratable;
+	const record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
+	const record_activedb_table_t *ratable = dbase->ratable;
 
 	record_t **records = NULL;
 	unsigned int rcount = 0;
@@ -111,8 +111,8 @@ static int dbase_activedb_flush(semanage_handle_t * handle,
 }
 
 int dbase_activedb_init(semanage_handle_t * handle,
-			record_table_t * rtable,
-			record_activedb_table_t * ratable,
+			const record_table_t * rtable,
+			const record_activedb_table_t * ratable,
 			dbase_activedb_t ** dbase)
 {
 
@@ -147,7 +147,7 @@ void dbase_activedb_release(dbase_activedb_t * dbase)
 }
 
 /* ACTIVEDB dbase - method table implementation */
-dbase_table_t SEMANAGE_ACTIVEDB_DTABLE = {
+const dbase_table_t SEMANAGE_ACTIVEDB_DTABLE = {
 
 	/* Cache/Transactions */
 	.cache = dbase_activedb_cache,
diff --git a/libsemanage/src/database_activedb.h b/libsemanage/src/database_activedb.h
index 37196c99..2f31b504 100644
--- a/libsemanage/src/database_activedb.h
+++ b/libsemanage/src/database_activedb.h
@@ -24,14 +24,14 @@ typedef struct record_activedb_table {
 
 /* ACTIVEDB - initialization */
 extern int dbase_activedb_init(semanage_handle_t * handle,
-			       record_table_t * rtable,
-			       record_activedb_table_t * ratable,
+			       const record_table_t * rtable,
+			       const record_activedb_table_t * ratable,
 			       dbase_activedb_t ** dbase);
 
 /* ACTIVEDB - release */
 extern void dbase_activedb_release(dbase_activedb_t * dbase);
 
 /* ACTIVEDB - method table implementation */
-extern dbase_table_t SEMANAGE_ACTIVEDB_DTABLE;
+extern const dbase_table_t SEMANAGE_ACTIVEDB_DTABLE;
 
 #endif
diff --git a/libsemanage/src/database_file.c b/libsemanage/src/database_file.c
index 716f54e7..a54c5aee 100644
--- a/libsemanage/src/database_file.c
+++ b/libsemanage/src/database_file.c
@@ -34,14 +34,14 @@ struct dbase_file {
 	const char *path[2];
 
 	/* FILE extension */
-	record_file_table_t *rftable;
+	const record_file_table_t *rftable;
 };
 
 static int dbase_file_cache(semanage_handle_t * handle, dbase_file_t * dbase)
 {
 
-	record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
-	record_file_table_t *rftable = dbase->rftable;
+	const record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
+	const record_file_table_t *rftable = dbase->rftable;
 
 	record_t *process_record = NULL;
 	int pstatus = STATUS_SUCCESS;
@@ -114,7 +114,7 @@ static int dbase_file_cache(semanage_handle_t * handle, dbase_file_t * dbase)
 static int dbase_file_flush(semanage_handle_t * handle, dbase_file_t * dbase)
 {
 
-	record_file_table_t *rftable = dbase->rftable;
+	const record_file_table_t *rftable = dbase->rftable;
 
 	cache_entry_t *ptr;
 	const char *fname = NULL;
@@ -163,8 +163,8 @@ static int dbase_file_flush(semanage_handle_t * handle, dbase_file_t * dbase)
 int dbase_file_init(semanage_handle_t * handle,
 		    const char *path_ro,
 		    const char *path_rw,
-		    record_table_t * rtable,
-		    record_file_table_t * rftable, dbase_file_t ** dbase)
+		    const record_table_t * rtable,
+		    const record_file_table_t * rftable, dbase_file_t ** dbase)
 {
 
 	dbase_file_t *tmp_dbase = (dbase_file_t *) malloc(sizeof(dbase_file_t));
@@ -199,7 +199,7 @@ void dbase_file_release(dbase_file_t * dbase)
 }
 
 /* FILE dbase - method table implementation */
-dbase_table_t SEMANAGE_FILE_DTABLE = {
+dbase_table_t const SEMANAGE_FILE_DTABLE = {
 
 	/* Cache/Transactions */
 	.cache = dbase_file_cache,
diff --git a/libsemanage/src/database_file.h b/libsemanage/src/database_file.h
index dbd11bc1..c65a9f9a 100644
--- a/libsemanage/src/database_file.h
+++ b/libsemanage/src/database_file.h
@@ -30,14 +30,14 @@ typedef struct record_file_table {
 extern int dbase_file_init(semanage_handle_t * handle,
 			   const char *path_ro,
 			   const char *path_rw,
-			   record_table_t * rtable,
-			   record_file_table_t * rftable,
+			   const record_table_t * rtable,
+			   const record_file_table_t * rftable,
 			   dbase_file_t ** dbase);
 
 /* FILE - release */
 extern void dbase_file_release(dbase_file_t * dbase);
 
 /* FILE - method table implementation */
-extern dbase_table_t SEMANAGE_FILE_DTABLE;
+extern const dbase_table_t SEMANAGE_FILE_DTABLE;
 
 #endif
diff --git a/libsemanage/src/database_join.c b/libsemanage/src/database_join.c
index bf260952..3e97f432 100644
--- a/libsemanage/src/database_join.c
+++ b/libsemanage/src/database_join.c
@@ -31,7 +31,7 @@ struct dbase_join {
 	dbase_config_t *join2;
 
 	/* JOIN extension */
-	record_join_table_t *rjtable;
+	const record_join_table_t *rjtable;
 };
 
 static int dbase_join_cache(semanage_handle_t * handle, dbase_join_t * dbase)
@@ -40,12 +40,12 @@ static int dbase_join_cache(semanage_handle_t * handle, dbase_join_t * dbase)
 	/* Extract all the object tables information */
 	dbase_t *dbase1 = dbase->join1->dbase;
 	dbase_t *dbase2 = dbase->join2->dbase;
-	dbase_table_t *dtable1 = dbase->join1->dtable;
-	dbase_table_t *dtable2 = dbase->join2->dtable;
-	record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
-	record_join_table_t *rjtable = dbase->rjtable;
-	record_table_t *rtable1 = dtable1->get_rtable(dbase1);
-	record_table_t *rtable2 = dtable2->get_rtable(dbase2);
+	const dbase_table_t *dtable1 = dbase->join1->dtable;
+	const dbase_table_t *dtable2 = dbase->join2->dtable;
+	const record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
+	const record_join_table_t *rjtable = dbase->rjtable;
+	const record_table_t *rtable1 = dtable1->get_rtable(dbase1);
+	const record_table_t *rtable2 = dtable2->get_rtable(dbase2);
 
 	record_key_t *rkey = NULL;
 	record_t *record = NULL;
@@ -176,12 +176,12 @@ static int dbase_join_flush(semanage_handle_t * handle, dbase_join_t * dbase)
 	/* Extract all the object tables information */
 	dbase_t *dbase1 = dbase->join1->dbase;
 	dbase_t *dbase2 = dbase->join2->dbase;
-	dbase_table_t *dtable1 = dbase->join1->dtable;
-	dbase_table_t *dtable2 = dbase->join2->dtable;
-	record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
-	record_join_table_t *rjtable = dbase->rjtable;
-	record_table_t *rtable1 = dtable1->get_rtable(dbase1);
-	record_table_t *rtable2 = dtable2->get_rtable(dbase2);
+	const dbase_table_t *dtable1 = dbase->join1->dtable;
+	const dbase_table_t *dtable2 = dbase->join2->dtable;
+	const record_table_t *rtable = dbase_llist_get_rtable(&dbase->llist);
+	const record_join_table_t *rjtable = dbase->rjtable;
+	const record_table_t *rtable1 = dtable1->get_rtable(dbase1);
+	const record_table_t *rtable2 = dtable2->get_rtable(dbase2);
 
 	cache_entry_t *ptr;
 	record_key_t *rkey = NULL;
@@ -240,8 +240,8 @@ static int dbase_join_flush(semanage_handle_t * handle, dbase_join_t * dbase)
 }
 
 int dbase_join_init(semanage_handle_t * handle,
-		    record_table_t * rtable,
-		    record_join_table_t * rjtable,
+		    const record_table_t * rtable,
+		    const record_join_table_t * rjtable,
 		    dbase_config_t * join1,
 		    dbase_config_t * join2, dbase_t ** dbase)
 {
@@ -279,7 +279,7 @@ void dbase_join_release(dbase_join_t * dbase)
 }
 
 /* JOIN dbase - method table implementation */
-dbase_table_t SEMANAGE_JOIN_DTABLE = {
+const dbase_table_t SEMANAGE_JOIN_DTABLE = {
 
 	/* Cache/Transactions */
 	.cache = dbase_join_cache,
diff --git a/libsemanage/src/database_join.h b/libsemanage/src/database_join.h
index d477fc41..b28e6422 100644
--- a/libsemanage/src/database_join.h
+++ b/libsemanage/src/database_join.h
@@ -33,8 +33,8 @@ typedef struct record_join_table {
 
 /* JOIN - initialization */
 extern int dbase_join_init(semanage_handle_t * handle,
-			   record_table_t * rtable,
-			   record_join_table_t * rjtable,
+			   const record_table_t * rtable,
+			   const record_join_table_t * rjtable,
 			   dbase_config_t * join1,
 			   dbase_config_t * join2, dbase_join_t ** dbase);
 
@@ -42,6 +42,6 @@ extern int dbase_join_init(semanage_handle_t * handle,
 extern void dbase_join_release(dbase_join_t * dbase);
 
 /* JOIN - method table implementation */
-extern dbase_table_t SEMANAGE_JOIN_DTABLE;
+extern const dbase_table_t SEMANAGE_JOIN_DTABLE;
 
 #endif
diff --git a/libsemanage/src/database_llist.h b/libsemanage/src/database_llist.h
index 84994ef2..639b784d 100644
--- a/libsemanage/src/database_llist.h
+++ b/libsemanage/src/database_llist.h
@@ -17,8 +17,8 @@ typedef struct cache_entry {
 typedef struct dbase_llist {
 
 	/* Method tables */
-	record_table_t *rtable;
-	dbase_table_t *dtable;
+	const record_table_t *rtable;
+	const dbase_table_t *dtable;
 
 	/* In-memory representation (cache) */
 	cache_entry_t *cache;
@@ -42,8 +42,8 @@ static inline void dbase_llist_cache_init(dbase_llist_t * dbase)
 }
 
 static inline void dbase_llist_init(dbase_llist_t * dbase,
-				    record_table_t * rtable,
-				    dbase_table_t * dtable)
+				    const record_table_t * rtable,
+				    const dbase_table_t * dtable)
 {
 
 	dbase->rtable = rtable;
@@ -76,7 +76,7 @@ static inline int dbase_llist_is_modified(dbase_llist_t * dbase)
 }
 
 /* LLIST - polymorphism */
-static inline record_table_t *dbase_llist_get_rtable(dbase_llist_t * dbase)
+static inline const record_table_t *dbase_llist_get_rtable(dbase_llist_t * dbase)
 {
 	return dbase->rtable;
 }
diff --git a/libsemanage/src/database_policydb.c b/libsemanage/src/database_policydb.c
index 6e922b5e..62467d15 100644
--- a/libsemanage/src/database_policydb.c
+++ b/libsemanage/src/database_policydb.c
@@ -29,10 +29,10 @@ struct dbase_policydb {
         const char *path[2];
 
 	/* Base record table */
-	record_table_t *rtable;
+	const record_table_t *rtable;
 
 	/* Policy extensions */
-	record_policydb_table_t *rptable;
+	const record_policydb_table_t *rptable;
 
 	sepol_policydb_t *policydb;
 
@@ -178,8 +178,8 @@ static int dbase_policydb_is_modified(dbase_policydb_t * dbase)
 int dbase_policydb_init(semanage_handle_t * handle,
 			const char *path_ro,
 			const char *path_rw,
-			record_table_t * rtable,
-			record_policydb_table_t * rptable,
+			const record_table_t * rtable,
+			const record_policydb_table_t * rptable,
 			dbase_policydb_t ** dbase)
 {
 
@@ -377,7 +377,7 @@ static int dbase_policydb_iterate(semanage_handle_t * handle,
 
 struct list_handler_arg {
 	semanage_handle_t *handle;
-	record_table_t *rtable;
+	const record_table_t *rtable;
 	record_t **records;
 	int pos;
 };
@@ -444,14 +444,14 @@ static int dbase_policydb_list(semanage_handle_t * handle,
 	return STATUS_ERR;
 }
 
-static record_table_t *dbase_policydb_get_rtable(dbase_policydb_t * dbase)
+static const record_table_t *dbase_policydb_get_rtable(dbase_policydb_t * dbase)
 {
 
 	return dbase->rtable;
 }
 
 /* POLICYDB dbase - method table implementation */
-dbase_table_t SEMANAGE_POLICYDB_DTABLE = {
+const dbase_table_t SEMANAGE_POLICYDB_DTABLE = {
 
 	/* Cache/Transactions */
 	.cache = dbase_policydb_cache,
diff --git a/libsemanage/src/database_policydb.h b/libsemanage/src/database_policydb.h
index 8cb66f71..f032e53f 100644
--- a/libsemanage/src/database_policydb.h
+++ b/libsemanage/src/database_policydb.h
@@ -88,8 +88,8 @@ typedef struct record_policydb_table {
 extern int dbase_policydb_init(semanage_handle_t * handle,
 			       const char *path_ro,
 			       const char *path_rw,
-			       record_table_t * rtable,
-			       record_policydb_table_t * rptable,
+			       const record_table_t * rtable,
+			       const record_policydb_table_t * rptable,
 			       dbase_policydb_t ** dbase);
 
 /* Attach to a shared policydb.
@@ -107,6 +107,6 @@ extern void dbase_policydb_detach(dbase_policydb_t * dbase);
 extern void dbase_policydb_release(dbase_policydb_t * dbase);
 
 /* POLICYDB database - method table implementation */
-extern dbase_table_t SEMANAGE_POLICYDB_DTABLE;
+extern const dbase_table_t SEMANAGE_POLICYDB_DTABLE;
 
 #endif
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index aa1485e3..b71e8e81 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -104,7 +104,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 static int semanage_direct_remove_key(semanage_handle_t *sh,
 				      const semanage_module_key_t *modkey);
 
-static struct semanage_policy_table direct_funcs = {
+static const struct semanage_policy_table direct_funcs = {
 	.get_serial = semanage_direct_get_serial,
 	.destroy = semanage_direct_destroy,
 	.disconnect = semanage_direct_disconnect,
diff --git a/libsemanage/src/fcontext_internal.h b/libsemanage/src/fcontext_internal.h
index 7ae20f12..decce01f 100644
--- a/libsemanage/src/fcontext_internal.h
+++ b/libsemanage/src/fcontext_internal.h
@@ -9,7 +9,7 @@
 #include "handle.h"
 
 /* FCONTEXT RECORD: method table */
-extern record_table_t SEMANAGE_FCONTEXT_RTABLE;
+extern const record_table_t SEMANAGE_FCONTEXT_RTABLE;
 
 extern int fcontext_file_dbase_init(semanage_handle_t * handle,
 				    const char *path_ro,
diff --git a/libsemanage/src/fcontext_record.c b/libsemanage/src/fcontext_record.c
index ae1b0324..f36e8317 100644
--- a/libsemanage/src/fcontext_record.c
+++ b/libsemanage/src/fcontext_record.c
@@ -289,7 +289,7 @@ void semanage_fcontext_free(semanage_fcontext_t * fcontext)
 
 
 /* Record base functions */
-record_table_t SEMANAGE_FCONTEXT_RTABLE = {
+const record_table_t SEMANAGE_FCONTEXT_RTABLE = {
 	.create = semanage_fcontext_create,
 	.key_extract = semanage_fcontext_key_extract,
 	.key_free = semanage_fcontext_key_free,
diff --git a/libsemanage/src/fcontexts_file.c b/libsemanage/src/fcontexts_file.c
index 16380fe3..e4ef1672 100644
--- a/libsemanage/src/fcontexts_file.c
+++ b/libsemanage/src/fcontexts_file.c
@@ -158,7 +158,7 @@ static int fcontext_parse(semanage_handle_t * handle,
 }
 
 /* FCONTEXT RECORD: FILE extension: method table */
-static record_file_table_t SEMANAGE_FCONTEXT_FILE_RTABLE = {
+static const record_file_table_t SEMANAGE_FCONTEXT_FILE_RTABLE = {
 	.parse = fcontext_parse,
 	.print = fcontext_print,
 };
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index 2853ca39..cfc47354 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -80,7 +80,7 @@ struct semanage_handle {
 	/* these function pointers will point to the appropriate
 	 * routine given the connection type.  think of these as
 	 * simulating polymorphism for non-OO languages. */
-	struct semanage_policy_table *funcs;
+	const struct semanage_policy_table *funcs;
 
 	/* Object databases */
 #define DBASE_COUNT      24
diff --git a/libsemanage/src/ibendport_internal.h b/libsemanage/src/ibendport_internal.h
index eada2d4b..04e0da5a 100644
--- a/libsemanage/src/ibendport_internal.h
+++ b/libsemanage/src/ibendport_internal.h
@@ -8,7 +8,7 @@
 #include "handle.h"
 
 /* IBENDPORT RECORD: method table */
-extern record_table_t SEMANAGE_IBENDPORT_RTABLE;
+extern const record_table_t SEMANAGE_IBENDPORT_RTABLE;
 
 extern int ibendport_file_dbase_init(semanage_handle_t *handle,
 				     const char *path_ro,
diff --git a/libsemanage/src/ibendport_record.c b/libsemanage/src/ibendport_record.c
index a8cb125d..6afe8975 100644
--- a/libsemanage/src/ibendport_record.c
+++ b/libsemanage/src/ibendport_record.c
@@ -129,7 +129,7 @@ void semanage_ibendport_free(semanage_ibendport_t *ibendport)
 
 
 /*key base functions */
-record_table_t SEMANAGE_IBENDPORT_RTABLE = {
+const record_table_t SEMANAGE_IBENDPORT_RTABLE = {
 	.create = semanage_ibendport_create,
 	.key_extract = semanage_ibendport_key_extract,
 	.key_free = semanage_ibendport_key_free,
diff --git a/libsemanage/src/ibendports_file.c b/libsemanage/src/ibendports_file.c
index 8ae02a9c..2bebbdcf 100644
--- a/libsemanage/src/ibendports_file.c
+++ b/libsemanage/src/ibendports_file.c
@@ -129,7 +129,7 @@ err:
 }
 
 /* IBENDPORT RECORD: FILE extension: method table */
-static record_file_table_t SEMANAGE_IBENDPORT_FILE_RTABLE = {
+static const record_file_table_t SEMANAGE_IBENDPORT_FILE_RTABLE = {
 	.parse = ibendport_parse,
 	.print = ibendport_print,
 };
diff --git a/libsemanage/src/ibendports_policydb.c b/libsemanage/src/ibendports_policydb.c
index 67c4e905..83862346 100644
--- a/libsemanage/src/ibendports_policydb.c
+++ b/libsemanage/src/ibendports_policydb.c
@@ -30,7 +30,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* IBENDPORT RECORD (SEPOL): POLICYDB extension : method table */
-static record_policydb_table_t SEMANAGE_IBENDPORT_POLICYDB_RTABLE = {
+static const record_policydb_table_t SEMANAGE_IBENDPORT_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = (record_policydb_table_modify_t)sepol_ibendport_modify,
 	.set = NULL,
diff --git a/libsemanage/src/ibpkey_internal.h b/libsemanage/src/ibpkey_internal.h
index 1e206b62..c1d97876 100644
--- a/libsemanage/src/ibpkey_internal.h
+++ b/libsemanage/src/ibpkey_internal.h
@@ -8,7 +8,7 @@
 #include "handle.h"
 
 /* PKEY RECORD: method table */
-extern record_table_t SEMANAGE_IBPKEY_RTABLE;
+extern const record_table_t SEMANAGE_IBPKEY_RTABLE;
 
 extern int ibpkey_file_dbase_init(semanage_handle_t *handle,
 				  const char *path_ro,
diff --git a/libsemanage/src/ibpkey_record.c b/libsemanage/src/ibpkey_record.c
index bb7fa6ea..9a47f53b 100644
--- a/libsemanage/src/ibpkey_record.c
+++ b/libsemanage/src/ibpkey_record.c
@@ -153,7 +153,7 @@ void semanage_ibpkey_free(semanage_ibpkey_t *ibpkey)
 
 
 /* key base functions */
-record_table_t SEMANAGE_IBPKEY_RTABLE = {
+const record_table_t SEMANAGE_IBPKEY_RTABLE = {
 	.create = semanage_ibpkey_create,
 	.key_extract = semanage_ibpkey_key_extract,
 	.key_free = semanage_ibpkey_key_free,
diff --git a/libsemanage/src/ibpkeys_file.c b/libsemanage/src/ibpkeys_file.c
index a45c6d3f..7a7c5772 100644
--- a/libsemanage/src/ibpkeys_file.c
+++ b/libsemanage/src/ibpkeys_file.c
@@ -153,7 +153,7 @@ err:
 }
 
 /* IBPKEY RECORD: FILE extension: method table */
-static record_file_table_t SEMANAGE_IBPKEY_FILE_RTABLE = {
+static const record_file_table_t SEMANAGE_IBPKEY_FILE_RTABLE = {
 	.parse = ibpkey_parse,
 	.print = ibpkey_print,
 };
diff --git a/libsemanage/src/ibpkeys_policydb.c b/libsemanage/src/ibpkeys_policydb.c
index ac16bcb6..01dd673f 100644
--- a/libsemanage/src/ibpkeys_policydb.c
+++ b/libsemanage/src/ibpkeys_policydb.c
@@ -30,7 +30,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* PKEY RECORD (SEPOL): POLICYDB extension : method table */
-static record_policydb_table_t SEMANAGE_IBPKEY_POLICYDB_RTABLE = {
+static const record_policydb_table_t SEMANAGE_IBPKEY_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = (record_policydb_table_modify_t)sepol_ibpkey_modify,
 	.set = NULL,
diff --git a/libsemanage/src/iface_internal.h b/libsemanage/src/iface_internal.h
index df38fb0f..de39ba33 100644
--- a/libsemanage/src/iface_internal.h
+++ b/libsemanage/src/iface_internal.h
@@ -8,7 +8,7 @@
 #include "handle.h"
 
 /* IFACE RECORD: method table */
-extern record_table_t SEMANAGE_IFACE_RTABLE;
+extern const record_table_t SEMANAGE_IFACE_RTABLE;
 
 extern int iface_policydb_dbase_init(semanage_handle_t * handle,
 				     dbase_config_t * dconfig);
diff --git a/libsemanage/src/iface_record.c b/libsemanage/src/iface_record.c
index e54cdd2d..b94afa04 100644
--- a/libsemanage/src/iface_record.c
+++ b/libsemanage/src/iface_record.c
@@ -144,7 +144,7 @@ void semanage_iface_free(semanage_iface_t * iface)
 
 
 /* Record base functions */
-record_table_t SEMANAGE_IFACE_RTABLE = {
+const record_table_t SEMANAGE_IFACE_RTABLE = {
 	.create = semanage_iface_create,
 	.key_extract = semanage_iface_key_extract,
 	.key_free = semanage_iface_key_free,
diff --git a/libsemanage/src/interfaces_file.c b/libsemanage/src/interfaces_file.c
index 29badb54..d61010ee 100644
--- a/libsemanage/src/interfaces_file.c
+++ b/libsemanage/src/interfaces_file.c
@@ -145,7 +145,7 @@ static int iface_parse(semanage_handle_t * handle,
 }
 
 /* IFACE RECORD: FILE extension: method table */
-static record_file_table_t SEMANAGE_IFACE_FILE_RTABLE = {
+static const record_file_table_t SEMANAGE_IFACE_FILE_RTABLE = {
 	.parse = iface_parse,
 	.print = iface_print,
 };
diff --git a/libsemanage/src/interfaces_policydb.c b/libsemanage/src/interfaces_policydb.c
index 8a02751a..c5936504 100644
--- a/libsemanage/src/interfaces_policydb.c
+++ b/libsemanage/src/interfaces_policydb.c
@@ -36,7 +36,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* INTERFACE RECRORD (SEPOL): POLICYDB extension: method table */
-static record_policydb_table_t SEMANAGE_IFACE_POLICYDB_RTABLE = {
+static const record_policydb_table_t SEMANAGE_IFACE_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = (record_policydb_table_modify_t) sepol_iface_modify,
 	.set = NULL,
diff --git a/libsemanage/src/node_internal.h b/libsemanage/src/node_internal.h
index 234143b4..24041101 100644
--- a/libsemanage/src/node_internal.h
+++ b/libsemanage/src/node_internal.h
@@ -8,7 +8,7 @@
 #include "handle.h"
 
 /* NODE RECORD: method table */
-extern record_table_t SEMANAGE_NODE_RTABLE;
+extern const record_table_t SEMANAGE_NODE_RTABLE;
 
 extern int node_file_dbase_init(semanage_handle_t * handle,
 				const char *path_ro,
diff --git a/libsemanage/src/node_record.c b/libsemanage/src/node_record.c
index e1c6e03a..9a018d4b 100644
--- a/libsemanage/src/node_record.c
+++ b/libsemanage/src/node_record.c
@@ -208,7 +208,7 @@ void semanage_node_free(semanage_node_t * node)
 
 
 /* Port base functions */
-record_table_t SEMANAGE_NODE_RTABLE = {
+const record_table_t SEMANAGE_NODE_RTABLE = {
 	.create = semanage_node_create,
 	.key_extract = semanage_node_key_extract,
 	.key_free = semanage_node_key_free,
diff --git a/libsemanage/src/nodes_file.c b/libsemanage/src/nodes_file.c
index e6e108cb..3ed34be1 100644
--- a/libsemanage/src/nodes_file.c
+++ b/libsemanage/src/nodes_file.c
@@ -154,7 +154,7 @@ static int node_parse(semanage_handle_t * handle,
 }
 
 /* NODE RECORD: FILE extension: method table */
-static record_file_table_t SEMANAGE_NODE_FILE_RTABLE = {
+static const record_file_table_t SEMANAGE_NODE_FILE_RTABLE = {
 	.parse = node_parse,
 	.print = node_print,
 };
diff --git a/libsemanage/src/nodes_policydb.c b/libsemanage/src/nodes_policydb.c
index 23464cf6..a32fde97 100644
--- a/libsemanage/src/nodes_policydb.c
+++ b/libsemanage/src/nodes_policydb.c
@@ -35,7 +35,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* NODE RECORD (SEPOL): POLICYDB extension : method table */
-static record_policydb_table_t SEMANAGE_NODE_POLICYDB_RTABLE = {
+static const record_policydb_table_t SEMANAGE_NODE_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = (record_policydb_table_modify_t) sepol_node_modify,
 	.set = NULL,
diff --git a/libsemanage/src/policy_components.c b/libsemanage/src/policy_components.c
index 69835550..bd3747b6 100644
--- a/libsemanage/src/policy_components.c
+++ b/libsemanage/src/policy_components.c
@@ -21,9 +21,9 @@ static int clear_obsolete(semanage_handle_t * handle,
 	record_key_t *key = NULL;
 	unsigned int i;
 
-	dbase_table_t *src_dtable = src->dtable;
-	dbase_table_t *dst_dtable = dst->dtable;
-	record_table_t *rtable = src_dtable->get_rtable(src->dbase);
+	const dbase_table_t *src_dtable = src->dtable;
+	const dbase_table_t *dst_dtable = dst->dtable;
+	const record_table_t *rtable = src_dtable->get_rtable(src->dbase);
 
 	for (i = 0; i < nrecords; i++) {
 		int exists;
@@ -65,8 +65,8 @@ static int load_records(semanage_handle_t * handle,
 	record_key_t *rkey = NULL;
 
 	dbase_t *dbase = dst->dbase;
-	dbase_table_t *dtable = dst->dtable;
-	record_table_t *rtable = dtable->get_rtable(dbase);
+	const dbase_table_t *dtable = dst->dtable;
+	const record_table_t *rtable = dtable->get_rtable(dbase);
 
 	for (i = 0; i < nrecords; i++) {
 
@@ -154,7 +154,7 @@ int semanage_base_merge_components(semanage_handle_t * handle)
 		dbase_config_t *src = components[i].src;
 		dbase_config_t *dst = components[i].dst;
 		int mode = components[i].mode;
-		record_table_t *rtable = src->dtable->get_rtable(src->dbase);
+		const record_table_t *rtable = src->dtable->get_rtable(src->dbase);
 
 		/* Must invoke cache function first */
 		if (src->dtable->cache(handle, src->dbase) < 0)
diff --git a/libsemanage/src/port_internal.h b/libsemanage/src/port_internal.h
index 67017472..3699ac7f 100644
--- a/libsemanage/src/port_internal.h
+++ b/libsemanage/src/port_internal.h
@@ -8,7 +8,7 @@
 #include "handle.h"
 
 /* PORT RECORD: method table */
-extern record_table_t SEMANAGE_PORT_RTABLE;
+extern const record_table_t SEMANAGE_PORT_RTABLE;
 
 extern int port_file_dbase_init(semanage_handle_t * handle,
 				const char *path_ro,
diff --git a/libsemanage/src/port_record.c b/libsemanage/src/port_record.c
index f8a1633e..d93e68f6 100644
--- a/libsemanage/src/port_record.c
+++ b/libsemanage/src/port_record.c
@@ -164,7 +164,7 @@ void semanage_port_free(semanage_port_t * port)
 
 
 /* Port base functions */
-record_table_t SEMANAGE_PORT_RTABLE = {
+const record_table_t SEMANAGE_PORT_RTABLE = {
 	.create = semanage_port_create,
 	.key_extract = semanage_port_key_extract,
 	.key_free = semanage_port_key_free,
diff --git a/libsemanage/src/ports_file.c b/libsemanage/src/ports_file.c
index 6158cb63..64f0c79d 100644
--- a/libsemanage/src/ports_file.c
+++ b/libsemanage/src/ports_file.c
@@ -161,7 +161,7 @@ static int port_parse(semanage_handle_t * handle,
 }
 
 /* PORT RECORD: FILE extension: method table */
-static record_file_table_t SEMANAGE_PORT_FILE_RTABLE = {
+static const record_file_table_t SEMANAGE_PORT_FILE_RTABLE = {
 	.parse = port_parse,
 	.print = port_print,
 };
diff --git a/libsemanage/src/ports_policydb.c b/libsemanage/src/ports_policydb.c
index e7f4fc0d..11ca53ab 100644
--- a/libsemanage/src/ports_policydb.c
+++ b/libsemanage/src/ports_policydb.c
@@ -35,7 +35,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* PORT RECORD (SEPOL): POLICYDB extension : method table */
-static record_policydb_table_t SEMANAGE_PORT_POLICYDB_RTABLE = {
+static const record_policydb_table_t SEMANAGE_PORT_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = (record_policydb_table_modify_t) sepol_port_modify,
 	.set = NULL,
diff --git a/libsemanage/src/seuser_internal.h b/libsemanage/src/seuser_internal.h
index fdb52ef9..80ac77a4 100644
--- a/libsemanage/src/seuser_internal.h
+++ b/libsemanage/src/seuser_internal.h
@@ -9,7 +9,7 @@
 #include "handle.h"
 
 /* SEUSER RECORD: method table */
-extern record_table_t SEMANAGE_SEUSER_RTABLE;
+extern const record_table_t SEMANAGE_SEUSER_RTABLE;
 
 extern int seuser_file_dbase_init(semanage_handle_t * handle,
 				  const char *path_ro,
diff --git a/libsemanage/src/seuser_record.c b/libsemanage/src/seuser_record.c
index 69ebea51..bfaa0d7a 100644
--- a/libsemanage/src/seuser_record.c
+++ b/libsemanage/src/seuser_record.c
@@ -246,7 +246,7 @@ void semanage_seuser_free(semanage_seuser_t * seuser)
 
 
 /* Record base functions */
-record_table_t SEMANAGE_SEUSER_RTABLE = {
+const record_table_t SEMANAGE_SEUSER_RTABLE = {
 	.create = semanage_seuser_create,
 	.key_extract = semanage_seuser_key_extract,
 	.key_free = semanage_seuser_key_free,
diff --git a/libsemanage/src/seusers_file.c b/libsemanage/src/seusers_file.c
index 7eb3f427..ed3bcb31 100644
--- a/libsemanage/src/seusers_file.c
+++ b/libsemanage/src/seusers_file.c
@@ -109,7 +109,7 @@ static int seuser_parse(semanage_handle_t * handle,
 }
 
 /* SEUSER RECORD: FILE extension: method table */
-static record_file_table_t SEMANAGE_SEUSER_FILE_RTABLE = {
+static const record_file_table_t SEMANAGE_SEUSER_FILE_RTABLE = {
 	.parse = seuser_parse,
 	.print = seuser_print,
 };
diff --git a/libsemanage/src/user_base_record.c b/libsemanage/src/user_base_record.c
index 47037665..3c20aa46 100644
--- a/libsemanage/src/user_base_record.c
+++ b/libsemanage/src/user_base_record.c
@@ -172,7 +172,7 @@ static int semanage_user_base_compare2_qsort(const semanage_user_base_t ** user,
 }
 
 /* Record base functions */
-record_table_t SEMANAGE_USER_BASE_RTABLE = {
+const record_table_t SEMANAGE_USER_BASE_RTABLE = {
 	.create = semanage_user_base_create,
 	.key_extract = semanage_user_base_key_extract,
 	.key_free = semanage_user_key_free,
diff --git a/libsemanage/src/user_extra_record.c b/libsemanage/src/user_extra_record.c
index d2707224..25349a9b 100644
--- a/libsemanage/src/user_extra_record.c
+++ b/libsemanage/src/user_extra_record.c
@@ -185,7 +185,7 @@ static int semanage_user_extra_compare2_qsort(const semanage_user_extra_t **
 }
 
 /* Record base functions */
-record_table_t SEMANAGE_USER_EXTRA_RTABLE = {
+const record_table_t SEMANAGE_USER_EXTRA_RTABLE = {
 	.create = semanage_user_extra_create,
 	.key_extract = semanage_user_extra_key_extract,
 	.key_free = semanage_user_key_free,
diff --git a/libsemanage/src/user_internal.h b/libsemanage/src/user_internal.h
index 678a73a5..65633572 100644
--- a/libsemanage/src/user_internal.h
+++ b/libsemanage/src/user_internal.h
@@ -9,13 +9,13 @@
 #include "handle.h"
 
 /* USER record: method table */
-extern record_table_t SEMANAGE_USER_RTABLE;
+extern const record_table_t SEMANAGE_USER_RTABLE;
 
 /* USER BASE record: method table */
-extern record_table_t SEMANAGE_USER_BASE_RTABLE;
+extern const record_table_t SEMANAGE_USER_BASE_RTABLE;
 
 /* USER EXTRA record: method table */
-extern record_table_t SEMANAGE_USER_EXTRA_RTABLE;
+extern const record_table_t SEMANAGE_USER_EXTRA_RTABLE;
 
 /* ============ Init/Release functions ========== */
 
diff --git a/libsemanage/src/user_record.c b/libsemanage/src/user_record.c
index b22c5c1c..325c719d 100644
--- a/libsemanage/src/user_record.c
+++ b/libsemanage/src/user_record.c
@@ -382,7 +382,7 @@ void semanage_user_free(semanage_user_t * user)
 }
 
 /* Record base functions */
-record_table_t SEMANAGE_USER_RTABLE = {
+const record_table_t SEMANAGE_USER_RTABLE = {
 	.create = semanage_user_create,
 	.key_extract = semanage_user_key_extract,
 	.key_free = semanage_user_key_free,
diff --git a/libsemanage/src/users_base_file.c b/libsemanage/src/users_base_file.c
index f4d15451..bbce4eed 100644
--- a/libsemanage/src/users_base_file.c
+++ b/libsemanage/src/users_base_file.c
@@ -195,7 +195,7 @@ static int user_base_parse(semanage_handle_t * handle,
 }
 
 /* USER BASE record: FILE extension: method table */
-static record_file_table_t SEMANAGE_USER_BASE_FILE_RTABLE = {
+static const record_file_table_t SEMANAGE_USER_BASE_FILE_RTABLE = {
 	.parse = user_base_parse,
 	.print = user_base_print,
 };
diff --git a/libsemanage/src/users_base_policydb.c b/libsemanage/src/users_base_policydb.c
index 2e2ea522..2c871739 100644
--- a/libsemanage/src/users_base_policydb.c
+++ b/libsemanage/src/users_base_policydb.c
@@ -35,7 +35,7 @@ typedef struct dbase_policydb dbase_t;
 #include "semanage_store.h"
 
 /* USER BASE record: POLICYDB extension: method table */
-static record_policydb_table_t SEMANAGE_USER_BASE_POLICYDB_RTABLE = {
+static const record_policydb_table_t SEMANAGE_USER_BASE_POLICYDB_RTABLE = {
 	.add = NULL,
 	.modify = (record_policydb_table_modify_t) sepol_user_modify,
 	.set = NULL,
diff --git a/libsemanage/src/users_extra_file.c b/libsemanage/src/users_extra_file.c
index b3a15da2..8f2f7139 100644
--- a/libsemanage/src/users_extra_file.c
+++ b/libsemanage/src/users_extra_file.c
@@ -100,7 +100,7 @@ static int user_extra_parse(semanage_handle_t * handle,
 }
 
 /* USER EXTRA RECORD: FILE extension: method table */
-static record_file_table_t SEMANAGE_USER_EXTRA_FILE_RTABLE = {
+static const record_file_table_t SEMANAGE_USER_EXTRA_FILE_RTABLE = {
 	.parse = user_extra_parse,
 	.print = user_extra_print,
 };
diff --git a/libsemanage/src/users_join.c b/libsemanage/src/users_join.c
index dba96f3d..5ca98677 100644
--- a/libsemanage/src/users_join.c
+++ b/libsemanage/src/users_join.c
@@ -22,7 +22,7 @@ typedef struct dbase_join dbase_t;
 #include "debug.h"
 
 /* USER record: JOIN extension: method table */
-static record_join_table_t SEMANAGE_USER_JOIN_RTABLE = {
+static const record_join_table_t SEMANAGE_USER_JOIN_RTABLE = {
 	.join = semanage_user_join,
 	.split = semanage_user_split,
 };
-- 
2.45.2

