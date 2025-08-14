Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E0279907
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212044; cv=none; b=DO/Lxya1Zmi+FODtPhJG/DA2G9hLQca/nttG2kpw1I5Y84cwj4tOYodKGhGqSLASDGn89fkKkid74X4h93s9DUYUKyqjopqdUAFWe/ILZG6nNRftVfRMyy3gMDn+HvhyZ+bsGcG0aa+Z0sxoc6Ia14/zEPV5VdfEhvvtgGmlve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212044; c=relaxed/simple;
	bh=lPdhiCA/2A43VbIVwb+6dc6qvHinv/k9x8LvcHDmb0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U7J3NJ0k3pL8jP24hiFHASOOgM9UdLNnWVIx7A3s9VRQRtf/aAGRAQ0JStMVx4W4+n9B0hRa/UNSuh42PAAw0T/FfiGH6dJrWP3cSMYO9ugiEEkQBGWLVjt/KnBDTUIFMDZXHwfag/GJlhtCGalzZkzQfIcKeIrAnXGm1t79BEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AogRvOMz; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AogRvOMz"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70a928cca6aso8611956d6.2
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212041; x=1755816841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rU+UOhNaqwsjYUe9zCIc66XJqDaw1SHKCGrAl1D5PcE=;
        b=AogRvOMzaFUZ51nWudmhtAvLKQCPMxqJUq+rBRtFaD2riJZxFdRHldR2u/TgsOUSf/
         Kx7zSQQ4429F+1g88MMVWsnzgE5aEjKFmLiVOiARaJmci/9GfiUKf7nize1TPAZSs90h
         KD3To7XCDJSUGXCsSjGyjrJh55+6ZbJVj6AmDY3MVqjWGolPJ/3aEckmxKv+++Pr7RyJ
         rsG7WdOXGb8P2Di//vFkJP3oDMugQ8Tfu1VKnnDqQLpbsFGAR0pO/Sv7n0nTdsVa+BFj
         FNChCiWMkjapDGL2clII37p0oM+d6Qb1nJVJPdcPPBXwAsYuFzH0qEmBOmBeIcZDPXw8
         bYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212041; x=1755816841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rU+UOhNaqwsjYUe9zCIc66XJqDaw1SHKCGrAl1D5PcE=;
        b=O/0GqzpaJcjMZxX1WYVL7+WiAtxrpmU+J6fU0db+dX1xFbpXwwcvM1aoEG3YYq3xIB
         gX0BP3OQWB9FobZMhN5kzLVBHGLs0/dKtck/NRLY3kdk2jzn+VWgY0yJ9JFs16ZFbtJa
         ze3mr8x/G17DIGdM+QHVFrpeVlUQ919WVx1ErQ1K2reP4v1d6558gTAyySSu3/1PWznY
         U9D1CkyEYELIRDORUGkonT5ZeqEEIz/wuUnnc+Cw8XcGh1nRBV7mRkaVSc77retCXWdU
         d0r9PxmHsuvWiwOZorEyIo7Pjc5j2S96fbE/aWwjlRVBH0V5ESEIUO4lzPAgX7f/Ln1s
         t5Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXgjfZlYTJa5lbS5GODWRSFU6B2lIMy06jnZh1RNNQ7tFyGnj8bZEL+PPrwOyQBWm2v9+iExmnd@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFh9ISzC+1ZJlBsKAg1sNouTX6BRi0iLZQny75DXSK6VB2g3M
	Q8u8xmp3w76vwhqKkPBiNL0rSB/J0exvywAAv6YfiFhB1zHfCwmgSKM5iiSDU3udDA==
X-Gm-Gg: ASbGnctlXUOr/F7M/reLFSGRuJDj04jADsSnatgdcDrovC3w1G8iFeOmnm7VQmbDjgo
	J869RRf3RfJyH+OMi5Ywy0CJNekfBHbgAgx9LBHU4Zoyk1QEssrhB3tlQjERkqg23mTSGa8baco
	/AFA3oXKmcl+SKqkMFvHQPVD9mPLFlSy/xIMyv2Oz11xfm2xqeaKMy4FwoDrxDNs7FamWayoK5y
	1g9Q28dlNTPElH52WMK65NIEbaip0g2Ic2ShdaEJoGUOakAfAz+9asc24s4vsejZPCX6j9YBfb0
	eqnvqaT7HnukxycQP4qbYl1+0EiOTZ3x0nyzBUeR5Kx02IsngWPp10gEOYQL3viLDaCIRhpcFYi
	fyq9U3lfjwcgebqm79yTxqFP2adbTTWTiDifoB6Yi70VSg2eoCLyxrPAoRSj0hpMalo0=
X-Google-Smtp-Source: AGHT+IEjObLWGd1F0gHvu1/FHumZZNzME/HV+XYLewREMJxt9Y3k5V3pQZrwrK7pJHvmnr4LC13rqQ==
X-Received: by 2002:a05:6214:5013:b0:709:dff6:9b8e with SMTP id 6a1803df08f44-70af5ccd897mr83782626d6.36.1755212041097;
        Thu, 14 Aug 2025 15:54:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70adc1cd165sm19419346d6.8.2025.08.14.15.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:00 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v3 0/34] Rework the LSM initialization
Date: Thu, 14 Aug 2025 18:50:09 -0400
Message-ID: <20250814225159.275901-36-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The third revision of the LSM initialization rework patchset.  While
there was a good deal of change between RFC/v1 and RFC/v2, the number
of changes in the v3 revision are relatively minor; I think the biggest
change is simply bringing it up to date with the current lsm/dev branch.

Please take a look if you haven't already, and to my fellow LSM
maintainers, please focus on the patch associated with your LSM and
either send me an ACK or reply back with the changes you would like to
see before this is merged.  I think we're in a good place with this
patchset, and I'd like to get this merged during this dev cycle if
possible.

The RFC/v2 patchset:
https://lore.kernel.org/linux-security-module/20250721232142.77224-36-paul@paul-moore.com/

The RFC/v1 patchset is below, the cover letter provides some background
and motivation for this series which still applies:
https://lore.kernel.org/linux-security-module/20250409185019.238841-31-paul@paul-moore.com/

CHANGELOG
v3:
- rebased to lsm/dev branch
- fixed IMA/EVM initcall comment (Roberto)
- fixed CONFIG_IMA and CONFIG_EVM problems (Nicolas, Roberto)
- fixed CONFIG_SECURITY_SMACK_NETFILTER problems (Roberto)
- fixed the IMA/EVM header file include macro protections
- fixed an off-by-one string length issue in lsm_read() (Casey)
RFC/v2:
- rename lsm_prep_single() to lsm_prepare()
- drop the lsm_prop counting patch
- drop the platform_certs changes from the IMA/EVM patch (Mimi)
- split/reorder anough patches in the patchset that I lost track
- added missing function comment blocks in the SELinux patches
- split patch 04/29 into smaller patches (Kees)
- fix an LSM list output problem in an intermediate patch (Kees)
- preserve the "lsm_active_cnt" variable name (Casey)
- cache the lsm_read() string (Kees)
- squashed, split, and reordered the enabled/ordering patches
- reworked the Smack patch (Casey)
- conditionalized the SELinux IB init code (Stephen)
- fixed missing Smack "__init" annotation (Fan)
- fixed a potential unused variable warning in IMA/EVM (John)
- fixed the placeholder commit descriptions (various)
RFC/v1:
- initial version

--
Paul Moore (34):
      lsm: split the notifier code out into lsm_notifier.c
      lsm: split the init code out into lsm_init.c
      lsm: consolidate lsm_allowed() and prepare_lsm() into
         lsm_prepare()
      lsm: introduce looping macros for the initialization code
      lsm: integrate report_lsm_order() code into caller
      lsm: integrate lsm_early_cred() and lsm_early_task() into caller
      lsm: rename ordered_lsm_init() to lsm_init_ordered()
      lsm: replace the name field with a pointer to the lsm_id struct
      lsm: rename the lsm order variables for consistency
      lsm: rework lsm_active_cnt and lsm_idlist[]
      lsm: get rid of the lsm_names list and do some cleanup
      lsm: rework the LSM enable/disable setter/getter functions
      lsm: rename exists_ordered_lsm() to lsm_order_exists()
      lsm: rename/rework append_ordered_lsm() into lsm_order_append()
      lsm: rename/rework ordered_lsm_parse() to lsm_order_parse()
      lsm: cleanup the LSM blob size code
      lsm: cleanup initialize_lsm() and rename to lsm_init_single()
      lsm: fold lsm_init_ordered() into security_init()
      lsm: add/tweak function header comment blocks in lsm_init.c
      lsm: cleanup the debug and console output in lsm_init.c
      lsm: output available LSMs when debugging
      lsm: group lsm_order_parse() with the other lsm_order_*()
         functions
      lsm: introduce an initcall mechanism into the LSM framework
      loadpin: move initcalls to the LSM framework
      ipe: move initcalls to the LSM framework
      smack: move initcalls to the LSM framework
      tomoyo: move initcalls to the LSM framework
      safesetid: move initcalls to the LSM framework
      apparmor: move initcalls to the LSM framework
      lockdown: move initcalls to the LSM framework
      ima,evm: move initcalls to the LSM framework
      selinux: move initcalls to the LSM framework
      lsm: consolidate all of the LSM framework initcalls
      lsm: add a LSM_STARTED_ALL notification event

 include/linux/lsm_hooks.h              |   73 +-
 include/linux/security.h               |    3 
 security/Makefile                      |    2 
 security/apparmor/apparmorfs.c         |    4 
 security/apparmor/crypto.c             |    3 
 security/apparmor/include/apparmorfs.h |    2 
 security/apparmor/include/crypto.h     |    1 
 security/apparmor/lsm.c                |   11 
 security/bpf/hooks.c                   |    2 
 security/commoncap.c                   |    2 
 security/inode.c                       |   62 ++
 security/integrity/Makefile            |    2 
 security/integrity/evm/evm_main.c      |    8 
 security/integrity/iint.c              |    4 
 security/integrity/ima/ima_main.c      |    8 
 security/integrity/initcalls.c         |   41 +
 security/integrity/initcalls.h         |   28 +
 security/ipe/fs.c                      |    4 
 security/ipe/ipe.c                     |    3 
 security/ipe/ipe.h                     |    2 
 security/landlock/setup.c              |    2 
 security/loadpin/loadpin.c             |   15 
 security/lockdown/lockdown.c           |    5 
 security/lsm.h                         |   42 +
 security/lsm_init.c                    |  563 ++++++++++++++++++++++
 security/lsm_notifier.c                |   31 +
 security/lsm_syscalls.c                |    2 
 security/min_addr.c                    |    5 
 security/safesetid/lsm.c               |    3 
 security/safesetid/lsm.h               |    2 
 security/safesetid/securityfs.c        |    3 
 security/security.c                    |  623 +------------------------
 security/selinux/Makefile              |    2 
 security/selinux/hooks.c               |   11 
 security/selinux/ibpkey.c              |    5 
 security/selinux/include/audit.h       |    9 
 security/selinux/include/initcalls.h   |   19 
 security/selinux/initcalls.c           |   52 ++
 security/selinux/netif.c               |    5 
 security/selinux/netlink.c             |    5 
 security/selinux/netnode.c             |    5 
 security/selinux/netport.c             |    5 
 security/selinux/selinuxfs.c           |    5 
 security/selinux/ss/services.c         |   26 -
 security/smack/smack.h                 |   14 
 security/smack/smack_lsm.c             |   11 
 security/smack/smack_netfilter.c       |    4 
 security/smack/smackfs.c               |    4 
 security/tomoyo/common.h               |    2 
 security/tomoyo/securityfs_if.c        |    4 
 security/tomoyo/tomoyo.c               |    3 
 security/yama/yama_lsm.c               |    2 
 52 files changed, 1043 insertions(+), 711 deletions(-)

