Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B973D35BDA4
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307107; cv=none; b=gJNcmydWLQhdg/d+iKPROZpnoFmchx1cqwLASzs8TAYIKGrGRQM6TeuKFDZGJQlQS5mQl0wN7M84gNC0KCQYFgFth+w13SQ7NJ3cddvZYbsXhHt89FOPjbQ3iGYmIoj7ZgcUNVfm/X2H7j5TFj+9JZAYQWNdB4sIxg1CT+pc5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307107; c=relaxed/simple;
	bh=h76zm6Dk1+1aMsxFwWCARuxV/NZzQXxJZYyt6IBllJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNsrRmR9Qnm1sm1DQW3jXPQzdKlmvy5Ux5C84lmU5Edjy7MLqj12uWlF07G9MxL1e5cqs94GT5Wg9VGVQRW/cy9rhGQyuFt6KQueTceNZJjsICKg/9oMQqZMmHy5R5EDwwjr/+yvsgRkAD+2b6wWoyySOyvdjyUBgtwypqSwZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=deG3z8ti; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deG3z8ti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777307104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N1PTf0qygKJWjbWrbamB2Y7RCA5UZodtPWs2ziMwSDM=;
	b=deG3z8tiIrkl5KBNR1i2CwcDZu4gHBKopg/GVyLWsXGmg2EUJASgc586QTh0yZzrLk93e/
	Lm/wDHl0AeVp3O2/k2FhYs1/RIW70IaZiT1QbMyzE2BM+JcQ/4lESNaNK2WkuLmFDDhYKl
	4a7frL+/oLIPZvoJCoyOic6q9Jq6YCI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-cmsHYLjEPjGoSWf6173wpg-1; Mon,
 27 Apr 2026 12:25:02 -0400
X-MC-Unique: cmsHYLjEPjGoSWf6173wpg-1
X-Mimecast-MFC-AGG-ID: cmsHYLjEPjGoSWf6173wpg_1777307102
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C5F219560A6
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 16:25:02 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.48.171])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F1BEA180045E;
	Mon, 27 Apr 2026 16:25:00 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 1/3] libselinux: do not discard const qualifier
Date: Mon, 27 Apr 2026 18:24:38 +0200
Message-ID: <20260427162452.132118-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fixes:
    selinux_config.c: In function ‘selinux_set_policy_root’:
    selinux_config.c:284:29: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
      284 |         char *policy_type = strrchr(path, '/');
          |                             ^~~~~~~
    cc1: all warnings being treated as errors

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 libselinux/src/selinux_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index e1bc1b79fb10..1e6da288aaeb 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -281,7 +281,7 @@ const char *selinux_policy_root(void)
 int selinux_set_policy_root(const char *path)
 {
 	int i;
-	char *policy_type = strrchr(path, '/');
+	const char *policy_type = strrchr(path, '/');
 	if (!policy_type) {
 		errno = EINVAL;
 		return -1;
-- 
2.54.0

