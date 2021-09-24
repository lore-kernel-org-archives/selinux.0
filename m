Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05189C433F5
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFBE60F24
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348136AbhIXS11 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:27:27 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:34270
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346538AbhIXS10 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 14:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507953; bh=Nz3wsgxhhtxDXcfxqmeMu7QcdC6RUl6KPkW6ItWrbws=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fLKzPxIuuYT04w0eHXgzeeuBU5sJqOuEoAdON0G3x4AnhJFhvR4NyomghTnETYDhcyI7Dklpa7DLSfnpWT8oEt6hI6ammO/4rg8LAy577IY5MEniXHReEQajUMMXM2WIPJsrJPQ9zbo9a9zkaEHIQAa9oSKQetS9K+F9VytBHr9qml7LfzOZuyawJU4N6MGR7CM0jQgM3XMsRaSzlpwM+KXJdBtPRdnHAi3MU9LZ6sWmMVcU0FqzahOIbuxVUeFBcrI9mF5Xes1syLOxosJTNafPEHKnYpuOvgmFjFPPu44o68yJ5F2ggcyjzDupnJREKRlQh3imKwq6RwfJFOv0xQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507953; bh=kih1ySoltZnQb4ThilzzaB7gNc9uQxoYSEPtgjSlhMp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=H5CiVMRrpavM1aluAZyEEuaql//eoFkqC+q0Cpkt3Lj+SwSFqjGfuRdqwf/vzHutO29NNJ+26t7kQPQg0lIEkQkDi2u4q0iVSfPvaACiXHNG1vaoYnslPXQ38Sh/AViXrq76v0DaDBPJcLb9PM9V37ChgWrbdpViXt8twSJnKpCUviYeUstpKxcrvF70BnTV5Vy+48Cm5lEz6/akwVRY067Cswq1uNqlb8JvoWbO5bsfdhvmXaai61V+gS162WMRLXeBWTidZzff8UszdnOaJW7/j1iVk7CnKQlnDhZWyig+NbfXVw6Adv+dZ3tc4cZ4R+0Z/JweOrO2GvP7lVDXOQ==
X-YMail-OSG: 8h3pjeEVM1k2s3NQ7s63V1ou1T7.6v6x.F94.xNfpz4WxQGZn4vK5qwaHPxrpT.
 WV9NIifwlL5DQA5woLlC4zEL4o90yxJKNcqPMwaF1W2c7OJarJun0QYu6l_CDbgLgWAke1AzWjPI
 EgdDajcZBCP91vI_jyKYige9Ae5ZnUX1WbODiCvP5R03CbeKAYzW_bMq4nhkq8iVufprjPsV5tbx
 wKrfU5WCJEyyDfq_jgUD845ZRWN3gsF.P9QQYLY5tkabtjRn1yWQ.7vr2UtmQmxeDZWdlOw0PEN0
 RoaLyiPhZNZmnz9UibqcdXAGbAfsAn5myzSTyeSs.s92Dj4c84HQWhyiSQc.ZcZZH7zODRx7inAJ
 P8TVROhOP4QILdJF7DFufNXpTRFy2JUFovYjG_Hk5S.NMAPH1EdQV8WrlBFvtFFfYBaUaBLsqjKk
 yxyS1m5IqAuDwVvNDP8a2XXEYgRHQRmaXEo4lihpRJGJRiMce_Rba_.tZYJTMkVCqQwtPPwY7.GA
 moowpyVZ94NMDwiQI3ocYyHc9kAG9IsYTqbQ7dRazkXiTvnj0W_Pu44f_.W6R1FI3VZOH1nXnx7R
 IFVqBmco0O422IwdE3jPxhKtrAA2aSXOzjZQC4YoGCUkUCalKQYcTayTetMgptnnbh_omaChFvJN
 Sdb4qjdQqTNnHWYDGnZN.K2_qaHom2vl5ysJiiOPkS8aUOPSHhwOIK2wtNmMDtoEf1MiYNINTym8
 6C5O7FEd8oadcl0escxvFIGhrEiiqjYBIvclf8J2hdBaeCfBdHdMCpVFGAGQOYrSlj3PVYZe85cr
 IIGapj_I535KjUQj5Zs.sKICsoJPMgrlXlfs1xiLVtcT6KXBuVcVo6fRIcGgtQwW_hoA2HflO2PK
 UgP8h462dOniNBdAAtBu3hmXvB_whDbx88EFQ2zXbxns8MG2hb9pxsCr94m03.UOe0tl5QMguw51
 4bY8KcdN1AqKNVdK3ojkskW2GaGSbomqc9VLmQicOmSJl7_MdA7Ojr_1r63EtqvyTfh1tzye2Fe8
 UVN6rYsvdCR71WIYBa5YgEQjU4GMHsjbJ2zg6zzX_YuAuDGK5iaFT0uFB5xxsRvxnvqHb0Ea0CXd
 Lfx4BP6P7KhzcdEp3H8fDAstCbypMymMYxPrPqgx8HTSyDf89nNtWwxQzWf4jEUAGHjZjHqTuCto
 fCqSVW9RjH2.2hZFD_upLirjzheZhXKntGo1IRpnFTrw3KbU9QTdjC.OXoay7OZqv9DE5ANzLebx
 DA35lqKrs6s4ZuGq3sRUI3m.hZqnMZ4H4nl55_GXRT42t2lOizJkzWmsRUSdTywonCs3hTAajo2B
 lVmF5rDpm7XrA7aauuPP7zQxaM7scy6alZ.bvlID57wgOiNCX3419hC0nx.x7_.1.QxD32Z5CSW4
 3cmGp.BCzh2pDIHe5.QYdg9MrxbiG2V_hefwjIHYgFbkH2YLCI1xKG_e8J966F1vlIW5YHg7cT4t
 9dX.mJDNlwuN9i.0ODNnmwGNaSU8_fB.Katr39RtXlkH857.pSd7_PogIzZPSL6bMcw1Mx50ySMM
 IX2EcQ8gAiSXvv75RgAghSlRPkTj9tq0Q2yYz91pKlLlbPqOGqPCRFis5E0ay79z0lgfUq0duK95
 HKWf5tgdrS5WmuQipMV3BPA55wpYU7fJ8RPYLLgh..saDv2_46.tmjdQHWQh2dbNFKQr8fW.95mg
 HhjDsBvUtZTpY5UnFDRzTGlZzr0ydIMwPAYCm.CK6LMImvWIkfopAbb8Na17cMGxgeyncCHu7gL1
 NTBa95RXbjIXZw_aMrTqtP99EFRscKuKN2gY63SwSrYptEEE3bt2pLaJad4XORID7xUKzQQr52ie
 26cpwWixFnx7CPzwPQnG1mhwlcRfDyM0I8J9cjcS1q6ttzDy0CIbVfGaNZZ_79tjGK7YAZ64dUOl
 En02WCvmq0jBS991lnDRywqDUhtZSJuc.6sldo2AhUkRRE6jVJUqva.OptC1PcicUBseQvbW6_r2
 plpewOE_ZKm.xImD7EY00O4XUutCoYxdXFYC9FWFziDbfx0tX2na.Twjf9_1KnxXfDiHoCRRTXC3
 KxG.2gpaMUJ0tVgi.I6NW1snAJP4vkvSUsy6MEdxzr4SpZZ6w6RniPSpIfwozdMo7Ugz0C4Mv.GU
 cIa4NzpYLvIhQFZcqla8f8RUEkR.sROogz3pPsNIawXdRNJFTkU7EKpZzyspkqyemgqLJgtLVzAm
 IhhxhEElw5f73VuWjZllRJoe4fTAfoHvsXnygUyuqc8JF_5jSiJ9PZcrAkm9QUfbC3BoZHHxUIo4
 Sfg0pD4W2IoYDRlX5vATQvdfYfikN8FNHW_e.ekT0UHSL1LNb2ZCM4GaDWaUfIzs6Y6zGh_5dBjh
 4xBAYM3CmKJo-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:25:53 +0000
Received: by kubenode537.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5d70ca904e6a12349fcb9a9773299445;
          Fri, 24 Sep 2021 18:25:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v29 28/28] AppArmor: Remove the exclusive flag
Date:   Fri, 24 Sep 2021 10:54:41 -0700
Message-Id: <20210924175441.7943-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
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
2.31.1

