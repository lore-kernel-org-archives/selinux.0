Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB520A5C4
	for <selinux@vger.kernel.org>; Sat, 29 Aug 2026 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788039190; cv=none; b=LGQmPqmeFMqHJfojVRqtR0bKKnIw5qozQRyHdklCf/hTpMkpUC5k92dUCpf9yiC74D8ust83vTV14ViCwNzzkbx54/fi8EcUCUuB+ely0cfdHa3ql3WMQQJWDF1CQ3hJ28P/WGojbCKMyvXjv7riDm4z+6a+J6PZugWNCyz1a8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788039190; c=relaxed/simple;
	bh=Zt6xM5ByKMqjss0Ju9Pq8lrUfSmBQl0+BHJmcT0gcU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FVbffdWMv1k/AiCFg0F6rV0JlvYzThQn2GMWXSdRNW3YXKdsdQRq40ftjkc1befBRrgzPun5RBaNZpNWFrLNaxclXXd7DfGYVcB/krcULkBuvcomfSmx9k9l4osEs5WidaMwv718hEzkPNLG31F33bt6WLYBt3TzvmfelPfRW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1pRPMGO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1pRPMGO"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f633e6058so1612109f8f.0
        for <selinux@vger.kernel.org>; Sat, 29 Aug 2026 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788039185; x=1788643985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ucnD2vvZKQodkVcezxvV4KyyS73dxyfqz8xpesSWdQI=;
        b=A1pRPMGONSvtnDEQSeM88hjsR4UhzcAQhj0khTIC7Kcg4ylw7Hs2Pp1ze0Wzml5xEY
         vuEw+SVSZ/VOCZzx44S2OhfeEa97fyg++wvqcJ+h7khmMFjcxME3guYCom6RXQU2XX3v
         TScKUqTfBJVT4IgbmJfe9G5pEfClUwmBXHlXLZTwtgnRhmGsgirYEHf6khLFQR1JnU3g
         9X8Rtk5up1uqY+KmUDI1pXc7QLqp0I+sTCALkRSD3QZPa8kiXhJ3yffXwH06sl93+gcU
         QnU57sOzivcNJ8juYFAMciOxBoJlyzZlFGKYTIrbMvpoq22mHXzt8bYXuIKTF4Zrmqgm
         YgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788039185; x=1788643985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucnD2vvZKQodkVcezxvV4KyyS73dxyfqz8xpesSWdQI=;
        b=lyWpqHDOaPtkVgjMJGKt+bLyw70BR7VbgRF2AGPMBvrcmtFDKV1K8GU9J8N13QoZ7C
         /aCJ76Ld15OeXZpl3TfnT9fpost78fiCe9JBZZet9Her4C8GU/0qIvZ7Zb1g3jpEErMX
         cSXpj8U760mSfKnwXwJPV7e1MKizw5pRmy3RpxLt07+XJdHllYfsiq5ukFsk+1Y7mZ1R
         UaKk3vJaaoxVmrZ1cAFBG1UTn48H1mAy4pqcJzv5PCx2M2fDqVCDDE931K5dqUC4Pib1
         cU5VWlB9ql1Yalfdep4R9MFQXwlVHOEj/pUKBmACnfxk+R27C8A7P+14ANit3hnugoRJ
         DvVQ==
X-Gm-Message-State: AFuF++mzjn7ElAsAVHjuF/kamy/MsgejoR6EnXo0Hp/UuDPpNiOYJaWM
	lodkvFVAHlLxdgDtxVvQmMfpFPJnKqH+it79NVjA2LmfLQ/wGU5Ez5fcHO56a5Kv
X-Gm-Gg: AYBFou3MWxEwIc9umC02lS3OrrS0rs91wuX6DHllXms/JUODVR0Jopw7qp723pgcy/m
	838ZxzeEq9M1uh/SUQju8lAPyJKJtO8NoP/jlpAmN6v7qIEbo9DO0dJQf8GHSPCei5mEi0gZbn2
	AOLzvpuVJhkc/VswGT1gessNk/Nw8WTITtkXARKjeYMC8ogSozNqNfohgmkIRCgjD3DBs7rWcOR
	W9ZbCaRKIQHSQwwLyBSgUNlyGTqfurLQ+DDZTQ5VkgckPe79WuDcmN8HajymV4ABliRpcXPlRv/
	+OSvcVZ11uKtW5EZPHqEZUjrA2FG3VOREFWqqCZNwfJ282lVZ8hZvBb2o6dGVhhSdniYgrwPI+u
	iTFhR6eDeqUlkuFJqYI8J/WDcPUX+uAIeB3cBPWiAu6mnSMGk6Jj6Zhn0fTlgZfRyeNbAo4LMOF
	hyaAeL0+kDWqZA0D9DXXw4/y7pNLXaOVDDuzFMEF94oCA9dq8wxdv8Cfv5NTI4T/3R/oD51Yghl
	H3sdqWFBgAnbjMeA4EsH14RI8x6eMNd4kouBU3d6vH4jFg0VuybfEHzjHHOtWKlq+JpoEYBd9WX
	SpRmemg4ZQi6mYY/BLyEtwEzp3LBPqI+u5M5wmcgYtbzanSNCpmMslR5svD8l+YOpp8A9sBvGPL
	mIA==
X-Received: by 2002:a05:6000:38f:b0:484:3315:1a38 with SMTP id ffacd0b85a97d-48433152785mr8141778f8f.28.1788039184984;
        Sat, 29 Aug 2026 14:33:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae86-1b01-80e2-8851-4221-68d8.310.pool.telefonica.de. [2a02:3100:ae86:1b01:80e2:8851:4221:68d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb33070sm12540616f8f.36.2026.08.29.14.33.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 14:33:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 0/2] selinux: fix nested backing-file mprotect checks
Date: Sat, 29 Aug 2026 23:32:54 +0200
Message-Id: <20260829213256.51527-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 preserves the top-level user file SID across nested backing files.
Patch 2 preserves and rechecks each intermediate path, mounter SID, and
file-description SID during mprotect(), including execmod checks.

The series is based on cf72cbb39da8, which contains
commit f2381b546e7e ("fs: fix user path of nested backing files"). Neither
patch needs that fix to apply or build, but without it the top-level check
still resolves to the intermediate inode. It is already marked for stable.

The intermediate list is allocated only for nested backing files. It is
captured at backing-file allocation time and remains immutable afterwards.
Capturing it in the mmap hook would require synchronization between
concurrent mappings of the same file.

Tested on arm64 QEMU with a small BusyBox initramfs, SELinux enforcing, and
two nested overlayfs mounts. The original SID propagation test passes.
Direct mmap(PROT_EXEC) and mmap(PROT_NONE) followed by mprotect(PROT_EXEC)
are both denied against the intermediate inode when that permission is
omitted. /proc/self/maps reports the top-level path.

Changes in v3:
- Add the intermediate-mounter fix as patch 2.
- Allocate intermediate state only for nested backing files.
- Rebase and retest on mainline containing f2381b546e7e.
- Document the BusyBox test environment.

Changes in v2:
- Add selinux_file_user_sid() instead of open-coding the lookup (Amir).

v2: https://lore.kernel.org/selinux/20260820175832.44512-1-kmehltretter@gmail.com/

Karl Mehltretter (2):
  selinux: preserve user SID across nested backing files
  selinux: recheck intermediate backing files on mprotect

 security/selinux/hooks.c          | 150 ++++++++++++++++++++++++++----
 security/selinux/include/objsec.h |  10 +-
 2 files changed, 142 insertions(+), 18 deletions(-)


base-commit: cf72cbb39da84b6f02f90c07f33b102fc10b16f0
-- 
2.53.0

