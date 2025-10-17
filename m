Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932852D24B6
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713736; cv=none; b=HTT+2Wqpknlw+ax4H6Kaq541Z/18MVdlarORlLbTxPiOVVIfZmW41N2GY2Oot0g67zOEmT/7IFUfQqF1+sjfBZ8UMgM+DRUZmiDFVh+WUK/R4e+651r6vDal6AmFWg4DDIbp78Z60DbkjaId77d6xZEg4cQrAh4FJzOZcrpwfU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713736; c=relaxed/simple;
	bh=cDj7hhnRmAjsPYrvQradtvQUYwigGmL0U9OoRmPeJ3o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nL5kKJtHZ3HWf+wrnWl4WGzhu+7MJyaQzgB/Gn1FExlausaQS1+97rp1/Af0LyF7YjFLEe9HnCn5l4B7UlVQbUfw6W8/LWcE7qyeaILKM291YS8gOk+ZzZaLW+d0T7jra3NRCgWaJCo/thn+enQRwNyITJ04Z85Ji2c5OF9DbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IvvZSBrE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvvZSBrE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760713733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9Ycd8mazgmep3R9PWYA/lSmCqW/jSfzSICL1vR/LZ0=;
	b=IvvZSBrEbivV+AVBkD0H6g3TtF/YdUGKvN3NCPrDJx+QiNsShtj0nK5Y9IbDIBLECtAKdg
	iqbfCSLj7FjV/2M8B4ofGV4qq/r8CP5UqAaE8zaqWqFHS3Ff/3/4PZYR5GekyhPuH6p293
	l02FGSx/xYs5Lvkptsi12IDnCl6L8PY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-1csQ0XC0ORO9zfjIOxy6uw-1; Fri,
 17 Oct 2025 11:08:52 -0400
X-MC-Unique: 1csQ0XC0ORO9zfjIOxy6uw-1
X-Mimecast-MFC-AGG-ID: 1csQ0XC0ORO9zfjIOxy6uw_1760713731
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78BFA1956095
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 15:08:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3DDF19560B2
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 15:08:50 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2] libselinux: Ignore files removed during relabeling
Date: Fri, 17 Oct 2025 17:08:34 +0200
Message-ID: <20251017150847.580771-1-vmojzis@redhat.com>
In-Reply-To: <CAEjxPJ7UE2vtCBNwDphKO1SPC88vbTHCyq+ENhvZe1Tea2hCGA@mail.gmail.com>
References: <CAEjxPJ7UE2vtCBNwDphKO1SPC88vbTHCyq+ENhvZe1Tea2hCGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In case ignore_noent is specified, ignore files removed during
relabeling (race condition between folder read, file read and label
set).

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libselinux/src/selinux_restorecon.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 39eabeb9..681c69db 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -726,6 +726,9 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 			    pathname, newcon);
 
 	if (lgetfilecon_raw(pathname, &curcon) < 0) {
+		/* Ignore files removed during relabeling if ignore_noent is set */
+		if (flags->ignore_noent && errno == ENOENT)
+			goto out;
 		if (errno != ENODATA)
 			goto err;
 
@@ -765,8 +768,14 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		}
 
 		if (!flags->nochange) {
-			if (lsetfilecon(pathname, newcon) < 0)
-				goto err;
+			if (lsetfilecon(pathname, newcon) < 0) {
+				/* Ignore files removed during relabeling if ignore_noent is set */
+				if (flags->ignore_noent && errno == ENOENT)
+					goto out;
+				else
+					goto err;
+			}
+
 			updated = true;
 		}
 
@@ -932,9 +941,10 @@ loop_body:
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

