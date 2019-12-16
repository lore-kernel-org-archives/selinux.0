Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00241C2D0BF
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E1C21835
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D/ILdUz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfLPWil (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:38:41 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:33594
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727884AbfLPWil (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535920; bh=DJkcoXBN6Len1rmT8hLxo+7iFFtGC2LMsJjtLAQzYm4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=D/ILdUz7vUWmQuHV+giwgWyk9kTN770b8wnTXN1Sd6XrTVsRxOAXiMsuQZyleCXALsijhpgsxjaUWFfAw+yCfinnyxELA0us2CFhHw3SBbQxEB07TKCjar0+oBEIPdBXtpGSSOR7TeaUotGCF7bxhZuK+YAUaa7Q/Rve8tHo5srhhjtEJ3/fYnsV80bLfc69GKM/on0nT5ut8J/zoJLaKjeRct7FPsfyN+2Tsl/MP4Dq2zXsmANe7dz/6y68Pk2qIPeKin/Jf5JdRC42xqaH8E6Kwtb3SAt/h1Qhjfcok/8816yKNjPxZAaH+Rjo4UsgpyASuNrRUWndEDaYSPX4Jg==
X-YMail-OSG: vWuD9K4VM1li6qNfNOUH413r5gpWmFvMyILFSoaTbTp0JQTyYyiPyZeU7PTYYog
 gZef0NkMetPx7QEya58qYIjejXyZzkokkdv8wbhERNJ5khf.8TnYturHYxOTXuiAsyZMQlK2ze1t
 H75DoclyKhJIsw4AhAwCqGInPUFIajQBoMqzBNTdFJadzyGeBe9IektlsiZvL51farskH4qODS.N
 Tv_TatDZ0IGbjKIk.efdGliJS2.CYHqxEEht0srvi47srjozfX5X9oxcuB6f_tcVdVSpt8bvr0Lf
 Ne0x.HzzqC.5juQ9YBthxTJBK.McVXvsoey.YlvCgoYv2lYG_o3r9yU1xpv_fCYSTpLZllDrjyQX
 d6_LKwibvP2bm2dlFyoOglNIYeF8CT41FiAr5X0kHoTrObP5COCPNfsevHUggjKAeFHZ1pSlIJ60
 QSH5PTN3CM4YzMkJG02oQ96kBilB1jIeR4HrkivbX.2jEr3QhUK7zTafzxaunb562DvZt80_HQg9
 zF2QeBMi7zqAeYX0UCuhx8MGWVurX8Nzwlm5EDCiWIGoSQkAmS1aloZJ8aDihAdrULeiO2.hCuHj
 E6XT0fWfWg9sBCNuF_9HC_OeKXDmYlcgLXbxiYui5TllxuGQQJPIQ7DHsNev1cd2VSVWZncCMAhl
 Cnp8BrGwHBGwAgCFhnPLDWcWpJAHR58KC6LVQzVGUZ0TnJKT6z8isrpxHnGoYnaYxkfGBvgZ.kzE
 ylaztmNePfeHLiMadrs2XlQGunubYI8nAfjJcTIl3b5QkVFVmP6tn4594EfdkAdKspp1kTqWItBn
 sRjS5B6YGR7JwmRhTZY762ZywY6tVs7ErTbAgw5CDcTWbmkofc5grb5rKm3RHC0MCLznrZ1sLGcs
 9HrLKo0TTHq3QaAiUtDdUj.lCC6Q2.4AsWkCRR1EYwnCPqzrmNF2pjmspkNEh_RjrWTclyJ3II0Y
 ZwQhcKgUkTlGcWMhrEEn8FafxUuV4V5cYSGHjWUadxKWN6tQ0Y7qpW7OnyxVjnPbzkWlNL7jc0He
 r4kV9lIEDbI2JQgZsfEfhLvcyXqA9xESJfSjhTQXNcya9olk76J23UwaFM9ePylEHS_KCIwaZJoq
 P6xLkQIB9ERw.I6K1GRyzREEI3nWyR8PSSCQ4gkpcy.9tVRH5qJFC6h52nBX2IQAa8AxSkkmOwrd
 adSM6HadlWS7GvxKRPJPt5UOq4kPguzcpLdVvXq2ZRtgSmMIRTXDbnOG6h8mRKZSofUBBTXBZZKw
 UZnu5DCL.8tqZmSsAx3m5YdgJ30MWO6AU.IgzAQZTtmohmbM84q0VvLplPwftnGuUgKXZyXgNZUe
 ZDLUDbxN.zwIuS.putvYa_BhlmjOC9dP18fSAnQo.fqTAEz4fLUPdj_Xt52F14GDMf0lFRm5rXlm
 qDWVVrJ_cSCP2OSPih.hacschHE6jadLjUhxAj5_HmVEZzpgpn_87ydxk5LuITszuwyjlQKbCEA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:38:40 +0000
Received: by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8674306002fb398816baaa76923d69da;
          Mon, 16 Dec 2019 22:38:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 25/25] AppArmor: Remove the exclusive flag
Date:   Mon, 16 Dec 2019 14:36:21 -0800
Message-Id: <20191216223621.5127-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223621.5127-1-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
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
index 34edfd29c32f..402a919190fd 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1112,22 +1112,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
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
@@ -1231,8 +1215,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1901,7 +1883,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.20.1

