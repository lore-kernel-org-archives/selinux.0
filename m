Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF02701DC
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926459; cv=none; b=KhnB3YC+XYdeZp/txJLYgugd7y3LRp5BvEawwC/kjOJkU/K7cTT9UVmy/X3EVxCSiuRx2TAZECJ8mAEVgH1MKyeN7oUi7a5fxCaGB30lQfvyw2dAYSp4uOMlDTiMV8+24gj1daFnfCCinfpqzxbexAfxePhase6xjXCvyvL07P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926459; c=relaxed/simple;
	bh=bsQR3BSgofhtIlXdd8nHQkdm6uGxhV2BLPyrbOeCDcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXp1TCIiYg8C9sK61AyHHG6I3Aq8HaBH+xvQCum71/EJsvS7sYJ9iB99B4HAAbaqcrCB5/9NhuY1IL8rBtT2VfkgeL53i6rg2OYoCqZ1nnTVLLkhrXrUscqRlw7ZrjZUvHMOVtjDpNJZdRLf4tKRwCW5CzC+vfY5ooHAhVBmRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJTR6WQd; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJTR6WQd"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5175cb5946dso27600901cf.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780926457; x=1781531257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb+JJbhptGl3/fPFykzSSOBuKLRMpybSZ9cOY/2eKnI=;
        b=OJTR6WQdCDiCoBx7T0a9ArQMS3NU1DIw27w/eXWDqxYplBkmJ+HKUf0fgRiQwFd3gY
         IQrTh/GeISYMXfUL0qO1uCsdCScS874ppCXIrUWr7Z5uvlvCQRyP/MBVxFkpu/uw9iKr
         e0WT5EMMsUbtWe+CrByywgNM6cu0ATOUDtqoFlaSmik3qlftetzQ9v9z43hg7RW0brLP
         JcqFPWebHVi9gsb4zLA8UsfhUaYfCsOSagoDQCGW3y9ChEJf/Mo2rPaXlBrkbfNK8P75
         pFm162gK+VamTCJ7m65qkMIe2vvAC7B965ZxzLEidFRugNrF6i2LjGiV4/hxJGcfEvYb
         b43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926457; x=1781531257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb+JJbhptGl3/fPFykzSSOBuKLRMpybSZ9cOY/2eKnI=;
        b=atEDfKFXba5/JQNifA5U5WHzxwb6dQCW2klV4uCFCZAHh4nUYqhTXChD6grdU4Hp7v
         PMYXXvWFLOjgQAfbA1K6jZp5YvQZkRYDdwx/CwsiitEFtwNlESre9gL6Bf4nHavgTBvk
         TmX2KMLgOU9ppayfDBbFVZocgJqtLIsbo7HS2WnTaezYl/1rOGLATOYWmd98B5NHQqj7
         SaJrcztC7bAQg6ui0iuZk/EtgHnGQdiMnBfYIU7FGnoZDjk88n6r8hcoC6HspN04cPk/
         ERdr6YkDSeyNWL/lMslCIJve0VpgUtpilvbcvLHBRxB/w1wea3U+lUtJEuMCiLSBhomr
         fH5w==
X-Gm-Message-State: AOJu0YwwmMwn2eleBuwsG5L6CCx5WMt9HMLfDg6DA9Nzn796r6gP2lXW
	U90q4hNXeBYISZKszvJ808GT6P8fphLZsoWMoVA+P+6SOAzekGR1JFkcMjWrMw==
X-Gm-Gg: Acq92OFSHPWdqZ2+48uLX157r81Tmidm2pRpoyI1W1VBkwDrubEb6CettV+Qi/S1xnm
	SggcqP6QtvZEffEWu+JaXQdbiUDQLyCLmJUzw3iMrlcRyLyGwQpWpbwu6Q2H0GeQo3XfiZBuh2s
	CGdTZyExgcnDSdbg4XGYTS8FU9To/MW4NPTWZ2Z4cqbGRrLuYOBlNXWayTEkn77HGR6V9ImzzDN
	so6M1JUYgjxB2zklaR0ss91rweA9NCMCc/mt48GNNgxckoV6zv+EMDxIvvDtV4JpQpZ6TUWEcTg
	d5rZdKiawwHfclvxTWThB3RJzXsnEy8nviMIz2afTp1YY6yO+GLS3xeLckFnQGUD6NxiFxm7Ep+
	gk5YJvxG5oNb5glyfa3ZKtYLnEk/SU4axtSzKbsw6QT8kZyApnRrU3jktnIlD64GR7W2DqQbWdf
	+CMyyvScx3MTAKMkIMu+Th8zzaSXLnPpqetoxm83l594BCWTeRlpuUQUb40VACsYyQl1QO3+2Y0
	GVhutRtJRbdOe4wvabBXq/dH8y9SXXI9L/2tfCoO6opIxn2
X-Received: by 2002:a05:622a:4108:b0:50d:83a4:2995 with SMTP id d75a77b69052e-51795b1d1c5mr228671321cf.21.1780926457402;
        Mon, 08 Jun 2026 06:47:37 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51789407da8sm123488531cf.19.2026.06.08.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:47:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] libselinux/src/se_linux_internal.c: include stdint.h
Date: Mon,  8 Jun 2026 09:47:20 -0400
Message-ID: <20260608134720.309839-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabrice Fontaine <fontaine.fabrice@gmail.com>

Include stdint.h to avoid the following uclibc build failure raised
since version 3.6 and
https://github.com/SELinuxProject/selinux/commit/cb8289c2b237e5f66e4a7608ecc6c68abeaeaf55:

selinux_internal.c: In function 'reallocarray':
selinux_internal.c:25:29: error: 'SIZE_MAX' undeclared (first use in this function)
   25 |         if (size && nmemb > SIZE_MAX / size) {
      |                             ^~~~~~~~
selinux_internal.c:6:1: note: 'SIZE_MAX' is defined in header '<stdint.h>'; did you forget to '#include <stdint.h>'?
    5 | #include <string.h>
  +++ |+#include <stdint.h>
    6 |
selinux_internal.c:25:29: note: each undeclared identifier is reported only once for each function it appears in
   25 |         if (size && nmemb > SIZE_MAX / size) {
      |                             ^~~~~~~~

Fixes:
 - http://autobuild.buildroot.org/results/7e627744beaa4f7fdfd488dfacbaafc074a999f7

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 libselinux/src/selinux_internal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libselinux/src/selinux_internal.c b/libselinux/src/selinux_internal.c
index f83ad16a..f82be475 100644
--- a/libselinux/src/selinux_internal.c
+++ b/libselinux/src/selinux_internal.c
@@ -1,6 +1,7 @@
 #include "selinux_internal.h"
 
 #include <errno.h>
+#include <stdint.h>
 #include <stdlib.h>
 #include <string.h>
 
-- 
2.54.0

