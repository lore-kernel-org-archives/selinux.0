Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9393D2571BE
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526539; cv=none; b=HdvQZn7YcIZXXZE9Jf2dwQAv0B2D1xoQ7TUAI7ICq0sggStYBVZ/A1flrYqgqxWh9JY32zWfe26BrPTXcFNPIlX3fyo0sEidYqDxoj4chROiwzMdT9QQ9/CRjkdIC6I3QJUJjOe1z9Mp1ZcH3eAY/KJrgZdchsq8JW8HM/7zVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526539; c=relaxed/simple;
	bh=uB7yD1qyg6F5R21Apr6SOlRFrJq/nuG5H6U1B+gczfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/tEazEuJKWxuMRvT9zhHWU5wMLn9Foi3Rtlg1gkLn2qnpkno+r6xR+9zWVZQFE3/LZ75yaQlT3vGHzZbY3wddoHIT5KWKSzhSVxzRnFHDP1s624XMYliUMCmjIurXmo7p2PDCrJgs9dVfGXSmzyb8o4NmeqwA5T2TXleWuXIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mKxsjLTy; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mKxsjLTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526537; bh=Ma/ujA/zU9vMJ2PjqU3PgUxULblvq7rfGh0Q2+r5a54=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mKxsjLTySs7eYlrzGCNPWcPYmB699idLdmBHZRE8wb94q3xjHIsXuigKf0LLo3WkN4nNuPjTPa9n7jGQRbHJbGcUf1Gqh7x50k9hVH9gAFUyZwiaOg2UzWPSNfkIyNx1ptZALGCbeqWg7hQ3Tr6LPI72G3zFHUYtpNfJzny4/q/4CjNVGBMJWhvu81OKST2BHRXsQjjTOTwDde7uL/rdAQjijt0f5qgZLsYOhwhh1ytooqm6kwyUeg80Tqj8VLJBQhSo8UBkbl7izja+U2sOtKxk+re2o8aiYQ9m+jZsW4rdkCffalerAP3AbjhJhQVgreIKbmPKd6Wb5MCdKNB6Sg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526537; bh=xI9x0e9BH5uzKwXu43mTrUSfhbyF5HTbdLWhcaI9Fe4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Y7OtFytL09P+YXI4KA0RjOUXP32FOjoCcTSBzu/jGSHb+uriLw5xurG5MYuSEzW8m80ZE9gIBSDsDXATz2nqO++42I18QZqnboJoAFf4NZ318f2+nl5WgXDdpGUGnF7cCf5zgqeMjBjwvoi8ZqhwSuStrTs6omHK2UHntlY7zqLKQhIXP1KToxrMiFMH8Xt/dQr7qU77DH6VSwk9BpQh8HwUYDYnMOXrWpXfq0fJLL6cVHuweyjgEjAir7ZACvZaQkgZEJzGsK7wVlAwASjWKKPmg9+zfC8Cd5aBj5e4XI94WJj8QGCvDcBl4rEZWmRTdz1EDTLYBZsct4VEAVnUrQ==
X-YMail-OSG: FqcE2dMVM1mAGzvVVO2AlJuFIjNnw28KfK4U6SlX5qruGe.QDNf4.YAML3hU6mc
 6m2NMpeZubOPd2aSNqmDeyIaBG5RzYMBOOGBdpVfo5XYMhxItUTyHG7Rl.ZP0BwYUtjl.Gx2BHgA
 1S5AgPjqYfZWlYWiRT48OX5.0fQzyNZ5cWcfnptgB4UXbpOLCzBkDjcOWPTNrlI_bNMlQk0Ro.0q
 _Nk7IGoouZ18jSkBZcoGmdie3ntB8dVjGOuZ9STJ465AK8miI.QIUevCMw5tOdGbFMSNUn23BYPF
 Qxauyg1hGs9GtO4lVAEMFtvXNGjph.Kco1mjdYxNkkN4RL4WAMt1rRV_jS4y3CUhhbvxYPiiZTy8
 il8zUjSWDxlPvdMx6JMXLbI5wix12urhw9XyUN9E3atWgNbARYtiPrLHU4QUmgihSMjQ8nd9Ylsh
 _Uo8WzJ4QvJK2m3Qs22E8vmLJLnoqWS5lYKOBPPhJFAjUqt2sEmToPsaOtDtIox6P6CQR2D6RhZ.
 4N8Fv.JaPfXNnK8WtSUUIHvTZSql9jnEB.NvXfOcRjCowKZBRGZmAkyM15u7QAysIpmGtrap6IWq
 c3282joQQB9amGM2lKBNguePoq4kutXuUbFf_rjyX2S3DvRLnRCFMmWb3A487_cC78PyyxVAcK_w
 4VFzvLONLZcQ1cffbxugcC99UE9IdvBgbO58dDvnXrm7nf5wF70n91YaHDJXNhYa9EUzj28F3qWM
 1ZQ1Yzk0YJxOg2xiqn3NpQ4akdNAtDSuFiNACM5HzhsfJkpuV8squV0mrvsED0XaVeUnUxt.Ka3j
 NsP1TCUvpxU.8U1vQx_S40JhMHol2rtProd.dEZlxQzV.tS4an4Eyfl5U6fEc3g9vCMYivoBbbqu
 hHq4e_fK9ahIT.2Vs89u8zz12Po2hfaSIRD4zKUCLwTJ.a3l6HWsIJf9DyJJfxI7bKDUdw8RgoOR
 mDu2NkpU6vNCCZK.1UmT5vEi_ILOxN7GQbjIqfKFzkgaQ9wB6P5omkcVMIVna7TjEMwzr54N94fp
 DNNcdDo2GP9Uqsv6l8WcM38buWpolbvuuMhnbE8QBHQaJaHB3GmiDqGGHBrSp7IAfbVrUGMbWPkO
 MAeYjr.aQVrI7ZmtCGUpDBcexmeT1FncnFIuwc99Br6ENnGA84zoOASiM9tVrgj9Xrq32Rgl7a.U
 wRRIoSVJlDxXfAwBqujwbi2wkkaZPWyDA9g63cthioxveqRRqWXdPQP.xo_lHbOx9uSl733k6jGc
 qdmohbTyzkrWSj5GDUqQwuthTQiEg7NEAx2pIX8NvC9m6Y4P44zlmTlpDgNmJand80z7EGc5KREK
 7k..228IbUa1r.tkthOenxS2CkQIhI7ycL6Vb3brrGGIBwFaForMe7gvnQrQpkq3EIsdd5OJUiC3
 orNle131hu5Rs.Mood2wgLMD4qGcIQVuBA0FzV7MMQum_ErlFyWCf0fkCjT.LKzZ53SBHxvGDoWd
 LmqpLKGh9sznGo6SeKdAvrnOiXbuPo_FJAoAO2LRYjL8HucSlaMFTuujOVA8CHwvCJ.BAh6i.tZH
 .s5eF5YfBBQwT.znx4h4HBuN8BZS3k.1BugbuI_cSnufSsPYzLQeSsZBQ_.W6PDsBc0Qy7EKrlhC
 f_QTjnGyNpJNq1lUzz9Z3PujlXjUzXZWdrOeTVBEJtzsBQ7cOJdPcSYs_Io1gf4Fhfg8eSnEeopG
 cXM6XPj8ePWv2bIPN4BgcblLXPGEqE8.1tCFkWZ8TC8bs4TADf8coi0_mJ44MF8sc3S_JzVn8Ck0
 vSk6uSk8U674NM.quITfPvG2ZLq_AMroef96gY3i7hwKxkIDKvWiP4NQas8FSJUMCrkRS5cVm3VV
 n4eHAoQ7wk9UjTdqnSJIuaY0wmA2M.Xee1P0GOxlmFxpl1rmb5byk1iuLLUX_g_PofToK0LN4Ta3
 upDDLWAFmeQv42ONADkhkiXvRQIjEsS3G2hr19wU21GntTvbf4_UvxwIxUzjDNWHwi5RcTG5ffCV
 3iQFuHLUPchyeG7uHfzrsSrYWFeI6RrK34YSa4I4pWBc_y0y8d9yuaFnxz34LpniegGRtLOFy_D7
 suHml69r0Ev2uq7aZfEgGgyVdOKg1H5RfcRXsS2veUVGu_b2YhQ49QBvaqZctOBHi6yzgaGljDcA
 UJodVYZrK4juNTqzQBmcAu5QXMNM_ph7Sdt9466J2eMjCI53AIsyMB9seDfZD7W2KOeeESRIns0h
 EmSGr4caz.isOXhr7QJLsCibRmvOpzdTJk5vLays8SekQhzurAyye4zFHNDGL53a6TgSdRkQhENM
 wE652MWCRc0zQLrJSMGWsh0Opxqbd3BIsFw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a6b988b2-fbe9-43a4-a5b4-a222d64c3566
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:22:17 +0000
Received: by hermes--production-gq1-74d64bb7d7-dp9cd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID be755b04d481595739dfcf42be1b4c68;
          Sat, 21 Jun 2025 17:22:14 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [RFC PATCH 09/15] LSM: Add mount opts blob size tracking
Date: Sat, 21 Jun 2025 10:18:44 -0700
Message-ID: <20250621171851.5869-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250621171851.5869-1-casey@schaufler-ca.com>
References: <20250621171851.5869-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mount option data to the blob size accounting in anticipation
of using a shared mnt_opts blob.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 1 +
 security/lsm_init.c        | 2 ++
 security/selinux/hooks.c   | 1 +
 security/smack/smack_lsm.c | 1 +
 4 files changed, 5 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 1ad9f8a86b10..2e3b1559714c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -122,6 +122,7 @@ struct lsm_blob_sizes {
 	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
 	unsigned int lbs_tun_dev;
 	unsigned int lbs_bdev;
+	unsigned int lbs_mnt_opts;
 	bool lbs_secmark; /* expressed desire for secmark use */
 };
 
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 4e3944c68bc8..d27a457627ed 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -313,6 +313,7 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
 	lsm_blob_size_update(&blobs->lbs_xattr_count,
 			     &blob_sizes.lbs_xattr_count);
 	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
+	lsm_blob_size_update(&blobs->lbs_mnt_opts, &blob_sizes.lbs_mnt_opts);
 	if (blobs->lbs_secmark) {
 		if (blob_sizes.lbs_secmark)
 			blobs->lbs_secmark = false;
@@ -460,6 +461,7 @@ int __init security_init(void)
 		lsm_pr("blob(tun_dev) size %d\n", blob_sizes.lbs_tun_dev);
 		lsm_pr("blob(xattr) count %d\n", blob_sizes.lbs_xattr_count);
 		lsm_pr("blob(bdev) size %d\n", blob_sizes.lbs_bdev);
+		lsm_pr("blob(mnt_opts) size %d\n", blob_sizes.lbs_mnt_opts);
 	}
 
 	if (blob_sizes.lbs_file)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 18ab1f13f3f9..c86b430f34c3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7161,6 +7161,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 	.lbs_tun_dev = sizeof(struct tun_security_struct),
 	.lbs_ib = sizeof(struct ib_security_struct),
+	.lbs_mnt_opts = sizeof(struct selinux_mnt_opts),
 	.lbs_secmark = true,
 };
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c8c173bb9cc3..956dce6b1e97 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5030,6 +5030,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
+	.lbs_mnt_opts = sizeof(struct smack_mnt_opts),
 	.lbs_secmark = true,
 };
 
-- 
2.47.0

