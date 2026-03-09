Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0628469F
	for <selinux@vger.kernel.org>; Mon,  9 Mar 2026 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075281; cv=none; b=vFhji805SGjsFJYU3PP1mPL8wXUw5m9DkXF+4MKsnqMO4ajfVhsEIyexmMoqRut7cpxA7RsGWEH02IqCnX77GFb0IgM7dxLY7naPVtP2tF6U8cKWltxxDINcenjVrLaJ0Ls4RVVnw2yJjpG4N6sJbMyOsHFQ712iPb28iAv26t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075281; c=relaxed/simple;
	bh=1MBAwze0BAD9B7th6kXsWuVPAQiZjk9T1KgShsV5zzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=mdvtrHYO8voO4N1lZm/l9pRb+OTt4UQXeTrhwO0//1I7SExunSlgB1FX5XAWK9EXuGHgIJjFK+iyNw4pYytpCQPhWmhei+d/1GdhEFeTHwzILPzadYMW+aBAIvN7mPCLzE1hU4X7ErxmAhokACrFk5138G84SNypAihIQlq7V9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFmJbzq8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFmJbzq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773075278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y75q95TV1mKZ4tmai4RaRLFAdivze7pjmMmw/C1+qBs=;
	b=EFmJbzq8SL1uwQ7ukxUCqg0mqRqOoN1pnGkEZOgj31WHYGppLrjGZzaTQYae/4ENDK50B1
	SPZ/9DRG7l8brc3P9JHVM2KSFWws/1rJQLVfD2qPpRbtoe20OyGhqFb/jBJ9/RXwUQdYFO
	RQWqMGq8eAlqq1yoio6dzt8A0RczAy0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-qvg-FdLHNPaSajZnZVAX_Q-1; Mon,
 09 Mar 2026 12:54:37 -0400
X-MC-Unique: qvg-FdLHNPaSajZnZVAX_Q-1
X-Mimecast-MFC-AGG-ID: qvg-FdLHNPaSajZnZVAX_Q_1773075276
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAC3C19560AD
	for <selinux@vger.kernel.org>; Mon,  9 Mar 2026 16:54:36 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.108])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 967E61956095;
	Mon,  9 Mar 2026 16:54:35 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2] semanage-fcontext(8): improve -e documentation
Date: Mon,  9 Mar 2026 17:54:26 +0100
Message-ID: <20260309165432.3137132-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Document that substitution based on another substitution does not work
in semanage-fcontext(8) man page

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/semanage/semanage-fcontext.8 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semanage-fcontext.8
index a29b74994763..b037491e3394 100644
--- a/python/semanage/semanage-fcontext.8
+++ b/python/semanage/semanage-fcontext.8
@@ -67,7 +67,7 @@ Extract customizable commands, for use within a transaction
 Remove all local customizations
 .TP
 .I   \-e TARGET_PATH, \-\-equal TARGET_PATH
-Substitute FILE_SPEC with TARGET_PATH for file label lookup. This is used with fcontext. Requires source and target path arguments to be path prefixes and does not support regular expressions. The context labeling for the target subtree is made equivalent to that defined for the source.
+Substitute FILE_SPEC with TARGET_PATH for file label lookup. This is used with fcontext. Requires source and target path arguments to be path prefixes and does not support regular expressions. The context labeling for the target subtree is made equivalent to that defined for the source. Note that substitution based on another substitution does not work.
 .TP
 .I   \-f [{a,f,d,c,b,s,l,p}], \-\-ftype [{a,f,d,c,b,s,l,p}]
 File Type. This is used with fcontext. Requires a file type as shown in the mode field by ls, e.g. use 'd' to match only directories or 'f' to match only regular files. The following file type options can be passed: f (regular file),d (directory),c (character device), b (block device),s (socket),l (symbolic link),p (named pipe).  If you do not specify a file type, the file type will default to "all files".
@@ -94,6 +94,10 @@ i.e. label everything under /home1 the same way /home is labeled
 # semanage fcontext \-a \-e /home /home1
 # restorecon \-R \-v /home1
 
+If you substitute /home2 with /home1 from the example above it will not work. You must use direct substitution
+# semanage fcontext \-a \-e /home /home2
+# restorecon \-R \-v /home2
+
 For home directories under top level directory, for example /disk6/home,
 execute the following commands.
 # semanage fcontext \-a \-t home_root_t "/disk6"
-- 
2.53.0

