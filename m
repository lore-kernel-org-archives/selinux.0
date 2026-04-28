Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011DA2E8DE3
	for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777412093; cv=none; b=kBT1KXPP/LtCPn0SnU0Zj7ucqN3kB9ihxdjGxyVeu7lenN3JGEBAyYSR/zme3R3pClGv3cyBjq/1/nPA9EQmCtCoGKBowUotO0L3Zklx0wSyb3uePkfnclNuO3ptzyRTm0Ht2EumO729YxlIPEgx+HKUb12CL2Y8AGUzs4wuf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777412093; c=relaxed/simple;
	bh=PyQ4ZwfMRlzz1aXE5GEWXD9h9JFebcT+UtL7Onph0Mg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDW1qcjF3dJ01Qk6inptXJfo9z+EUNC8LeTQvFqn6ZtqNuw7NlZuR2MNFoXLHniovQ9i+KJ/Dm+HYngxrvN0RiuM5g4q/BpaNn2gzy6I6VirMC7QPpKgbI3Ha4MOcfYgSRtLuUWxXU7QhH6haT2CtLF5+WBlapDSk3wSQBh350E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bx2GPGMx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bx2GPGMx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777412091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8YgZ59T4Ia/590Wi+ZUHFzc1+RJhVjYDVi4upt2TFJQ=;
	b=Bx2GPGMx63Lb1uUH661Ti4DR9CBGnbM4iNLb04sTle9WNVxr73WfigFgB6J5/LtTIVKVb0
	jmpzh0tNJRJ/qVU89mXdugd3/ud1J8ztpj41Tu2ujLopCZ2uP2D7IDxYbjhtBU6ACGfepy
	OVql0iG1Ri32zr/xD838UtfkAw87EeM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-9yG5n2EmP0ycW46pcG5IEg-1; Tue,
 28 Apr 2026 17:34:49 -0400
X-MC-Unique: 9yG5n2EmP0ycW46pcG5IEg-1
X-Mimecast-MFC-AGG-ID: 9yG5n2EmP0ycW46pcG5IEg_1777412088
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3F3B19560B2
	for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 21:34:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF819195608E
	for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 21:34:47 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2] libsepol: Fix memory leak in role_dominates_copy_callback
Date: Tue, 28 Apr 2026 23:34:09 +0200
Message-ID: <20260428213444.907701-1-vmojzis@redhat.com>
In-Reply-To: <87zf2nsl6g.fsf@redhat.com>
References: <87zf2nsl6g.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
No changes, only added "Signed-off-by".

 libsepol/src/expand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 5b2b7b03..c7978948 100644
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
2.53.0

