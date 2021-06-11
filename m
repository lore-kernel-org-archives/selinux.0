Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7874C48BD1
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8476861073
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhFKAeZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:34:25 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:42733
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhFKAeY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 20:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623371547; bh=r5+vPGElNosZcu2Wj41BSjkDKQjGL3hvS42vlbA9dA4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=PCfwjUY+IDdCJymlRKYG1fKbUXSaA/zMlO8/tDbzT4fxHpi6VI13wIarAmUNL2Ac6hSfLbRcdH99TRBmoHbC5kxbl2FSK85WJEaR01dYy+VZ+zSPTdE0DkZNcYmSX4nxb8n7MvyBQEOvBbqjwqeCM0mu2owFaUhWNllvdC4NyvC8GZIN+tr0CDc1fTqUc64B/q7ygI+Wf2W2cVAdoiTKkHO/4xM/eVxzXgK8Fc+RN88stsENyJQ6BylyCxbYkF2xFrioNdWLMFdsT191zPscpAeo/nQUmf5pobyZkE+BRKxl74Kt2il3os9NJBqaooE+pYBhxa0ZRVPIF/C3XpVgbA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623371547; bh=gUxEqZ/1gtQU3X/e5s0GM0Q4rAJE8kYs49/Y9RczkID=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bQcmKTV2l//uj4/5B+0StHI6m7sL1z97be9QJv/u8fzhin7rxA2/FhE+OI59fpH3T9GPrl65OYsNIdRyCiZdayQwoFdbSpkbmnYkm1mxyCIbR9lkMKTA334Sd+13i9kbKwg8qzXRnpyNJyUfLGxuA78LK62jyjDwWSqWby2w4ODA9JaNgfLApMx5VYFpJKmgwUK/FARn2URZ3rPKdCuRurjvmsn1z7Hcvuqoc/83/91HcCOe442hFlDgZKug9NzfPv/2f/DGvPntjsu9iy892Kg9bKhrww3RYdAzqzBLmqFSxuX3iyqukTkCuGRmfhuMfN5Ohg6GrnB+FwzIwb1szA==
X-YMail-OSG: e15eTF8VM1kiM41nhzlfDZj4tbTwInqz3_7WL6fM79zvIfHtPiScRkoxgBP4vhX
 _0WnaO8u7v17b5C0ucgZcGCR1bV3NuHu7hqY9q3W0fM7CbAT0kJpklWcXhue8ozqVAGXNply_dVI
 lmwnol64zbqYA23GV.1U2TBHlYqKA9LecAQGeOgJpQhx61fePMLl2oBw91.c9BjRDFK_0nCDyXzf
 .XytAnhTSDb90vY1GX3W_AyT7WJlNcW1iljuqz7YLCRUeHY06u_809vCnDmpOFJIieB84seYietN
 t8us4Cw08l6LjBWarobMoWOXw9bZ3L7dLTPO_9gbSMYRYPUlDxj_coTT4ekqacsAqym.oKtuiQWT
 5eMGDGJ1iB7x0j87taTcyjhJmfRngKq6YP87YyztP5nv2MmCXSnQ8YIZbAg7fJ9BXOBcTNg_3zL1
 xOjC8UU_.WyNevSvZ1q65vKFGn20ZIU.GDfilDL8UtJg7UaK1VxdTYbThjpHRQGiW6sSZh7HBv5.
 zi6SQZmnzM6c0j7Lp1skvw9M0JmJPnHw4nW8YWm3l_pRzcPz1zVKpm7L2oVeqt3dY8MQ.uphT97e
 Y7Hsf3BkpfJAvXOss4t0pnlYmV2VtzwN3Onql.2V44OEi0_3Wt8EBPcCzg5n5LE5b5_q80AAsW7v
 SQsgELeLF9nbDWSE5cGVXYt69Ay4KShMBuAnyYuxZVCahbq173R.wQJiR2AKm3wcInFpBmNXSQh7
 7iQgmE9hefx3f_yJi3IuygmvWJ21Hdo_ZoVXsV0LV4EQtVpZLrO.FC7kmUm6fRqNguEcUzK4wnDd
 jc3.SRk83LqM6edbGeHroyh1QZJRFl_bfqgp15jRE0LM_vO.CmqrnJ_CzIhYCh_EbrwdraBDaBoJ
 fOaOqwn7jwzn8JjlLOQ0u1Y3WtaQLzv3FCFA4Z_uSOfeEdDStz1GgBeTKbj4Ej3hVvDVZwBzEnN5
 CDdL8AqCH2jinPLdpcYTxZkIgtt03oK1r8ZUJu4O..AsdyJIHsE2nyVwGdXkN9ABVWwYGi_rpIQa
 H3HIhSv.ZgpFuMtRPBenXWv8pCH.Bht3Q1rZhc6OxARq0AUZmpixMOW7zwfnOYCcETCoHOgTmD2t
 VDsfT.wJLijZ2Rtx2qRQxXmq.y9lxoBnvRwOXqBv1GRA.X_dT2g2S8iK7vu41Id44DIao_kg6iF7
 _lDGrv_bZdTlemOG8nW1jiN.fgaLnCBSmVIPlUywEbgYjQ.aCpDPMyJYWYkz2AfSEtuOrTbGP7y6
 X_6WI.o1JaXAk6A3c7eZtaylDD7QeC_1awhUo9qmwU1gEqTA9JfIjANLpR1.KWsQdm.ZGgTR6oHb
 DUNgM3KfwpWZvfKR0PiJ6pVvk69mTEfLvUOK6YuVcyT4jhMBEF9TQtSY7qX6sQGIFOGcTgmNpZDK
 UI2HwEj555.Ghoh9a32eFyfXz7PbLlpC2iSoZsYmT1zahMI1nH8oiI2pUmOcbcoGakIf_hrXuwGj
 Y7.BZnBWnZUbUS1oy_OHSKMo0RrKioJIA8HcWecdpm6Pn0RwITOVO_jPfh5irX3ba4pXUp6WY1GL
 KfgI_DsPURVT2tSOYma_RGewdxhl5xYDcy0fNodA4ZSUUJZowU1FOOgK_HVLTeF1uF.ENgEAkcYS
 bKtzxvkDLJu8eodK3qvxlBRKKieFI8x69PwA.8VRflosanYnYiet5V4NSYbZp9mIiWTs4aDTJcbj
 Dl6cZ4MFIZEFsjHC_mX2HAqsjUi5xUIPdpvobGbURB3qYViBXh8mjzJtBf0PLRK.fudKsktsbkOR
 cJcR3ZHCas45rvNuxVFUGeQP893J.ASwU3T04iFnG06sg4cdBKHUEWcbtkJFO8uq6aZ.zIW8d_Uj
 VvfzfXgspVqXfWNYm6QbVxFmGKT3l2FGKnBZ0H1IO18HTDJ8i2St5p7meYvkdBwJs8wqRYf9a9bS
 lGRkGofVgz2Ntl0k18NsC0NxL1tsxdw9rMGsH1848Wa7l_PCMmYnFUALP4tpwd3lEHlufWoeB1Oi
 YoyOeuQrcV20o3U.luIRB_GkoC1nb9zSNwom9ceXxucQ3H6lNZGQbQy_lEKv4l76b_KGmLdq6Yet
 AJlL7ibt_1.SEPc495_SenISx79JXGVuXUYDuRMEhEoWlI5yBVMaQHcsurc9lp8nlsv5z5ZA2vB7
 NBC4.3d3meNXEe9RiU9PIpmALqlbJVKGzcTBg1vUk_ycF10BCHEe7b8aS_mLF7Ag.Wue8vPR2FTk
 8hDqPvGi4erLRpRGQM_Hh5MB4MGyPUpjnEOmY062WDZDXqghS.zWCisboEHZ73d08V70H7bMhhRO
 rz4_0yfZxJTYtApYcbnX6nJlKsSb_OcTajFEPDz5jaDwsOnVxiFpSbvrbmLdvp4awgl2CvQKsUGa
 nb5Eb9W.khk6WY3ZIv6bo7TUsIa_VXZ78xZkgp7wWw2ecvmaDSuv3i_hKWIDjseWoI59sXksfm98
 ZVO32kAb5c172BWCvDGRFRkVmCc2yVr2Qvb4dQ83_PFoz0Qr.0faFhNdgOZsA1he_h4FD9o.Am5C
 sAAdIYSiuXq.oi48nXNHSA0SiHM2d6xjMcAZHozoUTIBZmroiQ4HN_rTUD3yrcXlg9DsPk0zobWO
 r1IUNz_QV5r6j..tJEpKn534UkNa0jOwOv3RFjx7naQ4pM0PDNhVbLkFucySNcbQKq5M4Q03WVHG
 ela0zC_ucQQAtK3VVFV8V_hDKomogjJlwLnOc3qqYtvUNIyphfDSj8xOpkx_uCiCbw46cw8mocoF
 05PLnVrNtpvoGsowgcrxmEbagiLh5FNNAhru5xtAdh8mfScyebGugs4XK6QElfxMUnkgXOiV2kLO
 8NEqbs_NyfhxTJGF3euwZZjiaqr2cnOnSAU0BORo3IPot76hr8SJ.qdE_Y5HR5YxxRYLeCKrFIs_
 gfrrB53CwPY0iqLFFSVUjN1BJAh2R8EJYAmb.ERFPStmTTDIM49egM4_73o5CPDpJycm8j9F3nxZ
 n6AnzF.ziYzoUFyvYTsPH.NarXhYAHnhIxNsDTsK8nFhwDUMCKXgXNwIfFo92ZSDzMU.IJHLwu77
 aYhVz.zpgM5buYISfqFAg2qsKNiBrzJ_5JC0vjvEPz92lg27MNT0-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:32:27 +0000
Received: by kubenode511.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7f010b3ca93a8cf4ccbaab7ca7bd7cbb;
          Fri, 11 Jun 2021 00:32:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v27 25/25] AppArmor: Remove the exclusive flag
Date:   Thu, 10 Jun 2021 17:04:35 -0700
Message-Id: <20210611000435.36398-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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

