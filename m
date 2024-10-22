Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5913A87E
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587845; cv=none; b=JsDBKp6HszGwW4EQtKRhtZ2qqa1xt77oLCh+xaoY/RO5xX9LS3feS9HvdHuss7OhZ3tRjJhKHPOtxQUoyVzfc4CqijVm8J3qMbAys4GlhWu52rBuq0drprpWW0X4WejNgC/n3o5RxQbLXQ5riDqclKUmXDH+c8gcR7JvTljZD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587845; c=relaxed/simple;
	bh=+cwYIZnbNVeipG7kuWSyYqiYU9n7VBdxpU9bjyFTltI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVNJn1ATdHo6xd6MCA6dnPgZJaNWiA/wL8RBpWhjUkHyj9+r7ar0OpVgRSzthrGWMcHzkvbfWn1NEVp/GYIArhy9vbNohMTC5j25QHLfdjE1kPVx3qyPhlu1kmduzBgQHSPpZ7BOhkTreBZOS6e7h9ISnRDPEwssZn2GH22IfzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ea9edeHr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ea9edeHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729587843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBovyVCks93imgd3Ar2i2bSgf7MjSQfEpKOKbXi7CLM=;
	b=ea9edeHrf5gIsV2Lq9spT5oD7zExxyk/uzLka2+wMA1xuqI1QvVlmqUouzBVNYaXaSvnwZ
	ZrSpe3suPkSFT3OrPWo70CjevSjxoEEKbGLZwAD4CiKdrErCVTskCTNti9cv3klZUzXOew
	lmMxRqdB3ThksjVBRqv6tbKwCC31Ox4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-m7nQcsWqM2auDZI3GZrjlQ-1; Tue,
 22 Oct 2024 05:04:00 -0400
X-MC-Unique: m7nQcsWqM2auDZI3GZrjlQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A88719560AF
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 09:03:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.247])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11BEE19560AE
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 09:03:57 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH 4/4] libsepol: Initialize "strs" on declaration
Date: Tue, 22 Oct 2024 11:03:14 +0200
Message-ID: <20241022090314.173002-4-vmojzis@redhat.com>
In-Reply-To: <20241022090314.173002-1-vmojzis@redhat.com>
References: <20241022090314.173002-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The value of "strs" was not always initialized before being used by
strs_destroy.

Fixes:
Error: UNINIT (CWE-457):
libsepol-3.7/src/kernel_to_cil.c:1439:2: var_decl: Declaring variable "strs" without initializer.
libsepol-3.7/src/kernel_to_cil.c:1487:2: uninit_use_in_call: Using uninitialized value "strs" when calling "strs_destroy".
 \# 1485|
 \# 1486|   exit:
 \# 1487|-> 	strs_destroy(&strs);
 \# 1488|
 \# 1489|   	if (rc != 0) {

Error: UNINIT (CWE-457):
libsepol-3.7/src/kernel_to_conf.c:1422:2: var_decl: Declaring variable "strs" without initializer.
libsepol-3.7/src/kernel_to_conf.c:1461:2: uninit_use_in_call: Using uninitialized value "strs" when calling "strs_destroy".
 \# 1459|
 \# 1460|   exit:
 \# 1461|-> 	strs_destroy(&strs);
 \# 1462|
 \# 1463|   	if (rc != 0) {

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsepol/src/kernel_to_cil.c  | 2 +-
 libsepol/src/kernel_to_conf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 7243b3c0..2d563e7d 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1436,7 +1436,7 @@ static int map_type_aliases_to_strs(char *key, void *data, void *args)
 static int write_type_alias_rules_to_cil(FILE *out, struct policydb *pdb)
 {
 	type_datum_t *alias;
-	struct strs *strs;
+	struct strs *strs = NULL;
 	char *name;
 	char *type;
 	unsigned i, num = 0;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index ca91ffae..661546af 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1419,7 +1419,7 @@ static int map_type_aliases_to_strs(char *key, void *data, void *args)
 static int write_type_alias_rules_to_conf(FILE *out, struct policydb *pdb)
 {
 	type_datum_t *alias;
-	struct strs *strs;
+	struct strs *strs = NULL;
 	char *name;
 	char *type;
 	unsigned i, num = 0;
-- 
2.47.0

