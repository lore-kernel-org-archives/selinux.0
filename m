Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2902D7DE1
	for <selinux@vger.kernel.org>; Wed, 25 Feb 2026 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772047326; cv=none; b=CvsJZiRad3ATjqwFEiqPwuLdctgguzhPsQ+qp9Bd2sUwJjHfeAwJsLF5mvDCSuCLkfPPrQ3GCrkQe0FrNx50f+HecZhuFIooKacfR1pOzDj3QCF2BmIKjoJb86mV6bGJAchTzkROvYrXQJqgvDVLLInIRT5Niwtj6kpYq8UpYAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772047326; c=relaxed/simple;
	bh=tDeECAnZDCsz/EVtrhSLX7+oN8xJtFO2aX6TE6ILUtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=VyRglZCmulX4+3Yn7wgdYX+oTxvbFTi1NZAdg/yGR61t7Tte0CXEB3yohym/z28CVlnQCjZWsICWobur1h/sIiBPv72krtyJm6QpbegHnxli5oR8dL1Zv5LimFGTnD/MTG3KZ2C0BfuBtlFeITzT7os1gu62lKMLY+UNLo/h8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QxB4EflO; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QxB4EflO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772047318; bh=lSPHsauT1ycwbir1DbCPdGELh+oopUjlisBIdxSM7Yk=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=QxB4EflO7RGUhEURLwKQTzPOehMhHzZVlCGqjxy/DOJ3XfQaEH2LILxdeCi7dUGkM28cp6rlOnro0Nr1QqZgrcL/4/bhT76EmgaIfBoKQsSLclDg+B2PQtKgXl0N/U6YhKnUrZOm9JukohSb4bwQ+gyPHzuI9SOC7yEOtrYeW5Ywea/OltSrS7Kfa6iROCtoom77s5k0tiXcVuWXA+8KetlhjjtUXQWAE0f4klDBFnMcWcPpo/e/nHoizw56U8BdWW7XROAoBnewL5NdXOkDsGc3DBVZWcywPRhyihIAM4pohX+R5DFPhk4p5kcVPv+QVmJ9T8cnEdd4UFxOYQQOgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772047318; bh=8QYlcuznWtZvv+qTR8kZM+Yc7/kzM1JpiB8vHTHvdAt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GxUebsOtmI3MetelYoM6qpLG0Wz8mvjv75TjPySfYnAdfE+4iIBqA96e+iOkUGRCsaNPz6OoBrdg80RmrqvITaGVkXo0wQOtwILpJ8sMMmPGEC5IeGfRuVLGM4mUiBPEJOsLNDhd5/ZF4lCnY6jDCZEozpWyuBJaQ93jX5NO6KElZZK4iovq+/C3SfSfrepZ3cSrYEXTATo8X92TWPTGlmTBubpevNcn5d6MQf+AamFansHoxYMVMki26Q2CeySWXiecDWFnaoly9s5+zndxrvD45x2u/mmhMLsWvLEOZSi2tyBoyAaiHlYeCJ/hcYHgCgqjzEsvN+3UMt/CW+8tKA==
X-YMail-OSG: BDRl1coVM1mZyyDSwlI20eBDMAViXyGZc6AtuFgXBBSwqaayiA4TqeU1HuQtuRc
 F7XqLMy.RPi44uINebzuWdhLejXQ4NZLrpsPEQ_5_Jg53ug99GFjo6dJgmrJO1gRlJFdA_5DrPyZ
 FR1BAIN9dGEudbrdBWGsOoOfsPsn0DUZmnAOlWKK5TrFswxRr6o7NyDt_IwbRbsOZfC.qVbg.tVM
 vOmyjz4H3OfHcIcebIyy5atKJZkKv_djDXPFKi8scUI9wDDZBkeNj2UNg2biuZA6hD3ze5_K4cWf
 3qF8qu7EaBpAF8fNOFDTj4tANNN1U1wpAip2ydPnITuwM2QTe1zA9w2n4YMHOXg4axerugvNvH5J
 8CsPgHLp3Z13xQa3C_HHS_Pd2_5fL6Xl5KD6gQraCCP0Kgcmf2RA.uxUF561NybglVt1nWOSUNio
 _Y4OWM1sEYk7qS2EaqWB70Bj3FnIsJrP_XdgxGySGX.pgSC7UchZU39y12A0I5MuNIv7kdCfll2m
 Tm0PIFOAxggjJrrry5GSSJsTZU7VFaxK0Wicqqx31SVbjhDDCD2QiSgDjwBczjO37.gzbTxXk0IM
 6X5JOidAoZTQ1DAGOpqUvlVfAE9esrOAkbqY9qBCnekstbZH.mJdhSdBEuJdd_FDsoVFqaAi_sut
 Xi6awwaDJmXTPwhxLXkRCfRtsvdvGb4on5_lWyrX6Wg8Pr5ctLpC4aGY74lsUdHuzwUrC2Jz_GhM
 affGUxtMH9lUBsTo7pyLqJpER2VxjuSwyNO7sjR._4X1dxRyedAp7oyuIZl6mwNRNVzvW2xjzdeM
 BM1I1OPFKoWSVjX1atvijhqxaS7uNMKRigaKw.uST3VEQCA.fumNm6Tt__YUM9qiNVl_VNat24bV
 U7TTmnmcUrpQpOgqbsO79k1B6f9K47Id5JIzhY5t_YAQ9XJX23rehl05A0I7NvcuTIOcYbVh35G2
 V4we3Lgh7p5g2qbiJTXWKO.W79ldilsoaksBQRxKiBGpdV4D3CF3RDLGFnRBp432RxpQo6_tLFF5
 TTpQt4n6KpPZFanQX.g6xNhIYstnq3yIOSUGktPTLV3XTeap0U9O.4j.6ySPgPVWf10.NcyEXHgU
 H__421_yWKyJB9Ajr_sX4_3r.qttrQgycafLyvdCwdJMjS9LjD9soDSm8hWG8wBJah2NMPSTicjq
 dCCoZup08mGaX9loMKx42FdzgS0isxNhODWQ_Etbn1_ubk2vKY2Po2sUoMoPxZ8cFpK_FAuYHxsI
 VYbHACeEv.U0g4rRTtN6hAuk3OnXZPke1b1Ax8d6Xk7Y_TprXs5Xmdok6t1ZvnqI2vWWupeawh_8
 mSwsmJUw8knHdK_rjlWbino5AnCw79pfKX0f3lCQsz66ljVy0Sbaya3Zk9MpC4J6KBptqbyPJSlF
 1HW3TIcysD1LKZ0HHsNgKOfDXZd0qB_VikYmDn5jzQiDEgFOkqCOgF8PcrYymIojIqocbwtrw5CL
 zqladD_k9Hlwy3Bz.EGVBddUvDln1jiCmwfVmwtSfI.pNJAeyPiBchrzCiUYvtErTuzYX.6sb.uf
 klv6yA.HUrh9fjuCOnZ_J6CPCh6L_WpkwJfPSWifFfInKKVVXM_Bap1hAhch_tsVrTtivTFEBpyZ
 8BQmkY0HT57x4L53e6FeF_jcBq2G7lqFr8Q2scS6ErblIjN0xTxdt5dXNiMuv2IR.gZ52e.K0A8Y
 ewbm5XrANV.wSH8HiNrDBXWQkcdbEqsL7jj0RkZbTOLpqj265p43eDy6SsoAYb6zzAklMpNL4aUP
 uaNz_VqKtRu2IEWZ9yZlJ9OlnpSXbI_dsbLfefGD4rB04WDd32rJlXGvGcOq5pShwz6Aqh51M42N
 Cob5brDJUHVWy6QwRqV70mgINA0gaAVfTDOZEz4zbjjxxFgqnM3r2rNdQDwe1vloV8re3AVnUKaf
 KkiTxa1.tQnVxoomNQ3q_LNB2t5JoWQ2pR4VTwj786DeqBkA_tw0.g.xoJnqSX6LMCsQ0z1ra4vg
 cyF0eqX7cRrir2jZZ8RwPsy4ritAieU97GS9K9qQIl3Zrt4CZEeSVSxhPEplxMnpFOBktGr0_oVY
 ObCQSQEc5GWat8gn0fdYd2u8.lS1tqWBScFRkvwCVIfIsPTK.KyMvBrGaXH5rSRAUQ38.uhUACAF
 hyQupoMkLruPBLHKVQaG_caJFPFDVehbCYldu93pQiSnFH4NLJioT00DM1YQfVfG6dA3S_qq_TKt
 DaJxy_irdkQLM2YBiSqsfBR_..HTTSVl3nIbTSoh7vnSw49IdDzJH0PiroptsOSVw4jRFY1OEh6s
 wTassHrLQDiJNvA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7cd15d2b-39c7-42af-b4be-440b2c5bc1e5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Feb 2026 19:21:58 +0000
Received: by hermes--production-gq1-6dfcf9f8b-5skm9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 34de27226d18fbed2fa1781e81910440;
          Wed, 25 Feb 2026 19:21:55 +0000 (UTC)
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
	selinux@vger.kernel.org
Subject: [RFC PATCH 0/3] LSM: Hook registration exculsivity
Date: Wed, 25 Feb 2026 11:21:40 -0800
Message-ID: <20260225192143.14448-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260225192143.14448-1-casey.ref@schaufler-ca.com>

This patch set represents a reasonably radical change to the LSM
stacking model. The notion of an "exclusive" LSM begins to give
way to exclusive LSM hooks. Instead of disallowing more than one
exclusive LSM, individual hooks are marked as exclusive and only
one is allowed to be registered. Subsequent LSMs that attempt to
register these hooks are denied them. This can have consequences.
The hooks relative to secmarks have been used here to demonstrate
that the scheme can work, and that it isn't always as clean as
one might like.

Please comment fully. Quite a bit of tinkering went into devising
this approach, which is intended to address a number of concerns.

Add a flags field to the LSM hook definition.

The first LSM that requests a hook with the LSM_FLAG_EXCLUSIVE flag
will be the only LSM that can register any hook thus marked.
Attempts by other LSMs to register such hooks are ignored.

Direct access to skb->secmark within LSMs are wrapped with a
helper function lsm_secmark_from_skb(). This function checks to see
if the secmark related LSM hooks, which are marked LSM_FLAG_EXCLUSIVE,
are registered by the calling LSM. If they are, the secmark value is
returned. Otherwise, the invalid secmark value 0 is returned.

Future implementations of lsm_secmark_from_skb() could use some
form of secmark encoding that would allow more than one LSM to
use secmarks at the same time.

The LSMs that currently support use of secmarks are taught how to
identify if they are allowed use of the secmark. Each sets secmark values
differently. At initialization the LSMs have the opportunity to
take steps to ensure correct behavior if they don't have secmark access.

https://github.com/cschaufler/lsm-stacking#secmark-6.19-rc8-v1

Casey Schaufler (3):
  LSM: add a flags field to the LSM hook definitions
  LSM: Enforce exclusive hooks
  LSM: Reserve use of secmarks

 include/linux/bpf_lsm.h          |   2 +-
 include/linux/lsm_hook_defs.h    | 614 ++++++++++++++++---------------
 include/linux/lsm_hooks.h        |   4 +-
 include/linux/security.h         |   3 +
 kernel/bpf/bpf_lsm.c             |  10 +-
 security/apparmor/lsm.c          |  24 +-
 security/bpf/hooks.c             |   2 +-
 security/lsm_init.c              |  66 ++++
 security/security.c              |  21 +-
 security/selinux/hooks.c         |  35 +-
 security/selinux/ss/services.c   |   3 +
 security/smack/smack_lsm.c       |   6 +-
 security/smack/smack_netfilter.c |   6 +
 13 files changed, 473 insertions(+), 323 deletions(-)

-- 
2.52.0

