Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA61A08A3
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334645; cv=none; b=eK7eGaiUDX+zrrhm8paooLgkLscubWkCbD5yYDp/YnNGYLDgXr9wKb6zS/rxrhwINL9smvWO+uDz3LOMBLCKau+6b7EtNb3yQSYgnwDpuy/3OL4wU6+B3Hoj7SuMCIqoupGCDnqa3ceEQQJEyhrSwTx4b0RLTzA6Q9z33oetmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334645; c=relaxed/simple;
	bh=QpP3lG3OTkKbciCe5Jo2aIlHtEiXCq5nWe1UMCEMYIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9shSys/x8/Klzt+QVgZ/bs6kGFOaalxfuyEkl0PWhkbzInJKaMTMMJ4yxnIKUMgkV0HAfK6YSuIIcBFnkpBJuiB70hhEHLuSz+ZItBuLZqDKLMCEbMQSr/AJ8KhWInfzGlw0Q4RbhRwT1tcuVOVVhPRXs9qk93d/VRV0fdd9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=quDJg2Hx; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="quDJg2Hx"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334638;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRF8X5JJqpASKAzaf0T9f2wPz7QehjAVj2xI0bmt4v8=;
	b=quDJg2Hx+z8Xg8V9d5PsI76lZK3KcDx3BNE12vOFHelDrS/6Nah1qCz/1c6GXn1SeJSKgW
	XiHH5M+FKIGA5wJ44ipQtoTVCSX8zASBs1vBns2lr7eAO0iojtGWH3qBXGxQebElZP2p1z
	3fzxeGD/763VqjAhYcaZNhCPUDcXUJLO3Ny9rf5AlJfJIQLrDDES7p2MACw/1dSTjk9w+l
	IdWvMaRr/32xJPF7QMuSntyVZYtJhadoDSOS6lihUarcXOnH5/OpyMwJfEaOhP28LTQGPD
	X4vnP5p5xlvPFVNSCsGUqkZTT1oCEj19netX0qwABWd9zNSStBCvTOTzSTro7A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 30/47] libsemanage: avoid misc function pointer casts
Date: Mon, 11 Nov 2024 15:16:49 +0100
Message-ID: <20241111141706.38039-30-cgoettsche@seltendoof.de>
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

Function pointer casts are strictly speaking undefined behavior.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/boolean_record.c     |  7 ++++---
 libsemanage/src/database.h           |  2 +-
 libsemanage/src/database_join.c      |  6 ++----
 libsemanage/src/fcontext_record.c    |  9 ++++-----
 libsemanage/src/genhomedircon.c      | 21 ++++++++++++---------
 libsemanage/src/ibendport_internal.h |  3 +--
 libsemanage/src/ibendport_record.c   |  8 +++++---
 libsemanage/src/ibendports_local.c   |  4 +---
 libsemanage/src/ibpkey_internal.h    |  3 +--
 libsemanage/src/ibpkey_record.c      |  8 +++++---
 libsemanage/src/ibpkeys_local.c      |  4 +---
 libsemanage/src/iface_record.c       |  8 +++++---
 libsemanage/src/node_internal.h      |  3 +--
 libsemanage/src/node_record.c        |  7 ++++---
 libsemanage/src/policy_components.c  |  4 +---
 libsemanage/src/port_internal.h      |  3 +--
 libsemanage/src/port_record.c        |  7 ++++---
 libsemanage/src/ports_local.c        |  4 +---
 libsemanage/src/seuser_record.c      |  7 ++++---
 libsemanage/src/seusers_local.c      |  3 ++-
 libsemanage/src/user_base_record.c   |  8 ++++----
 libsemanage/src/user_extra_record.c  |  9 ++++-----
 libsemanage/src/user_record.c        |  7 ++++---
 libsemanage/src/utilities.c          | 10 ++++++----
 libsemanage/src/utilities.h          |  3 +--
 25 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/libsemanage/src/boolean_record.c b/libsemanage/src/boolean_record.c
index 2cbdd09b..41632052 100644
--- a/libsemanage/src/boolean_record.c
+++ b/libsemanage/src/boolean_record.c
@@ -64,11 +64,12 @@ int semanage_bool_compare2(const semanage_bool_t * boolean,
 }
 
 
-static int semanage_bool_compare2_qsort(const semanage_bool_t ** boolean,
-					const semanage_bool_t ** boolean2)
+static int semanage_bool_compare2_qsort(const void *p1, const void *p2)
 {
+	const semanage_bool_t *const *boolean1 = p1;
+	const semanage_bool_t *const *boolean2 = p2;
 
-	return sepol_bool_compare2(*boolean, *boolean2);
+	return sepol_bool_compare2(*boolean1, *boolean2);
 }
 
 /* Name */
diff --git a/libsemanage/src/database.h b/libsemanage/src/database.h
index 1950b63d..33348e2e 100644
--- a/libsemanage/src/database.h
+++ b/libsemanage/src/database.h
@@ -43,7 +43,7 @@ typedef struct record_table {
 	/* Same as above, but dereferences the pointer first.
 	 * This function is intenteded to be used as a qsort
 	 * comparator. */
-	int (*compare2_qsort) (const record_t ** rec, const record_t ** rec2);
+	int (*compare2_qsort) (const void * rec, const void * rec2);
 
 	/* Deep-copy clone of this record */
 	int (*clone) (struct semanage_handle * handle,
diff --git a/libsemanage/src/database_join.c b/libsemanage/src/database_join.c
index 3e97f432..abe6c43c 100644
--- a/libsemanage/src/database_join.c
+++ b/libsemanage/src/database_join.c
@@ -78,12 +78,10 @@ static int dbase_join_cache(semanage_handle_t * handle, dbase_join_t * dbase)
 
 	/* Sort for quicker merge later */
 	if (rcount1 > 0) {
-		qsort(records1, rcount1, sizeof(record1_t *),
-		      (int (*)(const void *, const void *))rtable1->compare2_qsort);
+		qsort(records1, rcount1, sizeof(record1_t *), rtable1->compare2_qsort);
 	}
 	if (rcount2 > 0) {
-		qsort(records2, rcount2, sizeof(record2_t *),
-		      (int (*)(const void *, const void *))rtable2->compare2_qsort);
+		qsort(records2, rcount2, sizeof(record2_t *), rtable2->compare2_qsort);
 	}
 
 	/* Now merge into this dbase */
diff --git a/libsemanage/src/fcontext_record.c b/libsemanage/src/fcontext_record.c
index f36e8317..cc6932eb 100644
--- a/libsemanage/src/fcontext_record.c
+++ b/libsemanage/src/fcontext_record.c
@@ -121,13 +121,12 @@ int semanage_fcontext_compare2(const semanage_fcontext_t * fcontext,
 }
 
 
-static int semanage_fcontext_compare2_qsort(const semanage_fcontext_t **
-					    fcontext,
-					    const semanage_fcontext_t **
-					    fcontext2)
+static int semanage_fcontext_compare2_qsort(const void *p1, const void *p2)
 {
+	const semanage_fcontext_t *const *fcontext1 = p1;
+	const semanage_fcontext_t *const *fcontext2 = p2;
 
-	return semanage_fcontext_compare2(*fcontext, *fcontext2);
+	return semanage_fcontext_compare2(*fcontext1, *fcontext2);
 }
 
 /* Create */
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 2fabbbd8..53673645 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -757,14 +757,20 @@ static int seuser_sort_func(const void *arg1, const void *arg2)
 	return strcmp(name1, name2);
 }
 
-static int user_sort_func(semanage_user_t ** arg1, semanage_user_t ** arg2)
+static int user_sort_func(const void *arg1, const void *arg2)
 {
-	return strcmp(semanage_user_get_name(*arg1),
-		      semanage_user_get_name(*arg2));
+	const semanage_user_t *const *user1 = arg1;
+	const semanage_user_t *const *user2 = arg2;
+
+	return strcmp(semanage_user_get_name(*user1),
+		      semanage_user_get_name(*user2));
 }
 
-static int name_user_cmp(char *key, semanage_user_t ** val)
+static int name_user_cmp(const void *arg1, const void *arg2)
 {
+	const char *key = arg1;
+	const semanage_user_t *const *val = arg2;
+
 	return strcmp(key, semanage_user_get_name(*val));
 }
 
@@ -1184,8 +1190,7 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 
 	qsort(seuser_list, nseusers, sizeof(semanage_seuser_t *),
 	      &seuser_sort_func);
-	qsort(user_list, nusers, sizeof(semanage_user_t *),
-	      (int (*)(const void *, const void *))&user_sort_func);
+	qsort(user_list, nusers, sizeof(semanage_user_t *), user_sort_func);
 
 	for (i = 0; i < nseusers; i++) {
 		seuname = semanage_seuser_get_sename(seuser_list[i]);
@@ -1195,9 +1200,7 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 			continue;
 
 		/* find the user structure given the name */
-		u = bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *),
-			    (int (*)(const void *, const void *))
-			    &name_user_cmp);
+		u = bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *), name_user_cmp);
 
 		/* %groupname syntax */
 		if (name[0] == '%') {
diff --git a/libsemanage/src/ibendport_internal.h b/libsemanage/src/ibendport_internal.h
index 04e0da5a..946c262a 100644
--- a/libsemanage/src/ibendport_internal.h
+++ b/libsemanage/src/ibendport_internal.h
@@ -26,7 +26,6 @@ extern int semanage_ibendport_validate_local(semanage_handle_t *handle);
 
 /* ==== Internal (to ibendports) API === */
 
- int semanage_ibendport_compare2_qsort(const semanage_ibendport_t **ibendport,
-					     const semanage_ibendport_t **ibendport2);
+ int semanage_ibendport_compare2_qsort(const void *p1, const void *p2);
 
 #endif
diff --git a/libsemanage/src/ibendport_record.c b/libsemanage/src/ibendport_record.c
index 6afe8975..38f1a4b0 100644
--- a/libsemanage/src/ibendport_record.c
+++ b/libsemanage/src/ibendport_record.c
@@ -37,10 +37,12 @@ int semanage_ibendport_compare2(const semanage_ibendport_t *ibendport,
 }
 
 
- int semanage_ibendport_compare2_qsort(const semanage_ibendport_t **ibendport,
-					     const semanage_ibendport_t **ibendport2)
+ int semanage_ibendport_compare2_qsort(const void *p1, const void *p2)
 {
-	return sepol_ibendport_compare2(*ibendport, *ibendport2);
+	const semanage_ibendport_t *const *ibendport1 = p1;
+	const semanage_ibendport_t *const *ibendport2 = p2;
+
+	return sepol_ibendport_compare2(*ibendport1, *ibendport2);
 }
 
 int semanage_ibendport_key_create(semanage_handle_t *handle,
diff --git a/libsemanage/src/ibendports_local.c b/libsemanage/src/ibendports_local.c
index feebfa63..0b8c14d2 100644
--- a/libsemanage/src/ibendports_local.c
+++ b/libsemanage/src/ibendports_local.c
@@ -89,9 +89,7 @@ int semanage_ibendport_validate_local(semanage_handle_t *handle)
 	if (semanage_ibendport_list_local(handle, &ibendports, &nibendports) < 0)
 		goto err;
 
-	qsort(ibendports, nibendports, sizeof(semanage_ibendport_t *),
-	      (int (*)(const void *, const void *))
-	      &semanage_ibendport_compare2_qsort);
+	qsort(ibendports, nibendports, sizeof(semanage_ibendport_t *), semanage_ibendport_compare2_qsort);
 
 	/* Test each ibendport */
 	while (i < nibendports) {
diff --git a/libsemanage/src/ibpkey_internal.h b/libsemanage/src/ibpkey_internal.h
index c1d97876..8761b5af 100644
--- a/libsemanage/src/ibpkey_internal.h
+++ b/libsemanage/src/ibpkey_internal.h
@@ -26,7 +26,6 @@ extern int semanage_ibpkey_validate_local(semanage_handle_t *handle);
 
 /* ==== Internal (to ibpkeys) API === */
 
- int semanage_ibpkey_compare2_qsort(const semanage_ibpkey_t **ibpkey,
-					  const semanage_ibpkey_t **ibpkey2);
+ int semanage_ibpkey_compare2_qsort(const void *p1, const void *p2);
 
 #endif
diff --git a/libsemanage/src/ibpkey_record.c b/libsemanage/src/ibpkey_record.c
index 9a47f53b..e015663f 100644
--- a/libsemanage/src/ibpkey_record.c
+++ b/libsemanage/src/ibpkey_record.c
@@ -37,10 +37,12 @@ int semanage_ibpkey_compare2(const semanage_ibpkey_t *ibpkey,
 }
 
 
- int semanage_ibpkey_compare2_qsort(const semanage_ibpkey_t **ibpkey,
-					  const semanage_ibpkey_t **ibpkey2)
+ int semanage_ibpkey_compare2_qsort(const void *p1, const void *p2)
 {
-	return sepol_ibpkey_compare2(*ibpkey, *ibpkey2);
+	const semanage_ibpkey_t *const *ibpkey1 = p1;
+	const semanage_ibpkey_t *const *ibpkey2 = p2;
+
+	return sepol_ibpkey_compare2(*ibpkey1, *ibpkey2);
 }
 
 int semanage_ibpkey_key_create(semanage_handle_t *handle,
diff --git a/libsemanage/src/ibpkeys_local.c b/libsemanage/src/ibpkeys_local.c
index 6d05d125..6848bd0d 100644
--- a/libsemanage/src/ibpkeys_local.c
+++ b/libsemanage/src/ibpkeys_local.c
@@ -91,9 +91,7 @@ int semanage_ibpkey_validate_local(semanage_handle_t *handle)
 	if (semanage_ibpkey_list_local(handle, &ibpkeys, &nibpkeys) < 0)
 		goto err;
 
-	qsort(ibpkeys, nibpkeys, sizeof(semanage_ibpkey_t *),
-	      (int (*)(const void *, const void *))
-	      &semanage_ibpkey_compare2_qsort);
+	qsort(ibpkeys, nibpkeys, sizeof(semanage_ibpkey_t *), semanage_ibpkey_compare2_qsort);
 
 	/* Test each ibpkey for overlap */
 	while (i < nibpkeys) {
diff --git a/libsemanage/src/iface_record.c b/libsemanage/src/iface_record.c
index b94afa04..15c3175e 100644
--- a/libsemanage/src/iface_record.c
+++ b/libsemanage/src/iface_record.c
@@ -40,11 +40,13 @@ int semanage_iface_compare2(const semanage_iface_t * iface,
 }
 
 
-static int semanage_iface_compare2_qsort(const semanage_iface_t ** iface,
-					 const semanage_iface_t ** iface2)
+static int semanage_iface_compare2_qsort(const void *p1,
+					 const void *p2)
 {
+	const semanage_iface_t *const *iface1 = p1;
+	const semanage_iface_t *const *iface2 = p2;
 
-	return sepol_iface_compare2(*iface, *iface2);
+	return sepol_iface_compare2(*iface1, *iface2);
 }
 
 int semanage_iface_key_create(semanage_handle_t * handle,
diff --git a/libsemanage/src/node_internal.h b/libsemanage/src/node_internal.h
index 24041101..632e41e5 100644
--- a/libsemanage/src/node_internal.h
+++ b/libsemanage/src/node_internal.h
@@ -26,7 +26,6 @@ extern int semanage_node_validate_local(semanage_handle_t * handle);
 
 /* ==== Internal (to nodes) API === */
 
- int semanage_node_compare2_qsort(const semanage_node_t ** node,
-					const semanage_node_t ** node2);
+ int semanage_node_compare2_qsort(const void *p1, const void *p2);
 
 #endif
diff --git a/libsemanage/src/node_record.c b/libsemanage/src/node_record.c
index 9a018d4b..4d9bca42 100644
--- a/libsemanage/src/node_record.c
+++ b/libsemanage/src/node_record.c
@@ -41,11 +41,12 @@ int semanage_node_compare2(const semanage_node_t * node,
 }
 
 
- int semanage_node_compare2_qsort(const semanage_node_t ** node,
-					const semanage_node_t ** node2)
+ int semanage_node_compare2_qsort(const void *p1, const void *p2)
 {
+	const semanage_node_t *const *node1 = p1;
+	const semanage_node_t *const *node2 = p2;
 
-	return sepol_node_compare2(*node, *node2);
+	return sepol_node_compare2(*node1, *node2);
 }
 
 int semanage_node_key_create(semanage_handle_t * handle,
diff --git a/libsemanage/src/policy_components.c b/libsemanage/src/policy_components.c
index ca3fbd20..6557bb18 100644
--- a/libsemanage/src/policy_components.c
+++ b/libsemanage/src/policy_components.c
@@ -169,9 +169,7 @@ int semanage_base_merge_components(semanage_handle_t * handle)
 
 		/* Sort records on MODE_SORT */
 		if (mode & MODE_SORT) {
-			qsort(records, nrecords, sizeof(record_t *),
-			      (int (*)(const void *, const void *))rtable->
-			      compare2_qsort);
+			qsort(records, nrecords, sizeof(record_t *), rtable->compare2_qsort);
 		}
 
 		/* Clear obsolete ones for MODE_SET */
diff --git a/libsemanage/src/port_internal.h b/libsemanage/src/port_internal.h
index 3699ac7f..25c1f511 100644
--- a/libsemanage/src/port_internal.h
+++ b/libsemanage/src/port_internal.h
@@ -26,7 +26,6 @@ extern int semanage_port_validate_local(semanage_handle_t * handle);
 
 /* ==== Internal (to ports) API === */
 
- int semanage_port_compare2_qsort(const semanage_port_t ** port,
-					const semanage_port_t ** port2);
+ int semanage_port_compare2_qsort(const void* p1, const void *p2);
 
 #endif
diff --git a/libsemanage/src/port_record.c b/libsemanage/src/port_record.c
index d93e68f6..2ea138ce 100644
--- a/libsemanage/src/port_record.c
+++ b/libsemanage/src/port_record.c
@@ -40,11 +40,12 @@ int semanage_port_compare2(const semanage_port_t * port,
 }
 
 
- int semanage_port_compare2_qsort(const semanage_port_t ** port,
-					const semanage_port_t ** port2)
+ int semanage_port_compare2_qsort(const void *p1, const void *p2)
 {
+	const semanage_port_t *const * port1 = p1;
+	const semanage_port_t *const * port2 = p2;
 
-	return sepol_port_compare2(*port, *port2);
+	return sepol_port_compare2(*port1, *port2);
 }
 
 int semanage_port_key_create(semanage_handle_t * handle,
diff --git a/libsemanage/src/ports_local.c b/libsemanage/src/ports_local.c
index 0261b07f..7d4d0768 100644
--- a/libsemanage/src/ports_local.c
+++ b/libsemanage/src/ports_local.c
@@ -82,9 +82,7 @@ int semanage_port_validate_local(semanage_handle_t * handle)
 	/* List and sort the ports */
 	if (semanage_port_list_local(handle, &ports, &nports) < 0)
 		goto err;
-	qsort(ports, nports, sizeof(semanage_port_t *),
-	      (int (*)(const void *, const void *))
-	      &semanage_port_compare2_qsort);
+	qsort(ports, nports, sizeof(semanage_port_t *), semanage_port_compare2_qsort);
 
 	/* Test each port for overlap */
 	while (i < nports) {
diff --git a/libsemanage/src/seuser_record.c b/libsemanage/src/seuser_record.c
index bfaa0d7a..3a8ebfe0 100644
--- a/libsemanage/src/seuser_record.c
+++ b/libsemanage/src/seuser_record.c
@@ -99,11 +99,12 @@ int semanage_seuser_compare2(const semanage_seuser_t * seuser,
 }
 
 
-static int semanage_seuser_compare2_qsort(const semanage_seuser_t ** seuser,
-					  const semanage_seuser_t ** seuser2)
+static int semanage_seuser_compare2_qsort(const void *p1, const void *p2)
 {
+	const semanage_seuser_t *const *seuser1 = p1;
+	const semanage_seuser_t *const *seuser2 = p2;
 
-	return strcmp((*seuser)->name, (*seuser2)->name);
+	return semanage_seuser_compare2(*seuser1, *seuser2);
 }
 
 /* Name */
diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
index ec7bfb08..eb3f82bc 100644
--- a/libsemanage/src/seusers_local.c
+++ b/libsemanage/src/seusers_local.c
@@ -126,7 +126,8 @@ int semanage_seuser_modify_local(semanage_handle_t * handle,
 				 const semanage_seuser_t * data)
 {
 	int rc;
-	void *callback = (void *) handle->msg_callback;
+	__attribute__((format(printf, 3, 4)))
+	void (*callback) (void*, semanage_handle_t*, const char*, ...) = handle->msg_callback;
 	dbase_config_t *dconfig = semanage_seuser_dbase_local(handle);
 	const char *sename = semanage_seuser_get_sename(data);
 	const char *mls_range = semanage_seuser_get_mlsrange(data);
diff --git a/libsemanage/src/user_base_record.c b/libsemanage/src/user_base_record.c
index 3c20aa46..ed911de8 100644
--- a/libsemanage/src/user_base_record.c
+++ b/libsemanage/src/user_base_record.c
@@ -47,12 +47,12 @@ static int semanage_user_base_compare2(const semanage_user_base_t * user,
 	return sepol_user_compare2(user, user2);
 }
 
-static int semanage_user_base_compare2_qsort(const semanage_user_base_t ** user,
-					     const semanage_user_base_t **
-					     user2)
+static int semanage_user_base_compare2_qsort(const void *p1, const void *p2)
 {
+	const semanage_user_base_t *const *user1 = p1;
+	const semanage_user_base_t *const *user2 = p2;
 
-	return sepol_user_compare2(*user, *user2);
+	return sepol_user_compare2(*user1, *user2);
 }
 
 /* Name */
diff --git a/libsemanage/src/user_extra_record.c b/libsemanage/src/user_extra_record.c
index 25349a9b..a948114a 100644
--- a/libsemanage/src/user_extra_record.c
+++ b/libsemanage/src/user_extra_record.c
@@ -66,13 +66,12 @@ static int semanage_user_extra_compare2(const semanage_user_extra_t *
 	return strcmp(user_extra->name, user_extra2->name);
 }
 
-static int semanage_user_extra_compare2_qsort(const semanage_user_extra_t **
-					      user_extra,
-					      const semanage_user_extra_t **
-					      user_extra2)
+static int semanage_user_extra_compare2_qsort(const void *p1, const void *p2)
 {
+	const semanage_user_extra_t *const *user_extra1 = p1;
+	const semanage_user_extra_t *const *user_extra2 = p2;
 
-	return strcmp((*user_extra)->name, (*user_extra2)->name);
+	return semanage_user_extra_compare2(*user_extra1, *user_extra2);
 }
 
 /* Name */
diff --git a/libsemanage/src/user_record.c b/libsemanage/src/user_record.c
index 325c719d..47e89145 100644
--- a/libsemanage/src/user_record.c
+++ b/libsemanage/src/user_record.c
@@ -79,11 +79,12 @@ int semanage_user_compare2(const semanage_user_t * user,
 }
 
 
-static int semanage_user_compare2_qsort(const semanage_user_t ** user,
-					const semanage_user_t ** user2)
+static int semanage_user_compare2_qsort(const void *p1, const void *p2)
 {
+	const semanage_user_t *const *user1 = p1;
+	const semanage_user_t *const *user2 = p2;
 
-	return strcmp((*user)->name, (*user2)->name);
+	return semanage_user_compare2(*user1, *user2);
 }
 
 /* Name */
diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index ec578340..a64015f8 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -183,8 +183,7 @@ int semanage_list_sort(semanage_list_t ** l)
 		array[i++] = temp;
 	}
 
-	qsort(array, count, sizeof(semanage_list_t *),
-	      (int (*)(const void *, const void *))&semanage_cmp_plist_t);
+	qsort(array, count, sizeof(semanage_list_t *), semanage_cmp_plist_t);
 	for (i = 0; i < (count - 1); ++i) {
 		array[i]->next = array[i + 1];
 	}
@@ -195,9 +194,12 @@ int semanage_list_sort(semanage_list_t ** l)
 	return 0;
 }
 
-int semanage_cmp_plist_t(const semanage_list_t ** x, const semanage_list_t ** y)
+int semanage_cmp_plist_t(const void *x, const void *y)
 {
-	return strcmp((*x)->data, (*y)->data);
+	const semanage_list_t *const *l1 = x;
+	const semanage_list_t *const *l2 = y;
+
+	return strcmp((*l1)->data, (*l2)->data);
 }
 
 int semanage_str_count(const char *data, char what)
diff --git a/libsemanage/src/utilities.h b/libsemanage/src/utilities.h
index 78f1f96e..4cc41f84 100644
--- a/libsemanage/src/utilities.h
+++ b/libsemanage/src/utilities.h
@@ -98,8 +98,7 @@ int semanage_list_sort(semanage_list_t ** l) WARN_UNUSED;
  * returns strcmp(x->data, y->data)
  * used internally by semanage_list_sort()
  */
-int semanage_cmp_plist_t(const semanage_list_t ** x,
-			 const semanage_list_t ** y);
+int semanage_cmp_plist_t(const void *x, const void *y);
 /**
  * @param      data a target string
  * @param      what  a character
-- 
2.45.2

