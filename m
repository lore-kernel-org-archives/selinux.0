Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28011F1515
	for <selinux@vger.kernel.org>; Tue, 21 Jan 2025 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737502828; cv=none; b=mILy3cGCfcJmY4UUdGrcimJzEX81T2rDwm3UIhfdaqob+OFFrCNylQBkiACz8kAdW2yU5cGTeevWH+YXEHlHYDjuA395I7WINWZSQzYF2LZXrH869ERXx1KGGXW8OMgLjyhzCWT7qrqlf0gp4vQqYVOguTY0+del7D4+9RkVhPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737502828; c=relaxed/simple;
	bh=r03QFes6IFOxhf/HJnwsOFl/NvyFoqtNJu4O16zG7P0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=u+Tb3aYN8xcOejUpgCVJKRjDZvjKxd/QKMJOWyCnFTuf0/Po9H6MwYED8uYmyUTeZuHadOaCgmU0gd2tA3XyVhpvDgIuzvAihUOhNudjVTKigyTx/q4Na1JLKU/2PZOLv9ZI+omkSl+29azbv9/U5B7qPPByE8ziofO9pYL9Wyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HnikFCLy; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HnikFCLy"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-467725245a2so11598391cf.3
        for <selinux@vger.kernel.org>; Tue, 21 Jan 2025 15:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737502825; x=1738107625; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE0i6kb20DWpBSDBOpkyqoxMa6iQVxxTGWSIt0YyYu0=;
        b=HnikFCLykEeCsRwf47ZJTKm4SIIypC4ndjPjuMfVoeqO3/LUuaB3V8v8YiMzMe6+ln
         xhf48l+brL4oiE8LpCviUpxb2Hl2V7D3KxmYrT+pLdcGkQML+D4KL3sXG/bvF29wIiT0
         xs6ZHdqRWaSFhOE3byjl+AE79ggqMIWde4gzppyLTX0gW81JVUq+49SGaoXIEpL6Do2N
         HcAhGBl3kxTaXYf1SG2crek43YuOlEdEidTR7DgPF2nRsyCXiecAUjzRtqVOvI4CtDfb
         VvlcTHld1skSX0BgoZTFbeQCJbYYD8Tys6zTKA3PhtieiFy3zoxPrQO7qi1noMo1oiw2
         RNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737502825; x=1738107625;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE0i6kb20DWpBSDBOpkyqoxMa6iQVxxTGWSIt0YyYu0=;
        b=Tc6r2CrIrVxgxezakzK18pWl1xbLJpyPb+RHEVqs49wq8dF5Cmp8JKGoGKJTNDIiT8
         Lut+zNtEkxaKGS3KNYCtEHN3RCdsd8HF+pCf6K/Sy2bhMItEHnGGR4tU+Fbo+W84b1Lf
         sn2K0Jzu6N8QgLrkNOLH55qnAoOA4NXLSOpb8JB9XJteezWAeXZzQdrqOft9zlIgSmVQ
         8huDUuML3CgGXjniorjnT2jFMKhE8DBm0VLw03Gu4X3EWQjwctJsSWV6W4cMAzzArxF2
         /zhN+13I8kMjxsaoe8WCCHq3PQRfpeO9vveXYCr3KbMqHXISRUPb5a50S0v2k7vQ9Vv6
         QF0A==
X-Gm-Message-State: AOJu0Ywa6qYx/SBP1vNpYgAN1lhJ4rmthxns0+DfB2DUxPeM8xfaIpl6
	LEI2JrtnVKQPYcj8hRfs+HrHXrxfvkRpyOSTRWE32ZNo0GK3ynybCKTe3MdXdA==
X-Gm-Gg: ASbGncsGbGrdpcfVGJvvkF04m4cNIA7247gpfwFS2meCxvv6BIVGd6sf23Grj21rYen
	ks9+6L1AvGxtdzfJat5dZrIF8rFECOj5Ws8Pax07XLGmPTEw9wckRYuDWqIK3YnEaGxt++6vkrJ
	zUnLeVnuVsqesuWUchW/4EyB6Z+FGCnaxPyDrDDwo5gtJhtua9A5Qjfyr4dKm3XpDT0ysGjLHMH
	vSZzizQIkYSp7XZWSiuhMXgl/PKlYUvg5GGBbOfV+11duMuqJeZtz+DQy6bPrGN
X-Google-Smtp-Source: AGHT+IG6/cDRy0NriMPIYCFbswoi8z+2V8sAu37Y+BrObvorJ6UJsoJR5PDz+/pbpj9GiVbLrTbp3g==
X-Received: by 2002:ac8:57c2:0:b0:46c:77eb:42d4 with SMTP id d75a77b69052e-46e12a96f28mr278054841cf.22.1737502825607;
        Tue, 21 Jan 2025 15:40:25 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-46e1030dffesm59301681cf.41.2025.01.21.15.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 15:40:25 -0800 (PST)
Date: Tue, 21 Jan 2025 18:40:24 -0500
Message-ID: <d6c372031669fb475858e5f296fc8222@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20250121
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

A lucky 13 SELinux patches for the v6.14 merge window, the summary is
below:

- Extended permissions supported in conditional policy

  The SELinux extended permissions, aka "xperms", allow security admins
  to target individuals ioctls, and recently netlink messages, with
  their SELinux policy.  Adding support for conditional policies allows
  admins to toggle the granular xperms using SELinux booleans, helping
  pave the way for greater use of xperms in general purpose SELinux
  policies.  This change bumps the maximum SELinux policy version to 34.

- Fix a SCTP/SELinux error return code inconsistency

  Depending on the loaded SELinux policy, specifically it's EXTSOCKCLASS
  support, the bind(2) LSM/SELinux hook could return different error
  codes due to the SELinux code checking the socket's SELinux object
  class (which can vary depending on EXTSOCKCLASS) and not the socket's
  sk_protocol field.  We fix this by doing the obvious, and looking at
  the sock->sk_protocol field instead of the object class.

- Makefile fixes to properly cleanup av_permissions.h

  Add av_permissions.h to "targets" so that it is properly cleaned up
  using the kbuild infrastructure.

- A number of smaller improvements by Christian Göttsche

  A variety of straightforward changes to reduce code duplication,
  reduce pointer lookups, migrate void pointers to defined types,
  simplify code, constify function parameters, and correct
  iterator types.

--
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20250121

for you to fetch changes up to 01c2253a0fbdccb58cd79d4ff9ab39964bfb4474:

  selinux: make more use of str_read() when loading the policy
    (2025-01-07 23:14:40 -0500)

----------------------------------------------------------------
selinux/stable-6.14 PR 20250121
----------------------------------------------------------------

Christian Göttsche (10):
      selinux: use native iterator types
      selinux: add support for xperms in conditional policies
      selinux: supply missing field initializers
      selinux: avoid using types indicating user space interaction
      selinux: constify and reconcile function parameter names
      selinux: rework match_ipv6_addrmask()
      selinux: rename comparison functions for clarity
      selinux: use known type instead of void pointer
      selinux: avoid unnecessary indirection in struct level_datum
      selinux: make more use of str_read() when loading the policy

Mikhail Ivanov (1):
      selinux: Fix SCTP error inconsistency in selinux_socket_bind()

Thiébaud Weksteen (1):
      selinux: add netlink nlmsg_type audit message

Thomas Weißschuh (1):
      selinux: add generated av_permissions.h to targets

 include/linux/lsm_audit.h              |    2 
 security/lsm_audit.c                   |    3 
 security/selinux/Makefile              |    7 -
 security/selinux/hooks.c               |   10 -
 security/selinux/include/classmap.h    |    2 
 security/selinux/include/conditional.h |    2 
 security/selinux/include/security.h    |    7 -
 security/selinux/selinuxfs.c           |    4 
 security/selinux/ss/avtab.c            |   19 ++-
 security/selinux/ss/avtab.h            |   13 +-
 security/selinux/ss/conditional.c      |   24 +---
 security/selinux/ss/conditional.h      |    6 -
 security/selinux/ss/context.c          |    2 
 security/selinux/ss/context.h          |   14 +-
 security/selinux/ss/ebitmap.c          |   12 +-
 security/selinux/ss/ebitmap.h          |    7 -
 security/selinux/ss/mls.c              |    6 -
 security/selinux/ss/mls_types.h        |    2 
 security/selinux/ss/policydb.c         |  135 +++++++++++--------------
 security/selinux/ss/policydb.h         |   22 ++--
 security/selinux/ss/services.c         |   30 ++---
 security/selinux/ss/sidtab.c           |    6 -
 22 files changed, 170 insertions(+), 165 deletions(-)

--
paul-moore.com
