Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44284481B3
	for <selinux@vger.kernel.org>; Mon, 19 Aug 2024 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091733; cv=none; b=e7d3KcMYF8pP0ofDhdcH+JMxeBsxborw3UOxJfrQ6pb6M1PKY/MGhhYl12Y3igkniHUfuH8m6frLN4d32HnsUbaxIKTLJM5qQvpnHpG4TRXABz1yEE/tGaeQe07vlJsi7OmefbuuNnofhKG9sAcM/3E33VUkRO0IuT9/Xg5zyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091733; c=relaxed/simple;
	bh=WRYMr0/HTsKJIlYGdjHBMiBUj3rviLZlPepUM276+qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=K/0gYTLz4qwYquS1v6zEFxowiRSjrs9GctwCdlxNxO+oZI1+5wO6bwL1L7g0QmGE4L/YmWqRiI88glZHGmjH6VyCXDZoFk84yNcfHmSLAWqh3jT+zPynBgYR0bxzZskS/nOZbUpEN7YoHgusn8ITurqgM+MZOsUfIPZZZibN+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ah0PJKEf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ah0PJKEf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724091731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JsIHP5Mr4qyOeMZbL6zdRS0VgIVFVroko/Y/l0iGnvQ=;
	b=ah0PJKEfW61awWkZkcvWRtT55BMapYZ8F/Xf/SOD9Sok1Lp1rjJiQLlx7t3UyRER1Xoz7m
	l7yl+Xm6exiECCrAyNHAhtmDHuw7jxhZhUHvrx92n0V8rP2lRH35TXvhQE+nGMGKczQQPn
	6VHBK8QaO73t2zMLsgdHHcggkoiGBYU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-i2AXasRaNfui0BDYHsiPnA-1; Mon,
 19 Aug 2024 14:22:09 -0400
X-MC-Unique: i2AXasRaNfui0BDYHsiPnA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 006D119560B4
	for <selinux@vger.kernel.org>; Mon, 19 Aug 2024 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.77])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DA4E3001FF1;
	Mon, 19 Aug 2024 18:22:07 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] sepolgen-ifgen: allow M4 escaped filenames
Date: Mon, 19 Aug 2024 20:21:24 +0200
Message-ID: <20240819182123.1037607-2-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When a file name in type transition rule used in an interface is same as
a keyword, it needs to be M4 escaped so that the keyword is not expanded
by M4, e.g.

-	filetrans_pattern($1, virt_var_run_t, virtinterfaced_var_run_t, dir, "interface")
+	filetrans_pattern($1, virt_var_run_t, virtinterfaced_var_run_t, dir, "``interface''")

But sepolgen-ifgen could not parse such string:

    # sepolgen-ifgen
    Illegal character '`'

This change allows M4 escaping inside quoted strings and fixed described
problem.

https://bugzilla.redhat.com/show_bug.cgi?id=2254206

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/sepolgen/src/sepolgen/refparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index e261d3f78f87..9622ee9a29ce 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -261,7 +261,7 @@ def t_IDENTIFIER(t):
     return t
 
 def t_FILENAME(t):
-    r'\"[a-zA-Z0-9_\-\+\.\$\*~ :\[\]]+\"'
+    r'\"`*[a-zA-Z0-9_\-\+\.\$\*~ :\[\]]+\'*\"'
     # Handle any keywords
     t.type = reserved.get(t.value,'FILENAME')
     return t
-- 
2.46.0

