Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E54C67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD0820851
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZxaGPXTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD0820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeLKWoD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:44:03 -0500
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:37315
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbeLKWoC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568241; bh=lKw+YFFirAcuaGMfYgMV+U5QfYDFlilvNclUnUdmOyY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ZxaGPXTp5ox4BX/Dj+pw63S5VfUd0WlLpxNuEl0Fn0RXN949Ioe2xRVYDYrje01dwUABoKx+fenfHZPsUYcLuBrUqdHct3JO8SiRWIjZPNmNikNJDOhQlPb1XnzKL/FuucsHWeY7Ip+yU8X2wwNqDEXZlyeNJm4vBveDfWpnFs0ofFAKHIKd8q7RzeT/6gLIh2v2i5/TvlA6v68iGn51dp9YRO3xW2icOw8rZX3hF5StbCTVf//MOW34jg28CDXjUWVQyA6M/6f0050ebHogCulmLU24ZqHZczHxkvEt+vVkX1wEdMH1iI3ZEC80nfzzIcQKv1KmoiLZUBLum4MSqw==
X-YMail-OSG: tEGvkfAVM1n.MsrCGcE.bzc3C47xW8OQlLS5AsUcnqJJtKC2wEQJOUnfDkOgM.I
 7xkWMbZWWLGRpeescZ_xSHu5aQ_UY1dB807gLyCSGa7L67.c8zEIvzZlarLoRmz.2_o.X780g2IN
 lp3vTRg3mmtAGsCmfaKp5YmY7oJ1qCy2xmw4JQcJLHhUIpAQkb9UEIbYUVkCW7fGAS.tPzD0RZWI
 dhP9KR3XeVgHos5KF072JiiqYTRO8Z6AbKHO2Z2PUckjN.ZWDN9onwFjzlaAo2CA4X5oqUTjfDHe
 OjQYq0AfftHjUjthzNfldMPG4r7hL7NL3vW3cT2c7CXvuOYBXRD8plqZA8YRi4ZFvdTg5qkBWiOl
 2KTpj3vCTIe7smHuHRttjCiaJmdrjCNduHnnsIl.954yta7W.se1dYaTWiRKlWuyGKIgbHdPv5pD
 VML3rirTEg5bQOTJKZsnN21eF_0b5P2dG5sB7PYkXqF0hQZv8J9UPsrgnnvLYnVR_Az5gYk0yj17
 h7elQ5Ka9DQbWFo9z0O_pPKANj2ecJ85W7xsPtsahH30k5tlgbzMwT38.hbK9asSZMDpG_44hkOU
 J49pOvbqQcVnOCFmxPG5A2UQIMwWj_QIEJis37rMmrxvC_dnHTvYDSyDPRp_DbloL4lhe_IaERaK
 6zYKlg_rfYOh7WzcW_n7C.HU75krKT8j89_DuZJIyfmQsyf8rX_q0wnBZ_BP3VT8uHacpOmHZLwL
 c68JA60eaVZndofhUySiq8FeQRJUVAmhwsCUwrvoYkYcYjBIV1Jg0tjobZz5UvVj7JU4s.jlpm66
 ghbNSaqB6gm3ptdM05kVQ4A1DnhMz2h1liKwbs5JW8ONwKEpxRJRfvbk6o2ZmBmFfbLPAwO87j1m
 wE7iyJFlrE8baxZ87saRvZjLjyyfVQ51ryLsLYP_Y2EIDvITj8pvGq6g8AxUCaVBa5RybA15VVpX
 03fQpzKITWkpk.VCCNhSWY_aFc88OWh0uDEwyh0RKiuKBbJDOTtwHOe6aipYlbFVuCq3MCYQ09y_
 IV20F1KhcV5hDMbVC5KKKQeyy1I1LpBggj128Q_7ec3r4Q7tlBe2Y33bRQSxqMfYnDiZyuSU_7cm
 cYcTznIJdg3KMQFuMSp2eOilw2HGpJdTiaQyGeg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:44:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8f4847c15ff2a33ea2e557120f9f24e5;
          Tue, 11 Dec 2018 22:43:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 29/38] Smack: Abstract use of file security blob
Date:   Tue, 11 Dec 2018 14:43:05 -0800
Message-Id: <20181211224314.22412-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Don't use the file->f_security pointer directly.
Provide a helper function that provides the security blob pointer.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/smack/smack.h     |  5 +++++
 security/smack/smack_lsm.c | 12 ++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index b27eb252e953..50854969a391 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -362,6 +362,11 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
 	return cred->security + smack_blob_sizes.lbs_cred;
 }
 
+static inline struct smack_known **smack_file(const struct file *file)
+{
+	return (struct smack_known **)&file->f_security;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 459f7d523ca6..3e11be8cce7e 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1573,9 +1573,9 @@ static void smack_inode_getsecid(struct inode *inode, u32 *secid)
  */
 static int smack_file_alloc_security(struct file *file)
 {
-	struct smack_known *skp = smk_of_current();
+	struct smack_known **blob = smack_file(file);
 
-	file->f_security = skp;
+	*blob = smk_of_current();
 	return 0;
 }
 
@@ -1815,7 +1815,9 @@ static int smack_mmap_file(struct file *file,
  */
 static void smack_file_set_fowner(struct file *file)
 {
-	file->f_security = smk_of_current();
+	struct smack_known **blob = smack_file(file);
+
+	*blob = smk_of_current();
 }
 
 /**
@@ -1832,6 +1834,7 @@ static void smack_file_set_fowner(struct file *file)
 static int smack_file_send_sigiotask(struct task_struct *tsk,
 				     struct fown_struct *fown, int signum)
 {
+	struct smack_known **blob;
 	struct smack_known *skp;
 	struct smack_known *tkp = smk_of_task(smack_cred(tsk->cred));
 	const struct cred *tcred;
@@ -1845,7 +1848,8 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 	file = container_of(fown, struct file, f_owner);
 
 	/* we don't log here as rc can be overriden */
-	skp = file->f_security;
+	blob = smack_file(file);
+	skp = *blob;
 	rc = smk_access(skp, tkp, MAY_DELIVER, NULL);
 	rc = smk_bu_note("sigiotask", skp, tkp, MAY_DELIVER, rc);
 
-- 
2.14.5

