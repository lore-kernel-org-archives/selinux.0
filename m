Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232B2F42
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526347; cv=none; b=oM3+Xoj9vxPeB+vomucEwLMmUagJW7b0v9BaCf7CchCeSECeI/SGhX+8mJtz6A0jp90uJ8kxmEvqv1fUBDIwKL2aMQgFTmY0TwVTqzZZK3OUkFqTOHxK4y7shEjfHDNLSBaLoXGiBVabEhzmQpOLfma/6Myg6PSkgPvDIbE8UXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526347; c=relaxed/simple;
	bh=noJk4BiepOb3lVQ04gp/89jM/44GoTx1QuGjHuXHIWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=mjYFNjPZSm+sTiA/aiXALV7eFWFzxuVIItnmT+QxosvoRkjeB7Vr2i71FRAgC0H/uvxFjLLK+EUdk6m42nHNk9nxYULTOt1h08PjYCApFMMhz95wYbvH+kltoUK2kI4ONQJKiD4MdGJ3u1TEu9gYXtRivC4bM3WYWq2hCU8Zhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UvZGBRdS; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UvZGBRdS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526336; bh=f/j3CK3RJdMWlT73UzsrQTZQ4X5MO9hJbzn+JxABBmM=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=UvZGBRdS09fq8Hh6HjYfTj9GOCwfQhLdChXZoY49VKSq5eE8dmXAGIsgfLI5CW8Ynn2tEssrVbKFGzL/IQiwCCx8JK1VqBT/vrGEVyk818Z2JTenuMYH8Br+wAVnCVO/spGlBpsb95/cOyFTUebMQK8x354TV8z/DmmpW8sOVy+lWE+pQGjrj3R7vOrZMLa+tSIcbl8S9qeJpCHUnDQUzGwKwZBXQ8xFF4XUqoTpyPrxdRtcDldnuLDhiLIYAHV6Con7Jsoqvj8hDM/+5lJsXzaKtE+uml3rTo6+WoFSRCKgZ5hO50MEw18ugkeTBlm8nTTQu61EMALOLcT2b7UFUw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526336; bh=75j5Rpm3u7DSVaa1oefZ5gcAMel8vUd49prKIIGOza6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FIwd/MtFaJlJa0WLVDFWiHYq1RrG+8JHM98R42FumuaVLKerHNnY+fXkX1XqMQQCXXwVOcgbamdAUa7kfqbvIMgKvJlIf+HYXKUO318Pi6DsBIBsWyn98i6xIvbVln8TWecZokTZnm7ygZoQ5t91MxjQHetkevezcH0NnYHHiZyARSk6JNeBY0qLT3O98tfh0eGlvCeAuD1h19sIuAi/7zv74mUN7zVK/rnbG2h034gj87fTE3vfRfkApzPjkDN/b5edFBuJjHdbXcNqPxYkt+FxgSakmI8/8Xjw3GMFsBOggpEszWWOwSlAYLGb2K/CMfayodd84FJvxDgEDoa95A==
X-YMail-OSG: Tp.hPl0VM1lIf.zl5VehtGfN1JXMJZfSQ2_IN3UEFulQCwgLcYe3FfKpUizE1Qs
 sattV47Z1jESJyRJ5b5Cx7hiNc_2T2Mx7nN7djlQB0Nqrd_mvAezZzUaRBOkyTq5KPyUr_gV0.Yf
 TYkzh9nVQuN9_x0pvHNFYu0_FSVqKs2XBPoA9ZxJ6mBGteruBeIcZOkLwDB1PATPerRrl_inldXH
 u9PBm4qxpscedHMu1XyeXqsSuyAePIfn.lAwex02JZB1.wg25sTicKp4J9sRQlKKqBLf51_U7IFD
 z9E6JowuC3aQGWOhSwTLXy8n4dVzi1nZrEkCsGeiNv_e69RKD.N4JVZlXmtcbqLoMTvMAs4TsKKX
 1iq6azc7V5QuWxSHgYiVbz2M7mauKmBwR3Fze4EigAu1Jj6NqzLG4I66dW0HXSCAzM5zupjnWJhI
 CLv6zMLnpk9UAvW0QC28bpABfRXB7UZK5aNhonODoU36QBeMe4ehf6CoLzmXG6fWoI9NJa0e7yiY
 lfHUSxBsQEMNz_cFoXwV5RXyAR_KCkgR7NritoTnZX02WBTpWCsJF9AUEycQeLPsAscVFPmTZPbF
 Qh6SZ81YG.OXVCc4Wvrtg5mxfYg_V5r6hKW2VlR4LuKtDhsNInV_xYbaHKeknv1iJIdDn01APUfS
 gzXbTywXdOGdMnXlyBmeTcQm_rYETDEWcF5xMdZ.Hy0G322hI1YRlNA_QxOKU76uX4OW9pGe2PPF
 Ey0ScxXJbcM0BN3HYAv0YT9qD5iiaMMaVZLT4A6wGvAhzME75GXD4WemqT56xG3e3loqUDtkOYRG
 RLzucSp55EJ.p_YAy.8VRGqKEoUTW5ESy9lqVwK3.vtoP2XOSzore80qet0RuuZ_JLG9PYBc4jE_
 G9u75PaQRA8ToNzlGN6LdTzd8uEM2QHQjHfaPwWPwihhzolWrYMQO_S0WIMUoQUi9iNbOddjgN6P
 htJ9Qb1G7RFvE_unvLuE7SC.yfSsVjGRD2iMYA_5KxExuec7ThwFPjFP6AmgnY9Z1s0OHC0ZzD1h
 wJ4JcBL_QLKOxzJQ1XXIgXH0v.bXHygyFDs06NCFtSyY7nxleqgwYwww0.dfJyQEhLda1MrraRwH
 weckV.nAWBqWcjljjNUGeSuC.hbHNNoobKCaNCaPu7uv9RYnlRdp7AG6_EeFzbnbOcOPakWt7WqU
 irisEkvBczXmsdYWIRy8lT9aBWIG_YDiT_Aza4JOytUTSrGU6JsL1AM_UXFdmZQTOU9q.4OwoDA1
 8MRegy83oqBKuiiTg67NrNw2kyANPtsweBJJzamAeSOn4VdYNVFa3.bmFFVGqKIMPRVB8Gb0Dbxc
 SmQDbiM9O3kpMieOG2PJ1NwLOYp0uI2oYejU1Q7zhE_Xktq2Ad8LGGeeMak13tEmFzBFXjrclENP
 xaP_ps.C7OrtDF05CZFHtE687D2cVlo2sqy_XFzOAwgDGyMfAH5DL6WneKGUm1mp3zwVW57CWdPH
 0mtRQjdT6vE1V5pCo2MAuG70aYdZTz5Y9EKhBL9Tbi7mKUZE9Ae1G.maKljHl.Ber6Fg9fYLGbCg
 dg5N9RK3_ELiLxsn5LphEy7gMGzDFzxu8KNkf337piS10JApIH.bm0l4tV5ZbkMSZbwQvyhJRO_c
 23.2v1lPZDdQJrfcaz1dOETozk0EiIt6xsGFyRSk81FiYhqTSLd2jm9WBEw1VeN0Zx17mi9BOQij
 L1gZW4KWaGh4m82BHdVgAKYhPo2Eu.Ncfqb0V5YGqrMPFf9ZYXnrxtxwl00HQodsNmEzu9fxUsXY
 VW93_yIPefG8jeN0MZgwr7WlDfbLaVTmzmuLAvPxyt3g4rPcjabHbemgAMjP3OOR8nUyLWsg0L3I
 i8qvVIQGZ627.IrV5WJtLufd1wWPuAuLr3PXBH02MvPHDtLesFW6t8BnvsMlnW7rJd0XQGPS0Fw5
 wCk0JOjRBnRCiACpMFbK5jAFmG4jX9gnBqqx2.VSySVygFIe79HiG4u6vywwNDz21MVmfk1l8Y9C
 Ka9uReXr1yMY_pSsoPJBEXcjsFAuzwhNVb7BP87D1BxCf0R0e9BxR3L4T.lyF44LDV2mOUTgV69K
 uivWuREsT4ccKIgIhgDKIRaDkSwZ_0Z7m.vpE.imig_pyd.ZyO0_KjXGh1vQ7SAAAn_CYKs_u1H7
 b1uPCqJVPviXJfDJamvJON7rpv7rTAVe7PzIMza3EYWdJQt2ha7UIjp9GCNZOyhdJZ0olMcrzjE7
 tZexiqHfzoqfm0m4.TjWwmTOpoyOL18Tcbh4MZPDgrc72_2raJ9xQAxQpGdqdh8qIcFra7G4tqSJ
 McOO9IzO0uxZ1xIpMEmrQtQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6251a79c-2b83-4ba1-bddc-8c30cde94e3b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:18:56 +0000
Received: by hermes--production-gq1-74d64bb7d7-fddgg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 250c349a2671887e65e0396b7ea9bbf4;
          Sat, 21 Jun 2025 17:18:54 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [RFC PATCH 00/15] LSM: No exclusive LSMs
Date: Sat, 21 Jun 2025 10:18:35 -0700
Message-ID: <20250621171851.5869-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250621171851.5869-1-casey.ref@schaufler-ca.com>

Remove all constraints that require Linux Security Modules to
be marked as "exclusive".

This RFC includes variants of two other patch sets:
https://github.com/cschaufler/lsm-stacking#audit-6.14-rc1-v4
https://github.com/cschaufler/lsm-stacking#mount-opts-6.16-rc1

Based on patches Paul Moore's LSM initialization patchset.
https://lore.kernel.org/all/20250409185019.238841-31-paul@paul-moore.com/v3

There are three components to this change. Patches 01-04
implement a mechanism to provide auxiliary audit records
and uses it to supply new records for multiple subject and
object security contexts. Patches 09-11 allow mount options
to be supported by multiple LSMs. The remaining patches
address mechanisms that cannot be used safely by more than
one LSM.

Testing has been done using SELinux, Smack and AppArmor on
Fedora and using AppArmor and Smack on Ubuntu. Using SELinux
and Smack on Fedora requires a systemd change.

Casey Schaufler (15):
  Audit: Create audit_stamp structure
  LSM: security_lsmblob_to_secctx module selection
  Audit: Add record for multiple task security contexts
  Audit: Add record for multiple object contexts
  LSM: Single calls in secid hooks
  LSM: Exclusive secmark usage
  Audit: Call only the first of the audit rule hooks
  AppArmor: Remove the exclusive flag
  LSM: Add mount opts blob size tracking
  LSM: allocate mnt_opts blobs instead of module specific data
  LSM: Infrastructure management of the mnt_opts security blob
  LSM: Allow reservation of netlabel
  LSM: restrict security_cred_getsecid() to a single LSM
  Smack: Remove LSM_FLAG_EXCLUSIVE
  LSM: Remove exclusive LSM flag

 include/linux/audit.h               |  23 +++
 include/linux/lsm_hooks.h           |   5 +-
 include/linux/security.h            |   6 +-
 include/uapi/linux/audit.h          |   2 +
 kernel/audit.c                      | 274 ++++++++++++++++++++++++----
 kernel/audit.h                      |  13 +-
 kernel/auditsc.c                    |  65 ++-----
 net/netlabel/netlabel_user.c        |   8 +-
 security/apparmor/include/net.h     |   5 +
 security/apparmor/lsm.c             |  12 +-
 security/lsm.h                      |   4 -
 security/lsm_init.c                 |  36 ++--
 security/security.c                 | 103 ++++++++---
 security/selinux/hooks.c            |  82 ++++++---
 security/selinux/include/netlabel.h |   5 +
 security/selinux/netlabel.c         |   4 +-
 security/smack/smack.h              |  10 +
 security/smack/smack_lsm.c          | 107 ++++++++---
 security/smack/smack_netfilter.c    |  10 +-
 security/smack/smackfs.c            |  20 +-
 20 files changed, 585 insertions(+), 209 deletions(-)

-- 
2.47.0

