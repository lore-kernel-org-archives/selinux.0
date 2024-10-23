Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1C6E56A
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691168; cv=none; b=nWgw6DFe3OLwXaKYIl+nkFtcLcicUZTvHdbd6JYUvVEfkkTKMbUM7jeQCLrU+G6xwC9wvrVYNiKsTHwX7w90Y7IxoSA9qaA2RqU+OHloDUYnJyhn1HiqpJ5aOsbH0Q4jicZbf2JEpyuf73x4fGrH1EDzz2JJbojuymHDyd6h3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691168; c=relaxed/simple;
	bh=EsxdwvQjuD7RovcvUH7WeD0PJV6yxN+jYWYrz9Z3xRI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXiCogf/gkWTKGQ5yeRRh+qLGkNJVGMrLIAfAuk1GCMQKNIDtdoHHjYV/0cjad6R8UbgSHMNfOppmbiT28gNTG8hL2oyTkXz/de0Ket8jSMskqNESOL2ZFD3PLNjeRgF+/otP3ndImimtxfzgV+bJTEkYhKZH4W78rlvwoyW8wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fuuSgNNs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuuSgNNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729691165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgYRaCbTdjXaFcfkOT0nR3rrB6xCp69iXBnS2UZvUh0=;
	b=fuuSgNNsYVmbPtJcoBhtj/0GAX1QJztmdAp2ICDRIkg9HvyhUTLTDxR2GvqQL83YUNpLSD
	ZtP0O7Hihd/bvoAhp2gtx8uhqOpA8LJbAElpAkcGpfyEL3CSKUsjEDxgYttBcozZaZuEme
	fO810NUkHXjyoRhtYxUMrBmAGsDwq4I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-H155zI4BM3GUi7j7sDM-GA-1; Wed,
 23 Oct 2024 09:46:04 -0400
X-MC-Unique: H155zI4BM3GUi7j7sDM-GA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B83F1190556E
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 13:43:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.164])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 066AA19560A2
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 13:43:30 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2 1/4] libsepol/cil: Initialize avtab_datum on declaration
Date: Wed, 23 Oct 2024 15:43:15 +0200
Message-ID: <20241023134318.733305-1-vmojzis@redhat.com>
In-Reply-To: <CAP+JOzRURZwsyvGzs3U7M7mw4NWD3Brh-K4wnztCS81MLYRHYg@mail.gmail.com>
References: <CAP+JOzRURZwsyvGzs3U7M7mw4NWD3Brh-K4wnztCS81MLYRHYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

avtab_datum.xperms was not always initialized before being used.

Fixes:
Error: UNINIT (CWE-457):
libsepol-3.7/cil/src/cil_binary.c:977:2: var_decl: Declaring variable "avtab_datum" without initializer.
libsepol-3.7/cil/src/cil_binary.c:1059:3: uninit_use_in_call: Using uninitialized value "avtab_datum". Field "avtab_datum.xperms" is uninitialized when calling "__cil_cond_insert_rule".
 \# 1057|   			}
 \# 1058|   		}
 \# 1059|-> 		rc = __cil_cond_insert_rule(&pdb->te_cond_avtab, &avtab_key, &avtab_datum, cond_node, cond_flavor);
 \# 1060|   	}

Error: UNINIT (CWE-457):
libsepol-3.7/cil/src/cil_binary.c:1348:2: var_decl: Declaring variable "avtab_datum" without initializer.
libsepol-3.7/cil/src/cil_binary.c:1384:3: uninit_use_in_call: Using uninitialized value "avtab_datum". Field "avtab_datum.xperms" is uninitialized when calling "__cil_cond_insert_rule".
 \# 1382|   	} else {
 \# 1383|   		avtab_datum.data = data;
 \# 1384|-> 		rc = __cil_cond_insert_rule(&pdb->te_cond_avtab, &avtab_key, &avtab_datum, cond_node, cond_flavor);
 \# 1385|   	}
 \# 1386|

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsepol/cil/src/cil_binary.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 3dec1883..3d920182 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -975,7 +975,7 @@ static int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src,
 {
 	int rc = SEPOL_OK;
 	avtab_key_t avtab_key;
-	avtab_datum_t avtab_datum;
+	avtab_datum_t avtab_datum = { .data = res, .xperms = NULL };
 	avtab_ptr_t existing;	
 
 	avtab_key.source_type = src;
@@ -997,8 +997,6 @@ static int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src,
 		goto exit;
 	}
 
-	avtab_datum.data = res;
-	
 	existing = avtab_search_node(&pdb->te_avtab, &avtab_key);
 	if (existing) {
 		/* Don't add duplicate type rule and warn if they conflict.
@@ -1346,7 +1344,7 @@ static int __cil_insert_avrule(policydb_t *pdb, uint32_t kind, uint32_t src, uin
 {
 	int rc = SEPOL_OK;
 	avtab_key_t avtab_key;
-	avtab_datum_t avtab_datum;
+	avtab_datum_t avtab_datum = { .data = data, .xperms = NULL };
 	avtab_datum_t *avtab_dup = NULL;
 
 	avtab_key.source_type = src;
@@ -1372,7 +1370,6 @@ static int __cil_insert_avrule(policydb_t *pdb, uint32_t kind, uint32_t src, uin
 	if (!cond_node) {
 		avtab_dup = avtab_search(&pdb->te_avtab, &avtab_key);
 		if (!avtab_dup) {
-			avtab_datum.data = data;
 			rc = avtab_insert(&pdb->te_avtab, &avtab_key, &avtab_datum);
 		} else {
 			if (kind == CIL_AVRULE_DONTAUDIT)
@@ -1381,7 +1378,6 @@ static int __cil_insert_avrule(policydb_t *pdb, uint32_t kind, uint32_t src, uin
 				avtab_dup->data |= data;
 		}
 	} else {
-		avtab_datum.data = data;
 		rc = __cil_cond_insert_rule(&pdb->te_cond_avtab, &avtab_key, &avtab_datum, cond_node, cond_flavor);
 	}
 
-- 
2.47.0

