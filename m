Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240F3546D6
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681058; cv=none; b=shFX1HJVdgM+b7nXKxUepgU3UjrCKsHLLYWvD57oFniZnrCamBiSCLaChfFA1v01eRIQMm/F30vUX9cNiF1ZFsTIouNWqj2Wk+/mJNxqoH2cIUw9Fpva7BYLshMYFMBUfAuCtgo0O4p+kTogu+Xk1GaVyKCYVawu2lH9YvNNt3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681058; c=relaxed/simple;
	bh=ak6qQjp7Zkbg7uIRjrdLLgGlrolS81llWenN8lyI2t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=desKptQavrLS7EajORtePt8ZalK8CQwTskaEo32iH9YubYi9zwARoMGoPbMw0K+4cGCdAOYtPAX7G+zUgg1KgwBOOhWVu5tZLzv169UMcNRPTb96qr+jfeErp2Irx6HEy7N7v+zPCSQ0SoCZteqYIzniBskgOxQ1tyb9W+0+y18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dri9vOwN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dri9vOwN"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c149c5722so993081cf.0
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787681056; x=1788285856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7OKRqI7gvKzQZwY963LC1BKprgCLb4mX2Esmr7PR9dM=;
        b=dri9vOwNsADqHsikxMFIXuYnpo9pe5XLxwgIFQ5PGSswiOOTUh9Y1Gt63QqIE+qA6i
         FW9FyKlkhyjB1kCYWSArkscjAOdm9f0yAsHDDjP3rDOO9hIAlOvnvBLX7nJRUIhMLazV
         2XfPy52qwJNzkBgBZZQb0j9p6pOF6ngxOf0VLvyVGw+8jOKY2djTLiCBbDLccuptwgQl
         YZBg6v1nlbmjuR8bIxe1QPEjh5hzenm0neEixEJTfCIRaYC3K+giOkPjQo3Ei5uXT/K0
         Waa3lgon+RB9S4s4Gla/x0eIDspe3UsDJ+BYkYBH5I5GPFCJniZOUldH03QrTm6c+KQT
         FB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787681056; x=1788285856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OKRqI7gvKzQZwY963LC1BKprgCLb4mX2Esmr7PR9dM=;
        b=pqJ217qf7JCFeuiVoJH6e8M7cQD+T2+ZY034C4SJye+0hc/bd0RkK7JYm8yHP9e6Tb
         yrNTfoJhTERL1dHTRb2aWRaPSj6MQ5US6O4zWzOT98R8JvSFSKQLlecR1d1n/8gqEE/T
         YbuvOAtEcuLeNABbHwMdcntEyMjNqNU6jmyvHGhPlDdNqwhajRceff9jDmHEsIDISzZu
         SrBfmwKUJW8RFtt0n7yAIdqgVU4Ct/MaAu+3VVDIj/D3PebSWnSXLblCXm+Gp9x0qzke
         jN2K4khY/jozm+WDJf+mE76UhpSffqh6XIWSAzSODb6RbLMmAN71i6qw+g+eaYil6gqM
         FsHQ==
X-Gm-Message-State: AFuF++mwS4W/gds5mthwFuS62Qc9qmWhmhgosgmbhLUzLThdmgkUcaI/
	l1QSvbpp0JPhZ2T5p4LWCKayGURjwdltJtjtT0TA2OZHeuBStanZKQMvwnEHwQ==
X-Gm-Gg: AR+sD11vuNZd13X75VCmsRrePqAaL6QHki8uQBLTXtIAKvpOYWGlVnrrQ46LTcNQ7P3
	Y/EAso9Xl0Wm3k8EO1sg09Y3u/7CnjCUXBBjOnLBqWvdd4KDt8HaEZ0bY2nZbvQ1InRsEmPkpS3
	UTfupYo3AMW6k9fJAsgOoyhXBsR9VmoMZgIIRpXxDWOz0bgld6RqdCwkY+9jCUpE6VYX+y7bbmF
	uCMaWN1xVGW6zrM2CdjcO/YiARAI1AXD7F5iRbGGthdBcBfPtWj9jZJojORpGa96rneKT3Md1hH
	cBuEJM47LJONfI67vZ6u12150+0C3nNlXdDhZ0HfOUICdZI3ZwUqI2y5KVzmkrqC27jTk9LewI4
	nK+4R5pDpAECASw3sSlWBkd65Eq492mHxYQNqt5zwhWEvf0v3JyFIOaJCGs5JiQqaG51JAtik4n
	8odueNvL1bdiYCZmkkO5BVXkUilawx1kaqa5q/QQ638QT5OwHFXZ6KaXqpQOjDiIHx1tar8Fkh8
	GpEy1soi++7zT4KFXTzqMYFWYmqxjhYOTQ4alNMQ26rjVv5H8FcLo/b9Pwb+Lmi
X-Received: by 2002:ac8:7f46:0:b0:52e:1364:debf with SMTP id d75a77b69052e-52e41a95250mr12480911cf.1.1787681055698;
        Tue, 25 Aug 2026 11:04:15 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e42767784sm973401cf.29.2026.08.25.11.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:04:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: sefcontext_compile: include limits.h
Date: Tue, 25 Aug 2026 14:03:57 -0400
Message-ID: <20260825180358.89854-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

limits.h is needed for PATH_MAX; the absence of this #include
breaks the USE_PCRE2=n build.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/utils/sefcontext_compile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index f8115026..e504b508 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <limits.h>
 
 #include <selinux/selinux.h>
 #include <sepol/sepol.h>
-- 
2.55.0

