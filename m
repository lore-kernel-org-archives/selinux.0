Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF56408001
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981135; cv=none; b=aMUpaLwvWSTAXCS9XZhG8WRceWn0Lowmkp1pLB0UjUXhEoXhJbhuXaUJbmgg1Z/MbyuR6xaLNN43GRzTWC4Skjn4QYlUanUCkcHR2NsNhFyS3poihzzRwuq2fDFhnleIfwWQ7CWKhcY0Uvlj/OJSm9sX7lKUAk+Q2gVjSPloL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981135; c=relaxed/simple;
	bh=/TiVNBejNWMWfL8Dx1FWAFyMv7z9z4kf7n/PLb5McYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=N+xhlW3iAJXftFCGXSpVtEMbjZGfxlhC/+gWQBN+/4eluIwH23JcX5HLifzHRhR+izhdolXRgGCHJPACPD/hYlSGCC0LPzDZ5LKiiJIFh3qvYgDlrsputm5OmG8F724efJcDhkHlFSCJhmaRq3bH2NqxELZbqvmBUVfZe5p9sPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNUuvNOO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNUuvNOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779981023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4CG/9wWIccRaE6rKh/ytiWxPNvYNQq7+aBuUth7JRIw=;
	b=gNUuvNOOCN+rRMWaqhOjwHJlXi9kOWsagY4DPYNzbaNIGZWuAWZG4XL3HUlaZUBWsMr83L
	Qc6KdjiYZQUbCCi+F/FUBzxboat5nMS1ujxz9ytg7JpBtZstp7leyM+SKM7XQzdk/aHtOY
	JxaAyrTRe9aAsDYPJj2zbHaL9oi29lk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-dzBv9YYVPgCXclTM7GXZUw-1; Thu,
 28 May 2026 11:10:19 -0400
X-MC-Unique: dzBv9YYVPgCXclTM7GXZUw-1
X-Mimecast-MFC-AGG-ID: dzBv9YYVPgCXclTM7GXZUw_1779981019
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0C5718002CF;
	Thu, 28 May 2026 15:10:18 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.147])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F41BE19560A3;
	Thu, 28 May 2026 15:10:17 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: ra33it0 <sebastian@sporyon.io>
Subject: [PATCH] seclic/docs: fix statement definition of roletype
Date: Thu, 28 May 2026 17:10:09 +0200
Message-ID: <20260528151014.1281996-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: ra33it0 <sebastian@sporyon.io>

Signed-off-by: ra33it0 <sebastian@sporyon.io>
---
 secilc/docs/cil_role_statements.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/docs/cil_role_statements.md b/secilc/docs/cil_role_statements.md
index 2e1b40475d67..3e0688db2970 100644
--- a/secilc/docs/cil_role_statements.md
+++ b/secilc/docs/cil_role_statements.md
@@ -51,7 +51,7 @@ Authorises a [`role`](cil_role_statements.md#role) to access a [`type`](cil_type
 **Statement definition:**
 
 ```secil
-    (role role_id type_id)
+    (roletype role_id type_id)
 ```
 
 **Where:**
-- 
2.54.0

