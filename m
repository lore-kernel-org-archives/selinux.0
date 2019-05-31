Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DE2C28CC4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDD42593D
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eLO+Zs/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfEaXcl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:32:41 -0400
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:38068
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbfEaXcl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345560; bh=dwbKmDfRWBch8TA3RWmr5v6f3rBIx/+49c84tS3OSyo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=eLO+Zs/y15/lxrHl0ztpHNd9uQFAcjtvo1Nn8ZlFSYyLeTFMMeEogIKcGH2k97AGMkOk8jYw1gSOylQTKCmy+K7MWvTmIuz6zGL8KEQfznErQXhAR7pwhxoR8g6dMQonSczUtLikJN89g4b3sEiixWtYn+YR4hF2GYcjTvGrEKA4BvoITM6aFziC78tdfRJ39EHZ1IUBJx0aVDt7zx4dJ5hBoh0QA91sUpbjsixLb8Ykw4QBSzzvbL6YWqOkGG9nLH6Wj748H9uvtRfdzwVdoz1kvnR/I+ROwL8Y8hLjvohML1ACy7wttjujdNp0L/y2QPCO37nwvvb2TlkOvRE94A==
X-YMail-OSG: ublMRmsVM1ntpNFMOz5NrymhDdv9VYJ_G405CZDvAe5sbGwDsPKx5Rdfw_Vjh2m
 i7rbRS0M7KnVtNj8Up2lrwSwdbCTSadE.Q7CykEwhZHJ.0yPKI1lGHa5wu43OpmPE2v_ZeV0nr8_
 ORtyERgoKbCBFRKvX0ATkxaJO1m.GICTfLdSf2w2J2A9F.MLYG4qLnmAoUwuYpKTVxun845y7yhl
 BUai.uLCIB8j3d9UiF0_k_w6SZ2QicScwv3r3jyzH.XEIpPdaFlqEcECrGjV7Xgmabd.Rqfq6LbS
 9wCCTlk_dzFpVpAhS4pn_Mrn95MpsUZ9Qa3WaozIS5vEQw3dZBG3vvO4uvZq2zAXV9JT5cwdAmdN
 3TJuLWaH6YHmgJGKvsClrI9c55q5LaXSHoUJl74vy34kJrJoyAoJJROR_yFlBhchSJSzhiNnEtVR
 hEnPvLI3NGk3DjDLwVWRIDvMwVQMOTIfLqWbtLuQ9QPWLDDYzelfMs6UkkPbQS16lJhmOUTqUmJW
 ri2lSxWMJDV.fHiaagCTSgU.MFDw2gV9RDQPxJSwC8fVXAidxBO8frxBaPOQQHPiO6rbkDiRAgD9
 oWpWLD.5byU3nDJab_KaXLFerDuFOLM93sfNPFikxtC4yx.RRD0f8DKQCEL23KNwuNHDE7sUBC3x
 I6rUpLQfHM2izCir7oWS23Kvezc64mCTHP7PQfGzMdob8w9RNXoRyJjQX05bS_KMkrSVZT4tG2T3
 OHipvUgETuorW0DfFB5uZ1lEuA1eLFSg9ndGLuvSER0WTjbLkhyqWLcFK166UzuUvaY6h.CRXuAt
 LJLCL.w1HnrSWqPyVxSTkCOkmMe44ltWSxMsSdaNK9m_Ho.zuM5l6Z_83U0u6ZhmO0Sv0KF0Kw91
 db8HjXBkXa.sl7_ED1nEqZ4ZatG6kPX14qgd7F7.LiCnTRsv77XKNYnVhnMcd8sCggNxilXnxIf6
 NtHG4cJDbxKgEBWG.hW.K__DxJsU15LXIZ21SwKM9vMpXKi1IOtZlCbxlO9I5UkAJw0EDPNrlrbr
 sVXrIEvvq3s73u2HsmNZw1KW277eaPMdgtutY0L.TRRlSdq2IDZRsedolBZziVo7y4zrDlHNtaZo
 _tY2OKxdYdJ9Uk6RDrEj0yrpML3sXpuIFRQpqPhdZDPB976o65q..ehfqbXz6YlBtFHB59WISHMf
 PvWJPKyQRaVb5Sf9g9U3gMphXtpxvv.TmD3vQqVFFD3KyRkfdEs5WQli6seKoxYnhcN5dX3X9D9l
 Ll4vigy8lYLkVAyy5WTa6tSpMIfeQ9H_n3d0eL07E80MqhtPjEkN9ZLo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:32:40 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 843b556db8dc4263deb8469fbc0cd8b5;
          Fri, 31 May 2019 23:32:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 06/58] LSM: Use lsm_export in the cred_getsecid hooks
Date:   Fri, 31 May 2019 16:30:57 -0700
Message-Id: <20190531233149.715-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531233149.715-1-casey@schaufler-ca.com>
References: <20190531233149.715-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the cred_getsecid hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_cred_getsecid()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 5 +++--
 security/security.c        | 6 ++++--
 security/selinux/hooks.c   | 4 ++--
 security/smack/smack_lsm.c | 4 ++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 09573c55e535..0f9d4174bb6e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -572,7 +572,8 @@
  *	Transfer data from original creds to new creds
  * @cred_getsecid:
  *	Retrieve the security identifier of the cred structure @c
- *	@c contains the credentials, secid will be placed into @secid.
+ *	@c contains the credentials
+ *	@l contains a pointer to the location where result will be saved.
  *	In case of failure, @secid will be set to zero.
  * @kernel_act_as:
  *	Set the credentials for a kernel service to act as (subjective context).
@@ -1596,7 +1597,7 @@ union security_list_options {
 	int (*cred_prepare)(struct cred *new, const struct cred *old,
 				gfp_t gfp);
 	void (*cred_transfer)(struct cred *new, const struct cred *old);
-	void (*cred_getsecid)(const struct cred *c, u32 *secid);
+	void (*cred_getsecid)(const struct cred *c, struct lsm_export *l);
 	int (*kernel_act_as)(struct cred *new, u32 secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
diff --git a/security/security.c b/security/security.c
index a1f28a5e582b..ca485a777ca1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1638,8 +1638,10 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 
 void security_cred_getsecid(const struct cred *c, u32 *secid)
 {
-	*secid = 0;
-	call_void_hook(cred_getsecid, c, secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	call_void_hook(cred_getsecid, c, &data);
+	lsm_export_secid(&data, secid);
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0e31be22d9bb..f97dd414ac8d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3764,9 +3764,9 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	*tsec = *old_tsec;
 }
 
-static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
+static void selinux_cred_getsecid(const struct cred *c, struct lsm_export *l)
 {
-	*secid = cred_sid(c);
+	selinux_export_secid(l, cred_sid(c));
 }
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5e345122ccb1..15579bdd7244 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1980,13 +1980,13 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
  *
  * Sets the secid to contain a u32 version of the smack label.
  */
-static void smack_cred_getsecid(const struct cred *cred, u32 *secid)
+static void smack_cred_getsecid(const struct cred *cred, struct lsm_export *l)
 {
 	struct smack_known *skp;
 
 	rcu_read_lock();
 	skp = smk_of_task(smack_cred(cred));
-	*secid = skp->smk_secid;
+	smack_export_secid(l, skp->smk_secid);
 	rcu_read_unlock();
 }
 
-- 
2.19.1

