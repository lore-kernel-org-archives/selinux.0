Received: from sonic313-22.consmr.mail.bf2.yahoo.com (sonic313-22.consmr.mail.bf2.yahoo.com [74.6.133.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D012E56A
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718533; cv=none; b=VAnWxcEYQI7SIekkfA1nukLp8UltqwWp2gmk8bJKEIqVmxarmRHrLOugfcTuyN1DwRgePuU4puRDxhJmswjxEx4e0BXgAjlcdeG37uD3Vy/A6FiaRbDZT9XCpTIpi2gRrBV8RpDbnPY+npKVMNGYeR9Hyyr2CSr1luRxrBH7gDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718533; c=relaxed/simple;
	bh=6VSn9m0+4gEQ/QemkSdtlH1FACIinNvkgPUOAlJPnQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=uw5UGJwG3ZqeoTrCxO8DSkeu2Tmsc6+W7diJlDUwXgYXDXWck6S1vPTZhcTYPyZTk7ZuJEzLzBqnC8VOjsFjAO2reYjYi0vEKQ+MgNFlHcUJ3M/Yl85+pxXLy6UL5usNVJRhb8ZK0zStJTqxdQuGcwQVOP6ZJxgAtiQMoHNJTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=I0UqB5YY; arc=none smtp.client-ip=74.6.133.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="I0UqB5YY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729718524; bh=3qg/Mtih7gPvp6NyFPLR4Rs2mLIKzdNL25OcNztnx2I=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=I0UqB5YYeXK8/lVjDZk69SCVbmlZB5cUQYsfsdK4bXuZiT9vaqC7kxJ/j2GF4YeGwKXjQb7KaD+FlmEZi/TTM5xNkx2kOe5lKCI/EKgeWYgQuJx9a4kG8u13NO6QxVxmtefJ76bLeppDms0Vb/Q66k2rtC5N5XmdV+iVgbbAX8ONYxDJGq02rB6O+Oek6V8iinLqoDIlyz9uIW2I0r4l6GmtgLiP3p0hDUHqsfOxxNFyUhIyHUJb8qoEGfYFrr1q6DElq72vEBWm7LMoFO+atFs6idNKmipsMuaEYjd2jefti3YK/oDXxjI9JFO0mjl4H3nmlW+JcdeDNWdCz2qaeQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729718524; bh=DpOqfmqrutMNJNlWP4j9QWtg9YOcj8qMzHXGeJCw7DH=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PKtT93bjVAeE6Ed/D/RoiGMOhgqeb5feFrQwfbquv+DmAEt2WTyex0QSK7ViAOxSpO+5+xg1FfSuFy7+o0/FARC1uVVcXyIYXmzMlZK0dhBfwN7BNjMq1apaRNf5ow368i4l9kWUlS0OmSVWYQ7XNj9t9Eq6b2RBixuND4et6eoGs+iL4nhX6SUfW7gKBEFMYygoULu0xHSbFr4++aUnntscDy4jDXx+8LYDN+6sxuYCIGC7EsoGAOPq1aCCrkCU998K6fYJ3pm4XoDb/SPruZi+4pQhQAmc4kiHgO4HiLIvCCz7u7256Jn6fzWKsKSc/bPfHAeV+eWHOAbbCp0zDQ==
X-YMail-OSG: AZNQGCkVM1lC18jb2sMmPVhEat2tyNN8dwKODTN6VzbUXxK0H1V5EYHwQaDZffx
 EERpTdR0NLzx14quO7sk_os9huiJsr.v90Yo6YiIMRqvWXsnrpeSEtU94PpSvEsA5edvGt7ItpUI
 Vlk0xqn5Yn.vxO7.5AhJyDTfEtUDPqdH7ZhalcrCUJXh_hkO5hiZ30SMrLAN0oQodS_cSP_Tp42B
 CpmCvbY6s_GJUMN2NTvE.1dqATikWp6PoX8VYa35Re8tWw0o1z9VoyZk21mdF0ySIYHAOG30.UGW
 tBkZBuYxZz9OAqJK7OTG2WJd6b5JVZiA9csIh48GV.VGg4_XFvtlDKpPtiZK9BpNko0hw4KXXhtw
 QOl24rjU6oCo13bGZf.1PrXGYxHkb8E3hlCFiBkrtRO0OZRWuVb0M5yvR4Ev8BKD3cZbEE.2No91
 ZCRnyU8pQERQLMXRHkq4TI8rusRoFT9Eu2fzjlHlgAA9REaZSCNjb1d5VLuS4Gi8ZqIDbirupNEU
 nIyPt3Lwvy7LopwUp4DkNCHSsIC8MashS7OVrwMazYY4fVghFGv2m25asb3Vybh86nrEBqBSIdbB
 H88DTSet4sgVHctMhsjZJhqYNFWWer9GeQLL4RDB3hMxnIyxPNdkHpoxdn_1TvpZdFNZyWGyiU4.
 4a5fZHIQqAnuX_jJPIAFKO6nV7xPH1ZM8pzDEiYchiLSmpwXXXVtIxIkvgNU1yaP6IxwzjbPSg_Q
 .gZEE_0J0lSwB4IrqmzKP264jsClSg7DOHRFqkGxR6enV1FtAdmG36zRKwMiiV50BXMEvARcSGzl
 Ibaz02Mt1nPixPTd1itNhYXl365ZFX59rUOK7PPlR6Y0yTdItbRh.RB84yV5aOfUWeBpCPvxKcXz
 6eed1Z16SKTEkfEhBtgueThlLNBxKB78ldl7ao6L89pqtZ5qHLC_yq686IdlXktb99I9EifN4u2.
 kztnlkIqxidGlx7cwK_hliW2lEHR8mZEasAmS4qzkIAUT_KxJsNdPJDMjwOdVFqHUVCPKZr7H9U3
 KwBndkZIBGGuAXWxEeszUIyQ8IctcQzoD586ZIUO0RI_2WMWu_ZQrtHwuRx_bhsNDOM6TBPwwqgH
 bkDlIea4NC.jQUvUDn7glQHJv4eAWyLuUU.be8JakiYFdqvd8Au6AtC9WpEJtGTPJM4grJfOE2Gn
 5nbPA0UUKEe3pJCPWyH5Vm0EC_i65ykn7kR0XqPo8cKH84.NtoqnzYUhHFYJKGCdU.qy.5R5a5XD
 aVv8Kx4.rDhi1jxOKtfCfnN_VEFU0zGUAPoMM7VvF9I6Y1eC6kK05r.95V_mFpfyTg4LlhHxHVcL
 NSdWz3GTr4kEPtxlTqROkvcXQScxUj0igHNZ5HyEfDSZXzQ7CMHMnbtEcTUUyObO0VVKHTlw2D98
 4LoGkfwo26uvc7iet55s1aPdeoe36uUkQKbjkWi4GDtVh7h.piXf9AC4HYIV4vHzCxIAZAFr8cco
 fPe_Dw8VFhEz0HiVuxOBIKRlClG89pMQ7z4EkYYkRm98X6E8IWoyqIeIpLeaqRUzY_oT2YhIuR1A
 rYUqVnLd637GUyodRTToEnKaPvFyF9qNNIp9ImGbfruwG_bufFwtp4cacciR0WAshUvfeaVUoHWS
 mIO2SRPBGHh5oQPTzfsMPykAOz19xzrYWVi9XacdjDsdYWw36LJcA0XhNtL88KF4yfGu6GfEkxvj
 NclvCqyLa5MT4Lovis68mbe7Iir.ZfhiDDAAjHRqmWnIQtfKLohDNbvGpgyXTeQVWYyEJFiLb5ZJ
 k57xNmgkfZ9uM4aCA2WLFKNK2DTB62Q_kz3KY1CzYT1DrVgB9iUQzzsqL.EP7w665IJOYX0pa5xe
 CTbeitbrCs2nQGmZrWNW.uCNT4iIEYETfWpHGbQE3UPzVe0na4L9MiRC4.uu8_vpj_1kemWiWDi8
 pezHgV.IKFBCpbm2qytZsJ4utpmE4iHd8iR_1WMQZGduh23kYSWmempzxN4cFQZ5bMm3CM.dWe8z
 hjhgsEWofciZ5HcQqEclWlXz0c0t3zqEqFZdoojOXJ8ImR57NBYPdmkkAIusnNpnDcYa0aC0SqX6
 dspLkHMEMQkZi_Fkmu0sBWITF4sc2J6FXoY5JcJqF0JR6MpIWg2CdzBEZBxZcuuSE3nsxkaF_2uE
 4P2AW9xFMPaFG.epxYWXUN84QGxgZSVbM2.qmF5xV89YPG7pTtyMHlKb5HjyY5CPoD1.fUrX8ORP
 IsXHSxAahLctdoWPNwTM7YOTRamYvDwUCZFCii4xVgdFjfSuBBzAPjxd_YKjB5ZLvCi74p0.xsBH
 mQPi2J6r.fGfV.3DQxOnd1A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ef4f947b-0e71-4ba0-a253-5c2b5d6757af
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Wed, 23 Oct 2024 21:22:04 +0000
Received: by hermes--production-gq1-5dd4b47f46-5xsmt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a7972f72a0226c80fd86fd6bd5371c9;
          Wed, 23 Oct 2024 21:22:01 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v3 0/5] LSM: Replace secctx/len pairs with lsm_context
Date: Wed, 23 Oct 2024 14:21:53 -0700
Message-ID: <20241023212158.18718-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241023212158.18718-1-casey.ref@schaufler-ca.com>

LSM: Replace secctx/len pairs with lsm_context

Several of the Linux Security Module (LSM) interfaces use a pair of
pointers for transmitting security context data and data length. The
data passed is refered to as a security context.  While all existing
modules provide nul terminated strings, there is no requirement that
they to so. Hence, the length is necessary.

Security contexts are provided by a number of interfaces. The interface
security_release_secctx() is used when the caller is finished with the
data. Each of the security modules that provide security contexts manages
them differently. This was safe in the past, because only one security
module that provides security contexts is allowed to be active. To allow
multiple active modules that use security contexts it is necessary to
identify which security module created a security context. Adding a third
pointer to the interfaces for the LSM identification is not appealing.

A new structure, lsm_context, is created for use in these interfaces.
It includes three members: the data pointer, the data length and
the LSM ID of its creator. The interfaces that create contexts and
security_release_secctx() now use a pointer to an lsm_context instead
of a pointer pair.

The changes are mostly mechanical, and some scaffolding is used within
the patch set to allow for smaller individual patches.

This patch set depends on the patch set LSM: Move away from secids:
        https://github.com/cschaufler/lsm-stacking.git#lsmprop-6.12-rc1-v4

https://github.com/cschaufler/lsm-stacking.git#context-6.12-rc1-v3

Revisons:
	v3: Don't change NFS data storage format
	    Retain argument alignments
	    Set released context pointers to NULL
        v2: Rebase for static calls in LSM infrastructure

Casey Schaufler (5):
  LSM: Ensure the correct LSM context releaser
  LSM: Replace context+len with lsm_context
  LSM: Use lsm_context in security_inode_getsecctx
  LSM: lsm_context in security_dentry_init_security
  LSM: secctx provider check on release

 drivers/android/binder.c                | 25 +++++-----
 fs/ceph/super.h                         |  3 +-
 fs/ceph/xattr.c                         | 12 ++---
 fs/fuse/dir.c                           | 35 +++++++-------
 fs/nfs/nfs4proc.c                       | 22 ++++++---
 fs/nfsd/nfs4xdr.c                       | 22 ++++-----
 include/linux/lsm_hook_defs.h           | 13 +++--
 include/linux/security.h                | 37 ++++++++++-----
 include/net/scm.h                       | 12 ++---
 kernel/audit.c                          | 33 +++++++------
 kernel/auditsc.c                        | 27 +++++------
 net/ipv4/ip_sockglue.c                  | 12 ++---
 net/netfilter/nf_conntrack_netlink.c    | 16 +++----
 net/netfilter/nf_conntrack_standalone.c | 11 ++---
 net/netfilter/nfnetlink_queue.c         | 22 ++++-----
 net/netlabel/netlabel_unlabeled.c       | 44 +++++++----------
 net/netlabel/netlabel_user.c            | 10 ++--
 security/apparmor/include/secid.h       |  7 ++-
 security/apparmor/secid.c               | 34 +++++++------
 security/security.c                     | 63 ++++++++++++-------------
 security/selinux/hooks.c                | 50 ++++++++++++++------
 security/smack/smack_lsm.c              | 49 +++++++++++--------
 22 files changed, 293 insertions(+), 266 deletions(-)

-- 
2.46.0

