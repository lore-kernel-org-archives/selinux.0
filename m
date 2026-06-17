Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24C379ED6
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722561; cv=none; b=exVvDJAWmQvCkfVAHJthKiBVJU7s3p5SZYSOgiuYcG2ZMKrorRC6o4H8GmH96+A0XCS7r9JEoJUyaGaM2I47mU7JeEEcDrffLCQmnD59kkXZ0zpZ/ssR7hw1u+UHmdHCCurqE06GsIpKhGAaMUcuORK+NmKE1XFnrqndHPdBl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722561; c=relaxed/simple;
	bh=QVAgqfKLOX2/SnIEYvU7+mB7lr6y23H46omo/3/gg0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dWfSonBVLFI+oSpKYP0m2SS2QX43xeOISRskWjImtUX5gzGVUHw/rRENJJ6Q2/QLB67yeCcNNdHq981jBlHev0W89s/2h0IUbbLTriZUAyNcumcWSRbuyPFR52cQFzlC+nrl4vn205iaitpuI3JlhvIA0aWDjyeP1gWYxR+Anr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnwnkxOI; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnwnkxOI"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176465a4a4so1036091cf.2
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781722559; x=1782327359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyWhkgkf5ojcrSqJHPG7D+oOfBoBLyKx3p3LNrTvDsQ=;
        b=OnwnkxOI6pLT+ejHgdeHZmbdF/fZQ9VZ/ZKwr4+UvjJSuHQ9hGOBWSY5xCgNMi6JQn
         w0jUpzcnZVAMtE+woIomkPMCRrzypoWbThRT8V6LstRkev3UpeVHgjNt59uWH1hjbk0u
         e4l6mM6p/xOyq50biNeSthpCwbwSzz7KoA2wN6viG/lWxJPZz8doAplOejqp/XcSXvbb
         RgnDJTr62Vinm7f4FxS7mkp4pnrPkdUVn+CqrJBu0KaCht4Kipr1SQNE/qM8W8zzHFEU
         kFP3e5/lrT4QWr+mN2ztwwdHHnCaAiLvN12yA0CcLmTSRKMh09n9DGVRpJUjCnHi4xkL
         bMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781722559; x=1782327359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyWhkgkf5ojcrSqJHPG7D+oOfBoBLyKx3p3LNrTvDsQ=;
        b=mjYzKORX6X10zPLq2RuQ5tncN0LMUZr3OEXN+FiB2Qf469RXSEddap1ArjOvL9MYzc
         JYNVwTJNbqZv6nN0OhIoeIyRakiuQTbdV7V4BTrUdrbpCey8KEFNrKUoiKqsPrNNfOqE
         XkrpIJvgrChEOdQKS8H5JwaPWHsVI8ERsjukmgG7mLO1WXKDwBw85GDQ7V5SBNG9ONGt
         btHm57mKqFf4JAsJKvToMVD/9r3N8OrgMZonzBIa7q0yZ9Au8CyAD6cZnS0A+zY1B4Cv
         LfmCXhyLBqK3eiJ/VOu8xJxw0F4VKTHHqC7VxD76av1Ob6UmKUu697y7IW2sdCbD02j5
         ow/w==
X-Gm-Message-State: AOJu0Yw7hrrYnb328sAYeVrKi6f+KSTFe/YX/vVLG/k38Jdcq4LO9fOq
	mmsGGaQub/lZMahLCoZx+1TSedNMFmfuRzLR5kJ9Avb0kOzsFoK7LD6cfBg+cg==
X-Gm-Gg: Acq92OGz4ClC9kABJldZ29iFArft+0Pz6NkAB7lniBti8FSTAhvVQsnb+RE36NWRrXv
	/Pk8e9HSKwNP7K+ffCa3sAshNtp/cXciX464gxqJZi16Ro/tSgPL31S6sqt0p0cqBFzoRgQFJTW
	ybEqfsUCuG2K6B8kFj3s04A+RXtehMvJtKdD8W5n3wmbBzrQnR7MiQ0jqddkqCUhYL0cdJqcGam
	lEZRJtbigAr6JfxFBkbowNQN5jhUeY8j8/KN+Jx9ictjqV0hn4rjzkuxEbJz6MVQGkPoNcQ7BeF
	4OB8NtZarEmjBvJCqX0yTJLfTYKa8KeusfgH+NX1YUV3IVFztVKCL9IKhft7wsU8vtEFRSV6mYn
	1/IHuw9BhCSAqzhPyfQDeGJhBc5dFMa45IT6sK52/ypsHr4Ij+e6mDQTgIEi+DzfjgEOxyq67eI
	0o7KUF4+B+l5T/a0UgoMCwKo5uEWYAskrZpbo=
X-Received: by 2002:a05:622a:180a:b0:517:8fb6:56b1 with SMTP id d75a77b69052e-519c6d15e35mr5585021cf.17.1781722558836;
        Wed, 17 Jun 2026 11:55:58 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7dacdfsm182953451cf.20.2026.06.17.11.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:55:58 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/4] libselinux: Add checks when growing lists to prevent wrapping
Date: Wed, 17 Jun 2026 14:55:40 -0400
Message-ID: <20260617185543.91749-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common idiom to grow a list or buffer is to use "len *= 2", but
it is possible for the multiplication to wrap on overflow. This
would result in the new len being smaller than the old len and
could lead to problems.

Add checks to prevent doing the multiplication if it would wrap.
The multiplication can always be done if len <= MAX / 2 and
should not be done if len > MAX / 2.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/matchpathcon.c | 4 ++++
 libselinux/src/seusers.c      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 2623e5dc..dc276b7b 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -117,6 +117,10 @@ static int add_array_elt(char *con)
 	char **tmp;
 	if (con_array_size) {
 		while (con_array_used >= con_array_size) {
+			if (con_array_size > INT_MAX / 2) {
+				free_array_elts();
+				return -1;
+			}
 			con_array_size *= 2;
 			tmp = (char **)reallocarray(con_array, con_array_size,
 						    sizeof(char *));
diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
index e4a844df..08514bd6 100644
--- a/libselinux/src/seusers.c
+++ b/libselinux/src/seusers.c
@@ -114,7 +114,7 @@ static gid_t get_default_gid(const char *name)
 			break;
 
 		rc = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-		if (rc == ERANGE && rbuflen < LONG_MAX / 2) {
+		if (rc == ERANGE && rbuflen <= LONG_MAX / 2) {
 			free(rbuf);
 			rbuflen *= 2;
 			continue;
-- 
2.54.0

