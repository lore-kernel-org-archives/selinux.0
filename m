Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AFF32F76E
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837951; cv=none; b=GNdSWAqd5GBlrULz1mOwcWuCUgj3+pQGMneyfemVTWDsz78J7nGVre+A13WzBc28zqyojtfapnmSBaXiAU2Y/HeOhhI6Bww1o72QYM4fKGDBnXOgq9Ju9zUVF/XFGyZYYkeYGc31IYtd/VW6HbO4MeO4sPyjT238fzIX8QLxHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837951; c=relaxed/simple;
	bh=ReXvQXZY+Tj/wFriSzpHdP7ohU4lrBaRK9wXKpOSbmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=QmpMcANQ3zjXm1tpiXKcrNLwXf8YRqH4791xN9qsrY3Wbc7DbFWwcggtgM2DfJP8IAx1AVU5b7RkP3O99U0k4CNi8ff1hjMEVNjwjTZCtZgOJAlCkRVfPR4umrPW2yBzCeeFSuaXCjKmLMoCTtIda9ZGCOIDwWRMdKeq/MS7at8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5MoeNai; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5MoeNai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756837949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tgHzdQODxJABNt2SinkcPzxtHFPfJtUO+pg+8zIawKY=;
	b=Q5MoeNaiukYm+lBbQDv6hQVFyylCIMzLxEG3DMyKJOfI6G+ZlI4Dm9M3QISIvOY/V/Wj3y
	fOAcF+IO2Mc51Fvvqwxj4vuTEHIv4dYTyq+wxb+uG4dbzNbEBDgBJ/SeKbrJCyuVZ95VI+
	CZpLxsvwd87CHqAN+ajbH6QoncPklt0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-rdkZa0npMiS7aDUZj7IAmg-1; Tue,
 02 Sep 2025 14:32:27 -0400
X-MC-Unique: rdkZa0npMiS7aDUZj7IAmg-1
X-Mimecast-MFC-AGG-ID: rdkZa0npMiS7aDUZj7IAmg_1756837947
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 191EA1800357
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 18:32:27 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABF3A1956086;
	Tue,  2 Sep 2025 18:32:25 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] Add simple github PR template
Date: Tue,  2 Sep 2025 20:32:11 +0200
Message-ID: <20250902183221.119333-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Users tend to open pull request without notice that patches should be
sent to selinux@vger.kernel.org

This template should give them a basic hint how to send patches for
review directly when they open a new PR.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 .github/pull_request_template.md | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 .github/pull_request_template.md

diff --git a/.github/pull_request_template.md b/.github/pull_request_template.md
new file mode 100644
index 000000000000..ae790a128d15
--- /dev/null
+++ b/.github/pull_request_template.md
@@ -0,0 +1,15 @@
+Please read [CONTRIBUTING.md](https://github.com/SELinuxProject/selinux/blob/main/CONTRIBUTING.md)
+
+## Contributing Code
+
+Post the patch for the review to the
+[SELinux mailing list](https://lore.kernel.org/selinux) at
+[selinux@vger.kernel.org](mailto:selinux@vger.kernel.org).
+
+When preparing patches, please follow these guidelines:
+
+-   Patches should apply with git am
+-   Must apply against HEAD of the main branch
+-   Separate large patches into logical patches
+-   Patch descriptions must end with your "Signed-off-by" line. This means your
+    code meets the Developer's certificate of origin, see below.
-- 
2.51.0

