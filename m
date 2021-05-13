Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60C6C433ED
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B567B611BF
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhEMUhH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 16:37:07 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:36542
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232957AbhEMUhH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 16:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620938157; bh=r5+vPGElNosZcu2Wj41BSjkDKQjGL3hvS42vlbA9dA4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WTPkNoqeHGcgn3Brgav/A97e7YWtKoxNJ6tgmLJGGnyLh3KoISd3V4zi/wwcO4Ab6/Hf7oiwK8Kuc+e9Mt+/L63rcKsnObLuLWFpbfIJ0jTC+ZEVqgiWSzYEw0u0XlCsBfUH72SkMgLzk+I0yoZ+L6iXiX6mH65q0F7GOoAhn63LRwXsMGD2OzESoP70mAhPmtzdLEC3JmQsoa+TlztcJ2GOCfIdOqIHxJmm8aIGCp8W3u+xeoz2xh8Bi1mWWoHZ44I/sZUgfn78z+7KvTvd2BaiJXXE32f3HlsmB8zpE44kbsA8ocT8nYZWQIFXqyWcnA+miV3Rkkq/gkyuNqhlVg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620938157; bh=rmGTEneUopIyDsPIvHKa8z2R2pWr8setArob4+5hoBp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=eo07+xaO0rExrLLUBdQicVWQEQDdxKuBgJ6Z9pFMtsXISC0glL2pFhs+QSz+AusGsoOFyXiulJywjbY6uPq5/HnG9W32xdO6ZiPvfyIH9GTa2NdQVSVtDlfmbhkZJE9ne57y+8D+xJydR55mJtYrBoBy952z01d8Ipf/YBkZt8TnkSvzcbd6YBgF0SHIpS8OcwcpKok/wF4P4W6A2/47M83ThT8iFIdOsYAPaxrDganY9NK985aQo5S6BValySzHeOcWxmJJ5eTgcQOsacm5nLjAtNfGZsZur0LB6qdVEl5d4FRjdgAcSCNyRI11AdOQbU6xsEW8qVLPNyCDG+T0PQ==
X-YMail-OSG: gnJjLPsVM1mzdmNomaw5Hs2mbX96jw3uChFTVZYhVp.QCTOtKK.h_FJlQxBbEIz
 qlJyZBwN5hp_cImGuHymhf7d8OLa1hqIFBlc8nKX7BVaGIjvNe6P8xJOW4v23QyKdkxEn_fEv8.m
 YCCWkKjbyAZXaHK3iqshftfzWTY4.vYR0gjK_DTtTgbcnwLsLjKB7xW3Ny7_SKw649Q3rLr9TZyL
 nhxfEos58V7raWmOF7o0r7dWwaO0mWL55J.bWaVMjK.Viy3PgWR7PnLzLEAwH1fhZ4dAYImrXw04
 HQs3r12sn6g1Q4S5J1HhC85JII5c7siqyrEz_AADtPF33Rc5eRkq.Jgpq59VDT3GvaajQ0gaUQW4
 8uRjAvy3cNWMVOgYP.n9ptyCazBMR5NdtqVgSfCnoJvyVRBsZMogSSvTE7u4LvHP44uGtjMw4Fm2
 6whASp8K3XFmafkHkPFsj7ET.jC_sxXCePoY2pnZQvg4xqPSz2itWYcMtUt77vccFowCpqqxODia
 9cf6xEpi8CPOJweuiGJnzUScpxFCdfj0XCiXLuYHbgNjleRr8yuu7SXwyeY0t.VbpCK9JjFKMYKT
 4SiwmhKpiIA7P0ohgdAnlZp8Y9K4pUzh90S3ayimdS8xYSsOncyzYpgPX0beFbhovU22DlC4j1MJ
 JnFP2RusET2MrTPR6kk7kmh2xqBdYnHVSFxTY9M5EBdthuhds0ECKdkJqhKlFK9Zq_xdHRSOQPYL
 1SAp5RMs1XE3HIQX3K6A.Jd2eMZwAHu9ccIk3dqB704_U09U7w4lyYjAtwQGTI0WKML7xnh6Yo5Z
 CDHnAJELcn6bdB.TXkhhKLSSBxLfIl_L484ZN9qEUR1ZJxJWxNMSlut4k3fS2.87DaEmBNzxnxJU
 4GsJUgG.cYk1SwyyrBPRGwZZpwFUBc5R1S3s3Gz.RQtY4EgmOH90QR1QrtkCZuGmntYih1_G6nV2
 vBLVqmrXw7mn_1nnJOw0erdIM_zO1hMCe8ZbtHErv.6EY2Hd6NQArjzu9enOiOE7dnTUu8R9p0kJ
 vvn35Fjv9VdFQcpXYFlLBdnnw66kw__t39onX1x9AOT44p_VSkxXtbHH6LKJFhuQ0o.b2VS8EAx7
 dl45KK9oM3JjNrvfDsHHhcVfAjXRCAwmJT6zdMrq4URjJXYymSh226LK3rj9P_P37nF0uGerWh5b
 rohQSAcxg49mA_FxxCjQybziOVqVY2PvgDe_CX0l5j.ff9PSiNV3YtgHb4BsZh_E6xgyuw8mxbME
 YP2K6QDteP4wDYNx_WJ4pFZJkS_NrHGdhgZsnU7_fAtkZKuYf8hvLQTIMlTULT5O0mh2GEPdbRcN
 1vr7YiArP2pA1gg7b_dD6EjKaqj2YS14NqnxyF5N7TvpaAHKiDK7pS0dIZXDtOYoRko1Bi2EigsF
 nKVEsMBC152E_o4z06h6KgGiIqkGrY_UsXSy0PTrM.ojM5MACMjwFVUiAHiuCSzEGx0..U0cvYwT
 tNFoZO4FjSG1QszQlauJ53I4d65L_iy2kE7asuxqlH0JfpkxYevE9oGjoPI_IZD2N4AHhwUx9oJu
 KgZTLz_R9WK4hQ8bhv3WVkjfwKzIbTsfGw3m1H7Mf.HKleMR7j9XxFq5nBMX9h9EjESRPylc68Pt
 OKeP8b3.uJpKlhnJQeJHxjyZCtXI73WYGRrDEWbjXAdIPrwjwx7Zi1sHUi.P0yYZDb85NXfEpZkI
 TJsemluvMREqwLh_8q9jHRqMS6a.5LCkQVJlNokyXL9c3V0TXtV1OlB6q6V4we4nDF9AVFyr6iUa
 1_gv5aOSCceWqCdrgCdztIkCy71EALuVbVVzIRFR5dFWZ4iQ5N0cBcnG.79v2gn_OPdpb00zFsZj
 DOrQCnv6plSyzSDFOhIL2zSPRFfxtTVUwWmBovGRN1DoE2VUOpnUdBldNXuTCuj.Em7jR1D2ACZA
 UjdTGtvhe3PEnvZ6U1sssgguDWM5UMU6N7JbofAxQthU7Cba914yGWwR8sOPCMF.Co5e.31vFUap
 TJmjhKuus2Y5x2OsIX2wXckGuaf_MLDlXFn7xd2TwGbpl3Tj2N7zMMmxEd5Zx26ZdqPhvUeb6Xqr
 hiezlD6925pVtKtrqDhv.o7Y.C5kCiSfRi2ISws4kKx9ZJ6G.SU1qx7Htr4SuQt.Ox2hf4r3BgUA
 i4Zf6NnrK4BNKQYKXtrO6ToZ9itwv4gE0cVgeuHgvjrywofybaphW2BJImnsRN_nYn0HTIVgv_mt
 owrFmb7cK.pXEL2kayou_QuJ6lHlq_14W3NAVpyfguXZWqxsF4j7EP38CtmHTq2ePt2F4rv5Gs2j
 889aNFHjbtQ6CAN5BbyaPmjuQ_q4LWwYgDzFmDitHwzDE_RE5gtNvblI_0AH5vQYUvqclqGFYwC_
 _KhIev2tgbsE2n0YFimpb4DE6Q1UZJz7J8b8jEcRWcgD.lv5IqctMOi7BrjbM_._qNOBhDSd4tXg
 1IfBZv7QIEdBqbD7IzbveAGV9EixbKJFjMCqAz6udURfqicbhzyMMvWO8b39ZeRSLvtmYDQtiiOh
 dY6RE4COtR5c7MWgMo2QvM5HbqfhAzzxqGiK5GUJDeNdTM9dFNvuU1qEqMfaXhHbrOkm23AsoXk7
 keNasqcqVFRSiy_FjNR9VYGn8eOhBVE4Wgy8BlKBUda_Hz63ZRDAo9K0fUmu89YJGcqhU90Mtvn6
 5RrrJHyR1UUKHISYuCzE69x7WNLgVdqepF_SfJ_vcxzwJRQkeUITmSflC.HWGJ7P7PEsW4q2lqKz
 7xG5nNobMaCh6IMHLY9bPI3zT.0py3iwBmoR98DcPD5.mDRiyir0NaRdyGsP_h3TUDoZumtJYnN9
 WXMZB5XKVDasu3fXH3Gc2Km6mddQiv0_IV4XvMhXydFWJlnkMh4My.5Fb9VB3LOZSV1TsqGgC2Jp
 AkGi77XxT2JDSLIE9qipSjpNZ9NX0d6AYkfoCt8YR4WiUcuX0W_097Q9jeZR2abaZFS0cuZBLAo6
 V4B4qlog0PQGGxnk1Ff_GPR4Z7tirm8GEfEiqaA4QAdO.FexyPIdrgy5TXZeoAqx6z2J9aWaP.fT
 2.i_mpSiOaFuGiXgnWEpFIp2z5z1rlCb.2JG_pK1szNliS.Ue9Hl9Eu2ipJChJxFerppbTg3M8lt
 5L6LgRmH_WTA0CCwoOLLE.cKgXM1O
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:35:57 +0000
Received: by kubenode502.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 82ee62b5c0a8268c1df3e319376022b6;
          Thu, 13 May 2021 20:35:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v26 25/25] AppArmor: Remove the exclusive flag
Date:   Thu, 13 May 2021 13:08:07 -0700
Message-Id: <20210513200807.15910-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the inclusion of the interface LSM process attribute
mechanism AppArmor no longer needs to be treated as an
"exclusive" security module. Remove the flag that indicates
it is exclusive. Remove the stub getpeersec_dgram AppArmor
hook as it has no effect in the single LSM case and
interferes in the multiple LSM case.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 65a004597e53..15af5a5cb0c0 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1138,22 +1138,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
 	return error;
 }
 
-/**
- * apparmor_socket_getpeersec_dgram - get security label of packet
- * @sock: the peer socket
- * @skb: packet data
- * @secid: pointer to where to put the secid of the packet
- *
- * Sets the netlabel socket state on sk from parent
- */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb, u32 *secid)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
-
 /**
  * apparmor_sock_graft - Initialize newly created socket
  * @sk: child sock
@@ -1257,8 +1241,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1928,7 +1910,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.29.2

