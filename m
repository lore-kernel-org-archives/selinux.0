Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CB32416AF
	for <selinux@vger.kernel.org>; Wed, 15 Jan 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946821; cv=none; b=SLNR5CHCZInqHCp+krUzFf/cEdSaNJhQmLWrorp+ZqrXHfB9h7Skiznk20e296mjCioKE5YJfCNySELeAZP8ooaFyQqZQtnZfiZlfczcotyE2fExcK7PtOcwEaFLwToJSccMuiZJYcwbk4zHpD69/bUG/BDJA7q3DAJYivbbyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946821; c=relaxed/simple;
	bh=iyixNWBydYdvp330mftH/LYLHaZf5D2eBIxjhEE1ro0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k38z0hMa5Dx9oqnkFU/BfgpiswitlGY/Lj4WBLAo9KhKkzMHSZ3R0VKV7UO6EnMP0CmwL/AwZgKLQs4iMpT/DDmgWl5FhHt1P5SWpIdUgxZ4v1C4CkZ0cjNIN91JjcArydqvFnK6bvdoUbik8EyWehBXnGTOqE4y8IKdeDxs4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=W5xrn09P; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="W5xrn09P"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736946816;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lNHOagk1m7tA1z4To+jxHEgYaVZcYonCgFX5zlmE5Q=;
	b=W5xrn09P0nsvxhQCFvLTP+0a/1rBt+0Lm9d9AqC+cgW8H18MaLEDfIwKVqyGMl+zCeXkpv
	emXE5BWg6VSKtwiabr8xF8v2YXayH7jr4yGH6AsVUIJo+kMvIrMCrYQ+8E9kmFpcEvoiJ2
	9GRA5aDM367fW+cbJSo2uKqcZdxjyA0yYCkCAqB4HRS8GVAoOXSK0C15pO/I2ELifEwz2m
	qtA1ik9LW59dR0KpwoMroBIy6ioVDOSVFDAB7jw9GIrX1Vq+YGZxAJBcHkBFcQO77T9KRC
	HIZAA/kLT7l/MYIUrJNzjETJHt9bHEOEbB6beetdigKWWoDg55QdKVmJXLWOvg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/5] libselinux: set errno in failure case
Date: Wed, 15 Jan 2025 14:13:29 +0100
Message-ID: <20250115131329.132477-5-cgoettsche@seltendoof.de>
In-Reply-To: <20250115131329.132477-1-cgoettsche@seltendoof.de>
References: <20250115131329.132477-1-cgoettsche@seltendoof.de>
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

In case an entry read from a textual fcontext definition is too long set
errno and the error string accordingly.

Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
Reported-by: oss-fuzz (issue 389974971)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_support.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 978ba828..57e191c8 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -45,8 +45,11 @@ static inline int read_spec_entry(char **entry, const char **ptr, size_t *len, c
 	}
 
 	if (*len) {
-		if (*len >= UINT16_MAX)
+		if (*len >= UINT16_MAX) {
+			errno = EINVAL;
+			*errbuf = "Spec entry too long";
 			return -1;
+		}
 
 		*entry = strndup(tmp_buf, *len);
 		if (!*entry)
-- 
2.47.1

