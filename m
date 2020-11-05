Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A3FC388F9
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 01:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D37120867
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 01:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BbjA3W4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbgKEBK3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 20:10:29 -0500
Received: from sonic313-16.consmr.mail.ne1.yahoo.com ([66.163.185.39]:41797
        "EHLO sonic313-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730050AbgKEBK1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 20:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538625; bh=4i+kcv8akOTQUE9hmm6XfDFksnqK9So86R8nxAIOwmo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=BbjA3W4SGTn3jCTgWo7aA5ib7bVfoxLRcDuO6BzNAl/iK4W335lmqcI7IgbV7NFXKLH25N4I4TTvtpoGDcUuMuAap55wm4SsvkMISQ4lXxNkmasVqigJ8n0VAHAo91x5FmhRFHY3LROrHQUNrIUnqZ2YAxJjtH9yiiFPykjlRRHgKLHYAlylg7rZzwG1cxGVjkq7A1POROi9R/62agoZ72miL0Dlg5yk1UYvpP9tyCARR8o+cfKD1tEbuSW7ox5d5o0VnpUn8maYh4C9tZILcRWY3xqdzRZV1LTS/hxaaw9B/VvSb2XtphRz/rfis6XrDNzMnk8TjNIQ0TaWO4BfYg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604538625; bh=rj7z0LJRoXFE0SUhho0f7Ghxg/nDRpm8ZPm/PLzu42T=; h=From:To:Subject:Date; b=k1k133Glcg7trLYLN8cAlQSrVThx1hzjwvtlFP/UV8QinqfcMKD+WxzXOlAwRulciPvpdZJd8YB9BRKgibI8ZaO9flte2hgl044bt44SmiiYfLenjYdf/ntDZvpYUiucZMW0ajGa5sl/oTGLY7ukMJcsmURabTdz+uXB5zwF4btE4kOyddSnXP2zxDJKldTd/4CCVU+1GOMom/pvW/Z1lGRL+1x74+1rymlbtxlGvD2XMc8dcxCvNdxbPCqkotF74mApQVNkUKKZf+GzO1rTFrOSrtz7UexGKx4GwFYB4dft3rguf7MnH6XtkS858+HrN9USDKHnvjp44M72ufaAVg==
X-YMail-OSG: IECdtoAVM1kw_pORLL3D9Lo6xYsaZz9JhKJiMsSwZ0DslY2Rl8NxsvWPUucCe3i
 _QFXUBRvQUSfKYGjWrW53s6U7eURxPXJg1QlpWjL0Hanwb_jo.5a7_keWlVMknOyV8IT5Vc3Rd_I
 rWbtMDhqtsZ2NKQY4x77Zt2drlFZ29ICQDGICut13Ot.Spzxu9RaJoie6Ut.hCHVVFHYzaJ6L0gR
 XtJn_GLn4Ex0aivsoFBsj86a_SV8E5fLzETxqSOlT5kMuaQmGgstR7qYVtg7zvHEZWzmlEv8FzO9
 7rcs2x9PxOCTcMn7EfHlHuo8JZ1Wyu1fyEv80Qwd_hNggR3W5BMXcZKRdAFUT2F65kySc_gtD39T
 jMn_ec2yvtPjuPnr7V.Zd3Dfp3nU6lUKbSgRi2GxZ.JcrN1uSTgjMHh_3ufInC67Jy_nFm36382j
 yBm1q18IydqtrHNPWpo0UVF8GY_lw1NQXHZd6bNWnL04wmD8I4_kuqdc2fn9N536CUp99t3NK6r4
 C3f.8W_VkHN1PyR4P3t1FunqAoPPwG0yUWMHrLd8WErsdfGaXT5V0sGAAzvtEu633TFVZYLWhqg7
 ODwxLWiZRI2TK7AJ0Z3QZ9clvWp7WHyD7ZyZxgpGzrS6DVEHo6TCPmI8RMB.wlts_KAVCGiBExIo
 27k7Lc8yxIpLSDI2nre7sMXQs9MY9y1zwyAtN67yeiT0BZBUAqTGjO.jcCQ1U3cS0VbDOKfwLyzd
 NcZA.sDRQYHfSD9Mf9VGLHYe0itSoWyfKOecKLKqgl1WAwNjzcrcol5nlup1d7NjdYyvw3uh5HDb
 Tz_pOBj5TrRuTsJXh1jNiB1n0qXs8JGsixSDaSqKipO1Y6Y9mLPEOp8CwhN3ZUUUSgDrR8xmbWo4
 ArAn3IoN5xLnWodkBGwG2hKI9r.Th9yX0yrjY.3bUvj0qmvseNCXZuXQJLb.n0vLUi1zk7SWsTje
 GfQZvF0ROP41idpq7A2eLQncNxYL98vPYaCTIVjEw6WlTqp02Tf9FY0vh1SD_Y5V5cx1GCdD9eAx
 d08jg.ymKoFs48s65THf01m95Ne88tymjNwHFO0bSmBqcNJlR5TVpOtzgGyu1pVY0FoVPiTOzc61
 AjLmxv92MkVr0g_J8tnKPerykpGg.hpVXTGIao9NJToYliTMO4TtyGfYLm__mkF1Tp0kO2yRAlQY
 8pTr1su6Xtpb1okG2i1bTxbB2R.CbsJhgcok2vCxA6HZoZahEmPP1rtIxfTVT8mxHzS_flBEKOjU
 pWRhlo0o_C6X0zQ2wcZ3ybaEbL9ZpHsUciAQH5DBFArEEC2zX1ekF7Dqdqi5YAXhgxmV4dI7smV2
 vbRK2atExV9mqSHlShxv6sOwMQfzZG6MZFvo1gsxQnzRtI_HX8NmFdNMwx1DJD3jSkurFJ_EsLKK
 OGrnsHRg6esQyvI8yX_OD4gSaPv3LioSiKLOJy3JffURhD3xw7j0Gv.ohNinpYLSpLxhx14L_k5m
 2TNQIrkOM4esFmjZz86pkq8c4JVgaX0ojGsAhqUGaHVAp_lHH8gBzIwPlfIA0nJ2NmqLYCngqWlM
 Op0ooOVUmljiFKJegFViX3Jwa5RpkYZ9PeR0.vejrx9R56M7ewTQYxXBv0EmcQzXK4ZVDpysLTpS
 W1Xmff9J155xkEKDtow6MNDjMdSxUiq6T.rUpRcqhHLJRYC6xjVEzJZjBzW6T.bu5y.GJampXK3H
 9xWhz1ShW2VxvsGwuOaN_LJpZViVRaIicXNHdShEyK68U_f2dWv__MoRVlHiliEeQPqlZVGaWjXm
 e.mnB6_vtJndHTHbOufP0tKCEnnFbKmwp53312xx72nWEN1HTdRJhZ5WqCppHvBeTvfbHsyCKoxS
 BAyd9SQKTPUgKU_XxRe3cX1x7M21oEGhJ4F7miCwUzUasUJVkLMeZAs9IQfKh2KVmUdEYrZs_QEE
 2KFPmTzQZ4RYu.mgmN0yurPZ4H_XL6rVmZRHI4sb9XOorifKAMgQpmtyn4Sk0BOWPnAc9TAqGuRV
 y6aDC8GNi6gu2FRsvjKFgDxBeQ1l.A_MjwgDvoqLaKPkLPVugFdfOcXGQMdjjq3VScqgE7dpAt1t
 RZWucUTRIVoVKLmRNWjt0yK8NFJcipFxDIMKcdwh1qlYMm0ycfk.bjVIpGX4gEhaRkJDLX92kdyF
 _d4V3AprtKU8stKhp7Yap6ZplOaCrr_yLcT0IvzNTrnp8nOr3HhVf99wG7y2x3To5DVGjjHRf7hs
 uLrmGSohr4EqYOqLRNv1rbMwWLBelEbmOrYEzvQa7qEW1L57KzUzpADgbhP7Tu0aa2OhkuryfbgJ
 TQjIY8hkwVG2.Idg03VMH548zG8Trmp4E_CJjlrO16zSOcqKlyWZN8YwIxOqfHl4H_QvFjI2gCvE
 KJj0uSZqlfPoIk4vYkQNSFdQzro8j83Q159K1R4ddLaygYt7w5F0yRORmjXFyVLi3DvXxrzU4AyS
 ZTSAMXVFAycGuibvXgf1bkOmTMkP0YXslzoOFuVyMxZjTD4q0Ob5TYkIRyGUzaHme_8d0qb6B.tv
 S_NzJgQtJG_pFUIBZxND5iGviH.zbNfVhQjExFXUIdmQqDKoaGxqS6bXb3EoaBCyVlswwsT81pRs
 cSgof3NFw4mLD4rpwZCniwxNMIcs2W_SppWAscTMPqZglq1Zly3LA8QMS3X5U98tVCB0LTlF.AF1
 FmTQcVrnh3.U.IKqFoCHgD5loees5jR7_of6BFb3nKYFLOQu6U9Cjixw9XZeYxauEnZfNqc2tOEB
 okvDQCrUhQuhw3WPfulnprfE6G0jiozbjy3HdgNjImImedE9xVJwCIqftqRvKBs28sm_fUSmkRKP
 Fn8BSsgAT2cNMg75gW46bjW8Q1I6C3Ng3VkpNnnK49BFaUiNL6lkgiH9mOuwwdk1XTZ.ZTjqiTgs
 rjeR77HqtP7T_EhSD65BtDDCJQrIZpWJ2p9cxngMgsri58VQLDMbxFjnWWJ0rRaJRBwyGiURu.OP
 FHwhQjPbUzCQ2PpKy2DG20KT.VhcCST8TvPwfh26aNEXuUGxQNtHVyCB1cl7304I7tMhcYOZjjZz
 rIOD06NPlsZ8xizsgUQmIy1IpejEQxYzuytZAXk36BA.IXmLdUb2d0KNzRfUTtdorA0SZG80dQw2
 ktjGamk8qQFtWyLvY.9jwxgE6.Lh4fgpzN9mkIF33jUMY6XDII8.o0hZvsZOJx4ns5DxUPx93.FR
 MoZ0l0Cj7jNfu9p.1RreX6Gke6C0gWz7ZkxFElr9hQiuXag5ayddW7EN1hWkKnAAK6Yy3Cegjp9U
 FDwRssgzwHeLufHMEy88NM8SpRhQd5n3AIWsuAHUAWR7p7OR7tBVcOqx347tYWjrlzlchz5sCz3h
 jSifp410-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Nov 2020 01:10:25 +0000
Received: by smtp422.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4b27f7017aa0de7d88a033876570fde1;
          Thu, 05 Nov 2020 01:10:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v22 18/23] LSM: Verify LSM display sanity in binder
Date:   Wed,  4 Nov 2020 16:49:19 -0800
Message-Id: <20201105004924.11651-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201105004924.11651-1-casey@schaufler-ca.com>
References: <20201105004924.11651-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Verify that the tasks on the ends of a binder transaction
use the same "display" security module. This prevents confusion
of security "contexts".

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/security.c b/security/security.c
index 6c8debdfd629..c6b0f854c4a3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -791,9 +791,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
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
+	int from_display = lsm_task_display(from);
+	int to_display = lsm_task_display(to);
+
+	/*
+	 * If the display is LSMBLOB_INVALID the first module that has
+	 * an entry is used. This will be in the 0 slot.
+	 *
+	 * This is currently only required if the server has requested
+	 * peer contexts, but it would be unwieldly to have too much of
+	 * the binder driver detail here.
+	 */
+	if (from_display == LSMBLOB_INVALID)
+		from_display = 0;
+	if (to_display == LSMBLOB_INVALID)
+		to_display = 0;
+	if (from_display != to_display)
+		return -EINVAL;
+
 	return call_int_hook(binder_transaction, 0, from, to);
 }
 
-- 
2.24.1

