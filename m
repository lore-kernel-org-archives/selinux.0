Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D848C34050
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 13:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F0D24654
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 13:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDBexKuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgBSNpb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:45:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44414 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726548AbgBSNpb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 08:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582119930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhMlmbi0K8oYlUQr3O0miIXTcXkIKPd2vYBx0tsnyu8=;
        b=YDBexKuRAeHCDFiKjY22gB9ac2hR9BhqfZKTnhdguG1o4Vq1HQ+h+5wDu91kkfB4xqK/oZ
        jKAgyyf6QRSVOwCyktfcoik41dSHpw4SwJ6H2dFpheER5XWsPi5LqQSySwS8lwiWa7+woP
        S8IY+2wj5sRsjN7/EtUquFKXVMfWcDM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-QpNCZ5beMZy9FJ67IAALWA-1; Wed, 19 Feb 2020 08:45:28 -0500
X-MC-Unique: QpNCZ5beMZy9FJ67IAALWA-1
Received: by mail-wr1-f72.google.com with SMTP id d8so66645wrq.12
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 05:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhMlmbi0K8oYlUQr3O0miIXTcXkIKPd2vYBx0tsnyu8=;
        b=IAxr74/lY1q0HkL6WdAJKH2SokQrelBo0UyyaBW/De+Uotz9dwe0iUyHXLjVU7BRg8
         ji82JC7dObVjvKWnZ6gWPz/EqnKbRWnEL9JXu/SeuX6e60rbIkIE1e1DEYjWEH8+Qz5P
         duRkGjtmDaOhxEcxjk1rNWl+lcDLu4Xon31XsKg5mnlKmT5AjSa4sly9irwNh45XKNRl
         vXOZzARk5WlHao0g8WVJuI7IQRg97/maWaAk/rNzzU7C+iDzwR5EvaXIc2BjrC7RpQV/
         wlkhp16jom0meEyTiO+/5DVFLarh8cFNk4FDZcr9TK4fJAy1dPYHhZeHrPkxIx+jMuwR
         QDVg==
X-Gm-Message-State: APjAAAXLQu98q5IZ7OK+mCSkBmUKmX5pGJ4rPYRRtVhvBeuXYQT2X5Y9
        SZbxfpPLDHaNb14lktun14cxG+KGju9jYCByTuMu0UXrqosDDGq+R/5ZdjRdzbrEEHEUcKTh5l4
        VYE2lJ1eamBxwznAcdg==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr10538741wmb.41.1582119925730;
        Wed, 19 Feb 2020 05:45:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4RV8MK0NVZAR6HFrWPa6yVbyPIxzxIngZwx7Ckf90XjdHvPVu9xOZMeMUJpufxCbGXv+4FQ==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr10538715wmb.41.1582119925299;
        Wed, 19 Feb 2020 05:45:25 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f11sm3036558wml.3.2020.02.19.05.45.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 05:45:24 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsepol,newrole: remove unused hashtab functions
Date:   Wed, 19 Feb 2020 14:45:21 +0100
Message-Id: <20200219134522.230822-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219134522.230822-1-omosnace@redhat.com>
References: <20200219134522.230822-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

hashtab_replace() and hashtab_map_remove_on_error() aren't used
anywhere, no need to keep them around...

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/include/sepol/policydb/hashtab.h | 28 --------
 libsepol/src/hashtab.c                    | 85 -----------------------
 policycoreutils/newrole/hashtab.c         | 85 -----------------------
 policycoreutils/newrole/hashtab.h         | 28 --------
 4 files changed, 226 deletions(-)

diff --git a/libsepol/include/sepol/policydb/hashtab.h b/libsepol/include/sepol/policydb/hashtab.h
index ca5ba862..dca8c983 100644
--- a/libsepol/include/sepol/policydb/hashtab.h
+++ b/libsepol/include/sepol/policydb/hashtab.h
@@ -79,20 +79,6 @@ extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
 					   hashtab_datum_t d,
 					   void *args), void *args);
 
-/*
-   Insert or replace the specified (key, datum) pair in the specified
-   hash table.  If an entry for the specified key already exists,
-   then the specified destroy function is applied to (key,datum,args)
-   for the entry prior to replacing the entry's contents.
-
-   Returns SEPOL_ENOMEM if insufficient space is available or
-   SEPOL_OK otherwise.
- */
-extern int hashtab_replace(hashtab_t h, hashtab_key_t k, hashtab_datum_t d,
-			   void (*destroy) (hashtab_key_t k,
-					    hashtab_datum_t d,
-					    void *args), void *args);
-
 /*
    Searches for the entry with the specified key in the hash table.
 
@@ -122,20 +108,6 @@ extern int hashtab_map(hashtab_t h,
 				     hashtab_datum_t d,
 				     void *args), void *args);
 
-/*
-   Same as hashtab_map, except that if apply returns a non-zero status,
-   then the (key,datum) pair will be removed from the hashtab and the
-   destroy function will be applied to (key,datum,args).
- */
-extern void hashtab_map_remove_on_error(hashtab_t h,
-					int (*apply) (hashtab_key_t k,
-						      hashtab_datum_t d,
-						      void *args),
-					void (*destroy) (hashtab_key_t k,
-							 hashtab_datum_t d,
-							 void *args),
-					void *args);
-
 extern void hashtab_hash_eval(hashtab_t h, char *tag);
 
 #ifdef __cplusplus
diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index f5407ab6..9590b359 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -133,48 +133,6 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
 	return SEPOL_OK;
 }
 
-int hashtab_replace(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum,
-		    void (*destroy) (hashtab_key_t k,
-				     hashtab_datum_t d, void *args), void *args)
-{
-	int hvalue;
-	hashtab_ptr_t prev, cur, newnode;
-
-	if (!h)
-		return SEPOL_ENOMEM;
-
-	hvalue = h->hash_value(h, key);
-	prev = NULL;
-	cur = h->htable[hvalue];
-	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
-		prev = cur;
-		cur = cur->next;
-	}
-
-	if (cur && (h->keycmp(h, key, cur->key) == 0)) {
-		if (destroy)
-			destroy(cur->key, cur->datum, args);
-		cur->key = key;
-		cur->datum = datum;
-	} else {
-		newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
-		if (newnode == NULL)
-			return SEPOL_ENOMEM;
-		memset(newnode, 0, sizeof(struct hashtab_node));
-		newnode->key = key;
-		newnode->datum = datum;
-		if (prev) {
-			newnode->next = prev->next;
-			prev->next = newnode;
-		} else {
-			newnode->next = h->htable[hvalue];
-			h->htable[hvalue] = newnode;
-		}
-	}
-
-	return SEPOL_OK;
-}
-
 hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
 {
 
@@ -241,49 +199,6 @@ int hashtab_map(hashtab_t h,
 	return SEPOL_OK;
 }
 
-void hashtab_map_remove_on_error(hashtab_t h,
-				 int (*apply) (hashtab_key_t k,
-					       hashtab_datum_t d,
-					       void *args),
-				 void (*destroy) (hashtab_key_t k,
-						  hashtab_datum_t d,
-						  void *args), void *args)
-{
-	unsigned int i;
-	int ret;
-	hashtab_ptr_t last, cur, temp;
-
-	if (!h)
-		return;
-
-	for (i = 0; i < h->size; i++) {
-		last = NULL;
-		cur = h->htable[i];
-		while (cur != NULL) {
-			ret = apply(cur->key, cur->datum, args);
-			if (ret) {
-				if (last) {
-					last->next = cur->next;
-				} else {
-					h->htable[i] = cur->next;
-				}
-
-				temp = cur;
-				cur = cur->next;
-				if (destroy)
-					destroy(temp->key, temp->datum, args);
-				free(temp);
-				h->nel--;
-			} else {
-				last = cur;
-				cur = cur->next;
-			}
-		}
-	}
-
-	return;
-}
-
 void hashtab_hash_eval(hashtab_t h, char *tag)
 {
 	unsigned int i;
diff --git a/policycoreutils/newrole/hashtab.c b/policycoreutils/newrole/hashtab.c
index 24c65c49..bc502836 100644
--- a/policycoreutils/newrole/hashtab.c
+++ b/policycoreutils/newrole/hashtab.c
@@ -112,48 +112,6 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
 	return HASHTAB_SUCCESS;
 }
 
-int hashtab_replace(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum,
-		    void (*destroy) (hashtab_key_t k,
-				     hashtab_datum_t d, void *args), void *args)
-{
-	int hvalue;
-	hashtab_ptr_t prev, cur, newnode;
-
-	if (!h)
-		return HASHTAB_OVERFLOW;
-
-	hvalue = h->hash_value(h, key);
-	prev = NULL;
-	cur = h->htable[hvalue];
-	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
-		prev = cur;
-		cur = cur->next;
-	}
-
-	if (cur && (h->keycmp(h, key, cur->key) == 0)) {
-		if (destroy)
-			destroy(cur->key, cur->datum, args);
-		cur->key = key;
-		cur->datum = datum;
-	} else {
-		newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
-		if (newnode == NULL)
-			return HASHTAB_OVERFLOW;
-		memset(newnode, 0, sizeof(struct hashtab_node));
-		newnode->key = key;
-		newnode->datum = datum;
-		if (prev) {
-			newnode->next = prev->next;
-			prev->next = newnode;
-		} else {
-			newnode->next = h->htable[hvalue];
-			h->htable[hvalue] = newnode;
-		}
-	}
-
-	return HASHTAB_SUCCESS;
-}
-
 hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
 {
 
@@ -220,49 +178,6 @@ int hashtab_map(hashtab_t h,
 	return HASHTAB_SUCCESS;
 }
 
-void hashtab_map_remove_on_error(hashtab_t h,
-				 int (*apply) (hashtab_key_t k,
-					       hashtab_datum_t d,
-					       void *args),
-				 void (*destroy) (hashtab_key_t k,
-						  hashtab_datum_t d,
-						  void *args), void *args)
-{
-	unsigned int i;
-	int ret;
-	hashtab_ptr_t last, cur, temp;
-
-	if (!h)
-		return;
-
-	for (i = 0; i < h->size; i++) {
-		last = NULL;
-		cur = h->htable[i];
-		while (cur != NULL) {
-			ret = apply(cur->key, cur->datum, args);
-			if (ret) {
-				if (last) {
-					last->next = cur->next;
-				} else {
-					h->htable[i] = cur->next;
-				}
-
-				temp = cur;
-				cur = cur->next;
-				if (destroy)
-					destroy(temp->key, temp->datum, args);
-				free(temp);
-				h->nel--;
-			} else {
-				last = cur;
-				cur = cur->next;
-			}
-		}
-	}
-
-	return;
-}
-
 void hashtab_hash_eval(hashtab_t h, char *tag)
 {
 	unsigned int i;
diff --git a/policycoreutils/newrole/hashtab.h b/policycoreutils/newrole/hashtab.h
index ad5559ba..092b96a9 100644
--- a/policycoreutils/newrole/hashtab.h
+++ b/policycoreutils/newrole/hashtab.h
@@ -81,20 +81,6 @@ extern int hashtab_remove(hashtab_t h, hashtab_key_t k,
 					   hashtab_datum_t d,
 					   void *args), void *args);
 
-/*
-   Insert or replace the specified (key, datum) pair in the specified
-   hash table.  If an entry for the specified key already exists,
-   then the specified destroy function is applied to (key,datum,args)
-   for the entry prior to replacing the entry's contents.
-
-   Returns HASHTAB_OVERFLOW if insufficient space is available or
-   HASHTAB_SUCCESS otherwise.
- */
-extern int hashtab_replace(hashtab_t h, hashtab_key_t k, hashtab_datum_t d,
-			   void (*destroy) (hashtab_key_t k,
-					    hashtab_datum_t d,
-					    void *args), void *args);
-
 /*
    Searches for the entry with the specified key in the hash table.
 
@@ -124,20 +110,6 @@ extern int hashtab_map(hashtab_t h,
 				     hashtab_datum_t d,
 				     void *args), void *args);
 
-/*
-   Same as hashtab_map, except that if apply returns a non-zero status,
-   then the (key,datum) pair will be removed from the hashtab and the
-   destroy function will be applied to (key,datum,args).
- */
-extern void hashtab_map_remove_on_error(hashtab_t h,
-					int (*apply) (hashtab_key_t k,
-						      hashtab_datum_t d,
-						      void *args),
-					void (*destroy) (hashtab_key_t k,
-							 hashtab_datum_t d,
-							 void *args),
-					void *args);
-
 extern void hashtab_hash_eval(hashtab_t h, char *tag);
 
 #endif
-- 
2.24.1

