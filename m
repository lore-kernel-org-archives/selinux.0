Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870CA548EC
	for <selinux@vger.kernel.org>; Mon, 29 Apr 2024 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408299; cv=none; b=uVLCii98vWyxn7D2U6nWMn9ogKtvUrBXh/oagAy/OSDQhHJhRvNll9IlWljFfkpeEfSXKf9vkZFHfo+mfpUjMSnEG2oR6Cgoj1eWYIzLnhqeGS0YyK9oSI25EpBXLyejIkpRZLetAUbNd+b/RH1nAu9FdVwHlSk03HB8cyVGgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408299; c=relaxed/simple;
	bh=W+cSSzuBYlc8eO5ZzVm/xIkknQqC3v81HqO4SqkIQyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmWZVo2qQSFnFDeeer7x4Xg2YhESD/oi780V64yWYvVVNjHftWv/oKHMli9m89bJnQnM0tvrAkTKIigXMCM8Nl6mOBsW4tajmmEZHzfQE2sQZR0jydp13GMhS0kbogiB9Xe7xnRgU7biriKN+wdd+WtcRgrq5c4uxn8JnKW5L+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=N7bgGvm+; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="N7bgGvm+"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1714408287;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEx8KhJiTbJDB7GlODof8TZc2nBqt4YunESv2bgsXRw=;
	b=N7bgGvm+nJCaJJJWZUq/W2fg3bt9xCrGyZt+C/DyLl8KTLTfS68IsnOoRXeJG7/owsrqj3
	Oss2NVjWR/Lmvqkomm+JcQskPP3dzwWF7tpgdqA8GYzqMjmdXaMPjUb6Cc7uIJkvM11WYb
	wSxy8d34xlZ3TEzV0zdSc3kT8mkcJuN0ZMHs9YlpgcHNA3ZL1wCTUxoBpK26dtS2zPhlDp
	e+x7KcIkVXyQT2FEeThYCFbUkcE0nj7byAnJ/UV3uPj1WPawhyv/yDy1NCHVPc/U3r7bwg
	lj19FnvsNOfsPPlXRwrtKauuYvO8k21sRxmzwToF5zejgFX1aWJO6E+xuUfwKg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 5/5] libselinux: constify selinux_set_mapping(3) parameter
Date: Mon, 29 Apr 2024 18:31:21 +0200
Message-ID: <20240429163122.63181-5-cgoettsche@seltendoof.de>
In-Reply-To: <20240429163122.63181-1-cgoettsche@seltendoof.de>
References: <20240429163122.63181-1-cgoettsche@seltendoof.de>
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

The map parameter of selinux_set_mapping(3) is only read from and not
modified, thus declare it const.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/selinux.h      | 2 +-
 libselinux/man/man3/selinux_set_mapping.3 | 2 +-
 libselinux/src/mapping.c                  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 83ea871c..61c1422b 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -413,7 +413,7 @@ struct security_class_mapping {
  * starting at 1, and have one security_class_mapping structure entry
  * per define.
  */
-extern int selinux_set_mapping(struct security_class_mapping *map);
+extern int selinux_set_mapping(const struct security_class_mapping *map);
 
 /* Common helpers */
 
diff --git a/libselinux/man/man3/selinux_set_mapping.3 b/libselinux/man/man3/selinux_set_mapping.3
index a1f82e5a..bb48eb43 100644
--- a/libselinux/man/man3/selinux_set_mapping.3
+++ b/libselinux/man/man3/selinux_set_mapping.3
@@ -15,7 +15,7 @@ struct security_class_mapping {
 };
 .fi
 .sp
-.BI "int selinux_set_mapping(struct security_class_mapping *" map ");"
+.BI "int selinux_set_mapping(const struct security_class_mapping *" map ");"
 .
 .SH "DESCRIPTION"
 .BR selinux_set_mapping ()
diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
index dd2f1039..d863e449 100644
--- a/libselinux/src/mapping.c
+++ b/libselinux/src/mapping.c
@@ -31,7 +31,7 @@ static security_class_t current_mapping_size = 0;
  */
 
 int
-selinux_set_mapping(struct security_class_mapping *map)
+selinux_set_mapping(const struct security_class_mapping *map)
 {
 	size_t size = sizeof(struct selinux_mapping);
 	security_class_t i, j;
@@ -64,7 +64,7 @@ selinux_set_mapping(struct security_class_mapping *map)
 	/* Store the raw class and permission values */
 	j = 0;
 	while (map[j].name) {
-		struct security_class_mapping *p_in = map + (j++);
+		const struct security_class_mapping *p_in = map + (j++);
 		struct selinux_mapping *p_out = current_mapping + j;
 
 		p_out->value = string_to_security_class(p_in->name);
-- 
2.43.0

