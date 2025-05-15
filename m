Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667B529712C
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314608; cv=none; b=bX2QpVV6YGPBwqMh2XGbMr5SaYSWZwvblhAilute0UQFLS7r9W/mNq2NV5H7HjRtdQyUTAXg1/EgXQpUTW52zYykcVy3FOibGbhbCeLYju6AweBBXcrdaR8gARz8jgDkvkK4AOsZ00WSlhcpRYU4a8D9amEalw24X7FwiwKpVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314608; c=relaxed/simple;
	bh=/+58daoTs64tLd3InmhTrS+VclCt+/aNm6Ye1MNcevs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pPQljZyedt2n1F1Yy95BtLvBWbG4IvS+1fvtNhtkehlFdp25QY98AFkxWrB7B0hUMbfoMCViZfAaiHzmV7p0VehLSE0bONBeomlVPi8yUinHA4II2NEU1oUmplw49WfgfK3g5akhrC3KzyuNZEqFUJ7UjySpnuZnTTSkMF394V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vb7+QKLG; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb7+QKLG"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476b89782c3so10432431cf.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314605; x=1747919405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pdj3Lcx8MSxozoHYaaU5VQ11wGs8ZxfeUVzNhHivX14=;
        b=Vb7+QKLGjxgs7BS68w4bWrzCPi19lcruzrZSrpHQfKVj2p/7ZtfLgsQixO7v6yY+eR
         yrV5v3Jz0369gb4jsAWMwkaQNrCf/k9ldYHC6rYhFSZUEmuYmU8Zl6jQhshUXN11v5Yo
         iDvoNBlYT13XqFZjqiJaeyUZt8OW8H0v/fyWAQdtz0GPvfmYS0fIyv9IwIbWro5rTIlz
         6lNRD+qmZW7J0l+6hoiWXjA41sa/rqE1xd6l0oqAvMWEHk//E1h980+D/p1oZJE89FZl
         8mwuZ7gtgH0nrNNY23YnvTs9Xi4zsbe/4jK+7BGDbHvA3QEmnc4rz0IXhTAxsH59PvVy
         94Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314605; x=1747919405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdj3Lcx8MSxozoHYaaU5VQ11wGs8ZxfeUVzNhHivX14=;
        b=lJ00328jwai1vc/440UDp+8hJhncl8b6zWbBwWVesSsd5ZCShQ9d5+mmMJ8BB2La2b
         Os5rTVc6wDnJHPHXchf9KuD9Ttx4EJF1Hm28N1GDj39Lz17COxRnpp1esK44vgHIEKH/
         I/ClKuvPZv2fKbvMgWv6z7TSGPA3hfEOMm3ksGYCRx7WcsV8R/JcaPhxu5oQ38KChibZ
         v0G1FSwgOwY34mRxgtXNvfDXeQ4tOUjdIubtin4+W1z54aormScgyThOEBODsfRbGwAA
         L06aieZpTzg5r+9roO7oL0pygvKCl/AGTjN2BQhrrub6dbmqhAWVAAnsSeMLssE3d1Xk
         bc1Q==
X-Gm-Message-State: AOJu0YwNhpb5OxeFvG+CHJ5251AhxJG2Ky8StQrdJTeVLcfWpfqYR78c
	MB09BjGo8mzJpL/FBp3lntu4UmJxqcj36Lp54WIfuROppCuGAh+ux3OPAg==
X-Gm-Gg: ASbGncsvXIStPZtd+81pV+QbWui751osjaU4rYwWe7wEagDtobeMN8xwVv6PrNWHoHf
	2yf+KmQYnpaeG9GXG0ayKLRtZX07iRvddEpFfc5delzCVvMirfoP3iRFwZ1nB8P3A+BCZj8egP8
	y6SDnQ0IfHKDLo1OPlt2ZPu7eo9XgommptQFEbNRbAskXVmndSg49voV41ZBn173VnVUlSOAJcc
	haeBCYz/+vV2qRER0w3CDH/NqdF7avEnG+K8wPBV9kdEDX/pmoVvC5eKeV1y6MMmHTJH3JRueXS
	Pum0CTe+a/EE4xStB3DQxbXtmRkDQgK+q4afCOuBOGK5HxSMjY4avgMmYJjhizli00VyLo7q+OP
	CH+0tivpVy6PLtKZyZkIubAKWYpm4lnADGwaerIZD8fX9khXnxk37FA==
X-Google-Smtp-Source: AGHT+IFLUPW7sU+n/y/IHQHuYZkeUqjlkcvBzjQF8mvWVFp4cC/FQiaxWvr2OBXTB0PvF+O/vfOm+g==
X-Received: by 2002:a05:622a:4cc6:b0:494:a2e9:4853 with SMTP id d75a77b69052e-494a2e9485fmr45015541cf.44.1747314604849;
        Thu, 15 May 2025 06:10:04 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:04 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 00/49] SELinux namespace support
Date: Thu, 15 May 2025 09:08:58 -0400
Message-ID: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces support for a SELinux namespace, i.e.
the ability to namespace the SELinux policy, AVC, and
enforcing mode. This support can be leveraged by Linux
container runtimes to establish a private SELinux namespace
for each container, enabling the container to load and
enforce its own policy while still remaining bound by the
host OS policy (if any). More information about SELinux
namespaces can be found at the following URL:
	https://github.com/stephensmalley/selinuxns 

Stephen Smalley (49):
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
  selinux: init inode from nearest initialized namespace
  selinux: allow userspace to detect non-init SELinux namespace
  selinux: exempt creation of init SELinux namespace from limits
  selinux: introduce a Kconfig option for SELinux namespaces
  selinux: eliminate global SID table if !CONFIG_SECURITY_SELINUX_NS
  selinux: maintain a small cache in the global SID table
  selinux: change /sys/fs/selinux/unshare to check current process state
  selinux: acquire/release SELinux state properly in socket hooks
  selinux: update cred_tsid_has_perm_noaudit() to return the combined
    avd
  selinux: repair security_fs_use() interface and its users
  selinux: style cleanups for node_sid prototypes

 include/net/net_namespace.h                   |    3 +
 security/selinux/Kconfig                      |   65 +
 security/selinux/Makefile                     |    1 +
 security/selinux/avc.c                        |  782 ++++++++--
 security/selinux/global_sidtab.c              |  810 ++++++++++
 security/selinux/hooks.c                      | 1339 +++++++++++------
 security/selinux/ibpkey.c                     |    2 +-
 security/selinux/ima.c                        |   37 +-
 security/selinux/include/audit.h              |    8 +
 security/selinux/include/avc.h                |   77 +-
 security/selinux/include/avc_ss.h             |    3 +-
 security/selinux/{ss => include}/avtab.h      |    0
 security/selinux/include/classmap.h           |    2 +-
 security/selinux/include/conditional.h        |    4 +-
 security/selinux/{ss => include}/constraint.h |    0
 security/selinux/{ss => include}/context.h    |    0
 security/selinux/{ss => include}/ebitmap.h    |    0
 security/selinux/include/global_sidtab.h      |   26 +
 security/selinux/{ss => include}/hashtab.h    |    0
 security/selinux/include/ima.h                |   11 +-
 security/selinux/{ss => include}/mls.h        |    0
 security/selinux/{ss => include}/mls_types.h  |    0
 security/selinux/include/netif.h              |    4 +-
 security/selinux/include/netlabel.h           |   14 +-
 security/selinux/include/netnode.h            |    4 +-
 security/selinux/include/objsec.h             |   43 +-
 security/selinux/{ss => include}/policydb.h   |    0
 security/selinux/include/security.h           |  473 +++++-
 security/selinux/include/selinux_ss.h         |  119 ++
 security/selinux/{ss => include}/sidtab.h     |   34 +
 security/selinux/{ss => include}/symtab.h     |    0
 security/selinux/include/xfrm.h               |    8 +-
 security/selinux/netif.c                      |   31 +-
 security/selinux/netlabel.c                   |   32 +-
 security/selinux/netlink.c                    |   42 +-
 security/selinux/netnode.c                    |   26 +-
 security/selinux/netport.c                    |    2 +-
 security/selinux/selinuxfs.c                  |  551 ++++++-
 security/selinux/ss/services.c                |  453 +++---
 security/selinux/ss/services.h                |    1 +
 security/selinux/ss/sidtab.c                  |  105 +-
 security/selinux/status.c                     |   44 +-
 security/selinux/xfrm.c                       |   47 +-
 43 files changed, 4071 insertions(+), 1132 deletions(-)
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
 rename security/selinux/{ss => include}/sidtab.h (81%)
 rename security/selinux/{ss => include}/symtab.h (100%)

-- 
2.49.0

