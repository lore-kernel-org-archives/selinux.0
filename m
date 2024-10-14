Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE61AB536
	for <selinux@vger.kernel.org>; Mon, 14 Oct 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918905; cv=none; b=n+sWj99ciYKIHFs4jQITYjZe3YSzDkN0bSlR7GX8ELHynIGBdIKr/JlyeuH9T6BGU1Yp878arGaoAuMXE1Jhixch0jwmKz2Q2SmSYVjsKGAUnLEw91O2uMGJAWhm8pAT66vLIMJpfkk9Bij0ON9/OyCe7cQNEkQoVVKBDbMyuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918905; c=relaxed/simple;
	bh=kJxFi3BqgCkSILZ7kWET0J04ko2NYzGeGNiWP9CMtjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=ZAKKONlLtnlNdXsSGjgMAcqkKdEXJlBvh4EmeqtrKaA6hrl6o/RT+5H1S+lzbyz1fM5AEZRVdo9om8D5WMaW8/qHo8CZzE2X7Iz6u4DKsKKV/XEPoBXyOtsunZfwFVkX7nsnsV7wLp9iVC1/84IXnhBkQ+MOYVpz72+nRfJL/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=V2QSMtnm; arc=none smtp.client-ip=66.163.189.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V2QSMtnm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728918896; bh=UnEEKf+Qio82nsMEVpo64j2xeMEZV543kJXLF+rLtnc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=V2QSMtnmsMG3T9aeQE7AeXnnXQqPsutdcif35AJ2U7I8lnQ5rkmWEzACc6oNK0rwWS3guksw2exXnjIQP8BZNNi6N9j0foYHAnMs7waAvHsgghojvaLeapujIGF9Qno8t0IDcr4DpAU/8EX5yyoVmP8PVUN8uJT/qYyfZ3TuUn4KLT/eXf0VOiOQcBKK/oxJU9i89PqllsCHYwVtFmpY26Lhxn89zic5RPkL2i0mlOUAexDwqL+fl/bLGdfQLk7Femdxc4EbAmFobBsFfgDh/Y0M3g834teJvTmpySkx7RzcjXxnMUlVd/quphOvu+BJAUgd1ym5DLeMwgv0bf98Kg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728918896; bh=V2saP3X/U4NA1dwGROI62oFndbG8LvcsO8+rxvyLgX9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cchENhSMHiWvfJN5okfmq4dpyMYUWL8YkSNWr0Kn+6mHLmNfcauAjEIcBc5e8xmIzin90akFk+hr6Jd3ugdrudJLzQtups2Y4PKTuBgMfCx2y5uzxgxwcs/1j7e3KlXG+e44wXQmVd3pCDFfxZfAFKopBAIo2LCC3K3s76g+LlGMdjguwVo4jcpIVoIweTw7e8vaMb0M7t3cN1QQEpYWOJflvEi/ZdISJqeIvRmU9d288rUiiJhQ84fRkGTfqgrqLUX9rh9Di31yxF2cthLPdu+aAps3C+BQLQ7+NL5pvvLVd13bkD3iSSnrpERM6bRNmDQloo9M+USpzUcWckT6sQ==
X-YMail-OSG: j62v95oVM1mAQarmHmK_j38oGFD7zBW5j2Dlv6R9zt42ikCM2WrltP9hG3._pjf
 J6k4b3pvF4.4P0_.qmbMVdGZdxQn8pbsTkKiRhWNb.Z9bsaPUrsmuIXuh1nXi40s.JcfelcZ0HcY
 w57BUY6edqVaflnUy0ALzIwvq9gykxzDYDxIm9Koxj0oMBcxoEQt_EXm388IqUzdnqMHiFUBMtBc
 o6NgGmjseptmAaigjS9OdUJVPVSzu6MJQqiMt02Ng4c9uGSXj50ayd0dKnpT8vOVbdWJhZjeD9BB
 eU2Cucu19heuJODvpL2P0v2Yc6oD.MSRVbRENqCIp66swas0HU0XVZGrwaFD_9kDQaoKin1kuput
 REv2wbxXwN3vhNHpV3oUUig3K9ueEPJmuGagDb8bl86bNJtWwBmwU4QkyKUmpyb6EW3LkPIDjrOF
 dKIQOJIdncoFaK81nl4BwgMVb.O2GjOPy7.tsueKCMwwuwxaPI0G7QWzrAmOLFd1EDEbRXbHttbw
 swe.d8SwDVybWV6YaBWd0iZKUBloBBXbgmRQVup_qTQMdYCQvtz1x5UHMNow5WESwb4_3Z19JEAc
 CQK88KheCzK.kZKgo4zFILl73yc3b_q81h2tZI_08I.RzgVb8tuPoMU7tKlCtKC5UxtyY.a6HeUe
 qNhZ.z7MbkmfonueC5ndKSejOExqszfhDLaj8HD7qkvtJq35YwQhweHOlV8sYzUFsxhMctNors7B
 g_rfrnu5tjXylfH2Lk4432DkxfVTTAwx_lR1ElXQlW5bn8cWctWTxNOkSxNJ7cT.hE2UoqVUgs1O
 Z71l8ZP.gkLtQFxu03ETrAXJQOVLtf2PERP2k_4.L2YMRTrJ7jBHSi9TakMBgSbLuvlZB3e3f6Nh
 LIR5vcBvaQXqb1eZqxLhSEkCMli88ZKEukCw_3ybZozVQl6ReRk7BVQ8eTks4RMMLILHGqB_04Ox
 I2IJytR0yOjdJdi6Os2qQE4lvQDfGHlovblG7I8LLJj2ZHD9rFZei6JnutlD_hUffmGm8uiYJtR6
 y9wBUkCBRPYoUVX87rUCOuBxcz9H_.D47klyadJPl0_VyW5p66j.EVrggeyPnego5RKTi4vjoUOf
 64.EP72M561E6r9i8FDEZb2iaAcCxHL4XitXGDrmKFX.7DELtNfW9CHNXbcmfo_tV_uS9bk93l0O
 aoxpTdPNI1PrZGoBiRpqaMLLaWLdQktcLy0iAwtwYe7LTuMKtPKdHss0vx8bR4xhBPDMfXdaV5BP
 SxraGYs4J4I5K6W63vT9pFNJOYWg_rXkS23MR6NtQIpkKCz91uqF9P5uoqav.TaKsZQSbdN_mZeS
 z3M7avWRrT8HgazQCpCSeopGH4FFSSNUS.wPbpFqyMlLNTWlLS8vnEPMFb0RGXOG7UC50we.YtRU
 WDpgUktC_DiaY32m5tQL6_K2FP.yfJGXyn0lxGb3uCqk896yfg11Cp2geVNiFUrx3sm96MBmwnVr
 ObH.DdPTz57HyCeN6r19SsW.ABbO9AHqe6p3isYVn3JGnH.O03dmlExgc1e.BeCDfAieyO9pLUqA
 h0JC4nB_1TZBOAZCFvP6WBJ3yfRenr_f.mjQLe_wZr0OiqKIufU9PjCis3axLgZIeapP3tRrbJY7
 _a7CIvG06CLSAfR277yNOc_BN30N_oNsb0BBFwzoGnYsC.vQp6nD20S9wpjXxQYLHJ6lGHr6aL8a
 m48Dy89JPnTgFVtNNm6oqzmBu6yJbfMHQsugrDB9NTMyBybbztUtJhdnGOmLeYjtxsyXTC.MDYUo
 gJw81QXo3QLehTEpBplq2WmwtTR8qb78l0fN9BipRRJPYqePsnu5BCV05eFGvMj6bF3Q6TjM6enI
 sukNgjO0qyVTRLCY4c5GNfYFz02OSXpkuK0tLUF7CYD_WhMokwP9gasBdGiejSMyqnb5cynmRYZA
 G4cvqqctTER9202uEXqdhUcBQmIH_PsMWDMqzU19TD4rFtVycUniEYLbI9ULlVZOsGePa6S5SSFN
 _46AuJ63LTkws1KdvJxNOIlRXdXVZJs.H4rkcCggIx.OS7WVvRF_zw1suBvoOB4qcW_tTeonObL.
 2qEuwQkQ83rkyAS9C0Bgu8qYH966rNxstOk8TdBH9wzseU0ljapPSokqhPzwVBkYQglj25EYkrSb
 wOdCopuIea4V5_KNYxQR9q0WYPXUBrsOW526xF73J64rnb9vbUl3kgzvSm7ma0xFH1eJKMODkhy2
 T0PuMn06jGMQ5njMm_D1AgQsJoEb3TAgadECPEWdbuOMebPdA6UIdfUhZ8l_imR0gh2owzU63ra8
 0gLSKRZ0UshR9W77RIE_21dA-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c0a3c97a-b036-4a9b-bad8-23e85f169727
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 14 Oct 2024 15:14:56 +0000
Received: by hermes--production-gq1-5d95dc458-4tw7n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6c392927ea0eb898578ed262d71f570d;
          Mon, 14 Oct 2024 15:14:54 +0000 (UTC)
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
Subject: [PATCH v2 0/6] LSM: Replace secctx/len pairs with lsm_context
Date: Mon, 14 Oct 2024 08:14:44 -0700
Message-ID: <20241014151450.73674-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241014151450.73674-1-casey.ref@schaufler-ca.com>

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

https://github.com/cschaufler/lsm-stacking.git#context-6.12-rc1-v2

Revisons:
	v2: Rebase for static calls in LSM infrastructure

Casey Schaufler (6):
  LSM: Ensure the correct LSM context releaser
  LSM: Replace context+len with lsm_context
  LSM: Use lsm_context in security_inode_getsecctx
  LSM: lsm_context in security_dentry_init_security
  LSM: secctx provider check on release
  LSM: Use lsm_context in security_inode_notifysecctx

 drivers/android/binder.c                | 25 +++++----
 fs/ceph/super.h                         |  3 +-
 fs/ceph/xattr.c                         | 12 ++---
 fs/fuse/dir.c                           | 35 +++++++------
 fs/nfs/dir.c                            |  2 +-
 fs/nfs/inode.c                          | 16 +++---
 fs/nfs/internal.h                       |  8 +--
 fs/nfs/nfs4proc.c                       | 16 +++---
 fs/nfs/nfs4xdr.c                        | 22 ++++----
 fs/nfsd/nfs4xdr.c                       | 22 ++++----
 include/linux/lsm_hook_defs.h           | 16 +++---
 include/linux/nfs4.h                    |  8 +--
 include/linux/nfs_fs.h                  |  2 +-
 include/linux/security.h                | 41 +++++++++------
 include/net/scm.h                       | 12 ++---
 kernel/audit.c                          | 33 ++++++------
 kernel/auditsc.c                        | 27 +++++-----
 net/ipv4/ip_sockglue.c                  | 12 ++---
 net/netfilter/nf_conntrack_netlink.c    | 16 +++---
 net/netfilter/nf_conntrack_standalone.c | 11 ++--
 net/netfilter/nfnetlink_queue.c         | 22 ++++----
 net/netlabel/netlabel_unlabeled.c       | 44 +++++++---------
 net/netlabel/netlabel_user.c            | 10 ++--
 security/apparmor/include/secid.h       |  7 ++-
 security/apparmor/secid.c               | 31 +++++------
 security/security.c                     | 70 +++++++++++--------------
 security/selinux/hooks.c                | 52 ++++++++++++------
 security/smack/smack_lsm.c              | 55 +++++++++++--------
 28 files changed, 325 insertions(+), 305 deletions(-)

-- 
2.46.0

