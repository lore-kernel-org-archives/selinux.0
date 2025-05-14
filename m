Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6201E04BD
	for <selinux@vger.kernel.org>; Wed, 14 May 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206431; cv=none; b=av6fp2fHZS4eNyH/hjo9nIAWPHF9DuEsmLz6kG+tGvdnIExNCTbOrt1qzVtrCRhYrFvGI/y3Yg+wcj/B7He74xgcm49hM6kehO7dHuUPOm6R7aFkfOUOZh1lRa7Q9/TcsuAZRzl5DkJ55Ns1X1Eftb2QhqsP84P2d2F4LVuHGAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206431; c=relaxed/simple;
	bh=ukvcM9K/pxIwC0tTTDR3YTKgwzMlWfx1zgjGatTk8V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=W5ddImVJOMThFPNnhyVkLZruLaC7VuOAp/DrqJV9Bg2b8b0ZcI+bBUmV49dOuMhvTf6FnRj4puezxeQihnX8HCsrUaAfeXCQNTLweNTmBIopmtQ+HcQjqgW6LBmM9PEYx4lPB7zsl79GP487q4RgOJ4E+FNKkbbwB/3nwkLpmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ET+jwv7h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ET+jwv7h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747206428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W+xPXYc9q+jeHPIOl2qGnx9h0F8HEsEyzjdk4OujfRw=;
	b=ET+jwv7hOhJ75BQ7Ugu4Fv0pnPlhtz0fr8PyK9uIpCOC/6fiNV36AnXIz5MKq6Rwfob+cO
	jA+IXebUsB1X96k1zFLB4LdUFzfNaw42sxrv+U3IdsqT0rwQwDAkyGgZ2EB201R6QbID2j
	UAzfhmLiqLjuKRPsX9HFue7DNlQEYDk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-A9LCEedNME2oW5TBE2O7kg-1; Wed,
 14 May 2025 03:07:07 -0400
X-MC-Unique: A9LCEedNME2oW5TBE2O7kg-1
X-Mimecast-MFC-AGG-ID: A9LCEedNME2oW5TBE2O7kg_1747206426
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA7B018001D5;
	Wed, 14 May 2025 07:07:05 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.64])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 460421940E95;
	Wed, 14 May 2025 07:07:04 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>,
	Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] README: update subscribe information
Date: Wed, 14 May 2025 09:06:45 +0200
Message-ID: <20250514070651.223058-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Majordomo commands are no longer supported after the migration away from
legacy vger infrastructure.

https://subspace.kernel.org/vger.kernel.org.html#what-happened-to-majordomo

Reported-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 README.md | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index 1e16beea6536..aa98d7819b01 100644
--- a/README.md
+++ b/README.md
@@ -16,9 +16,8 @@ and system libraries which allow for the configuration and management of an
 SELinux-based system.
 
 Please submit all bug reports and patches to the <selinux@vger.kernel.org>
-mailing list. You can subscribe by sending "subscribe selinux" in the body of
-an email to <majordomo@vger.kernel.org>. Archives of the mailing list are
-available at https://lore.kernel.org/selinux.
+mailing list. You can subscribe by sending an email to <selinux+subscribe@vger.kernel.org>
+Archives of the mailing list are available at https://lore.kernel.org/selinux.
 
 Installation
 ------------
-- 
2.49.0

