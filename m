Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ACD129A78
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836335; cv=none; b=o6Hf7Tmf08ZPHRYiRRk+d+E4JwOwcwbU2cQ4NzI9feDzGkwEsjYOt4oSUHLRQ04s+oFZL4Lfo//oPuUMGXZWnlVRvz3FpHOJAndsIOafjS0ybIH4zDfQDT59Xp/h994Q0Z1wm8yE4HmK8d2EH4lylhtlP372EZC0nDJr29/HLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836335; c=relaxed/simple;
	bh=9renvuZMZDRBspDE0hRBZc6FfvOq+ONPEG4EEIjz6QY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UX2qfjmOlUZ0k85s08QMhfYyoSY8uXbKadIpz8CnYr5p6VbfeQ6Et3SmGrUBjnapOvwmtFFg050wqnpjGrIqG6TMnNFdXjpFLzgxof7NU0c2ql9iI83LsKdXe6BzAXwzoHI9KbX3J3BeauilOFmh6vmmlmgNQeqCRuzNvwYq2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBM2mp9l; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBM2mp9l"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4678664e22fso101979241cf.2
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836331; x=1736441131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=86WEhTXnYRfpvmLMqkQx1m+h7i+9VQDrcZvnmKwsvjc=;
        b=ZBM2mp9laTmgHoVYAshg2KR4QrIR0NpcAy+ZqyvwwmzXDHeXVVWBersnpZZefAvjbc
         9UrpG/DOTWp+7/FuajiPAr15ng2H3366Vt4TorjBesIf8NDETQGmHhgFzAxNm8J4sIMl
         +zRfag0yZx0tzuODUj6ce1o3H8NxDqwOmYS47nKRGkgtsuqi5221KjgQy9aC6QiT5LSR
         Yj0yv0OodXGWOgZYbLp6B7kQEI8S3c6ec9y1Sn9bnBb7PFGXXdyufW1nYloGIjs6vLPn
         0cJYjZqK8fefM66Rde1od8vhXLvKFy613FazZhrFZiw+ca20mYwDzfAXn2t1qc+04tbI
         ywHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836331; x=1736441131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86WEhTXnYRfpvmLMqkQx1m+h7i+9VQDrcZvnmKwsvjc=;
        b=vSXYPgOrlTBK6BZUvUEclW51YiB+HTwbAdEotAYMJKGl2xpa9+kZAlIUc8z4CwW2+h
         uy7ryc3Q9uhHU6/qkF/lQbzbqpfaDcPD3/cHigTOY/KzW/suEgPBz9R0/vT08gVgYOdu
         Ur25nDoqt1a573D4/PxsGxIYsTbRxKYj5RYhFnCibARsboVYoGqVg8jrY6/lu/cQIwxc
         a00k9+AYd2PhoBo92oXQb8ZWOyCO8+j1vw1hRKna7m6ItgtiYwkl2E0mURg1HUVv7dbG
         bQxAS5lUvNFWNZ6DchwZ/kMnuX65v8V8X+oBu0pvc3UFQ9fX1Zw6VFODpqRafmGj+/vz
         R+Jw==
X-Gm-Message-State: AOJu0YwoTRFNaOchb9hmaKJYRpbauKOvB1ISMDQSvQCKP9VQquX6u+OT
	K9EsdZx+e96SFJIL6+uplqyXVqYSWUjd7fEbUSznwoagODg8eIb2BLt9Ug==
X-Gm-Gg: ASbGnctNeARkG0F+LLqiT5NqwXqEjGlJQRZ8AUYKYmkTSYbx0n013VKjW5QlJmBVZzK
	Bgib9jvUEgY9VmIOah2uEmUTmtHFRKS7D+u7ZBDna7YxhFzO7/gxyvABqE1r7pD+fKZb0l5L+IX
	GDdMLJKumBMzzL/cWh6nCtIgVwhYzEJTForLDH+1rwC4VKj8V3aXaeHvItejqFI4is1nS0cs9TR
	IR/ucbs+fukZJd61dOjKmaPn95Bafb7rPEeAUN8Q5h0s3pzfoEV71kRew7L2Q9eT4jMA/OGlKUu
	KeR+KWNy08dFEi4WR5At7asQbsQhf4dcBrWcKlMVyE+ZLlLIIeulDZpf4SxpwSfEMvLSiQ==
X-Google-Smtp-Source: AGHT+IGe18abhZHT7YoVEAc7VnuPrv2BAPiN0SJH6OxYOWN3Moig9RbnD6pgnBN8PedSqWJR9DenEg==
X-Received: by 2002:a05:622a:11d5:b0:467:6dea:7fe7 with SMTP id d75a77b69052e-46a4a8ccffamr770605351cf.12.1735836331482;
        Thu, 02 Jan 2025 08:45:31 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:30 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 00/44] SELinux namespace support
Date: Thu,  2 Jan 2025 11:44:25 -0500
Message-Id: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an RFC-only for the SELinux namespace support, just to
encourage early review and identification of any show-stoppers
with respect to the design and implementation to date.
Patches 0001 through 0009 are just re-based versions of the original
SELinux namespace series that predated COVID. The remaining patches
are all new relative to mid-2024 when work on the namespace
support restarted.

If you actually want to try running it, I'd recommend instead using
my branch which has an additional cherry-picked fix from upstream
needed to avoid crashing the kernel. This can be cloned via
    git clone -b working-selinuxns \
	https://github.com/stephensmalley/selinux-kernel

Configure the kernel as usual but add CONFIG_SECURITY_SELINUX_NS=y
to enable the support. More detailed instructions on building, booting,
and testing the SELinux namespace support available upon request. I
have been running the SELinux testsuite and booting Fedora,
Rocky 9, and Rocky 8 containers with SELinux enforcing within
the container on a Fedora SELinux-enforcing host OS, a Fedora
SELinux-disabled (no policy) host, and an Ubuntu SELinux-disabled
(no policy) host.

Known remaining issues include:
- Per-namespace checking of all relevant policy capabilities (currently
  done for the open_perms capability),
- Proper handling of peer/packet labels when they cross SELinux namespaces,
- Optimizing the implementation for the single SELinux namespace case,
- Review, and if desired, change the kernel interface for unsharing the
  SELinux namespace (currently via /sys/fs/selinux/unshare with a
  libselinux wrapper),
- Namespace-aware context mount options for sVirt-like setups,
- Namespace support for certain residual networking hooks that lack it
- Anything else noted in the patches themselves.

It is an open question as to whether some or all of the changes could
be merged before all of the above issues are resolved, given that
the support is only exposed to userspace if CONFIG_SECURITY_SELINUX_NS=y
and even then only to privileged userspace. I think at a minimum we
would likely need to optimize the implementation for the single SELinux
namespace case so that it does not introduce any significant overhead
prior to merging, or extend CONFIG_SECURITY_SELINUX_NS to actually
compile away the extra storage and runtime overheads introduced by
the infrastructure. Open to suggestions.

Stephen Smalley (44):
  selinux: restore passing of selinux_state
  selinux: introduce current_selinux_state
  selinux: support multiple selinuxfs instances
  selinux: dynamically allocate selinux namespace
  netstate,selinux: create the selinux netlink socket per network
    namespace
  selinux: support per-task/cred selinux namespace
  selinux: introduce cred_selinux_state() and use it
  selinux: add a selinuxfs interface to unshare selinux namespace
  selinuxfs: restrict write operations to the same selinux namespace
  selinux: introduce a global SID table
  selinux: wrap security server interfaces to use the global SID table
  selinux: update hook functions to use correct selinux namespace
  selinux: introduce cred_task_has_perm()
  selinux: introduce cred_has_extended_perms()
  selinux: introduce cred_self_has_perm()
  selinux: introduce cred_has_perm()
  selinux: introduce cred_ssid_has_perm() and cred_other_has_perm()
  selinux: introduce task_obj_perm()
  selinux: fix selinux_lsm_getattr() check
  selinux: update bprm hooks for selinux namespaces
  selinux: add kerneldoc to new permission checking functions
  selinux: convert selinux_file_send_sigiotask() to namespace-aware
    helper
  selinux: rename cred_has_perm*() to cred_tsid_has_perm*()
  selinux: convert additional checks to cred_ssid_has_perm()
  selinux: introduce selinux_state_has_perm()
  selinux: annotate selinuxfs permission checks
  selinux: annotate process transition permission checks
  selinux: convert xfrm and netlabel permission checks
  selinux: switch selinux_lsm_setattr() checks to current namespace
  selinux: add limits for SELinux namespaces
  selinux: fix namespace creation
  selinux: limit selinux netlink notifications to init namespace
  selinux: refactor selinux_state_create()
  selinux: make open_perms namespace-aware
  selinux: split cred_ssid_has_perm() into two cases
  selinux: set initial SID context for init to "kernel" in global SID
    table
  selinux: disallow writes to /sys/fs/selinux/user in non-init
    namespaces
  selinux: convert nlmsg_sock_has_extended_perms() to namespace-aware
  selinux: defer inode init on current selinux state
  selinux: init inode from nearest initialized namespace
  selinux: allow userspace to detect non-init SELinux namespace
  selinux: exempt creation of init SELinux namespace from limits
  selinux: introduce a Kconfig option for SELinux namespaces
  selinux: fix inode initialization when no namespace is initialized

 include/net/net_namespace.h                   |    3 +
 security/selinux/Kconfig                      |   54 +
 security/selinux/Makefile                     |    2 +-
 security/selinux/avc.c                        |  743 ++++++++--
 security/selinux/global_sidtab.c              |  758 ++++++++++
 security/selinux/hooks.c                      | 1309 ++++++++++-------
 security/selinux/ibpkey.c                     |    2 +-
 security/selinux/ima.c                        |   37 +-
 security/selinux/include/avc.h                |   78 +-
 security/selinux/include/avc_ss.h             |    3 +-
 security/selinux/{ss => include}/avtab.h      |    0
 security/selinux/include/classmap.h           |    2 +-
 security/selinux/include/conditional.h        |    4 +-
 security/selinux/{ss => include}/constraint.h |    0
 security/selinux/{ss => include}/context.h    |    0
 security/selinux/{ss => include}/ebitmap.h    |    0
 security/selinux/include/global_sidtab.h      |   22 +
 security/selinux/{ss => include}/hashtab.h    |    0
 security/selinux/include/ima.h                |   11 +-
 security/selinux/{ss => include}/mls.h        |    0
 security/selinux/{ss => include}/mls_types.h  |    0
 security/selinux/include/netif.h              |    4 +-
 security/selinux/include/netlabel.h           |   14 +-
 security/selinux/include/netnode.h            |    4 +-
 security/selinux/include/objsec.h             |   29 +-
 security/selinux/{ss => include}/policydb.h   |    0
 security/selinux/include/security.h           |  249 ++--
 security/selinux/include/selinux_ss.h         |  115 ++
 security/selinux/{ss => include}/sidtab.h     |    5 +
 security/selinux/{ss => include}/symtab.h     |    0
 security/selinux/include/xfrm.h               |    4 +-
 security/selinux/netif.c                      |   31 +-
 security/selinux/netlabel.c                   |   32 +-
 security/selinux/netlink.c                    |   42 +-
 security/selinux/netnode.c                    |   25 +-
 security/selinux/netport.c                    |    2 +-
 security/selinux/selinuxfs.c                  |  548 +++++--
 security/selinux/ss/services.c                |  421 +++---
 security/selinux/ss/services.h                |    1 +
 security/selinux/ss/sidtab.c                  |   14 +-
 security/selinux/status.c                     |   44 +-
 security/selinux/xfrm.c                       |   47 +-
 42 files changed, 3570 insertions(+), 1089 deletions(-)
 create mode 100644 security/selinux/global_sidtab.c
 rename security/selinux/{ss => include}/avtab.h (100%)
 rename security/selinux/{ss => include}/constraint.h (100%)
 rename security/selinux/{ss => include}/context.h (100%)
 rename security/selinux/{ss => include}/ebitmap.h (100%)
 create mode 100644 security/selinux/include/global_sidtab.h
 rename security/selinux/{ss => include}/hashtab.h (100%)
 rename security/selinux/{ss => include}/mls.h (100%)
 rename security/selinux/{ss => include}/mls_types.h (100%)
 rename security/selinux/{ss => include}/policydb.h (100%)
 create mode 100644 security/selinux/include/selinux_ss.h
 rename security/selinux/{ss => include}/sidtab.h (95%)
 rename security/selinux/{ss => include}/symtab.h (100%)

-- 
2.47.1

