Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656561FCE;
	Thu, 14 Aug 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178024; cv=none; b=IloV9WkJZ9d/PnNkXFj5PF5+A1oKsGFWQV/5OAYQybg5Itbhz9TESJTGANyrvbn9JGf0cvPY5fkTlzNcdgc17agFtYDPITs++vZJ8+FI2syrspg8LkclUGUD7k4wUKZaavaj1BwJjyIkozG5byR4s2S2Yx9fckzAyz6tqWFkmJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178024; c=relaxed/simple;
	bh=UcD34f71EMXNwxKv9TGa2nszdbtI2AnavnmAUojFOrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rcz1fmKdc8yGZs5e2mnLUovSYvrLiSD6Ea2uYCnJTpm8Uk7iXj6XTLID0DzKwemxQyeqPldouwVHfuDjvizhixLYoYs7mXqtgCcezMF05hu/NnMlqBg5AeJ4BvnvCBi5kj119cx58aeat05CmjI66fffNyKG7HEJ+ojFR7sOUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRHOF43/; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRHOF43/"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b1099192b0so15031521cf.0;
        Thu, 14 Aug 2025 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178021; x=1755782821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSDOuhvODkK4MCwnwZTbJcPFmtzu8Rja9xANf5AWCLs=;
        b=fRHOF43/52BQ6oapVXvGhB/FS+nZQfuwzr5+6j9az9yK0v0DNz0S+7ax7Lcn6q2Waq
         /XnByTpqmCZ0FmkKDHZ/6Ab6vfziA+QhfmKZk0QGAdXBUssB1Pw2Anw1Gs9BbFw+J7wi
         YrRGn+AKdhFH1k7UXmVOvh6WwE82iDoTA8uWoItvLGqOd28+/XQ7/gH4xKrjLIwBBB44
         5eTQRBfWVBSm7G9JtGXPiAzzz3f2nWn07SWyYQ1ldU07b0rLJh7H74P3i+us0urodXj4
         LK7OpZ1ayXgkxZtGTKg2OXQNO+J5/AYAadou8UN1UV3eSTqY7tyqoT1g7/8pXacPoHeW
         5JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178021; x=1755782821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSDOuhvODkK4MCwnwZTbJcPFmtzu8Rja9xANf5AWCLs=;
        b=BWW9OaVbY6UIKTZczy7Bb78SIEDp98Lq/XflW6kY1aJuLT519LSwIauUGad2APlejc
         yXdiGHnB49x4Nxl0EG5/0GX5tCaBNs2T8d0GLGLWGMulNh3MPA2SJyhQKQmnZBqKYHrg
         n+7BTOID/JJNQLBblxooo8gvstn2nRmURUyh7iLfAFUz2hvTshKRC5ErNsDitq8Ess9D
         cmS3DOeO/vVPMZ6zLe2F79Gh7G9lnhIZzu6kho0yw1FzvVTtDNhRm6rZosH09Z0FHpA9
         pSb/UtcOOLLoega5f3VAOwjuimm/2tyMCfSVKJ39fQvVsoxeKHNhde1DSBJ+QbMnn3Y5
         1QnA==
X-Forwarded-Encrypted: i=1; AJvYcCXsz5xuWzrSHytyGZiWL4IQj4dYvJLLj70IF/5pi8Ndno32sduQSJivniiQdjC4kgOeUqzFoQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNDLI+sBdcKSu8qqqLVFM/EXZP/MFSbqQbxigP9BRNhanMUeh
	ZNsWho6P4kqcmzqkGOhoOnrGN/74Th5HXeyKZrQC9k2uZC8d/tF9iVNOwONjIw==
X-Gm-Gg: ASbGncuAcFTMF+LVoj945MR4cwzy3PhnlCAY6RoDCTHQAKPM3VZEsvrg6gIuFeHqMMT
	a9UtFAFZT1bvVU7kgvtRsU5y/gQ2elimkrKQKx1KxAanV6tbszdNHb1m1TMdWyQI4i+AajRh4Qs
	8NQ8I4uHAcEoPTRP4NnpH2AA4EeEQwGX/l22p1MrST6HSDXp+tIwcJo+hmgDFjmCdENcbUmT1FA
	L6cRhqUaPSoprjlA6chVg0aeoSiJO7zPy+4LUAxRx1iraxo6zxbBkm3MZEIlRFdcxmVjYG+Wjws
	9t75xvLB2J0YFdr6wL0Ey4oETA2brJjLp/OkaVUaAVb2Lc2C6HpzZeVkuaP0fu0uiETUH/1yu3o
	L7LLAJ1tGhP6b0PHulOclgty3SkyW3w8Quuj689EddKnA33fxM6vyHe46kQ4kN3TrdtBOnISSd6
	AKZci0R7HcMpyC/EY0eIzd9dCcFnVxIPEv2/FV
X-Google-Smtp-Source: AGHT+IG9EDy/7wXpa+8zPe5XrunNR8dheLn75wuBzef8PjJuxmiTZUmrNo7oCDE8zcLr7cKOMBgk9w==
X-Received: by 2002:a05:622a:1189:b0:4af:890f:ff9a with SMTP id d75a77b69052e-4b10a9083a2mr40500181cf.4.1755178021089;
        Thu, 14 Aug 2025 06:27:01 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 00/42] SELinux namespace support
Date: Thu, 14 Aug 2025 09:25:51 -0400
Message-ID: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces support for SELinux namespaces, i.e. the
ability to create multiple SELinux namespaces each with its own
policy, AVC, and enforcing mode. This support can be leveraged by
Linux container runtimes to establish a private SELinux namespace for
each container, enabling the container to load and enforce its own
policy while still remaining bound by the host OS policy (if
any). Documentation and open issues can be found at
https://github.com/stephensmalley/selinuxns.

Performance data:

Baseline = v6.16-rc1 No NS = v6.16-rc1+this patch series with
SECURITY_SELINUX_NS=n Init NS = Same but with SECURITY_SELINUX_NS=y
from init SELinux namespace Child NS = Same but from a child SELinux
namespace

kcbench (automated kernel compilation benchmark packaged by Fedora,
run with 'kcbench -s 6.13' for 10 runs, computing average and standard
deviation): |CPUs|Baseline (sec)|StdDev|No NS (sec)|Init NS
(sec)|Child NS (sec)| | 16 | 123.88 | 0.24 | 121.85 | 121.67 | 121.93
| | 19 | 125.33 | 0.43 | 123.06 | 123.03 | 122.73 |

'perf record make –jN' on a fully built allmodconfig kernel tree,
followed by 'perf report --sort=symbol,dso' yields the following
percentages (only showing __d_lookup_rcu for reference and only
showing relevant SELinux functions): |Function |Baseline|NoNS
|InitNS|ChildNS| | __d_lookup_rcu | 1.74% | 1.72%| 1.72%| 1.82% | |
selinux_inode_permission | 0.71% | 0.55%| 0.58%| 0.56% | |
selinux_inode_getattr | 0.40% | 0.41%| 0.42%| 0.42% | | avc_lookup |
0.14% | 0.07%| 0.11%| 0.21% | | avc_has_perm/_noaudit (*)| 0.08% |
0.05%| 0.05%| 0.09% | | avc_policy_seqno | 0.02% | 0.17%| 0.16%| 0.16%
| | cred_tsid_has_perm | N/A | 0.07%| 0.07%| 0.10% | | Total SELinux |
1.35% | 1.32%| 1.39%| 1.54% | | SELinux/d_lookup_rcu | 0.776 | 0.767|
0.808| 0.846 | (*) Sum of avc_has_perm + avc_has_perm_noaudit
percentages.

NB perf record was done _without_ the separate neveraudit|permissive
types optimization [1], which would significantly reduce the SELinux
percentages for such types both with and without the SELinux namespace
patches.

ApacheBench (run with 'ab –n 100000 –c 1000 http://localhost/' for ten
runs, computing average and stddev): |Metric |Baseline|Std Dev|No NS
|Init NS |Child NS| |Time taken (sec) | 6.8071| 0.6764| 7.0198|
7.1344| 7.8451| |Reqs / sec | 14823.1| 1339.6|14353.2| 14163.3|
12858.4| |Time per req (ms) | 68.0721| 6.7646|70.1978| 71.3438|
78.4525| |Transfer rate (KB/sec) | 126691| 11499| 122675| 121052|
109899| |Connect time median (ms)| 27.8| 4.3| 27| 25.8| 30.5| |Total
time median (ms) | 62.6| 9.3| 67.6| 68.0| 77.0|

[1]
https://lore.kernel.org/selinux/20250521144123.199370-4-stephen.smalley.work@gmail.com/

v7 re-bases on latest selinux/dev, which is now 6.17-rc1 based.
No substantive changes.
I have not re-run the performance benchmarks again from the prior
version but could do so if required.

Stephen Smalley (42):
  selinux: restore passing of selinux_state
  selinux: introduce current_selinux_state
  selinux: support multiple selinuxfs instances
  selinux: dynamically allocate selinux namespace
  netstate,selinux: create the selinux netlink socket per network
    namespace
  selinux: limit selinux netlink notifications to init namespace
  selinux: support per-task/cred selinux namespace
  selinux: introduce cred_selinux_state() and use it
  selinux: init inode from nearest initialized namespace
  selinux: add a selinuxfs interface to unshare selinux namespace
  selinux: add limits for SELinux namespaces
  selinux: exempt creation of init SELinux namespace from limits
  selinux: refactor selinux_state_create()
  selinux: allow userspace to detect non-init SELinux namespace
  selinuxfs: restrict write operations to the same selinux namespace
  selinux: introduce a global SID table
  selinux: wrap security server interfaces to use the global SID table
  selinux: introduce a Kconfig option for SELinux namespaces
  selinux: eliminate global SID table if !CONFIG_SECURITY_SELINUX_NS
  selinux: maintain a small cache in the global SID table
  selinux: update hook functions to use correct selinux namespace
  selinux: introduce cred_task_has_perm()
  selinux: introduce cred_has_extended_perms()
  selinux: introduce cred_self_has_perm()
  selinux: introduce cred_has_perm()
  selinux: introduce cred_ssid_has_perm() and cred_other_has_perm()
  selinux: introduce task_obj_has_perm()
  selinux: update bprm hooks for selinux namespaces
  selinux: add kerneldoc to new permission checking functions
  selinux: convert selinux_file_send_sigiotask() to namespace-aware
    helper
  selinux: rename cred_has_perm*() to cred_tsid_has_perm*()
  selinux: update cred_tsid_has_perm_noaudit() to return the combined
    avd
  selinux: convert additional checks to cred_ssid_has_perm()
  selinux: introduce selinux_state_has_perm()
  selinux: annotate selinuxfs permission checks
  selinux: annotate process transition permission checks
  selinux: convert xfrm and netlabel permission checks
  selinux: switch selinux_lsm_setattr() checks to current namespace
  selinux: make open_perms namespace-aware
  selinux: split cred_ssid_has_perm() into two cases
  selinux: convert nlmsg_sock_has_extended_perms() to namespace-aware
  selinux: disallow writes to /sys/fs/selinux/user in non-init
    namespaces

 include/net/net_namespace.h                   |    3 +
 security/selinux/Kconfig                      |   65 +
 security/selinux/Makefile                     |    1 +
 security/selinux/avc.c                        |  783 ++++++++--
 security/selinux/global_sidtab.c              |  810 ++++++++++
 security/selinux/hooks.c                      | 1339 +++++++++++------
 security/selinux/ibpkey.c                     |    2 +-
 security/selinux/ima.c                        |   37 +-
 security/selinux/include/audit.h              |    8 +
 security/selinux/include/avc.h                |   76 +-
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
 security/selinux/include/objsec.h             |   46 +-
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
 security/selinux/selinuxfs.c                  |  553 ++++++-
 security/selinux/ss/services.c                |  468 +++---
 security/selinux/ss/services.h                |    1 +
 security/selinux/ss/sidtab.c                  |  105 +-
 security/selinux/status.c                     |   44 +-
 security/selinux/xfrm.c                       |   47 +-
 43 files changed, 4089 insertions(+), 1134 deletions(-)
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
2.50.1

