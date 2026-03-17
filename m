Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA1C38F234
	for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773781873; cv=none; b=SFnCK77WdB6UcTXI/5CIMmcDtEK/MO5/TOQVpkjstzJuf+94g1DsUioEPo36VevDORTCfGMsBvuxIQO/YFojuebpP5Ziec8V3DeudBhStSjSm+Z/dJCAZPVSOPtr21Rgsg/Kc7xInfNhUhOtaKCPlnsTrgi6nCeYuAAI9ItfApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773781873; c=relaxed/simple;
	bh=OSex54RvkL5OJbcBmdp0r7QHMdFsbcpMaw9LEJQ6b8s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lwEDB/hhxH7SkkkNtmm86n1OY646ega7RiGiiLPA9cXvQrS7N3KF97pZV8TVrAG0tl+gOJoz8pQB6zIZUqUntxW3Gez3kklLHk9OcQJOYMGvW9u+fB+19qDENoMHFhPPapL6a8SWmz+3CUoLXL6ScZkyhgOrfswEdGJGiyyXtnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAAI9zX9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAAI9zX9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773781871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ZVFxHGQJi6e6SHlJ50Bk1yi1rhrEeJErWwxqGa7hB8=;
	b=DAAI9zX9klJIohQrrJzWkR9Oltm7m3E6n8NHV9rS0Mkt8B4pjUGwF85UmVPvHRxpubTZGL
	1CTR0gEk/T/RNpgJc/yvpHBHb6E+xd3bM16VnFiQJWKXsRaPArQLRHB8F0Uhe6F5T148qr
	jVaewe7kAThkDJrYY2VCWjLgRjyDTJM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-cfv0mPieOnWnPm73o4IzeQ-1; Tue,
 17 Mar 2026 17:11:09 -0400
X-MC-Unique: cfv0mPieOnWnPm73o4IzeQ-1
X-Mimecast-MFC-AGG-ID: cfv0mPieOnWnPm73o4IzeQ_1773781869
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 017C819560AA
	for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 21:11:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1282B180075C
	for <selinux@vger.kernel.org>; Tue, 17 Mar 2026 21:11:07 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libsepol: Fix memory leak in role_dominates_copy_callback
Date: Tue, 17 Mar 2026 22:11:00 +0100
Message-ID: <20260317211105.2485247-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Free memory allocated by map_ebitmap in case ebitmap_union fails.

Fixes:
  Defect type: RESOURCE_LEAK
  libsepol-3.10/src/expand.c:828:2: alloc_arg: "map_ebitmap" allocates memory that is stored into "mapped.node".
  libsepol-3.10/src/expand.c:68:3: alloc_arg: "ebitmap_set_bit" allocates memory that is stored into "dst->node".
  libsepol-3.10/src/ebitmap.c:420:2: alloc_fn: Storage is returned from allocation function "malloc".
  libsepol-3.10/src/ebitmap.c:420:2: assign: Assigning: "new" = "(ebitmap_node_t *)malloc(24UL)".
  libsepol-3.10/src/ebitmap.c:437:3: assign: Assigning: "e->node" = "new".
  libsepol-3.10/src/expand.c:831:3: leaked_storage: Variable "mapped" going out of scope leaks the storage "mapped.node" points to.
  \#   829|   		return -1;
  \#   830|   	if (ebitmap_union(&new_role->dominates, &mapped))
  \#   831|-> 		return -1;
  \#   832|   	ebitmap_destroy(&mapped);
  \#   833|
---
 libsepol/src/expand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index ed912b57..72804f60 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -827,8 +827,10 @@ static int role_dominates_copy_callback(hashtab_key_t key __attribute__ ((unused
 
 	if (map_ebitmap(&role->dominates, &mapped, state->rolemap))
 		return -1;
-	if (ebitmap_union(&new_role->dominates, &mapped))
+	if (ebitmap_union(&new_role->dominates, &mapped)) {
+		ebitmap_destroy(&mapped);
 		return -1;
+	}
 	ebitmap_destroy(&mapped);
 
 	return 0;
-- 
2.52.0

