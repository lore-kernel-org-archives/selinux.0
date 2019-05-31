Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB458C28CC3
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF3E26FED
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VSdw5JFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfEaXTN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:19:13 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:36262 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726842AbfEaXTN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344751; bh=4I+6H6t4R1PSAbDphFTCodzdmZKek818TwRA7drv09Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=VSdw5JFulZD4g+jw/qvyKBa8m5oLN7B9maQC16FFmu3b+Por4c/iHdb5VUleg0imb8JSMLRYNHV480YVoG7V8I1hJo3BIF9Or9O19P4J6E7c8rhITxZ6GHQdkCNPivbwLbnEUEEtpQS1Sb+0C2yReW048D+HPRr5B0BrV2t3XTnDbt4U47m64CTt289d0ZWCsY4kyk/KR+r1mz+Lxt0iF09frjR2SA+vljkDgMGeIgn2egHfHz+eesQklOybDjtpLKKf7R9jXGrqX/oJ8oiDuqjN7PVCCdpY12TU/aeKMIYmCq8NdkmT75KScyi4R6J4qdNALpyS5khxPE8v+VFvUw==
X-YMail-OSG: Poq6k.8VM1nIRnT50r8T1qFXoKuv9Q1OgTWe1V9wDfy4FbzpC_ecEwq61uCkIJM
 pb060yiQ_YeEfuM.NOjB5x9o3vQ_ux8vew9IUk2vKbmO4mkjq3jASyiSmml2LQnJ37nLC2Z0TINf
 WZ7HJQHzooTMh9XXz.4gfWXyf2QZa_PqXw3_vZh0p5CB8zQWW.iXQilm66DfOLvDu98X_JzyI14Q
 zLS0JO3Aa1_fREb.5YfTW..cxA2ohnidSB8nElgGSkqCZ9i_qm7wLZwhmSnOyJu.G4bWHrEzxzXk
 ULy3Ad62Zqn_1FnBxKP.T8sv8cjcaIaqxEm3ZFiz3psH.FqaM4L9wZFd.Gv9jMPZ61N1Cm6KCwDQ
 gYta0toLraF9rNluhWuVI1FJ.AIS_VrTWHrlZwBBA0rYuPkf_zQNhBT8_GtkqZjSVDYu8_Ehr3zD
 tub2fks7qvzgHnb8yAfn7m4M.nse85lCYJDUbBGj8iNPH9a27ixqY2CK72hPsONGlwMvtzbgdqJc
 vWjEQCABClqoK6NdHmssVSL7wqqnu1Qqwjyfypl_TJhj109ZSEuK2Mf5.6dv5ScqHkMFDthE5y4T
 Qvd0btj.4FnbL7tYq7bwqCs1pazqPBKi16tQ9ox44I6tAjdKZxaFjz69vVxYWkFv6pPZy1spD750
 s4fiEBfBd5FynXs3vyQdHRqooig5mRacnYyvK.VHJ_Zj34mxxtdZWIkl.otKnMZk1f3JMWOrszUr
 N8w5m7W_Uqkt.1YOmCLxT9rsY9BsnrrEyqJsmi7p0ikNkbug_MB6uzuVmstkNsacmS0pv9H5G4yj
 IBXeHt_2I4XdTzbbNEwPNsGhgcgq.CHIQPML7zmX.OFxg1KYhSfL_2_L8jeb77HyNIWPxO29isQ8
 IMyuqsL0DkrzKwi_QpD11TZyUbK_mDmRxMHPfJA_B.fej2rqofJIF.656HQE0.kV0xhxNc6PtRET
 eGGh2IHHv6co3BecLC56shTKR0xrclRQpqEqFH3KgNbRZ6Z23jd4v25qzOQms6pBlvUrX1K1_83F
 vGUjGqUqViAwBAdRpbNVK_ZtiUodAhVPli3NO8ETqwfyBX7fiDlPMaz8uvN8Ktosk9Pto4aranLN
 0Nug6W92bL_sZGPeEykA_0UmgYcgF3ujrfIdLFbw_QrxQSknFQwfNLbD6RJj6Ma2liYrsFXdeEpc
 vOkazonuIXOdFWdRz_CGEHDnQT4LlEeV.SlxiF1AALNDhNFybflmCV9DPfBDejXS0cYYXNTDohk0
 PVZUbNlSBzvNa3evgefQLHddZgkfRx8tT6Ot4QMPZhsBdD2XdJXM3F8AqDw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:19:11 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6dfb1cc58eca6b211ba8deba6fd0269d;
          Fri, 31 May 2019 23:19:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 46/58] LSM: Use lsm_context in release_secctx hooks
Date:   Fri, 31 May 2019 16:10:08 -0700
Message-Id: <20190531231020.628-47-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert SELinux, Smack and AppAror to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         | 3 +--
 security/apparmor/include/secid.h | 2 +-
 security/apparmor/secid.c         | 4 ++--
 security/security.c               | 6 +++++-
 security/selinux/hooks.c          | 4 ++--
 security/smack/smack_lsm.c        | 4 ++--
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d4ace7af4950..3a779a0f9e15 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1329,7 +1329,6 @@
  * @release_secctx:
  *	Release the security context.
  *	@secdata contains the security context.
- *	@seclen contains the length of the security context.
  *
  * Security hooks for Audit
  *
@@ -1663,7 +1662,7 @@ union security_list_options {
 	int (*secid_to_secctx)(struct lsm_export *l, struct lsm_context *cp);
 	int (*secctx_to_secid)(const struct lsm_context *cp,
 				struct lsm_export *l);
-	void (*release_secctx)(char *secdata, u32 seclen);
+	void (*release_secctx)(struct lsm_context *cp);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index acfcf99bff0e..a780e56d4f5b 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -29,7 +29,7 @@ struct aa_label *aa_secid_to_label(struct lsm_export *l);
 int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp);
 int apparmor_secctx_to_secid(const struct lsm_context *cp,
 			     struct lsm_export *l);
-void apparmor_release_secctx(char *secdata, u32 seclen);
+void apparmor_release_secctx(struct lsm_context *cp);
 
 
 int aa_alloc_secid(struct aa_label *label, gfp_t gfp);
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 35df38592b6e..46c8b9a67ac7 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -123,9 +123,9 @@ int apparmor_secctx_to_secid(const struct lsm_context *cp, struct lsm_export *l)
 	return 0;
 }
 
-void apparmor_release_secctx(char *secdata, u32 seclen)
+void apparmor_release_secctx(struct lsm_context *cp)
 {
-	kfree(secdata);
+	kfree(cp->context);
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index 44a4402073d7..029d2f4fe48c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1996,7 +1996,11 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_one_void_hook(release_secctx, secdata, seclen);
+	struct lsm_context lc;
+
+	lc.context = secdata;
+	lc.len = seclen;
+	call_one_void_hook(release_secctx, &lc);
 }
 EXPORT_SYMBOL(security_release_secctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fe09905d013c..332296f69f76 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6322,9 +6322,9 @@ static int selinux_secctx_to_secid(const struct lsm_context *cp,
 	return rc;
 }
 
-static void selinux_release_secctx(char *secdata, u32 seclen)
+static void selinux_release_secctx(struct lsm_context *cp)
 {
-	kfree(secdata);
+	kfree(cp->context);
 }
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3d24503029e5..cf27905ccaa5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4468,9 +4468,9 @@ static int smack_secctx_to_secid(const struct lsm_context *cp,
 }
 
 /*
- * There smack_release_secctx hook does nothing
+ * The smack_release_secctx hook does nothing
  */
-static void smack_release_secctx(char *secdata, u32 seclen)
+static void smack_release_secctx(struct lsm_context *cp)
 {
 }
 
-- 
2.19.1

