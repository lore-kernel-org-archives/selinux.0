Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D95293C5D
	for <selinux@vger.kernel.org>; Wed, 16 Jul 2025 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701279; cv=none; b=XHHDI55dX7UZVIHuStZ0N756peuZtR/nn1HUACmsHTqg1ju42P3VV4hZ0KRu05PWNw0ulFNSZWA1yHSAseM66q8Z66HMbohPFqm3irxlrP/0719l1KbPm1HpMfBaWRtkwgnMsZHOyafc0GoBww6Y9ziYDIfBMtEoMKR3IWR91MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701279; c=relaxed/simple;
	bh=IfyU0SLKhVx4/evH4GZoQneZPuk9OIpaNSSabTsfFxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1Uz7XgE/X1fItdC/HYqINDr7Z3GlYH1dgXKetWP/qrScGC0AKlfM11Ie6WGnaFHyoxnOLCCFr01tVQ262OB9lkv4w2RYWoWSaPMmibUoj1S05nk/dwmCnVAYoYM4+o5IsTIhsYyiV/TJV+JX0UihgjAB+16jc0u8GS8sRCiptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Kxxbz7fI; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Kxxbz7fI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752701270; bh=fY+bnHMn1zvihdkur8/hjRqH2qCiWCld0D1nWQRQIQk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Kxxbz7fInwqhEncw1wMSRN2d4z8148MoeLl4HH0mnBkbeKh0C4QWAR6O7aNsC/d6sZHT9HVxF/W1LD4r4IAwRY5dPzLCbzYSRlE8zi5/u1oL5XxJLtVE5MVslpHXAjerEs6Le6VIKJ6RTMUrjw27VAg3+v7clxtN/f3vgCD8hOyeiGe88GpBJCav+XcyxPMnZqt7FDsNSyeLwNIzw5gtH+yCuX94tnTqh/ZUY3WvLPpgbIyyproAzZrwv6k41XU+dXZ30nPut/tC1VbRuvM1yys12BdLAbSH8VkZ/6PCkpS3Ny0rPqHooIMdgOgHIw2iAZcT8I2NYW0T/v7KtAjiTw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752701270; bh=XWw4RQKrJlSQmojGbBrn+RIY6RgV6fuNWr+7WRs1BE+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Qa3vOogCXE5kxemlbAa7p75ehBwOWPzXPUvLWXZgc4z1gFBGcaFf4GnZPLVd3xAu/JmiNZyK9QoChgvHnkKQB/Y0hREOdkwcWPjVlBi7aG0At/5AQQ5r2a/EAAEC+Yp70MHO6JNF2KmdXQ9D3qc3ttwcQlF57daOIfzvahSmaaGd7j60npjzGpiM6B0VF6GEhqsH/QPagaRvTtUSPrWLsiiH7KgTEUUPiMjS8F5hDx92Ln56pGBiWIMTJBxGLFZW7vTZ5LUqS0Xa2HOwCMU+oSKvWd8foLuiJrt7PpcFUJosV6JFbfdoLTOH2u56knircPWVtCvNsztvt2p+WiaDCw==
X-YMail-OSG: 7uyrqB0VM1n2lxuIBhWA4g8gsFsaRco_JW3cPRz2_CoKoMoxH.P0ARexOOoCroo
 LSa8CpkytRxgUSkLOZrhlU_eKpiD_nQGixghrVop0f8Ewu_WJtJZn9bt4A8r2xA14i.c3AJxYtFT
 5L15r8fuhBC.RcEts3gYrc6EJjoGlWDbtaU5yV4Wv5hXYIf7mM_3FZyzXbBPFiAdPXK08G1Gs1Z6
 R.deBU9u_soFQYouI5pLrh9Bq2_cV4NsOQ0bxeXgaqpkJIhYuu4ML3bbS_pC3PsnWd2feP7D9b6L
 UfNQF4qrFNDRRjOj2kbf8Iyl6e9MOundxaa9K7KQb9TfTkTyqmjrS7A7nkzmgGUsokp5tEht1U.t
 Q4HZ86lmPwzV89HXMD4IEnXT2JQz9TuXRruOJf9taxwx14TgFmBUJWVOUE9N4uhBjK.AcmJh6etS
 6qh_AJG60xPq5bUw4KeC6VqZ8fLIJDBR1ylFKZcDsGTYk2RDyXCrviy0XGCtrcpMoWjaSUW74fdJ
 ApL7_nvh5ujse3N.wB8ISDUsY_QG7u3SiXgF45Lb6.KZijhxFGxSG0DPuj4JZpAMIDSMYDsT8shu
 D4KGgeJ5QPkC6t.74W8W0sql5VP2.9iXIbhUZA7NIMDOzmN2h11mDpZETUme01aYeNsoROh1hmim
 xr90wcMuARSLxjBqqXf64SJz3IRI92etQrSKlJleLRGFdx8D1DVgRy7wSEmdvQI0oIYKhB.m_c6X
 EGvEOA9JNqiCGxI4bLgk2WluwH3yEU1d8afeXGcWwMeMGYzYeMhC3t1LX_gB2EJYbBngoW236vSh
 slCy3yXBUVVGgOZZj3yHP8eODrPH.mvvdGFYpqI761ztvPBqQwYbB1soCqV7QxfUNxXsHGMH6W05
 0dppPTppk9aNWGQRC_p.Slci8NkI.Pzw1e2UOUWxddRRnnddqE4ZkhtrbtIX.i_ZgF8khcViWZx7
 qc8LpDtgSwecfU9G10nDLHixISyy3txVvI77YwmrZMlV7wHjT.svM5fLXxvYHAMoJLeCI0SU_hUa
 hFL3VusWAvPY9eAjjGErqsE3qIESMmRPf2wQdStKYv.Rt4ILK2nrle_mhZ740VPeec0Z.eSW50eK
 fKiIjXyLMpAdx5pF3K36zpnPX4OWgjE_M4RkXC6BuBv.2HQR.u2OieWCFZpMbPMtAiLrS9zaPV8l
 PJSS6Z7mWvfKsvRuc2Kh6L6_BIE3qEU87amZsMr0bxx3im4aDYBmY.kkRingW6oSZpxs_46cKFI_
 BBaK_7pY2tczJyUN8bF2bt5abqa1gAx0k9.qFd7NNTdZ.GLl95ESw.5.L5yTsfHc5HZwxijThBQ2
 Ifm8AF1eHq.iVJIp6Wx_QT.l0RMYApdRug_2gyDFXjvHqgJY2mYAdbFSujP64RhLsft6c_eguEVC
 0E7ZV1ayQUoO5qFftAFxhJWaR6j6Tgb5NHCZXltPxFNAacIQU4Brh7Ufpd0cEd8MMsqj80q_rBuI
 FikxgiSlLce3c3wGy_QyMffU8lDs7eemSfjfxclbjk7WHRojCfC6DtMiRDTs56mUIonXz63pktYA
 96hkEv_uY_saRSxc0TK8fQ1V0EzdiYsb9xfCwl.lU1hLcdMIiNgHsKSJKAhqiZUBWGuNRcRI4Vu3
 gBt1.M5I_NKu4CRKw2n.X5IOQnDl_3oEpFP_ZXZ4LtvQCsh.R2d6M.Sdpn1nq5lvzAI9ooJadi2j
 Bqc8wNHlusHjjrNyMv.Qy4O8tbUNaEV6rkjAMFJmewdVTECJEivyvKfLBrmkEtz7fPrzj56hF9bq
 vC5iIrmTMLJ8u59NZznItykf2NE6wvkSS3FD2xQYhLjkh0J9SlFjU2MFFUpmhGBI93iisWGTLMvt
 AuiUs.EaBFvUe1B00VYpmp76R9IiWSXMDWuvHhEqMViVr_ipGD4qm6auO8FNob71__zX2.yFSgM7
 mPCWXovjYriHKB3MfXFzfOBiSLrlrHh2sYUwjxAgQ1jZNJHb3nN2McNAppzz6gAPMqMrquPEnwbK
 QhUEn0911u0WrgIPk5Rz6SuQ6UDOn1Eg8ILFQ6bgq2G6zWTdr5Je.aOzNSeYOLmLHLZuKPSz..EM
 T8wauO7tC_4GCudlee21ecmX2Q4CxMpSNK10ftFEMNKqDZrox2EL.eVw2E4JXUieW8k1mxS935EK
 hXPZR07L5dg.qnG1GW1xrfXb40x6sLEp9EzzhiU74AOSLqGTFd5Zq8ZPWaQ9OnB9CJB7gEppB4SZ
 .eRGQMsmsd8QScUuS5Nb2od8KgkXGVrYDgpJFzLbjPXUCvIkigVI_EQZanrUS3AlJEtQvKriJF8V
 asXePs.FFGthVxltu9riUFZnW2T0mlw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5eb0aa63-c714-4118-ade3-392e838390ff
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Jul 2025 21:27:50 +0000
Received: by hermes--production-gq1-74d64bb7d7-lbnk4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c82aa99504a499c14c18b1238d973034;
          Wed, 16 Jul 2025 21:27:48 +0000 (UTC)
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
Subject: [PATCH v5 4/5] Audit: Fix indentation in audit_log_exit
Date: Wed, 16 Jul 2025 14:27:30 -0700
Message-ID: <20250716212731.31628-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716212731.31628-1-casey@schaufler-ca.com>
References: <20250716212731.31628-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two indentation errors in audit_log_exit().

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/auditsc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 322d4e27f28e..84173d234d4a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1780,15 +1780,16 @@ static void audit_log_exit(void)
 						  axs->target_sessionid[i],
 						  &axs->target_ref[i],
 						  axs->target_comm[i]))
-				call_panic = 1;
+			call_panic = 1;
 	}
 
 	if (context->target_pid &&
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  &context->target_ref, context->target_comm))
-			call_panic = 1;
+				  &context->target_ref,
+				  context->target_comm))
+		call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
 		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
-- 
2.50.1

