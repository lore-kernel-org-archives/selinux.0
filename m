Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF220D4E8
	for <selinux@vger.kernel.org>; Fri, 25 Oct 2024 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881043; cv=none; b=SQfJLSjXQdP783AwhLTdHXjkiR62mZI9PquYo2J5C1qebi35yvucEa4fyy88kCGpdp/E/w2qYW4NKmrV2sDrKO4Qn7Eqql94hjCrllpOB3PVwh+6lB4QQHJcHLL5ysDdiF2OMF7Edm5n8cb/HvO5nLFGlXu4ZSDEPHwKDF9kby4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881043; c=relaxed/simple;
	bh=RD5IyU4Ycs2NzQJEvvRARxz2ZgvBE/jYp8rdoxD2ZH8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z2ibyWztY6qAnuAGhcaZW2X+bfisK+tk8TWnFn7VmvLX7lx8dtTUP3z2JoNqDujXjXoYSAmAThdsXfC8KszW928d5lJCcTYwTvUFuLtX4Y9HGyfYli+fWJ7l6I4QdfNTCVt3XaTKaVIk1QT02ftNtIjl5OMhKSAsGk2nRsg5ZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gw60Z9fE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gw60Z9fE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729881039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HyZSbFW1vYqMwT24u9iC/6uXQBBQXEOd9nTy1nphhuc=;
	b=gw60Z9fExRbAn8MYgl7cDxg3Y7Y6mq7n+Dw82Ofa534P0roXpxNLvfM8zU24ndcfQOCsgD
	02WwNnsRo6Rs2dsJCzQPdc7qAdUDcXMNANfn9tNlFzSyvQLKfuRtUAgF3PvV0xfmjuMhK4
	3wH7f6yz5Yglq+Qbqm5VKj4td+RVOyg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-Wy0xnKN2NTOqs5pvHhhOrA-1; Fri,
 25 Oct 2024 14:30:37 -0400
X-MC-Unique: Wy0xnKN2NTOqs5pvHhhOrA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDFA119560B2
	for <selinux@vger.kernel.org>; Fri, 25 Oct 2024 18:30:36 +0000 (UTC)
Received: from fedora.tail6b4d1.ts.net (unknown [10.45.225.141])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D6D71955F43
	for <selinux@vger.kernel.org>; Fri, 25 Oct 2024 18:30:35 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/2] libselinux/setexecfilecon: Remove useless rc check
Date: Fri, 25 Oct 2024 20:30:13 +0200
Message-ID: <20241025183014.1826149-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fixes:
 Error: IDENTICAL_BRANCHES (CWE-398):
 libselinux-3.6/src/setexecfilecon.c:45: implicit_else: The code from the above if-then branch is identical to the code after the if statement.
 libselinux-3.6/src/setexecfilecon.c:43: identical_branches: The same code is executed when the condition "rc < 0" is true or false, because the code in the if-then branch and after the if statement is identical. Should the if statement be removed?
 \#   41|
 \#   42|           rc = setexeccon(newcon);
 \#   43|->         if (rc < 0)
 \#   44|                   goto out;
 \#   45|         out:

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libselinux/src/setexecfilecon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/libselinux/src/setexecfilecon.c b/libselinux/src/setexecfilecon.c
index 2c6505a9..4b31e775 100644
--- a/libselinux/src/setexecfilecon.c
+++ b/libselinux/src/setexecfilecon.c
@@ -40,8 +40,6 @@ int setexecfilecon(const char *filename, const char *fallback_type)
 	}
 
 	rc = setexeccon(newcon);
-	if (rc < 0)
-		goto out;
       out:
 
 	if (rc < 0 && security_getenforce() == 0)
-- 
2.47.0

