Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25B1D12EC
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978447; cv=none; b=pYkK8jNvoNgknmhlwQ322lLQ+JSjzhmJUjO7sZl4Regza9B5rqPOuuEF3LHMTpKNhx4Qmr9wMR47X9en3tYk8vEEKUmT49hsXDxCJm3URdC8WitmMxT/R+tCkf8TVwyFpEHDupYXE8+Gs8ENICxXcuBPeLD9AlK6N/E/G6xEv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978447; c=relaxed/simple;
	bh=FL6znwNfNmLTIievZ6yYX4zZUxHKkY23sxHlr1oXvvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHUGHtbaMOYhdpej+aheVOdqPlrhGA3gAoVN4QrZql10/pk2ei8tmvnniC+mb6wK1MqypyrGLD2uPZtnECowSMH88I/Omwx2Elfn/xtcznpIA++etvCx5etd4E79jhg7Et8xwKajvcT7KHZE73qFwVTFA9/T2fH5+Ve7DQkRbrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=U4DfTmz2; arc=none smtp.client-ip=66.163.185.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="U4DfTmz2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978445; bh=eO4eL80ngcC1hROEhIhIXT5qfCo94qcR0hL+3TSmK6M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=U4DfTmz21IZMXHf3yjFvP234WgSNOT6nkgQPhNYbC+RnC/g4U8oqimwoxghe4MNdf4/sLzq0/1RGCoYiF+PdCh0P1NK02evvblfDyLgtlt/sOTQU+KkPBUqQIgueuSZf0Bnf0ZBC/kPeIQ81iXok05laTVqW2nb7OicTjaZqaTJLsYXOr4/CHAPecIYzGhxUUq0ARViUKKp6Aih3FTkMR7/ANvC8oBANUznoRFDaMW1ujtGUDc29rkKASkMbjA8/T+Sjkrix/dbGDmLChsH19lXfWaVWlotjVZ/NFtKWCZYOOrOb8ciyScsOl5tetxBZLj7+LeA/D3Ft/LeJYYFSWg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978445; bh=he0/FrvQBE09nbWTK8aS5XL7Eq2YBhnXLRdRS0b/rtL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Xzjzn5f+eZomGPKxQfIvIk4WXHWWr10XvhXNlit33JV3KFXSvBfAdsrZv1W9OJBX/8g3fOwTHl79qpn9Drn1vAlZ8ZL6B+B979PYvjvTEYghUXegO3Un5V+3IE7YmB2UV0wz78WuI3Np1vhpQrMlv8jN9g5LSgOn6l0IlXkmIINVt+aEZ2ler2qZzfSw/XUt5fXslTcDkRzSfctJEgyquHCJYT45WcQEQtyvqRenly0TcNGV1yznqAYsLtDQO7jp1ivYEnQPdwFpXZFZcfkkH1oiETAzJG5awTgqNTgdJR+E42lM+SmPObDhB3DrmOTz3EgedaNxSwtue1JrOGzIqA==
X-YMail-OSG: wZh__BkVM1luhSvokpLpENVOZndFk2P00YWle.jsjeT5HjRTHXgRFeb12bL34mU
 J4lNlPIhODCp7hRLWj5vnTqdtoM6nZ8ECzP.jybIRso1xSdZd64ii83K.P7xsbAW8wilDrVG9jPu
 RNgtqxXET2eRhnC8zbpVRKpEKYg_q9ds_Tu_yeAXyDN3fUp_VOwaBIuiY1oc.2a22YRfuZZmVPgH
 TN1ePNP_bdUOKZGiQZNaa8v9fux_xlOIOgW0vrJ47eSERY62TX1lsWo5SjGw1hG2boR0RGo1X5R0
 mdHlMucbp0.JRiTZyCNiZ_q2uZQNuD9xDxCuqoaqU3RfUQZo6PR8nhZhwK2au11hWKS7IwANfGO3
 58VHUU4zk7W.qeno3eI6E4EAnwPqGe.Thmb7JxRgalbW.Bt6fuDOj0m82HQDKw.S7BZPpd4Z90cx
 pVIUPyKIWFyzouVevMXbpCmptj6BzIK_oxFWlJTKtg0115wful9sgpFowttu0O2vxXejT5XkpJKE
 BtbyiqY0gh.B_qA0yJ6gDwoFII8w4JeNHr4eidwlsmVdeBmUjyCMAz2MXwZhNuWMbX8DsyApK5qY
 eF2Q5v6Ta6IPpNc1ecH3bjkf5vPiETzw2ym3rmW6GsrpptQ0BsnBYHEuxftzSH7wfihYa.7YnZDw
 WLjem3S35D4tvBOlszNuahdDa2laM33pME0M55o_cW5t79NFi0WqLItMaGLPANHnv8m2q.FIv9dr
 zMnX5kbD0HiBHGl13RkZnqZdQEi_6NRG7rH2EyRiREwPXWEt36dBMlLq7abW0YZqxJLZvhHUHm5i
 JbIjDkk5_YJjWVAq2duKKn7JFbjkwPMfv36ucsDrcAP0vsV9zxXnrghiS77y_bpFI6AIWt1OU7fD
 VyEQ1QCvp5wxU17GnPhXnIf5pRnAUfc5J_ZYKVjpsiWS78NqibvJNOBdotgzNJaGyUaOy_2nPRNx
 .NkUNGStvieDvCvK2lm_rgHQHoNUYtLoDPJh9syn0txNe5PiFAE5awOAaWRKw4nZ27lstQ7oIubH
 SPYbChfiSoZ0uvneLAe7oFhi.2EUwlqksOoXVTwHVpqwVcK2.HN2GWTk42Htegra4u3WI87mbXU9
 rSiwcM8XYXWT16e1bjKNrwAYmE1rLPs1cX8MT.zd9QdS90YBk07j3JB2L32.3.bBYrHbGuLLa_pO
 BQhIewv2lCEK2SxuAAMf_PvFC0Kfi_86_lgjwWSPfQwgfRbgh8wyjcSisDRjH_2y6s3xyxRazOT.
 rn8YqcKF6EZVjGzSu2jLEgOLTTnDnU7E8bfqHB66mWRrTHSEVQxthYiYuJmDi89ywVDS1qrP0aL9
 v6JmnTzxIKPxMkV5iIprc5qyfnahLobM7Hzg1dfusxWHKrC1_bak0LfMi4ZT9hDlQTOHzarz3VIN
 GRXj4664n.GQYwXke60hDHVaSrkxEkDqzfY4rRztudO0JrUtadqm7TrChGwnAymgVMvbgDZJ5fMe
 VLpYfsO4jaZaJjkZ0F_ZvGtzI6NdQQ9F_Gej7QpeHPamXhsIW5Bg040bTKZnXxujO2O3RTXlKx3Y
 KiKtrDCJIY8BiwNm5qmpNqw8_.DIKBo5h2iz8KpPON5FSQlvHsMs6P.ioHaNh.QjabDVDyw.blFm
 urudtPwV3x1xLqZxErVGe8UQobRXMxPP43UH7ZMdUAQ5TQwBI.38EOaTSKdHhzJVezIAzLpHkdvo
 CKPNdmBqvAoQyC0X_ndk2lXtbMfKGeBodGjfkgzKme.DKc7PCjc1uxO72O3omJOEJWLLeV3nR6Y3
 .tLvCLpqCl8i.rgRqQnEV8DRRKtFvA7BgppcvOtmbUSL00t0RFYilVDK3.pr.xKoi152ZjvrR1XY
 q0xNP1tKsdezBMrNsJ1xg2WkjTxA18zFV30dMbXqk97HPRbLuvz48wY5AieK4G2D0rRzNULfqc.U
 1J1oVHqSPO0CixSHkVN0gtAzn8c.wHwnXYZ0phcg1cZxRT5Alz8txmswfCWNXyWkOzNHpPNDNWRy
 Y3q2vjrCVfkHcBSVyxQvxfWL1VHFAb.TawvCxZiJvLwdmc.oE.RmJYlHeQCkEpv_ygYVTsusgVXV
 cnOQcwdSqpPWelyzMh4fFCSceC2cAiHzc8KO.7FGSQtrNLxZsyfM1R.K0uM8U_Ii57vG1gcykMD9
 InlmeUoZEnrVwcaljgix7bvnPJzBsQnrufbSHBVycIwPsTIEv5qHkWQk9z6GaNeT377frlZVfRXC
 EFgJ23pIPFF3ZAeon6bXh1HQM3gHtvPSu5r6Hm3w0YQZwrcXValE5Lt0TPsS9Fa9jqtSKzfMou6a
 t..VSEKK1qrC_x47_0GpWVv_ZgIV9wRwOj_AOyTT52jOe
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3d18e569-5ab7-4ff2-a88a-2e6ffa56d4ce
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:40:45 +0000
Received: by hermes--production-gq1-5d95dc458-dxlpk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cc2d6a8057ac7b246e10bf9aa95792e4;
          Fri, 30 Aug 2024 00:40:41 +0000 (UTC)
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
Subject: [PATCH v2 12/13] Netlabel: Use lsmblob for audit data
Date: Thu, 29 Aug 2024 17:34:10 -0700
Message-ID: <20240830003411.16818-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830003411.16818-1-casey@schaufler-ca.com>
References: <20240830003411.16818-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the secid in the netlbl_audit structure with an lsmblob.
Remove scaffolding that was required when the value was a secid.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/net/netlabel.h            | 2 +-
 net/netlabel/netlabel_unlabeled.c | 5 +----
 net/netlabel/netlabel_user.c      | 7 +++----
 net/netlabel/netlabel_user.h      | 6 +-----
 security/smack/smackfs.c          | 4 +---
 5 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 654bc777d2a7..eb6b479c5c06 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -97,7 +97,7 @@ struct calipso_doi;
 
 /* NetLabel audit information */
 struct netlbl_audit {
-	u32 secid;
+	struct lsmblob blob;
 	kuid_t loginuid;
 	unsigned int sessionid;
 };
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 7f38dc9b6b57..7bac13ae07a3 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1534,14 +1534,11 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
-	struct lsmblob blob;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_current_getlsmblob_subj(&blob);
-	/* scaffolding */
-	audit_info.secid = blob.scaffold.secid;
+	security_current_getlsmblob_subj(&audit_info.blob);
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 3ed4fea2a2de..6cd1fcb3902b 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -98,10 +98,9 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
-	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(audit_info->secid,
-				     &secctx,
-				     &secctx_len) == 0) {
+	if (lsmblob_is_set(&audit_info->blob) &&
+	    security_lsmblob_to_secctx(&audit_info->blob, &secctx,
+				       &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
 		security_release_secctx(secctx, secctx_len);
 	}
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 40841d7af1d8..1a9639005d09 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -32,11 +32,7 @@
  */
 static inline void netlbl_netlink_auditinfo(struct netlbl_audit *audit_info)
 {
-	struct lsmblob blob;
-
-	security_current_getlsmblob_subj(&blob);
-	/* scaffolding */
-	audit_info->secid = blob.scaffold.secid;
+	security_current_getlsmblob_subj(&audit_info->blob);
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index e22aad7604e8..878fe44b662d 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -182,11 +182,9 @@ static inline void smack_catset_bit(unsigned int cat, char *catsetp)
  */
 static void smk_netlabel_audit_set(struct netlbl_audit *nap)
 {
-	struct smack_known *skp = smk_of_current();
-
 	nap->loginuid = audit_get_loginuid(current);
 	nap->sessionid = audit_get_sessionid(current);
-	nap->secid = skp->smk_secid;
+	nap->blob.smack.skp = smk_of_current();
 }
 
 /*
-- 
2.46.0

