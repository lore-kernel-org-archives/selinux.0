Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055C1E0E16
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495253; cv=none; b=LxaceNvjmPiFvW52elGeHzcD1VMON4C2C6I762zIKk17LewlTO1ZujygNc53eq17YRHbukzhPClBK2WoA01xjC/+LT9MK/FNpsJOKmNOTW/2fr/y6OuXEMbhBqa+qN7lH2jzfmD8JTU+hkK7XqRnh5Jj03W1x/NTFKbvKXqrMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495253; c=relaxed/simple;
	bh=4P7C6WGa+3DAD3HMQ7qltgx4htUhGEAzSs7puUwwYFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xn3VJQtM99JqmfUmaJaj+3ypjUWSnP/IsNGISd0Gj4nUuIqvunzvVoCetoYL8f+DNw5XlWRSfpCJ4UEhVc7eHwmubWNDdgwVxVW8fuNcaA5xUf4RIuCqZKTUZm85lGnsORI6I9Dgd8Cqu9sdvnd1/tnn4qc2fYI+EDRfFH5YNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=J+iFItwc; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="J+iFItwc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495251; bh=Ri80MgNDcTseaGUsqfIA0tyVfuRU0LoKRoYnob2OWgM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=J+iFItwczlZiRXdZ/QwzwnIiaH6DGZC9stRISMNEgTvFHRUzRbyVxg9ouO05iJqtr3q4B4NM+8uOtoP6dijBoJFzjQnUZJ+ionnMpSz40TAnZ1vqjtJdVP9ZLqb+GncBPTwqCWa2Ub7VxGdgZAL0+AXR1mPp3A04MKOtXzr6EaaAUjiEireDBzT8xaid5qN4mt1PIOZTJ3RNP/v8jf40ELP9QuzYCGsWrXYaGIQ9I8Clp0IV8tRS55mXDjRY0Qpydz75/bK+UUb8AL0WJk6meTDicwgBmL+YUaegBCZNaMATjcD9gb23l7gqIYgU31iFybrBdW9IkYtAkC/krFLteA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495251; bh=+LvK8j1vwCDTYPM1Mmj43JKM2tnho148gZz55FrWoGs=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QctkixJESEl0WB8fgXqQuqkLCFMs72Le8fXThloUMEFm144yhKYdmbAbwv+RD9mWYakFbt6B5FKpK2uqprGJG+Fx3stKOGMhpRfle21vtJL0EuIxyJQBwrKf3AdIpj7eVT4vH88+qWtgd2vatnKT3bkt2qicYCGKaH/Gyq3FSs4NpEGu63a5BU/gGNyghp8EzW4mZJGK0XMNrlfVHDjSIcTGZ7IwPJjs5cJE6B5po5MG3m13Uii68ITbw1CoGiS6/lkcv+jNhOZ/WNJxU6qXLzcHWKsRBYlN03+Q6Yjq6xtcVHq0j3M4pQXtv3mEDKKzfDzk0oTC4wJgu3XALmEVPA==
X-YMail-OSG: 6qG7DtAVM1krpNbgRCjAWDGlXzA47KbP2Bj4gUUM6eqXhQW5PWMCM7bMT0Yn6BV
 fmJRJ28EHHToAvj1BGWZrgVVVhnsBDEw9BuFQbt4TU5emp2HhQVVK8Ye_AXdDc3D5AOIFElvJ.Ve
 .9V9xKxbAfZFnZVxWlkNzrZSdS5E2Kn1IaoPPCy0CMC8I7nSE3IC3naIBtY78rYHYO.VNp3KIym7
 gATDRwEzyH69IXvbq1eItACK2cSGioQYWcq96P_mms02_KEolQ9Art8L0E57XQNRKP9D.xGGRTXn
 lqt6od1KoXsE33Eu2R4hnZF1wv_5zsU8vhGwAuxWPEfwfkLWFxjcLsQLNBDrcyh.WpODVPXTSE28
 Pc40LLxOTNqaXDn79mPQUa1zguLGL2G0TwSjDjF2ax6Xenz1rNxVo6RE.SD0_U7krJd8bt9r70x0
 cabaQ8lNZN06Kdv9lAPYDNn3d1z6zVZfPGuluIFmSIZOorcnvvcqpwsrOONtT8HZzaxJ154YI16L
 uztu4u0bzAXqEECfImXn_VsiWigwLrZ7Diuuhwg6FXUnB0kzPAhCvkVTiBSXq6a82J4sT0SyATeu
 d2J7qn3wabCZChMIOXy1XWDlW5wheMqd8PH0rrpdAMNbW9VkOgr_V5rh16XL2P4j9nG3TqbKLTvp
 iKx2JtMEgU_WlmzZniRSNfdS3kKaBJqQxDBKtsgs11iQss8qYQC5_AYaB1iEJSFPAOedYvgsriY1
 AS4YNGRh4D8F1bz9BWoCXQrBygH8.1OijyqOsFQlN0MwFdlctWJ1FnhT41MZlYk227eUmh_TH.kK
 lnw9ROlMrjp7UO4rH0JGEhxsyeSWSHxQ78abNDknnRprNl1s2CWX57LqyiTv9CzkjLjCxBSPr4U1
 ccxKRYod4aZmYabFVlUlr0L8A2qsOGf.B784Jg57GLyZl.KtogB2sx9ZFceKJY.pWakAnlaqAJl7
 RI8.vsAy.FKj8CXKWZm7ktgiVL6jwNIbnerc3v4SqiseOVTCeOgZqYl6Q8tv6MfYxTCw4dnd1XKh
 isMR1M9I8UP_1FR5sXbZhn3dXPzoavN3_SY6mYOVzWvRYAliJ28OBVmNI9qDQLt33947ZabyAVXN
 z2mSkgYVYsNQspoinpHUbiN7f_u9IhrDGoqyBYzNyuFEFLTgG20qLD4KC714A9irdTKsrTmt2P57
 q9vs7a0oaRKHlug4FkVB9xjcSNFk_BkF3o4glOI_eK93SyFUCzo0ixI6ft6K2vN3HMKW6B5QRAyl
 SHhNupKfj.kaOGzlzKeyB_bPYSAaEHnH9Fd47vv2.WcTkxYa8eWlSuZwBzD0aPZSFhI.FLU2tZEd
 bUq60PDgthb75E8Py_Oac.rK6CAHgkF7FlRHkwXEWZKxWaaeWFQOd25F09NSiacaNtSPaIz1ZE3a
 AcyUM9PVHNctCNd9s3v34FAkTcx5RTQfDKLytvrStOs0wjCXzDhZAkxgJdrnR83Qyu84c8GpTV0s
 .4lsMF1GMmV_O_c7GZRo5GYoo04ungpsz6GatQjA3_GeWWt2BjcYGZD4n9qul1MOEGl3Jr95Hn2k
 plRd4VtL1tVy.XdBzB6eT8Lx3q6gyza.vtcmubHpKaGXb8S3Uo9uqY4LtKl58FGvMKl9uP1G.WcU
 3Q0R3sjUWu9H6E3qBPuPBU6YEXgxgfCQOIEf8dXm_IPnSSr_eAx2wCXxa0mX1CgEUWTJJ.NVvgsa
 SmYkuTZC1a66NNQ6YM0nsMn3c2FpdOc7kihJOcvGC_1j9SyR.8EV1QniE5s9HPBHmtakGDcSgorw
 u8AMN4H2SbHwvI4yD1.VCgZIeSU185AvRDztxb_H4t3dv5oo4l8GPKa.ESusvWhWZ5KEtwXNwudW
 ooS9W9YT7utHeQPtYIe9GydvSCZ_pjgMmBmFvmz_Hl9mBLTqPsTeNJo9tPAJPfNgsSGuRRCUf5TL
 4Toi0seWuENQs3NuPEHyBV82UW3oecRWFVrOXno9OXO83Qecj_RT8YaH.lvZSWNKFAQZRYcj4ZZl
 N4SCFeLVYosGmeDL9riOvfxya6zYmJKBkgYkC9sKilkh_yANDjZXqZyoeZmJ9MI1hs7qqXBN_.nc
 uU1fgMZ0AdAeuLFir.Z9QeNAzq53Jd7B7wsbnaQ1evDEtUToziFcKptPHNztirXKJlfJaQGcuPYD
 .rL8i_.p7YLMWJVjCRaeYfIoNiBbU_ETag4eTanspZBUt5GSNanOlYx.WN9E6Bwv6Ie.iyDzo5gK
 0I4WPwEhePPnmfoyZr3.JuK2D35A3Kk5ymqbiYzlsNPpP_lIPxDEGFsOtiA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1cd3087f-f37f-4167-921d-376d99fcc003
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:34:11 +0000
Received: by hermes--production-gq1-5d95dc458-6q8w6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7e77129a0d9b2a8b8a48f1f6322a7dc;
          Wed, 09 Oct 2024 17:34:08 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v4 06/13] Audit: Update shutdown LSM data
Date: Wed,  9 Oct 2024 10:32:14 -0700
Message-ID: <20241009173222.12219-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241009173222.12219-1-casey@schaufler-ca.com>
References: <20241009173222.12219-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The audit process LSM information is changed from a secid audit_sig_sid
to an lsm_prop in audit_sig_lsm. Update the users of this data
appropriately. Calls to security_secid_to_secctx() are changed to use
security_lsmprop_to_secctx() instead. security_current_getsecid_subj()
is scaffolded. It will be updated in a subsequent patch.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 1edaa4846a47..47c41e6f9ea9 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -123,7 +123,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 static kuid_t		audit_sig_uid = INVALID_UID;
 static pid_t		audit_sig_pid = -1;
-static u32		audit_sig_sid;
+static struct lsm_prop	audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1473,20 +1473,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
-		if (audit_sig_sid) {
-			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
+		if (lsmprop_is_set(&audit_sig_lsm)) {
+			err = security_lsmprop_to_secctx(&audit_sig_lsm, &ctx,
+							 &len);
 			if (err)
 				return err;
 		}
 		sig_data = kmalloc(struct_size(sig_data, ctx, len), GFP_KERNEL);
 		if (!sig_data) {
-			if (audit_sig_sid)
+			if (lsmprop_is_set(&audit_sig_lsm))
 				security_release_secctx(ctx, len);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
-		if (audit_sig_sid) {
+		if (lsmprop_is_set(&audit_sig_lsm)) {
 			memcpy(sig_data->ctx, ctx, len);
 			security_release_secctx(ctx, len);
 		}
@@ -2404,7 +2405,8 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_current_getsecid_subj(&audit_sig_sid);
+		/* scaffolding */
+		security_current_getsecid_subj(&audit_sig_lsm.scaffold.secid);
 	}
 
 	return audit_signal_info_syscall(t);
-- 
2.46.0

