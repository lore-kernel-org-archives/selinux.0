Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5530DD11
	for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814859; cv=none; b=aypLQJL5Rld6+xa4b4YKhSvUNTJJyfJr2rzLUTqtsiKBfNCzTv3qGmipYK3fEtI1XOsWCK97GfkZV6tZLGfeY/Zs9e0lPyVXk5bRXlp4s6JFN6WYbRfVQKljnuR4nBjTGFbnLljyAxI/IcnUefnTylxr4xBKUduvCgEInA2GZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814859; c=relaxed/simple;
	bh=58J+e+qzOqSL8rLq819iM9p8hX+gCfzoDVUQTirsvLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QqxbBeRPL9iZhDD+ombA/ZX2gjLj9dyWC2l0Bi7twJ2QS180gPfWZbzEJdzqyJmIHHZuSEiWrHA9w+wffsgNTA6g0yMLkEO74F+TcOWhQU3N/Dwz/wuev0efHGNR3Nyu+dknyKcWjYwqKrTHkGBCbp6DA7MLhKomFsrOxZk5PfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpZDhoWP; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpZDhoWP"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8db35680d0cso25451826d6.1
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814856; x=1782419656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DA8ujigZ7IZh+Xr0JA9p0ivPwgMz7UTZBS7avx55oOk=;
        b=ZpZDhoWPKMWpdhZAt8MJSKrpVWP33cTDKaLOR8NEm9junQifEuiYa61pJ5oKMbbDUp
         42KlQxUeHhddXxpPPL9P1duAU4scCVYsf9Fv7rU3/GthpI/WNmrIVWvBONGMBsDmatKx
         9pmj94Sw9dU5HEm0wqLwGiSYEfF/PvlCwC97ckbrUYXu7AtWeIuQdJtx42WNlmaLrw7d
         zgOG/03uEJsvIoAfkBVVZG1S6pcC6/hKSd5wun/hlHCOOqb885aiX/JzgcJxPOMCXMc3
         SBBF0xL/wmhsbV9oTsLOSFhom3l53/qIZn056E6zi+qFXQVjmzHM55+LIqbAFSK1CsxM
         Ckyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814856; x=1782419656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA8ujigZ7IZh+Xr0JA9p0ivPwgMz7UTZBS7avx55oOk=;
        b=qUbDS0W8HMgGZ3Us3hQQeBJadw1a5l9X+v0qOL9ZPDKHJm5ytI+zg87zV/gO/5g9e8
         dlg9Ne/mDf8a40V7PqgkuJnpyRu/m5PjUktu+JEgw0GltCXrc0D5fT+/ypY8w/+uzmJA
         xAi4UfwpzK/YBNG2O1Nn1IofYWM9UN/nkD34JihAsHiZfnUG9/lt4AHJvhoO1oWZ146K
         khlHSUcBK/NMeKvgrHefv7D7//NYqcQxwf8PN4yep8dqSr4AjbsxioB69eScNHn0ns7/
         jVVbPOXoGKasOj6VllaID+J4eo/wROXgOyEWYhlISiGsUtvn8qWBd0+V85lAbjiByEGe
         AhYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vzPQyb68Hv6H2IiPErY5GJ4LUyRbxQb3bPaKiRKqH1mkw7dsMjRIrWrmD0v9jwZeUmm1loalt@vger.kernel.org
X-Gm-Message-State: AOJu0YxIT3LARexK9Ji4y3msz6FbNZj/R4yLmqK74zIOH4WBxVlSuynp
	T9VNpoOW4RAvXHtgTGiJPnhTC8YnR21mAlwfdwRbbnVd7pTPueFucHql
X-Gm-Gg: AfdE7cnsGec7fH1Eq7X1aocNqs8yo1xOebs1YEri5baF/AjXyP+tBerlBGhF5IWv/rk
	jnW4PrFzmAK0cAIjinTUP9WJlYGnw/ao5RYsrU48qSFb9q6WDE0A0K8rsmw/norlAlztuAxGUXt
	HgbdQ/LzybwJZH0lbtrNi6rxjs1g/XcOWNo+MfIT6lvGo6JMn1HxLxYMzpj3RXJqDvSM+vnt1Us
	RHmS7JutvQvuXcT6KRu8qYtBF8vJS35McX7cm8lT74y9MBL1UPBTmRVuHsUU1IQDZwacx6sVVH3
	qiXCTywub11lc/I2TszKEmVCxnRhPuksXy5qFR7JAtkmD1TIWFSSdulhsAs+7RFmJYkbJ0E4vZB
	M7ROruCPlXNhfym1Lw5Dg0f7XTpLNShi2g3/v/JweYhCFcfy63wi8+2c4VLAjrknZlY/xWM4gb4
	/YM/f4Ewd5W2swEBOIOv/ibpFeARH4K2u6x1DK6TRkM+F+myS10riU3FE7APYLQYExaH0PlJTyU
	4ArGKkHDSySrP6HjnePlRREBg==
X-Received: by 2002:a05:6214:dc1:b0:8dc:939d:b03d with SMTP id 6a1803df08f44-8de4c76b7c5mr8335506d6.16.1781814855698;
        Thu, 18 Jun 2026 13:34:15 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de5e12d1c3sm2176166d6.10.2026.06.18.13.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:34:14 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Thu, 18 Jun 2026 16:34:09 -0400
Message-ID: <20260618203411.73917-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in
extended attributes. For these LSMs, atomic labeling during inode
creation is critical: if the inode becomes accessible before its xattr
is set, it is briefly unlabeled, which can disrupt LSMs making policy
decisions based on file labels.

Existing LSMs solve this by setting xattrs directly in the
inode_init_security hook, which runs before the inode becomes
accessible. BPF LSM programs currently lack this capability because
the hook uses an output parameter (xattr_count) that BPF programs
cannot write to, and existing kfuncs like bpf_set_dentry_xattr
require a dentry that isn't available until after the inode is
accessible.

This series introduces the bpf_init_inode_xattr() kfunc, which takes
the combined inode_init_security xattr context argument to access
xattrs and xattr_count, and internally writes to xattr_count via
lsm_get_xattr_slot().

v3:
  - rename struct lsm_xattr_ctx to struct xattr_ctx (Paul)
  - increase BPF_LSM_INODE_INIT_XATTRS to 4 (Song)
  - enforce per-hook attachment cap at attach time to prevent
    runtime rejection (Paul)
  - add init_inode_xattr_attach_cap selftest

v2:
  - pass the xattr state as a combined context object and drop the
    verifier fixup path (Kumar)
  - restrict bpf_init_inode_xattr labels to bpf.* namespace (Matt)
  - cap bpf_init_inode_xattr() at BPF_LSM_INODE_INIT_XATTRS slots per
    invocation (AI)

Link: https://lore.kernel.org/all/20260503211835.16103-1-dwindsor@gmail.com/ [v2]

David Windsor (2):
  bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
  selftests/bpf: add tests for bpf_init_inode_xattr kfunc

 fs/bpf_fs_kfuncs.c                            | 106 +++++++++++++++++-
 include/linux/bpf.h                           |   1 +
 include/linux/bpf_lsm.h                       |   3 +
 include/linux/evm.h                           |   9 +-
 include/linux/lsm_hook_defs.h                 |   4 +-
 include/linux/lsm_hooks.h                     |  16 ++-
 include/linux/security.h                      |   5 +
 kernel/bpf/bpf_lsm.c                          |  10 ++
 kernel/bpf/trampoline.c                       |   3 +
 security/bpf/hooks.c                          |   1 +
 security/integrity/evm/evm_main.c             |   8 +-
 security/security.c                           |   7 +-
 security/selinux/hooks.c                      |   4 +-
 security/smack/smack_lsm.c                    |  27 ++---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 105 ++++++++++++++++-
 .../bpf/progs/test_init_inode_xattr.c         |  31 +++++
 17 files changed, 306 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c


base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
-- 
2.53.0

