Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1F185E50
	for <selinux@vger.kernel.org>; Fri, 25 Oct 2024 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881047; cv=none; b=nz/OGHINuqAnaN6B9oXN/pI+gi/BdayfNlw5zpJO2+dIHehtbrb5EBm/Dljjo12C5ZvHMORJyRAfqo1Kjj/IbUY+mjQyB0g+QqUT4GBZ13pVszj6Pk2Mgw5kNsSIfzDAots2nJtsHAquToN7HY9LTlsldsUNpkm36ebwLVnrhrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881047; c=relaxed/simple;
	bh=w9RSmWIvMwgde6CutuogvPfityH1bQNzjfNGaJisnVA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4xCKqEm1iHg7m5wUqMqrK+U1nKOpoqRraAAQOsag4GYvWejEmQqt/2uOsvZqbTRSrVj5pKwz5V7lQQLkWwE3Gi+jrnsGJaOvgotxY/LtMk70idMqRatwtjS1aTDYzIvfTemGXB/d1GVTt8FmtNKLgO/m49OFO5/1CZQ65MWXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTTnQuYW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTTnQuYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729881044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CabjybX8wpPdOTpOKilOCKBweB2aOd7EQsl12FKgFlo=;
	b=RTTnQuYWpmsh/n7REAHivAWqz9Ho16uDqxWbS/eFXIfL61+tbZ6bZgVGeWobk7HVcnQSd5
	w215U9OPa/3JywCCDCXIULYiKgVBQnq4YJPNvEqc0ZHIpuyLn4bgexSJFgmiHr5viBxvl5
	0599hA9DRqo7yl2jv84ZdRdrjosPgwU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-4wJ1BwrjNbOiJyd8v4rEoA-1; Fri,
 25 Oct 2024 14:30:43 -0400
X-MC-Unique: 4wJ1BwrjNbOiJyd8v4rEoA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 327D41956089
	for <selinux@vger.kernel.org>; Fri, 25 Oct 2024 18:30:42 +0000 (UTC)
Received: from fedora.tail6b4d1.ts.net (unknown [10.45.225.141])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76FFD1956088
	for <selinux@vger.kernel.org>; Fri, 25 Oct 2024 18:30:41 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/2] libselinux/matchpathcon: RESOURCE_LEAK: Variable "con"
Date: Fri, 25 Oct 2024 20:30:14 +0200
Message-ID: <20241025183014.1826149-2-vmojzis@redhat.com>
In-Reply-To: <20241025183014.1826149-1-vmojzis@redhat.com>
References: <20241025183014.1826149-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fixes:
 Error: RESOURCE_LEAK (CWE-772):
 libselinux-3.6/src/matchpathcon.c:519: alloc_arg: "lgetfilecon_raw" allocates memory that is stored into "con". [Note: The source code implementation of the function has been overridden by a user model.]
 libselinux-3.6/src/matchpathcon.c:528: leaked_storage: Variable "con" going out of scope leaks the storage it points to.
 \#  526|
 \#  527|           if (!hnd && (matchpathcon_init_prefix(NULL, NULL) < 0))
 \#  528|->                         return -1;
 \#  529|
 \#  530|           if (selabel_lookup_raw(hnd, &fcontext, path, mode) != 0) {

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libselinux/src/matchpathcon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index e44734c3..967520e4 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -524,8 +524,10 @@ int selinux_file_context_verify(const char *path, mode_t mode)
 			return 0;
 	}
 	
-	if (!hnd && (matchpathcon_init_prefix(NULL, NULL) < 0))
+	if (!hnd && (matchpathcon_init_prefix(NULL, NULL) < 0)){
+			freecon(con);
 			return -1;
+	}
 
 	if (selabel_lookup_raw(hnd, &fcontext, path, mode) != 0) {
 		if (errno != ENOENT)
-- 
2.47.0

