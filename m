Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A92173343
	for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491035; cv=none; b=WDDYvgjcaSf0OZ14jWhBpqbj+iQKSInGI/CVTQvgMNj+TRue2gV7g/HWpRYUbh7d7fwkCaiuluAdRZUb4lXPjkq8Hc2bLuq3flbTEU+0lYToaHs7jk/RNv5P8UMB0wXm63HpiGI2HS6SrhVQA3DyZaGkKu8DmwxDDA1nryOHfV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491035; c=relaxed/simple;
	bh=2dn4XU+ak6lQZknAhUSKhro9BT+tEjh4PQiYbozYKK0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rE5BW6ClnB8tLtxsdRsK65y7JOGs7DaEi/W7b7fTlzUo48WdLUvwc6q3ov78yrpWAFFpemHMhqGp0Ammoo+SWV+O+mnOjbd38/Nz1O7XWrUwMrDOqgTRFDhVAbF00i7Kh2VguIJAGTU+4i1SvnUeM/fsXxqi8zmrTBWrZ/13L+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNux5EYu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNux5EYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714491031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NJ9K0L1LGD/8QcTWqXH1ZUd6AzpIZVlyA1LfFztlMQA=;
	b=fNux5EYuDCTkizizCQ2LLSBr1WOuBdwJOaKvMWYA62uE7YOzGHcZH0bxAnEyd7bXdDMxrX
	AwWHzvRAdem0V83M04PqQInvR4hFSE6rTMJf7U0K2oM5VuXHIaF0RJEt6oAmckNVsyzcGU
	k36lxfLxN4En39uTiLxZloMcPeqVr0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-YuCejnc9OdO0NQTjiRZ4AA-1; Tue, 30 Apr 2024 11:30:28 -0400
X-MC-Unique: YuCejnc9OdO0NQTjiRZ4AA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 918F380017B
	for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 15:30:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.95])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3491D40B4979
	for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 15:30:28 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: Fix detected RESOURCE_LEAK (CWE-772)
Date: Tue, 30 Apr 2024 17:30:24 +0200
Message-ID: <20240430153024.790044-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

libsepol-3.6/cil/src/cil_binary.c:902: alloc_fn: Storage is returned from allocation function "cil_malloc".
libsepol-3.6/cil/src/cil_binary.c:902: var_assign: Assigning: "mls_level" = storage returned from "cil_malloc(24UL)".
libsepol-3.6/cil/src/cil_binary.c:903: noescape: Resource "mls_level" is not freed or pointed-to in "mls_level_init".
libsepol-3.6/cil/src/cil_binary.c:905: noescape: Resource "mls_level" is not freed or pointed-to in "mls_level_cpy".
libsepol-3.6/cil/src/cil_binary.c:919: leaked_storage: Variable "mls_level" going out of scope leaks the storage it points to.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsepol/cil/src/cil_binary.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 95bd18ba..c8144a5a 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -904,6 +904,7 @@ static int cil_sensalias_to_policydb(policydb_t *pdb, struct cil_alias *cil_alia
 
 	rc = mls_level_cpy(mls_level, sepol_level->level);
 	if (rc != SEPOL_OK) {
+		free(mls_level);
 		goto exit;
 	}
 	sepol_alias->level = mls_level;
-- 
2.43.0

