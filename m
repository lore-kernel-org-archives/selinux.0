Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D22586FE
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526541; cv=none; b=axP+oLZ/cRNQ6/tY+pQK36VXqU3LJyzWvZPJ60yH7fQK7x9dEPVhFwftM77yblQOoCc+DsORY++gbPQLRDIshxdX7SSsRoMWiN/nh4MM8f8/Q0rzLO+BcyFpAaIWbM++n4KEdOjrQX9r1LBpNMe2hQIth4VtzMHqx/POosq9Rn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526541; c=relaxed/simple;
	bh=J7uUJzI+DyUy/0s3Dwtgp4wm8Zo3tkjGbsf/RH4nq4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOvT/HgzvGDLlVNzJ4RC4xO59fd1BHMpGBXoKRm0kAy39rmXOS5sjDKn7FyK0Xp8jxZkWfOC9vOUxuAl3EJxjC3h09XhOn8QU9VXmkpd1ts6mS+uoAgwTyspX1Nq+isWvKGfQ/KAkofl9Gy5cWRP1KIPUarsNOchrnfW30yO60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=l8KyckIP; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="l8KyckIP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526539; bh=Y1MBhcJxNgXqSKEpTzfE0odcwfmPXmVNep1TIM/mV+A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=l8KyckIPwN3lSwqkkMwUVSuUQVmpFYPgbNH3OEaCHhkU/bF/feBWtaeIUroTsjdt+O9Q4dnH+AMO4fiv8NANqTsAwJQ48ta2GZEJ1SjZkM1ueTujLDza+QymY89mo2EDvP3mcjFGGJK174mfLHh4v+xJIpR0D6HRgeARcF4ykfEAzcb1JN8Kewv6UpYRjug7Tx6pX2bt/E2SlJCiDEipnGhfGVFe/hDzlxpmTnDbIkPSPGXKvspwtrQSCVapHSVItZSrketk01Ier+vtjN4Bs1c6pl/LJSWBU47ALruQ/Tghmj2pSsRB6iJm+KuuVD1cTdjhDFO/ihrdRBi167Oogg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526539; bh=SdNviW33BgwdNqMIRz2/oJb4GnfVq5bRDheKk/X8w1Y=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=TF9ZosF8oeyj3loyBIE8nRoiGkhad8g3d0GU5Olb57BTRnwKcOst7YcMDkauT7VDPwPnMHlYX3tD/z1fYVEaexXvQejjATEd2jKLGzzSQJRHMjoK6gKdyVFyPqwEDfV2Vpumd1KlsR3QWEEEs/Kkd/4WXTeRHfW+lp1fwVT2rBiOnEMtbOLn5UiaeDtR1NgaRxmQBejjButJC19RoVMma5Y77yhb93qCYJ69Zj+ehhI41GFkKx9myW7e3u6cjjzzn1aZgtHZ2x9bsn+fniu8jmoxGus0AN0LYOwrgEUR/lpfq/hjcstcZ3HsrZhEDAkO8bT5dqptxbrIC2mlk1VZ0Q==
X-YMail-OSG: LzGsyu4VM1nmlNCBDsMlbzaFQO3f4.Ip5J5llpfsbw8P3CI64Myyy950WLOJitU
 heYuJ60dZho3NUDuGrdzcBLuXuZ32pfnH.w66NN25R1YqAHntedzuTAz0SeDxGAUfNupYQQ_OA7d
 Ib6qvjUjj9jhXSWgoayVmHZE.m7GuBZ7hStuXb9Lk_BElRg1X3JuylffS4e4STbZLpZiJM6OElp.
 9LkbICq5ux4__mctAJQWnTkT3w6RdwRdwuaZbbLHv.QVdQm8VyANXrCl5.2u_GL7k2EqftKF0j1T
 qIp5bfTkWwnKqWojLPxsKVSRpTfhD21McXnXrrZDOTpTN8EkVdnE8L2p.Z7.rMR7LUGTr2NBxsYw
 ol7pvOri4JF5BkSMES7RqkNDax1b5UZm6S2bfzDXMYQ4aCdQEMouRsinfgsLDgdP7pt4Welw6h2j
 gJNeR1Q..tjWJqRRO6F2IUmMRFaIlXLrcDyGudxYwqTQ_IE5VrjJDb3dCvycmp2vhR13sbzOdXYS
 _P5i9lDu2015f3w7WlRBcvmq8WGr1dpZNnt3dy9ryX0C8bP9Yl.7XR9OZv1Es.yb2Z2jM15NUkeD
 Vp9DcUkzljqJtbHq54xEqH4PzWDDEMkNnXzSyvhR0sflsb_5OSSBBQUkvQBc5x4aGxOrtzgJOGtJ
 6VM1pZnCU5oC2EcZhhiZ_zpX6_pt0_uqJXiQSrkNNx7D2844RzzGOBrk1bxp1VRgoEjVWjRuV0es
 0ppEVvdxH57DYS22PCdEP4JRbkisbHpTjCoCH.OrAU7dYhRGE5BRt4hlcStEmt829vbtJ_1qUjXd
 e_TtHp3oCwyXOMY.S62FOUnrmApX7a1i3u.yGFBvrSZ0NS7CqUN9sJi.O7ynY_NV.3cVvImpl41r
 hM7sBucJ1h0kENeDRpr4n1vft8Pe2xJP3zNPTWiLOg44tQ_hZjbfgNsNv6mfYyvJZo9seTHYKiMz
 DO30n5eQHUsnQnTIMdKdmvTupDaqBBNNzJJCPgL0xrDlb4whOPYgzdCiSy8lpb.Ixz2Z67_awZev
 eJ.gfNX9cm0h6VoQaTCE9hpXE.yhR6rFuAKnrliec5J3a2ozR_L1Vr0RfBvMufE6Z4xA9hhlLdBg
 UukwSOBQKkIcQtNF3_xE4fpc2kPETaYsv9YUBBW_BWz89WFM5SEa.6hmSFTjD0lqaeQxfuLyQI8B
 1zG2X6GS0QBPHmragRKsO4J6I8T7vcvzZH7EtDJK1QA3ibmZLuZrrxdZybbwrWgY8SI3DBYDjSeM
 tSoVNAUh1loAJJvUp6adnbETa42XRfwKcvRSTrYgobrGqbt7AVudmT6gxfkpCit7k41Z9Ekz6N.P
 gcEInAcD4psbOpxEsQo9MdMuVROLpggfXVGI_tiLfkVMVKfuC.AW4Ge8l7CzktH9TotwfK.5DMat
 G3.7WzrvdLW21VlpV9erngBkNm8JW0gvx4BVNdWDulLs46ABm1NPXS7HnXYzYobT3ed_CLm7ispb
 pBGFjQhqrbgD7mvX0i.0aCu6p3AM3P7K5bQMXAV22KHc8hLvBmfC.Hsu2WNgALYobjZSFMY9Gvcl
 kdtz5_uQLgPEb.7yEIUdlgdtjy41UGGsDQmNd4kuAasvT2Cnnifi0vW2FtCdt8UPJ9.g3kcAXZlp
 DwX0YP3jR6117tvKl6r_V.7cuvv_swL8xtp1oEldKa1M_fYf0vBfl_T9RvLkGfwEfa.l02IA_U6I
 eXJPLCvmSCld3chBfbLX7BZypcv250OqYIbXVBWhXvTEZzDAFG_vPpdbQlCWJozs0m41eo2fqCDE
 eVjrcuoPdlAh7SuvyUYGFXNoo2pe4TIXjVpKZw7Ux8aCqJrRb20l4kWKdztaN67WZQ72bfErJxqB
 Ns75jkkSRcfpk1R7Dz_woGnWbDMN65a2Q2QMeTFnlwj4pa86tSZeJlpiSx4HQeKAsWA2FKXvRIVG
 vmf.j9WIRnlXea0B3pGCs88fR0Q5wyl9aTAYq_Ku1DM20YuOhW.qQnM7olfODIF_7amte51.I0Rd
 tWU2Us6e1MYkZyR2LdCcOOGvQvVNwR3paTXJne0I0wc.XgJf0AMdeq_CcI8LlB8UhYqVRZJ_gx32
 Tx2SDZaRZ7Kw2J30nRzYa6owo4yziiZJI3knVUBivfvPVIgWy0jzHSLX1Hg7webvLSzfYkXIInts
 lRJ9bk591OURFqDF4a8cDhhT.VjuqTf47a9n3UL9InjiMQOke094QVWO4avJPLpzCLmH.9kjgB5u
 I_A4bn_Fhgoavyblf5W9dS4HyhuZRqiq5ryAG2bd4i3e1ifTNejvSyNNUDKUN36WHDtabmYeNXTe
 dl7TYZUvScv8vTL.lxZxlrYhfeT1JvbsxGSeO
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bf334de0-969f-47e6-b08c-372df8d94efb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:22:19 +0000
Received: by hermes--production-gq1-74d64bb7d7-dp9cd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID be755b04d481595739dfcf42be1b4c68;
          Sat, 21 Jun 2025 17:22:15 +0000 (UTC)
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
Subject: [RFC PATCH 10/15] LSM: allocate mnt_opts blobs instead of module specific data
Date: Sat, 21 Jun 2025 10:18:45 -0700
Message-ID: <20250621171851.5869-11-casey@schaufler-ca.com>
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

Replace allocations of LSM specific mount data with the
shared mnt_opts blob.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  1 +
 security/security.c        | 12 ++++++++++++
 security/selinux/hooks.c   | 10 +++++++---
 security/smack/smack_lsm.c |  4 ++--
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 2e3b1559714c..38f89762c0df 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -220,4 +220,5 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
 	return &xattrs[(*xattr_count)++];
 }
 
+extern void *lsm_mnt_opts_alloc(gfp_t priority);
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 93d4ac39fe9f..98a80078b2df 100644
--- a/security/security.c
+++ b/security/security.c
@@ -901,6 +901,18 @@ void security_sb_free(struct super_block *sb)
 	sb->s_security = NULL;
 }
 
+/**
+ * lsm_mnt_opts_alloc - allocate a mnt_opts blob
+ * @priority: memory allocation priority
+ *
+ * Returns a newly allocated mnt_opts blob or NULL if
+ * memory isn't available.
+ */
+void *lsm_mnt_opts_alloc(gfp_t priority)
+{
+	return kzalloc(blob_sizes.lbs_mnt_opts, priority);
+}
+
 /**
  * security_free_mnt_opts() - Free memory associated with mount options
  * @mnt_opts: LSM processed mount options
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c86b430f34c3..8e0671920e3a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2809,7 +2809,7 @@ static int selinux_fs_context_submount(struct fs_context *fc,
 	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
 		return 0;
 
-	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	opts = lsm_mnt_opts_alloc(GFP_KERNEL);
 	if (!opts)
 		return -ENOMEM;
 
@@ -2831,8 +2831,12 @@ static int selinux_fs_context_dup(struct fs_context *fc,
 	if (!src)
 		return 0;
 
-	fc->security = kmemdup(src, sizeof(*src), GFP_KERNEL);
-	return fc->security ? 0 : -ENOMEM;
+	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
+	if (!fc->security)
+		return -ENOMEM;
+
+	memcpy(fc->security, src, sizeof(*src));
+	return 0;
 }
 
 static const struct fs_parameter_spec selinux_fs_parameters[] = {
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 956dce6b1e97..0cc24b57bb52 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -622,7 +622,7 @@ static int smack_fs_context_submount(struct fs_context *fc,
 	struct smack_mnt_opts *ctx;
 	struct inode_smack *isp;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = lsm_mnt_opts_alloc(GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 	fc->security = ctx;
@@ -673,7 +673,7 @@ static int smack_fs_context_dup(struct fs_context *fc,
 	if (!src)
 		return 0;
 
-	fc->security = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
+	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
 	if (!fc->security)
 		return -ENOMEM;
 
-- 
2.47.0

