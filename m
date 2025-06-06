Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F023BD06
	for <selinux@vger.kernel.org>; Fri,  6 Jun 2025 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749213386; cv=none; b=tRl9LwXcmRt0fIbyHGUfH/5nIXeZBhe/aDloiJxNHte6+kqq0njN7EmKmQudjfhxs65WVD+CC2xY9sjzgnaEyx+6A8+oj+dsOpRU57577q2iRvAcEXAO+nrK32hf+voGQ8iWvRf6heqkZmSJg2omF0Uat565D3eGDRl3oxyiwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749213386; c=relaxed/simple;
	bh=k3ObBbyX2n2un1z8uiiywXjWpiz3YBPQBnzWw8x4y/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=GKwYaj8tSwVluh8TadmaJJ/aXL3T/MRCoGDnERCbKxnu8Nakjwctc0KTu8Cklfhd6CxoDlXBbW9y0/lNP1vEas8u9DvrCS5HdiEyOtcg+WyvgbvrsRtk2HvDthD/AaepkL0STGvzutMB4EQmIdIhD6FDYZH7atxVm6k4XGUctck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmeZUm5y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmeZUm5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749213383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lI/g/Myu80zrdFoIWg2YHL+dQ86CxBnFQBnk1V4q2cs=;
	b=EmeZUm5yxb6l/kgy2p1FzPYhxKqPuKR8Sx0IQxFBwWq8Y14Dswd3JWCr2UoIA8WZiNYpiu
	HJGPh6rozcbKJkm44YRVxnY9kcL1/I3/7W5Ehmu+5lBm1Lzfh7Vk9JIkuWs3tm7hm1fZGE
	GTvyw9TS4xK+vEJhfan3XtCce7rVJyY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-rHBvEPFFNFeHslPsCigqzw-1; Fri,
 06 Jun 2025 08:36:22 -0400
X-MC-Unique: rHBvEPFFNFeHslPsCigqzw-1
X-Mimecast-MFC-AGG-ID: rHBvEPFFNFeHslPsCigqzw_1749213381
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3117195608B
	for <selinux@vger.kernel.org>; Fri,  6 Jun 2025 12:36:21 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DC6F19560B2;
	Fri,  6 Jun 2025 12:36:20 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH selinux-testsuite v3 1/2] userns_child_exec: Propagate child exit value
Date: Fri,  6 Jun 2025 14:35:33 +0200
Message-ID: <20250606123615.1029847-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Sometimes it's useful to know how a child ended.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 tests/cap_userns/userns_child_exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/cap_userns/userns_child_exec.c b/tests/cap_userns/userns_child_exec.c
index cdbf1205a717..2ee831a3ba7e 100644
--- a/tests/cap_userns/userns_child_exec.c
+++ b/tests/cap_userns/userns_child_exec.c
@@ -198,7 +198,7 @@ static char child_stack[STACK_SIZE];    /* Space for child's stack */
 int
 main(int argc, char *argv[])
 {
-	int flags, opt, map_zero, test_clone = 0;
+	int flags, opt, map_zero, test_clone = 0, wstatus;
 	pid_t child_pid;
 	struct child_args args;
 	char *uid_map, *gid_map;
@@ -332,11 +332,11 @@ main(int argc, char *argv[])
 
 	close(args.pipe_fd[1]);
 
-	if (waitpid(child_pid, NULL, 0) == -1)      /* Wait for child */
+	if (waitpid(child_pid, &wstatus, 0) == -1)      /* Wait for child */
 		errExit("waitpid");
 
 	if (verbose)
 		printf("%s: terminating\n", argv[0]);
 
-	exit(EXIT_SUCCESS);
+	exit(WEXITSTATUS(wstatus));
 }
-- 
2.49.0

