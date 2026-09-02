Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE144E66A
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349129; cv=none; b=hyDT/FWkmx1p7s3QIizfFaSLooec1uG62294YxhVg+COfRLWkXOyEjav4FTbjBLU7ZmdKeXglRAiZy2rGnUTzC8dMYFLO4UBCRcay0nCNkOCpEsns2lIzHFbyTEjjrS6oBzPCYqr50ImRMlcMMGjTYCNS8WK/KvE83zPCsA0ZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349129; c=relaxed/simple;
	bh=fbhv6+EZ8di8BFytXjTOin7xbSPIG2iGzaMg9XkfIek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ucHhVJYDssXQevU5nokaGibCTF5t12p5u5DG2aNnxM7ySC9liZirGfm9iIX0YMM0SXOWvOI4i1meX/D2qr0I7Qp9A7K7j1bMJYG1ENzNLX+SomJp8H4ijou0+PAOiKRtTGoXTIIKejshyiQ8frU8meDvOhjGPmxbrFI1s2rEQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rr29lPAc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rr29lPAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788349123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jb+iIGEGud/6xnXNCu2Ozy9CFJlFeq48gQ19fSIlzLE=;
	b=Rr29lPAcgvloY2iQEWVOe0wvxXHmbvB9IHK5dcUiCEOxiqBfymaH6hHveZjQWMmip8wJ07
	eBx6TD7hhOudwdpHZZ/gZagp4Up4/alCzdlG3eVO+9rYJusNkXzZon61KGtX1O2qieLn3l
	06AaYCXJiky1f62yEBPgTOoraFi+218=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-Jly5Mw4MOuS_tqKTdcAGyA-1; Wed,
 02 Sept 2026 07:38:42 -0400
X-MC-Unique: Jly5Mw4MOuS_tqKTdcAGyA-1
X-Mimecast-MFC-AGG-ID: Jly5Mw4MOuS_tqKTdcAGyA_1788349121
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A496180264B
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 11:38:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.236])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8125E1956044
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 11:38:40 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libsemanage/genhomedircon: reject users with a relative home directory
Date: Wed,  2 Sep 2026 13:38:29 +0200
Message-ID: <20260902113834.2886601-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If a user's home directory in the password database is empty or
otherwise does not start with "/" (e.g. because of a broken NSS lookup
or a malformed passwd entry), the HOME_DIR template ends up being turned
into a regular expression such as "/.+", which matches any path on the
filesystem. This causes genhomedircon to generate a file context that
relabels far more of the filesystem than intended. Skip such users
instead of using their home directory to build the regex.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/genhomedircon.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index f04fc127..2717712c 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1110,6 +1110,17 @@ retry:
 		pwent->pw_dir[len] = '\0';
 	}
 
+	if (pwent->pw_dir[0] != '/') {
+		/* an empty (or otherwise relative) home directory would
+		 * turn the HOME_DIR template into a regex that matches
+		 * everything, e.g. "/.+", so refuse to use it */
+		WARN(s->h_semanage,
+		     "user %s has an invalid home directory \"%s\", ignoring",
+		     name, pwent->pw_dir);
+		retval = STATUS_SUCCESS;
+		goto cleanup;
+	}
+
 	if (strcmp(pwent->pw_dir, "/") == 0) {
 		/* don't relabel / genhomdircon checked to see if root
 		 * was the user and if so, set his home directory to
-- 
2.53.0

