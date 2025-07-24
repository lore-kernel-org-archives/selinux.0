Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9B1FDD
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353949; cv=none; b=n2G8S/qbC1cwbKPoxX/rOo5GmbHuXLtXDCrne+x4Jn+rYVZSCm8+3jHA/Ae77cOTYU/D414oXY9jGTn3MyvtgspZ5wWKuz1bzfXsp4ogjh8UBAC5I3cIT0AChCPyIxUr/eK1Ao0LdlcvktT/+L9gUnD9DidStP+hICWNIw3Bo4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353949; c=relaxed/simple;
	bh=DiRFlKcw3pDJaNiybWSt2rspepQ2F3dxiOQnF2RqjSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Wj61r+XN5r0sBT+uyZxfw3TMm0aO8T3/0LgBvRPRTH42roSOkNWec2c5cuVWwCeDP+tEvx0YWj90WQwfaQbJM/goMA1iwEjdkLSXP52k7rIPG5N8xALWDkL7Ae6pjwPIkd6Pftrwox03v1ir3EutwCD+6UwcBB9RuE+aELWRX4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=daE67rnr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daE67rnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753353946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=01CjsgxmR2GAK6elkmbAfp/wkOvPnAE1sy2ZDHi5SdM=;
	b=daE67rnrqxQEKHZpSDEMwZsh3GPVgWvGYlsohqlSYV6GYWh0kf3MDx4GYlj0ynm19R21Id
	Go/fstPfJB/VYpoCwrEHFHrguK+3Ot3g3xQKBpY+89bQJjK/Kne7DykGJ/uNd2dEdu8KMP
	N8+gMBILjWxJvy/amCb7pAQAeqaPrqU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-FMXsUvYdO1WqA9RVMF4LLQ-1; Thu,
 24 Jul 2025 06:45:44 -0400
X-MC-Unique: FMXsUvYdO1WqA9RVMF4LLQ-1
X-Mimecast-MFC-AGG-ID: FMXsUvYdO1WqA9RVMF4LLQ_1753353944
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5E6A195608B
	for <selinux@vger.kernel.org>; Thu, 24 Jul 2025 10:45:43 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.172])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89C6C1956089;
	Thu, 24 Jul 2025 10:45:42 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] README.md: add link to the github wiki
Date: Thu, 24 Jul 2025 12:45:31 +0200
Message-ID: <20250724104539.42620-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 README.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/README.md b/README.md
index aa98d7819b01..5c6caa9d710f 100644
--- a/README.md
+++ b/README.md
@@ -19,6 +19,9 @@ Please submit all bug reports and patches to the <selinux@vger.kernel.org>
 mailing list. You can subscribe by sending an email to <selinux+subscribe@vger.kernel.org>
 Archives of the mailing list are available at https://lore.kernel.org/selinux.
 
+See the [SELinux Userspace wiki](https://github.com/SELinuxProject/selinux/wiki)
+for more information.
+
 Installation
 ------------
 
-- 
2.50.1

