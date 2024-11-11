Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BABD14A62B
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328395; cv=none; b=EMhbILE7cwMG2JEMSgyWqk/xjcNER3X5Q4rk8IpMdkUKt5fPMqKcMbKL5nQkgu+s8iXZp0qi+E4Ym7j4NtZkBbXxDSv+N/d4mfnQwqYftwPfmvCU1v+0qFJlL1a5Ekrj2dHnPk+qx24vGJN4ePhOqn17sMcx1SHllkJCTdkWA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328395; c=relaxed/simple;
	bh=JGM0EvycVzegrFm5k62F0NEGaTSBkNP9B2QrvYS2AUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=OY+5Ethq/Z/xBdbu2l/fSftX7GX81NqZA31qMjEEf7mz3+/hS7oVnj+DxYWPFcq1OvOhwdzL8S3zywa103B94avaVbLz5AzR9mouNVJO6gO3ZZhqcPge74jqfbWqVNMGGwSU3AHx1FOWz90MamhRN/RBZRGHT9GiJOMOKEU/qsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aAH5mcqA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAH5mcqA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731328391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0US39sEzAWT5LffmpGwpOJTN950TperuhFIcvD7+NIY=;
	b=aAH5mcqAcuZD5DgaSGkUmbUT2xuVYgFbomaPjQHa+b3bXcuE6SKWFuwlVRkxumSTTcbimI
	PDqLwwYQXbOtqm1b11rqHW/WBYbDdczFjRSNc1SV3S46RwHvfF0f68bbDUcLx9XZGxhBsl
	LRbgfY3BsmhHoN8BK3GlYyCjeg0ydTk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-h9YXWji5MUCC9a3_SMg5kQ-1; Mon,
 11 Nov 2024 07:33:10 -0500
X-MC-Unique: h9YXWji5MUCC9a3_SMg5kQ-1
X-Mimecast-MFC-AGG-ID: h9YXWji5MUCC9a3_SMg5kQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C719B1956088
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 12:33:09 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.225.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C93119560A3;
	Mon, 11 Nov 2024 12:33:08 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] libsemanage: open lock_file with O_RDWR
Date: Mon, 11 Nov 2024 13:32:50 +0100
Message-ID: <20241111123304.651436-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

man 2 flock:
    Since Linux 2.6.12, NFS clients support flock() locks by emulating
    them as fcntl(2) byte-range locks on the entire file.  This means
    that fcntl(2) and  flock()  locks  do  interact with one another
    over NFS.  It also means that in order to place an exclusive lock,
    the file must be opened for writing.

Fixes:
    # semanage fcontext -d -e /home /tmp/testdir
    libsemanage.semanage_get_lock: Error obtaining direct transaction lock at /var/lib/selinux/targeted/semanage.trans.LOCK. (Bad file descriptor).
    OSError: Bad file descriptor

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 libsemanage/src/semanage_store.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 0ac2e5b2ad39..c26f5667b3cd 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1899,14 +1899,12 @@ static int semanage_get_lock(semanage_handle_t * sh,
 	struct timeval origtime, curtime;
 	int got_lock = 0;
 
-	if ((fd = open(lock_file, O_RDONLY)) == -1) {
-		if ((fd =
-		     open(lock_file, O_RDWR | O_CREAT | O_TRUNC,
-			  S_IRUSR | S_IWUSR)) == -1) {
-			ERR(sh, "Could not open direct %s at %s.", lock_name,
-			    lock_file);
-			return -1;
-		}
+	if ((fd =
+	     open(lock_file, O_RDWR | O_CREAT | O_TRUNC,
+		  S_IRUSR | S_IWUSR)) == -1) {
+		ERR(sh, "Could not open direct %s at %s.", lock_name,
+		    lock_file);
+		return -1;
 	}
 	if (fcntl(fd, F_SETFD, FD_CLOEXEC) < 0) {
 		ERR(sh, "Could not set close-on-exec for %s at %s.", lock_name,
-- 
2.47.0

