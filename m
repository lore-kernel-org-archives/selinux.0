Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59944C48BD1
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340696135C
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhFKA2y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:28:54 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:34925
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230346AbhFKA2y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 20:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623371217; bh=0ocsldoX5aiLd/U7MOpua/oUOKyqWZuadpgQ3p8PIps=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LpLDluwvN0RvGIUTq/zO8CcgnuxbAQSg5yq0iW3Cu29B2uKfiwTN5Dl0bNE+o0PKkk8zN7tyW0B0MywVCCRGfZgvmtOYiwlzTZRj9L98jJ11qHwGa57ggxX5BG1rZcAMPAxx7RU8PbfM7fY9UwkSgSe8kuz4yW1L9LAt0FyLCge2kEm64FBs9ztzGBH223zyNzJ7+t0mACVjHLzI4DgTvcl9Ism8J5OuO8rl1awF+5OoPTf/mwlHijAQ/8zjQHD6RjsdqYmcHjqV7PJHGikos3mgtP+x2zanSjf57tXz44lzjAdLg6E7N3DoZKXJGpSPEllAnJm4u9BmUQDHj98Trg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623371217; bh=zigjhW536bXbp/QKnE0Eyan8mUFMv14n6w9ydJODVcM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GohfLFBOVea50i+YMYCOojkRM6NFhtoclCxcpF864gPmmr+eBE6ykocQo19mrLe59PpU8ssIcH733O3kRdAgOyIRo/CHx9sxuwPnUtcvL+a3yDexJ1hHpmwBBBUZ3cuE/lutnn1NcLDJEg4Q+uR4Enq8IVd1fnLXotdzjNm6PCFHmAC5C67hIUlLzwUtb59wPJ2rGaNEAmGwxFyIeFMCZbWukkejGQNPBt66N7gdYQ7bndw39/AiK0CDcB35BCERysjZ0jh3HOdwLaiM4ukZxOqq+MJzuYaEpNA2B5VHc+oaaCdI1ozTLPaTXTTELNWz7Z+xxEeJU0j6LsJ3nPv6xg==
X-YMail-OSG: xZsLNEsVM1kjFd.vEYoaVog4gMExSvAnbpjo_tQG9Cl9knBqvyxRmv_.XtTQyTm
 l5An0EDksR7G4NXdlVr_ZLQ.3e1Z8eisHZoaG5yB8iDVabm61DLnJeuNwNWDAvnLWmR0JZaoSfSS
 xGIqpXdW3MwzSL_gMGEPvC8nWng9liNRetO5hfSX7aFFVh22GEWwfgPaq5HjU12Ob58R4T_8j4Jq
 X7.6LB05dGmwYnZsEpaTPZx0bItT7NqJKb_LEzBRSBbjfPz3Sqx7wkx_vHLqdZJNX3skN1zUGfhP
 ZcagTmihlDZEmOeHDGk8V9hnZMCP0Q2sSp3U1NaGSnk_2SfwuhgOMyNxZggxVWsa_T5MawaND6JT
 OiRezwYkL_HPDIk.Or3Je4bZ0wRbR8zp6ldrUAAlAuA7umC3L.nNMpLjQoCYmsspK99Ah5qPOlMP
 TwaOGDiGotdb2a972eQLKtr_ynI_EmrjNN_f1WHh0_uASRS9ey.cFiv62yIuCLttEXDl5jewm.nS
 PFqF5dHHfIydiSJAZeD7HDHYoKs5tkq1cFgPkDVZwIgAi_r.fCUWCzSm5OUslAeojC7KWAPxwYO2
 Nk7eB7HCCtXxenQjHJ04vNTRNlX7P.WwW4cdzmgM_tMC2B2WuPRRNQqiZZk..D842HNTGE0v_q05
 _Cj6ebLCw55UleGSHDhIEgLtACALPY9gYRi2YyVfWU2r7cDcxmliykiYEMs__5qFOxFtepj11x7F
 y6bWR9DChD7Hum4VEpcC8mlF6ylTr9XE26xbXI7Er9vsY0_AU5pTOx9Obdf6BelQ7F0JrgjqIwIB
 b4RtCnHpyELV1MhjQJSBbvlw1UX5dk1i6OI91QoIqJPD0KRnNnj6tnsAD2a9i9Sw0yfHhsQgV4LC
 0PB1H3dG6qPdjx_zhqdie85S7FH5A9QXHstot.gUcA05xV9aP9oCJlPwDa8fM6A7tXsMGJS0RTFt
 vG1GUwZYiepU6Oj0rPmDBp.tUHrvp6Pr7wQEhB8lUqoDi2dEuHqK.QC21Q8iZhoKkcHusAgXwdWZ
 9gRjLrqdTWHo8LaX0a3IYfo2W4Coh9iGdiDAXjOm6_2Ksq_c3v5zo_JcSFGHEa4TXnxrP6mZbV2y
 v9dYQBgUY7UedNcWXeKrlCv30IKrII38UfuKfTGBJ1TLxPfXZI1DxOTFNY5JvX7yfO2obBMQydVE
 0xOtDqOkmt0DSRMVxPfG0JaAhwonVKZcxDFbMiUfMD3oVcOwGr_xN7TAymVPVEaC6vUUVUaJzaCr
 1N6W1TYXB2Od0U29.i.byNILOnnXAjGtoyOdGpHYXQ3BqMZ.XcruBWnwhvVYtiqLpwjWgS.Q4NzH
 8nBVqur3qEs.zMvI_vDiPoe_B0HyW6Oef3KH0j_7t9W2FSFpJcDFgxMQ6xA4iHsIF_DNpecU1dzu
 pw319LYRXxKvnb1wfEIclhvuPWD5NA5.QckSsi66.gnrzHJ0z6CoO93PRrwjPFNp6swUlzR5N0uG
 eQ6MVw0ymh_Txb_Vq3nOwwqCVgZWY6ycLd6YEpYL.0lzGgE08Cgw2hjhP9kNyeEHGCqVDAdiilgs
 wZak0UQfjjb8CMzwjQjqPtyhHZtfTEqKU5GhLKVdlcPXO4k0XLHbxcOeIpdvfPR2LBjpEh8zizne
 oFAXU2lpdrjz5eLxrdEvySuq9QWYhEu0ehqANJpPRFE.jss1x9MR2p5dBGpK_a6REQClNsZ3eabW
 7N5pMo0jNR6MmrgUJDjzK_BZ99pVkuAFKGeHToi3oMyymVXYuC.hzWvaqEPOahgy1j.dHerdkUq0
 O_LAAeJp4kvDUJhJEmspdKjdDzz06eF.7O6aHH2XQ8bVYgnc9d7J3d0XeQBRjVV_ORNqbbccIfhj
 FQd3nj4MHzuo3_4YYecNxDYjxmzoD3kme2AnMiPh9O1gp95hRJOKDQb8rAjoOwAAl5AQPm_0HwrN
 UbdjOMyNU9sZ1yu66GU.8taDAbrFqBlcmlhpYTaZJyavpemZ4QL7MAF5UqkmamxXd7m7NflA72JE
 79jCHy4.59vs1M1sVtCtNyXFsjdW4voteEQJFaKhlylkXn9i9sOx6OMMX6uzScLHFW4740_eVbAz
 ouegnLXNLtWlozMk_DOxlGLlc.0n.Y7xPSyPx4zmXJBgemeFY3k_4xryDXwAlMjynJOQJUsoMNJy
 2IKjpJsaV4ERIy_uCiAPDh0Bbmrly7feOUbr4h_hOVi.j2fm672MkrreOEPraxG5Z4tcCg7KvWeo
 patKwNEhObZZKgO2vI_vFyNvUg6qoY56otUEBe5EP55eEy8ZFB2o853P76XbP_PSIxEoECiuRvCM
 wRcAZgxHhcgKzeZyZ0.gaq1xb5fI79n35nTEN.wc0uoIhT04a85OEASeD5KkOrV3hv0tkw.kE8jy
 WvmDCk5We5AC_zAjtovtVQyUG4_aL62uPLGo4.y0vipvdnc9m2vqIdPDeZytNVEwIvFsVKv04lr9
 TgwPoinphwZ8UqVCvhwPZit6JIyAhEg6EkC8MnVYzXiSbgfn2VQWkov4cLQ5kosfKYSy_wHAxymO
 ObfhKBgfKX3vDxMnyeJbdOUAUqbSr1S7ujmVwNGIp1PCYn1JRHHBhr9u7e.VuDLhvbMEu3KXXA1u
 dcu4REaIPkLGJfW4zet9LJBUHR9nAKnJnxlrd7JiB.CtO11KqELJ7bIWgkqPGhZQ7pDULwIeuYUr
 L8T9STLev00TO3Wy3WNHxGZDPj1o6jfYhHsoV7.kn57XzH.avXpDR4Oel254vohQXQDztDd4qrJ2
 .jtOxtn0k4LGwlS.QDGS44gRC2jMHWK5YK0JWYwNisXZi9pcI2SivMLH3i9ltvgM4gaevR37v6li
 88GvzNJKB81jZaDQY6DyZSz0_lryBYM1b6v.8m4Pm_QKJvmWM7p4erZe7ye0gTeWs2nEgJz5eTUd
 9Le.8cEcV7fkdbukV28D8.rxgg39a14iT0CETZUS.a5K4s1ltPy9Ah8iZRR8gCh6z5s6Wu.BmrdS
 yep.kayPATDwbVOb409VyEZ5QEkA4GXQBCkqJl66nPj5X7CZq5f7imynilMiDWNMjdotZoK04Wgq
 nxFAAuyIdKLijSTiQQbxdustnf0D4c6thoRGrUA1k25_jFiUQH_EV7fYz7qmTeFGDZ0.P7uyj3pE
 Ln7OJ5Uz808hJpmp1YYEp1UJeUzT3BYSaPw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:26:57 +0000
Received: by kubenode528.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 765bae9a76b99cccc78663309335f09c;
          Fri, 11 Jun 2021 00:26:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v27 20/25] LSM: Verify LSM display sanity in binder
Date:   Thu, 10 Jun 2021 17:04:30 -0700
Message-Id: <20210611000435.36398-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Verify that the tasks on the ends of a binder transaction
use the same "interface_lsm" security module. This prevents
confusion of security "contexts".

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/security.c b/security/security.c
index a5150de2f3db..ae23b5a8fe87 100644
--- a/security/security.c
+++ b/security/security.c
@@ -859,9 +859,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
 	return call_int_hook(binder_set_context_mgr, 0, mgr);
 }
 
+/**
+ * security_binder_transaction - Binder driver transaction check
+ * @from: source of the transaction
+ * @to: destination of the transaction
+ *
+ * Verify that the tasks have the same LSM "display", then
+ * call the security module hooks.
+ *
+ * Returns -EINVAL if the displays don't match, or the
+ * result of the security module checks.
+ */
 int security_binder_transaction(struct task_struct *from,
 				struct task_struct *to)
 {
+	int from_ilsm = lsm_task_ilsm(from);
+	int to_ilsm = lsm_task_ilsm(to);
+
+	/*
+	 * If the ilsm is LSMBLOB_INVALID the first module that has
+	 * an entry is used. This will be in the 0 slot.
+	 *
+	 * This is currently only required if the server has requested
+	 * peer contexts, but it would be unwieldly to have too much of
+	 * the binder driver detail here.
+	 */
+	if (from_ilsm == LSMBLOB_INVALID)
+		from_ilsm = 0;
+	if (to_ilsm == LSMBLOB_INVALID)
+		to_ilsm = 0;
+	if (from_ilsm != to_ilsm)
+		return -EINVAL;
+
 	return call_int_hook(binder_transaction, 0, from, to);
 }
 
-- 
2.29.2

