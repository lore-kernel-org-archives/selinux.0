Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3C159583
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691069; cv=none; b=bK+sBfhMs+fmcPCqn5naimLzEGVjJzqSrDwteCvYk9vqq7dh+UuhZF74fn6CWrp3oU6l5egR+EoSmiUz7GXTlzQMuKFzJNPeOnOO8SO1ThIh38HQtQB5jlg68ciM983TELXCUJcF+yf5ZLchRxP8aipKCr2KrZMK2TNZSpogAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691069; c=relaxed/simple;
	bh=DygcjO+6tokGt5xkff3FmRS0BxlLIi/2fNBumvFX40s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJm3D9VuS+jRKidv6nwkjtzOhfbr3i86kR2u6IuuWFjkxcGX+eENBrm+lyopEEk7wwUBxsOxdag1FwVDpF3NLrRKS2G9sfzjaWLg5dV55tb2qKKijJfI/uCxZiDs/SwhXI3jr+aIwTI2SMyeOe3buixNDNYUO2vfp75TxqCkGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZk1d1Vy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZk1d1Vy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729691065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S74S1i4iajAAwohgFYQDlrvOHjBRPPxvHDMvqGaCuc0=;
	b=XZk1d1VyVblE8f0fdLnc/BfCx3WYvqJSr3QxIqKkiEu4+INi5ziB22gG3vdm84htjSGjMs
	wUceM7/LxL45pKs+cp48odZ1rv7k2TEXTTBxXWdR8YNF1RXgJxee58PzIVLYDRzOtuK735
	ugF12+vBUuS4PdbNDicwKZyBQY5PvAE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-naP28411M1K5AD6RpTKdjQ-1; Wed,
 23 Oct 2024 09:44:23 -0400
X-MC-Unique: naP28411M1K5AD6RpTKdjQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D70FC1936118
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 13:43:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.164])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C3F719560A2
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 13:43:36 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2 3/4] libsepol/cil/cil_post: Initialize tmp on declaration
Date: Wed, 23 Oct 2024 15:43:17 +0200
Message-ID: <20241023134318.733305-3-vmojzis@redhat.com>
In-Reply-To: <20241023134318.733305-1-vmojzis@redhat.com>
References: <CAP+JOzRURZwsyvGzs3U7M7mw4NWD3Brh-K4wnztCS81MLYRHYg@mail.gmail.com>
 <20241023134318.733305-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
 libsepol/cil/src/cil_post.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index ac99997f..d63a5496 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1315,6 +1315,8 @@ static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max,
 	curr = expr->head;
 	flavor = expr->flavor;
 
+	ebitmap_init(&tmp);
+
 	if (curr->flavor == CIL_OP) {
 		enum cil_flavor op = (enum cil_flavor)(uintptr_t)curr->data;
 
-- 
2.47.0

