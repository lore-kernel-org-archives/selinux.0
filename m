Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B622F60B5
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755362525; cv=none; b=cG3gqdOWJ0zmWZXimBc7+mo98Vnbyp2pn5opGvt2S4lK8BR7C9vW1jtFLHWU7BkNqibSNXVnJghLFCkIKsEnGwI7wPgfP2GKDTZUCXctuef9Gw7+kuaYJf/gCFQJefxTVTHCZx3+FOxB0+f4T9xCh9Nbsq106P6mSnhyyK95+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755362525; c=relaxed/simple;
	bh=LzUCl3hoJEExpToziP9fTxrE872KV3dSO1feighJNnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=X8LuRJ2MqhHqHkom7PwgIKcc68Y45X1USiWOh3K7XCDGYhyT04gCPZPb25aVhoUQovirJScqmGYMEoNNfxr3TWFfUGJj8t/IVgfxeDSS5tCH86d1ZI4NblvmWW0begY0NZJFxz9uNukl/ToKX20kQIzH8ivBUhW8EwcAiYTxRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=nEl8U3Ex; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nEl8U3Ex"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755362517; bh=D+A4s2puEKRfCvZ3mdVLmiFNlIwcfme6AV7KlzI6Syc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=nEl8U3ExyK8q2NDtm2QbVM8k9Mh2f8ErwLoPHsgBfwj9ZquUhShNF1Z9+fUwDVpw5tATwj821Eac7Wk6QlksrM9x2QVEUq9W8kmeSgKKF0Bke+70hxnRfR4E9MdDBa71z3moNHZ1sG01DApjeoInKd1boUhQrkeLIk98AgncLDNxMgR0pGmDI3q7UTWbCSAgCLi0g+4wucN9xrB9X9yEZsl24qqyYu4vVEuFposaZEU5hjZOHw1jL1ZE0DNqCGSCcSP7BbsaUr9FJhvu7ss+Q55itcapSWD3WjXhBAeWMEGB8mPjvPBeKV92s9kXJgZ3qQJ8b5TBVI3j9WuMsFJpvw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755362517; bh=PyNE3QwL6ADIqBMJz37yIKeZixQ2H0LcsDPEfsz5rQu=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lkcWvrVicrSQOZv9DOSYaUKPbzBtlQXm41XMcvBHDixNnykECtyKr0NNEzvsF4F3TBIQ+lcxxuiL3vejFX3FqZkjYThxGe5b+0RpbY5X1gRSZujpMKIhhI3E6CMt4e6tIZmACD/zWQ5wtSDMVHEQQ58MefxFyud4KGL/JvbXMAA0wMddpRYNnd3RNHfBZsCCogNM1gYyPAhlLJn0QZTFurjoIjKHm//j/e7ewDPJ2Dx/acdA8k66NUGho0iOyV79s8fXbFNPOvj8z9+Y9cJrZs3e5V0dBjy9CTbVFuwvVEp6WWtOx+1pptxE1tVF0u8ox5FV71vuR8XLtp7856I5/w==
X-YMail-OSG: .trXr3YVM1kHaebagFcoRlPYoa2pr3slXNsZnTUQaWMTSognFXPfX41WNbK.XcM
 Gi4LmTtxfSy0jV_AOzB_5gssLq0Yjyy.9.0HtdQeFLFs7i.pz5fZr3EAJeMJGbfm0J37IBNn6RSU
 xAeq0Ma5f7fHRP1Wh_DdCk4BWddmG.W7rEicsTSG20wlUsCaI0LZk2RwOqFqy9.w0ddDu90bQHiu
 E0CvkJfg3PXD61Rindz2FkHEjKWHK2h_yOOdHcAC6uCo1wR.1bxzbOL_btrckvlWsmc.cbCOJiBj
 dRhM0D7CXryK8Rg4h0vwmGo1tEnymj64.3aFXpCHR4qVOpdjYN_MJhEU6mcSbjJP9jovTw6ZJcFO
 yABuQg.CCfostoCthijgwMLx.XRDuW3gcacRyXekFqUTU_FScMXyBzAcgvjqKK7tFzmmAQDC01CK
 2_Jd48zOkHpzh3b2.xlfstDZ_l6OCGswkZXLaKHekLYOU4fDABC.ZNfowqAQuL6CfzbcwmrctgYW
 SkwuZ9BpxGnuJA5j9ZGaPSTJLBahNhpnmX7Te1rFXOjJsFXPNmIByIXZq9k1Xpwd0ZGlyAip4H3_
 pkn7Fc748fxov3GJTQ_kLFcXFuo7fNHSqqckRpHOoyxHlUl4XwoyjLrHTNHEtMThdiK.iG8w3Iub
 wcB.uPcsoGYCDKI8DU5YimPYJsXKJ_Kb8On8fJt7gXZ3amKEHdJIL9l0DPBlCyWQsmaTtK4XWWnY
 jrkPj99ya9ABqSVICx8QSwFc5PY7rlyeOPYUvZR3Op1EbvjcCu5fP4yDYlIO5kVaqTgC064Anq58
 9sS5MQaSMlBizTmRJkl0lGCm.h.b1gH3b8V7g6NiNB8VE_sVVgcT350droO.LIK34KuuOcbr_xX1
 Cinsx0ZkQPRKZmBW9al7ngLcUn47MnvUDm.sQdRFMr.7i7k1VpjoZmpp_eGPyhxGyUK0qLYuaZ9B
 hlOVjxyDwWXkA_NOL2Ok4LQ.71oKVWbAsAfsQfeioTnRVcvvhjApas9ZqihwAe4q.ZzIYcO6MYZB
 fcatzob6e7cE3xinYxiYTLUX7ihl4axQADD3UKu7JnpcgJreFSqZZnv1quomgqnk0Kle8u8dN40V
 rHx9YHQclf.PkBhvzUSXhEDQJitKUxmopDbSxQ3Ct4Q4ES.oYJarI7qV_Vse751LFbQtbLqUM7xo
 hCG8L5CoBAv0eK4GQj3Uju01ykhlW_iQLjubWi1Kj8VznztecemKImAjC.rg7jpVL8Vz61ZA4XCs
 KZ3HY3CH4Ouyae5Z43vilGkXb3ndzq2_Nd59hyU4DSOWhdjTWZ1k1.mg1n6U8Thz0AZH8DCmy6_l
 RrrMPPrbabebJ6ExnQaQbRDBejnfAn0OYxVRcnZuoommg.B9g6tvCNtOoUGxG9_cX08CgAH33k3R
 ZgKs7hVsuDtqFRqolHv4h5v87Id2H6cVm.M30ocofGxHH3hyKEhI2ZnicPSvBIjOi4fiMgn.mHOU
 qn1zOm5Q0cIHax1bmSgQJcfvlvPuhQKrfZSRU8Wlc9CrhAbehTYjjkUCvzWf1reglVQVVYFBlMzd
 X8vIryOpuZCbqCWugCllMoumuwZIyRtMg.Djz.KHTZDeNrejdh.hvHMlXz19u9.8tGjVoqlsewup
 wzueaAjwn.OYaVTfNr1EMwHP0PsoTx1LFP2UVs6R.2863swW6P991DI.lzbQToI8JOeUtla2ONIF
 dm6YqdEJzo4fX0_4E3j3spwtoCh3deCpEzjMppgVORUQgXQwDinEs1Am._8KaDSkHu.rVKeJ1Hg0
 mxDkWWUDXX12ZdUrySxsZHSN88IaEtxSYIurbwJax8tqHC96xV539U0XvrL68IFmGo0XUVzZVlz8
 k_fvcw5DUbErPsMZUSNcmf.z5k_mE8v5ABMwiiX_Dk1BWfDHdIwEBNO9QHeYzYuPEoVHpZPv5znm
 FbQQz3rxQfJ3qf00SxvmQu4yuxXyQ4tKS1uuFwmSbgLxMQPGCZ5i1sTJxEO4V32Z.rbC_ehehDDU
 P7tN3XGdYbkbENnaC28FYZr1UhtQWGVV5.U34ztu3oIzw_fJxcWZ85rQX9gfSpOA3Xmkf9gJvFUq
 ZnqNF94iw2OuXbawYRxGPVRKSTv.rz9_3uIHO1L9qAi4lkpsTor7KG4Vki4GBA0kBPPL_WlpnXmp
 LvsRMM5cUfRUManKcRZmeuxzlj9KnuQ8WqweXbwuzCHzvmrwLcXUNLf0kpmsctO81_QGD8dLGPR.
 ARZydcG6In9qc2Vi8QhilN568E8OQJUG.M7NwysKfeYgaT_gojBFyOG4A7hFnambfx2LKDL32mcI
 eTGmWz.qxnfERF.mj9vCq
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9e61bf04-052a-4a3a-9223-318438cb2654
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 Aug 2025 16:41:57 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12cf07a2fbb9800c7a9ea9632f3a0835;
          Sat, 16 Aug 2025 16:41:52 +0000 (UTC)
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
Subject: [PATCH v5 0/5] Audit: Records for multiple security contexts
Date: Sat, 16 Aug 2025 09:41:35 -0700
Message-ID: <20250816164140.6045-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250816164140.6045-1-casey.ref@schaufler-ca.com>

The Linux audit system includes LSM based security "context" information
in its events. Historically, only one LSM that uses security contexts can
be active on a system. One of the few obsticles to allowing multiple LSM
support is the inability to report more than one security context in an
audit event. This patchset provides a mechanism to provide supplimental
records containing more than one security context for subjects and
objects.

The mechanism for reporting multiple security contexts inspired
considerable discussion. It would have been possible to add multiple
contexts to existing records using sophisticated formatting. This would
have significant backward compatibility issues, and require additional
parsing in user space code. Adding new records for an event that contain
the contexts is more in keeping with the way audit events have been
constructed in the past.

Only audit events associated with system calls have required multiple
records prior to this. Mechanism has been added allowing any event
to be composed of multiple records. This should make it easier to
add information to existing audit events without breaking backward
compatability.

v5:
Comment on the LSM_ID_UNDEF behavior in security_secid_to_secctx().
Change some names to better reflect their purpose.
Move alignment changes into a separate patch.
v4:
Use LSM_ID_UNDEF when checking for valid LSM IDs in
security_lsmprop_to_secctx().
Fix the object record to include only those for LSMs that use them.
Squash the two patches dealing with subject contexts.
Base the patches on Paul Moore's LSM initialization patchset.
https://lore.kernel.org/all/20250409185019.238841-31-paul@paul-moore.com/
v3:
Rework how security modules identify that they provide security
contexts to the audit system. Maintain a list within the audit
system of the security modules that provide security contexts.
Revert the separate counts of subject and object contexts.
v2:
Maintain separate counts for LSMs using subject contexts and object
contexts. AppArmor uses the former but not the latter.
Correct error handling in object record creation.

https://github.com/cschaufler/lsm-stacking#audit-6.16-rc4-v5

Casey Schaufler (5):
  Audit: Create audit_stamp structure
  LSM: security_lsmblob_to_secctx module selection
  Audit: Add record for multiple task security contexts
  Audit: Fix indentation in audit_log_exit
  Audit: Add record for multiple object contexts

 include/linux/audit.h        |  23 +++
 include/linux/security.h     |   6 +-
 include/uapi/linux/audit.h   |   2 +
 kernel/audit.c               | 274 ++++++++++++++++++++++++++++++-----
 kernel/audit.h               |  13 +-
 kernel/auditsc.c             |  65 +++------
 net/netlabel/netlabel_user.c |   8 +-
 security/apparmor/lsm.c      |   3 +
 security/lsm.h               |   4 -
 security/lsm_init.c          |   5 -
 security/security.c          |  21 ++-
 security/selinux/hooks.c     |   5 +
 security/smack/smack_lsm.c   |   5 +
 13 files changed, 325 insertions(+), 109 deletions(-)

-- 
2.50.1

