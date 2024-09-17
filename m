Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A49191F78
	for <selinux@vger.kernel.org>; Tue, 17 Sep 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726617231; cv=none; b=SCUtIGYRiOIHgINisynSmTKOWqJSvnyJAKvYRVjZNkXZGcYkbAk3fO3lL1CowBN3SKzSV8Qoj6h1VQqEoRZJLPIfFdH2BoxO+Ec2iD6V31DbiSipwNI6R7sr22ExEBa04nSpnc882yN75gpQp6QXM0MIBOyY0jH0djqURdX9mMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726617231; c=relaxed/simple;
	bh=0ubI3dLuiFvQb7cQkSFUkzrhPW2VRR0XtYlRe5c/A60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/RsRXygtAwWP7TQ9pIOcwSHOxkG2UgMyUkMZg8T4jgQWgwmLP2oirSuUai4gv/HAb8n5NoiKLKqHKJ7y1wIqM0b8bc2YYVmGQMqlyqDla7EUethT6ylGBfSGTNQD8usX+AFgo7uyTm9yBlJU7V42pAeShtmpVbA3g5X2aTA9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WNu/t09m; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WNu/t09m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726617229; bh=j5lakjbtg6bbgJzgWkUYPqrQ2XuCHA+KwbbiISmMicI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WNu/t09mU2N8i4PkfTkEorYUtEYxQNFyyM2ShL7vIjDgCXAHd9DabnUMLYn7b8YOkY1DodoOzRF113LhMfhbbgw4iHRkK/Ek5wiZMUHH0i5u7rvXXRUyZhQOfL08APHIY4LaDqdHNzLCHIA39ofUAGz/OCTjpMsz9RBxxyYs1XP0r9dhUvS5xPkKEQ2k7yYNwXJafj9ryBCvxHLisnQ8tm5YYw0q3N5yh68yCP04Sy4q6yTjbGg8Ex0NwLpksxgPP28hVUCDOcnDkYiyPTHXkMvcVwEJFwYZLK/PUQi1gJl+9e6o04x7hKZZxk4GsMpQQNlX8WIegXSpwZDPKrOoyQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726617229; bh=Ep+ZvFh/ISGZYSQyDBEElpQcODGAFa1l29UXn8gjXqq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DyhLhibN3kHXKunzSbhQhmdqH6bfH6AAELUjx8HFM47oWAn8KECvLh5j4odUJ9FTAI+1O8xMxS81WBGtxsihLX3YfgCvNNiElxl8a+ffQwoJgHmVA89CL0aP9xiyUxZWNknBDay4JWZBQx9Q/AfqjjbmY1EUfJ8Hn+e78QoRXzuT8HXCSf0IP8Ob3+2QvCSIgIxRj/WH59fJXnJO4HCWCcekAbgU0DF6rrdlhmPjXDmL8d+B7ib3wrqwrZWDvHgTjj0FnDKwqc5t8kwZZC++b1hWuHBfz+Zjl+tZM/juqRMFbecFlfOfXDcF8FY0lc9SBNC4WoJNaPkla2IvG7rkZQ==
X-YMail-OSG: .ZBEx4UVM1nKn6icJg7.3tZY.4kGS1ASyixUXTBoSQBGIDUNvgs91IEUs4r2fF7
 MApKyHx8ptZsx66BFTqbbZHwnoE2eWw1XioGkidXDseDiIuTc_hqu7WOzFoVJ3GMxvkrCK.sCLsf
 IfinirnwhI5cxocxc0DQlUG5Z3AkTWiNoKY20_JEuCkJvuSD3xsXZn1LEC6GGwPv3Rl_ARYnlFsw
 Q.04riznMw_ortdimgsZWA0rjlrAnrYjzoGl67xApDz6tESQPZvnkbF4gPAw1HGFcn4Z3Qxw.NOo
 3WtxwKYiWRkQfWlTXEjJ7YAn9YsCudBc5RIaF26JXo0TB0HUxAy1PVFscYv7cgUDSw3ro.nWPBNx
 tAfdZBvyBAcO4cfldJqyTX5sBKFVO8ibb.B6jtTUaZ99gA8jJ_WRfQb1BfU3IF1m5ZELxJmH87he
 zDhf3UAAHE6Fx0am3xVOsIQvbe8XZ41hII8UhtvvPb4PXhCt96Tmxh3hS5o_0iGzkiDPW7mp4rd8
 oYb5vvf1WTQSgv3RUrUqH3ctaq_FSlS7Mft6sF41omRB9oaD8N0wtIvOk7.nI4iybqqi6w4sTvu6
 lnpl2L_LagZ2ZCPfAhU7R0UVhGLxfBx6g4pc5qRnuTpLzTxhrfTBq3nPB1Nz8UybTjEW63BsHHpP
 EtQ1aYJpFGit9xifV5d5KhtVQf7UCVNYTu7vNOMvBc_Gom8dxruf6TLOJePmv8DQoiGW._lC2w0G
 KIm7_ima60SXdsAii.eP5cultdrdhJIwjGtBDWrN7IzTTkJjahniZLsyxCGx_xpPnLRTPPFXWJjm
 NPoNOzZRC1V_2fNf527j2qoRxdSP_UUSMbpnVuvCBLULQM_c5jVmO7AYxFuCm8TeC3Rri7e3Hlun
 NyM997vYTY2K9fjrgppLDMcAGgZ06qwQaKRCSf.JwdMpT7KAuuCMJljSU5fnN3kHVMcw1GWHrlLg
 3LBPz3LxY4wSLe3PLg7Aa7V9Se7LjH_5uLt7Lo.HVlXf9p_XahfUMMTKIpftuB6iUSi.PD3T10Fd
 VfUnMHTWddWLifCcprGxR_fcPEOBphuydfWAO1d77ulkDBj4hVWiNGPJyEk946X_c4q7niCm7qnz
 05zPForwwaq5TC6MHKzxSdhRgzbGV7LjBmcr25nqpGD7MGoUBSuNgvqucP3w1PSKZSrl2dPHQPT.
 qfAMVaSv5SHctXUeuCiIZwk6yWU.TptGAEKd._ibmVh9Xx4LOgSPGvDe7HBchdheL.sInZc.z2si
 lQOu45ztX89mWONGE8HwSPDMNdfS_5qZEZiOOJflz0NzNElF7CRxj7FvVBp9BpZkEpUioz8QpPjt
 qnSh.3sxn3XQD1Hg65N0BCnWY0.BKunWjJu9j3_.Y1A6i_c6FjSTGSGK7pDsXdx6mzQzHpqiolTi
 AkU5aLWQCap_JB.SBSEEbLEjwJKzCIEMQ3XgWCwmLfUYcyrYauJIy4dLGsmPB_Dn2ZcdfDQYUl9W
 Ls6z74vNWoEOAvdFcL5je3SV9VFx7FvJPDUyXSakYo24B3oaUVWtLC8_tTNZwJny4kZfzJecohSZ
 gNMxpsCbj63W_cKOtF6IvO9SkGaWjtRvbTS1hY__Ek1Fh4zcZ3y3sMyoQWXcXSVg7yj3YOTC94Uf
 8FGuRR.tS1nkRUJyHoe8k6Jg0YWbQvDjPnWtPZ.4QvDsoFru7c1h9GmpiC3p_JizoA6RSRIjIOPw
 adHXzFpYl9FvqKde3uOCQJe2yhkGrYrfUBFdm5GFQ2R1LduaAeAxr7oQ62dVxyQyPWGSHO1fiyWC
 YvXmB19VeHIJ9lCbDfU_mu1eBQ7CmvxuOUU5Nx0V_8.1oQJXx6.xIYJ0WQh8_kcsbl9n93TQJ6Xi
 qucWg8DcsbjUXzrAZWydtDdfeJNRBKGIW13GlbRl0fcR.l4Xp88eOon2YuHYpub6hjbsnLaBH53G
 PqgQz6ylFeqRe_zQ6Ee0FpAkCIow3iGP0EajwXTBm254kZgotcirP8lDWMPuEu4xsgBETd0p40aP
 Cn5hT9ztY3QMrHsXIfQIERx4kWobIZPfXVlhdmNqGvcfNADhSUqjjsmmmSvU3f1_6AqZz5GkkVCS
 5mbUDbrosrMaXoztZfCQmHXL1ztj6Z7YFnmPY1ZNRiCzOnWZK9HB1pJUli_jkDuHTeP4lFGHgrbP
 GdPfU83AmkrTt..I6ww.pA0fpqd0W027HA61gfOOFGi91m_ouvvXqy2NoAy1oVPs7TOrFnXpdl8e
 s2noqDsEjXTDnhb2_P3OZBCIRoUC9_yUHBaUvB_DeY2hY5tXXgRp4HWXIXK7BHmO6lWpc9ixvUJT
 tmx3PSYVvod_TdTROdfxAG3OVmfiY5GMBUQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cf539a59-42e7-4664-afc7-13ba7b38f727
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Sep 2024 23:53:49 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 41ac41609d6122fff099bda257412a4d;
          Tue, 17 Sep 2024 23:53:44 +0000 (UTC)
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
Subject: [PATCH 4/5] LSM: secctx provider check on release
Date: Tue, 17 Sep 2024 16:52:01 -0700
Message-ID: <20240917235202.32578-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917235202.32578-1-casey@schaufler-ca.com>
References: <20240917235202.32578-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that the LSM releasing the secctx is the LSM that
allocated it. This was not necessary when only one LSM could
create a secctx, but once there can be more than one it is.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/secid.c | 10 ++--------
 security/selinux/hooks.c  | 10 ++--------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 5d92fc3ab8b4..974f802cbe5a 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -122,14 +122,8 @@ int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
 void apparmor_release_secctx(struct lsm_context *cp)
 {
-	/*
-	 * stacking scaffolding:
-	 * When it is possible for more than one LSM to provide a
-	 * release hook, do this check:
-	 * if (cp->id == LSM_ID_APPARMOR || cp->id == LSM_ID_UNDEF)
-	 */
-
-	kfree(cp->context);
+	if (cp->id == LSM_ID_APPARMOR)
+		kfree(cp->context);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e56403659164..93188e124f99 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6649,14 +6649,8 @@ static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 
 static void selinux_release_secctx(struct lsm_context *cp)
 {
-	/*
-	 * stacking scaffolding:
-	 * When it is possible for more than one LSM to provide a
-	 * release hook, do this check:
-	 * if (cp->id == LSM_ID_SELINUX || cp->id == LSM_ID_UNDEF)
-	 */
-
-	kfree(cp->context);
+	if (cp->id == LSM_ID_SELINUX)
+		kfree(cp->context);
 }
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
-- 
2.46.0

