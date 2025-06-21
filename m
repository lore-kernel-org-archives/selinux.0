Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD16A225760
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526448; cv=none; b=HN9EYJY4ZHSYVLE/WwnN8lHBFnfhXacKRsPoGHoDt9hYZ8vRiyn8nTrnnix6iC2HBS2ZQtx/rY8OwAFI+U0KlIQaeCJDeu9wLYAeNK4AYmDG6A/5g+fYNqkU6enDkGURkfdgx3Rvnrq8rweZU4SLsvLb+uR07TsALAIKzJ7QcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526448; c=relaxed/simple;
	bh=lXFlHaJ1Z1Ynqo39wnAKbE6gwdwpkl053IT82YXG3P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCZvWuGP7GiXqfxurqjmoLKe0xhSTRgnM5G4UMq2i47h0WhhJD5AvflTxhwr95FNjvc5SOzo7LWWxG9EALZ4El/sbdtgEWkJ8z0J9mzLR0oyimsaW9FeRfFZPUAwg5mzIUQmeFRPuHwgjaP3ieRzgQm36cU4CIL/R2k5DIpy3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=oDim/UIn; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oDim/UIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526438; bh=P/usmRD3xsOrSJtNG8M9zwcTc6TGpwoIp/0pYZ9vVpc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oDim/UInVUuxdh6QGmtMD55WWKu4VAx9k0gBlsF9bSe1qNKHrHlVABRP2wnlyKWbLmkrWLpBakHU3nd+lWplQ24mp5W5wj3RnZJpxAQGwB6VZFqaT5L8IFoOLOAjiA9mM8Uz77Daj4pTZURpJn07ygg3lloloilUCksqF7BLtsI85Zh9SG8g03u5YpcWNHl17ba59AQOkXiPhG5TQSTEqWHhSFbb6NFsM2g4AvZaUH4TvrSn8Oh2nb9oWNekVJUymdqGfn0rDDysmA996qTO6dBsO3r3tT57asGb+bIH8Moojd12neTvf6iXy7U/nZF3BCXNtFla2eEzTig6QuQi5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526438; bh=ON0V1BXb/ENS2rbPIGA++64oU32aY5OD82iBFaBrCaS=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GzoQrTDpMCgvmk4xtdjQGvc8w4SGcI6NnwIX90o7l2jLLjbJ6Ut783Iac9LHQ7UeNt5cY0D+p0RNSYd5NjZ5OErx/GqZVCJ+yPKsVbQlQ5v4H64q7+Uww/WrXjbQqrZu6n25lNJBX6jFbhIS8fWHG4E4qyET0wEi2H7/mI9AnG7JnAeHxiJLlaK4h/qlVHF9IFppDShRVIEZhkC+3xpTR2xr/xeZ1dEZL840fhyn8AQYVzVPa6StXAhEApCEly1eiuJsX1tUSN3kVJtm36mp5Jbsh/m32M5V9cN1tVcUMaf59iOA5KRuasLB3JQH6CTofYw5B/8rSbyRl6X1vhr2BQ==
X-YMail-OSG: lfUS7TAVM1kNC1pxNzOMy2X8APsKRwz.s2XT006_eYmH72cU2V825tcqYazSNhd
 RpyFweFFszSyuL1lfyd.SntgckoLT2aq_56vPu6qSufbo0_WNnPMsaH_vDViRQu2ZPU.yJxhqm7l
 wa4q1fKdg4LyElw2J92TWFr7qmXOFcYAc0SotK1xobjcEPjVvbi5x7qwzXAC2B75NZuLfAvZengq
 1cKi_s0ZeW.wGT_MosqVg..nrQ7T3yoQUutlw.h1mHMyRJ.N5XbjPVOFTGrHGzQ3kVXq27SgB.Ua
 DtZq4RGbtyCpiuDeA4_yTV7SZACH2DvIvTRwEFt4HHz7Aqk56n_5yC2RTDwB1_ppfl2iwt5pG2Su
 bd5IOyIp33c5UBrXYJxGu.Sx1qb0IdHLGLvY.xQfPauRLp.xWvbhpkV4WNfLeiUpLDaYeKq3ZXcO
 jMAMtrgcAzSOjJzbHyLQkuUfhru0Baa5xgjPEoCPRgmBv6fJI5PMwMJRDg255jrwPijZve2Kw2hz
 qxOMnu5fJjLL8L3tMD1x75QK6pLo.AjtIsrHAloW4zmLoIcJ6QqsxrGt8EFu7KMDZCkYiRhnsFzc
 7ENwZmttZ2hZoaeIERuUkZCBsQGW7Vgy5c5appdnziK3lmquVRPlzrlDPI.GLNtzUTekGCcCo38w
 5aTfc985x7IfzA4FtNUEyQXsK91hGrWNsIyBWlcghpSen_ag9QeyRCga2PadkcqP1ulvbbpSBmed
 2p.wv_OL.4FatP.7jYssC7Lrr17qwCMI7pL28M.J73b0bOgx1C9HocoKf8D2YdDe3aX7AJBAuKTw
 VoWEW74C5zU_sp17xsXtFSiHILhXACIAtoNsDKyi4d1AEup5o2Ur1_nDnQ5_3SFHzYKfmZ3dlgIf
 OU1wx1.RFrG0fkM7O4pSrWvPiTzTFrqLMEYBmaDVDuDC7sX3vMCov.BBxv8VWoGcruiSK2.5ZZY5
 U3hVbiT8vY1i5pL3_mm6u6wRAjMbhAobKwsx9xaSWG50.Um7pJL.rsodcfhjehbGrNra7vhlau7W
 Hr0CKHEYFvKOlq6JMQ2P.gWlVOiCv35fm5O_NMYxmXw2.ZTs2Dt0suV4FforWQKIU77kT3y8OVS1
 WiKhuuc_wKW0V56Imq7NZF7ckr4epcPoC0i08XWwPA3tyGiOWDl8e3kf9h8xgVlza_7F_UQzL5Kg
 N.SAWPn582PF_iCABrlEX1FVafuKwb6zlAWcyuMqcx9acVtjLqlbnZXMRdRCd1JqUwrsxrfrMOwQ
 tCHVNnONfnW_UBx.Z7QImRRPOrrlR_fyITyQSNZDCGZUlQyOdPziK.ZbIDivsgEfUCmBDA4QlHuO
 y.StapM81wltpsUyNCqUjYOMh.hKYi3W6VDVJUtAvO_5a3_YB3r8RqNhg64V1_xUnsIzPlmcpp3X
 GDdgJDhnjt2ZtHge32jX1qmx2q3Oer8u8zc1364pwQo.P33HGyG3pig7KPkLYSGZw2BL7lpRhtE.
 wZjMtMxOfk_grtYXynx24gwtUai0niK_9P8g6zJWn181596uH3E91H8VkMIXFLs_ff5.FKE3pict
 vz0wOjvmGW.gkHSuUyLdsOlnbqFpRA.p1oRbpbsRn1ReTd5fi.8fNdTKNR5Fltox0cqCDBZe4Hj7
 j29VwgbRrGaW3..C.G38F4FK4YYtnhj7MfE4YUiy2Jii5VfI.zn5vMIlURb7pYix1a43lPbXjy0Y
 T2UexzFI.CGUMbO6m5UdEqW.BQrhFU0AnAczWaHpiw75nvHYDnygx4JrH3WWiHo78eqMi__tB2ZY
 DvkE7mLlfJ1nVIhMDJ1lphrG2qMW6F3i1IIy60yRg5PkbSt.c9JWPjiTT2KG6ECIblXZjB0p.Vfo
 kNwGRLYsIahL2UdF5kTuZyI_WauOV_PuygnSb.HL87QX0oltBDk_I7vgcIlwCRWVFc3ZWXa5oaB1
 qhIJ0Z3y1ptubVRAereIc.iyUmagd0t83HVdmc2epMvUOnGN9CP3eH1ojREGVPbpzKWPsd60ADYT
 jNpKF7Z05LESmDQ8odjGRPboP2afPHk2mBAj7a4tEJrctZ.NseXFHolmP3VUNn9I2OrYbq.T48Yq
 awF6TiEW0nlxlxxY25SkggLnf5dDXUD3grIVOzfv9Fqkd4eunZwTftzlcrL0eme0iMRpeqUuwlrN
 eLlu4iZszYXFY1ZxAth8jL6LXts7Ooc9qVfFa1aipkqKaOjbrce00avm8LOmFWVmGw4ITcyhX_5G
 PepDNs2IlKzEmc2.txH1i7fnbfN6_KoZTVY4gsg2.ROAdR4P_HxIKwVAPVgZbNInlLDOSIkKLWYy
 3aQsysx4C012smv0d4.fSLmNl1ts-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c11f7d66-2732-44d0-aae5-2bc4a8f9af6f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:20:38 +0000
Received: by hermes--production-gq1-74d64bb7d7-cmxx8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 311260ab82870132bd75579510690963;
          Sat, 21 Jun 2025 17:20:35 +0000 (UTC)
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
Subject: [RFC PATCH 05/15] LSM: Single calls in secid hooks
Date: Sat, 21 Jun 2025 10:18:40 -0700
Message-ID: <20250621171851.5869-6-casey@schaufler-ca.com>
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

security_socket_getpeersec_stream(), security_socket_getpeersec_dgram()
and security_secctx_to_secid() can only provide a single security context
or secid to their callers.  Open code these hooks to return the first
hook provided. Because only one "major" LSM is allowed there will only
be one hook in the list, with the excepton being BPF. BPF is not expected
to be using these interfaces.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index db85006d2fd5..2286285f8aea 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3806,8 +3806,13 @@ EXPORT_SYMBOL(security_lsmprop_to_secctx);
  */
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
+	struct lsm_static_call *scall;
+
 	*secid = 0;
-	return call_int_hook(secctx_to_secid, secdata, seclen, secid);
+	lsm_for_each_hook(scall, secctx_to_secid) {
+		return scall->hl->hook.secctx_to_secid(secdata, seclen, secid);
+	}
+	return LSM_RET_DEFAULT(secctx_to_secid);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
@@ -4268,8 +4273,13 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 				      sockptr_t optlen, unsigned int len)
 {
-	return call_int_hook(socket_getpeersec_stream, sock, optval, optlen,
-			     len);
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, socket_getpeersec_stream) {
+		return scall->hl->hook.socket_getpeersec_stream(sock, optval,
+								optlen, len);
+	}
+	return LSM_RET_DEFAULT(socket_getpeersec_stream);
 }
 
 /**
@@ -4289,7 +4299,13 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
 int security_socket_getpeersec_dgram(struct socket *sock,
 				     struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(socket_getpeersec_dgram, sock, skb, secid);
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, socket_getpeersec_dgram) {
+		return scall->hl->hook.socket_getpeersec_dgram(sock, skb,
+							       secid);
+	}
+	return LSM_RET_DEFAULT(socket_getpeersec_dgram);
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.47.0

