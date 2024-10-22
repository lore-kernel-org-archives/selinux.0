Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FC189BA6
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587842; cv=none; b=er7m2jRTzfJAY3n/n08kuWf/wiDc3z0nV96pWWFamUI3uiFX80PWK2g0W4OldPI6r2j1/5WLyN64rlMrUGNIcoMc0T+UBlqev9f7LjoV/+g2kslda3QPLRb19sRLzhKXbU8GG1rpHZZGtH9Ica+joZV1R39qrkoBeJktavqrn0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587842; c=relaxed/simple;
	bh=CWnCEgYBqIr4Q3gfgKRKbaOUb4sYZHELLC1qfVdP5AY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EY0/REvAL4oOaJ1hjaVsRcSvGc8XKz+3B51o+EGt7D6DhqmkLxrmjSIPWlwf6tQXz7AukgjYKTPwx9l6wDqsVnUKkKxf+k9BW55T8pf/Ahf8aXHRiD1gAQ3LiJIBP6Ciq9wOAPZ9ZSBD7mM06sjB+3xXNBnhJW0xoLLtV5/rBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LomQ66Jb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LomQ66Jb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729587839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9GVc1+ZbRCqB7iKBfvrUwC4tg2iDmlRG5qkjYU59Bg=;
	b=LomQ66JbBBrdRxNRYseUI9SHytHcelGMDU7y5pW8MbqG3SM6dksYlZEt0aUBGbnd6nx9b9
	lHEo4usYREmE1oza81GrgXbIhy32H9vUbBzQ6GQ0/bIDLgRhSEZ1PBNtDlKXeYyXOm8JDt
	5u6IVl5FRjtrKjF/HCXW94pKWjDejuw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-HxlcSXcvOfmWf79OyrPJhg-1; Tue,
 22 Oct 2024 05:03:57 -0400
X-MC-Unique: HxlcSXcvOfmWf79OyrPJhg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2CF719560A7
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 09:03:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.247])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 216B019560AE
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 09:03:55 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH 3/4] libsepol/cil/cil_post: Initialize tmp on declaration
Date: Tue, 22 Oct 2024 11:03:13 +0200
Message-ID: <20241022090314.173002-3-vmojzis@redhat.com>
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

tmp.node was not always initialized before being used by
ebitmap_destroy.

Fixes:
Error: UNINIT (CWE-457):
libsepol-3.7/cil/src/cil_post.c:1309:2: var_decl: Declaring variable "tmp" without initializer.
libsepol-3.7/cil/src/cil_post.c:1382:6: uninit_use_in_call: Using uninitialized value "tmp.node" when calling "ebitmap_destroy".
 \# 1380|   				if (rc != SEPOL_OK) {
 \# 1381|   					cil_log(CIL_INFO, "Failed to apply operator to bitmaps\n");
 \# 1382|-> 					ebitmap_destroy(&tmp);
 \# 1383|   					goto exit;
 \# 1384|   				}

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsepol/cil/src/cil_post.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index ac99997f..c8dbfd3e 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1306,7 +1306,7 @@ static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max,
 	int rc = SEPOL_ERR;
 	struct cil_list_item *curr;
 	enum cil_flavor flavor;
-	ebitmap_t tmp, b1, b2;
+	ebitmap_t tmp = {.node = NULL}, b1, b2;
 
 	if (expr == NULL || expr->head == NULL) {
 		return SEPOL_OK;
-- 
2.47.0

