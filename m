Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C913A87E
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587839; cv=none; b=Unb0lJuoXr71AInQqjR3Mn0MfPTMKr/OuaS4MGD7BcQutxpApmtwVh6eccuyYloaDFf3+Kz20F3I5SnaWr7tlJ6qV6JjujNaYWdOC87p9eaKAJe6LwYAPZeGMyLCDub6ZPLbz2rMnXmwGcO6JYjqfO5eJBxk5fytf1B0/7o2NzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587839; c=relaxed/simple;
	bh=3JPrxQFOe72SqSRNbLDqr+RlUkSdMTC1v6KwIFepv5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=laUs8hGZCRny7yGRW6nNYwYinj8JZT9PvEgrRjqxW2CgcB+kRzz/XMYm259oULwMFr0BX936/8GCyisFQSFt3pa6swF+b5TBldeSYDW5aa+77JY/8mkx2uwxLUbh5GHCJT7hItR2yC0n3Ak0MsmfbMd2MT03/5Nq0VO47KEloYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdA4zo6Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdA4zo6Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729587836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A7+NB/d69f1eLcTUEBhoXdrqfgIgN6ikMwOW274utMs=;
	b=ZdA4zo6ZNOreb5slfRXLNMz2veTnO4/Dy1XKjbCVH4LvtYIVEHPjQzpstI11bVFt9Vp5Or
	XAWm6wjyjk9pi7jhj4UdPY8aq3fOu4LU+k9yPJBXJdeKbPN3kSIKd8eJIW5YmtpDL3iZ46
	mWe112C+4LDheIr37btbXl+1xsDJjbQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-LdteiyxoOx-CbOBfouGoNg-1; Tue,
 22 Oct 2024 05:03:51 -0400
X-MC-Unique: LdteiyxoOx-CbOBfouGoNg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36F5E1956089
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 09:03:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.247])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8279319560AE
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 09:03:49 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/4] libsepol/cil: Initialize avtab_datum on declaration
Date: Tue, 22 Oct 2024 11:03:11 +0200
Message-ID: <20241022090314.173002-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
 libsepol/cil/src/cil_binary.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 3dec1883..eb6120d9 100644
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
@@ -1346,7 +1346,7 @@ static int __cil_insert_avrule(policydb_t *pdb, uint32_t kind, uint32_t src, uin
 {
 	int rc = SEPOL_OK;
 	avtab_key_t avtab_key;
-	avtab_datum_t avtab_datum;
+	avtab_datum_t avtab_datum = { .xperms = NULL };
 	avtab_datum_t *avtab_dup = NULL;
 
 	avtab_key.source_type = src;
-- 
2.47.0

