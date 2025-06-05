Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D81254B17
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130467; cv=none; b=qziZ+HwSeCOJOc0tCyGSyI4nsab+yYX/s76IfByu2jxqYKgkoE6qMPbkRBd7npWi+Emmxm8r1MkRca4ovpdL2F0v+LmVsR3/YD6JIx2E78qWrhHcyrDcoQxh1t5aoMWmhFWwQV8VPkcODL2FiFbP/kgJoktsIW5AJktkdWdVlb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130467; c=relaxed/simple;
	bh=k3ObBbyX2n2un1z8uiiywXjWpiz3YBPQBnzWw8x4y/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=ivSrjLIHU3dHwdp+RxVemLCSPDdHcO39Ai2qvz8qYJj+fMnU2E/Jn2OF/xeAjq4ssihJi8ALiyOxZ9jq1KSd6Xqm6rbhldpN4dAzg+xb0GFfABNiwQ1L0b9hwBKolU6QNBhHyqvYvHmOHYimGGKRIetPndDZQvElu+uuL9IiiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHW2NPlB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHW2NPlB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749130464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lI/g/Myu80zrdFoIWg2YHL+dQ86CxBnFQBnk1V4q2cs=;
	b=JHW2NPlB+ZxPYK+6e8bTgCy4BEYezOyPwCRq5qf77yzkCTj4jT+nzNOMEiCm7sHL+pJKXW
	KJwt/yiULTuyfKC4AcsCAped6J51Gwu3/hVDuCzPaU9uGiQzTEEkq0bi3bdkfHOuDiWQUN
	/Lc23sfkGdizm48+2u0fTtA0I9bHx0U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-7Dd9-YroPyybj-Oqzxf-mg-1; Thu,
 05 Jun 2025 09:34:23 -0400
X-MC-Unique: 7Dd9-YroPyybj-Oqzxf-mg-1
X-Mimecast-MFC-AGG-ID: 7Dd9-YroPyybj-Oqzxf-mg_1749130462
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A15521956080
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 13:34:22 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.60])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F6CF18002B3;
	Thu,  5 Jun 2025 13:34:21 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH selinux-testsuite 1/2] userns_child_exec: Propagate child exit value
Date: Thu,  5 Jun 2025 15:34:00 +0200
Message-ID: <20250605133414.939461-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

