Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC813E0C77
	for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844801; cv=none; b=o9hcitfbRBIRuY5LlWKt2RBHD3gsbVKIdPPk+6G74GW34cT+NXj8iPCqiDpHKu6lLHe+25cmrjiq9NxXQ3OVBbNCSeSwJ6ge9C/HH7h96s2Dd53C9kbZwaHQC0kapmEsIZWDRwsRL7ErD20bJoBIFMos+Ir/fWg/FXcPnQ50uQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844801; c=relaxed/simple;
	bh=S6k+uQwLsBLqS78QaiWexapMR9GFIKsV5VVSUcaj7Js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6ocSsowaqGUmLpkUWVGosM1PuL8hbxoDW4Nb9ViLTRI1IXd539OySq/41X+Yn1GNaHn3kcaBAUJ8JOJEaVD6wpyoGJQ9+RWi4H5E15wsdzpp80+Y8SKWqnXlFuWWBY8UZYcnnqIoGDdWPJCB3pvY97/LnSIIXHGk2MeUakkZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEQ12RMX; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEQ12RMX"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8f18d92172aso20465316d6.2
        for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844799; x=1783449599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KmgV8nCn9sbfqM1ezwxzcVc9Q6Oo1QwQHw5Oa3kbYoo=;
        b=aEQ12RMXQ+9Hh3F8u82u1VGab0TICtc/2lK+zxraZIDrae+S3v/JtWuYFKJsnzbp3/
         rTUg5SEbJgZN6xVgrxhrVKZQj4Ogp9uPEb6JZvnnRtpuj2opyz5ULVe6H8+J/JnmjONs
         /WYbwijD17n+1B77a+eIL4kTFmd2LydZ0hs6TLYwYjcSWFi9k6XXwVYqknEioWyTkfrN
         eHEbtCkZwVBmFDjIQMKLNDQCFzVck68Uc0xuvcCFtwEObTvpvFRvOekTQswV6P+Ci4Tn
         l9mhkVkmpB1uIdKzzdMMpKAlmnCMKW0x9Rp/bjthR/8mOFihJiTVI5El7+6ALF3nDnb1
         5gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844799; x=1783449599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KmgV8nCn9sbfqM1ezwxzcVc9Q6Oo1QwQHw5Oa3kbYoo=;
        b=S0jrJDOAzbu3wWcuXXREgkhmhIew+QA6oKtJx+syvXWpUXWD4AiOHVRTZ/aP5k3QvF
         DqrNcjTUMoB733cN7qu5nkTXX5z++bsnuLdW/0nABSfA5Nux8NThNcc0nx5OfX1FwG0X
         dEIpsFlDqcpVcqIZUbxHujb6cYNyOOpQIGwdioj4YHE0lLQeGwhNC5HmdvXgbouFHQ8q
         G6ia5cHsaaMgNyyBBKUYvvyLC+hhVqR3xriXbUJ3CeOntc3IYTh+iupzeSw7+2B8bHAk
         sd7uoekcQYM2gw2yWoP+97FvJbD9lhCtMDgMQt4+x86rhhYNQe775O7Tlql2/hFRgMMR
         uxDA==
X-Forwarded-Encrypted: i=1; AFNElJ++Bwh/mpL4gkdVlfqEx/Fimq0iSi5fvZK99WBVH55E8iSpa2aq4cLvwZwygtYBbUuVycV8DNfV@vger.kernel.org
X-Gm-Message-State: AOJu0YxOuan664HO4XdEtlzvDlKqp0YTbEDz/ra6YXFyvsEAwt39/KZc
	WCSmA8UOr26+VWDVpZHKCAq9f+mr8yLguWPlr75+tfiKC4bXzSUByFfO
X-Gm-Gg: AfdE7cnXJvMrfFIVNQRRqlg3PnLBlRS3qDwtqQNK2FKmvu9bFLdfnX/sHjsodKTxL22
	Xb+5pegT7Lf16HGhtsr0lYiFq0FUS8mNs1kbNXstWQ1VJwr+DgUMI5w+JPNNG0X66WIX6rHGtAP
	6ZeMh0SZxpEJ42uZ7k4O2xa2s6Qbs5aSFeSjAdjEeMWzUqlA7aHm3Fye6z+NNJTwW3Nzn4iOwIR
	WyYvDuirA4NHnG8EmLGV5SN1xNG7WuGcYrVrfsBhmnfgib3b67NDZ49aXVwaTTpy9b61OR3SmYW
	mT82etCS2Pmwd3iZz0polwL9rgYpjlTw7uyzr13cGpgJ2d0/dQn/rZI8GO7UWVFvO6UZJKH3Eif
	qY2Bs+qoBwbIkRTBi3DD3kHuPSZRO4G3l56qDyCM1mOC9XXy8V9uXeC2MZo3BOh5N6ZtaDgSd58
	moYkBNX76OqbnA7+msXsqBuS0qROBxiBnAiBOqQH6e0BsEvPv7zmJawK+L8pzEURwOh6JSEZFTT
	3EA/CkuqkyiFLY=
X-Received: by 2002:a05:620a:7088:b0:92e:4773:5a05 with SMTP id af79cd13be357-92e624aa5a7mr812235885a.4.1782844798653;
        Tue, 30 Jun 2026 11:39:58 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62191b18sm326961285a.18.2026.06.30.11.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:39:58 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 0/3] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Tue, 30 Jun 2026 14:39:52 -0400
Message-ID: <20260630183956.281293-1-dwindsor@gmail.com>
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
  security: pass inode_init_security xattrs via struct lsm_xattrs
  bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
  selftests/bpf: add tests for bpf_init_inode_xattr kfunc

 fs/bpf_fs_kfuncs.c                            |  79 +++++++++++
 include/linux/bpf_lsm.h                       |   3 +
 include/linux/evm.h                           |   9 +-
 include/linux/lsm_hook_defs.h                 |   4 +-
 include/linux/lsm_hooks.h                     |  16 +--
 include/linux/security.h                      |   5 +
 kernel/bpf/bpf_lsm.c                          |   1 +
 security/bpf/hooks.c                          |   1 +
 security/integrity/evm/evm_main.c             |   8 +-
 security/security.c                           |  24 ++--
 security/selinux/hooks.c                      |   4 +-
 security/smack/smack_lsm.c                    |  27 ++--
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/lsm_kfuncs.c     | 129 ++++++++++++++++++
 .../bpf/progs/test_init_inode_xattr.c         |  31 +++++
 15 files changed, 299 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c


base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
-- 
2.53.0

