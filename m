Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F20C33C8C
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8DC206EF
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Adnssr8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfKMSZ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:25:57 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:44600
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728592AbfKMSZy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 13:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573669553; bh=AnMCoo8whYMS9LxrvVzuREBP07j0k39Hd31LTpE/YIQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Adnssr8iK3YXDQYPDX6rC2otdc5XzFOeFCFzWy6h4ABBDTbW7XRper1ezXcsdA+KMPp34dlZw8vF8L2cEw1DWYyzuVB7PnGkynws+9nh5+smLrYgDR1YC+pF8bDVMDQiUq7NE6HMRGF6hRk7tLeyyKTmvCzuGLS3duHSIHNau39qPD4GK8jmkMNcBD/wcou8LmthKW8+RmaLYBLt6IpjHd20quU2h2nBrSWxIcD4St1C+I4fgcnulHScHwjIsPam3GhpvBeGccLsXhoyrxUpQKA9B1x1eibPr14fyl7O/uSPOSesy/zhV2sL2w5c8yiQ1OzAZLKsdJA4fQwUoLkdpA==
X-YMail-OSG: 53uCqrwVM1mhMcS06j6g2oiTL8JMdtt5jo_LmBeCRdmWyEMJPkudko88zpmSgzT
 9WPCKQFT3.mpuWWaMu.IDhDy0cSvBL4wEhujY.hx4bvPNuUJxBUA81dDuVPToBkTTR1LsWpc4ucQ
 9olv1OCHCWZrts63Z34vMUtLGqb4j8eiu74FpIG32heGzyYJs0K5RITCby6e7QJ2P.nz2oC3Zv_f
 _OkrQ.AhS4YyqTKSMPn048jsraleOkrzzcwS7Qp1HAvK2wIudquTq.PXWt8bpnakqKM8WHW4XqW.
 W60QkMZ3G5N_aHFtjd70tOIYd3ihymjcC2Ma9SNDwOUo120UUz6vqEh75TeUBC1Ltn1UlzKOI.WA
 iuDgshM_4qAPh52cRVwDeHLtepkDs89eD3ZfXsmVaG7HL7Zn_MZlh1SW.y0H35IgsQvnxEoT8F5a
 lWIA.uFDOvhRoGcBUmkRDJE7ssOeNUnvUMj7FeI.zCjEk7noNVIistxF0oO9boE3uHTNL6oV7ptR
 8u5hlO95wA3.ueu.cu8rRw9IaBIe6sHfcfvxnWphqaFs1Sd97wuNPFwPuHgNFFl1VtSMkVAKhvJh
 WahFhuJWY9TjBj4qF9qxgpr1AHV0OJbj8apLoCKky1c30oz6zzJ.GjFZi4u_y6Veu4JosUwTghzJ
 B7H1__AdkvDL_CjJyRtP1welsO4EF4ca00H.2nQSZd7uiRx6EgOXQ662WkDVClFQqxmM.YhuaLgB
 iNdcFPY06Pe.w_IJexjZNFXxr6nzbjPPKtnPaU_pJiocBuB84RoeH3y7h6AGaBuQhfqBgNBmL.kU
 c4ec.9L9LGZlqK9Thsv_N_CVO_J6xqVNt7bw45KKbnO15wT8IPp5akU9F_mor5Lln0JAOC6dlesk
 aPVCP3X1AMUzoj0T0Rb7uUoLTkgOynFbC2r9SpqONFa.u_a_o2DccUnlfKr74hTNaeu4oEG8Ac8s
 HhyOl86Tkbb_hxOq__wz7fYS9Ke8LO0KHW9Njr3Rjp_Jx1XNZSlWA60qS3ldShI7KjsCmjg6ASge
 Kx8jcuGTjn7Rrgu2vhsOjZbxS00gocIDSQQ4TksJ8u9PcAYal.HWrGTgfh_pZqGlPG3rBiXgkKQn
 jRXRiw4vmZ5E6Et6jmcTRMrARgtXfXtSW1Ii8g414pJsOSupOxgdu0Kb16UU36uTsl.yunuw6NXP
 emLXoV2sQC1EZ0jDTTvFWYEiRCTP7fXrSZgQhGTjAh0vQMtegBYgYKEDFumINdybWbEDKMs2XnaI
 U8t_Oj6viIcWiWgWC51CKwTIot739fLV2o3Sr0Kf8zw9m78FzTXoPJxxfp4NHmvm4oCOC1btCBX4
 6m7NloYLpoqBgkbQVlHSw92y6DvLRRTzpIQOCwAclE44p2lEYfn.8roewdCXF1_bzRFhwWXbjigN
 Ag5DqNadqYMlRSZLLBk1k_jxhiO0K3_Zl6zOgHKxnx39Q9AKqpOgWrMjuprdul.jMfGRR0eLWvg-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 18:25:53 +0000
Received: by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 12d4900c069877a28331491f4321a926;
          Wed, 13 Nov 2019 18:25:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v11 25/25] AppArmor: Remove the exclusive flag
Date:   Wed, 13 Nov 2019 10:25:06 -0800
Message-Id: <20191113182506.2580-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113182506.2580-1-casey@schaufler-ca.com>
References: <20191113182506.2580-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the inclusion of the "display" process attribute
mechanism AppArmor no longer needs to be treated as an
"exclusive" security module. Remove the flag that indicates
it is exclusive. Remove the stub getpeersec_dgram AppArmor
hook as it has no effect in the single LSM case and
interferes in the multiple LSM case.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b4c964fdc2f9..81bc4f773429 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1099,22 +1099,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
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
@@ -1218,8 +1202,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1777,7 +1759,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.20.1

