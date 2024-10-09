Received: from sonic306-26.consmr.mail.ne1.yahoo.com (sonic306-26.consmr.mail.ne1.yahoo.com [66.163.189.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38AA1A2630
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495446; cv=none; b=rzKAeVDJHi+I0RLNqaJJ35latrKgX7AWtVu77UtbXUMar16HyDJUDBIGIeEwjZQ23L2XK5UWtf1Sj4fW2vAA0I7ATmt6ZJXeTK+Ky9FZqpiWlrX9CH2flR2rMR7ShoHVqbLWBGVTf3BWrL1V2WMo6Q9LpNLKuPFAYWEMGQXSAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495446; c=relaxed/simple;
	bh=n8xyTzrmBZezDTvSLBbtjqQTqiD+k0fdNEINQvEQTH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6OPJGtJXhBuKgds9n+1UzCDeJfpPtrcLSKVbeIpYJn9PZu9Rlk1fJ4JDU0I+XtyeKMjSdsVEN1T4e2Pp29GrRCwA8iUxeZQxhMZneFDojffXAMMimUPM4DJs419LNrHslDPrZyjFBN4YJC5IW+QaG5pI2J2Mfca/u5l88seLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SmaNgUp/; arc=none smtp.client-ip=66.163.189.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SmaNgUp/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495444; bh=4VJXnDeZn7m1qqxsSxoGUKvK9NPmCZzpWqWUKtknIMY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=SmaNgUp/V9Kbtr4TSCHhqLYGcBLr8d95CAelGjIAjQysuwbZUQbLstNuFcZ+N2+celmV7PzfB87CiYoZaYBmPbODYE8THSaLiwwct3Rx+oRTgdtgoMzm4E+UzA4DfPnlVVVRoLa2BNMt58xPyte0GTWuwL+wMa64iD2V3+Paq5crPpzsE/NtABCC7WxjDlwnekSzPscKMxbO+2E53HLcuB5MWjJHE3q7vWeYClzqk3dW4NtPncokWg1IO0axnBOgMLwR2mtco1D8SuCoqLGahTYFPAM84IWCvM6d92rVleH7AJrwrx/kBNSEuNs9w2RLmjecTX1v5GQQxnXsAFChVA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495444; bh=PB4NVMNskdAgFsmPysH9qrfIuwMnccDyRzVIGG1vKXY=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fZBMYhzWJm5PuBhXs5nOuUJ1rOiP4xUEc0GTeDzt7+ic6bjO4boASpbmdUeVwB1gGwmqb/97h2j5WXKMA+pecSkTpBg6egakGP7rJpb89TcLUJXAPz+e9QjFxTMdwyY8HnP9BFN1mx79xeTypcOxUumYvyz467dYybP+w2aUt9HCdkoZ81oLK+LOaPxvtftJrHoeAYKUNEyK5zscHL8/Ck8gCLdfsu43Gfu8BJCysZJE6vW3Z41ByL2u9rZ4GNguW80Ht41B8wj+piKz4kyew46UBhIlSP7ndHUrI9CFfjhL8V9Hz56SldvTnxkUva2bPdLhaixZnXcjOtZEmgbvrQ==
X-YMail-OSG: KNDBrVcVM1lpSeiuhnjDXZIhcfJFJE3bu_5.x4WCmVQ6Dbgvx0G4VVjs2si0ZQW
 HvgRhUiLJFneLxXQvlaAjXr4MZPvdNjwLEQZdUUgMGUyCWs9uGWsrCTSU7pQ.L4.dzgiGYC7RADd
 aB9A.LmGquKHdlJsk_IoBuVKQOv5wdnXb.Q9sdllJdCycKFwV3LlHMsAxB0KDTK4QZS96buat8I.
 sa.G3ML9slNofXjhHZe2wbqI9JMF_Pj3UrTwbGgKlyBldjnBAYOpGs8XaGoSCSd76aRn7Micw4Sw
 0axaCxsZ3DXyKdI2zJoTO6MKSum7fX9fqUX.ha4KAhCgdaqavtxTlKI.gFnBiIwqBetwz8FY5mAf
 Sljld7Tzt4ZRbGEOXIzR9x97TGO4rw1AS78s02AjS.k0S6c3arNEcuvbbv25oUlO4ABrLz8m6WbL
 sDGNSRca7oen7y3U8p8CRsub.SCrYCNwkEUtFI9lmNRdx7xngy570EPQ08mO3sr5RQpn2shm3vqj
 jTiWZmGiS2RBcfJeEI8m2URVxT.4jLFTrFcj9E_hlvakxxKYRpn4Ag7fBvZHHCdG7HOqPABJwnyQ
 zGB2rhDKkqJl2tHPDPaFWC07zcSRboGXUMMaJXGIfVUYZkq.DYUMw0n97lXJkRWZozuf3EETc47V
 i4UUfvSRMPiXG5o1AkmlbzTg8rxCDBkhqSkrimWys43U5vomZxH80NZq3vztW02CUCHhAomKzn6l
 nBrGZVnuCzrDlyMsZhZlf24P1jugfG34gi.RSU68Tyg0xjBLY5R1NOekjqrND4WMxo1XMBUcs1Xf
 H_3DkjKzckyPVRTsccY1L3ax43JypPTmwf36cIt0f9x.NZ_SLV9YndWnSyOp5AVeXinW_bVdT2Qi
 V1KeXZssE3ayINGkLGeFpQnqVhjhdyDSP7p1XZFArIWdYw07MHbhQZHmq8NogXZ2I.ChjcPbyx1S
 puBLpK58BQnED7IM3Z1Y_e5q_AP9oXvM49s446CC4sfdhBKoQUwQSRLjSqjLa8ZEVp5Efsm_hX8C
 bUA08oj4ptPPeJQ.PQhmT2bfY5rwsBGvb891DhuY03h011sEBOVB3K_fCYWpusRm8jX.U7Y7zRHy
 kljmQfg8d4NP95nDk9H3bEBUHlEgC7kPrZpSvQ0EsR7e7q.mrnjR0oya516H_l9hLKmhPmpbXCWL
 Gn2SJCdgAiAGzIs_DI774ghSVtTZ0ih.d82stHhUVUJM3fEcsU9pJDCYHP.aiCEMtfJdMjaf9G8g
 cVRocXFkx7oerU9op4upyGpAP3Fz8VN683W3Ect4S40kPnDDcqMhgvNvqai.2w3bE7z97rzVldjv
 URYWWa1vBSry7Bf6AiZx5wn9bwuNdEs_p89cCsgYaS5Ss.UnLgrD1l8yqZlQcO8Gr7Bb3IIO1G51
 A.VOi_WybjLjY9NTGt5ayeTG6ENw_BoDU8DhhulJXa3sPmWTF4T8563fv9omi.3xKeHCpNh8SFsa
 W4vR.qKpNMc1icesC1c057K35mY8pND062Vk64rwG7IZgYky1VUPlBlIBl27hAbUrbQEl6Ssj0s8
 hWEBQKpwFTTzMMca.uf9CBL41Wg1gHPSzTC5tM5CIa_C8cqR9MQMjCWgPdMMVHdc3qQ.jHqmIovX
 DHJkGDfD.LzljtY.VYfFj1a8zYVgdcK.7y2svWDvFUg6TQ1RnKsyzLD6jPa6jRypv_.YpOjZ4NWX
 MKhv87svN8iZyz.ucud99ONDtIk.D4s8fuMYCS7IjicGvvXyPrALBLYIS.1Nwv1fyOVE4B3Jf1W6
 TgwhWN5KrtCaCBbcRo5A0Q4jkqqEBBJMXK8JtV1JziRuW4fnnVwLQnT0D6RNOpO0.dl61GzBUE1s
 oQz.00nKjKmfeVUDk3Xov8F8w.ToT8uyiSBEZlwQJVXuBi7.iHLJwJ6BSmi5PnnWJMeuGjOBFSs0
 xSW5s7zKc9feBE5g64jz.3RFgpNMS4pZ7N0y4CjDV07WRBLiODG.opvHcGW7gHlJVnq7QrZxkqos
 x2yfTwEDJwmuID4goLyuLi6Y0fQictAgQoJoe2uBprr9h6V_rXQ7X67wnjrHbdtsFaIVKRMzRBvC
 VI3AD.yJ49QvsSa4MI1Go80TXukBLA.5T0xJlR0J64pSjQNLPIy_uEqiJcO3GJFgKJIrEt9Lxvx_
 qzGOX6lCpL.CSJGsyCbzsKfeaNPjOjrWYu0g78QjjFyCsxTW2ajpe9flRHXiJZbBcmQQ.zmE2XXD
 SitzMrMlI.mGBzyfvWpiq04K8U7po3GZ46Mm_VBuYZX636ewNdc2z4S8J_mMf2OqnjYOpcExhwT9
 zr3cE5bTo8jgWFLVKM3SHVX71j9CJxK3XC_jic1kw5muA3Nw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0e80faf5-cfea-4eb1-bbe1-72173aad2bf9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:37:24 +0000
Received: by hermes--production-gq1-5d95dc458-xmcnd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 934db59ff91b58b27af467a3ec48d37e;
          Wed, 09 Oct 2024 17:37:23 +0000 (UTC)
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
Subject: [PATCH v4 12/13] Use lsm_prop for audit data
Date: Wed,  9 Oct 2024 10:32:20 -0700
Message-ID: <20241009173222.12219-13-casey@schaufler-ca.com>
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

Replace the secid in the netlbl_audit structure with an lsm_prop.
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
index 529160f76cac..8de8344ee93c 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -97,7 +97,7 @@ struct calipso_doi;
 
 /* NetLabel audit information */
 struct netlbl_audit {
-	u32 secid;
+	struct lsm_prop prop;
 	kuid_t loginuid;
 	unsigned int sessionid;
 };
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 5925f48a3ade..1bc2d0890a9f 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1534,14 +1534,11 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
-	struct lsm_prop prop;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_current_getlsmprop_subj(&prop);
-	/* scaffolding */
-	audit_info.secid = prop.scaffold.secid;
+	security_current_getlsmprop_subj(&audit_info.prop);
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 3ed4fea2a2de..81635a13987b 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -98,10 +98,9 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
-	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(audit_info->secid,
-				     &secctx,
-				     &secctx_len) == 0) {
+	if (lsmprop_is_set(&audit_info->prop) &&
+	    security_lsmprop_to_secctx(&audit_info->prop, &secctx,
+				       &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
 		security_release_secctx(secctx, secctx_len);
 	}
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 39f4f6df5f51..d4c434956212 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -32,11 +32,7 @@
  */
 static inline void netlbl_netlink_auditinfo(struct netlbl_audit *audit_info)
 {
-	struct lsm_prop prop;
-
-	security_current_getlsmprop_subj(&prop);
-	/* scaffolding */
-	audit_info->secid = prop.scaffold.secid;
+	security_current_getlsmprop_subj(&audit_info->prop);
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 5dd1e164f9b1..1401412fd794 100644
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
+	nap->prop.smack.skp = smk_of_current();
 }
 
 /*
-- 
2.46.0

