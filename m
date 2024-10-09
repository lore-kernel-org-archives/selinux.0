Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590F1E0DAF
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495760; cv=none; b=Uj39/LOQ5Em6EjNnr6yMFODNqPPT7CAXhU9oSA1iwJ9wMD1UN5lLjXfGA3qOnriNoJoPjP9n4qIkG8VShP/ikn9kIQrBU/c104HCFXk7vcyxwDw9IP577mbaIMRkQh3tnHsQpTEydVbj9ZG859bWv8vtenGYMJti/ucRU2MApy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495760; c=relaxed/simple;
	bh=Bp0DXtQE9EE7Gc9KkjVV5kABzhVaIQr3Cq1LQ5Rif5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=fbaPsJjyI4UTg+ScG8HcTtddQ0Y9QNfwcYt8J5towdrmrAF+4tSp3B1Oi8MwJ9gf1LGdC+vTecplhOqi05JN/Om5skIvLY7HQOrkdgz5+CNSJlECSuqglCUWwq6VDCCscdtq9HfIq3YFZ4xP3wPZeVKfXP3kDVFeOEZuP1bojC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ervwLz5W; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ervwLz5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495758; bh=XuErko58uwWP+dpKdF782dvvBf4QsVJAWVjWHdzaWcI=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=ervwLz5W5s4rg26ilcLeWi56cPUTz2KebFH+RxL5zOxtAlLKLc0pxhP6dL4tKcSzuq24QibUEEotsxe2LFy8VZs+GLwd6mWuXX0E3jugaBoynsxD5kJI/BVh0Yx2oDfpAzuQxGbRuz7aSL2hA33l5NKvMA6AF6lM2GRWp3n1FnFVE8G9i6cnqhzuMr94N+0PFectXsHcfnAK9zb1iDqY1gCnsenK+aetDkuaucafSpzSlcSmH40D+S6Gc9b0WYPie6qH7tr9Oa9HB7C9JiLIHnRabBh0UdqJb24bSz9Tw5og/xM8gAA3jDzWBCovYRFfY4MnIs2vO1f6D6HVUfKIGg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495758; bh=PPNhwNgAvmABKVUX7aN10jHLbFZ/FpdPOJ4B1vTYDzD=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=r2IQK5/PHhXtTSV97j8Wypru4uBDT0BOx//iQh2aPIryvIIe+XhkQ5/wVKY8pQLFDkiHthHyhZoX5nMewFmCbUUxd6+WJHm6SBezzVREkV/Gm2OIBOBV1gf8FWcvpre247xvq9HqAlB7Klmun96ICgo2RjY+fHvbFYd/9XcKqwmFOc7PwMAU9IJoSG5U5Q0VBiyrBMh2LEBVaUksaiwx6CtHfpmyPPZG9WQk60JiNuZ3k7kD8TUIyJ9ILG7MDFyh04NwNGn/gf8nmhxqPzF+h0zYM3+qLjJvCufcgrd4mSqdX5LCHLNZGbpESQXJDKiDVWqXuhQXUEsU/FJnk6pmHw==
X-YMail-OSG: mWIve_AVM1nxoxLkekjs9MAIeQBdsZo.gjpC5xTJX6e8TQlZA08xVKr41iRlzKc
 aXAPCLIBDRiTguJZz9odcWtZjWPKQG_JQLwqZDis9CY6_NLdLluq_YxyDskTfrACR7CfnKeVB4wK
 Xk8oTDMBKSW6FCrEQ6PGmjlpD5MhkDYJCPjLe3oM.5HiV3NZ4jcn8iuUv78TkZBXY23nMRX.mtch
 sy.vJjtFi4u0kmSnlFY9iDsKI9awMXAQTBKh_xpZno4879DrMg_47mteFU75lK1SudJvaT.Eq9e9
 LVWaqriEUVphad4r5cNjKUihGWqW4MwVUytUCUCcmPMLeYISHcjMm2fJycSOIX.mQ_G77JzLxDya
 KmzpwE6ExTuOEs3nuW.4Qc1tCXe6LYSVFMtzY0wc7m7Ce7C_npIMwXNi9gDLy1u5286h5ALCWAyW
 m6sY2R628G_GukwN.zna5Cr3iTJ6ZYjoGlHzvMo54SnLWEMF5F5zog01SiwXygEHzG6PSAwfaBtV
 wpz18R8S3dmOsBwbLOl04NJKRnbkJ0LwUKruccuSZNdBsx9FVAdwvLhyjBNMApdPe8T6GAj__3l3
 xbvpBCnuyLsXrGfqjrlTvwCd_pmXiGjX2VW4RwSTRJvUW5892kgL.dnA67sGM6QzDitKh5PIo9hm
 QYOR0nkAuBoXNpn7Y.BpRyVz78F3w7sdsWVqzA2o71eI8Jfvka_qfwyKUjTG1id3n_UnaWuQz.L7
 PWF2GNDsEz8Tk9kyWVb4NY9qlLCKPGDOiHxfD9LqwZktKxBVzBVthkUj1Z9EqHRArvfqjdvlhNLM
 YXpBCMkHi5.20HWljzHY0DTXMxCZExTMnzNR7zWRWiu3N8CQE7u2JoLSLSvsKaHHsynp7p2tMqYN
 mC1f5x2mL_Qyxav2Vv0BVUDLIm4q0zbB.2N0gaM68gZs7C9Ukbnx367HixPubxJcjohdihrIxX06
 7AHeCZqVAvWEMmkUqMitKkzU5eMrIeddnrQbdZdIJx.b0BKOG4GOSBr9aaxpBJYbm6R.Dr55GtML
 YqZZjzaB351Bs1GBcG.bb3VMJdtPzeUnLaoAuu5FfSH92aysUkMhfpLkRwfT95tUqLdt5Nn1.r8q
 TPCFASiyPZiWd4UjfROHn1UdD_raY9OWMx2WCNVOPxaodY4.i5CwxzS3K2LlP1ZcK8ct8Fyq8V6k
 SazkHfeMYjAYVepUeeiLzw4WTMqrRNj1dFTM00a748rVEy2XxjVIHWokVl6Ukpqfp_lfk31qHABU
 x93va2sxNabAkqMsuOxZjJauJZysK0vMgXY6VI3XQlWDBzhe3QLQga_LgjQVskxfKpWRhJ31_Dm0
 uiEmrnhoQPq7CyemXpw0CO6TF_qVttx_zrfGYboEPPufiOj0Sx.qpk5dlf1gBKioQnU5ZzAR5M_Q
 Pwn35OXLAW.QQdoFmj032wTWaFA9u0CULdK5rhXL2ZWiFy3IeYqlL5mdXgFcwGWt4ziqSu6M8_4N
 _K3FtPMOxYgp2XB5po4jD.kLnvLx5iZUrbtA9a22YXm8GeCcK_8N5U2e7kYodEFuTl_Tg7z7Kcyu
 RLKsFvodQm7aTly_45NRAy1Djg8WhAm.EWcjJvvKfrH0fTTMivFnpkp_oVjO0s_VorPh9_v1CFHD
 Xo_7leMpLvXAJm2HtJSnO0G1kq7qeql.0rMG6n.qdZXaN6oU6Sqc_fiDu1EEGgKb2eUHBI50wKQL
 NhPdEfLe6Y_zPGQw9xOu628pG50Ye_4x14vUdBHl4G9ZHJp7mKbmNtgpBfIrDbuauZt07CBe4B25
 6urFspKG157eVriwEffZlFVJfT_QIj6kkgES1zeFM1_g_bMjNfXqKdm5c1oADV6Yfw9takHs675e
 5h.MRPQhzR.IVn1f_LZ80PZYSVWCMt4H_Lob5Wao_wn3OXWzUhme0o6KAHElqwR73YFAyjHFkNuZ
 DDIzc2CmO84.kpzJgtis6yIgVMkkmLEb4H__rG09Ad1Ay8R8Zyl_8tKBYC2Cz5DyAtyF84UwpLLI
 aTgDhu9.5q.1mKzQyHuFmLpv484YwPL09fEVw5m8nHi6jCJAr0GIO94Ti8QsdJ5.0f0_1kYQ0NA8
 RBgm9B32_2vUNSTyAobIzNHxHGLQ8UIrqU_nwbVjLWkRBo3bsiAPU2FDbtotvJtcjnJSdBr.7mz6
 begCbtrsdpmawAq6RskwneWfmL5RNPA777Mim_MCHxhewu7b2aCEdURtZrG9Cr67fa3z9hJ1G6Al
 v.jNqSE_H8edhdULh7RaUASv8qgtpCy.WJNubySuThB39U4jZ0Y1Db_coCmjn.nnO5uheqoC.Hh5
 80Eq_x6Wv35eVUCRuOc3j59iSmQ0FBDw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 95ba62a8-32bd-44e2-9f01-54ea0a2e3276
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:42:38 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5fec0e30966313b56a0d7e944fb52df1;
          Wed, 09 Oct 2024 17:32:25 +0000 (UTC)
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
Subject: [PATCH v4 00/13] LSM: Move away from secids
Date: Wed,  9 Oct 2024 10:32:08 -0700
Message-ID: <20241009173222.12219-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241009173222.12219-1-casey.ref@schaufler-ca.com>

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

A struct lsm_prop is introduced to contain the attribute values.
This struct includes a member for each of the security modules that
are built into the kernel. Where possible, uses of secids are
replaced with a lsm_prop. LSM interfaces have been modified to use
lsm_prop pointers instead of secids in most cases. Some new interfaces
have been introduced where it is not practical to replace an existing
secid interface. This occurs in several networking code paths.

https://github.com/cschaufler/lsm-stacking.git#lsmprop-6.12-rc1-v4

Revisons:

v4: Rebase to v6.12 to reflect static calls
v3: lsmblob becomes lsm_prop
v2: Feedback on v1
    - Share common code in apparmor_*_to_secctx()
    - Remove stale review tags
    - Fix mistakes in comments

Casey Schaufler (13):
  LSM: Add the lsm_prop data structure.
  LSM: Use lsm_prop in security_audit_rule_match
  LSM: Add lsmprop_to_secctx hook
  Audit: maintain an lsm_prop in audit_context
  LSM: Use lsm_prop in security_ipc_getsecid
  Audit: Update shutdown LSM data
  LSM: Use lsm_prop in security_current_getsecid
  LSM: Use lsm_prop in security_inode_getsecid
  Audit: use an lsm_prop in audit_names
  LSM: Create new security_cred_getlsmprop LSM hook
  Audit: Change context data from secid to lsm_prop
  Use lsm_prop for audit data
  LSM: Remove lsm_prop scaffolding

 include/linux/lsm/apparmor.h          | 17 +++++
 include/linux/lsm/bpf.h               | 16 +++++
 include/linux/lsm/selinux.h           | 16 +++++
 include/linux/lsm/smack.h             | 17 +++++
 include/linux/lsm_hook_defs.h         | 20 ++++--
 include/linux/security.h              | 98 ++++++++++++++++++++++-----
 include/net/netlabel.h                |  2 +-
 kernel/audit.c                        | 21 +++---
 kernel/audit.h                        |  7 +-
 kernel/auditfilter.c                  |  9 +--
 kernel/auditsc.c                      | 61 ++++++++---------
 net/netlabel/netlabel_unlabeled.c     |  2 +-
 net/netlabel/netlabel_user.c          |  7 +-
 net/netlabel/netlabel_user.h          |  2 +-
 security/apparmor/audit.c             |  4 +-
 security/apparmor/include/audit.h     |  2 +-
 security/apparmor/include/secid.h     |  2 +
 security/apparmor/lsm.c               | 17 +++--
 security/apparmor/secid.c             | 21 +++++-
 security/integrity/ima/ima.h          |  8 +--
 security/integrity/ima/ima_api.c      |  6 +-
 security/integrity/ima/ima_appraise.c |  6 +-
 security/integrity/ima/ima_main.c     | 60 ++++++++--------
 security/integrity/ima/ima_policy.c   | 20 +++---
 security/security.c                   | 96 ++++++++++++++++++--------
 security/selinux/hooks.c              | 49 +++++++++-----
 security/selinux/include/audit.h      |  5 +-
 security/selinux/ss/services.c        |  6 +-
 security/smack/smack_lsm.c            | 96 ++++++++++++++++----------
 security/smack/smackfs.c              |  4 +-
 30 files changed, 469 insertions(+), 228 deletions(-)
 create mode 100644 include/linux/lsm/apparmor.h
 create mode 100644 include/linux/lsm/bpf.h
 create mode 100644 include/linux/lsm/selinux.h
 create mode 100644 include/linux/lsm/smack.h

-- 
2.46.0

