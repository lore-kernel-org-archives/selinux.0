Return-Path: <SRS0=T7gy=O2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F795C43387
	for <selinux@archiver.kernel.org>; Mon, 17 Dec 2018 13:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF7520656
	for <selinux@archiver.kernel.org>; Mon, 17 Dec 2018 13:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="X1bKv4GR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeLQNmT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:42:19 -0500
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:63901 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeLQNmS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Dec 2018 08:42:18 -0500
X-EEMSG-check-008: 655072744|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,365,1539648000"; 
   d="scan'208";a="655072744"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2018 13:42:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1545054120; x=1576590120;
  h=subject:references:to:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=YoCgelN6cJcrArMFvAlEScF9nYIVW6CYF5B1GeQqgU8=;
  b=X1bKv4GRy+BLt0sZePZjnoHuOKo2QU+94e2f8zcV4slWysN9NG+i6/Ou
   +ySHDM7ntrW+P/JZcWGMYGdbnFnD5CmpDMXn90mE/o+MfvX2DG1Z8LtId
   UYbY1os/6exo8hFvThIMmDYXfaRwgyH8a9v7OSfe12KriY5i5EkiuCxOk
   xmeJyodzbN7dO1ORsCMxH16KtiVqV1gQUJBAjNzoHQ5HABwpAUyJqcLOf
   geG7cVH/GO/sw0/Y5iqbbVfiSi1G4udKsb+P8kfoVAWcNQMLw1CZcfTRx
   QUlsXj57vEtTs+NF+DT7t2nWMXX4mVb2Xf5OKZOkk6HqmJ9hzYZm02AUL
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,365,1539648000"; 
   d="scan'208";a="18786787"
IronPort-PHdr: =?us-ascii?q?9a23=3AyPGJvBTSH4pqmNI6FVvdihXmlNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yYxaN2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMfhEo4X4oVYFsBmwChS2BO731zFIiGH406053e?=
 =?us-ascii?q?ovHw7J0w4vEM4BvnnPsNX4Nr0fXfypwKTGzzjOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lp?=
 =?us-ascii?q?wPvkTYAiD6gkD2jK6Sdkk8++io7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9eik0b3s50z5QLFEjv0slanZtYjXJd8Gqa6iGAJVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2IHI0hfdBKIiIjpJUnCIOrkAvenn1SsjDBryujePrL7H5XNKmPOkK/7cr?=
 =?us-ascii?q?Zg705Q0Q8zzddY55JOFL4NOu78Wkj0tNbAFB82LxS0w/r7CNV6zo4eQnyAAq?=
 =?us-ascii?q?uYMKPUrF+J6fkiI/eDZIALojbxMfsl6OD0jX8/h1AdebOl3ZwNaHC3TbxaJB?=
 =?us-ascii?q?ChaGfoyvIGFn0H9l4mRfHuoEWLTDoWYnG1Ra967TY+XsbuForHR4awkJSf0y?=
 =?us-ascii?q?qhWJ5bfGZLDhaLC3i7WZ+DXqI3dC+KIsJn2gcBXLylRp5pgQqiryfm2rFnKa?=
 =?us-ascii?q?zS4SReupX9gosmr9bPnA0/oGQnR/+W1HuAGiQtxDsF?=
X-IPAS-Result: =?us-ascii?q?A2AWAAAFpxdc/wHyM5BkGwEBAQEDAQEBBwMBAQGBUgUBA?=
 =?us-ascii?q?QELAYFaKYFoJ4N8lA9SBoEICCV8iBkOjjWBejgBhEACgxMiNQgNAQMBAQEBA?=
 =?us-ascii?q?QECAWwogjYkAYJhAQMDIwQRURwDAQIDAiYCAiEsAggGAQwGAgEBgl8/gWkDC?=
 =?us-ascii?q?A2oGXwzhUCCNQ2CHIELizMXeIEHgREnDIIqNYJXhTKCVwKJQoYLRzeQBxgvC?=
 =?us-ascii?q?Y4qgyoGGJFSiTyGCItoATWBVisIAhgIIQ+DJ4IkAgEXjhwfIQMwDHkBAY1vA?=
 =?us-ascii?q?QE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2018 13:41:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBHDfuUV014013;
        Mon, 17 Dec 2018 08:41:56 -0500
Subject: Fwd: [PATCH 3/7] selinux: convert to kvmalloc
References: <20181217131929.11727-4-kent.overstreet@gmail.com>
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
From:   Stephen Smalley <sds@tycho.nsa.gov>
X-Forwarded-Message-Id: <20181217131929.11727-4-kent.overstreet@gmail.com>
Message-ID: <f49ffd76-1bfe-5755-8e48-0f944642195c@tycho.nsa.gov>
Date:   Mon, 17 Dec 2018 08:44:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181217131929.11727-4-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

-------- Forwarded Message --------
Subject: [PATCH 3/7] selinux: convert to kvmalloc
Date: Mon, 17 Dec 2018 08:19:25 -0500
From: Kent Overstreet <kent.overstreet@gmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
CC: Kent Overstreet <kent.overstreet@gmail.com>, 
linux-security-module@vger.kernel.org

The flex arrays were being used for constant sized arrays, so there's no
benefit to using flex_arrays over something simpler.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-security-module@vger.kernel.org
---
  security/selinux/ss/avtab.c       |  40 +++++-----
  security/selinux/ss/avtab.h       |   4 +-
  security/selinux/ss/conditional.c |   6 +-
  security/selinux/ss/policydb.c    | 122 ++++++++----------------------
  security/selinux/ss/policydb.h    |  12 +--
  security/selinux/ss/services.c    |  22 ++----
  6 files changed, 62 insertions(+), 144 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index c0417cf17f..8c5800750f 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -93,12 +93,10 @@ avtab_insert_node(struct avtab *h, int hvalue,
  		newnode->next = prev->next;
  		prev->next = newnode;
  	} else {
-		newnode->next = flex_array_get_ptr(h->htable, hvalue);
-		if (flex_array_put_ptr(h->htable, hvalue, newnode,
-				       GFP_KERNEL|__GFP_ZERO)) {
-			kmem_cache_free(avtab_node_cachep, newnode);
-			return NULL;
-		}
+		struct avtab_node **n = &h->htable[hvalue];
+
+		newnode->next = *n;
+		*n = newnode;
  	}
   	h->nel++;
@@ -111,11 +109,11 @@ static int avtab_insert(struct avtab *h, struct 
avtab_key *key, struct avtab_dat
  	struct avtab_node *prev, *cur, *newnode;
  	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
  -	if (!h || !h->htable)
+	if (!h)
  		return -EINVAL;
   	hvalue = avtab_hash(key, h->mask);
-	for (prev = NULL, cur = flex_array_get_ptr(h->htable, hvalue);
+	for (prev = NULL, cur = h->htable[hvalue];
  	     cur;
  	     prev = cur, cur = cur->next) {
  		if (key->source_type == cur->key.source_type &&
@@ -156,10 +154,10 @@ avtab_insert_nonunique(struct avtab *h, struct 
avtab_key *key, struct avtab_datu
  	struct avtab_node *prev, *cur;
  	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
  -	if (!h || !h->htable)
+	if (!h)
  		return NULL;
  	hvalue = avtab_hash(key, h->mask);
-	for (prev = NULL, cur = flex_array_get_ptr(h->htable, hvalue);
+	for (prev = NULL, cur = h->htable[hvalue];
  	     cur;
  	     prev = cur, cur = cur->next) {
  		if (key->source_type == cur->key.source_type &&
@@ -186,11 +184,11 @@ struct avtab_datum *avtab_search(struct avtab *h, 
struct avtab_key *key)
  	struct avtab_node *cur;
  	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
  -	if (!h || !h->htable)
+	if (!h)
  		return NULL;
   	hvalue = avtab_hash(key, h->mask);
-	for (cur = flex_array_get_ptr(h->htable, hvalue); cur;
+	for (cur = h->htable[hvalue]; cur;
  	     cur = cur->next) {
  		if (key->source_type == cur->key.source_type &&
  		    key->target_type == cur->key.target_type &&
@@ -222,11 +220,11 @@ avtab_search_node(struct avtab *h, struct 
avtab_key *key)
  	struct avtab_node *cur;
  	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
  -	if (!h || !h->htable)
+	if (!h)
  		return NULL;
   	hvalue = avtab_hash(key, h->mask);
-	for (cur = flex_array_get_ptr(h->htable, hvalue); cur;
+	for (cur = h->htable[hvalue]; cur;
  	     cur = cur->next) {
  		if (key->source_type == cur->key.source_type &&
  		    key->target_type == cur->key.target_type &&
@@ -281,11 +279,11 @@ void avtab_destroy(struct avtab *h)
  	int i;
  	struct avtab_node *cur, *temp;
  -	if (!h || !h->htable)
+	if (!h)
  		return;
   	for (i = 0; i < h->nslot; i++) {
-		cur = flex_array_get_ptr(h->htable, i);
+		cur = h->htable[i];
  		while (cur) {
  			temp = cur;
  			cur = cur->next;
@@ -295,7 +293,7 @@ void avtab_destroy(struct avtab *h)
  			kmem_cache_free(avtab_node_cachep, temp);
  		}
  	}
-	flex_array_free(h->htable);
+	kvfree(h->htable);
  	h->htable = NULL;
  	h->nslot = 0;
  	h->mask = 0;
@@ -303,6 +301,7 @@ void avtab_destroy(struct avtab *h)
   int avtab_init(struct avtab *h)
  {
+	kvfree(h->htable);
  	h->htable = NULL;
  	h->nel = 0;
  	return 0;
@@ -329,8 +328,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
  		nslot = MAX_AVTAB_HASH_BUCKETS;
  	mask = nslot - 1;
  -	h->htable = flex_array_alloc(sizeof(struct avtab_node *), nslot,
-				     GFP_KERNEL | __GFP_ZERO);
+	h->htable = kvcalloc(nslot, sizeof(void *), GFP_KERNEL);
  	if (!h->htable)
  		return -ENOMEM;
  @@ -353,7 +351,7 @@ void avtab_hash_eval(struct avtab *h, char *tag)
  	max_chain_len = 0;
  	chain2_len_sum = 0;
  	for (i = 0; i < h->nslot; i++) {
-		cur = flex_array_get_ptr(h->htable, i);
+		cur = h->htable[i];
  		if (cur) {
  			slots_used++;
  			chain_len = 0;
@@ -646,7 +644,7 @@ int avtab_write(struct policydb *p, struct avtab *a, 
void *fp)
  		return rc;
   	for (i = 0; i < a->nslot; i++) {
-		for (cur = flex_array_get_ptr(a->htable, i); cur;
+		for (cur = a->htable[i]; cur;
  		     cur = cur->next) {
  			rc = avtab_write_item(p, cur, fp);
  			if (rc)
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 0d652fad53..de16673b23 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -24,7 +24,6 @@
  #define _SS_AVTAB_H_
   #include "security.h"
-#include <linux/flex_array.h>
   struct avtab_key {
  	u16 source_type;	/* source type */
@@ -84,11 +83,10 @@ struct avtab_node {
  };
   struct avtab {
-	struct flex_array *htable;
+	struct avtab_node **htable;
  	u32 nel;	/* number of elements */
  	u32 nslot;      /* number of hash slots */
  	u32 mask;       /* mask to compute hash func */
-
  };
   int avtab_init(struct avtab *);
diff --git a/security/selinux/ss/conditional.c 
b/security/selinux/ss/conditional.c
index f49e522e93..3bbb603452 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -195,7 +195,6 @@ int cond_index_bool(void *key, void *datum, void *datap)
  {
  	struct policydb *p;
  	struct cond_bool_datum *booldatum;
-	struct flex_array *fa;
   	booldatum = datum;
  	p = datap;
@@ -203,10 +202,7 @@ int cond_index_bool(void *key, void *datum, void 
*datap)
  	if (!booldatum->value || booldatum->value > p->p_bools.nprim)
  		return -EINVAL;
  -	fa = p->sym_val_to_name[SYM_BOOLS];
-	if (flex_array_put_ptr(fa, booldatum->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
-		BUG();
+	p->sym_val_to_name[SYM_BOOLS][booldatum->value - 1] = key;
  	p->bool_val_to_struct[booldatum->value - 1] = booldatum;
   	return 0;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f4eadd3f73..16b7027bb7 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -36,7 +36,6 @@
  #include <linux/string.h>
  #include <linux/errno.h>
  #include <linux/audit.h>
-#include <linux/flex_array.h>
  #include "security.h"
   #include "policydb.h"
@@ -341,17 +340,14 @@ static int common_index(void *key, void *datum, 
void *datap)
  {
  	struct policydb *p;
  	struct common_datum *comdatum;
-	struct flex_array *fa;
   	comdatum = datum;
  	p = datap;
  	if (!comdatum->value || comdatum->value > p->p_commons.nprim)
  		return -EINVAL;
  -	fa = p->sym_val_to_name[SYM_COMMONS];
-	if (flex_array_put_ptr(fa, comdatum->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
-		BUG();
+	p->sym_val_to_name[SYM_COMMONS][comdatum->value - 1] = key;
+
  	return 0;
  }
  @@ -359,16 +355,13 @@ static int class_index(void *key, void *datum, 
void *datap)
  {
  	struct policydb *p;
  	struct class_datum *cladatum;
-	struct flex_array *fa;
   	cladatum = datum;
  	p = datap;
  	if (!cladatum->value || cladatum->value > p->p_classes.nprim)
  		return -EINVAL;
-	fa = p->sym_val_to_name[SYM_CLASSES];
-	if (flex_array_put_ptr(fa, cladatum->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
-		BUG();
+
+	p->sym_val_to_name[SYM_CLASSES][cladatum->value - 1] = key;
  	p->class_val_to_struct[cladatum->value - 1] = cladatum;
  	return 0;
  }
@@ -377,7 +370,6 @@ static int role_index(void *key, void *datum, void 
*datap)
  {
  	struct policydb *p;
  	struct role_datum *role;
-	struct flex_array *fa;
   	role = datum;
  	p = datap;
@@ -386,10 +378,7 @@ static int role_index(void *key, void *datum, void 
*datap)
  	    || role->bounds > p->p_roles.nprim)
  		return -EINVAL;
  -	fa = p->sym_val_to_name[SYM_ROLES];
-	if (flex_array_put_ptr(fa, role->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
-		BUG();
+	p->sym_val_to_name[SYM_ROLES][role->value - 1] = key;
  	p->role_val_to_struct[role->value - 1] = role;
  	return 0;
  }
@@ -398,7 +387,6 @@ static int type_index(void *key, void *datum, void 
*datap)
  {
  	struct policydb *p;
  	struct type_datum *typdatum;
-	struct flex_array *fa;
   	typdatum = datum;
  	p = datap;
@@ -408,15 +396,8 @@ static int type_index(void *key, void *datum, void 
*datap)
  		    || typdatum->value > p->p_types.nprim
  		    || typdatum->bounds > p->p_types.nprim)
  			return -EINVAL;
-		fa = p->sym_val_to_name[SYM_TYPES];
-		if (flex_array_put_ptr(fa, typdatum->value - 1, key,
-				       GFP_KERNEL | __GFP_ZERO))
-			BUG();
-
-		fa = p->type_val_to_struct_array;
-		if (flex_array_put_ptr(fa, typdatum->value - 1, typdatum,
-				       GFP_KERNEL | __GFP_ZERO))
-			BUG();
+		p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] = key;
+		p->type_val_to_struct_array[typdatum->value - 1] = typdatum;
  	}
   	return 0;
@@ -426,7 +407,6 @@ static int user_index(void *key, void *datum, void 
*datap)
  {
  	struct policydb *p;
  	struct user_datum *usrdatum;
-	struct flex_array *fa;
   	usrdatum = datum;
  	p = datap;
@@ -435,10 +415,7 @@ static int user_index(void *key, void *datum, void 
*datap)
  	    || usrdatum->bounds > p->p_users.nprim)
  		return -EINVAL;
  -	fa = p->sym_val_to_name[SYM_USERS];
-	if (flex_array_put_ptr(fa, usrdatum->value - 1, key,
-			       GFP_KERNEL | __GFP_ZERO))
-		BUG();
+	p->sym_val_to_name[SYM_USERS][usrdatum->value - 1] = key;
  	p->user_val_to_struct[usrdatum->value - 1] = usrdatum;
  	return 0;
  }
@@ -447,7 +424,6 @@ static int sens_index(void *key, void *datum, void 
*datap)
  {
  	struct policydb *p;
  	struct level_datum *levdatum;
-	struct flex_array *fa;
   	levdatum = datum;
  	p = datap;
@@ -456,10 +432,8 @@ static int sens_index(void *key, void *datum, void 
*datap)
  		if (!levdatum->level->sens ||
  		    levdatum->level->sens > p->p_levels.nprim)
  			return -EINVAL;
-		fa = p->sym_val_to_name[SYM_LEVELS];
-		if (flex_array_put_ptr(fa, levdatum->level->sens - 1, key,
-				       GFP_KERNEL | __GFP_ZERO))
-			BUG();
+
+		p->sym_val_to_name[SYM_LEVELS][levdatum->level->sens - 1] = key;
  	}
   	return 0;
@@ -469,7 +443,6 @@ static int cat_index(void *key, void *datum, void 
*datap)
  {
  	struct policydb *p;
  	struct cat_datum *catdatum;
-	struct flex_array *fa;
   	catdatum = datum;
  	p = datap;
@@ -477,10 +450,8 @@ static int cat_index(void *key, void *datum, void 
*datap)
  	if (!catdatum->isalias) {
  		if (!catdatum->value || catdatum->value > p->p_cats.nprim)
  			return -EINVAL;
-		fa = p->sym_val_to_name[SYM_CATS];
-		if (flex_array_put_ptr(fa, catdatum->value - 1, key,
-				       GFP_KERNEL | __GFP_ZERO))
-			BUG();
+
+		p->sym_val_to_name[SYM_CATS][catdatum->value - 1] = key;
  	}
   	return 0;
@@ -568,35 +539,23 @@ static int policydb_index(struct policydb *p)
  	if (!p->user_val_to_struct)
  		return -ENOMEM;
  -	/* Yes, I want the sizeof the pointer, not the structure */
-	p->type_val_to_struct_array = flex_array_alloc(sizeof(struct 
type_datum *),
-						       p->p_types.nprim,
-						       GFP_KERNEL | __GFP_ZERO);
+	p->type_val_to_struct_array = kvcalloc(p->p_types.nprim,
+					       sizeof(*p->type_val_to_struct_array),
+					       GFP_KERNEL);
  	if (!p->type_val_to_struct_array)
  		return -ENOMEM;
  -	rc = flex_array_prealloc(p->type_val_to_struct_array, 0,
-				 p->p_types.nprim, GFP_KERNEL | __GFP_ZERO);
-	if (rc)
-		goto out;
-
  	rc = cond_init_bool_indexes(p);
  	if (rc)
  		goto out;
   	for (i = 0; i < SYM_NUM; i++) {
-		p->sym_val_to_name[i] = flex_array_alloc(sizeof(char *),
-							 p->symtab[i].nprim,
-							 GFP_KERNEL | __GFP_ZERO);
+		p->sym_val_to_name[i] = kvcalloc(p->symtab[i].nprim,
+						 sizeof(char *),
+						 GFP_KERNEL);
  		if (!p->sym_val_to_name[i])
  			return -ENOMEM;
  -		rc = flex_array_prealloc(p->sym_val_to_name[i],
-					 0, p->symtab[i].nprim,
-					 GFP_KERNEL | __GFP_ZERO);
-		if (rc)
-			goto out;
-
  		rc = hashtab_map(p->symtab[i].table, index_f[i], p);
  		if (rc)
  			goto out;
@@ -809,16 +768,13 @@ void policydb_destroy(struct policydb *p)
  		hashtab_destroy(p->symtab[i].table);
  	}
  -	for (i = 0; i < SYM_NUM; i++) {
-		if (p->sym_val_to_name[i])
-			flex_array_free(p->sym_val_to_name[i]);
-	}
+	for (i = 0; i < SYM_NUM; i++)
+		kvfree(p->sym_val_to_name[i]);
   	kfree(p->class_val_to_struct);
  	kfree(p->role_val_to_struct);
  	kfree(p->user_val_to_struct);
-	if (p->type_val_to_struct_array)
-		flex_array_free(p->type_val_to_struct_array);
+	kvfree(p->type_val_to_struct_array);
   	avtab_destroy(&p->te_avtab);
  @@ -871,17 +827,9 @@ void policydb_destroy(struct policydb *p)
  	hashtab_map(p->range_tr, range_tr_destroy, NULL);
  	hashtab_destroy(p->range_tr);
  -	if (p->type_attr_map_array) {
-		for (i = 0; i < p->p_types.nprim; i++) {
-			struct ebitmap *e;
-
-			e = flex_array_get(p->type_attr_map_array, i);
-			if (!e)
-				continue;
-			ebitmap_destroy(e);
-		}
-		flex_array_free(p->type_attr_map_array);
-	}
+	for (i = 0; i < p->p_types.nprim; i++)
+		ebitmap_destroy(&p->type_attr_map_array[i]);
+	kvfree(p->type_attr_map_array);
   	ebitmap_destroy(&p->filename_trans_ttypes);
  	ebitmap_destroy(&p->policycaps);
@@ -1761,8 +1709,7 @@ static int type_bounds_sanity_check(void *key, 
void *datum, void *datap)
  			return -EINVAL;
  		}
  -		upper = flex_array_get_ptr(p->type_val_to_struct_array,
-					   upper->bounds - 1);
+		upper = p->type_val_to_struct_array[upper->bounds - 1];
  		BUG_ON(!upper);
   		if (upper->attribute) {
@@ -2519,23 +2466,15 @@ int policydb_read(struct policydb *p, void *fp)
  	if (rc)
  		goto bad;
  -	rc = -ENOMEM;
-	p->type_attr_map_array = flex_array_alloc(sizeof(struct ebitmap),
-						  p->p_types.nprim,
-						  GFP_KERNEL | __GFP_ZERO);
+	p->type_attr_map_array = kvcalloc(p->p_types.nprim,
+					  sizeof(*p->type_attr_map_array),
+					  GFP_KERNEL);
  	if (!p->type_attr_map_array)
  		goto bad;
  -	/* preallocate so we don't have to worry about the put ever failing */
-	rc = flex_array_prealloc(p->type_attr_map_array, 0, p->p_types.nprim,
-				 GFP_KERNEL | __GFP_ZERO);
-	if (rc)
-		goto bad;
-
  	for (i = 0; i < p->p_types.nprim; i++) {
-		struct ebitmap *e = flex_array_get(p->type_attr_map_array, i);
+		struct ebitmap *e = &p->type_attr_map_array[i];
  -		BUG_ON(!e);
  		ebitmap_init(e);
  		if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
  			rc = ebitmap_read(e, fp);
@@ -3524,9 +3463,8 @@ int policydb_write(struct policydb *p, void *fp)
  		return rc;
   	for (i = 0; i < p->p_types.nprim; i++) {
-		struct ebitmap *e = flex_array_get(p->type_attr_map_array, i);
+		struct ebitmap *e = &p->type_attr_map_array[i];
  -		BUG_ON(!e);
  		rc = ebitmap_write(e, fp);
  		if (rc)
  			return rc;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 215f8f30ac..27039149ff 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -24,8 +24,6 @@
  #ifndef _SS_POLICYDB_H_
  #define _SS_POLICYDB_H_
  -#include <linux/flex_array.h>
-
  #include "symtab.h"
  #include "avtab.h"
  #include "sidtab.h"
@@ -251,13 +249,13 @@ struct policydb {
  #define p_cats symtab[SYM_CATS]
   	/* symbol names indexed by (value - 1) */
-	struct flex_array *sym_val_to_name[SYM_NUM];
+	char		**sym_val_to_name[SYM_NUM];
   	/* class, role, and user attributes indexed by (value - 1) */
  	struct class_datum **class_val_to_struct;
  	struct role_datum **role_val_to_struct;
  	struct user_datum **user_val_to_struct;
-	struct flex_array *type_val_to_struct_array;
+	struct type_datum **type_val_to_struct_array;
   	/* type enforcement access vectors and transitions */
  	struct avtab te_avtab;
@@ -294,7 +292,7 @@ struct policydb {
  	struct hashtab *range_tr;
   	/* type -> attribute reverse mapping */
-	struct flex_array *type_attr_map_array;
+	struct ebitmap *type_attr_map_array;
   	struct ebitmap policycaps;
  @@ -369,9 +367,7 @@ static inline int put_entry(const void *buf, 
size_t bytes, int num, struct polic
   static inline char *sym_name(struct policydb *p, unsigned int 
sym_num, unsigned int element_nr)
  {
-	struct flex_array *fa = p->sym_val_to_name[sym_num];
-
-	return flex_array_get_ptr(fa, element_nr);
+	return p->sym_val_to_name[sym_num][element_nr];
  }
   extern u16 string_to_security_class(struct policydb *p, const char 
*name);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 12e4143945..24b59a7e6a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -50,7 +50,6 @@
  #include <linux/audit.h>
  #include <linux/mutex.h>
  #include <linux/selinux.h>
-#include <linux/flex_array.h>
  #include <linux/vmalloc.h>
  #include <net/netlabel.h>
  @@ -546,15 +545,13 @@ static void type_attribute_bounds_av(struct 
policydb *policydb,
  	struct type_datum *target;
  	u32 masked = 0;
  -	source = flex_array_get_ptr(policydb->type_val_to_struct_array,
-				    scontext->type - 1);
+	source = policydb->type_val_to_struct_array[scontext->type - 1];
  	BUG_ON(!source);
   	if (!source->bounds)
  		return;
  -	target = flex_array_get_ptr(policydb->type_val_to_struct_array,
-				    tcontext->type - 1);
+	target = policydb->type_val_to_struct_array[tcontext->type - 1];
  	BUG_ON(!target);
   	memset(&lo_avd, 0, sizeof(lo_avd));
@@ -654,11 +651,9 @@ static void context_struct_compute_av(struct 
policydb *policydb,
  	 */
  	avkey.target_class = tclass;
  	avkey.specified = AVTAB_AV | AVTAB_XPERMS;
-	sattr = flex_array_get(policydb->type_attr_map_array,
-			       scontext->type - 1);
+	sattr = &policydb->type_attr_map_array[scontext->type - 1];
  	BUG_ON(!sattr);
-	tattr = flex_array_get(policydb->type_attr_map_array,
-			       tcontext->type - 1);
+	tattr = &policydb->type_attr_map_array[tcontext->type - 1];
  	BUG_ON(!tattr);
  	ebitmap_for_each_positive_bit(sattr, snode, i) {
  		ebitmap_for_each_positive_bit(tattr, tnode, j) {
@@ -901,8 +896,7 @@ int security_bounded_transition(struct selinux_state 
*state,
   	index = new_context->type;
  	while (true) {
-		type = flex_array_get_ptr(policydb->type_val_to_struct_array,
-					  index - 1);
+		type = policydb->type_val_to_struct_array[index - 1];
  		BUG_ON(!type);
   		/* not bounded anymore */
@@ -1065,11 +1059,9 @@ void security_compute_xperms_decision(struct 
selinux_state *state,
   	avkey.target_class = tclass;
  	avkey.specified = AVTAB_XPERMS;
-	sattr = flex_array_get(policydb->type_attr_map_array,
-				scontext->type - 1);
+	sattr = &policydb->type_attr_map_array[scontext->type - 1];
  	BUG_ON(!sattr);
-	tattr = flex_array_get(policydb->type_attr_map_array,
-				tcontext->type - 1);
+	tattr = &policydb->type_attr_map_array[tcontext->type - 1];
  	BUG_ON(!tattr);
  	ebitmap_for_each_positive_bit(sattr, snode, i) {
  		ebitmap_for_each_positive_bit(tattr, tnode, j) {
-- 
2.20.1

