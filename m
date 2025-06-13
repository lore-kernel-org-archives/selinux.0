Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2832356D9
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841106; cv=none; b=gzEF8WjAbmXIQQsSCNfCKhrFh+YFJ519Q+nVGkKFslbkbgO9FbGb3f2Q9pGpbIPN9DSJfgatyvIcpVN5u5H/JFuS0b09s9SGP7Zk87ky1pt6u4JffaRMR98fVH8nJg/UDbXv1Z6/8gj77MToz0Pk+Ln4lVayJWS8wYSyiVchSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841106; c=relaxed/simple;
	bh=BV/fJmDXeH5gznj6tNjo9anmVSFCUE7pHGE85p5bV7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YbymwKHoUMUmLSUjqZFlT4i24CufKPGUTig2tmxToMRt40JOh5FQnOpI0UAJsfY6p1pAqFR6/mMmRDJx2FpO27Xx6U5bZVcuvuC7kbBYwqUSIvn7MHtIz89Vacne3yoSXBki7e7LhKicMhSB5I1HMnhkr79v0zHspXUh+nbNxro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUGWokoQ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUGWokoQ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d0976776dcso255864285a.2
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749841103; x=1750445903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8HllT7RKDMRf9ODid6HpAYRBLtGGAQKRs25RYTgmVpY=;
        b=JUGWokoQIxqge+VQ/vYNJlRrfH4tT6obYuSxTjlWdp8/tP+jcboIdrseIOivnAAd/G
         Rz1SeRNOUpXTvCl+uyDWAegundDjuZYSVm1byim5HiWuObnqDuWhTKupYrcqeITYWbjY
         xO4pvpMkZQ0JlFhxZffWz68cZgK31GpmCQe0rm8gHW11x2OAegu0/pPkjo3ElPOHnS64
         dHWdj7U8jfMFJ0wkNq0WqxdvQN0E/G3FbW+DzQW08RxkK5NfGmLUjTnBD7XA03qbVsuI
         m3dUtFSJhphJfL8wiWCxzR5kMcmS69gfn9tfJYtPvxb0XaDUx3jP62Y+TtOzr1traNNP
         N1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749841103; x=1750445903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HllT7RKDMRf9ODid6HpAYRBLtGGAQKRs25RYTgmVpY=;
        b=FZrl5O7itCS7UXf4hFHVTif2GKknfUxExdG62tlxs8+zpzUdBH0zbOBoM6crJ5M1Y4
         8YAlJmZWx96RoDdAsP7uJUsP8M50niPP302s/twTOTMLQbRBOWqUB/CnolipqTs06IA2
         DhLN4WoTVq03diX/k7R1PWHsHQzC7CqII9PaVyCR9xHuz3VvFn3bYtZtavA4FIO5l0a2
         tujur6gdQHkSj6xLgFA42uzgZfGye5vpYfIno3M4T0lWHgyHQXHxfB472x81yBGHalSU
         8+9YHClAAYlL9o75J04oa4eRuMJkiE932ftc29ivD4OL0z2VaXQ6oVNtCJj8Avg+j3Ea
         a+vA==
X-Gm-Message-State: AOJu0YwC3zGHJ1obPi37SabubJ6XimCIrloDYZParDDi0ubbzXFEY8MI
	rHNA0Tdfzy4GCaTyZl7Nso5RNW56fkuy4ONIeT0jUPkkK0Pz1Zt18NMa9Fg25A==
X-Gm-Gg: ASbGncvQvuha/r8Lr18RRS5bDFiRiMPDth1CwpFpkmgqEZSci/mr1//G1nwa4PwJpD3
	chpwOWUr+MIBZ1iUCf37p42CFJTdvqzVNlgHpC4JAkK+BOaVTDTcII66HFUDR1CjU2g3SWpR5Vx
	4yR8OC3T1lNLf2ooiG0JRMyZZBH64yQXWt25iNffo5VwRgIhX9knQgXl7RTBvbI190IJkUuOzyr
	Mz//izUngAEKCQAdiYam4+j7o7i5r2YRrSvuSIz0CykEOPhNH6lAnfmXFlCPfjeEjdkbCqESYk0
	1dXqhTcKSqLWuaioXHVpflvZ0ORvkqP+EMEYpDF2DdkuLZZXTPhROrDcoM4pHfkdZoYsBrqUi1P
	iKvz+2pxZPIiKtw9x9+AchZnS0/kXCRMsbmi9BHrMMwOCFY6GaU9GOgYVImc=
X-Google-Smtp-Source: AGHT+IF3xzhm+1YwxdSJLJYBWDLqtjDOFiQa2S96iXDC//UQwZPPebUtxqTuYTgfpLokxnaZNuO6yA==
X-Received: by 2002:a05:620a:458c:b0:7cc:aedc:d0c1 with SMTP id af79cd13be357-7d3c6c0ea0bmr89910285a.5.1749841103185;
        Fri, 13 Jun 2025 11:58:23 -0700 (PDT)
Received: from FUSE-FED34-SVR2.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8ed215dsm204512785a.87.2025.06.13.11.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 11:58:22 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsemanage: Ignore missing field initializers in swig generated code
Date: Fri, 13 Jun 2025 14:58:20 -0400
Message-ID: <20250613185820.122384-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The code generated by swig causes multiple warnings about missing field
initializers. A sample follows:
    semanageswig_wrap.c: In function ‘swig_varlink_type’:
    semanageswig_wrap.c:1514:5: warning: missing initializer for field ‘tp_versions_used’ of ‘PyTypeObject’ {aka ‘const struct _typeobject’} [-Wmissing-field-initializers]
     1514 |     };
          |     ^

Add "-Wno-missing-field-initializers" to SWIG_CFLAGS to ignore these
warnings.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsemanage/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 1357ec71..fa3449fb 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -58,7 +58,7 @@ CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-
 	  -fno-semantic-interposition
 
 SWIG_CFLAGS += -Wno-error -Wno-unused-but-set-variable -Wno-unused-variable -Wno-shadow \
-		-Wno-unused-parameter -Wno-missing-prototypes
+		-Wno-unused-parameter -Wno-missing-prototypes -Wno-missing-field-initializers
 
 override CFLAGS += -I../include -I../../libselinux/include -D_GNU_SOURCE
 RANLIB ?= ranlib
-- 
2.49.0

