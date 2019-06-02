Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95497C28CC6
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B02A2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pfpj2tyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfFBQxO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:14 -0400
Received: from sonic302-8.consmr.mail.bf2.yahoo.com ([74.6.135.47]:41754 "EHLO
        sonic302-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727005AbfFBQxN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494393; bh=XFEQORQN/Rrt9xNIMHTY8NF01S7CWObpcTiWCO3b0pw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=pfpj2tyqCN+H3ssbWxeMaCDj8a52WKmVo3z12xp3ES2WKF82xJ79Cwf3z2kgvDjTvvxcN2uwfs04oNLNQOWQ2WFaDocol6/5QkYDVOlcd6AUL81rmS2ucagXxYTIt+rJx7FIbuLITYGDIpK0fo5tfMju+Y45RM9+gDLFJ7LNS48BkT0dOPJUVILB+jac522iN0PqnydjlMzOcoaIvmPlCl3j59dUJWWSt6gH3stipP1YfkxC8w5bLJ2qfG2fQ9jaV9lUmwj7WU9N2Ft0dmECe+a1hHYMbu9vDXwWF8pm7T5sCPZ4fxdI5ZgI3Ff4O71nfxFvCo3FSdLuQwyH591z0A==
X-YMail-OSG: pF7O1e4VM1n9awcKFt0PD3XKR1ty60cP64ZsdOpNldjAxafV1w0E8XOxCyVj8hI
 j1nr67HDGJMImJSfEVrv054gfVKmRdyn5ElrahQKge68hHEH41FE5q7ZXT7dsrl_cxLyjuD6DIx1
 4lvNzrg.q6HInWC.qr8hvotyaLjjoLA1pAcGgFUXSUNMLJzjOX28ComfekwH5rqf748sMqU.R61o
 g5fQaokr8X5sBZhQ_aIX.6v81O3LD_G47J9DR7iN2qZzFG2yTKHgUc6YCaLei5KhGbUmXn9R5DM_
 aMt78pdjTqaVLvmA69CjpoQygBJ6e4zp7zbfWupW0PjF2ps1Wtn3BgsDSDm1LU_rrXc4io07p9jr
 723mmlKXbZfICEQkVOl0JG8gXZ32x1TUDEZVTC5Ki11aBt2o3X4GXmJPkXhlOFrUdo_pkQhexfei
 Bm6jQWLNjeig.G6TWYxMAgPvE2LBpllxGlP4I1Y2.PcJi3eVcF3qN2DaxK7kiLbWosrr9JzExCPL
 luPxJoGvtZj6X8JXWOvFgCwY3h7OxeF0P.k8lyLHjS6xD5OuryV_8Z3ldDX2xc0m5qrIL6O7h30s
 kxjSh0ajZNgHWuQh7rsdbYJzRa4CDeF6E56tqvENhqdHYBaaUbYlYtgzcKCDHsA1tOjqaPNYY6UE
 4eVZnDWu6N6OoyRxfAuu1Mv0aM77i7xHy.smK5u.oWyqmiS7oZ.tmrAfeTRGwAbGQxGa1HB_oCeV
 Kx7ac7amKUDbylFNv_p.ZFiqjhBQeD4Bm66vHgU9aXvrqndiqYFB2geoWPgkWGY4eKdczwm1wvFN
 H_YqhP8ybxoXWoafMkN4ZN.pmddxjcMKDExyoHkx1lNC2OzQnqR4c6ITp5WXtn6uzIRy7lFKUwug
 h4mixpGZY4ZIwx6QGPc3rTrkRjHtiab26QX.15JU2haM_sf55Sy_FUBu_sUdmEtRABNeSlBD9vBW
 PwT8HI_R2Ma5xpbmR8CZs33agqJAxQ.r0orc.CBFoeIdfqJQgTG57wnmWPSBTOAjFkzDQDhmi_5r
 Pn5yW3RMngOox5AJJlAN8nJVgWo4._DnU1h7o.lb1jzXKD6ZG_a0FujQ8C3Ca7DL946jDJ4gpL.z
 A59PZMlAaRItlHsb9MseezvpkQxAetfkLp.OWWmKGKHlePlXFepkvlpOxXK1eNaIIm0DVR2BXnN9
 ui3j7hUxx7AC83wo0uwJfGMXL37sZBNFamvkQBroGMkBRM2F2rSfr3vNJwoHabQbK1c2YoaI5wDj
 hTuY5lK5EhJI2uJzhZeZBPRjmHAW9gk_lzJNXVLFf0TsEmqa1K84uALtQ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:13 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 740888a1156cdff0756b5bee8a218310;
          Sun, 02 Jun 2019 16:53:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 33/58] Smack: Restore the release_secctx hook
Date:   Sun,  2 Jun 2019 09:50:36 -0700
Message-Id: <20190602165101.25079-34-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

