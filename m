Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BF5C433E6
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 15:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185586526E
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 15:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhCIPF2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:05:28 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:43040
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231681AbhCIPFH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 10:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615302306; bh=omFPyEjnY2cGDGLKwfF2DECd7JyX0trPj8ccTe5YsPc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=d940G/CQrzevZEsO9LJe2Efka9ztt0OF7P1owyVTjl99NqpB6OLzPtuSjrPzp8mQxJSDYhb/5Sp4M7hEggHkH27hA2TL8zH/sPmRCTXU68qh7zWiUaXnNtItuN7oohbnGhRaq05I9ONCn9o8B8LCj83nQK1PEv7dVTVR0uvT/K5zNglDymVyYpKxgGZplIx3kvbj9HnQcADfD+mrrmFkt6UuKJk4YONbrtl73F8RD1G4QiCBC5p9qCzDzC82ykj16BwoQVhswGVHQuUTCDEgMhwHJBh/G7C44wl5mPqAqeTAb9IGyit0dL1qLeH2hOQIQ6PvNz+XpxjCE4jUSRX3ww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615302306; bh=3WYZ49h+ubXzSBzg2RJxbOCE6ty+0cjSdrG2U72yPBd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FCwd5LSGdiVw97kGJm306TW0Ak+ePu5ByKE/qJ9YOWC9V36iY78n2H3zFrgS8Qnz6CpmyRd7B2qAdg0XJZ/hya4VxNDTX9N/jqWjCo+1Gjo2xdo8TvIjyZCL6AZOLWya/m8PDIxZYveCbbrIbsmHGtmifG8FbCnWHjVyU5eW+LE60+I9XcpEP5Q3+D98axMF9g1pOwGw5F6Zwgf6PNJ4Biuud18vtIa+ncsQh+DEpW3UUcX9JN6znpONT8XnM46oWuTfAjLZ3aXMlqD3myojTF1bVAU2wz6SzacwPNy3bxw/49PFH/x0eRx5BPfQ7oDEo/9ARaxLV0K/uZXnLokz1w==
X-YMail-OSG: RRWc8XIVM1n065f1kMl2RVYJ1LtQOlxQkTH.hTmd3VWdJjznHdVakNP_xBMpOLc
 wdnihRfHnait4F2MIWqRHYLi_dOrFgampxDDRpq3LiqQRaYbv2_S8Onzg99XVPfVEHzBxlqj0pcv
 B2SAZAyzPmDSFwI0ij0f2eqVXPBKrndbawcYjOzemS3JlkgFYysAdfMN1GfKNWeYLmRT0e5MxIlY
 _moODuRTr2IWHINdUkv182OkUl4Zzs3a8m5Y1VE32u.OVE7ueA9ASN3PRMclM0WC6AQ7qViOvAl2
 Q_M8DxX7ut25hzVg860tqUnQ6iVR_3orPk_gzZ5Jxj0TyNgd7NjKTGqkQVr8nPAqO0zgxLBc__TD
 g.uEODRBXOF3B2Q_AJSSBf6UNqtT0pISsHgS5IWdhIiYboa6HjdfiVMaNKadFeO0PMfuFG0U7Chz
 VxwoML9.X_EHEhrz0wTi_9v0i2Hx8TorgjvUhCSV6Al4VXBhR2ttTzNdA48ogxhZ_XFKMzhM9O6g
 Jr0pO833BlscH438nMkYKbe7.QRF4P1uSAkaXj7wAlYLsfVvAZI7Gd8rawJm4CiLJD4U0qBSRDzd
 pQ58nPIXlKRG1nbJrC9_OpuOMQIi01NWYu2z0u7VKQxX3vM.g066bMej0B_sJ2I5RCIpo_R810t3
 iy10CPHt6YfIV4eEnOfQadSXNWm9iT73RX1FTVBYT6Dh_NF1QoZdflLqbBkhMnji_wV9EZo6DqAC
 LpvRj4i0H0jqNT2j7XNrmxgqTU21Y4HfCFnAKYtoWR7pxpytEroWper.SloWwMd2IeJfMGLWDjjY
 8c.A0vt6aESx9p4vhBLf6IvvXvsE4wGmZJ9vMSzkgKjlcbzuT5uhWHgW15Xk8r4IwxZgdhNEdDBr
 QbBFvJdZD3UT0M2aDL_2vNY1WeZrg4ZHcvIx_jI3B3ivpS_PiJWusZMSQDTHmN1bfBWyp8DAhPPD
 Ig1bot6RpfNEOI3sRNpr.ZlSefyd3NbjPcLegU5VGFB_0RUe3xWzOSMSxwGKbPRPoPB8ZHVNlrtX
 QKFrAU04sNLM5AmIhSfH3kROz.nj_7w6Ki_MsV45cJ8WfSeQtb.9bgPix_c59LlmT2jdrsqlD6FD
 sPKK6.PhKppI7AEBrvmS.WDInL7RoEJYvDlSxz7bQAFmavPHpziTtf3ahfDm9zpiBqPv1cyPSKC_
 3KQNKsx800DRrqw_KscYcZL6jyVXbBOFyVa.sXeGrSx7TlX4SwB.9PafylXpZ8YTDnC_ZfaYoNef
 i7zHbxo.M9xmLFSwsiaPm_5JwMX_6uLlGWyL2swMGeNX6joFc0nLHJVLkOXfSOVZcajrZaniWBko
 f2JV6SIRinIMz6.ZT0Rn_A.Rrwpvrnmyn1u13lJIk8TKroexGUdYdfUZ1BhXhs_bN672BofeiWId
 ALmJ9SYnd3bb.5B.y8UnCT9_R_vcfNxsBuFzqkV8ea5vi2nXepqcDoJciRPRzSZ5MAs19QVve2Hj
 p41KkNA34poJR6qMtP3bEK08gSVNCAfSzfLszXb4L8K91nUX5m7qrzJCahIj1VWG1NpAya.s91kI
 VIsaF2LiuuRPhbzUEdF811wzkwe1R9T_xsiT7YLn2ImfDKOjiK6oDjkqOusH1p7DSDr8YBX7jNfQ
 .81Wdfbp8HT5GJaP9sIcablrzRnaStrEQ7zoMP2ZCn78DcBM_WrUKoHg_7wmPuSsqnOwjwHDTlkZ
 VoqmDxaeUP28hwloq5FWGIFVUtz7VJhr1EqCZ6qUgIoDgBj3IYtbA5wjOn_.RfcGT2nTzHCcTAup
 ohhNz5NykSWCFsAZq76wUqPMeL.zt6NvXHUyG_QqNsHlgjIH9d24Re1fXPQXUKuqHHu4c6oQA17r
 n_O.EtCJoP6r35PDatBEO9XmWQaqQwuCCC99M6UjJvvHKdoiR_0YqiOzCDw9JAUz9c75B1cos.Ju
 62p9pzaRf3tAPDlGuvsxTR_uyUqDNFjleD7oinKOe8k0LiWRgYQRytagxVG_6Keta2IUSGUNmVCC
 JLn9ZQ5A3GmBYkFckdtdq.4yiBcYd0e5rrQ9inFycq2I3CTJaXZiXAyuPIb8BIyoUmDd3L62p0R_
 n30z3K.MVooKTHbi2iBWZxAKQlvSXxix1iCmi7LdydYWmqPum9NraWs45H6yKvAP_ZVhYtn0_U5d
 vbROt5Z7Kg89xLKz1ty0JglpEYkVIiVxXm3PliOk08PWHNRaHbiuAa6s80VzZwfQ9LFdoDJL3cXn
 9E0pE2k8cmLt3jNKNCPZbAmEn4j4FbIbN8uvUhq5h5mugyFnWAxnn2zc9fWPG87GGwC43DUJ7IFj
 Ut8IU.Y95Sz8311ETnlNnEItdEyt5OYE1WxtRYakdQMVQAscHRJiCWYB5IfXos9XzPRp4QanLuGa
 SGNEoxnePNaLUKG4rP4mtIM.ayFuaeo9YDu1s5y6ja0uN1wa0ViddbqiXlSoneQ9KV0i20ESY18r
 ZLNSrJe7N68qsiCioRoLRq9_0styAoX1j83FS3aBwGO5tAhaPyqEqPyggB8fY1Mvzg6abTLWv2Jv
 EJUUgIe2mzcNB42jN4.Eh9oBDaKyigPoyLN7UGDSn75DBG9tMooS1IT7z_DJNDRCb3eVhV88Kwec
 gMMyA9DY0Qv.mzf.qFYPSilAIqwGyzV.TwvmnUrAjqYZ6kqN9fWqSk6JI50cxZXu9MbsObbWQbNl
 RqHY0vYvJATSy_PZs.KRqM41ZcnSscue6m5Byra7BPXrXV3kyrAel6glMzh.6U88ngQsRcCa6IRY
 tloo3jI1K6T6Omi2HsNbZf6R5yZRi6Ut4v.IvhnpGGYphab3Zbt2.s2baC7WzIiiemr9Kka7iGnE
 1faaWL9bR5_6xxd6GRfIlKIfMjLlIyplmSq0RejPx7RJl4xAoqQiNmWFvb573CUa6F.T5CeI2l9u
 oyhewFIZ7Z2Bue33L3F4T9352tXOM5xNQC3Bgj6RnXNjLNHhTMGsK20RHIKreLuMnqGyGfOKq8Xz
 5iA5Wk02ZCmp9G5Kk9X8yLUYoThIODFkNC3Ky1hq9ZL6hNEb.lvv4tTEcNnC1Fy6FoTFFgHezUH3
 I2RrzekaIcx4GIp1fTIENejW4BimF2u_LKocNfBJeWWDyhNzDfOs8tgc11JfZ
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 15:05:06 +0000
Received: by smtp425.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8035a072f5ee31803d67cfe7edfa7010;
          Tue, 09 Mar 2021 15:05:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v25 20/25] LSM: Verify LSM display sanity in binder
Date:   Tue,  9 Mar 2021 06:42:38 -0800
Message-Id: <20210309144243.12519-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
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
index b88f916e0698..5d3dad5f800f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -834,9 +834,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
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

