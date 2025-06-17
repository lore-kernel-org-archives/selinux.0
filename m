Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B722EFDA8
	for <selinux@vger.kernel.org>; Tue, 17 Jun 2025 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194084; cv=none; b=AB+bUC1c+Jw0NrmIHKhFnFs2U89Of/VMJi2hT5hx1M1YGVf+ot3LN1crmL4mNS2/1P9ZgDUuECmHhdgdL8g6crRmO5IbwL8AcguN/gm034VUv9rfR5Hu/lePdrngnJ2pMC/sRggptOwuJ9lkSPuFi8kdkKN5chpqbFLAx8UxkeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194084; c=relaxed/simple;
	bh=ghH64xmkgNd+dDopUniwnekT0RE9latD+FOfh10y87g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TztYFeb1wfA07IPQ1mFQ8bOpkvWuoR/z7QcDg/SV3kV7ei1sJ+uC+Zi/eQ5LbfPjQM0DDC5YFh4apOT5k2wn1wYunjjHnuaiSLeNOPK4gJXibjiBx0zcLi2u53IbZv8RbInLBju420rFVy3rKiFsGhHZEFDplDXefQ7hkrKCd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=p/kyiD1W; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="p/kyiD1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750194075; bh=HWbDnsmfiSVNjE+s03/Jh+DgFFx34sqaBnVJGk10ek0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=p/kyiD1W46HVYkxHIE8W/FQnqwdaBtkIMS7KTgZrYgrbX9X3fy/54vytpQA3Ae+GsqvfrAhBMbrvnq3A/+G4+yzODJpNzb9m2wICwF9oeLqxn2fup8wGMWQCo7TXdIFSpchjKPlKx3CvjEWGoW3leJUT0SEJgoPNt1CetnSQH67oW4WvK9zxsickd1iDEA2Uil7IWi25/BPUeeTwRgs+SBhE/aH60wKqSHujV4JcwPQKiPQQr+1Us5kq47TZn4VxTBrwMhW0QDpsmLmHGzEjC75WKy6q4yZ3j1jglXUPw/RAdrMzGDDWh59s0cDKsqZZaIWqqeDnxzWlK+kdrMP8mw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750194075; bh=IuGIt9h3jLFnDCz699D8qip7p+A7PrMB7VqWRav1Vq3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=l3AjtVzt2LclLG6KXoTolp23+Bv4LrlpdU4FDFeQIkFr51Ic/IyQUpsfmfo3fr/AVOaCDtn1urH2A8KY1qruapWFAdgB6j+uijetTIZ1shSB6QthFMk4uUgZj/foqx5B2WyPuPMXn/cQZjLYvh/XCYqjRX65OvKcGCBPv4SXFg8dNo1b7cBZuAPSjBJ9c/s8MXQEChwEx68saS3YzPGnBuWKkmp4U+i9kN8gZl3I/UAyoHJWPi+9KGS5+pedoj6bKlt+jGRNajBK+L8suRNrU76QFPjcFgBn4gtYW0UFgu0iG11qv4jOc1O0ZR0hMpysIFFsDD/nQCUi2Rt2k1yypA==
X-YMail-OSG: aZOH5UgVM1mMDVdfiaoGo.3430_kscFtQlQGPcy6zuYh2egrJJKAcSjQEhCiXXu
 JZA7RyU65KSnKESgJup1Iu.FRjGPYJmLKu1sow3gwnV.Eo6AvZOZGekmiHXvUQSKQzEdrIN0yBUo
 rBWBwj7u5We0TSKB70i6B4BcIopCHAFoYNdeUC8Cabf.y4TeZJMoRET81jlT8PU1QhW5u_3qsOtP
 opVVuvNdAltsxiAuts3ZglwIwrZBJhlVfpfyP3f0piATqq1fHkQDc9.VkYQ6RUO_BaINvPaWMJLF
 k5gQ7_ifK3bMK386BceCw0s8gEJDvgNqPo0n.XedNqjlv24.R1gJKctusJEL5C6xzf2raMRV5WgU
 pczSa15xiTmAbY1V_L5jkdUG3y98e4W1PQ7ohefcm9kh_2H8x8xthQXbO6RiZf.MI8sbmmto2x3b
 Qg4prFULqARlJTZKhJCVO9..c35Ga9adqizJb7yGQUEk_yK9votHJbH6.N3QfirjvCo3KvflXufQ
 OHMdlb570X2kO1gw_y7hcGN6ZBtB1sIRiiX4sQ_chLoxfkl.4nNWWVQk5aZRHrD9qbU9_5BVZC8T
 uRF5G_agFdEW4s0oCsi3Dbxmnwqpv0pFKV4gX1HYZ6DCwkRFu6rlUxLevz_A0jww5pgBO_mDHyb_
 HuJHtaS4oK6kQ4G5D.dWqIHeB844EOkD7tvCbCPRB6F8ZZ08xL_eERpgsIJKUpNHYEXxLhWTzZQS
 0974kUjpy23IzPVOvOSAJ6WRHc.7_KNu2HuqMf7oJP4_oRpHJkboJkibwqfB9k0S_RhSf36ev.ui
 5hSaC_8zNow.idS6vy_IeOcpPJQNAuPzP_Yz9thJUGiGxii1m_CxXi_kbBeibQXww3vdc5ZNEiSX
 dkeqXB8O6ywThC.v0Rd8Oi9nbthm3lR1tUzghSH4MXkLxysYNRIgH1HXKgqI2k3XgWhu9zFkL1gN
 SLOvIN_kvEw_yNC_tPqctmDjGGGjCYTQWkjkGswdvjX_Cg8gkQTbuf3_syCteH.DIym.nVF5TevG
 Tzi50sbhkhU.u205KcyBGP2.S9l8MOGRjX3woxIG2ujRpyEhLWxfq_O5GQ0Oz1MnA4duf_DrRZrq
 K8_VL_y8BDgmVtPHH0dXKSCBR.d3LwC6EpoeEoASCxdCb19M4R_RavTLeehE46aEh_hkw1Ecb9Cq
 4h33jFY8.qU2NPyuz_O1Q4GoobsyrfiUzS1VGbn4Ey_cBIv1iTwuNVnd5wTkdj3pXAvl8GrYISsh
 19Y2du8hSMMU_9o.MtWqUz3NykqGjPkxFrnh5Gvfh1Htf_E9gcEuQ1JeUE95zsgkrSGVS3SZsWbf
 T4vaXlXdbUq2GdoQhbio00J35ZKResDuv0S6k.HJxviUFUpc0u08IpAW0E7HVZf6MbWXtAbVUssS
 MOjjunZFnPGtdhVjdRLyXo8ev9Ap9xqac6O.b0i7SzPWMz66OQVNFJ0MATxX1rbuxvVCtzI_OlFc
 Py_vQm3j2.KCv6HSexUbl80ct1LU7McLwnqJ_S2MFuHX9kEihhaWRuqKYhMF0sVSrVMpxkUxAX5a
 P8bczJYzf3EJVEU4ZpLHT9xS1aKl48GwfDz_GuBX0IpZ81qMpjGbTzq_j.sswZaMKXYZVGLWhbcl
 J.y2A2QYJmnhY17ksphbxTJ5AqBWEwZ0L_Xa6TCpjYBtZwrDlEEaE5f0LIzEUoF2kEuMMRX8gdUg
 6ZOWehyee2eG.mfV3_ENiLqdOvO0LNaKckg8oHQpUIFqnTK1__OG4p.bVhXG.x_LQkWHuJCM_8H8
 JZD7wOWspbMrgrqJXpioD0h.3qdjZi67RSn4om2fG7gUNaLPmdxqGA2EtxhCzj27C48eK6zbAj0I
 arVzQZ7g0dPu1vj1htT7W.3ZMpFNeqD5RJiQ3uKyY1NOHFOLXLQ.vAzVoceCahmjxxKELQYXjViL
 XwN7no3YWAQ_QyoPFt3Xuy3kGysirk5cfzs8rBH3lT87Dk2ZCA.8NlNboRhZNwEF7XS7THb28v5U
 ANuG3bSxuKgWu3GaW6XcbmWVeOP9RIEjKNL7qknCM951CVRghji2LbjXPE3N8S35NXiPzPGzIbT2
 kU2KQ905jrzbQ_lXy_Y420hdaVHdlOssQZvPLyjwtJjXTx9UBet3sb59ua28EU7kzl3si9q1es9Y
 MgGXSZYMAsFhDsZd3pGchjtnCMQZwWKmFgl_cZE9HEs2yjZ2bqc_n6352AeqH4N8hipJ5AwN6iBh
 aHF7Dme_U1i16yN.HPaRbLOinilhMIOoZ9NKudkzz119UJGqxeibOTJQssWJmCjaKBfAgfExS1OL
 U14HOOC.264AGk64YL8dTl0keWA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9e07d5c4-3b5b-4029-b31f-209175d0a2ed
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Jun 2025 21:01:15 +0000
Received: by hermes--production-gq1-74d64bb7d7-f4j4n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c2f63bee58180d330568dcd5f1b3323;
          Tue, 17 Jun 2025 21:01:11 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 1/3] LSM: Add mount opts blob size tracking
Date: Tue, 17 Jun 2025 14:01:03 -0700
Message-ID: <20250617210105.17479-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250617210105.17479-1-casey@schaufler-ca.com>
References: <20250617210105.17479-1-casey@schaufler-ca.com>
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
index 5bc144c5f685..9741c76e4654 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -122,6 +122,7 @@ struct lsm_blob_sizes {
 	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
 	unsigned int lbs_tun_dev;
 	unsigned int lbs_bdev;
+	unsigned int lbs_mnt_opts;
 };
 
 /*
diff --git a/security/lsm_init.c b/security/lsm_init.c
index c2ef4db055db..26c9bdd5f851 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -318,6 +318,7 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
 	lsm_blob_size_update(&blobs->lbs_xattr_count,
 			     &blob_sizes.lbs_xattr_count);
 	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
+	lsm_blob_size_update(&blobs->lbs_mnt_opts, &blob_sizes.lbs_mnt_opts);
 }
 
 /**
@@ -459,6 +460,7 @@ int __init security_init(void)
 		lsm_pr("blob(tun_dev) size %d\n", blob_sizes.lbs_tun_dev);
 		lsm_pr("blob(xattr) count %d\n", blob_sizes.lbs_xattr_count);
 		lsm_pr("blob(bdev) size %d\n", blob_sizes.lbs_bdev);
+		lsm_pr("blob(mnt_opts) size %d\n", blob_sizes.lbs_mnt_opts);
 	}
 
 	if (blob_sizes.lbs_file)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b00c2627286a..88cd1d56081a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7160,6 +7160,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
 	.lbs_tun_dev = sizeof(struct tun_security_struct),
 	.lbs_ib = sizeof(struct ib_security_struct),
+	.lbs_mnt_opts = sizeof(struct selinux_mnt_opts),
 };
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 46ef5ece991c..44bd92410425 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5030,6 +5030,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
+	.lbs_mnt_opts = sizeof(struct smack_mnt_opts),
 };
 
 static const struct lsm_id smack_lsmid = {
-- 
2.47.0

