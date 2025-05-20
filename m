Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886EC4A21;
	Tue, 20 May 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742460; cv=none; b=cszxWqVv7q+UHWG4FPuVbdtFP3RRpeoWkcAc1OL4tdgPOePsyO5dh8sha0Z+Ws2dnvkeaSk7tu1MxO3ERu4ULxhMpOuHuE6lHVdNzTscuyzvAq8VrWc2GgNtyjpGlNSH+dm6/VDuss8y0IWSS20FKYHQzlMZ1fMrp5GPomogHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742460; c=relaxed/simple;
	bh=idCm440ri3VJsmTurGtai09etYfsnnfxLSDrS3n4M3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YW4nabq7ZaFnovFkMycJ5SJktXruWu8Jfhqh/zd21uflUkB4J+BoB4P2ZBlVgmGgsUZSHe+grnTGyjsArFpkIfjwEac9p4BASbFcalhlRIGgn9l178gSjB/s6oG/EWEDERQ+YddOPxuWtZP2n2XusGHtVeY4mqjTz6UEf2WQGIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoUEDSFb; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoUEDSFb"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7cd0a7b672bso367418585a.2;
        Tue, 20 May 2025 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742457; x=1748347257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2BB5f5jiKyfizxmCU27kme1C6lpYz8iUTFghXuoUbY=;
        b=WoUEDSFbFHbSAaZ8Sr0NJpz8W1Kf3TDW98gRJN25p73ziiPcSrb/lvoKLihvSSI0pM
         XAXi+d7BX3fS3gPtoJWHpksQBr+KgkHe2/+x5zTlbXBNTGbyVTzohrVu2u8xCBgftyMY
         57sE500exwpNFVPLacP492EBULKkzClirL5u9YgT/zNdQvuGdUcGM5vnoxsrV10uKpdD
         1vekmaK21sWtCfgO2Gmg6CfzW+CXQVIM/eGG0vViSvnX4xBE4+M1llOZ0lhmabdSuzvm
         sm6OKIh1vZ/WgO/Q9rd++2YYbY0xz5Ct4zFx2x8GreOtbE/VUIzj8oEyzQYDVqDlm3M5
         iKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742457; x=1748347257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2BB5f5jiKyfizxmCU27kme1C6lpYz8iUTFghXuoUbY=;
        b=gnDRbavQfc4BlwFTN7El36eGiBOfhjbkJOAW/qtWI71rvExereFtne8z7ue0KAfRw4
         NZHffSnBIubossSZrwi4DdsfAenYgSmWUBK4ulgKMLxPyvkIfAz7GLQRKmIQzlAkpZp1
         GxUVn8w1WBYchdq1VJ9DXuL3WbqWkdzrdlDcmWkYDJw2td32NpCODXvedzrttP/9uvIo
         3XN97b1S4aZ+BKERa2vUtbupajblhYN2DJBbF8HnQ107ZmzFEV1MZfdBNBSI+7KFiKUD
         c0w2zNRgQMojaoLJdyOLdIASaYICS+1pB3kJx2nuzBEDPHKQZFm7KI56/7tkI/2X760Y
         Tw5g==
X-Forwarded-Encrypted: i=1; AJvYcCVx/RkAOn+RvfZOFLvoGbM61dQoY8Mdgu98M0hL8OpEZudGO/W3YXoytci+5+QR4WDOVrp+eGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYoslkcYz0oNZlusCgTxWXIArp317y1X4AG/LgRvRZxq/D9FHE
	b94S+6CX7FPFn/VfLOpHs2zE1ua9zUJWYOzIkJ9EN9/sdfkGP+fxOvvlF784HQ==
X-Gm-Gg: ASbGncvgGiFzFfcxkKlmPgL1MwXvdkbiKUgc5neJy4wvhRw8lrPtN1NkWQc9+B1vOy2
	tWX5Lmsh6yMr5/TQdje6bJ0IeezmoHkj3hG927BbEc0jtuVD6HoTaOcDodtnjN6qbcyigo748Dl
	NvdsVrhXtPDtBwmQ1R2i5ltM9bTvoy1ZGNu4zzLQNo/vkNc0IFpGY9yRXH2bPz4lUTGcDVLdKWi
	3Ab5LTI/1CD9mRVzILm5HDrVkubZqFH5b1+CATQ6GPR6ijAg6K82xNqbdwnnGehY0irKrx8iZAU
	HML2ImnAt4VknIlybZ72eXo4UIoVw0/4gy7NzI7CkRM6GpAIyEVX6Ouykrn8gc9zHDBK4gYkT8z
	60jZubxZj7P3BNsOYPuG8Z+7FMLSWAOwklfnT1jc8CKewzs+FwPzbWg==
X-Google-Smtp-Source: AGHT+IGMdSBSj+lNSH4l1mpcADws+zROKcsydF3c/7BirNS5KjRmwrQwpQillG9qyyf9dUf6gT3YUw==
X-Received: by 2002:a05:620a:2849:b0:7c7:a5f6:2633 with SMTP id af79cd13be357-7cd46706f85mr2780109285a.6.1747742455622;
        Tue, 20 May 2025 05:00:55 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:00:54 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 00/42] SELinux namespace support
Date: Tue, 20 May 2025 07:58:58 -0400
Message-ID: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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

Baseline = v6.15-rc1+selinux/dev@05f1a939225ec8
No NS = this patch series with SECURITY_SELINUX_NS=n
Init NS = Same but with SECURITY_SELINUX_NS=y from init SELinux namespace
Child NS = Same but from a child SELinux namespace

kcbench (automated kernel compilation benchmark packaged by Fedora, run
with -s 6.13 for 10 runs, computing average and standard deviation):
|CPUs|Baseline (sec)|StdDev|No NS (sec)|Init NS (sec)|Child NS (sec)|
| 16 | 122.56       | 0.68 | 122.94    | 122.86      | 122.76       |
| 19 | 123.61       | 0.34 | 124.11    | 124.15      | 123.65       |

perf record make –jN on fully built allmodconfig kernel tree as per
Linus' description:
|Function                  |Baseline|NoNS  |InitNS|ChildNS|
| __d_lookup_rcu           | 1.68%  | 1.79%| 1.63%| 1.69% |
| selinux_inode_permission | 0.59%  | 0.53%| 0.46%| 0.47% |
| selinux_inode_getattr    | 0.37%  | 0.42%| 0.39%| 0.40% |
| avc_lookup               | 0.20%  | 0.09%| 0.11%| 0.22% |
| avc_has_perm/_noaudit    | 0.10%  | 0.04%| 0.04%| 0.09% |
| avc_policy_seqno         | 0.02%  | 0.15%| 0.14%| 0.14% |
| cred_tsid_has_perm       | N/A    | 0.07%| 0.06%| 0.11% |
| Total SELinux            | 1.28%  | 1.30%| 1.20%| 1.43% |
| SELinux/d_lookup_rcu     | 0.762  | 0.726| 0.736| 0.846 |

ApacheBench, packaged by Fedora, run ten times computing average and stddev:
ab –n 100000 –c 1000 http://localhost/
|Metric                  |Baseline|StdDev|No NS  |Init NS |Child NS|
|Time taken (sec)        |  7.7115| 0.805| 7.3128|  7.5505| 7.6774 |
|Reqs / sec              | 13112.2|1394.9|13731.8| 13443.5|  13155 |
|Time per req (ms)       | 77.1154|8.0497|73.1283|  75.505|76.7726 |
|Transfer rate (KB/sec)  |  112069| 11922| 117364|  114900| 112434 |
|Connect time median (ms)|    30.4|  5.95|   28.5|    28.2|   31.3 |
|Total time median (ms)  |    75.5|  11.5|   69.0|    70.4|   73.7 |

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
  selinux: disallow writes to /sys/fs/selinux/user in non-init
    namespaces
  selinux: convert nlmsg_sock_has_extended_perms() to namespace-aware
  selinux: init inode from nearest initialized namespace

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
 security/selinux/selinuxfs.c                  |  551 ++++++-
 security/selinux/ss/services.c                |  453 +++---
 security/selinux/ss/services.h                |    1 +
 security/selinux/ss/sidtab.c                  |  105 +-
 security/selinux/status.c                     |   44 +-
 security/selinux/xfrm.c                       |   47 +-
 43 files changed, 4070 insertions(+), 1132 deletions(-)
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

