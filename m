Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0F4AA401
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451157; cv=none; b=ezIRoSIkPChnbyJrk1DODFCORpjes1TgGVnxu+X3EAlU3csw1zQXwjEWlxuhz7h52yg/mLcRCOhdHk42EYDeUzkOpGLYgNPrinEmYK1u9W1spe9YQ9Isi16mwy0uF5vnUH4Je7TkBHUnB3LJojhvWSqjfGUEwfWv5NYVdejVzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451157; c=relaxed/simple;
	bh=fd4MMwlmSULOgNYzQ7ZD7KO/XIzA2vH5kwqU8JmDJa8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nLbQPQZAv1trTmYA4Tf5RB8kRvSQW4ilb3V8dLBORR3fVX5b2k1hD1m1lqUwi+1NUE2zRSJG7SHjf56PhS+E204R2nHyYpZFktmCVNJPItDgrOzTOfbS9iM9B1zC+H/BHjQwrmuqQRtf7s38dN/p5PolYtTzbxeuKTuUG3rjXwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcqzFMX4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcqzFMX4"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b6031cbc6bso2404992e87.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788451154; x=1789055954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k+STmnpYxGVez5jnS5tz4D2/okYOxzFi+4LsfvlXF7w=;
        b=qcqzFMX4/rBDnHhyqUergcLh9fLYswnBFJbe32oZCMw1dEAqOiV7PrXUPuyl/qKyvW
         mxmL8aEeSGpHBnD/zWSFNdnHRiSGBCzeEYg7PJZuE49jQqVwXS8Jaq9XnBZ3j1P3w6Lr
         9xJxuD0KdcmwSAxGaRPs42Eo7+AMuenySbCyzTHZ0B3Mp5v2gr+/ypgW2C+mo4txK7lN
         FTsbIdviVCV1v7B5HXZt6ZF4gTilp4BltuFjvXm1C8JPPFDMcs2/mkBeGbO2z9t4MObU
         jOiKuMPLkDkiwddlAj0dl1q9ChGokL0d9/ko8BW1ilR52KwQ/CjPbGMmJQSQBDCRn2qT
         /Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451154; x=1789055954;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+STmnpYxGVez5jnS5tz4D2/okYOxzFi+4LsfvlXF7w=;
        b=E2E78SyQCiI4i9BlItdKRPQJPCUwyOlXhdoiagyBzpxZo0dj213+G/8h0dl41YnUkX
         mW9MSbpx9T/QF2g/PUjxy13RwYM0UTHU0391EsfWtqxy8NB/cJk/tMc1S83XfqiC0CEj
         +c5FsnyEOKwNTPka5BS4oAe0B29NkcT1rqTARHEUlBVheWHe1FQehCvoFtKBqOMVyg5r
         K8YDJ4Zx9lrbEo7bxH3JxdtTr2WqY3lYQ9KBxNQPbd3Tt0/MRvgAMZROE1GxXLRat8tZ
         ZeUsAQEy6oUJsWmJ3ILfT1L0e5rfu2D8csVRr7Seed02qxvRhkcnfz7H8he6rMqgZmm1
         DDxQ==
X-Gm-Message-State: AFuF++kDEVRKPNdSuXjSgZDV0gmXPb1ItrXdYo8fbkPlOIf6I3E4Jkk0
	eupfBWkcG5WHv6z3ATDTKo+CE5g1HnFFsBp1QnLcl74O2N+EQDZ7ZTWenCc19BVg
X-Gm-Gg: AYBFou3x0d7BUa/V24X8PmqtiMo/06Up2lhqOXSALozxZvx6paJRvoBEHXUzBygLzrf
	S0OZM9lLg4sY4BkEVISyBi1OiLppzHUk/QYHCTHvFvhkG6ND57hKr0ec98BiiwkTpObZxv3pYoR
	xYMEWzpTIfzdsPSQmvpriRMJHu7UFFIPgD+RRe3Ni1akYf/nF5Wbtu/bX8R940Xbrx0pTHiRLSd
	RnIr0TJl8ZU0zQ6OS09z649LS89ztL6TsSWFQhQKZlDjJl4fAqZlKO7VNKP4c5kK0DpJiX7HJsf
	ssfSZ1CYM4+4vL7CX3Tc/HDm7QFSTBbkQwt3O8dOoME/cgw+d5QrokcRf49cIhaMBrpfp7uNtSF
	CCU7qFFRTpIMVPpURL65grxtjpD8JRCrvSnzwYggCNvBMCaTpddcR7NSIReFO36Vcr8iw/118rN
	voCCWV4ise3p0gPCDlswUNdvWAwlVmdMUoWe85nALKEEbM/PIBQssjlUlC/ceBsMmvOJe4I7ld8
	AWSEIzQFPItJVyfu8JrWZ0Gjf/kuu4rOxaloA==
X-Received: by 2002:a05:600c:620e:b0:499:78b3:7b36 with SMTP id 5b1f17b1804b1-49cf5b9a6d3mr14530465e9.11.1788451119571;
        Thu, 03 Sep 2026 08:58:39 -0700 (PDT)
Received: from omos-acer (109-81-21-204.rct.o2.cz. [109.81.21.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce55259ecsm98242275e9.2.2026.09.03.08.58.38
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:58:38 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH userspace] SECURITY.md: update Ondrej's email address and add GPG fingerprint
Date: Thu,  3 Sep 2026 17:58:37 +0200
Message-ID: <20260903155837.516393-1-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm going to use my personal email for upstream contributions from now
on. Update SECURITY.md to reflect this.

Also add my GPG fingerpint. The key is not yet signed by other patries,
but I've been using it to sign my git commits for a while now. It can be
also found at:
* https://github.com/WOnder93.gpg
* https://gitlab.com/omos.gpg
* https://keyserver.ubuntu.com/pks/lookup?search=CEEE4E9CF1676119&fingerprint=on&op=index

Link: https://lore.kernel.org/selinux/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK8KuseMQS-9tNA@mail.gmail.com/
Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---
 SECURITY.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/SECURITY.md b/SECURITY.md
index 52ab863c..1f255c81 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -40,7 +40,8 @@ window.
   *  (GPG fingerprint) 578C 4211 832F 0A7E A2C5  A7C2 21A4 6E60 3F74 4ECF
 * Jason Zaman, perfinion@gentoo.org
   *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF
-* Ondrej Mosnacek, omosnace@redhat.com
+* Ondrej Mosnáček, omosnacek@gmail.com
+  *  (GPG fingerprint) 9F17 354B 2928 339C 5130  906D CEEE 4E9C F167 6119
 
 If unsure about whether an issue is in kernel or userspace, feel free
 to send it to both the kernel and userspace maintainers and the
-- 
2.54.0

