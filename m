Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5F1799F
	for <selinux@vger.kernel.org>; Mon, 20 Apr 2026 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688893; cv=none; b=cZYAFttZ6l9F+T1drsPbnvvE//yj47Jq0zS52+K7w7donO0RVBKE6ivVhiBRsb3fIWdoeUQKO6X1zrEWOA6LCO1mtBkXXQtKDapV0jHClDdOY3wJ/z7b5Aa7VNnOol2NFje+CvBO2U4OThLmO2jHOP4KCXuyi3oZ071QtSEKtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688893; c=relaxed/simple;
	bh=3jw70MxijpyI87dVt+kSg+earFp/tYVetdkjip33LH8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jPJrUJaAdCPWOCO1wr/ZDCrQXYbp264FjCuRMEKzHf1wxpvXSfSG9X7h5619dvnmfYe7vO/JWP2VDxV2OgIbK+fBuaZml8uEeKQtMVF5qSIGISC3C+D5eCoL0lEsKjTbrSXSWhu4o9tttXGIAATI99QlV7I3UTDr5eVitDp1HWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dotYbdpQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dotYbdpQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776688890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oxw/8xSYEIkkndkf3V7+h2zHmYQWw4wlgZU3MyXn0bE=;
	b=dotYbdpQA8tQmY3bQsOh1FwNm+xO+Jd+m2DyYwbwDTCWHyaZSvi/lx2wvCJnhgle65kBfP
	iJWmEOKg0IaNmpegpzklewTN/bVT5WYP46lUuFNDKoSYVc6g8xYyb5yLT9zx33Qy9T+4QZ
	hvc0kn66PXfd7Wr6179Ytymu+kRZYag=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-kPhsd984O_GabbKIyjLWhg-1; Mon,
 20 Apr 2026 08:41:29 -0400
X-MC-Unique: kPhsd984O_GabbKIyjLWhg-1
X-Mimecast-MFC-AGG-ID: kPhsd984O_GabbKIyjLWhg_1776688888
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9E321956095
	for <selinux@vger.kernel.org>; Mon, 20 Apr 2026 12:41:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.50.248])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F018F1956095
	for <selinux@vger.kernel.org>; Mon, 20 Apr 2026 12:41:27 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] checkpolicy/test: Show all options for dispol and dismod in -h
Date: Mon, 20 Apr 2026 14:41:22 +0200
Message-ID: <20260420124124.324404-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Show the following options, which were hidden in the usage message,
because they require additional input:

dispol:
  7    change a boolean value
  f    set output file
  m    display menu
  q    quit

dismod:
  l    Link in a module
  f    set output file
  m    display menu
  q    quit

Fixes:
  $dispol -h
  Usage:
   sedispol [OPTIONS] binary_pol_file

  Options:
   -h, --help   print this help message
   -a, --actions ACTIONS   run non-interactively

  Actions:
    1    display unconditional AVTAB
    2    display conditional AVTAB (entirely)
    3    display conditional AVTAB (only ENABLED rules)
    4    display conditional AVTAB (only DISABLED rules)
    5    display booleans
    6    display conditional expressions
    8    display role transitions
    c    display policy capabilities
    C    display classes
    u    display users
    r    display roles
    t    display types
    a    display type attributes
    p    display the list of permissive types
    U    display unknown handling setting
    F    display filename_trans rules

  With the patch:

  Actions:
    1    display unconditional AVTAB
    2    display conditional AVTAB (entirely)
    3    display conditional AVTAB (only ENABLED rules)
    4    display conditional AVTAB (only DISABLED rules)
    5    display booleans
    6    display conditional expressions
    7    change a boolean value
    8    display role transitions
    c    display policy capabilities
    C    display classes
    u    display users
    r    display roles
    t    display types
    a    display type attributes
    p    display the list of permissive types
    U    display unknown handling setting
    F    display filename_trans rules
    f    set output file
    m    display menu
    q    quit

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 checkpolicy/test/dismod.c | 3 +--
 checkpolicy/test/dispol.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 4868190f..ed5aaa45 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -106,8 +106,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 	puts("");
 	puts("Actions:");
 	for (unsigned int i = 0; commands[i].meta != EOL; i++) {
-		if (commands[i].meta == HEADER
-		    || commands[i].meta & NOOPT)
+		if (!(commands[i].meta & CMD))
 			continue;
 		printf("  %c    %s\n", commands[i].cmd, commands[i].desc);
 	}
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 3f80c1a2..c3339b88 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -79,8 +79,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 	puts("");
 	puts("Actions:");
 	for (unsigned int i = 0; commands[i].meta != EOL; i++) {
-		if (commands[i].meta == HEADER
-		    || commands[i].meta & NOOPT)
+		if (!(commands[i].meta & CMD))
 			continue;
 		printf("  %c    %s\n", commands[i].cmd, commands[i].desc);
 	}
-- 
2.53.0

