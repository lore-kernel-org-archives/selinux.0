Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64E1FB899
	for <selinux@vger.kernel.org>; Fri, 25 Oct 2024 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881141; cv=none; b=tUVEiLK8h5nZ9y0OPoGMMZuCNCkfTVfGXMC+lYFu12j5E3uhXDzlGeBTJ8m58D1QUD6hAKqhwII8qEQVbDkJpMtUyBpqlxOyu/oB+n7NpkRdd0WLiie4OJP+T4Vb6aEw9iqGbO5gNT4X96y+sJJzF1VV/+HCJHc+h5BXQyZyb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881141; c=relaxed/simple;
	bh=t3oRjFNh5sSZq2bqbeLmpyPKVJVZ0XmVXUjOnmShXAM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U7GmLOUf6UmhSmKLSH0FQUK/LX7jSu4RVWVvTOYZgDibpuikUxjC5lo8CnLvqL37wn6EPZ8a2pQytrUoKDmq2V4HK7mjM+IRxrVgfhSCPfmOgNROlb/2J6xC+sAOd+dEnaGYy8IYq+JBlSSdjH5hJ0ggxAcYoTq7O90nIt8QLZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrIhzaoF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrIhzaoF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729881137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F1Rt4Wy7K2ss8FXoIbRee/hXnywyTQ/lA2D8oFC1qGs=;
	b=UrIhzaoFHCybOVDY8eWRNTtdRfysgVt0vM0Kug3gqSUM1M/SofRYksS02ED5R/Q/zElyzm
	kkx+SqYD0QO1xVB+eHpTEYJUKMPedm5fSudUUvka2FLFjCUVgQjTZcHLQOJk1HxRP9b2Tt
	1LDQnoq3HYdAnhqkq2lgslfMVlJvSto=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-8n_Pdes6ORKoJVyf8xoPbg-1; Fri,
 25 Oct 2024 14:32:15 -0400
X-MC-Unique: 8n_Pdes6ORKoJVyf8xoPbg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE96E19560A1
	for <selinux@vger.kernel.org>; Fri, 25 Oct 2024 18:32:12 +0000 (UTC)
Received: from fedora.tail6b4d1.ts.net (unknown [10.45.225.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 272E0300018D
	for <selinux@vger.kernel.org>; Fri, 25 Oct 2024 18:32:11 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libsemanage/direct_api: INTEGER_OVERFLOW read_len = read()
Date: Fri, 25 Oct 2024 20:32:07 +0200
Message-ID: <20241025183207.1827274-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The following statement is always true if read_len is unsigned:
(read_len = read(fd, data_read + data_read_len, max_len - data_read_len)) > 0

Fixes:
 Error: INTEGER_OVERFLOW (CWE-190): [#def19] [important]
 libsemanage-3.7/src/direct_api.c:598:2: tainted_data_return: Called function "read(fd, data_read + data_read_len, max_len - data_read_len)", and a possible return value may be less than zero.
 libsemanage-3.7/src/direct_api.c:598:2: cast_underflow: An assign of a possibly negative number to an unsigned type, which might trigger an underflow.
 libsemanage-3.7/src/direct_api.c:599:3: overflow: The expression "data_read_len += read_len" is deemed underflowed because at least one of its arguments has underflowed.
 libsemanage-3.7/src/direct_api.c:598:2: overflow: The expression "max_len - data_read_len" is deemed underflowed because at least one of its arguments has underflowed.
 libsemanage-3.7/src/direct_api.c:598:2: overflow_sink: "max_len - data_read_len", which might have underflowed, is passed to "read(fd, data_read + data_read_len, max_len - data_read_len)". [Note: The source code implementation of the function has been overridden by a builtin model.]
 \#  596|   	}
 \#  597|
 \#  598|-> 	while ((read_len = read(fd, data_read + data_read_len, max_len - data_read_len)) > 0) {
 \#  599|   		data_read_len += read_len;
 \#  600|   		if (data_read_len == max_len) {

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/direct_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index d740070d..7631c7bf 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -582,7 +582,7 @@ cleanup:
 static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len, int fd, char **out_data_read, size_t *out_read_len)
 {
 	size_t max_len = initial_len;
-	size_t read_len = 0;
+	ssize_t read_len = 0;
 	size_t data_read_len = 0;
 	char *data_read = NULL;
 
-- 
2.47.0

