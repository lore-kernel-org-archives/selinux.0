Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C683203B0
	for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787159; cv=none; b=GvpL+witVXgxGVW6uFd625gP5OiercTCPmgf+u2ui872Qb12CslxTX8JTeSAbyEC0WZq/fYHABDDFsKtrbDp0bH7euPWmxCPL5IiHFSi/MPNWKvgXghXiCre5q4XAyId25AXWUj1JKuu+RYbX0/gK1AneIQNUVQk99mABjZV7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787159; c=relaxed/simple;
	bh=YawMaE+KqfBxH/LrkO3L7kf37UqskISH1mmawiyzlrg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PceVPFNJZzVd/7npUUFFmoi61/oul2eyrryp31KxM5cDvzpxXzd3DU7X/1hPWuuZGRNt89m365qD8zzrzP81cOakhtN84N4j3roEibnpQnJkIicF53H1Gt3bkX7ZN9RlZurpHsJEu4n79wrHegcGxNCGfsYVEhg1gvpOvjAwfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rj1XqWOK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rj1XqWOK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769787156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z3Pyv7V+0IOVgAMVJGRLEVLdoF87d+J/1shIMCQ09q0=;
	b=Rj1XqWOKowweUNzWc7Pme78oSfv2ct8l1QDTTuSBO9qEYoBh8vTto9N2QUYrfs3Hotp8OE
	iHWnWZ6/4YdXnbLaGBCaWh07D6jZnjR3wjaYtIQL+usQUJJhZ1xDNt7KH3Qw0ZnigddQvN
	4T1e3iOMzOznYDiDBcrw7sH5N5VdTx4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-DYCgEjnEM9aZ5OddBzz2Mg-1; Fri,
 30 Jan 2026 10:32:34 -0500
X-MC-Unique: DYCgEjnEM9aZ5OddBzz2Mg-1
X-Mimecast-MFC-AGG-ID: DYCgEjnEM9aZ5OddBzz2Mg_1769787153
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A91FA1954B06
	for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 15:32:33 +0000 (UTC)
Received: from fedora.tail22866f.ts.net (unknown [10.45.226.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD3F31800665
	for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 15:32:32 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libselinux: Ignore directories removed during relabeling
Date: Fri, 30 Jan 2026 16:32:10 +0100
Message-ID: <20260130153229.2422340-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Extend 54c79a74f5b9154762abaadf8194665598b24115 to directories, since
users will expect them to be ignored as well.

In case ignore_noent is specified, ignore directories removed during
relabeling (race condition between directory read and removal after
parent directory read).

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libselinux/src/selinux_restorecon.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 681c69db..2e605b5a 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -932,9 +932,10 @@ loop_body:
 		case FTS_DNR:
 			error = errno;
 			errno = ftsent->fts_errno;
-			selinux_log(SELINUX_ERROR,
-				    "Could not read %s: %m.\n",
-				    ftsent->fts_path);
+			if (!state->flags.ignore_noent || errno != ENOENT)
+				selinux_log(SELINUX_ERROR,
+					    "Could not read %s: %m.\n",
+					    ftsent->fts_path);
 			errno = error;
 			fts_set(fts, ftsent, FTS_SKIP);
 			continue;
-- 
2.52.0

