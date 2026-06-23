Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECF237CD34
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222155; cv=none; b=tpOqu4NmCV1ODPpLyjN6/gwzW7S6gCyMDQmj6KyG9bFd/6E5uJTUelvlTL9XPAMouDtNMoNCjO2lsm1m+OfJrt+mq8iOMrirkwTchV2+CfxS5fA0e+4ZnzjcxYHvTrzNNueoncK7BhXVNuinsLYg2y/wCL370m5nJ0HwWhHY3Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222155; c=relaxed/simple;
	bh=pxqjAWB8B90dR6LdMzqmI3XLU3mlc3YWrzlgW/BKwuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjbDgUNpJwXxx02o3EuC8Ly3YLyL9w/CasYF3i4se24rau2VJN1zM2OLYoYIRvbEK6OD/CnyW4gWE2sHFo1HT2yrH50lbQZRY7W2HgwaWICNlNZ0aSk4IU2hOBy8a8AIi67Ar8wk/NS5tlDkVNSsnOsF7wwsgQ+Iete9PNZREPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Z3/pFqd6; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Z3/pFqd6"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222151;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZ10ddm4gvUBMIIi+GM/xAGVMmXsi9FHjnWhBHQ9zIQ=;
	b=Z3/pFqd6QayLlxZBTfwu0MzihhFC5PC6jV8WJcN9bFEUu7yi7k+D1xfVT8fFwQPLugGXvX
	YsUeIvuDjmW6XCYrl1ZhczG5y7nTBBHaF1Y3mp/iI/z5AQ6jesXkdh8ZJ1V4akuRUhBJLY
	cG8xP10Rj/kXz3i15O0/1fkWfP+sK4iXrhBZLVv9CHon5uLF4cDc+Uy0KNuvcz+frSYbVK
	oM4IUUhoMTQXVbxDj/5oUz5H3yZ1HqvUjDs4ZcN5vJP1qckvkEcGoRQdFNilOCencMaA6F
	9Fs8u95mwDioavEvbHhd9jqd/i+/lp9gQ7XX3B26xLL5hOIHCkBSBTgrC5VavQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 09/24] libselinux: add missing newline to label_db invalid-format warning
Date: Tue, 23 Jun 2026 15:41:58 +0200
Message-ID: <20260623134215.98273-8-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Every other diagnostic in the file ends with '\n'; the invalid-format
warning did not, so it ran into the following output. The longer string
pushes the call past the column limit, so reflow it to satisfy
clang-format.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_db.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index bd22198c..bafa9328 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -108,9 +108,10 @@ static int process_line(const char *path, char *line_buf, unsigned int line_num,
 		       &temp);
 	if (items != 3) {
 		if (items > 0)
-			selinux_log(SELINUX_WARNING,
-				    "%s:  line %u has invalid format, skipped",
-				    path, line_num);
+			selinux_log(
+				SELINUX_WARNING,
+				"%s:  line %u has invalid format, skipped\n",
+				path, line_num);
 		goto skip;
 	}
 
-- 
2.53.0

