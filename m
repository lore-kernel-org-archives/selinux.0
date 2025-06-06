Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF0F20330
	for <selinux@vger.kernel.org>; Fri,  6 Jun 2025 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749209678; cv=none; b=bIr2+DPTEGq9dB2OHwcHuDUyouj2n/CjWMcxO+zOEcYmm7hsE4+bxgehbbA2gPjGtXgZ+BytoYk1URFb7HHe5mGCdIXR0EjlP+WwEQ3PemwntYk547IOLTWzHR0+/oxozZ/l1ik98KztaGLvWebeyfUokWWsoR+xjIcQDIt3PKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749209678; c=relaxed/simple;
	bh=k3ObBbyX2n2un1z8uiiywXjWpiz3YBPQBnzWw8x4y/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=ZMUIolHCq/QLuAk+pbhSqnbmtABT9gFV77Nwqk15PUau5/qNX7piq10QQTSxSZPd3HvDvw1LvtuzsjsgxAjY1r3QVlgNkmhhA31CGdT+FeoGrh0GoSwiE0eODYNrv3GOa6HbdfkdEmCcuWjKcc2cCZWGomvMI47zVjuZwNJwy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYeMtME9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYeMtME9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749209675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lI/g/Myu80zrdFoIWg2YHL+dQ86CxBnFQBnk1V4q2cs=;
	b=GYeMtME9lYCHcKQfO5alXYGQ+OFQafzE1fsk+w4G37qr7Q8ip4OHzery7Tf3biQjzhivGa
	4qkywbDgyIbI9ZUYLNDZrJbq88IYRV82c1vNmKTGeh0E7IpGEUuw3b+N8gwOtfHmPcWBTa
	IGrphBFaPTGQ85xCxntfGgPSnN63cSY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-jzxK22AfN2GnrMEr6J6mGQ-1; Fri,
 06 Jun 2025 07:34:33 -0400
X-MC-Unique: jzxK22AfN2GnrMEr6J6mGQ-1
X-Mimecast-MFC-AGG-ID: jzxK22AfN2GnrMEr6J6mGQ_1749209672
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA8111956087
	for <selinux@vger.kernel.org>; Fri,  6 Jun 2025 11:34:32 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.43])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94E121956087;
	Fri,  6 Jun 2025 11:34:31 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH selinux-testsuite v2 1/2] userns_child_exec: Propagate child exit value
Date: Fri,  6 Jun 2025 13:34:13 +0200
Message-ID: <20250606113413.1020169-2-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

