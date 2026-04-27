Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C46935F60B
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307110; cv=none; b=WKuDfMdyuDS3HfW28aDd7EnoRbjSZojVLgi0HcG6B3nQpoqAHGMonW+Pc6kFx3Cz0MYDuYtlzDYxBqpnaN6PlTpGMxjxac+kgJYKdXWOm/SLFGDzOcx4Qhm/0Dy4mKq5TCHmLJEZclC/dkMlR48PG5lxEL+ULuD1gJn5ZW863JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307110; c=relaxed/simple;
	bh=SucS2qDuqLt7MEIHjmeOCMKyeBekhTEBG498u6pEgRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzD9S7bxvOqAPjiu+a7fTGK4eCLsgDfofJi1A3hy1BKP2aAPpjCSCzT+u/raI6fe/YdcdFsru5p7kwRi//TS7bjfnWeLaxmkiEqW/GVpEGgEuzXbkOMixpjCwnbOSpEPydEMcLleAz5Tt5q63liicVhilLvQ8u9MfPplyByTzXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tji/2duN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tji/2duN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777307107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7x+mTeTZfRvigWglDom1b5odUFKLF6qZ3tY7nDz9OK8=;
	b=Tji/2duN+a29Jbg5tcZNqNNiUNEoGqEqhWzrJR4YY1UXTEO4YzqYtXSKYOjVl1q3Zknmyk
	hDGOHAGjVBxeRjbb9Qhk14ds2RWXZZJS9wEx4t6x1p+l0a8eymTbfQYw1Dr+xkXz3WO91c
	KsMzHIb8SgPIS8739RSObOCLezpXxUU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-vWhq5xbsMbaZH9ekBdPEZQ-1; Mon,
 27 Apr 2026 12:25:05 -0400
X-MC-Unique: vWhq5xbsMbaZH9ekBdPEZQ-1
X-Mimecast-MFC-AGG-ID: vWhq5xbsMbaZH9ekBdPEZQ_1777307104
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7414195608D
	for <selinux@vger.kernel.org>; Mon, 27 Apr 2026 16:25:04 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.48.171])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1CCA180047F;
	Mon, 27 Apr 2026 16:25:03 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 3/3] libsemanage: Do not use vfork()
Date: Mon, 27 Apr 2026 18:24:40 +0200
Message-ID: <20260427162452.132118-3-lautrbach@redhat.com>
In-Reply-To: <20260427162452.132118-1-lautrbach@redhat.com>
References: <20260427162452.132118-1-lautrbach@redhat.com>
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
    semanage_store.c: In function ‘semanage_exec_prog’:
    semanage_store.c:1307:16: error: variable ‘a’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
     1307 |         char **a;
          |                ^
    semanage_store.c:1265:15: error: variable ‘new_s’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
     1265 |         char *new_s = realloc(s, len + 2);
          |               ^~~~~
    semanage_store.c:1265:15: error: variable ‘new_s’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
    cc1: all warnings being treated as errors

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 libsemanage/src/semanage_store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index e3048c08df0e..99d55d9813c9 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1488,7 +1488,7 @@ static int semanage_exec_prog(semanage_handle_t * sh,
 
 	/* no need to use pthread_atfork() -- child will not be using
 	 * any mutexes. */
-	forkval = vfork();
+	forkval = fork();
 	if (forkval == 0) {
 		/* child process.  file descriptors will be closed
 		 * because they were set as close-on-exec. */
-- 
2.54.0

