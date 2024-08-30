Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B506FA8
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978670; cv=none; b=ikK8JhnQI9IxORskMsDEi/PdCjIFye0ExivH6LlLnNGGDSppNGCkJQ/4Agm5sXUxAYF8rW/qNufABhp8klh5A3mtYEkt8hdoqgwb/yw6fmCWx8kPhnT79+PKdeWjADEXP9KZkZnLhg9rHD7vaZi6NGg67b4rb9B0SDjtAlAhiog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978670; c=relaxed/simple;
	bh=uBf0mBIUv1rjOA94/InHCZo+azAEq2EXToYV0dHTVXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=ZZoSXYiln1Dj6RKIvtNXuP2nk4NrzYEBCax7iuw8QocQSim6FXnsusRh4ROqMP2mw5Jexx8i3W61sg0YI+PD3e6+OUdwVbleoH3TZ878PM1QbB+UA5JGumtaAVGFgT2aWIrpT2jcSizPu+TYjtSmCvs3mS2g4CpAwZYrKYgqv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=lNvWH0bD; arc=none smtp.client-ip=66.163.186.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lNvWH0bD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978668; bh=ZdBhIYEn/EPdtiJut86o4A8qrqlJM345imzubnSFQQg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=lNvWH0bDU2SgdvbB4jElxM2RvObI/9mq0Cy4z86trxVFSJSvUBpNwObBYQi20AcRsHJn+huAcuQ/Dxsy5n5MIisPdAJiOf2rOwMk1xeYXhY62UBS7cqF7nE6zWSKBAy2bohrA8440/orjC0az91PfUT624CYDrQFOfrHRWwqwibL3lUORJrHHA6NZMNi6g0wBlO7xSIyipejzxkIx6F8cPGUE+0RLDsNJQdJURjF+GZu/stoit3tKlzVTuj+kaCcL7ItOlp6n1NBkCuzw0vMZVKhDRWaqHpEpIHVM1zsbY+1XO47rBsha9oo8EOlbUYU28224sY0FitSBFtJAmvQ6A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978668; bh=1lF1unYGZK6gCnS1nOqC1jXIe5gyQ2pI5nj6WQe1YPz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Mvlfhwn4u/XIf8UcEHFbtkGEXgRcIeaN8A8/XiIcCMDv4aWlbHGNTEU+egG7lT6nHvpOpfUY4I2PVj+2PkiVJ236CwVqz8qQTt8+HvaMKoq2kXH3Iw12N4C81NFUavxMN2Qb9UeqIqr5A/pq6dGBVq3kkI9CabHSHUjBZbvL69Vc5LzycKxYgRnrCVY7DHyaCYerQqaGxl5CaLRV9lz+axV832pJygN3mhbuF3Dm+dYLKe7MvW4X774mRDTvW3BB6NbZZBphUPezeYKbFLzNXfG5rbZe/Xh8+RH9dBIwv/8wwHREZjxCWSViZ83RHkluRq6jQCGGTnSBxKbPNu3Xcw==
X-YMail-OSG: Hd5Wz7wVM1lDWF1STJD8ErzrGjGSwnvIXyV9RUXNQgtwLH8_5zLIVmgcAbYfG9I
 vODkJAQlJnMkFd3mdInKMMCrgCLih3W65ZTFqaOUBsqNw.D6IeraeJB_ePYsqqVanJoiUW6SUjf.
 gmx9sFM5Xr8osnJo4WqcjxLE3bfxH7xn68i8LptSd8DwQka8EPylCvdC3sVZjVCPKDi1yiBPjJ3y
 d254UwI7J35y31ufhYYwHvAGIV19zKjrOeEmPX.rHvOtfmsSWqBSHb.Q05XEQ35mafItXuVLPLK_
 WGCFkDyQo6alhdvaH898c6kAZTAoNraX4QVAuNGaQEMqZQlCxPbRnPucPYl7EEdnnl3YpG4uD1Tl
 4YzOUPGLrzY1.dev6oEjlcFn9zcHwrroPGnKZwuQOhO846RK6Rp.STYahi4.cszLD1V27p3fr.Wf
 pg0eWkEyzwcmjCV8.7Vm0LsgIaHpwBKzQRkS0kSqDngczVfHJCPy2GWrI2f1Vf1CeVMVMNHZMeIW
 5njXq8EZcFBvtQCL9TVBju7YB3mmx7lQbqFJ.wSg4GfDCYZsZ4WVmQQd314x1a9epWtidtx8j1ac
 LR8crR8h8cXc0xqkC2jtEhiuQoHaQApAXk4csj1KRDxkoEdzs4VaYjgUgphSbNeSMKQ1J5x1v1WQ
 Ayx7cYQsljOCYQBOIJ5T3r2HFnVIPGkd0j8owgDyPC0RL4z65Lu1TPEgy0NX4T3n3cBKH5MWZq5t
 W2JFPDsclAlEWWa.PMsV_oTsuXg16O_rEVp_mBWxV9pU6U4DYcE3NzzQcF6Abz1qPzoxE1SYu1pd
 z9.M1dPgE5zUy.BJDVfr_2XKaWSE1XVRpgzRWABWAPszMpHqw5WR2W52VJUxNRtCy1q0JHWUVsDU
 zwHUOvggJWbHbphcXG.rlGr5bZ9T7RDM8ZalghQY13nKJrHychRcNyvqFYRD_B1jZE3cXprLN3PH
 RmUK0WL4qjX0_xwoHg_uH371oK3GYXhPKPP7zQLyfp2rl9JjFZgeRGzmLfVrIR00E3y1Tp2V5aEa
 r.TpaoLBH7WBL.5I9ZpmRarx5fGHNLceYGGdx7PNZ3syTmVnIbDJMxBOZbhxb4tjb3zzoinfgRLL
 Xl6QS.uR69iflxCM6g09k85Xirkax8oaJ9dOa8zgYdqkv12h2aH0SdwK8zkNmPCsErsQR8JS1UV2
 eDd7v_fz8.9sMyAdL1w6_d2ljyWTDfZdlRf3anEaY.qO2xu7U8tfPQ7yHLoIYs8jKf0Q.JH.rM9c
 yjzazmVqrivLk1bIoRWYrjjJjVnI4Z8V4Z_CJxT.av8PcO9zqLC8qfKFHIluSMr.SnmalFFzZN9b
 eFWr_pYAijTIuLT8PeKbyCylcKHUk1sumjb9vUF0nTJjr1Ic7cKwmHu8VHYNx6ZIn.Bz2S7kCpm5
 9QeVhDSCOL1vwAXViCYw3fjO2RlpGqpin2MS7GFaoyhh4rhw3qTZ2PJKuT2elTShDcZUm1P2AXMn
 in.WNp268uHI2cgt2WAq4d_mVCJRXW.vXbmIFAJaO1g1vBMy5F2otC.PVJFr1l92R6_cw7eT2c7d
 kttqD2bZ9bppL28gyMdvF3lqA3uA_JqoJNltMtMvjWkZRfBOUEoaNZrN55nUG17TN5EPyiZh9L_Y
 iegPPwGYkh23Zo3G4BeLROmetWhOVTFkANPjrg6wFlZcwQBOZWT4FM6VIe99Bqd_bW_jC3Yuq47p
 W_i4H5gfKGOIKsCVPGvAFsgrufMKnDf0UnLkgfJu5PT9B7f4XLPmjaVlyQP6dc8ABDWmvkiCtrce
 pIkm80bw2ee.P9VPkvJy_A9yO4trAaAZKXxKYFdANJJjQwYP7zzsWYjsc8D.2slQ3jwfIFneouoV
 E6mUyOqt5KRPZiYsj6Npr_Wz0NJAiHesY7MmfgPclb1DbZtowzOvGhZ_qlpYhhCN1Q4vnB1.CyS7
 4M1k8TUSpnV_ldq76Y3YoBm0KjKSkJqaQu.QVQ7lv2KLHIxpDpz20LoRv66wBcnQNZDkUF5UCXxA
 I5JQNFRPb.FNPqehNmxcKovpu9rEAQi7DsmfNdVRt6kstUrsJ8a9YtMLq6SzY8NIoZWIufbNTQel
 FclZUlhnwM5RfBQKjFy5c787D1i2kCoXXBUisSGvOXG0wMKDApXmlcmuyzHiUF8nLaso3aRpwB_W
 TK79KAyKTb5DdufCWBM5fUVfpPudBCbV_LirbFmU9wQBEX8Zak_qitME.IQD4MpL7zKcIoLEWXUC
 HY0oISmvVATa1J74vyxVYPLlYKKHA_yI9_2GBZAfYohf.xr8m_X7uohiToNbWrHa1ZvOU.1fKQFD
 zjmSluRQeYZT0ez.bOJV3pstlHN0a
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6f727ff2-846e-4c00-9702-48cdc60f900a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:44:28 +0000
Received: by hermes--production-gq1-5d95dc458-gnv6n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5da78dbe3e0c562970426cfb16ce357c;
          Fri, 30 Aug 2024 00:34:14 +0000 (UTC)
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
Subject: [PATCH v2 00/13] LSM: Move away from secids
Date: Thu, 29 Aug 2024 17:33:58 -0700
Message-ID: <20240830003411.16818-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240830003411.16818-1-casey.ref@schaufler-ca.com>

Many of the Linux Security Module (LSM) interfaces use u32
security ID values (secids) to identify module specific security
attributes. This is an artifact of the SELinux security server
architecture and compromises made to allow security attributes
to be associated with networking mechanisms. There are significant
performance implications to using this approach, as access control
decisions must map the secids to the real data to be used. There is
also impact on the audit system, which must provide textual values
for security attributes.

The secid based interfaces are also constrained to supporting a
single security module. There are clever mechanisms for representing
multiple 32 bit values in a single 32 bit value, but they add overhead
and complexity. While the issue of multiple concurrent security modules
is not explicity addressed here, the move away from secids is required
to make that possible.

Most uses of secids can be replaced by a security module specific
value. In SELinux this remains a u32 secid. In Smack the value is
a pointer into the system label list. In AppArmor a pointer to a
security context can be used. Because the active security module can
be specified at boot time using the "security=" or "lsm=" flags,
the system must be able to use any of the possible values.

A struct lsmblob is introduced to contain the attribute values.
This struct includes a member for each of the security modules that
are built into the kernel. Where possible, uses of secids are
replaced with a lsmblob. LSM interfaces have been modified to use
lsmblob pointers instead of secids in most cases. Some new interfaces
have been introduced where it is not practical to replace an existing
secid interface. This occurs in several networking code paths.

https://github.com/cschaufler/lsm-stacking.git#lsmblob-6.11-rc3#lsmblob-6.11-rc3-v2

Revisons:

v2: Feedback on v1
    - Share common code in apparmor_*_to_secctx()
    - Remove stale review tags
    - Fix mistakes in comments

Casey Schaufler (13):
  LSM: Add the lsmblob data structure.
  LSM: Use lsmblob in security_audit_rule_match
  LSM: Add lsmblob_to_secctx hook
  Audit: maintain an lsmblob in audit_context
  LSM: Use lsmblob in security_ipc_getsecid
  Audit: Update shutdown LSM data
  LSM: Use lsmblob in security_current_getsecid
  LSM: Use lsmblob in security_inode_getsecid
  Audit: use an lsmblob in audit_names
  LSM: Create new security_cred_getlsmblob LSM hook
  Audit: Change context data from secid to lsmblob
  Netlabel: Use lsmblob for audit data
  LSM: Remove lsmblob scaffolding

 include/linux/lsm/apparmor.h          |  17 +++++
 include/linux/lsm/bpf.h               |  16 ++++
 include/linux/lsm/selinux.h           |  16 ++++
 include/linux/lsm/smack.h             |  17 +++++
 include/linux/lsm_hook_defs.h         |  20 +++--
 include/linux/security.h              |  90 ++++++++++++++++++----
 include/net/netlabel.h                |   2 +-
 kernel/audit.c                        |  21 +++---
 kernel/audit.h                        |   7 +-
 kernel/auditfilter.c                  |   9 ++-
 kernel/auditsc.c                      |  61 ++++++++-------
 net/netlabel/netlabel_unlabeled.c     |   2 +-
 net/netlabel/netlabel_user.c          |   7 +-
 net/netlabel/netlabel_user.h          |   2 +-
 security/apparmor/audit.c             |   4 +-
 security/apparmor/include/audit.h     |   2 +-
 security/apparmor/include/secid.h     |   2 +
 security/apparmor/lsm.c               |  17 +++--
 security/apparmor/secid.c             |  21 +++++-
 security/integrity/ima/ima.h          |   6 +-
 security/integrity/ima/ima_api.c      |   6 +-
 security/integrity/ima/ima_appraise.c |   6 +-
 security/integrity/ima/ima_main.c     |  60 +++++++--------
 security/integrity/ima/ima_policy.c   |  20 ++---
 security/security.c                   | 105 ++++++++++++++++++--------
 security/selinux/hooks.c              |  49 +++++++-----
 security/selinux/include/audit.h      |   5 +-
 security/selinux/ss/services.c        |   7 +-
 security/smack/smack_lsm.c            |  97 +++++++++++++++---------
 security/smack/smackfs.c              |   4 +-
 30 files changed, 471 insertions(+), 227 deletions(-)
 create mode 100644 include/linux/lsm/apparmor.h
 create mode 100644 include/linux/lsm/bpf.h
 create mode 100644 include/linux/lsm/selinux.h
 create mode 100644 include/linux/lsm/smack.h

-- 
2.46.0

