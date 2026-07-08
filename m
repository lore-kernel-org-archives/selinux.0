Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31817745
	for <selinux@vger.kernel.org>; Wed,  8 Jul 2026 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783469403; cv=none; b=ohEs5tVZnxq4oQludWDlEHCzIkFOJsiRYXPh5GU0yJxgNYcL+w9F9t/ufaY1zVleig3HwidnsUoB4YGAwUICHpN65Oi5h7C5Y/ES9In/0Pr8fy3vLQdcoll+LPY4C8YpdmobrlffzHDdED61JQhwinN851tXK/9WsMf7lXCTYXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783469403; c=relaxed/simple;
	bh=c58fnOiwEsN7lUj0DmXeQk2wWyvK7VT5Pt/ChD76cJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPJLHpq2BJ2M9szy+/iJca5gWCEGrfxB41BuBT/mGk82tKd2QASIquZvMyOSeTQlZ04TfcmI0WMbbxlD8HJYZk+M61sXFMTlIJsNv4RtfpsP5w6bgCKhDWFoWFmfkUGKRKVKvB/NL1Bx2ukf8EpAuiU7PvExPJiKu7fLF4ugsy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUVlOCJr; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUVlOCJr"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e5d6f35c1so5861985a.0
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783469400; x=1784074200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X5YW1Vp33W4R7ClL7Q/jKwGiZ/RqUWzBm7jRzsfKd+8=;
        b=PUVlOCJrUkLuEsI+OMjFuJKsGa+l4JaMsu7vrh3aCQKgwbb6G2N1kmia8DPz4HVdQW
         CgRC71bA4obYOXHAljFXW1RsJygheVmQXgOH8GfoeQiCjiYwPH++jG1H2rhl4xkmgVq/
         AeLgvgRCUMyjM1il7xFIyGlUUkZJjllO41FTEEb3q9IebTucD21lXmIUojFRckwKQoiA
         QWDWqRcdEh9x8qJb+Qe5JJf8RXJSPMqJSEhj1tPFT0DYuT/RbEAeTxiMfhzIhZ0Cqb9K
         6x2A6ikZZnJTYl8pqUs+JsE5QVVWuhRDYn4D6WoQay6FzWEiKoKJE/Xx8sI/9Xu/jRCN
         2FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783469400; x=1784074200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X5YW1Vp33W4R7ClL7Q/jKwGiZ/RqUWzBm7jRzsfKd+8=;
        b=BfHnEOu4/WybnERcusT6QlE0nWcCLLoSPv3DaD7aevU3FgYACa4+mzNdwTR/LZLGQG
         tO/OTsoBPlVp2Kipcb/+abIdvxBfsz4qM9wXaJ1YV2qBUqJWeYD691p9S/hYIg+uZTFW
         jOMo0WBfOIjtezSFpL3atsYM2Wou4OxG25JEqRU7cB/osSaLwjeVp0lO3dqNwzKO1PuL
         7LFIfbX3OfV85WLE7ya9D7zxLOvw8lpKSTHf016Wogakv1cmJWwkXhNgmlzE+tt1tMyA
         uAplxEfR8m68CQIp76v4zATrKcnlzgM9PKbbFgdc/rkvPuF9p9+xu7eWTINrIljkAEz5
         NXLg==
X-Forwarded-Encrypted: i=1; AHgh+RpTlz1aXEYuIgbdmXlRBw0+qCdnhSkYW6Yuwnpa4dan27b6C6M+WQvNJp9wQF0s0SgB0kl8xrW2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0clxmd7J4qEe4ngS2XRmqHBS058P5s7nTkGmZ0QgnouTDpNgs
	GhzX/9ecJIUy5yvS3bAY41E1l+oSN5W7JuN5ZWA/D7NevlPLCw2kPZLQ
X-Gm-Gg: AfdE7clQ6Y+dvTWWjXF6p1TmyBI1IGTGX2EtVHctmz/Rz+ZD4Et1mQFZ4QuAZlUswjl
	fjxQicoLetqnN3pF0+Aaae4ZrpkLih2IMMME5N8QAMjRmI8zN+KAlcWbwW7QscoLznFunJRB5XD
	XZ4uWEmkGo09qXP/jroOzFTD2nm++RYGouOoPhOkAmy0cWlYgIls2YCS0Jas4ndBfh5eJ65R9yD
	iYMqSemFUdTxDrfUULl1g0zGknQKDC83UlRWBNhlkgxjq+iBwx/+Z+nc3D7YAvGmQ2HHtJgnaQk
	g/jzfZqZGZVCfNyf7JjfPJbLseSRprlCzOuzKNTGKkly7ElVheF1WGC5DGeh0mHpLMRra+CWrgp
	z/+xY6eEkICaetIiCPY7oXeKR1I+Idn54LHHF3Y1WircoaepyEL+7wfkZx2sD+kEGU/G/0MwzFQ
	KZ7J2AvB7NeANi/fUxOgkUBqz8aV7SbsZYcCZnLVjG4n/Ruu/QNlbOtwZWju/NH/1AekN/vud0Y
	w+NPGqo0LtMKH4=
X-Received: by 2002:a05:620a:2b4d:b0:920:6061:816e with SMTP id af79cd13be357-92ecf629324mr5879185a.7.1783469400172;
        Tue, 07 Jul 2026 17:10:00 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e93ea5ed3sm1191281885a.29.2026.07.07.17.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:09:59 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v5 bpf-next 0/3] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Tue,  7 Jul 2026 20:09:53 -0400
Message-ID: <20260708000956.46138-1-dwindsor@gmail.com>
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
the combined inode_init_security xattr context argument and claims a
slot in it via the new security_lsmxattr_add() LSM helper.

v5:
  - make the kfunc non-sleepable to avoid an ext4 deadlock (sashiko)
  - move xattr creation logic to security_lsmxattr_add() (Paul)
  - use distinct xattr names in init_inode_xattr_slot_limit

v4:
  - introduce struct lsm_xattrs in separate patch (Alexei, Paul)
  - rename struct xattr_ctx to struct lsm_xattrs (Paul)
  - make lsm_xattrs.xattr_count unsigned int (Paul)
  - drop new_xattrs/xattr_count locals in
    security_inode_init_security() (Paul)
  - fold __bpf_init_inode_xattr() into bpf_init_inode_xattr() (Paul)
  - drop bpf_fs_kfuncs_filter() attach-point check; rely on verifier
    type enforcement (Alexei)
  - drop attach-time cap; enforce slot budget in the kfunc (Alexei)
  - allocate the combined xattr with GFP_NOFS (sashiko-bot)
  - replace init_inode_xattr_attach_cap selftest with runtime
    init_inode_xattr_slot_limit

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

David Windsor (3):
  security: rework inode_init_security xattr handling
  bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
  selftests/bpf: add tests for bpf_init_inode_xattr kfunc

 fs/bpf_fs_kfuncs.c                            |  36 +++++
 include/linux/bpf_lsm.h                       |   3 +
 include/linux/evm.h                           |   9 +-
 include/linux/lsm_hook_defs.h                 |   4 +-
 include/linux/lsm_hooks.h                     |  16 +--
 include/linux/security.h                      |  15 +++
 security/bpf/hooks.c                          |   1 +
 security/integrity/evm/evm_main.c             |   8 +-
 security/security.c                           | 108 +++++++++++++--
 security/selinux/hooks.c                      |   4 +-
 security/smack/smack_lsm.c                    |  27 ++--
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 124 ++++++++++++++++++
 .../bpf/progs/test_init_inode_xattr.c         |  31 +++++
 14 files changed, 344 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c


base-commit: 602701718649936eb287bf6c7ecf870ec54c6f71
-- 
2.53.0

