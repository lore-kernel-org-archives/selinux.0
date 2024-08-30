Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35D71D1300
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978858; cv=none; b=u4/tL0ydIt1MQTFpg9RSwjc40/itizkq7dsf7b5oji2y4N9sg0vjy2v/azWvJ6PeBO3jJzM1UHgg/3UTE0xvdXE52YkGU7k0SjN0qiNVk33/+YKF/upbSaxHDYCWinBfA6ReA23EM9xMPbjI6+ONnTWAPCGblqLplOiFtKbCQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978858; c=relaxed/simple;
	bh=WS8QAWly8kiJ0RF1HvQg45anT2QXh0FKMqlLtzIGCcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nanCupGSM1AJO31LRFBas9WLlklQEz+6arz2TrzBYX1qD0wlWxIICxZ/ZHBEWS4rmRS9HnOLZ0jacY2xMccLtO/o7TmONCF1bf3Ja3BLNeTS5DhjTbBm31U1XGMDhUjtQXaoihH8iOhpRVcNQfkDMjLX7m32l75daFs2SLTaWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hQEFA0Cw; arc=none smtp.client-ip=66.163.187.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hQEFA0Cw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978856; bh=VOzWcKc9GRYTzUpdik4/VaiykO3Ylp7IgQbo8C0Nu0s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hQEFA0CwcxHuBUVIg8o2rjzhCl6nXeWGcrJNDaAmS8w19+uXmJdMM35qcl4oy2QqVIu41t5QlWmbrPLFS+b3ncdZi7+OgZYv9X8JzLYrUmbLyNdaY9vdIsQyzlh5DAwe4FSCJSYLpm+VbIKsHt119oHwaOtFyhxMqGZdmVDZosXvioBU2ad39yOts1U3owxISevWjKupYsFxWA2lHNr2ZxmuEjA6PRJ8jNFUQZ7Zdbste8cGQkIE3mQ/n7aUfp4zFkZMcDNo7/6cuCxUL0t2+B4gfqbwnQTXyBtoie6voDuSg/uBlhvtj6JfoZAH1XPjx7j1WedwpTsTW48JyWX5mw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978856; bh=uIjC7A0Qshk9XdHz15I/C+9fOkzyG1PajPLunXkB6Vj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nMwLkj9tzy31B4tMq5JO6Gxm9QdyT3O4rsEU0n5qNIAG9lzw3Lz97LJY3LoxXay/Ilc7pHzZge5AzvAweFzvEeM0+o3BKjIL6mN1oWePPc1eEK9s+cXsH8Dbd8Vtf1yWOdPHAl9FL004w99NPOSUICYLRfg1eQw7CBVRDY9arDpFoCJWxqyB96vP0koi3L+GLxTUOivBV6oNrx9M1WFJrjUiYMyR1jPcOI6zFcQUwQfMYIYbCGvJt88I9/lqCElvIej4kap9sd9DmODfzK3m2U18G30fT0nrlM1bl2VBSwO2NcZmxNWTbVspHCRY/tsAWQXuayGC2mQO+oJGg8AVkQ==
X-YMail-OSG: eCI25mcVM1lmyNy1AuxM_JnsfBPOVyGVl2wrBn4.G0sTT7l_w3fCSR0Kgnfto9i
 jOeCk_NpemJ9zUpFfsnUodsuam6XFtT3NE9LPM1sglAQvFneGoIln6z3jtNa6jEL.KsFDHaxB6jo
 ZiIM8DhOgImSAbysQ98e4GRKSJSOtbWPUfhtcZKkTVdbq0FWCGaGCXPKAp2kqTFuR6ctWQPpKJC0
 1g6A2kRiyhKOcXqhNOW3j6EYeInlG9WTIYclVjufNG2IH4oOByP1agh1rvJ2ZGhLwAnNdXa.dtzV
 LQH8D7c656FJ3KNCXASljWWwbdyE8auY0TP8imjNZXwmPaNRrJyJ8Ogfn_ITY74pLUf6cA2ZQuI0
 fYyTFOvqry9M1RlLuzrHVmc2G24x7wlpwfRpzfQ9.kEDDK5n1h.8wMkJ4Mysh7R8Duc6L8rpuLgK
 6ZEbHRqZQtQTJ4dP3Vz5SFG5R0euKEUerliDoV0qHO.2uk7oNIasnnI5QgfBCEVzdLWxEWbdJb7j
 4qAC_r0F7WL3K6M5w0dWV7JZDuWfAlSe3lKp68a1RvG4MTXeTwPwTvIWYc7c81dEhzetlYeS1l8t
 v4BETvVGeNgW5IhKLlMw7rWpY_XZZied5fQdL1Pr4p7FhIQDPXHvC4.oj7d8IR.HoRQMly0keTJM
 bfK1chk.QzxbsA6hEi.ImJq4UQ_tlHKNb3rG1Ms29TY.dpM3yw2bhHmWLnw7w7NPNq3Y2T5tU0._
 c4XzDYOTKnxTxeHFSGwYce1IybopkEUOXaKF4jrlBfcwscbjM4FWiqO2ygoFJZOF3j6ui.qeIf8k
 9fUatAChBNtpiKfziaSovCAk.Z99mWR64KlOaF0q5W_80TSwus3eqUFICm.CF1XJgukOACWCThc5
 YzJcueYK4D.4mIjYGO72B_Q9SSH4NRT7jjlbBYvBzs_bZRp0letDQVxtw3YratzE9qT6ztyEiFmW
 MH9nDP2lf3_Q_ayXu4X781Veedc5jhoAvW8LYWzpVHncyQtuJvB8pjkWOQJU5QSfJdJ51J55V3o1
 VwStyd3gMT9XTHqCaVB_ip4_wehn9FklQ9Oi3Z20Uog8enEw2Rgu6oo3sKDfngFru_x5ENQrOHDa
 TI.YrYSR69pAbD.UTye4IN311R6Hshnt6LOrdCh8vU2fSC0KFmlmy1vt3DOqIgVyyI4ufq5SozwP
 aqgAfpn7DaqQBWu9HXNNdgQil3hbYysUv0Wcc75X3FozcOkaFwjS8gT8rRLsdXs0AAFyOd50sl45
 4QZQ4ctv6mwroNtMoXi5GbI2E.5T7nOHjsrg1A_wfxagK_qdV4I5H9xoVMZhnPr0ZBFS.ZIypp6_
 YJKU6IJX0zQvGESLuk6xb2sKP3KXHN8LBufA4C6HDfl_JVZqW_O5xUM.P5.TJyv5O59AP55fcyNj
 gDdXbEwD3qsABf0doQP6knp2O.udqimK9wRrkKbcbpsFPlua0j6b5H5GO3HNO2i.a.NJ.brCUXqr
 39TTF6UG74qR_A1CnnkoJiMBeQ7v.Rum59xVOWT55l1e49_DZmHo7_N_ly5Bo9fOAGcRAsUu2QMJ
 AaK3Oi3XSL0oLfUL2MdyQy41RCBzgOLGTVQmkTh_trIxAs7gjMkLJ0DtpSEu4KrExH_4HDdnyOZJ
 5_3YhDaDBq00tBcGxDX7naED6BOl8DPMkMGB10KmXU_PBc1I0jLmzVYprGX8VcgKZx61y.HgHCfY
 I4E_Fii4.NmGsOVyD0piYmogiLlNWYN2z0D37IZibyFfOxJBiVeClovu5ZJzWK3ruDE7d_SAVBOJ
 002iupEPn.Rc5s_AvbFmmgDGoILnGlNrdl5mNYTwK8SEyrkL9vx4JQ_EcZ9j2udy3KRSgZ73SxFC
 vs2.Ox8Z.WCrLZ2sGWTa8EV6bsLpTOCZB7yOWLiq0mWfVsvRq9qHOuKHIliz4tLSCnyD0Lk0zKlE
 yPXMKpTuL7hMbLpNbqEyZ05Cc3x1vj_8ykZ_LnSRkFg23pWH0b5hDnvziVF3czgdZwOzYFQvlm91
 BdGLXT4lnu4sQ01HlYCmzz62Nz8BYrQmsvQTOEIFFbKLW7au.PSPpnyad2NrpfLlA2snsg4UJp_S
 XM2qX22e9R8Bv06hDP5ZIB0_P.cAtS3uREnR24cAH0n_ei9WwAwIhnPESN525jDcIRandNeFi8an
 BAYQNX60LQsM.UFdmXbvLbnlDvjci3EgtYE1Z3oUstRSQASosiUe0kN37.qwquCMmEYb7O8T5whz
 6y7OGEDRv4pK32RiQNY1pBlHrfjW4VHaRWZq4BQMRQNIZO21_barp8xJzloD.xFQTihbuJNaWGOL
 DH6eKRacqdFB_cdIwQfUlVx.G6Sjf8jsTFg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 53548d59-98d6-478a-8812-6e400e37d0f7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:47:36 +0000
Received: by hermes--production-gq1-5d95dc458-jflr5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f4d7fb0b22ad2b46e66df0183031cfdb;
          Fri, 30 Aug 2024 00:37:27 +0000 (UTC)
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
Subject: [PATCH v2 06/13] Audit: Update shutdown LSM data
Date: Thu, 29 Aug 2024 17:34:04 -0700
Message-ID: <20240830003411.16818-7-casey@schaufler-ca.com>
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

The audit process LSM information is changed from a secid audit_sig_sid
to an lsmblob in audit_sig_lsm. Update the users of this data
appropriately. Calls to security_secid_to_secctx() are changed to use
security_lsmblob_to_secctx() instead. security_current_getsecid_subj()
is scaffolded. It will be updated in a subsequent patch.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index e7a62ebbf4d1..9dac776b60a7 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -123,7 +123,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 static kuid_t		audit_sig_uid = INVALID_UID;
 static pid_t		audit_sig_pid = -1;
-static u32		audit_sig_sid;
+static struct lsmblob	audit_sig_lsm;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
@@ -1473,20 +1473,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 	case AUDIT_SIGNAL_INFO:
 		len = 0;
-		if (audit_sig_sid) {
-			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
+		if (lsmblob_is_set(&audit_sig_lsm)) {
+			err = security_lsmblob_to_secctx(&audit_sig_lsm, &ctx,
+							 &len);
 			if (err)
 				return err;
 		}
 		sig_data = kmalloc(struct_size(sig_data, ctx, len), GFP_KERNEL);
 		if (!sig_data) {
-			if (audit_sig_sid)
+			if (lsmblob_is_set(&audit_sig_lsm))
 				security_release_secctx(ctx, len);
 			return -ENOMEM;
 		}
 		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
 		sig_data->pid = audit_sig_pid;
-		if (audit_sig_sid) {
+		if (lsmblob_is_set(&audit_sig_lsm)) {
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

