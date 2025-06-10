Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5465C242D70;
	Tue, 10 Jun 2025 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576179; cv=none; b=kyhe694e6hGQZHART408IJ4VYwM5QJTjLwFjvarJOLe8ODUUXvJbKn3DP1CRnkUqaWQyPoKeiVHSfWqBgA1rgucHmSFTQ2S+oXZwalrQIqTr1iiDG1IkeR1nSwe2l6NhI2fL89sVYRbqIRpGoJSJfILwKP3Wky5GqH74bPQQlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576179; c=relaxed/simple;
	bh=JjL3GdCIgR9i+DjoJupAZlvWtDSUebRlRKwHgCObpho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tmqh4UB5WNXWtkncRsy4TT5tM4m5bnf01ZcS3sbGzKvo8xBeUvP9J51ZkFQ4OU4Xd/QIwGZTSedRzvwDUkwSr9Fxt2EZr2U+wS9/OPfBL9Xw157mXckdNh58Y7R9gsWP/czpfi9iF/Nc3us0H84bPhAXV8uM8ccUFPXPfuCWSYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ncmf2I6t; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ncmf2I6t"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d0a0bcd3f3so7690785a.1;
        Tue, 10 Jun 2025 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576176; x=1750180976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kHNAnc+9j39p/QxNnqxx6s73FLJX9zuc3KzK4qBXMC8=;
        b=Ncmf2I6tc6snvzrfhWEKwAdD88AI11NVH5Q/lpBgatBI7JhH+L/3AZcSaA9Q2cd+2r
         SV/992GocFBu8DQD+JSFoVdrW/336ZHCPDwimzxvpnwCROwYdlevrDKCJibUnYnt2SWH
         dPyX+gWKhMSycPQ7FBRF7yDQNaHshNXDRZKyfe31YdSlsvwNZaaQOsgFjU9mx5v0LZyv
         QgSYsa8hD/qjqbQMLeZvMNgf8JPbVdx/36Qqg2T3Y328DvBt2pXpwILdDLPZclj/dkaU
         yKVEZjkoB8L24FwrjgW0LlBQYcEls6jIM3CXMSrY05TVKNz+tW/1BYs8WAhyW1xONtFS
         uUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576176; x=1750180976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHNAnc+9j39p/QxNnqxx6s73FLJX9zuc3KzK4qBXMC8=;
        b=KZSBp56YvLTJmI7y0z0cQB+QLSn++kRJwZq3tqRcTHD1skXwCL6lOBvdnViA9Z6Nfv
         jX0ppLUJNwNFGv7TMTEBF6G4XnC+ypCAsJ3iyYe6NfgQ3Le6G54Bhd3TncXPQZNkmktG
         evq2ezck8Z26nOuAC7bHX60CWNjwhbPlRE16Yxnrk9rNp8WaLhNxR/TbKra5xUMoHL+z
         Rl26kJEwHjPug8pWbvHYe4ScUzKqkYcP3tMjg/yhkZbHh2OJy9zPYQPHZqP/thuaaeNc
         +IwceDkZG1IUqWt9z4ejWv5yzSbJcqAP6vRX0R9Ug2Qkj7LLDl8KE6rv6Nqob/AHobMz
         vY7g==
X-Forwarded-Encrypted: i=1; AJvYcCXBt7vRZPjyXOz8tQ6EnZia5GzdUT9eH8NgPjyJKShljbKExD/70rkZPC1OSk4zx0CCyN7v398=@vger.kernel.org
X-Gm-Message-State: AOJu0YycQYa5qttlopTiWJizLt8tn6ELpB72N7oXhql0hu1BxBY2n83c
	EeIiZa3yver3NssWEv6glYbRMQJoe3GcX1/SIwrsk4GwTWPop8Vtvaesk8WNzg==
X-Gm-Gg: ASbGnctNxyTOZVC5nH3sBodCnJOsBwy0mifscJzEf9tuzXy+Kdop1bzYbNnFYqbHNNe
	0WW23eEO8Q2nFuCTFkKfsaIiDXHHrHNtxnqITusQgnY15+VKfYVOKoXZJcdr8kAHmQjLkab8BlW
	7/yOwRQdwcDWve/tIvn705iSeBBlY5savrPxz82cO9nbk16l5wjFUH8X0pJj5Fiw6wHSlYshuRT
	F08BSwXp0vHwLKduO6MtSYbFd2qwNM6Iwx41sCAtQlz611+w2OhlzvoltySohUB2TyZBI0bJpWk
	SM0i/KjuDylrUVbePNhd0rVumXMFXVVsmKV1fzzLFUOoyOGjshhGxSBfVyH4p0wkaqKqC0A0mSL
	Jtcr9IFXw2lFFbWQNI2nnKwKNwFhormYcFXzfpt/LW1+O0zdoBfDoNdWeddKuxl6QUQ==
X-Google-Smtp-Source: AGHT+IGk1ZntF/kL2IG3ZioM58MAz4HMBoGP5536pwPARs7cvLI+6s+syjK++VCPkk7+jF3PnsjXOQ==
X-Received: by 2002:a05:620a:248a:b0:7d3:89c7:684d with SMTP id af79cd13be357-7d3a88cfac6mr27171285a.20.1749576175728;
        Tue, 10 Jun 2025 10:22:55 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:22:55 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 00/42] SELinux namespace support
Date: Tue, 10 Jun 2025 13:21:31 -0400
Message-ID: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces support for SELinux namespaces, i.e. the ability to
create multiple SELinux namespaces each with its own policy, AVC, and
enforcing mode. This support can be leveraged by Linux container runtimes
to establish a private SELinux namespace for each container, enabling the
container to load and enforce its own policy while still remaining bound by
the host OS policy (if any). Documentation and open issues can be found at
https://github.com/stephensmalley/selinuxns.

Performance data:

Baseline = v6.16-rc1
No NS = v6.16-rc1+this patch series with SECURITY_SELINUX_NS=n
Init NS = Same but with SECURITY_SELINUX_NS=y from init SELinux namespace
Child NS = Same but from a child SELinux namespace

kcbench (automated kernel compilation benchmark packaged by Fedora,
run with 'kcbench -s 6.13' for 10 runs, computing average and standard
deviation):
|CPUs|Baseline (sec)|StdDev|No NS (sec)|Init NS (sec)|Child NS (sec)|
| 16 | 123.88       | 0.24 | 121.85    | 121.67      | 121.93       |
| 19 | 125.33       | 0.43 | 123.06    | 123.03      | 122.73       |

'perf record make –jN' on a fully built allmodconfig kernel tree,
followed by 'perf report --sort=symbol,dso' yields the following
percentages (only showing __d_lookup_rcu for reference and only
showing relevant SELinux functions):
|Function                  |Baseline|NoNS  |InitNS|ChildNS|
| __d_lookup_rcu           | 1.74%  | 1.72%| 1.72%| 1.82% |
| selinux_inode_permission | 0.71%  | 0.55%| 0.58%| 0.56% |
| selinux_inode_getattr    | 0.40%  | 0.41%| 0.42%| 0.42% |
| avc_lookup               | 0.14%  | 0.07%| 0.11%| 0.21% |
| avc_has_perm/_noaudit (*)| 0.08%  | 0.05%| 0.05%| 0.09% |
| avc_policy_seqno         | 0.02%  | 0.17%| 0.16%| 0.16% |
| cred_tsid_has_perm       | N/A    | 0.07%| 0.07%| 0.10% |
| Total SELinux            | 1.35%  | 1.32%| 1.39%| 1.54% |
| SELinux/d_lookup_rcu     | 0.776  | 0.767| 0.808| 0.846 |
(*) Sum of avc_has_perm + avc_has_perm_noaudit percentages.

NB perf record was done _without_ the separate
neveraudit|permissive types optimization [1], which would
significantly reduce the SELinux percentages for such types
both with and without the SELinux namespace patches.

ApacheBench (run with 'ab –n 100000 –c 1000 http://localhost/' for
ten runs, computing average and stddev):
|Metric                  |Baseline|Std Dev|No NS  |Init NS |Child NS|
|Time taken (sec)        |  6.8071| 0.6764| 7.0198|  7.1344|  7.8451|
|Reqs / sec              | 14823.1| 1339.6|14353.2| 14163.3| 12858.4|
|Time per req (ms)       | 68.0721| 6.7646|70.1978| 71.3438| 78.4525|
|Transfer rate (KB/sec)  |  126691|  11499| 122675|  121052|  109899|
|Connect time median (ms)|    27.8|    4.3|     27|    25.8|    30.5|
|Total time median (ms)  |    62.6|    9.3|   67.6|    68.0|    77.0|

[1] https://lore.kernel.org/selinux/20250521144123.199370-4-stephen.smalley.work@gmail.com/

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
  selinux: introduce task_obj_perm()
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
 security/selinux/avc.c                        |  782 ++++++++--
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
 security/selinux/selinuxfs.c                  |  553 ++++++-
 security/selinux/ss/services.c                |  453 +++---
 security/selinux/ss/services.h                |    1 +
 security/selinux/ss/sidtab.c                  |  105 +-
 security/selinux/status.c                     |   44 +-
 security/selinux/xfrm.c                       |   47 +-
 43 files changed, 4071 insertions(+), 1133 deletions(-)
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

