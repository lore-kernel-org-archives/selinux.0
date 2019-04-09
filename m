Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4AFC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891B320820
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="t/1htg9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDITTe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:34 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:42053
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbfDITTT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837558; bh=XFEQORQN/Rrt9xNIMHTY8NF01S7CWObpcTiWCO3b0pw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=t/1htg9GjqaGxX3LifEoFua35/jrnOvNpCUwPr2dgtIsVEcZ4Km+AWNAx+LEivJhbqGwxr0JjbIvUemY0mADYzkr7WJHynyQAfZuPxsRIm6RxuWKU53zisj0M62Hlryxn8WU3T61979lHeoZpdLyBbloF/vg8za3vtmkxcctbLrr9DhrkDhKXvVWVMd6w1UdG3Mh6vS8XZa7s9Kzjuuy/lucqSqixDEHTAu3xb4OjlyosdWLAeS7kjMTMC5PUG4L/jmTd+ty6bNtPCELF9NbRXlY54dI4X5eQ7OoXKR1/pHtC8BKu4X9sFvR80x7PxZEujSa+dok89ww7QoM22ysiA==
X-YMail-OSG: mfsvLo8VM1mNwsefW588PagtZWrbxeDRrFx_BKKyAROm4IGBOqA7OVngJxQi2qE
 mGRcrD4LluNvvGi7ncwnXGcJyanAaCnnSTlEuw3dfWodPF611mYUxlSW0n_qnRmtERx9RNoh7OE.
 R9.OTlDBoVcdptnejGSlYHDPUmnsriqNc8qZsBC4lFQnsgepyhfIr_jezRcMDppHKuOCEih6LwD9
 ERhFGQtAz7_NodT3Kkg55O.47Fgb0Ou4AeyEs369akV0PQgJJ_ibnXom0rZtsqJkcQ068lK5Hfv1
 x2Jp2bXi.cpXQ_62EuDPcWIUQ3S5vwnZkM6M7Jp.dGyTUMdnd.3LAAQbDK90aMtGiTlt1PFjLwWS
 O4o.9efhxpVn.v92c4wKN0TiDuxMv4t9HB_BiXnzEDnRc5Q7G86UDNkgiooR4PltBFDdg7PYxMHP
 j2_X_VjCPxHSxFrbUlTa37afGtG6cAWazCEcinf0Syah_XbbG9aCm2Cumx3eoY9OZqCouSibEsC7
 delJzLlU2RYCjYZ40z5E2f0_gIMl5r.5_ByxwmPTAfcQysNN1fzOUbFLrQUvmF9tavV.x8ATJgtA
 pxkQE08JiCvlZLdXkxnsQILng5XJmsNYB4R_CHK.hgxBrWCDYGTEomIIi952IuyW0r6nxDDRsN6R
 HfeL8IRARs7qD8o3TezhKZLgJMCtGvSkZsink9dF2CtdRlaQYrpTBiQVzau6G7N9yXsbKlVwKdR_
 JT9DlQkdHebFkbzKliRb76KGpYcGxYv0kow2DUwz88k1l2mSfdlNzRwj7dkl8vcyVrPVxBFJDimw
 LkX5YdHI_RJx9wxPF77RR8l6Bk3bCFE0cOslzhToGR2jwtF08DlY4mlQj.paTJ0qoqI36k_R3Q6O
 apuhDq3NzAr3lmHGxTaEFZUN06KNGcyUOrkk4zAOekZ0qkHcdSNLcqDEpW4L_qNj.8Bfssoq57Sl
 KoQKl_KENjdGSCXJHFiEQOTYr55y5nhWDpsm3JSVOo944fQ6PUjKtVId4dJ0oVuQLw6S7MHM03n5
 80HqlZZIrLS7qDTO.UdNK0NP3VMHZ7hxIQsMwaOnOKAmebwk9YFC8S2knHFCzQQ0PHePAP5.PCo0
 mUz9Uc_uP8g6eLw8mM72zdnw1D_3IFmQR74xswJhAuvCuMyeM4D.rKWg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 564a224fa9abd9f41816cac9472f1914;
          Tue, 09 Apr 2019 19:19:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 34/59] Smack: Restore the release_secctx hook
Date:   Tue,  9 Apr 2019 12:18:23 -0700
Message-Id: <20190409191848.1380-35-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The secid_to_secctx() hook has to be balanced with a release_secctx
hook for stacking. This hook does nothing.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 38ea48d22547..a837af153ed9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4470,10 +4470,11 @@ static int smack_secctx_to_secid(const char *secdata, u32 seclen,
 }
 
 /*
- * There used to be a smack_release_secctx hook
- * that did nothing back when hooks were in a vector.
- * Now that there's a list such a hook adds cost.
+ * There smack_release_secctx hook does nothing
  */
+static void smack_release_secctx(char *secdata, u32 seclen)
+{
+}
 
 static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
@@ -4713,6 +4714,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
+	LSM_HOOK_INIT(release_secctx, smack_release_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
 	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),
-- 
2.19.1

