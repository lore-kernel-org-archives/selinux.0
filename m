Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421B217722
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638180; cv=none; b=PbN3cvuAbGUNwPpvkTbZiAcLKWq/ECnfkQfSVMtW45xC9i0xVYCjpf/JBv8wOzCt2uAymzMd/oKDO353AASZiqFIsMxo/Xohn057Qz8Mt5F+gmfNimFcxnFR1qLOhsxePVmbFSift8Sp1RPQvcK5opPSCRZ8I95O321a20jE+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638180; c=relaxed/simple;
	bh=zsYOaeFr2Hyxt89gz7G04HeM7h56ouBWo2fy93/X+aY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=svZYbAYNmVBkF2n9/9hnw6033/BJ2gdp8g0V9FMr19+DKe/3HxMEzX9UA1AdP8eIqJkm97leFUtt6G9+T4w3cdUEncZhafs18shTCmyStwr8nqvStSqMQqpV8DX+ng2DaHSyyg7gGJJmge08vKMETd97hp8DpCurVzyLECNMM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkwYE88s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkwYE88s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760638177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DK8uoAPNnhceWoxbeMRLM8Nks+gU9B/bXBByjMwpB/o=;
	b=LkwYE88sdTCrE4Pou/STUGpm6bWAaAiZloxRFYspUHSrm2nLYZT2lfcxO5TxPQsIMsjQxc
	qi+Q6k7LD8IjGrjzCWPViN5QtslEL6XoXxS3ZMTfgxU/OgexV56k6bybQN3iNABKCMHPzS
	K9WKQk+eLnscl0FYKvjozaS0TGBtHSg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-60lgGsCaNLqisM8Ln6Vy3w-1; Thu,
 16 Oct 2025 14:09:36 -0400
X-MC-Unique: 60lgGsCaNLqisM8Ln6Vy3w-1
X-Mimecast-MFC-AGG-ID: 60lgGsCaNLqisM8Ln6Vy3w_1760638175
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B388D1800744
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 18:09:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D72651956056
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 18:09:34 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libselinux: Ignore files removed during relabeling
Date: Thu, 16 Oct 2025 20:08:37 +0200
Message-ID: <20251016180929.452863-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In case ignore_noent is specified, ignore files removed during
relabeling (race condition between folder read, file read and label
set).

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libselinux/src/selinux_restorecon.c | 30 ++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 39eabeb9..7cad4c8d 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -726,6 +726,14 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 			    pathname, newcon);
 
 	if (lgetfilecon_raw(pathname, &curcon) < 0) {
+		/* Ignore files removed during relabeling if ignore_noent is set */
+		if (flags->ignore_noent && errno == ENOENT){
+			if (flags->verbose)
+				selinux_log(SELINUX_INFO,
+					    "%s removed during relabeling\n",
+					    pathname);
+			goto out;
+		}
 		if (errno != ENODATA)
 			goto err;
 
@@ -765,8 +773,19 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		}
 
 		if (!flags->nochange) {
-			if (lsetfilecon(pathname, newcon) < 0)
-				goto err;
+			if (lsetfilecon(pathname, newcon) < 0){
+				/* Ignore files removed during relabeling if ignore_noent is set */
+				if (flags->ignore_noent && errno == ENOENT){
+					if (flags->verbose)
+						selinux_log(SELINUX_INFO,
+							    "%s removed during relabeling\n",
+							    pathname);
+					goto out;
+				}
+				else
+					goto err;
+			}
+
 			updated = true;
 		}
 
@@ -932,9 +951,10 @@ loop_body:
 		case FTS_NS:
 			error = errno;
 			errno = ftsent->fts_errno;
-			selinux_log(SELINUX_ERROR,
-				    "Could not stat %s: %m.\n",
-				    ftsent->fts_path);
+			if (!state->flags.ignore_noent || errno != ENOENT)
+				selinux_log(SELINUX_ERROR,
+					    "Could not stat %s: %m.\n",
+					    ftsent->fts_path);
 			errno = error;
 			fts_set(fts, ftsent, FTS_SKIP);
 			continue;
-- 
2.51.0

