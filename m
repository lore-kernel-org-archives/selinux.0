Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2443242B8
	for <selinux@vger.kernel.org>; Mon,  5 Jan 2026 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634832; cv=none; b=HDDzUJFK4pOjUNhOnfLElNZdW7iJpfrNSb4w2nDi39rD9SuhyjP+hdayWkFM4XEkAIICcrryPyR/28sMxryoxFkS9C/5xEqDIOcVRHF5jryt2ezVrLFCDMvqHWZK8045Id0xdV9BnhC97ErXxCh7OuBDypwiKDUHBI+JcMbjIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634832; c=relaxed/simple;
	bh=6gsK4X19BHFh4C1iuGrGtlwAmu3gxa7XMxqlUupJYWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=LEfLhtKzlCNVxzdx60baG3syQVXcyTgovDi3234OiXScS8T0yghIgC39JgrQ3kT+2Vnh2V9tH6OuO5bnyIN+F2NFvcYpnJNqtBOcqDJdo9nHSTHXRuLYTjrBPFBM4tXFX2H67Yog7sVYFhhL4/mqjjLbCuu4jc2hRGoYPr1jHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1ynOE9u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1ynOE9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767634828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XhNBexD4AIyCFdV7JLtWwvlTw2j6YSvmK6t/bencCEw=;
	b=G1ynOE9u+dvH0Xg/iEq5Ut+x6gaVHKQ/buaRdFqkBn+JjayQ4I3+QAq0JNiSxOBlWQMYp4
	ZMS5bJB2aoUS+bnux9okqax/0ceSQSJiFgpqZ+o3wl3qYt+FBRFh9Li6DcjtYk7kYTSOAY
	azV7rvuZ2w/MydouHTZSMpRlVn80qJ4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-JB1xxBrnMRGpKJt91DiaFw-1; Mon,
 05 Jan 2026 12:40:27 -0500
X-MC-Unique: JB1xxBrnMRGpKJt91DiaFw-1
X-Mimecast-MFC-AGG-ID: JB1xxBrnMRGpKJt91DiaFw_1767634825
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C8E31956068
	for <selinux@vger.kernel.org>; Mon,  5 Jan 2026 17:40:25 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.211])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A93219560A7;
	Mon,  5 Jan 2026 17:40:23 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
Date: Mon,  5 Jan 2026 18:40:11 +0100
Message-ID: <20260105174020.887724-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The key is available at:
https://github.com/bachradsusi.gpg
https://plautrba.fedorapeople.org/lautrbach@redhat.com.gpg

Also update the email address

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 SECURITY.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/SECURITY.md b/SECURITY.md
index 2a7ce5b317a7..faa060ccff03 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -24,7 +24,8 @@ list is below. We typically request at most a 90 day time period to address
 the issue before it is made public, but we will make every effort to address
 the issue as quickly as possible and shorten the disclosure window.
 
-* Petr Lautrbach, plautrba@redhat.com
+* Petr Lautrbach, lautrbach@redhat.com
+  *  (GPG fingerprint) 68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E
 * Nicolas Iooss, nicolas.iooss@m4x.org
   *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494 C5EB
 * Jeffrey Vander Stoep, jeffv@google.com
-- 
2.52.0

