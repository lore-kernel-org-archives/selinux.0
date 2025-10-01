Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE222AEF5
	for <selinux@vger.kernel.org>; Wed,  1 Oct 2025 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759355824; cv=none; b=GslzS4sQfchKRNDZyZLKv1uEGiFD8d1Zepp626FSF/oAnoXJa0yj89UrlU3w4EydxMt5wH+AGMllvsgr/QMsBskrS83QFXrGoD6LZHzj6gMjvl+i6EQ0NnNDemQG7WXWDIzMjSq2TeoKwFgbkl/4bEmsB4yhAFcsmZWrTxdrfSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759355824; c=relaxed/simple;
	bh=/KHwMvApgdHtxvt4nJFBBT22DUVQzjKqbkBKZ6OaPgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=sa1v1c6AV7KAf1oAtq9/vU1gfWZGS7BOo/x+8o9HrTZHYDH+7w1zdyDOFA7YWSaN0Uq+R5sMT2FI5Kq3IfsXPWJkYydgjQQ8FKXvg/D+pDdCENOcXp6DXkMNayzrzXklR5CkD+qkuUFCmJlfZHu6CuU4/+X3gr4kVpRd5FPyZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TG/dNr2D; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TG/dNr2D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1759355816; bh=d5W86E9kzuTsMlc3NVlw42rhi4hfIHTHvgYCsbysjUU=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=TG/dNr2DWDNu3QWiA0onQwFjvRvRyPDACiJT/PD96QG6ktuO40XKdIhEw7YJWbiSWelysorHG7SQh6e9uIXRl5yVH6+G369qi3zn0GTUrh+3czabDusTaqsjW6vhOS7lv/MotBo5BaZ/cBPobjmUbiWu/EsLT+BjTbtBWOZhKQ0AI6E7LTvqyh6HLhMCwwGucIPyL0Gvaak+QtIZhbunnjlEI24t3ZwPnDuhW4LPMgxWmz6KVktvinIiO9/4KMQ9g7qMLK9ezeR3GTISvmaJxJT0KWXa8OWu8X1N5fGsoGwAWI1UBJYJyfydDxjspHKDVIQu0bGDSFWUZ9+XCDn1vA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1759355816; bh=JN+ISi6AqfeTELbc+k5wiO1rPZYfFx7HHkobVJminN5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=dTAc7XI5df0CKJilnzvES+Y5DQ52r1BDMjD9790OgnXoNYrv667z9YVe0NXkkyuZfuDUXYEXsHzgdBt0oJpq0eQW1bXGbjonbdAKBGBC3r5+YXcyvyVGFQeU02XtA8KMmGH/dAlCsRK7BQwdLqLxHN5n2i/d7ACl56By0o1fWM7j4pCgcy5yjBezxXO84qDYtC+lYY29Il0UM7G/HxWoN1JFoP/DDBN8KBn1EPuFB8J4MWF/IU9R5TjCOTCWmFfmf1QdepAGRZORPo0BlNWTmwuVNJ7xEl8GP0sRF0TIMTpTZLLBal4CuCB2xbOaTwSYu2Tff2lIg2piWdn6SMfKKQ==
X-YMail-OSG: rbGmPKEVM1mkdoaE5n1qqLgf_1_0k2nf8hYCAM2avjykzkU1eEP3zX6AF85l4hl
 5yzBvR0E0FD4ieqG2vKKRWRFRCd6W2N9hantVk8O8ctfMOCudCUc47oLuD.JeHuBGfl4_9NMz7NA
 0JDMhWZos_7p67EPhFWdkwXoscj4Zvh5tKUutfhTwpbYM08cpLZo0bn_JxW.BumoDiLj.ZPm_dzU
 ZtzDTohfZOIOh65Eg49AZtKAXvS17GusrSu6O7N.V3pX0L7HHX72HJrt9nqTE73ZsLidVn1nqDxo
 mPTPYcAPlt6ye0gISLqD3W2e94qRjGQJ42JOerygXLVJ9jcS.CTEX2CwPt7tnatrUZET5tjCDdlR
 esIASYucvTd5W1foWefwQE8_zfFn2Y_JOYuTuZLQ5P1bawZQBQuMdY7JM.NP2xZKcBlrxUDrXJzc
 9.Isml8dVyIrAXm_55BBmIoU7T.DSTE7HyobFNPiMBbHLFeSkPksuRTD1IykuoY4gE0bnUoV5zET
 _lRXKZBPduSazXh5bsToJ.dDDDaqlUYP5pMkv7q1i75p3qIxidXxbOuVPkSM48axgGwpvgIF3_nu
 rzlP6v_ggk14oEUyXleR7rTcUDQWmcKessRbnt6JyNYWA09LgHd6cWW0mSjPGMloke_SQgLS2i1E
 gv4v0vzsP28OFlsN8N1ndhMvW2QY103ES6An9FvE7UzRMGLSNkgvV9oSbP.5dzBvQpD0vRxrvvIZ
 v0Avej9EXBNFwCMvFhYgX88pVRooJGwSmqV_csEoStnZZ87xkfykkLlI1Kuw1KvndKmUElvS1OKG
 7Vkq_0ZHk8TQ.IUrHLlbGz9.6MS2H6Qq9xzGLSMlV90gEaNAkj7HaqbNdqkSH7l18aJt8Ty.QAKl
 aA9RCKdrjT3zfgT8EM66z3ASci63lVzNYQZgbJRGELlwmzdipGYw7UlzG9cizP_kJ.vWDBZxzW2u
 t52pMQNWvP_lPW3N4JRryHfqRm04F66.jYreg.XgBc.nqSGhxlxSFtHNaULxnn4jIy7hVpmI_hIn
 cF8NlxDgZJfCxiAFadWgMQpiEzQzqDCfnufmLROB18Bgg7ea4TTNHW1u.Yw7Ue43XhPIfKnL5xNP
 FtC0zjLlpjqgmTA.LRhZMI7d2Ic1IVSVgrL5wm5a7j__bOMoJo2mceDeHFPanwfFLy_blgKB1lzO
 16t8vx82OjYIcFUcCSL6Mi9EydpAmHme0fVO89WstjWDJbKfHOiUBc3OR7cpO78Yj95mY2Y3eebT
 xh_txGmY_AuVXYgpjvp7Z0aUczDAoa9FNdu7b7fo.OY1fxdjHwnkDF9KBdnMedcwc.Vmln4aE887
 1kabhAM4UnqeNdn1N6jPtOyDmawseE8kaeYJiJCJFvuiuW86q7CvBPEKwP0Xym7EwGEw.OcoC7Bq
 4H8y1INbTiOPr4ARkpjjqXviypBpxz1tjz5UjgOmPYmCwgGS6XzQxt9gtM6bf2mk1p_xYxNvW2tU
 2x.yI12paduaTdvLkQA5W.Yhc5Esl7LaI0GU3MXW5aroyLziKDFjU3FNnW1qHxB.YPopWiUrsKO9
 0eYM.su5PJztJOripWFj1AZ20BwtGzntSS4dYAsr3NyHflm9WV.8jWMSEluH3mbTyNyMqVHDOrLw
 cmoQ7eWsQWQhzZvsfwhoUlrs.rMvyHSNFWVi_weJyUTBr1cRF_jOkBeERzttJZcFmIG68STAQ9WM
 uNgx5EGylSCrb5QXaS6uyb7TDrQ4IzGvluCHpnh8K_Gl0h45.w2I_z_gOzXiOR0zAFV4M7wMcf0w
 017OR.N328QJe.VsqlQuFKZJPtWJjxGJixig0m9VXz9Jwg5_b4NQzQv3GUMktjR_F7Dl3uhECI.V
 fI6B7d.jknVfpDJ2XYJ5nWPCMdCvehc2LrCJdQnehQPjydlb3OR.FshzARAGrSQfqTBtu54hf4RT
 v4EN2sSlgQrzAUMJw6UH10FlkERyU0grjh4s5Mj0snxocjPTwJRHX_JgziQ.IT1GrbzXEUUfvnw2
 UY8A3P07uFJevyaAfqMLz7GO63tsLidUZfySx4cMyw94637F7KbrsNWcMd8KuQ5auO7A_2oFatfB
 wfAejbE3x8kxpQnfAzs6_DAm1mPVEKsYbypogKkKAit.M35sykB36CvR_5BuMgYgQIrlR1CXMga_
 10S4bo8h6ujf1GPPxrqHJntKsWF5bISxMKbIOOZgqOfbYWVdNm5ujvphOb61QBFp_vEcOSvHdmsz
 71w5gTrt8Qm6azR0ao1h8ur6GgR06m.tJVK.OScwxzCLOCGI6WBXsmZd.YoDMg85M1YdvGULBAB5
 WKesFI_AUNFJkRp45lg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 88c7b613-922f-44fb-bb61-e616cd609782
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 1 Oct 2025 21:56:56 +0000
Received: by hermes--production-gq1-66b66ffd5-4kj8j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 49e653aa15d96dc3c9cb4665110aa952;
          Wed, 01 Oct 2025 21:56:54 +0000 (UTC)
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
	selinux@vger.kernel.org
Subject: [PATCH 0/2] LSM: Identify module using network facilities
Date: Wed,  1 Oct 2025 14:56:41 -0700
Message-ID: <20251001215643.31465-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20251001215643.31465-1-casey.ref@schaufler-ca.com>

Security identification for network packets is provided by two mechanisms,
secmarks and netlabel.

Secmarks are 32 bit quantities managed by the netfilter system.  It is
strongly believed that there is no hope that the size of this will ever
change. This is problematic in the face of multiple security modules
trying to use this facility at the same time.  There is no identified use
case, nor user space support for specifying netfilter rules for multiple
LSMs. The LSMs have been modified to request use of the secmark, and to
eschew them if the request is denied. The first LSM that requests use
of secmarks is granted it, and all subsequent requests are denied.

Netlabel uses the CIPSO2 and CALIPSO IP options to transmit security
information on IP packets. It does not support sending multiple sets of
data. It is unlikely that any two LSMs would agree on how a packet should
be labeled. As with the secmarks, LSMs have been modified to request use
of netlabel, and to eschew them if the request is denied. The first LSM
that requests use of netlabel is granted it, and all subsequent requests
are denied.

The ordering determines which LSM gets these features. The ability
to determine which LSM gets the feature at boot time, perhaps with
lsm.secmark and lsm.netlabel boot options, is left for future work.

https://github.com/cschaufler/lsm-stacking#secmark-6.17-rc6-v1

Casey Schaufler (2):
  LSM: Exclusive secmark usage
  LSM: Allow reservation of netlabel

 include/linux/lsm_hooks.h           |  2 ++
 security/apparmor/include/net.h     |  5 ++++
 security/apparmor/lsm.c             |  7 +++---
 security/security.c                 | 12 +++++++++
 security/selinux/hooks.c            | 11 +++++---
 security/selinux/include/netlabel.h |  5 ++++
 security/selinux/netlabel.c         |  4 +--
 security/smack/smack.h              | 10 ++++++++
 security/smack/smack_lsm.c          | 39 +++++++++++++++++++++--------
 security/smack/smack_netfilter.c    | 10 ++++++--
 security/smack/smackfs.c            | 20 ++++++++++++++-
 11 files changed, 103 insertions(+), 22 deletions(-)

-- 
2.51.0

