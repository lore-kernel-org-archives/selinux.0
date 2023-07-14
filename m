Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F49C001B0
	for <selinux@archiver.kernel.org>; Fri, 14 Jul 2023 18:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbjGNSYQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjGNSYQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jul 2023 14:24:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAB6C6
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:24:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e29ede885so2714276a12.3
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689359052; x=1691951052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dNtOztyu3PlaFRtpjmEY3mi/L4XNyaGfwYiOecIQZ8w=;
        b=HyP5QX9WlrIlmvDIvMmB/s68pkglMTHjk90r8Y8r/eVzmWDKCapOMOkBKf5+EGwT5A
         W8Ri81iTE7VSiTics4i7t90tyoMGKuOTSgZtWVOYjLJ28tQLMQXSGdXr3H6vKZfHZ4Kf
         z9A+V7upzoDYDO/BO0VDvwSnG77ojPRX4oBCYb0OxTfwAhrwiF7jzKubab3VkRO/ZXWJ
         oBsZ9JkwoN4LtkVuF5T087UEjCmXmmUU2JR4CoWR+HHYNvPsyaeheVZ0hJ90mMT/ySbn
         hYGC4e1aRrlY9NjcvLX7bxwiRo6gvDqHr/uBhscreFzSyNRO3bHvQY9kAyp5+vFt7gus
         ryMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689359052; x=1691951052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNtOztyu3PlaFRtpjmEY3mi/L4XNyaGfwYiOecIQZ8w=;
        b=lFznhBwe/DIH2mlmZGbE/6CliXcJJsqozw7jTJBGiqEaULBX0e+/pUUoXyDqmLvBNS
         DfnXMHePlwg4yhK92vEUQeGM2kSQj9mdD+stjcK8pMbJH16MW2TmXf2BHbTJtYsq8cql
         04lx8yoXmd6xSjafoY1V0zlXks00QTDQbuM2O1reFiH6c7Cos/Il27YgyLSW/Xh2VT4F
         Kc/7pUMrz1npxTW4QgNzQcu5UCGLUjXcyL0demGgcsRmgTnWjoKfKnTJLYvm6+Vw5upC
         eGDgVV5sWhzcwYt45q3cMggifR29V0mBh74X+Z/QFvsx8qigVsxjezMxvgkb6l9kd+1g
         iFBg==
X-Gm-Message-State: ABy/qLZ54MLWhbmhi6RPuhGnhDELRalsQVXe6Ebicuq/Lm7Ms36lZT07
        u/Pp64FW/OKoNejLnjLWhCUHlrcHngbwvA==
X-Google-Smtp-Source: APBJJlGn+4GTjpgG0IHMB0Z8b8v+VzvrFS2gkEKGnfmv3pZuUInDGGZATYfmgiH9MQr8X0jRdfPGDA==
X-Received: by 2002:a05:6402:2037:b0:51d:92bf:e6b9 with SMTP id ay23-20020a056402203700b0051d92bfe6b9mr4722271edb.34.1689359052295;
        Fri, 14 Jul 2023 11:24:12 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-078-050-124-229.78.50.pool.telefonica.de. [78.50.124.229])
        by smtp.gmail.com with ESMTPSA id w22-20020aa7da56000000b0051e1a4454b2sm6009832eds.67.2023.07.14.11.24.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:24:11 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: optional data destruction in hashtab_destroy()
Date:   Fri, 14 Jul 2023 20:24:06 +0200
Message-Id: <20230714182406.28723-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Support the destruction of the hashtable entries via an optional
callback in hashtab_destroy(), to avoid iterating the hashtable twice in
common use cases, one time for the entry destruction via hashtab_map()
and a second time via hashtab_destroy() to free the hashtable itself.

Also convert all the destroy callbacks to return void instead of the
needless value of 0.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/module_compiler.c                 |  6 +-
 libsepol/cil/src/cil_binary.c                 |  9 +--
 libsepol/cil/src/cil_strpool.c                |  6 +-
 libsepol/cil/src/cil_symtab.c                 |  6 +-
 libsepol/include/sepol/policydb/conditional.h |  2 +-
 libsepol/include/sepol/policydb/hashtab.h     |  8 ++-
 libsepol/include/sepol/policydb/policydb.h    |  2 +-
 libsepol/src/conditional.c                    |  3 +-
 libsepol/src/hashtab.c                        |  7 ++-
 libsepol/src/policydb.c                       | 55 +++++++------------
 libsepol/src/symtab.c                         |  3 +-
 libsepol/src/write.c                          |  6 +-
 12 files changed, 48 insertions(+), 65 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 5fe1729a..554b625f 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -761,20 +761,18 @@ int add_perm_to_class(uint32_t perm_value, uint32_t class_value)
 	return 0;
 }
 
-static int perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
+static void perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 			__attribute__ ((unused)))
 {
 	if (key)
 		free(key);
 	free(datum);
-	return 0;
 }
 
 static void class_datum_destroy(class_datum_t * cladatum)
 {
 	if (cladatum != NULL) {
-		hashtab_map(cladatum->permissions.table, perm_destroy, NULL);
-		hashtab_destroy(cladatum->permissions.table);
+		hashtab_destroy(cladatum->permissions.table, perm_destroy, NULL);
 		free(cladatum);
 	}
 }
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index ea0cef32..8aa305c9 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1984,13 +1984,11 @@ exit:
 	return rc;
 }
 
-static int __cil_avrulex_ioctl_destroy(hashtab_key_t k, hashtab_datum_t datum, __attribute__((unused)) void *args)
+static void __cil_avrulex_ioctl_destroy(hashtab_key_t k, hashtab_datum_t datum, __attribute__((unused)) void *args)
 {
 	free(k);
 	ebitmap_destroy(datum);
 	free(datum);
-
-	return SEPOL_OK;
 }
 
 static int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute__((unused)) uint32_t *finished, void *extra_args)
@@ -5230,9 +5228,8 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 	rc = SEPOL_OK;
 
 exit:
-	hashtab_destroy(role_trans_table);
-	hashtab_map(avrulex_ioctl_table, __cil_avrulex_ioctl_destroy, NULL);
-	hashtab_destroy(avrulex_ioctl_table);
+	hashtab_destroy(role_trans_table, NULL, NULL);
+	hashtab_destroy(avrulex_ioctl_table, __cil_avrulex_ioctl_destroy, NULL);
 	free(type_value_to_cil);
 	free(class_value_to_cil);
 	if (perm_value_to_cil != NULL) {
diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpool.c
index e32ee4e9..18ecfe87 100644
--- a/libsepol/cil/src/cil_strpool.c
+++ b/libsepol/cil/src/cil_strpool.c
@@ -87,12 +87,11 @@ char *cil_strpool_add(const char *str)
 	return strpool_ref->str;
 }
 
-static int cil_strpool_entry_destroy(hashtab_key_t k __attribute__ ((unused)), hashtab_datum_t d, void *args __attribute__ ((unused)))
+static void cil_strpool_entry_destroy(hashtab_key_t k __attribute__ ((unused)), hashtab_datum_t d, void *args __attribute__ ((unused)))
 {
 	struct cil_strpool_entry *strpool_ref = (struct cil_strpool_entry*)d;
 	free(strpool_ref->str);
 	free(strpool_ref);
-	return SEPOL_OK;
 }
 
 void cil_strpool_init(void)
@@ -115,8 +114,7 @@ void cil_strpool_destroy(void)
 	pthread_mutex_lock(&cil_strpool_mutex);
 	cil_strpool_readers--;
 	if (cil_strpool_readers == 0) {
-		hashtab_map(cil_strpool_tab, cil_strpool_entry_destroy, NULL);
-		hashtab_destroy(cil_strpool_tab);
+		hashtab_destroy(cil_strpool_tab, cil_strpool_entry_destroy, NULL);
 		cil_strpool_tab = NULL;
 	}
 	pthread_mutex_unlock(&cil_strpool_mutex);
diff --git a/libsepol/cil/src/cil_symtab.c b/libsepol/cil/src/cil_symtab.c
index 7e43a690..73cdd734 100644
--- a/libsepol/cil/src/cil_symtab.c
+++ b/libsepol/cil/src/cil_symtab.c
@@ -133,18 +133,16 @@ int cil_symtab_map(symtab_t *symtab,
 	return hashtab_map(symtab->table, apply, args);
 }
 
-static int __cil_symtab_destroy_helper(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, __attribute__((unused)) void *args)
+static void __cil_symtab_destroy_helper(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, __attribute__((unused)) void *args)
 {
 	struct cil_symtab_datum *datum = d;
 	datum->symtab = NULL;
-	return SEPOL_OK;
 }
 
 void cil_symtab_destroy(symtab_t *symtab)
 {
 	if (symtab->table != NULL){
-		cil_symtab_map(symtab, __cil_symtab_destroy_helper, NULL);
-		hashtab_destroy(symtab->table);
+		hashtab_destroy(symtab->table, __cil_symtab_destroy_helper, NULL);
 		symtab->table = NULL;
 	}
 }
diff --git a/libsepol/include/sepol/policydb/conditional.h b/libsepol/include/sepol/policydb/conditional.h
index 5318ea19..9b19946b 100644
--- a/libsepol/include/sepol/policydb/conditional.h
+++ b/libsepol/include/sepol/policydb/conditional.h
@@ -127,7 +127,7 @@ extern void cond_policydb_destroy(policydb_t * p);
 extern void cond_list_destroy(cond_list_t * list);
 
 extern int cond_init_bool_indexes(policydb_t * p);
-extern int cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, void *p);
+extern void cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, void *p);
 
 extern int cond_index_bool(hashtab_key_t key, hashtab_datum_t datum,
 			   void *datap);
diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/include/sepol/policydb/hashtab.h
index 354ebb43..7aa88f3b 100644
--- a/libsepol/include/sepol/policydb/hashtab.h
+++ b/libsepol/include/sepol/policydb/hashtab.h
@@ -89,8 +89,14 @@ extern hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t k);
 
 /*
    Destroys the specified hash table.
+   Applies the specified destroy function to (key,datum,args) for
+   all entries.
+
  */
-extern void hashtab_destroy(hashtab_t h);
+extern void hashtab_destroy(hashtab_t h,
+			    void (*destroy) (hashtab_key_t k,
+					    hashtab_datum_t d,
+					    void *args), void *args);
 
 /*
    Applies the specified apply function to (key,datum,args)
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 48b7b8bb..8cf82da6 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -634,7 +634,7 @@ extern int policydb_context_isvalid(const policydb_t * p,
 				    const context_struct_t * c);
 
 extern void symtabs_destroy(symtab_t * symtab);
-extern int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
+extern void scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
 
 extern void class_perm_node_init(class_perm_node_t * x);
 extern void type_set_init(type_set_t * x);
diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index 7900e928..b51639d4 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -528,13 +528,12 @@ int cond_init_bool_indexes(policydb_t * p)
 	return 0;
 }
 
-int cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, void *p
+void cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, void *p
 		      __attribute__ ((unused)))
 {
 	if (key)
 		free(key);
 	free(datum);
-	return 0;
 }
 
 int cond_index_bool(hashtab_key_t key, hashtab_datum_t datum, void *datap)
diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index 922a8a4a..7f3dd00b 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -193,7 +193,10 @@ hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
 	return cur->datum;
 }
 
-void hashtab_destroy(hashtab_t h)
+void hashtab_destroy(hashtab_t h,
+		     void (*destroy) (hashtab_key_t k,
+				      hashtab_datum_t d,
+				      void *args), void *args)
 {
 	unsigned int i;
 	hashtab_ptr_t cur, temp;
@@ -206,6 +209,8 @@ void hashtab_destroy(hashtab_t h)
 		while (cur != NULL) {
 			temp = cur;
 			cur = cur->next;
+			if (destroy)
+				destroy(temp->key, temp->datum, args);
 			free(temp);
 		}
 		h->htable[i] = NULL;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 552eb77a..f443ea88 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -895,10 +895,10 @@ int policydb_init(policydb_t * p)
 
 	return 0;
 err:
-	hashtab_destroy(p->range_tr);
+	hashtab_destroy(p->range_tr, NULL, NULL);
 	for (i = 0; i < SYM_NUM; i++) {
-		hashtab_destroy(p->symtab[i].table);
-		hashtab_destroy(p->scope[i].table);
+		hashtab_destroy(p->symtab[i].table, NULL, NULL);
+		hashtab_destroy(p->scope[i].table, NULL, NULL);
 	}
 	avrule_block_list_destroy(p->global);
 	return rc;
@@ -1264,16 +1264,15 @@ int policydb_index_others(sepol_handle_t * handle,
  * symbol data in the policy database.
  */
 
-static int perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
+static void perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 			__attribute__ ((unused)))
 {
 	if (key)
 		free(key);
 	free(datum);
-	return 0;
 }
 
-static int common_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
+static void common_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 			  __attribute__ ((unused)))
 {
 	common_datum_t *comdatum;
@@ -1281,13 +1280,11 @@ static int common_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 	if (key)
 		free(key);
 	comdatum = (common_datum_t *) datum;
-	(void)hashtab_map(comdatum->permissions.table, perm_destroy, 0);
-	hashtab_destroy(comdatum->permissions.table);
+	hashtab_destroy(comdatum->permissions.table, perm_destroy, NULL);
 	free(datum);
-	return 0;
 }
 
-static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
+static void class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 			 __attribute__ ((unused)))
 {
 	class_datum_t *cladatum;
@@ -1297,10 +1294,9 @@ static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 		free(key);
 	cladatum = (class_datum_t *) datum;
 	if (cladatum == NULL) {
-		return 0;
+		return;
 	}
-	(void)hashtab_map(cladatum->permissions.table, perm_destroy, 0);
-	hashtab_destroy(cladatum->permissions.table);
+	hashtab_destroy(cladatum->permissions.table, perm_destroy, NULL);
 	constraint = cladatum->constraints;
 	while (constraint) {
 		constraint_expr_destroy(constraint->expr);
@@ -1320,37 +1316,33 @@ static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 	if (cladatum->comkey)
 		free(cladatum->comkey);
 	free(datum);
-	return 0;
 }
 
-static int role_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
+static void role_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 			__attribute__ ((unused)))
 {
 	free(key);
 	role_datum_destroy((role_datum_t *) datum);
 	free(datum);
-	return 0;
 }
 
-static int type_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
+static void type_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 			__attribute__ ((unused)))
 {
 	free(key);
 	type_datum_destroy((type_datum_t *) datum);
 	free(datum);
-	return 0;
 }
 
-static int user_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
+static void user_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 			__attribute__ ((unused)))
 {
 	free(key);
 	user_datum_destroy((user_datum_t *) datum);
 	free(datum);
-	return 0;
 }
 
-static int sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
+static void sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 			__attribute__ ((unused)))
 {
 	level_datum_t *levdatum;
@@ -1362,25 +1354,23 @@ static int sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 	free(levdatum->level);
 	level_datum_destroy(levdatum);
 	free(levdatum);
-	return 0;
 }
 
-static int cat_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
+static void cat_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 		       __attribute__ ((unused)))
 {
 	if (key)
 		free(key);
 	cat_datum_destroy((cat_datum_t *) datum);
 	free(datum);
-	return 0;
 }
 
-static int (*destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
+static void (*destroy_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum,
 				  void *datap) = {
 common_destroy, class_destroy, role_destroy, type_destroy, user_destroy,
 	    cond_destroy_bool, sens_destroy, cat_destroy,};
 
-static int range_tr_destroy(hashtab_key_t key, hashtab_datum_t datum,
+static void range_tr_destroy(hashtab_key_t key, hashtab_datum_t datum,
 			    void *p __attribute__ ((unused)))
 {
 	struct mls_range *rt = (struct mls_range *)datum;
@@ -1388,7 +1378,6 @@ static int range_tr_destroy(hashtab_key_t key, hashtab_datum_t datum,
 	ebitmap_destroy(&rt->level[0].cat);
 	ebitmap_destroy(&rt->level[1].cat);
 	free(datum);
-	return 0;
 }
 
 static void ocontext_selinux_free(ocontext_t **ocontexts)
@@ -1468,8 +1457,7 @@ void policydb_destroy(policydb_t * p)
 	free(p->decl_val_to_struct);
 
 	for (i = 0; i < SYM_NUM; i++) {
-		(void)hashtab_map(p->scope[i].table, scope_destroy, 0);
-		hashtab_destroy(p->scope[i].table);
+		hashtab_destroy(p->scope[i].table, scope_destroy, NULL);
 	}
 	avrule_block_list_destroy(p->global);
 	free(p->name);
@@ -1515,8 +1503,7 @@ void policydb_destroy(policydb_t * p)
 	if (lra)
 		free(lra);
 
-	hashtab_map(p->range_tr, range_tr_destroy, NULL);
-	hashtab_destroy(p->range_tr);
+	hashtab_destroy(p->range_tr, range_tr_destroy, NULL);
 
 	if (p->type_attr_map) {
 		for (i = 0; i < p->p_types.nprim; i++) {
@@ -1539,12 +1526,11 @@ void symtabs_destroy(symtab_t * symtab)
 {
 	int i;
 	for (i = 0; i < SYM_NUM; i++) {
-		(void)hashtab_map(symtab[i].table, destroy_f[i], 0);
-		hashtab_destroy(symtab[i].table);
+		hashtab_destroy(symtab[i].table, destroy_f[i], NULL);
 	}
 }
 
-int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
+void scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 		  __attribute__ ((unused)))
 {
 	scope_datum_t *cur = (scope_datum_t *) datum;
@@ -1553,7 +1539,6 @@ int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
 		free(cur->decl_ids);
 	}
 	free(cur);
-	return 0;
 }
 
 /*
diff --git a/libsepol/src/symtab.c b/libsepol/src/symtab.c
index a6061851..3430bfc0 100644
--- a/libsepol/src/symtab.c
+++ b/libsepol/src/symtab.c
@@ -51,7 +51,6 @@ void symtab_destroy(symtab_t * s)
 	if (!s)
 		return;
 	if (s->table)
-		hashtab_destroy(s->table);
-	return;
+		hashtab_destroy(s->table, NULL, NULL);
 }
 /* FLASK */
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index f0ed9e33..2eb08bb7 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -539,7 +539,7 @@ static int filenametr_cmp(hashtab_t h __attribute__ ((unused)),
 	return strcmp(ft1->name, ft2->name);
 }
 
-static int filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
+static void filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
 			      void *p __attribute__ ((unused)))
 {
 	filenametr_key_t *ft = (filenametr_key_t *)key;
@@ -553,7 +553,6 @@ static int filenametr_destroy(hashtab_key_t key, hashtab_datum_t datum,
 		free(fd);
 		fd = next;
 	} while (fd);
-	return 0;
 }
 
 typedef struct {
@@ -778,8 +777,7 @@ static int avtab_filename_trans_write(policydb_t *pol, avtab_t *a,
 
 out:
 	/* destroy temp filename transitions table */
-	hashtab_map(fnts_tab, filenametr_destroy, NULL);
-	hashtab_destroy(fnts_tab);
+	hashtab_destroy(fnts_tab, filenametr_destroy, NULL);
 
 	return rc ? -1 : 0;
 }
-- 
2.40.1

