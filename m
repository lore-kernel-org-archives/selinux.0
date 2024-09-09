Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32F1AC88E
	for <selinux@vger.kernel.org>; Mon,  9 Sep 2024 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872565; cv=none; b=nG3mEkA167Mv34w9tHfVO7r7qgNX1JFGGSMTp0+jZ4wHXTc7TNuexJsPJQHLpYvwlGudWD+mEYyy7xzmAJo1OaRGibqkADtnABkqgLbwWM4/qgEtOvvx7lEUlo1qsFvAHNZlRQ35ITbI00jMA0M2ormGXF3r86FzPWDLVod+oe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872565; c=relaxed/simple;
	bh=VDNkYX3WaoQryYN4SSWXniCNqEjv3G8XnjXfhlwyshY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qi3Z7lCVjnv0Cr432UGarvm1gnriP4jG4XH60sX5BXZ+R5CT+T14szfle0lmBY5dwBZ4qplpJAuNqmp80L3snBpBmOs2XOO033rXm4nwt9cg4T1BS8PushrWbIewKQZjb5pZrAoq16pf/FlJB5Izy/S9Dw/qk/eKtTixrguwXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMPlDN14; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMPlDN14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725872562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v4ZcHbYq+GXZkpLPb6gaPXThYdtJIZha90i7AQ4TRpE=;
	b=KMPlDN14PvOEHihuokCMBbx7gnDmDpQUxoTSSShnwfrJnKDuw1HfDe9EDiCHjoJA7h3QSI
	OYROdfzreDjgc3MM/2wNQO8VuXWz8QX6t+zbtwLigS8nTCRg7lhyc1dVwfLf2JCIqFbKj0
	zRTSqNPf7TAeDERYZHphWCIJNIDXgAo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-XF8m-rM3PDmycG2Nc9aGzQ-1; Mon, 09 Sep 2024 05:02:40 -0400
X-MC-Unique: XF8m-rM3PDmycG2Nc9aGzQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8d3085ab6fso69575566b.0
        for <selinux@vger.kernel.org>; Mon, 09 Sep 2024 02:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725872559; x=1726477359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4ZcHbYq+GXZkpLPb6gaPXThYdtJIZha90i7AQ4TRpE=;
        b=fsLmjeI4nfGfHzlvzx8DUc6zgXcB0otYVf6jEYqDyGewY63yWqW6fN9QjxQjbicKC0
         jlPYjSRLks1/JLQ3y77sd8tvGUpYXeNT179i0XmLSBx8Qwbku4T4iX/qU+hxm3oXKeCX
         UW4fzZ8j3wrESH4fw+vAM7Tg2nuukxL9aJ4Q0Pvlv5oOqkilsafB+J5Bd27kexmNUH16
         F1S/VEUTEopmMhJfDd985ZkpzinCJvi2s1D6TpnIrqiK425Km1n3ptMgYP9YGENAYUGD
         s59x7p1deWS/hs9L449RRBu9CHY1XaeXf/aT06xHoLjdrTuKJXDb0yL0dEFjuNjjFWbV
         yisA==
X-Gm-Message-State: AOJu0YyXn8SSHgiejc3bWHYshhyllkZh3JHgS/awSn/uEdLAi/trdHn0
	7NCe4h6OEuKdPCFguJ+MJRCW0fQydyI/EdqGa4X2G9qCDr29cBwgcRSCkxYai0gVUzgIVimFYjt
	1uQ8MLGXqG4SIXwvKCEftypNgmKI2J/e93Ef+qU6wqcxNIRXRu1ILNHOSc8wjGu1A4v1tA+6g1x
	Jq57xMLUHgLxmALYe3laRUl/+C9XBQAcGZVxzRt98=
X-Received: by 2002:a17:907:e20f:b0:a6f:593f:d336 with SMTP id a640c23a62f3a-a8d24513fa1mr409912566b.11.1725872558716;
        Mon, 09 Sep 2024 02:02:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlPW6Amoxg3rYKT8H1XVAV+WiAlSdS0GYY6XIziKcHvFbpaIdhqqzXErEHznasOGFudNeZag==
X-Received: by 2002:a17:907:e20f:b0:a6f:593f:d336 with SMTP id a640c23a62f3a-a8d24513fa1mr409909466b.11.1725872558111;
        Mon, 09 Sep 2024 02:02:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72ef7sm312462266b.106.2024.09.09.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:02:37 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] policy/test_filesystem.te: fix policy for NFS over a symlinked directory
Date: Mon,  9 Sep 2024 11:02:36 +0200
Message-ID: <20240909090236.194250-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the curret directory is a symlink to the actual selinux-testsuite
directory, running ./tools/nfs.sh would fail at nfs_filesystem/test due
to missing policy rules. Add the necessary rules so that it can pass
also in this scenario.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_filesystem.te | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index efe1f4d..f60b0c8 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -31,6 +31,7 @@ allow test_filesystem_t test_file_t:dir { add_name mounton read write remove_nam
 # Create test file
 allow test_filesystem_t test_filesystem_file_t:dir { read add_name write search mounton };
 allow test_filesystem_t test_filesystem_file_t:file { open getattr create read write relabelfrom relabelto };
+allow test_filesystem_t test_filesystem_file_t:lnk_file { read };
 
 fs_mount_all_fs(test_filesystem_t)
 fs_remount_all_fs(test_filesystem_t)
@@ -44,6 +45,7 @@ fs_getattr_xattr_fs(test_filesystem_t)
 
 # Required when running the tests on a labeled NFS mount.
 fs_getattr_nfs(test_filesystem_t)
+fs_read_nfs_symlinks(test_filesystem_t)
 
 # Update quotas
 fs_set_all_quotas(test_filesystem_t)
-- 
2.46.0

